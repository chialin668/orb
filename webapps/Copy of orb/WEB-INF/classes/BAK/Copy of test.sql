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
	sum(decode(name, 'consistent gets',value,0))))) 
	* 100 "Hit Ratio"
	from v$sysstat;
}

OV_ROW_CACHE
{
	select (1-(sum(getmisses)/sum(gets))) * 100 "Hit Ratio"
	from v$rowcache;
}

OV_DICT_CACHE
{
	select Sum(Pins) / (Sum(Pins) + Sum(Reloads)) * 100 "Hit Ratio"
	from v$librarycache;
}

OV_SHARED_POOL_SIZE
{
	select to_number(v$parameter.value) value, 
		v$sgastat.bytes,
		(v$sgastat.bytes/to_number(v$parameter.value))*100 "Percent Free"
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
	select sum(value) "Session UGA"
	from v$sesstat
	where statistic# = 15
}

MEM_SESSION_MAX
{
	select sum(value) "Session UGA Max"
	from v$sesstat
	where statistic# = 16
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