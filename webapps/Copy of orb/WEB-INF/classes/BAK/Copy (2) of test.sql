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
		df.bytes/1024/1024 "Total M Bytes",
		df.blocks "SQL Blocks",
		df.bytes/512 "VMS Blocks",
		sum(fs.bytes)/1024/1024 "M Bytes Free",
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
        BYTES/1024/1024 "M Bytes",
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


OV_SHARED_POOL_SIZE
{
	select to_number(v$parameter.value) value, 
		v$sgastat.bytes,
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

OV_SORT
{
	select a.value "Disk Sorts", 
		b.value "Memory Sorts",
		round(100*(b.value/decode((a.value+b.value),
			0,1,(a.value+b.value))),2) "Pct Memory Sorts"
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
	select disk_reads, sql_text
	from v$sqlarea
	where disk_reads > 200
	order by disk_reads desc;
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

IO_PARTITION_INFO
{
	select segment_name, partition_name, segment_type, tablespace_name
	from user_segments
}

IO_FREGMENTATION
{
	select owner, segment_name, segment_type, extents, 
		bytes/1024/1024 "M Bytes"
	from dba_segments
	where extents > 5
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
	select owner, tablespace_name, segment_name|| 
	       decode(segment_type,'TABLE','[T]', 'INDEX', '[I]', 
			    'ROLLBACK','[R]', '[O]') segment_name,
	       sum(bytes) sizing,
	       decode(count(*),1,to_char(count(*)),
			       2,to_char(count(*)),
			       3,to_char(count(*)),
			       4,to_char(count(*)),
			       5,to_char(count(*)),
				 to_char(count(*))||' < Re-build') seg_count 
	  from dba_extents
	 group by owner, tablespace_name, segment_name|| 
		 decode(segment_type,'TABLE','[T]', 'INDEX', '[I]', 
			'ROLLBACK','[R]', '[O]')
	having count(*) > 5
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
	select dbid, name, created, log_mode, open_mode from
	v$database
}

DB_VERSION
{
	select * 
	from v$version
}

DB_INIT_PARAM
{
	select name, value
	from v$parameter
	where value is not null
}

DB_INIT_PARAM_DESC
{
	select nam.ksppinm name, nam.ksppdesc description
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
	select *
	from v$sga
}


DB_INIT_PARAM_UNDOC
{
	select ksppinm, ksppity
	from x$ksppi
	where substr(ksppinm, 1, 1) = '_'
}

# MAXIMUM: the largest contiguous area of space in database blocks
# MINIMUM: the smallest contiguous area of space in database blocks
# AVERAGE: the average size in blocks of a free space extent
# TOTAL shows the amount of free space in each tablespace file in blocks.
#
DBA_TS_FREE_SPACE
{
	SELECT fs.tablespace_name "TABLESPACE", file_name,
		COUNT(*) "PIECES",
		MAX(fs.bytes)/1024/1024 "MAXIMUM",
		MIN(fs.bytes)/1024/1024 "MINIMUM",
		AVG(fs.bytes)/1024/1024 "AVERAGE",
		SUM(fs.bytes)/1024/1024 "TOTAL"
		FROM dba_free_space fs, dba_data_files df
	where fs.file_id = df.file_id
	GROUP BY fs.tablespace_name, file_name
}

DBA_TS_INFO
{
	SELECT tablespace_name, blocks, bytes/1024/1024 "Mbytes", file_name
	FROM dba_data_files
}




DBA_TS_PARAMS
{
	SELECT tablespace_name "TABLESPACE",
	initial_extent "INITIAL_EXT",
	next_extent "NEXT_EXT",
	min_extents "MIN_EXT",
	max_extents "MAX_EXT",
	pct_increase
	FROM dba_tablespaces
}

DBA_FILE_INFO
{
	select file_name, bytes/1024/1024 "M Bytes",
	maxbytes/1024/1024 "Max Bytes",
	autoextensible, status
	from dba_data_files
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
	select owner, segment_name, count(extent_id), sum(bytes/1024) "K Bytes"
	from dba_extents
	where owner not in ('SYS', 'SYSTEM')
	group by owner, segment_name
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
	select sid, serial#, username, machine, program, logon_time, status
	from v$session
	--where username is not null
}


LOG_FILE
{
	select l.group#, member, thread#, sequence#, bytes, members, archived, l.status
	from v$logfile lf, v$log l
	where lf.group# = l.group#
}


LOG_HISTORY
{
	select *
	from v$log_history
}


LOG_BUFFER_ALLOCCATION
{
	SELECT NAME, VALUE
	FROM V$SYSSTAT
	WHERE NAME = 'redo buffer allocation retries'
}

USER_SQL
{
	select s.username, t.sql_text 
	from v$session s, v$open_cursor oc, v$sqltext t
	where s.sid = oc.sid
	and t.hash_value = oc.hash_value 
	and t.address=oc.address
	order by oc.sid, t.address, t.hash_value, t.piece
}


USER_SESSION 
{
	select sess.username, s.sid, sn.name, s.value
	from v$sesstat s, v$statname sn, v$session sess
	where sess.username is not null
	and s.sid=sess.sid
	and s.statistic# = sn.statistic#
	and s.value != 0
	order by s.sid, sn.name
}

USER_LOCK
{
   SELECT sn.username, m.sid, m.type,
   DECODE(m.lmode, 0, 'None'
                 , 1, 'Null'
                 , 2, 'Row Share'
                 , 3, 'Row Excl.'
                 , 4, 'Share'
                 , 5, 'S/Row Excl.'
                 , 6, 'Exclusive'
                 , lmode, ltrim(to_char(lmode,'990'))) lmode,
   DECODE(m.request, 0, 'None'
                 , 1, 'Null'
                 , 2, 'Row Share'
                 , 3, 'Row Excl.'
                 , 4, 'Share'
                 , 5, 'S/Row Excl.'
                 , 6, 'Exclusive'
                 , request, ltrim(to_char(request,'990'))) request,
         m.id1,m.id2
   FROM v$session sn, V$lock m
   where sn.sid = m.sid 
}


USER_LOCK_DETAIL
{
   SELECT sn.username, m.sid, m.type,
   DECODE(m.lmode, 0, 'None'
                 , 1, 'Null'
                 , 2, 'Row Share'
                 , 3, 'Row Excl.'
                 , 4, 'Share'
                 , 5, 'S/Row Excl.'
                 , 6, 'Exclusive'
                 , lmode, ltrim(to_char(lmode,'990'))) lmode,
   DECODE(m.request, 0, 'None'
                 , 1, 'Null'
                 , 2, 'Row Share'
                 , 3, 'Row Excl.'
                 , 4, 'Share'
                 , 5, 'S/Row Excl.'
                 , 6, 'Exclusive'
                 , request, ltrim(to_char(request,'990'))) request,
         obj1.object_name objname, obj2.object_name objname
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
       s.username,
       rn.name,
       r.rssize,
       r.waits,
       r.extents, 
       r.shrinks,
	 r.optsize,
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
                        'look it up '||to_char(s.command)) command
	from v$session s, v$transaction t, v$rollstat r, v$rollname rn
	where s.taddr (+) = t.addr 
	and t.xidusn (+) = r.usn 
	and rn.usn = r.usn 
	order by rn.name
}

USER_ROLLBACK_LOCK
{
   SELECT   rn.name name0
	 , p.pid
         ,p.spid 
         , NVL (p.username, 'NO TRANSACTION') user0
         , p.terminal
  FROM v$lock l, v$process p, v$rollname rn
  WHERE    l.sid = p.pid(+)
  AND      TRUNC (l.id1(+)/65536) = rn.usn
  AND      l.type(+) = 'TX'
  AND      l.lmode(+) = 6
  ORDER BY rn.name
}

USER_OPEN_CURSOR
{
	select USER_NAME, to_char(sysdate,'hh24:mi:ss') col1, sql_text
	from v$open_cursor;
}

USER_SESS_CURSOR_CACHE
{
	select * from v$session_cursor_cache
}

SYSTEM_CURSOR_CACHE
{
	select * from v$system_cursor_cache
}


##############################################################################

DB_BG_PROCESS
{
	select name, description, error
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
	select  username, sid, serial#, status, machine, program, logon_time
	from v$session
	where username is not null
}

STAT_STAT
{
	select  n.name, value
	from v$statname n ,  v$sysstat s
	where n.statistic# = s.statistic#
	and value <> 0
}

STAT_LATCH
{
	select 	n.name, gets, misses, 
		round(decode(gets-misses, 0, 1, gets-misses)/decode(gets, 0, 1, gets), 2) "Ratio",
		sleeps, 
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
	select df.file_name, phyrds, phyblkrd, readtim, 
		phywrts, phyblkwrt, writetim
	from v$filestat fs, dba_data_files df
	where fs.file# = df.file_id
	
	
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