#!/usr/bin/perl -w
#
# Parses the output of tcpdump -q -tttt
# and computes stats
#

use strict;
use Getopt::Std;
use Time::Local;

my $usage = "$0 [-i ip_address -s -p port1,port2,... -e host1,host2,... -d mm/dd/yyyy -t mm/dd/yyyy:mm/dd/yyyy] tcpdump_file\n";
my(%opts);

getopts('i:d:t:p:s', \%opts);
die($usage) if(@ARGV != 1);

my ($host);
my ($start_time, $end_time) = (0, timelocal(0, 0, 0, 31, 11, 2030));
my ($my_time);
my $key;

if(exists $opts{'i'}) {
    $host = $opts{'i'};
    die($usage) if($host eq '');
}

if(exists $opts{'t'}) {
    my($start_date, $end_date) = split(/:/, $opts{'t'});
    die($usage) if($start_date eq '' || $end_date eq '');
    my($day, $month, $year);
    ($month, $day, $year) = split(/\//, $start_date);

    # Beginnning of the start day
    $start_time = timelocal(0, 0, 0, $day, $month, $year);

    ($month, $day, $year) = split(/\//, $end_date);
    # End of end day
    $end_time = timelocal(59, 59, 23, $day, $month, $year);    
}

if (exists $opts{'d'}) {
    my($date) = $opts{'d'};
    die($usage) if($date eq '');
    my($day, $month, $year);
    ($month, $day, $year) = split(/\//, $date);
    $my_time = timelocal(0, 0, 0, $day, $month, $year);
}

#
# this is used for gnutella
#
my @portarr; 
if (exists $opts{'p'}) {
    my($ports) = $opts{'p'};
    die($usage) if($ports eq '');

     @portarr = split(/,/, $ports);
}


##################################################################################################

my %stats = ();

my $file = shift;
open(IF, $file) or die("Couldn't open file $file for reading:$!\n");
while(<IF>) {
	print STDERR "processed " . $. . " lines " . localtime() . "\n" if ($.%100000 ==  0);
# Parse lines of the form    
#03/06/2003 02:58:03.228782 sraolinux.dna.com.800 > 192.168.1.150.nfs: udp 120 (DF)
#03/06/2003 02:58:03.228975 192.168.1.150.nfs > sraolinux.dna.com.800: udp 112
#03/06/2003 02:58:06.875761 ft-codc03w.corp.dna.com.domain > sraolinux.dna.com.55648: udp 131
    next unless(m/^                           # Start of line
                (\d\d)\/(\d\d)\/(\d\d\d\d)    # MM DD YYYY
                \s                            # space (duh!)
                (\d\d):(\d\d):(\d\d)\.\d+     # HH:MM:SS.number
                \s                            # 
                (\S+)                         # Bunch of non-space characters
                \s                            # 
                >                             #
                \s                            #
                (\S+)                         # Bunch of non-space characters
                :                             #
                \s                            #
                (\S+)                         # Bunch of non-space characters
                /x);

    my($month, $day, $year, $hour, $min, $sec, $src, $dest, $protocol) =
        ($1, $2, $3, $4, $5, $6, $7, $8, $9);

    $protocol =~ s/\(.+$//;
    my($src_host, $src_port) = &parse_ip_and_port($src);
    my($dest_host, $dest_port) = &parse_ip_and_port($dest);
    
#    next if(defined $host && !($host eq $src_host || $host eq $dest_host));
    next if(defined $host && $host ne $dest_host);

    my $time = timelocal($sec, $min, $hour, $day, $month, $year);
    next unless($time >= $start_time && $time <= $end_time);

    my $dt = timelocal(0, 0, 0, $day, $month, $year);

    if(defined $my_time) {
          next unless(defined $my_time && ($dt eq $my_time));
     }

    # count 'em up
    if (exists $opts{'s'}) { 
    	$stats{"$dest_port\t$protocol"} ++;

    } elsif (exists $opts{'p'}) { 
	my $port;
        for $port (@portarr) {
		if ($src_port eq $port || $dest_port eq $port) { 
    			$stats{"$src_host\t$src_port\t$dest_host\t$dest_port\t$protocol"} ++;
		}
        }

    } else {
    	$stats{"$src_host\t$dest_port\t$protocol"} ++;
    }
}


sub byPortThanCount {
	my $porta = (split(/\t/, $a))[1];
	my $portb = (split(/\t/, $b))[1];

	$porta cmp $portb || $stats{$b} <=> $stats{$a};
}

	      
foreach $key (sort byPortThanCount (keys(%stats))) {
     my @arr = split(/\t/, $key);

     if (exists $opts{'s'}) {
        printf("%15s\t%5s\t%d\n", $arr[0], $arr[1], $stats{$key});

     } elsif (exists $opts{'p'}) {
        printf("%20s\t%5s\t%20s\t%5s\t%d\n", $arr[0], $arr[1], $arr[2], $arr[3], $stats{$key});

     } else {
	printf("%35s\t%15s\t%5s\t%d\n", $arr[0], $arr[1], $arr[2], $stats{$key});
     }
 } 
																                                             

sub parse_ip_and_port {
    my($src) = @_;

    my($host, $port);

    if($src =~ m/^(\d+\.\d+\.\d+\.\d+)\.(\S+)$/) {
        # of the form 10.10.30.50.5666 or 10.10.30.50.nfs 
        ($host, $port) = ($1, $2);
    }
    elsif($src =~ m/^(\d+\.\d+\.\d+\.\d+)$/) {
        # of the form 10.20.225.167
        $host = $1;
        $port = "";
    }
    elsif($src =~ m/^(\S+)\.(\d+)$/) {
        # of the form foobar.dna.com.13345 or gino.2345
        ($host, $port) = ($1, $2);
    }
    elsif ($src =~ m/^(\S+)\.([^\.]+)$/) {
        # of the form foobar.dna.com.nfs or foobar.nfs
        ($host, $port) = ($1, $2);
        # for the special case of foobar.dna.com or foobar.dna.org or foobar.baz.fr or bar.biz.tv etc.
        if($port =~ m/^(com|org|gov)$/ || $port =~ m/^[a-z][a-z]$/i) {
            $host .= ".$port";


            $port = "";
        }
    }
    else {
	$host = $src;
	$port = "";
    }

    # we only need foo.com or bar.org
    if($host =~ m/^\S+\.(\S+)\.(\S+[a-z])$/) {
	    $host = "$1.$2";
   }

    return ($host, $port);
}



    






