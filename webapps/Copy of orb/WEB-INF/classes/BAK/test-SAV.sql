#
# dummy sql???
#
DUMMY
{

}

#
# DBA Scripts (from Oracle Support)
#

SUMM_TS_SIZE
{
	select  substr(ts.TABLESPACE_NAME,1,32) "TS Name",
		substr(ts.INITIAL_EXTENT,1,10) "INI_Extent",
		substr(ts.NEXT_EXTENT,1,10) "Next Exts",
		substr(ts.MIN_EXTENTS,1,5) "MinEx",
		substr(ts.MAX_EXTENTS,1,5) "MaxEx",
		substr(ts.PCT_INCREASE,1,5) "%Incr",
		substr(ts.STATUS,1,8) "Status",
		substr(df.FILE_NAME,1,52) "DataFile Assigned"
	from sys.dba_tablespaces ts, sys.dba_data_files df
	where   ts.TABLESPACE_NAME = df.TABLESPACE_NAME(+) and
		ts.STATUS NOT LIKE 'INVALID'
	order by ts.tablespace_name, df.file_name
}

SUMM_TS_USEAGE
{
	select  substr(fs.FILE_ID,1,3) "ID#",
		fs.tablespace_name,
		df.bytes/1024/1024 "Total",
		df.blocks "SQL Blocks",
		df.bytes/512 "VMS Blocks",
		sum(fs.bytes)/1024/1024 "Free",
		(100*((sum(fs.bytes))/df.bytes)) "% Free",
		df.bytes-sum(fs.bytes) "Bytes Used",
		(100*((df.bytes-sum(fs.bytes))/df.bytes)) "% Used"
	from sys.dba_data_files df, sys.dba_free_space fs
	where df.file_id(+) = fs.file_id
	group by fs.FILE_ID, fs.tablespace_name, df.bytes, df.blocks
	order by fs.tablespace_name
}

SUMM_DBFILE
{
	select  substr(FILE_ID,1,3) "ID#",
		substr(FILE_NAME,1,52) "Filename",
		substr(TABLESPACE_NAME,1,25) "Tablespace",
		BYTES/1024/1024 "Size",
		BLOCKS "SQL Blks",
		BYTES/512 "VMS Blocks",
		STATUS
	from sys.dba_data_files
	order by TABLESPACE_NAME, FILE_NAME
}

SUMM_USER
{
	select  user_id,
		substr(username,1,15) UserName,
		substr(password,1,15) Password,
		substr(DEFAULT_TABLESPACE,1,15) "Default TBS",
		substr(TEMPORARY_TABLESPACE,1,15) "Temporary TBS",
		CREATED,
		substr(profile,1,10) Profile
	from sys.dba_users
	order by username
}

SUMM_TABLE
{
	select  substr(OWNER,1,15) "Owner",
		substr(TABLESPACE_NAME,1,32) "Tablespace Name",
		substr(TABLE_NAME,1,24) "Table Name",
		substr(PCT_FREE,1,3) "%F",
		substr(PCT_USED,1,3) "%U",
		substr(INI_TRANS,1,2) "IT",
		substr(MAX_TRANS,1,3) "MTr",
		substr(INITIAL_EXTENT,1,10) "INI_Extent",
		substr(NEXT_EXTENT,1,10) "Next Exts",
		substr(MIN_EXTENTS,1,5) "MinEx",
	substr(MAX_EXTENTS,1,5) "MaxEx",
		substr(PCT_INCREASE,1,5) "%Incr"
	from sys.dba_tables
	order by owner, tablespace_name, table_name
}

SUMM_INDEX
{
	select  distinct
		TABLE_NAME,
	     INDEX_NAME,
		STATUS,
		UNIQUENESS
	from sys.dba_indexes
	where TABLE_OWNER not in ('SYS', 'SYSTEM')
	and     TABLE_TYPE = 'TABLE'
	order by TABLE_NAME, index_name
}

SUMM_SYNONYM
{
	select  substr(owner,1,10) Owner,
		synonym_name,
		substr(TABLE_OWNER,1,15) Table_Owner,
		substr(TABLE_NAME,1,20) Table_Name,
		substr(DB_LINK,1,20) DB_Link
	from sys.dba_synonyms
	where OWNER not in ('SYS', 'SYSTEM')
	and TABLE_OWNER not in ('SYS', 'SYSTEM')
	order by owner, synonym_name, TABLE_NAME
}

SUMM_VIEW
{
	select distinct
		v.VIEW_NAME "View Name",
		c.TABLE_NAME,
		c.COLUMN_NAME,
		c.DATA_TYPE,
		c.DATA_LENGTH
	from SYS.DBA_VIEWS v, SYS.DBA_TAB_COLUMNS c
	where v.VIEW_NAME = c.TABLE_NAME
	and v.OWNER not in ('SYS', 'SYSTEM')
	order by v.view_name, c.column_name
}

SUMM_OTHER 
{
	select  substr(owner,1,10) Owner,
		substr(OBJECT_NAME,1,25) Object_Name,
		object_type, status, created
	from sys.dba_objects
	where object_type not in
	('INDEX', 'SYNONYM', 'TABLE', 'VIEW')
	AND OWNER not in ('SYS', 'SYSTEM')
	order by owner, object_type
}

#
#
#
OV_INIT_PARAM
{
	select name, value
	from v$parameter
	where name in ('db_block_buffers', 'db_block_size',
	'shared_pool_size', 'sort_area_size');
}

OV_HIT_RATIO
{
	select (1 - (sum(decode(name, 'physical reads',value,0)) / 
			(sum(decode(name, 'db block gets',value,0)) + 
			sum(decode(name, 'consistent gets',value,0))))) * 100 "Hit Ratio"
	from v$sysstat;
}

OV_ROW_CACHE
{
	select (1-(sum(getmisses)/sum(gets))) * 100 "Hit Ratio"
	from v$rowcache;
}

OV_LIB_CACHE
{
	select Sum(Pins) / (Sum(Pins) + Sum(Reloads)) * 100 "Hit Ratio"
	from v$librarycache;
}

OV_LIB_CACHE_DETAIL
{
	select namespace, pins, pinhits, pinhitratio*100 "Pinhit Ratio", 
		reloads, reloads/decode(pins, 0, 1, pins)*100 "Reload Ratio"
	from v$librarycache;
}


OV_SHARED_POOL_SIZE
{
	select to_number(v$parameter.value) "Shared Pool Size", 
		v$sgastat.bytes "Free Space (in Bytes)",
		(v$sgastat.bytes/to_number(v$parameter.value))*100 "% Free"
	from v$sgastat, v$parameter
	where v$sgastat.name = 'free memory'
		and v$sgastat.pool = 'shared pool'
	and v$parameter.name = 'shared_pool_size';
}

OV_SYS_SHM_DETAIL
{
	select  ksmchcls Status, sum(ksmchsiz) Bytes
	from x$ksmsp
	group by ksmchcls;
}


OV_SYS_SHM_DETAIL1
{
	select decode(state, 0, 'Free',
			1, decode(lrba_seq, 0, 'Available', 'Being used'),
			3, 'Being used', state) "Block Status", count(*)
	from x$bh
	group by decode(state, 0, 'Free',
			1, decode(lrba_seq, 0, 'Available', 'Being used'),
			3, 'Being used', state)
}

OV_SORT
{
	select a.value "Disk", 
		b.value "Memory",
		round(100*(b.value/decode((a.value+b.value),
			0,1,(a.value+b.value))),2) "% Mem"
	from v$sysstat a, v$sysstat b
	where a.name = 'sorts (disk)'
	and b.name = 'sorts (memory)';
}

Query-1.7 
{
	select state, count(*)
	from x$bh
	group by state;
}

OV_MEM_USEAGE
{
	select decode(state,0, 'FREE',
	1,decode(lrba_seq,0,'AVAILABLE','BEING USED'),
	3, 'BEING USED', state) "BLOCK STATUS",	count(*)
	from x$bh
	group by decode(state,0,'FREE',1,decode(lrba_seq,0,'AVAILABLE',
	'BEING USED'),3, 'BEING USED', state);
}

OV_DISK_IO
{
	select name, phyrds, phywrts, readtim, writetim
	from v$filestat a, v$dbfile b
	where a.file# = b.file#
	order by readtim desc
}

OV_SQL
{
	select sid "Sid", 
		username "Login", 
		disk_reads "Disk Reads", 
		executions "Execs", 
		disk_reads/executions "Read/Exec", 
		buffer_gets "Buff Gets", 
		sorts "Sorts", 
		sql_text "SQL"
	from v$sqlarea sa, v$session s
	where sa.address = s.sql_address
	and username is not null
	and (disk_reads > 200 or buffer_gets > 200)
	order by "Read/Exec" desc

}

OV_SQL_AREA
{
	select buffer_gets, sql_text
	from v$sqlarea
	where buffer_gets > 20000
	order by buffer_gets desc;
}


Query-1.12 
{
	select A.User_Name, B.Disk_Reads, B.Buffer_Gets,
	B.Rows_Processed, C.SQL_Text
	from V$Open_Cursor A, V$SQLArea B, V$SQLText C
	where A.User_Name = Upper('&&User')
	and A.Address = C.Address
	and A.Address = B.Address
	order by A.User_Name, A.Address, C.Piece;
}

#
# Oracle Press
#
IO_FILE
{
	select 'Archive - ' || value "Name"
	from v$parameter
	where name = 'log_archive_dest'
	union
	select 'Data File - ' || name "Name"
	from v$datafile
	union
	select 'Log - ' || member "Name"
	from v$logfile
}

IO_DISK
{
	select name, phyrds, phywrts, readtim, writetim
	from v$filestat a, v$dbfile b
	where a.file# = b.file#
	order by readtim desc
}

IO_LOG_FILE
{
	select a.member, b.*
	from v$logfile a, v$log b
	where a.group# = b.group#
}

IO_TABLE_INDEX
{
	select i.owner "Owner", 
		t.table_name "Table", 
		i.index_name "Index", 
		i.tablespace_name "TS Name"
	from dba_tables t, dba_indexes i
	where t.table_name = i.table_name
	and t.tablespace_name = i.tablespace_name
	and t.owner not in ('SYS', 'SYSTEM', 'RMAN')
	order by i.owner
}

IO_TABLE_SCAN
{
	select name "Name", 
		value "Value"
	from v$sysstat
	where  name like '%table %'
	order by name
}


IO_BLOCKS_LONG_TABLE_SCAN
{
	select (sum(decode(name, 'table scan blocks gotten', value, 0)) 
		- sum(decode(name, 'table scans (short tables)', value*5, 0)))
		/ sum(decode(name, 'table scans (long tables)', value, 1)) "Blks/Long Table Scan"
	from v$sysstat
	where  name like '%table %'
}

IO_LONG_TABLE_SCAN_USER
{
	 select ss.username||'('||se.sid||') ' "User Process",
	 sum(decode(name,'table scans (short tables)',value)) "Short Scans",
	 sum(decode(name,'table scans (long tables)', value)) "Long Scans", 
	 sum(decode(name,'table scan blocks gotten',value)) "Blocks Retreived",
	 sum(decode(name,'table scan rows gotten',value)) "Rows Retreived"
	   from v$session ss, v$sesstat se, v$statname sn
	  where  se.statistic# = sn.statistic#
	     and (name  = 'table scans (short tables)'
		 OR name  = 'table scans (long tables)' 
		 OR name  = 'table scan rows gotten'
		 OR name  = 'table scan blocks gotten')
	     and  se.sid = ss.sid
	     and   ss.username is not null
	group by ss.username||'('||se.sid||') ';
}


IO_PARTITION_INFO
{
	select segment_name, partition_name, segment_type, tablespace_name
	from user_segments
	where partition_name is not null
}

IO_FRAGMENTATION
{
	select owner "Owner", 
		segment_name "Name", 
		segment_type "Type", 
		extents "Ext Counts", 
		bytes/1024/1024 "Size"
	from dba_segments
	where extents > 5
	and owner not in ('SYS', 'SYSTEM')
	order by extents desc
}

IO_ROLLBACK
{
	select a.name, b.extents, b.rssize, b.xacts, b.waits, b.gets,
	optsize, status
	from v$rollname a, v$rollstat b
	where a.usn = b.usn
}

IO_CONTROL_FILE
{
	select name, value
	from v$parameter
	where name = 'control_files'
}


IO_TEMPORARY_TS
{
	select username "Username", 
		temporary_tablespace "Temp TS"
	from dba_users
	order by temporary_tablespace, username
}

#
# O'Reilly
#

MEM_SGA
{
	select *
	from v$sgastat
}

MEM_LIBRARY
{
	select namespace, sum(gets) "Gets", 
			sum(gethits) "Get Hits", 
			avg(gethitratio)*100 "Ratio",
			sum(pins) "Pins", 
			sum(pinhits)"Pin Hits", 
			avg(pinhitratio)*100 "Ratio"
	from v$librarycache
	group by namespace
}

MEM_RELOAD
{
	select namespace "Name Space", 
		reloads "Reloads"
	from v$librarycache
}

MEM_SQL
{
	select substr(sql_text, 1, 30) SQL, count(*)
	from v$sqlarea
	group by substr(sql_text, 1, 30)
	having count(*) > 20
}

MEM_OBJ_SIZE
{
	select owner, name || ' - '|| type "Name",
	sharable_mem
	from v$db_object_cache
	where sharable_mem > 1000
	and type in ('PACKAGE', 'PACKAGE BODY', 'FUNCTION', 'PROCEDURE')
	order by sharable_mem
}

MEM_OBJ_LOAD
{
	select owner, name || ' - '|| type "Name", loads,
	sharable_mem "Sharable Mem"
	from v$db_object_cache
	where loads > 2
	and type in ('PACKAGE', 'PACKAGE BODY', 'FUNCTION', 'PROCEDURE')
	order by loads
}

MEM_OBJ_EXEC
{
	select owner, name || ' - '|| type "Name", executions
		from v$db_object_cache
		where executions > 2
		and type in ('PACKAGE', 'PACKAGE BODY', 'FUNCTION', 'PROCEDURE')
	order by executions
}


MEM_USR_CSR
{
	select 
	ss.username||'('||se.sid||') ' user_process, 
		sum(decode(name,'recursive calls',value)) "Recursive Calls", 
		sum(decode(name,'opened cursors cumulative',value)) "Opened Cursors", 
		sum(decode(name,'opened cursors current',value)) "Current Cursors"
	from v$session ss, v$sesstat se, v$statname sn
	where  se.statistic# = sn.statistic#
			and (     name  like '%opened cursors current%'
					OR name  like '%recursive calls%'
					OR name  like '%opened cursors cumulative%')
			and  se.sid = ss.sid
			and	ss.username is not null
	group by ss.username||'('||se.sid||') ';
}

MEM_DICT
{
	select count, getmisses
	from v$rowcache
	where getmisses > count
}

MEM_SESSION
{
	SELECT SUM(VALUE) "Total Bytes"
	FROM V$SESSTAT, V$STATNAME
	WHERE NAME = 'session uga memory'
	AND V$SESSTAT.STATISTIC# = V$STATNAME.STATISTIC#;

}

MEM_SESSION_MAX
{
	SELECT SUM(VALUE) "Total Max Bytes"
	FROM V$SESSTAT, V$STATNAME
	WHERE NAME = 'session uga memory max'
	AND V$SESSTAT.STATISTIC# = V$STATNAME.STATISTIC#;
}

MEM_BUFF_HIT_RATIO
{
	select 
	sum(decode(name, 'consistent gets',value, 0))  "Consis Gets", 
	sum(decode(name, 'db block gets',value, 0))  "DB Blk Gets", 
	sum(decode(name, 'physical reads',value, 0))  "Phys Reads",
	(sum(decode(name, 'consistent gets',value, 0))  + 
	sum(decode(name, 'db block gets',value, 0))  -
	sum(decode(name, 'physical reads',value, 0)))
							/
	(sum(decode(name, 'consistent gets',value, 0))  + 
	    sum(decode(name, 'db block gets',value, 0))  )  * 100 "Hit Ratio" 
	from v$sysstat;
}


MEM_BUFFER_GET
{
	select sum(value) "Buffer request count"
	from v$sysstat
	where name in ('db block gets', 'consistent gets')
}

IO_TAB_ACCCESS
{
	select name, value 
		from v$sysstat
	where  name like '%table %'
	order by name
}

IO_FULL_TAB_SCAN
{
	select ss.username||'('||se.sid||') ' "User Process",
		sum(decode(name,'table scans (short tables)',value)) "Short Scans",
		sum(decode(name,'table scans (long tables)', value)) "Long Scans", 
		sum(decode(name,'table scan rows gotten',value)) "Rows Retreived"
	from v$session ss, v$sesstat se, v$statname sn
	where  se.statistic# = sn.statistic#
		and (name  like '%table scans (short tables)%'
		 OR name  like '%table scans (long tables)%' 
		 OR name  like '%table scan rows gotten%'     )
		and  se.sid = ss.sid
		and   ss.username is not null
	group by ss.username||'('||se.sid||') '
}

IO_RECURSIVE_CALL
{
	SELECT NAME, VALUE 
	  FROM V$SYSSTAT
	 WHERE NAME = 'recursive calls'
}

IO_DYNAMIC_EXTENSION
{
	select segment_name || 
	       decode(segment_type,'TABLE','[T]', 'INDEX', '[I]', 
			    'ROLLBACK','[R]', '[O]') "Obj Name",
	       count(*) "Ext Count",
	       sum(bytes)/1024/1024 "Size",
	       owner "Owner", 
	       tablespace_name "TS Name"
	  from dba_extents
	 group by owner, tablespace_name, segment_name|| 
		 decode(segment_type,'TABLE','[T]', 'INDEX', '[I]', 
			'ROLLBACK','[R]', '[O]')
	having count(*) > 5
	order by count(*) desc 
}

IO_TS_INFO
{
	select tablespace_name,
		initial_extent, 
	       	next_extent, 
	       	pct_increase
	  from dba_tablespaces
	 order by tablespace_name
}

#
# Oracle Tables
#
STORAGE_TABLESPACES
{
	select *
	from dba_tablespaces
}

STORAGE_DATA_FILES
{
	select *
	from dba_data_files
}

STORAGE_EXTENTS
{
	select * 
	from dba_extents
	where owner not in ('SYS', 'SYSTEM')
}

STORAGE_ROLLBACK_SEGS
{
	select *
	from dba_rollback_segs
}

STORAGE_FREE_SPACE
{
	select *
	from dba_free_space
}

STORAGE_SEGMENTS
{
	select *
	from dba_segments
	where owner not in ('SYS', 'SYSTEM')
}

##################################################################################
DB_INFO
{
	select dbid "Id", 
		name "Name", 
		created "Created",
		log_mode "Log Mode",
		open_mode "Open Mode",
		controlfile_type "CFile type",
		controlfile_sequence# "CFile Seq #"		
	from v$database
}

DB_VERSION
{
	select banner "Server Information" 
	from v$version
}

DB_OPTION
{
	select parameter "Name",
		value "Value"
	from v$option
	order by parameter
}

DB_CONTROLFILE
{
	select name "Name",
		status "Status"
	from v$controlfile
}

DB_INIT_PARAM
{
	select name "Name", value "Value"
	from v$parameter
	where value is not null
	order by name
}

DB_INIT_PARAM_SORT
{
	select name "Name", 
		value "Value"
	from v$parameter
	where name in ('compatible',
		'nls_sort',
		'sort_area_size',
		'sort_area_retained_size',
		'sort_multiblock_read_count')
}

DB_INIT_NON_DEFAULT_PARAM
{
	select name "Name", 
		value "Value"
	from v$parameter
	where value is not null
	and isdefault = 'FALSE'
}


DB_INIT_PARAM_ISSES
{
	select name "Name", 
		value "Value"
	from v$parameter
	where isses_modifiable <> 'FALSE'
	and value is not null
	
}

DB_INIT_PARAM_ISSYS
{
	select name "Name", 
		issys_modifiable "Flag", 
		value "Value"
	from v$parameter
	where issys_modifiable <> 'FALSE'
	and value is not null
	order by name
}

DB_INIT_PARAM_DESC
{
	select nam.ksppinm "Name", 
		nam.ksppdesc "Description"
	from x$ksppi nam, x$ksppsv val
	where nam.indx = val.indx
}

DB_BACKGROUND 
{
	select event, 
		sum(total_waits) "Total waits", 
		sum(time_waited) "Time waited"
	from v$session s, v$session_event e
	where type = 'BACKGROUND' and s.sid = e.sid
	group by event
}

DB_STAT_NAME
{
	select class, statistic#, name
	from v$statname
	order by class, statistic#
}

DB_SGA
{
	select name "Name",
		value "Value"
	from v$sga
}


DBA_PARAMETER
{
	select name "Name", value "Value"
	from v$parameter
	where name = '&name'
}


DB_INIT_PARAM_UNDOC
{
	select ksppinm "Name", ksppity "Value"
	from x$ksppi
	where substr(ksppinm, 1, 1) = '_'
}

DBA_DB_FILE_FREE_SPACE
{
	SELECT	fs.tablespace_name "TS Name",
		file_name "File Name",
		df.bytes/1024/1024 "File Size",
		COUNT(*) "Pieces Free",
		MAX(fs.bytes)/1024/1024 "Max",
		MIN(fs.bytes)/1024/1024 "Min",
		SUM(fs.bytes)/1024/1024 "Total",
		autoextensible "AutoExt",
		SUM(fs.bytes)/df.bytes*100 "% Free"
	FROM dba_free_space fs, dba_data_files df
	where fs.file_id = df.file_id
	GROUP BY fs.tablespace_name, file_name, df.bytes, autoextensible
	order by SUM(fs.bytes)/df.bytes*100
}

DBA_DB_FILE_FREE_SPACE_PARAM
{
	SELECT file_name "File Name",
		df.bytes/1024/1024 "File Size",
		SUM(fs.bytes)/df.bytes*100 "Pct Free",
		COUNT(*) "Pieces",
		MAX(fs.bytes)/1024/1024 "Max",
		MIN(fs.bytes)/1024/1024 "Min",
		SUM(fs.bytes)/1024/1024 "Total",
		autoextensible "AutoExt",
		fs.tablespace_name "Tablespace"
	FROM dba_free_space fs, dba_data_files df
	where fs.file_id = df.file_id
	and fs.tablespace_name = '&tsName'
	GROUP BY fs.tablespace_name, file_name, df.bytes, autoextensible
	order by SUM(fs.bytes)/df.bytes*100
}


DBA_TS_FREE_SPACE
{
	select tablespace_name "TS Name",
		sum(bytes)/1024/1024 "Size"
	from dba_free_space
	group by tablespace_name
}


DBA_TS_INFO
{
	select t.tablespace_name "TS Name", 
		sum(bytes)/1024/1024 "Size",
		t.status "Status",
		t.logging "Logging"
	from dba_tablespaces t, dba_data_files df
	where t.tablespace_name = df.tablespace_name
	group by t.tablespace_name, t.status, t.logging
}


DBA_TS_PARAMS
{
	select tablespace_name "TS Name",
	initial_extent "Initial",
	next_extent "Next",
	min_extents "Min",
	max_extents "Max",
	pct_increase "Pct"
	FROM dba_tablespaces
	order by tablespace_name
}

DBA_FILE_INFO
{
	select file_name "Name", 
		tablespace_name "TS", 
		bytes/1024/1024 "Size ",
		maxbytes/1024/1024 "Max",
		autoextensible "AutoExt", 
		status
	from dba_data_files
	order by bytes desc, tablespace_name
}

DBA_FILE_STATUS
{
	SELECT file#,
	name,
	status,
	checkpoint_change# "CHECKPOINT"
	FROM v$datafile
	order by file#
}


DBA_EXTENTS
{
	select e.tablespace_name "TS Name",
		df.file_name "File Name", 
		count(e.bytes) "Ext Count",
		df.bytes/1024/1024 "File Size ", 
		sum(e.bytes)/1024/1024 "Used Size",
		sum(e.bytes)/df.bytes*100 "% Used",
		autoextensible "AutoExt"
	from dba_extents e, dba_data_files df
	where e.file_id = df.file_id
	group by e.tablespace_name, df.file_name, df.bytes, autoextensible
	order by sum(e.bytes)/df.bytes desc 
}

DBA_ROLLBACK_INFO
{
	SELECT name, tablespace_name, rs.status, xacts "Active Trans"
	FROM v$rollname rn, v$rollstat rs, dba_rollback_segs rbs
	WHERE rn.usn = rs.usn
	and rn.name = rbs.segment_name
}

# roback segment stats
# USN Rollback segment number. If this view is joined with the V$ROLLNAME view, the rollback segment name can be determined.
# WRITES The number of bytes of entries written to the rollback segment.
# XACTS The number of active transactions.
# GETS The number of rollback segment header requests.
# WAITS The number of rollback segment header requests that resulted in waits.
# OPTSIZE The value of the optimal parameter for the rollback segment.
# HWMSIZE The highest value (high water mark), in bytes, of the rollback segment size reached during usage.
# SHRINKS The number of shrinks that the rollback segment has had to perform in order to stay at the optimal size.
# WRAPS The number of times a rollback segment entry has wrapped from one extent to another.
# EXTENDS The number of times that the rollback segment had to acquire a new extent.
# AVESHRINK The average number of bytes freed during a shrink.
# AVEACTIVE The average number of bytes in active extents in the rollback segment, measured over time.
DBA_ROLLBACK_STAT
{
	select rn.name, writes, xacts, gets, optsize, hwmsize, 
	shrinks, wraps, extents, aveshrink, aveactive
 	from v$rollstat rs, v$rollname rn
	where rs.usn = rn.usn
}


DBA_OBJ_SUMMARY
{
	select owner, object_type "Type", count(object_name) "Counts"
	from dba_objects
	group by owner, object_type
}

DBA_OBJ_SIZE
{
	select segment_name || 
		decode(segment_type,'TABLE','[T]', 
				'INDEX', '[I]', 
		    		'ROLLBACK','[R]', 
		    		'[O]') "Obj Name",
		    owner "Owner", 
		    tablespace_name "TS Name",
		    sum(bytes)/1024/1024 "Size "
	from dba_segments
	group by segment_name || decode(segment_type,'TABLE','[T]', 'INDEX', '[I]', 
			    'ROLLBACK','[R]', '[O]'), owner, tablespace_name 
	having sum(bytes)/1024/1024 > 5
	order by sum(bytes) desc
}

DBA_OBJ_SIZE_SUMM
{
	select type "Type",
		count(name) "Counts",
	      sum(source_size)/1024 "Source (KB)",
	      sum(parsed_size)/1024 "Parsed (KB)",
	      sum(code_size)/1024 "Code (KB)",
	      sum(error_size)/1024 "Error (KB)",
	      (sum(source_size) +sum(parsed_size) +sum(code_size) +sum(error_size))/1024 "Size Required (KB)"
	from dba_object_size 
	group by type 
	order by 2 desc
}

DBA_INVALID_OBJ
{
	select owner, object_type, object_name "NAME", status
	from all_objects
	where status = 'INVALIE'
	order by owner, object_type, object_name
}

DBA_CACHED_TABLE
{
	select owner, table_name, cache
	from dba_tables
	where cache not like '%N%'
}

DBA_SESSION
{
	select sid "Sid", 
		serial# "Serial #", 
		username "Username",
		decode(command, 
			1, 'CREATE TABLE',
			2, 'INSERT',
			3, 'SELECT',
			4, 'CREATE CLUSTER',
			5, 'ALTER CLUSTER',
			6, 'UPDATE',
			7, 'DELETE',
			8, 'DROP CLUSTER',
			9, 'CREATE INDEX',
			10, 'DROP INDEX',
			11, 'ALTER INDEX',
			12, 'DROP TABLE',
			13, 'CREATE SEQUENCE',
			14, 'ALTER SEQUENCE',
			15, 'ALTER TABLE',
			16, 'DROP SEQUENCE',
			17, 'GRANT',
			18, 'REVOKE',
			19, 'CREATE SYNONYM',
			20, 'DROP SYNONYM',
			21, 'CREATE VIEW',
			22, 'DROP VIEW',
			23, 'VALIDATE INDEX',
			24, 'CREATE PROCEDURE',
			25, 'ALTER PROCEDURE',
			26, 'LOCK TABLE',
			27, 'NO OPERATION',
			28, 'RENAME',
			29, 'COMMENT',
			30, 'AUDIT',
			31, 'NOAUDIT',
			32, 'CREATE DATABASE LINK',
			33, 'DROP DATABASE LINK',
			34, 'CREATE DATABASE',
			35, 'ALTER DATABASE',
			36, 'CREATE ROLLBACK SEGMENT',
			37, 'ALTER ROLLBACK SEGMENT',
			38, 'DROP ROLLBACK SEGMENT',
			39, 'CREATE TABLESPACE',
			40, 'ALTER TABLESPACE',
			41, 'DROP TABLESPACE',
			42, 'ALTER SESSION',
			43, 'ALTER USE',
			44, 'COMMIT',
			45, 'ROLLBACK',
			46, 'SAVEPOINT',
			47, 'PL/SQL EXECUTE',
			48, 'SET TRANSACTION',
			49, 'ALTER SYSTEM SWITCH LOG',
			50, 'EXPLAIN',
			51, 'CREATE USER',
			25, 'CREATE ROLE',
			53, 'DROP USER',
			54, 'DROP ROLE',
			55, 'SET ROLE',
			56, 'CREATE SCHEMA',
			57, 'CREATE CONTROL FILE',
			58, 'ALTER TRACING',
			59, 'CREATE TRIGGER',
			60, 'ALTER TRIGGER',
			61, 'DROP TRIGGER',
			62, 'ANALYZE TABLE',
			63, 'ANALYZE INDEX',
			64, 'ANALYZE CLUSTER',
			65, 'CREATE PROFILE',
			66, 'DROP PROFILE',
			67, 'ALTER PROFILE',
			68, 'DROP PROCEDURE',
			69, 'DROP PROCEDURE',
			70, 'ALTER RESOURCE COST',
			71, 'CREATE SNAPSHOT LOG',
			72, 'ALTER SNAPSHOT LOG',
			73, 'DROP SNAPSHOT LOG',
			74, 'CREATE SNAPSHOT',
			75, 'ALTER SNAPSHOT',
			76, 'DROP SNAPSHOT',
			79, 'ALTER ROLE',
			85, 'TRUNCATE TABLE',
			86, 'TRUNCATE COUSTER',
			88, 'ALTER VIEW',
			91, 'CREATE FUNCTION',
			92, 'ALTER FUNCTION',
			93, 'DROP FUNCTION',
			94, 'CREATE PACKAGE',
			95, 'ALTER PACKAGE',
			96, 'DROP PACKAGE',
			97, 'CREATE PACKAGE BODY',
			98, 'ALTER PACKAGE BODY',
			99, 'DROP PACKAGE BODY',		
			command
			) "Command",
		osuser "OS login",
		machine "Machine", 
		program "Program", 
		process "FG pid",
		logon_time "Logon Time", 
		status "Status"
	from v$session
	--where username is not null
}


LOG_FILE
{
	select l.group# "Group", 
		thread# "Thread", 
		member "File Name", 
		bytes/1024/1024 "Size ", 
		sequence# "Sqeuence",
		archived "Archive", 
		l.status "Status"
	from v$logfile lf, v$log l
	where lf.group# = l.group#
}


LOG_HISTORY
{
	select recid "Rec Id", 
		stamp "Stamp",
		thread# "Thread",
		sequence# "Sequence",
		first_change# "Low SCN",
		first_time "Low SCN Time",
		next_change# "High SCN"
	from v$log_history
	where recid > (select max(recid)-100
		from v$log_history)
	order by recid desc
}


LOG_BUFFER_ALLOCCATION
{
	SELECT NAME, VALUE
	FROM V$SYSSTAT
	WHERE NAME = 'redo buffer allocation retries'
}

LOG_ARCHIVE
{
	select name "Name",
		value "Value"
	from v$parameter
	where name like '%archive%'
}

USER_SQL
{
	select s.username "Username", 
		t.sql_text "SQL"
	from v$session s, v$open_cursor oc, v$sqltext t
	where s.sid = oc.sid
	and t.hash_value = oc.hash_value 
	and t.address=oc.address
	and s.username not in ('SYS', 'SYSTEM', 'DBSNMP', 'OUTLN', 'RMAN', 'PUBLIC')	
	order by oc.sid, t.address, t.hash_value, t.piece
}


USER_SESSION 
{
	select sess.username "Username", 
		s.sid "Sid", 
		sn.name "Name", 
		s.value "Value"
	from v$sesstat s, v$statname sn, v$session sess
	where sess.username not in ('SYS', 'SYSTEM', 'DBSNMP', 'OUTLN', 'RMAN', 'PUBLIC')	
	and sess.username is not null
	and s.sid=sess.sid
	and s.statistic# = sn.statistic#
	and s.value != 0
	order by s.sid, sn.name
}

USER_LOCK
{
   SELECT 
   	m.sid "Sid", 
   	sn.username "Username", 
   	m.type "Type",
   DECODE(m.lmode, 0, 'None'
                 , 1, 'Null'
                 , 2, 'Row Share'
                 , 3, 'Row Excl.'
                 , 4, 'Share'
                 , 5, 'S/Row Excl.'
                 , 6, 'Exclusive'
                 , lmode, ltrim(to_char(lmode,'990'))) "Mode",
   DECODE(m.request, 0, 'None'
                 , 1, 'Null'
                 , 2, 'Row Share'
                 , 3, 'Row Excl.'
                 , 4, 'Share'
                 , 5, 'S/Row Excl.'
                 , 6, 'Exclusive'
                 , request, ltrim(to_char(request,'990'))) "Request",
         m.id1 "Id1",
         m.id2 "Id2"
   FROM v$session sn, V$lock m
   where sn.sid = m.sid 
   and username is not null;
}


USER_LOCK_DETAIL
{
   SELECT 
   	m.sid "Sid", 
   	sn.username "Username", 
         obj1.object_name "Obj Name", 
         obj2.object_name "Obj Name",
   	m.type "Type",
   DECODE(m.lmode, 0, 'None'
                 , 1, 'Null'
                 , 2, 'Row Share'
                 , 3, 'Row Excl.'
                 , 4, 'Share'
                 , 5, 'S/Row Excl.'
                 , 6, 'Exclusive'
                 , lmode, ltrim(to_char(lmode,'990'))) "Mode",
   DECODE(m.request, 0, 'None'
                 , 1, 'Null'
                 , 2, 'Row Share'
                 , 3, 'Row Excl.'
                 , 4, 'Share'
                 , 5, 'S/Row Excl.'
                 , 6, 'Exclusive'
                 , request, ltrim(to_char(request,'990'))) "Request"
   FROM v$session sn, V$lock m, dba_objects obj1, dba_objects obj2
   WHERE sn.sid = m.sid
   AND m.id1 = obj1.object_id (+)
   AND m.id2 = obj2.object_id (+)
     AND lmode != 4 
   ORDER BY id1,id2, m.request
}


USER_IN_ROLLBACK
{
   select 
       s.username "Username",
       rn.name "RS Name",
       r.rssize "RS Size",
       r.waits "Waits",
       r.extents "Extents", 
       r.shrinks "Shrinsks",
	 r.optsize "Opt Size",
       decode (s.command,1,'CREATE TABLE',
                         2,'INSERT',
                         3,'SELECT',
                         6,'UPDATE',
                         7,'DELETE',
                         9,'CREATE INDEX',
                        10,'DROP INDEX',
                        12,'DROP INDEX',
                        26,'LOCK TABLE',
                        44,'COMMIT',
                        45,'ROLLBACK',
                        46,'SAVEPOINT', 
                        48,'SET TRANSACTION', 
                        NULL, NULL,
                        'look it up: '||to_char(s.command)) "Command"
	from v$session s, v$transaction t, v$rollstat r, v$rollname rn
	where s.taddr (+) = t.addr 
	and t.xidusn (+) = r.usn 
	and rn.usn = r.usn 
	and username is not null
	order by rn.name
}

USER_ROLLBACK_LOCK
{
	SELECT  rn.name "RS Name", 
		username "Username",
		p.pid "Oracle Pid",
		p.spid "OS Pid", 
	 	p.terminal "Terminal"
	FROM v$lock l, v$process p, v$rollname rn
	WHERE    l.sid = p.pid(+)
	AND      TRUNC (l.id1(+)/65536) = rn.usn
	AND      l.type(+) = 'TX'
--	AND      l.lmode(+) = 6
	ORDER BY rn.name
}

USER_OPEN_CURSOR
{
	select user_name "Name", 
		sql_text "SQL"
	from v$open_cursor 
	where user_name not in ('SYS', 'SYSTEM', 'DBSNMP', 'OUTLN', 'RMAN', 'PUBLIC')	
}

USER_SESS_CURSOR_CACHE
{
	select maximum "Maximun",
		count "Count",
		opened_once "Once",
		open "Open",
		opens "Opens",
		hits "Hit",
		hit_ratio "Hit Ratio"
	from v$session_cursor_cache
}

SYSTEM_CURSOR_CACHE
{
	select opens "Open",
		hits "Hits",
		hit_ratio "Hit Ratio"
	from v$system_cursor_cache
}


##############################################################################

DB_BG_PROCESS
{
	select name "Name", 
		description "Description", 
		error "Error"
	from v$bgprocess
}


STAT_LOGONS
{
	select value
	from  v$statname n , 
		v$sysstat b
	where n.statistic# = b.statistic# 
	and n.name='logons current'	
}

STAT_SESSION_USER
{
	select  s.username "Username", 
		s.sid "Sid", 
		s.serial# "Serial #", 
		s.status "Status", 
		s.machine "Machine", 
		s.osuser "OS User", 
		s.process "FG pid",
		p.spid "BG pid",
		s.program "Program", 
		s.logon_time "Logon Time"
	from v$session s, v$process p
	where s.username is not null
	and s.paddr  = p.addr
}

STAT_STAT
{
	select  n.name, value
	from v$statname n ,  v$sysstat s
	where n.statistic# = s.statistic#
	and value <> 0
}

STAT_DF_SIZE
{
	select file_name, sum(bytes)/1024/1024
	from dba_data_files
	group by file_name
}

STAT_DF_FREE
{
	select file_name, sum(f.bytes)/1024/1024
	from dba_data_files d, dba_free_space f
	where d.file_id = f.file_id
	group by file_name
}

STAT_LATCH
{
	select 	n.name "Name", 
		gets "Gets", 
		misses "Misses", 
		round(decode(gets-misses, 0, 1, gets-misses)/decode(gets, 0, 1, gets), 2) "Ratio",
		sleeps "Sleeps", 
		immediate_gets "Imm gets", 
		immediate_misses "Imm misses",
		round(decode(immediate_gets-immediate_misses, 0, 1, 
			immediate_gets-immediate_misses)/
			decode(immediate_gets, 0, 1, immediate_gets), 2) "IRatio"
	from v$latchname n ,  v$latch l
	where n.latch# = l.latch#
	and (gets <> 0 or immediate_gets <> 0)
}

STAT_EVENT
{
	select * from v$system_event
}

STAT_WAIT
{
	select * from v$waitstat
}

STAT_ROLL
{
	select usn,
        gets, 
	waits, 
	writes,
	rssize,
        xacts,
	shrinks,
        wraps
	from v$rollstat
}

STAT_FILE
{
	select df.file_name "File Name", 
		phyrds "Reads", 
		readtim "R Time", 
		phywrts "Writes", 
		writetim "W Time"
	from v$filestat fs, dba_data_files df
	where fs.file# = df.file_id
	order by phywrts desc, phyrds desc
	
	
}

STAT_ROWCACHE
{
	select parameter name,
       	gets,
       	getmisses "gmiss",
       	decode(getmisses, 0, 0, getmisses)/decode(gets, 0, 1, gets)*100 "g miss ratio",
       	scans scan,
       	scanmisses "smiss",
       	decode(scanmisses, 0, 0, scanmisses)/decode(scans, 0, 1, scans)*100 "s miss ratio"
       	--modifications mod_reqs,
       	--count count,
       	--usage cur_usage
  	from v$rowcache
}

STAT_LIB
{
	select namespace,
       		gets,
       		gethits,
       		(gethits/gets)*100 "GH Ratio",
       		pins,
       		pinhits,
       		(pinhits/pins)*100 "PH Ratio",
       		reloads,
       		invalidations
  	from v$librarycache
  	where gets <> 0 or pins <> 0
}

STAT_LATCH_HELD
{
	select l.name, p.username 
	from v$process p, v$latchholder l
	where l.pid = p.pid
}


STAT_SYS_CPU
{
	select value "CPU Used by all Oracle users"
	from v$sysstat 
	where name = 'CPU used by this session'
}

STAT_SESSION_CPU 
{
	select username, sn.name, sum(value) "Total Value"
	from v$session s, v$sesstat ss, v$statname sn
	where s.sid = ss.sid 
	and ss.STATISTIC# = sn.STATISTIC#
	and sn.name like '%CPU%'
	group by username, sn.name
}

STAT_SYS_PARSE
{
	SELECT name, value 
	FROM V$SYSSTAT
	WHERE NAME IN('parse time cpu', 'parse time elapsed', 'parse count (hard)')
}

STAT_SQL_EXEC_COUNT
{
	SELECT PARSE_CALLS, EXECUTIONS, SQL_TEXT
	FROM V$SQLAREA
	where parse_calls > 100
	ORDER BY PARSE_CALLS desc
}

STAT_SQL_BUFFER
{
	SELECT BUFFER_GETS, hash_value, EXECUTIONS, SQL_TEXT
	FROM V$SQLAREA
	WHERE BUFFER_GETS > 5000
	AND EXECUTIONS > 0
	ORDER BY buffer_gets desc
}

MEM_DATA_BUFFERS
{
	SELECT VALUE "Total Buffers"
	FROM V$PARAMETER
	WHERE NAME = 'db_block_buffers';
}

MEM_BUFF_IN_MEM
{
	SELECT name, COUNT(block#), COUNT (DISTINCT bh.file# || block#)
	FROM V$BH bh, v$dbfile df
	where bh.file# = df.file#
	GROUP BY name;
}

MEM_OBJ_IN_MEM
{
	SELECT owner, object_type "Type", 
		object_name "Name", COUNT(*) "Buffers"
	FROM V$BH bh, dba_objects o
	where bh.objd = o.object_id
	and owner not in ('SYS', 'SYSTEM')
	group by owner, object_type, object_name
	having count(*) > 3
	order by "Buffers" desc
}

MEM_LATCH
{
	SELECT CHILD#, SLEEPS/GETS "Ratio"
	FROM V$LATCH_CHILDREN
	WHERE NAME = 'cache buffers lru chain';
}


SPACE_OBJ_COUNT
{
	select owner "Owner", 
		sum(decode(object_type,'TABLE',1,0)) "Table" , 
	       sum(decode(object_type,'INDEX',1,0)) "Index" , 
	       sum(decode(object_type,'SYNONYM',1,0)) "Synonym" , 
	       sum(decode(object_type,'SEQUENCE',1,0)) "Seq" , 
	       sum(decode(object_type,'VIEW',1,0)) "View" , 
	       sum(decode(object_type,'CLUSTER',1,0)) "Cluster",
	       sum(decode(object_type,'DATABASE LINK',1,0)) "DB Link" , 
	       sum(decode(object_type,'PACKAGE',1,0)) "Package" , 
	       sum(decode(object_type,'PACKAGE BODY',1,0)) "Pkg Body" , 
	       sum(decode(object_type,'PROCEDURE',1,0)) "Proc"
	from dba_objects 
	where owner not in ('SYS', 'SYSTEM', 'DBSNMP', 'OUTLN', 'RMAN', 'PUBLIC')
	group by owner 
	order by "Table" desc
}

SPACE_OBJ_COUNT_TOTAL
{
	select sum(decode(object_type,'TABLE',1,0)) "Table" , 
	       sum(decode(object_type,'INDEX',1,0)) "Index" , 
	       sum(decode(object_type,'SYNONYM',1,0)) "Synonym" , 
	       sum(decode(object_type,'SEQUENCE',1,0)) "Seq" , 
	       sum(decode(object_type,'VIEW',1,0)) "View" , 
	       sum(decode(object_type,'CLUSTER',1,0)) "Cluster",
	       sum(decode(object_type,'DATABASE LINK',1,0)) "DB Link" , 
	       sum(decode(object_type,'PACKAGE',1,0)) "Package" , 
	       sum(decode(object_type,'PACKAGE BODY',1,0)) "Pkg Body" , 
	       sum(decode(object_type,'PROCEDURE',1,0)) "Proc"
	from dba_objects 
	where owner not in ('SYS', 'SYSTEM', 'DBSNMP', 'OUTLN', 'RMAN', 'PUBLIC')
}


SPACE_USER_SPACE_DETAIL
{
	select  us.name	"Owner", 
		ts.name	"TS Name",
		sum(seg.blocks*ts.blocksize)/1024/1024 "Size "
	from	sys.ts$ ts, 
		sys.user$ us, 
		sys.seg$ seg 
	where	seg.user# = us.user# 
	and us.name not in ('SYS', 'SYSTEM', 'DBSNMP', 'OUTLN', 'RMAN', 'PUBLIC')
	and  	ts.ts# = seg.ts# 
	group by us.name,ts.name 
	-- order by sum(seg.blocks*ts.blocksize) desc
	order by us.name, sum(seg.blocks*ts.blocksize) desc
}

SPACE_USER_SPACE
{
	select owner "Owner", 
		sum(bytes)/1024/1024 "Size"
	from dba_segments
	where owner not in ('SYS', 'SYSTEM', 'DBSNMP', 'OUTLN', 'RMAN', 'PUBLIC')
	group by owner
	order by "Size" desc
}



SPACE_TS_FREE_SPACE
{
	select a.tablespace_name "TS Name",
		sum(a.tots)/1024/1024 "Size",   
		sum(a.sumb)/1024/1024 "Free",  
		sum(a.sumb)*100/sum(a.tots) "% Free",   
		sum(a.largest)/1024/1024 "Max Free",
		sum(a.chunks) "Chunks Free"   
	from (select tablespace_name,
			0 tots,
			sum(bytes) sumb,   
			max(bytes) largest,count(*) chunks  
		from dba_free_space a  
		group by tablespace_name  
		union  
		select tablespace_name,
			sum(bytes) tots,0,0,0 from  
		dba_data_files  
		group by tablespace_name) a  
	group by a.tablespace_name 
	--order by sum(a.sumb)*100/sum(a.tots)
	order by sum(a.chunks) desc
}

# PROMPT SEGMENTS WHERE THERE'S NOT ENOUGH ROOM FOR THE NEXT EXTENT  
SPACE_NEXT_EXT_NOT_FIT 
{
	select  a.owner, a.segment_name, b.tablespace_name,  
	     decode(ext.extents,1,b.next_extent,  
	     a.bytes*(1+b.pct_increase/100)) nextext,   
	     freesp.largest  
	from    dba_extents a,  
	     dba_segments b,  
	     (select owner, segment_name, max(extent_id) extent_id,  
	     count(*) extents   
	     from dba_extents   
	     group by owner, segment_name  
	     ) ext,  
	     (select tablespace_name, max(bytes) largest  
	     from dba_free_space   
	     group by tablespace_name  
	     ) freesp  
	where   a.owner=b.owner and  
	     a.segment_name=b.segment_name and  
	     a.owner=ext.owner and   
	     a.segment_name=ext.segment_name and  
	     a.extent_id=ext.extent_id and  
	     b.tablespace_name = freesp.tablespace_name and   
	     decode(ext.extents,1,b.next_extent,  
	     a.bytes*(1+b.pct_increase/100)) > freesp.largest  
}

SPACE_EXTENT_BY_OWNER
{
	select segment_name  "Name",  
	  segment_type  "Type",  
	  header_file   "Hdr File",
	  header_block  "Hdr Block",
	  extents       "Extents",
	  blocks        "Blocks"
	from dba_segments  
	where owner = '&owner'
	order by extents desc
}


#
# @@@@ Too big for java to handle!!!!!
#
SPACE_TS_MAP
{
	select tablespace_name              tablespace,  
		  file_id,  
		  1                         block_id,  
		  1                            blocks,  
		  '<file hdr>'                 segment  
	from  
	  dba_extents  
	where  
	  tablespace_name = upper('&ts')  
union  
	select tablespace_name              tablespace,  
		  file_id,  
		  1                            block_id,  
		  1  blocks,  
		  '<file hdr>'                 segment  
	from  
	  dba_free_space  
	where  
	  tablespace_name = upper('&ts')  
union  
	select tablespace_name  tablespace,  
		  file_id,  
		  block_id,  
		  blocks,  
		  owner||'.'||segment_name  segment  
	from  
	  dba_extents  
	where  
	  tablespace_name = upper('&ts')  
union  
	select tablespace_name  tablespace,  
		  file_id,  
		  block_id,  
		  blocks,  
		  '<free>'  
	from  
	  dba_free_space  
	where  
	  tablespace_name = upper('&ts')  
	order by  
	  1,2,3  
}

SPACE_TS_FILE_FREE
{
	select	df.tablespace_name "TS Name",
		df.file_name "File Name",
		df.bytes/1024/1024 "Size",  
		sum(fs.bytes)/1024/1024 "Free", 
		df.status "Status"
	from dba_data_files df ,dba_free_space fs 
	where df.tablespace_name = fs.tablespace_name 
	group by df.tablespace_name,  
		df.file_name,  
		df.status,
		df.bytes
}

SPACE_FILE_MAP
{
	select 'CONTROL' "Type",
	  value       "Name",
	  ''          "Size",
	  ''          "TS Name"
	from 
	  v$parameter 
	where 
	  lower(name) = 'control_files' 
	union 
	select 'REDO'   "Type",
	  group#||':'||member "Name",
	  ''     "Size",
	  ''     "TS Name"
	from 
	  v$logfile 
	union 
	select 'DATA' "Type",
	  file_name   "Name",
	  rpad(to_char(bytes/1048576,'99,990'),7) "Size",
	  tablespace_name                         "TS Name"
	from 
	  dba_data_files 
	order by 
	  1,3 
}

SPACE_OBJ_PER_TS
{
	select 'Table' "Type",
		tablespace_name "TS Name",
		owner "Owner", 
		count(*) "Counts"
	from sys.dba_tables 
	where owner not in ('SYS', 'SYSTEM', 'DBSNMP', 'OUTLN', 'RMAN', 'PUBLIC')	
	group by tablespace_name, owner
	union 
	select 'Index' "Type",
		tablespace_name "TS Name",
		owner "Owner", 
		count(*) "Counts"
	from sys.dba_indexes 
	where owner not in ('SYS', 'SYSTEM', 'DBSNMP', 'OUTLN', 'RMAN', 'PUBLIC')
	group by 1, tablespace_name, owner
	order by 1 desc, 2, 4 desc
}

SPACE_SEGMENT_EXTENT
{
	select 
	  segment_type  "Type", 
	  segment_name "Name",	  
	  extent_id     "Ext Id",
	  file_name      "Name", 
	  block_id      "Blk Id", 
	  e.blocks        "Blocks"
	from 
	  dba_extents e, dba_data_files df
	where 
	  e.file_id = df.file_id
	  and 
	  owner like upper('&owner') 
	    and 
	  segment_name like upper('&segment') 
	order by 
	  owner, 
	  segment_name, 
	  extent_id 
}

SPACE_SEGMENT_EXTENT1
{
	select 
	  segment_type  "Type", 
	  segment_name "Name",
	  extent_id     "Ext Id",
	  file_name      "File Name", 
	  block_id      "Blk Id", 
	  e.blocks        "Blocks"
	from 
	  dba_extents e, dba_data_files df
	where 
	  e.file_id = df.file_id
	  and 
	  owner like upper('&owner') 
	order by 
	  owner, 
	  segment_name, 
	  extent_id 
}

SCHEMA_TAB_COLUMN
{
	select column_id "ID",
		column_name "Name",
		data_type "Type",
		data_length "Length",
		data_precision "Precision",
		data_scale "Scale",
		nullable "Null",
		data_default "Default"
	from dba_tab_columns
	where owner = upper('&owner')
	and table_name = upper('&obj')
}

SCHEMA_TAB_INDEX
{
	select owner "Ind Owner",
		index_name "Ind Name",
		index_type "Type",
		uniqueness "Unique",
		tablespace_name "TS Name",
		logging "Log",
		blevel "BT Level",
		leaf_blocks "L Blocks",
		status "Status"	
	from  dba_indexes
	where table_owner = upper('&owner')
	and table_name = upper('&obj')
}

SCHEMA_TAB_INDEX_COLUMN
{
	select index_name "Ind Name",
		column_name "Column",
		column_position "Position",
		column_length "Length",
		descend "Descend"
	from  dba_ind_columns ic
	where table_owner = upper('&owner')
	and table_name = upper('&obj')
}

SCHEMA_INDEX
{
	select index_type "Type",
		uniqueness "Unique",
		tablespace_name "TS Name",
		logging "Log",
		blevel "BT Level",
		leaf_blocks "L Blocks",
		status "Status"
	from dba_indexes
	where owner = upper('&owner')
	and index_name = upper('&obj')
}

SCHEMA_IND_COLUMN
{
	select column_name "Column",
		column_position "Position",
		descend "Descend"
	from dba_ind_columns
	where index_owner = upper('&owner')
	and index_name = upper('&obj')
}

SCHEMA_VIEW
{
	select 
	 TEXT_LENGTH,
	 TYPE_TEXT_LENGTH,
	 TYPE_TEXT       ,
	 OID_TEXT_LENGTH ,
	 OID_TEXT        ,
	 VIEW_TYPE_OWNER ,
	 VIEW_TYPE      
	 from dba_views
	 where owner = upper('&owner')
	 and view_name = upper('&obj')
}

SCHEMA_VIEW_TEXT
{
	select TEXT
	from dba_views
	where owner = upper('&owner')
	and view_name = upper('&obj')
}

SCHEMA_CONSTRAINT_TAB
{
	select distinct c.constraint_name "Name",
		decode(constraint_type, 
				'C', 'Check on Table',
				'P', 'Primary Key',
				'R', 'Referential Integrity',
				'U', 'Unique Key',
				'V', 'Check on View',
				'O', 'Read Only on View',
				constraint_type) "Type",
		cc.column_name "Column",
		cc.position "Position",
		validated "Validated",
		status "Status",
		delete_rule "Del Rule",
		deferrable "Defferable",
		deferred "Deffered",
		generated "Generated"
	from dba_constraints c, dba_cons_columns cc
	where c.constraint_name = cc.constraint_name
	and c.owner = upper('&owner')
	and c.table_name = upper('&obj')
}

SCHEMA_CONSTRAINT
{
	select 		
		decode(constraint_type, 
			'C', 'Check on Table',
			'P', 'Primary Key',
			'R', 'Referential Integrity',
			'U', 'Unique Key',
			'V', 'Check on View',
			'O', 'Read Only on View',
			constraint_type) "Type",
		cc.column_name "Column",
		cc.position "Position",
		validated "Validated",
		status "Status",
		delete_rule "Del Rule",
		deferrable "Defferable",
		deferred "Deffered",
		generated "Generated"
	from dba_constraints c, dba_cons_columns cc
	where c.constraint_name = cc.constraint_name
	and c.owner = upper('&owner')
	and c.constraint_name = upper('&obj')
}

SCHEMA_TAB_TRIGGER
{
	select owner,
		trigger_name "Name",
		trigger_type "Type",
		triggering_event "Event",
		column_name "Column",
		referencing_names "Ref Names",
		when_clause "When",
		status "Status",
		action_type "Act Type"
	from dba_triggers
	where table_owner = upper('&owner')
	and table_name = upper('&obj')
}


SCHEMA_TRIGGER
{
	select owner,
		trigger_name "Name",
		trigger_type "Type",
		triggering_event "Event",
		column_name "Column",
		referencing_names "Ref Names",
		when_clause "When",
		status "Status",
		action_type "Act Type"
	from dba_triggers
	where table_owner = upper('&owner')
	and trigger_name = upper('&obj')
}

SCHEMA_TRIGGER_TEXT
{
	select trigger_body
		from dba_triggers
	where table_owner = upper('&owner')
	and trigger_name = upper('&obj')
}


SCHEMA_SEQUENCE
{
	select min_value "Min",
		max_value "Max",
		increment_by "Inc",
		cycle_flag "Cycle",
		order_flag "Order",
		cache_size "Cache",
		last_number "Last"
	from dba_sequences
	where sequence_owner = upper('&owner')
	and sequence_name = upper('&obj')
}

SCHEMA_SYNONYM
{
	select table_owner "Table Owner",
		table_name "Table Name",
		db_link "DB Link"
	from dba_synonyms
	where owner = upper('&owner')
	and synonym_name = upper('&obj')
}

SCHEMA_SYNONYM_COLUMN
{
	select distinct column_name "Name",
		data_type "Type",
		data_length "Length",
		data_precision "Precision",
		data_scale "Scale",
		nullable "Null"
	from dba_tab_columns
	where owner = (
		select table_owner
		from dba_synonyms
		where owner = upper('&owner')
		and synonym_name = upper('&obj')
		)
	and table_name = (
		select table_name
		from dba_synonyms
		where owner = upper('&owner')
		and synonym_name = upper('&obj')
		)
	
}

SCHEMA_DB_LINK
{
	select owner "Owner", 
		username "Username", 
		host "Host", 
		created "Created"
	from dba_db_links
	where owner in (upper('&owner'), 'PUBLIC')
}

LOCK_LATCH
{
	select name "Name",
		sleeps "Sleeps",
		((gets - misses) * 100) / decode(gets, 0, 1, gets) "% Get",
		((immediate_gets - immediate_misses) * 100) 
			/ decode(immediate_gets, 0, 1, immediate_gets) "% Imm Get"
	from v$latch
	where gets <> 0 or immediate_gets <> 0
	order by name;
}


LOCK_PROCESS_HOLDING_LATCH
{
	select s.sid, 'LATCH', 'Exclusive', 'None', rawtohex(laddr), ' '
	from v$process p, v$session s, v$latchholder h
	where h.pid  = p.pid    /* 6 = exclusive, 0 = not held */
	and  p.addr = s.paddr
}

LOCK_PROCESS_WAITING_LATCH
{
	select sid, 'LATCH', 'None', 'Exclusive', latchwait,' '
	from v$session s, v$process p
	where latchwait is not null
	and  p.addr = s.paddr
}


LOCK_ROLLBACK_SEG_OVERVIEW
{
	select name "Name", 
		shrinks "Shrinks", 
		hwmsize "HWM", 
		wraps "Wraps", 
		aveactive "Ave Active", 
		extents "Extends"
	from v$rollstat s,
		v$rollname r
	where s.usn = r.usn

}

LOCK_ROLLBACK_SEG
{
	SELECT name "Name", 
		gets "Gets", 
		waits "Waits",
	       ((gets - waits) * 100) / gets "Hit Ratio"
	FROM   v$rollstat S,
	       v$rollname R
	WHERE  S.usn = R.usn
}

LOCK_ROLLBACK_SEG_DETAIL
{
	SELECT class "Class", 
		count(*) "Count"
	FROM   v$waitstat
	WHERE  class in ('system undo header', 
				'system undo block',
			 	'undo header',        
			 	'undo block')
	group by class			 	
}

LOCK_ROLLBACK_SHRINK
{
	SELECT name "Name", 
		extents "Extents", 
		waits "Waits", 
		optsize "Opt Size",
		shrinks "Shrinks", 
		extends "Extends", 
		hwmsize "HWM"
	FROM   v$rollstat S,
	       v$rollname R
	WHERE  S.usn = R.usn
}

LOCK_REDO_LOG
{
	SELECT name "Redo Latch Name", 
		gets "Gets", 
		misses "Misses", 
		((gets - misses) * 100) / gets "% Get",
		immediate_gets "Imm Gets", 
		immediate_misses "Imm misses",
		((immediate_gets - immediate_misses) * 100) 
			/ decode(immediate_gets, 0, 1, immediate_gets) "% Imm Get"
	FROM   v$latch
	WHERE  name in ('redo allocation', 'redo copy')  
}

LOCK_ROLLBACK_LOCK
{
	SELECT r.usn "RSN",      
		r.name "Name",  
		s.osuser "OS User", 
	       s.username "Oracle Login", 
	       s.sid "SID",   
	       x.extents "Extents", 
	       x.extends "Extends",  
	       x.waits "Waits", 
	       x.shrinks "Shrinks",
	       x.wraps "Wraps"
	FROM   sys.v_$rollstat x,
	       sys.v_$rollname r,  
	       sys.v_$session s,
	       sys.v_$transaction t
	WHERE  t.addr       = s.taddr (+)
	AND    x.usn (+)    = r.usn
	AND    t.xidusn (+) = r.usn
	ORDER
	    BY r.usn
}

LOCK_LRU
{
	select name "Name", 
		gets "Gets", 
		misses "Misses", 
		((gets - misses) * 100) / decode(gets, 0, 1, gets) "% Get",
		sleeps "Sleeps", 
		immediate_gets "Imm Gets",
		immediate_misses "Imm Misses",
		((immediate_gets - immediate_misses) * 100) 
			/ decode(immediate_gets, 0, 1, immediate_gets) "% Imm Get"
	from v$latch
	where name like '%cache buffer%' or
		Name like '%cache protect%'
	order by name
}

LOCK_FREE_LIST
{
	select count "Count"
	from v$waitstat
	where class = 'free list';
}

LOCK_DDL
{
	select sid "Sid", 
		username "User",
		owner "Owner",
		name "Name",
		l.type "Type",
		mode_held "Mode held"
	from sys.dba_ddl_locks l, v$session s
	where l.session_id = s.sid
	order by sid
}

LOCK_DML
{
	select sid "Sid",
		username "User",
		owner "Owner",
		name "Name",
		mode_held "Mode held"
	from sys.dba_dml_locks l, v$session s
	where l.session_id = s.sid
	order by sid
}

LOCK_LOCK
{
  select
        username "Name",
        decode(l.type,
                'MR', 'Media Recovery',
                'RT', 'Redo Thread',
                'UN', 'User Name',
                'TX', 'Transaction',
                'TM', 'DML',
                'UL', 'PL/SQL User Lock',
                'DX', 'Distributed Xaction',
                'CF', 'Control File',
                'IS', 'Instance State',
                'FS', 'File Set',
                'IR', 'Instance Recovery',
                'ST', 'Disk Space Transaction',
                'TS', 'Temp Segment',
                'IV', 'Library Cache Invalidation',
                'LS', 'Log Start or Switch',
                'RW', 'Row Wait',
                'SQ', 'Sequence Number',
                'TE', 'Extend Table',
                'TT', 'Temp Table',
                l.type) "Lock Type",
        decode(lmode,
                0, 'None',           /* Mon Lock equivalent */
                1, 'Null',           /* N */
                2, 'Row-S (SS)',     /* L */
                3, 'Row-X (SX)',     /* R */
                4, 'Share',          /* S */
                5, 'S/Row-X (SSX)',  /* C */
                6, 'Exclusive',      /* X */
                to_char(lmode)) "Mode Held",
         decode(request,
                0, 'None',           /* Mon Lock equivalent */
                1, 'Null',           /* N */
                2, 'Row-S (SS)',     /* L */
                3, 'Row-X (SX)',     /* R */
                4, 'Share',          /* S */
                5, 'S/Row-X (SSX)',  /* C */
                6, 'Exclusive',      /* X */
                to_char(request)) "Mode Requested",
         to_char(id1) "id1", 
         to_char(id2) "id2",
         ctime "Last Convert",
         decode(block,
                0, 'Not Blocking',  /* Not blocking any other processes */
                1, 'Blocking',      /* This lock blocks other processes */
                2, 'Global',        /* This lock is global, so we can't tell */
                to_char(block)) "Blocking Others"
      from v$lock l, v$session s
      where l.sid = s.sid
}


LOCK_ENQUEUE_WAIT
{
	select name "Name", value "Value"
	from v$sysstat 
	where name in ('enqueue waits',
			'enqueue timeouts')
}

LOCK_ENQUEUE_REQUEST
{
	select name "Name", value "Value"
	from v$sysstat 
	where name in ('enqueue releases',
			'enqueue requests')
}

LOCK_WHOS_LOCKING_WHO
{
	SELECT s1.username   "Waiting User",
	       s1.osuser           "OS User",
	       to_char(w.session_id)   "Sid",
	       P1.spid                              "Process id",
	       s2.username    "Holding User",
	       s2.osuser           "OS User",
	       to_char(h.session_id)   "Sid",
	       P2.spid                              "Process id"
	FROM   sys.v_$process P1,   sys.v_$process P2,
	       sys.v_$session S1,   sys.v_$session S2,
	       dba_locks w,     dba_locks h
	WHERE  h.mode_held        != 'None'
	AND    h.mode_held        != 'Null'
	AND    w.mode_requested  != 'None'
	AND    w.lock_type (+)    = h.lock_type
	AND    w.lock_id1  (+)    = h.lock_id1
	AND    w.lock_id2  (+)    = h.lock_id2
	AND    w.session_id       = S1.sid  (+)
	AND    h.session_id       = S2.sid  (+)
	AND    S1.paddr           = P1.addr (+)
	AND    S2.paddr           = P2.addr (+)
}

LOCK_WHOS_DOING_WHAT
{
	SELECT s.sid "Sid", 
		s.username "Username", 
		s.osuser "OS User", 
	       nvl(s.machine, '?') "Machine", 
	       nvl(s.program, '?') "Program",
	       s.process "FG Pid", 
	       p.spid "BG Pid", 
	       X.sql_text "SQL"
	FROM   sys.v_$session S,
	       sys.v_$process P, 
	       sys.v_$sqlarea X
	where s.username not in ('SYS', 'SYSTEM', 'DBSNMP', 'OUTLN', 'RMAN', 'PUBLIC')	
	and s.paddr          = p.addr 
	AND    s.type          != 'BACKGROUND' 
	AND    s.sql_address    = x.address
	AND    s.sql_hash_value = x.hash_value
	ORDER
	    BY S.sid
}

ANALYZE_TABLE1
{
	select table_name "Name", 
		blocks "Block #",
		num_rows "Row #", 
		avg_row_len "Avg Row Len", 
		chain_cnt "Chained",
		last_analyzed "Last Analyzed"
	from dba_tables 
	where owner = '&owner'
	--and table_name = '&obj'
}
	
ANALYZE_TABLE
{
	select table_name "Name", 
		blocks "Block #",
		num_rows "Row #", 
		avg_row_len "Avg Row Len", 
		blocks * p.value "Size Occupied",
		avg_row_len * num_rows "Real Size", 
		chain_cnt "Chained",
		last_analyzed "Last Analyzed"
	from dba_tables, v$parameter p
	where owner = '&owner'
	and p.name = 'db_block_size'
	--and table_name = '&obj'
}
	

ANALYZE_INDEX
{
	select index_name "Name",
		num_rows "Row #",
		distinct_keys "Dist Keys",
		leaf_blocks "Leaf Blks",
		clustering_factor "Cluster Factor",
		avg_leaf_blocks_per_key "Avg Leaf Blk/Key",
		last_analyzed "Last Analyzed"
	from dba_indexes
	where owner = '&owner'
	--and index_name = '&obj'
}