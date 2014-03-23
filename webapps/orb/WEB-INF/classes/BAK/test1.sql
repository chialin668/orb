

select tablespace_name, sum(bytes/1024/1024)
from dba_free_space
group by tablespace_name;


select file_name, sum(dfs.bytes/1024/1024)
from dba_free_space dfs, dba_data_files df
where dfs.file_id = df.file_id
group by file_name;


select file_name, sum(bytes/1024/1024)
from dba_data_files
group by file_name
order by file_name;

