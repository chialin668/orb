today=`date -u +%m/%d/%Y`
todayExt=`date -u +%m_%d_%Y`

# killing the process
pid=`ps -ef | grep "tcpdump -q -tttt" | grep -v grep | cut -c10-15`
kill -9 $pid

baseDir=/root
# moving the dumpfile
#outfile=$baseDir/tcp.dump
outfile=$baseDir/abc
dumpfile=$outfile.$todayExt
mv $outfile $dumpfile

# starting a new process....
nohup /usr/sbin/tcpdump -q -tttt > $outfile &

# generating the repor
report=$baseDir/report_$todayExt

echo 								> $report
echo "			DNA Sciences, Inc. network monitoring report" >> $report
echo "				date: $today" 			>> $report
echo "				----------------" 		>> $report
echo " 				110 - www.dna.com" 		>> $report
echo " 				 62 - pix" 		>> $report
echo " 				 98 - smtp1" 			>> $report
echo " 				100 - smtp" 			>> $report
echo " 				101 - owa" 			>> $report
echo " 				 45 - vpn" 			>> $report
echo " 				 90 - oracle" 			>> $report
echo " 				 61 - mylinux" 			>> $report
echo " 		      63.172.191.42 - rtp" 			>> $report
echo 								>> $report 


ips="65.161.124.110 \
        65.161.124.62 \
        65.161.124.98 \
        65.161.124.100 \
        65.161.124.101 \
        65.161.124.45 \
        65.161.124.90 \
	65.161.124.61 \
        63.172.191.142 \
        "

for ip in $ips
do
echo ----------------------- 					>> $report
	echo $ip 						>> $report
echo ----------------------- 					>> $report
 $baseDir/tcpdump_parser.pl -s -i $ip $dumpfile 		>> $report
# $baseDir/tcpdump_parser.pl -i $ip $dumpfile 			>> $report
echo  								>> $report
echo  								>> $report
echo  								>> $report
done

cat $report

