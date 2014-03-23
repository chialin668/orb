<html>
<head>
	<title></title>
</head>

<body>
<P><u>DB_VERSION:</u></P>
<P>Database (and optional packages) version(s) of this database</P>
<ul>
<TABLE border=1 cellPadding=5 cellSpacing=0 id=DB_INIT_PARAM_DESC>
<TBODY>
<TR>
<TD>
<P align=center><strong>Name</strong></P></TD>
<TD>
<P align=center><strong>Description</strong></A></P></TD></TR>
<TR>
<TD>O7_DICTIONARY_ACCESSIBILITY</TD>
<TD>Version 7 Dictionary Accessibility Support</TD></TR>
<TR>
<TD>_NUMA_instance_mapping</TD>
<TD>Set of nodes that this instance should run on</TD></TR>
<TR>
<TD>_NUMA_pool_size</TD>
<TD>aggregate size in bytes of NUMA pool</TD></TR>
<TR>
<TD>_PX_use_large_pool</TD>
<TD>Use Large Pool as source of PX buffers</TD></TR>
<TR>
<TD>_active_standby_fast_reconfiguration</TD>
<TD>if TRUE optimize dlm reconfiguration for active/standby OPS</TD></TR>
<TR>
<TD>_advanced_dss_features</TD>
<TD>enable advanced dss features</TD></TR>
<TR>
<TD>_affinity_on</TD>
<TD>enable/disable affinity at run time</TD></TR>
<TR>
<TD>_all_shared_dblinks</TD>
<TD>treat all dblinks as shared</TD></TR>
<TR>
<TD>_allocate_creation_order</TD>
<TD>should files be examined in creation order during allocation</TD></TR>
<TR>
<TD>_allow_error_simulation</TD>
<TD>Allow error simulation for testing</TD></TR>
<TR>
<TD>_allow_read_only_corruption</TD>
<TD>allow read-only open even if database is corrupt</TD></TR>
<TR>
<TD>_allow_resetlogs_corruption</TD>
<TD>allow resetlogs even if it will cause corruption</TD></TR>
<TR>
<TD>_always_star_transformation</TD>
<TD>always favor use of star transformation</TD></TR>
<TR>
<TD>_aq_tm_scanlimit</TD>
<TD>scan limit for Time Managers to clean up IOT</TD></TR>
<TR>
<TD>_arch_io_slaves</TD>
<TD>ARCH I/O slaves</TD></TR>
<TR>
<TD>_async_bsp</TD>
<TD>if TRUE, BSP flushes log asynchronously (DFS)</TD></TR>
<TR>
<TD>_average_dirties_half_life</TD>
<TD>Half life in bytes of first dirties running average</TD></TR>
<TR>
<TD>_b_tree_bitmap_plans</TD>
<TD>enable the use of bitmap plans for tables w. only B-tree indexes</TD></TR>
<TR>
<TD>_backup_disk_io_slaves</TD>
<TD>BACKUP Disk I/O slaves</TD></TR>
<TR>
<TD>_backup_io_pool_size</TD>
<TD>memory to reserve from the large pool</TD></TR>
<TR>
<TD>_bsp_log_flush</TD>
<TD>if TRUE, flush redo log before serving a CR buffer (DFS)</TD></TR>
<TR>
<TD>_bump_highwater_mark_count</TD>
<TD>how many blocks should we allocate per free list on advancing HW</TD></TR>
<TR>
<TD>_check_block_after_checksum</TD>
<TD>perform block check after checksum if both are turned on</TD></TR>
<TR>
<TD>_cleanup_rollback_entries</TD>
<TD>no. of undo entries to apply per transaction cleanup</TD></TR>
<TR>
<TD>_close_cached_open_cursors</TD>
<TD>close cursors cached by PL/SQL at each commit</TD></TR>
<TR>
<TD>_column_elimination_off</TD>
<TD>turn off predicate-only column elimination</TD></TR>
<TR>
<TD>_compatible_no_recovery</TD>
<TD>Database will be compatible unless crash or media recovery is ne</TD></TR>
<TR>
<TD>_complex_view_merging</TD>
<TD>enable complex view merging</TD></TR>
<TR>
<TD>_controlfile_enqueue_timeout</TD>
<TD>control file enqueue timeout in seconds</TD></TR>
<TR>
<TD>_corrupt_blocks_on_stuck_recovery</TD>
<TD>number of times to corrupt a block when media recovery stuck</TD></TR>
<TR>
<TD>_corrupted_rollback_segments</TD>
<TD>corrupted undo segment list</TD></TR>
<TR>
<TD>_cpu_to_io</TD>
<TD>multiplier for converting CPU cost to I/O cost</TD></TR>
<TR>
<TD>_cr_server</TD>
<TD>if TRUE, enable CR server (DFS)</TD></TR>
<TR>
<TD>_cr_server_extn</TD>
<TD>if TRUE, enable CR server extension(DFS)</TD></TR>
<TR>
<TD>_cursor_db_buffers_pinned</TD>
<TD>additional number of buffers a cursor can pin at once</TD></TR>
<TR>
<TD>_db_aging_cool_count</TD>
<TD>Touch count set when buffer cooled</TD></TR>
<TR>
<TD>_db_aging_freeze_cr</TD>
<TD>Make CR buffers always be too cold to keep in cache</TD></TR>
<TR>
<TD>_db_aging_hot_criteria</TD>
<TD>Touch count which sends a buffer to head of replacement list</TD></TR>
<TR>
<TD>_db_aging_stay_count</TD>
<TD>Touch count set when buffer moved to head of replacement list</TD></TR>
<TR>
<TD>_db_aging_touch_time</TD>
<TD>Touch count which sends a buffer to head of replacement list</TD></TR>
<TR>
<TD>_db_always_check_system_ts</TD>
<TD>Always perform block check and checksum for System tablespace</TD></TR>
<TR>
<TD>_db_block_cache_clone</TD>
<TD>Always clone data blocks on get (for debugging)</TD></TR>
<TR>
<TD>_db_block_cache_map</TD>
<TD>Map / unmap and track reference counts on blocks (for debugging)</TD></TR>
<TR>
<TD>_db_block_cache_protect</TD>
<TD>protect database blocks (true only when debugging)</TD></TR>
<TR>
<TD>_db_block_check_for_debug</TD>
<TD>Check more and dump block before image for debugging</TD></TR>
<TR>
<TD>_db_block_hash_buckets</TD>
<TD>Number of database block hash buckets</TD></TR>
<TR>
<TD>_db_block_hash_latches</TD>
<TD>Number of database block hash latches</TD></TR>
<TR>
<TD>_db_block_hi_priority_batch_size</TD>
<TD>Fraction of writes for high priority reasons</TD></TR>
<TR>
<TD>_db_block_max_cr_dba</TD>
<TD>Maximum Allowed Number of CR buffers per dba</TD></TR>
<TR>
<TD>_db_block_max_scan_cnt</TD>
<TD>Maximum number of buffers to inspect when looking for free</TD></TR>
<TR>
<TD>_db_block_med_priority_batch_size</TD>
<TD>Fraction of writes for medium priority reasons</TD></TR>
<TR>
<TD>_db_block_numa</TD>
<TD>Number of NUMA nodes</TD></TR>
<TR>
<TD>_db_cache_advice</TD>
<TD>Buffer cache sizing advisory</TD></TR>
<TR>
<TD>_db_file_noncontig_mblock_read_count</TD>
<TD>number of noncontiguous db blocks to be prefetched</TD></TR>
<TR>
<TD>_db_handles</TD>
<TD>System-wide simultaneous buffer operations</TD></TR>
<TR>
<TD>_db_handles_cached</TD>
<TD>Buffer handles cached each process</TD></TR>
<TR>
<TD>_db_large_dirty_queue</TD>
<TD>Number of buffers which force dirty queue to be written</TD></TR>
<TR>
<TD>_db_no_mount_lock</TD>
<TD>do not get a mount lock</TD></TR>
<TR>
<TD>_db_percent_hot_default</TD>
<TD>Percent of default buffer pool considered hot</TD></TR>
<TR>
<TD>_db_percent_hot_keep</TD>
<TD>Percent of keep buffer pool considered hot</TD></TR>
<TR>
<TD>_db_percent_hot_recycle</TD>
<TD>Percent of recycle buffer pool considered hot</TD></TR>
<TR>
<TD>_db_writer_chunk_writes</TD>
<TD>Number of writes DBWR should wait for</TD></TR>
<TR>
<TD>_db_writer_histogram_statistics</TD>
<TD>maintain dbwr histogram statistics in x$kcbbhs</TD></TR>
<TR>
<TD>_db_writer_max_writes</TD>
<TD>Max number of outstanding DB Writer IOs</TD></TR>
<TR>
<TD>_db_writer_scan_depth</TD>
<TD>Number of LRU buffers for dbwr to scan when looking for dirty</TD></TR>
<TR>
<TD>_dbwr_async_io</TD>
<TD>Enable dbwriter asynchronous writes</TD></TR>
<TR>
<TD>_dbwr_scan_interval</TD>
<TD>dbwriter scan interval</TD></TR>
<TR>
<TD>_dbwr_tracing</TD>
<TD>Enable dbwriter tracing</TD></TR>
<TR>
<TD>_default_non_equality_sel_check</TD>
<TD>sanity check on default selectivity for like/range predicate</TD></TR>
<TR>
<TD>_defer_multiple_waiters</TD>
<TD>if TRUE, defer down converts when there were waiters (DFS)</TD></TR>
<TR>
<TD>_disable_file_locks</TD>
<TD>disable file locks for control, data, redo log files</TD></TR>
<TR>
<TD>_disable_incremental_checkpoints</TD>
<TD>Disable incremental checkpoints for thread recovery</TD></TR>
<TR>
<TD>_disable_latch_free_SCN_writes_via_32cas</TD>
<TD>disable latch-free SCN writes using 32-bit compare &amp; swap</TD></TR>
<TR>
<TD>_disable_latch_free_SCN_writes_via_64cas</TD>
<TD>disable latch-free SCN writes using 64-bit compare &amp; swap</TD></TR>
<TR>
<TD>_disable_logging</TD>
<TD>Disable logging</TD></TR>
<TR>
<TD>_discrete_transactions_enabled</TD>
<TD>enable OLTP mode</TD></TR>
<TR>
<TD>_disk_get_lock</TD>
<TD>if TRUE, get a lock after disk status (DFS)</TD></TR>
<TR>
<TD>_distributed_lock_timeout</TD>
<TD>number of seconds a distributed transaction waits for a lock</TD></TR>
<TR>
<TD>_distributed_recovery_connection_hold_time</TD>
<TD>number of seconds RECO holds outbound connections open</TD></TR>
<TR>
<TD>_domain_index_batch_size</TD>
<TD>maximum number of rows from one call to domain index fetch routi</TD></TR>
<TR>
<TD>_domain_index_dml_batch_size</TD>
<TD>maximum number of rows for one call to domain index dml routines</TD></TR>
<TR>
<TD>_dss_cache_flush</TD>
<TD>enable full cache flush for parallel execution</TD></TR>
<TR>
<TD>_dump_MTTR_to_trace</TD>
<TD>Dump High Availability MTTR infromation to CKPT trace file</TD></TR>
<TR>
<TD>_dynamic_stats_threshold</TD>
<TD>delay threshold (in seconds) between sending statistics messages</TD></TR>
<TR>
<TD>_eliminate_common_subexpr</TD>
<TD>enables elimination of common sub-expressions</TD></TR>
<TR>
<TD>_enable_NUMA_optimization</TD>
<TD>Enable NUMA specific optimizations</TD></TR>
<TR>
<TD>_enable_block_level_transaction_recovery</TD>
<TD>enable block level recovery</TD></TR>
<TR>
<TD>_enable_cscn_caching</TD>
<TD>enable commit SCN caching for all transactions</TD></TR>
<TR>
<TD>_enable_default_affinity</TD>
<TD>to enable default implementation of affinity osds</TD></TR>
<TR>
<TD>_enable_list_io</TD>
<TD>Enable List I/O</TD></TR>
<TR>
<TD>_enable_multitable_sampling</TD>
<TD>enable multitable sampling</TD></TR>
<TR>
<TD>_enable_type_dep_selectivity</TD>
<TD>enable type dependent selectivity estimates</TD></TR>
<TR>
<TD>_enqueue_debug_multi_instance</TD>
<TD>debug enqueue multi instance</TD></TR>
<TR>
<TD>_enqueue_hash</TD>
<TD>enqueue hash table length</TD></TR>
<TR>
<TD>_enqueue_hash_chain_latches</TD>
<TD>enqueue hash chain latches</TD></TR>
<TR>
<TD>_enqueue_locks</TD>
<TD>locks for managed enqueues</TD></TR>
<TR>
<TD>_fairness_threshold</TD>
<TD>number of times to CR serve before downgrading lock (DFS)</TD></TR>
<TR>
<TD>_fast_full_scan_enabled</TD>
<TD>enable/disable index fast full scan</TD></TR>
<TR>
<TD>_fifth_spare_parameter</TD>
<TD>fifth spare parameter - string</TD></TR>
<TR>
<TD>_filesystemio_options</TD>
<TD>IO operations on filesystem files</TD></TR>
<TR>
<TD>_first_spare_parameter</TD>
<TD>first spare parameter - integer</TD></TR>
<TR>
<TD>_fourth_spare_parameter</TD>
<TD>fourth spare parameter - string</TD></TR>
<TR>
<TD>_freeze_DB_for_fast_instance_recovery</TD>
<TD>freeze database during instance recovery</TD></TR>
<TR>
<TD>_full_pwise_join_enabled</TD>
<TD>enable full partition-wise join when TRUE</TD></TR>
<TR>
<TD>_gc_bsp_procs</TD>
<TD>number of buffer server processes to start (DFS)</TD></TR>
<TR>
<TD>_gc_class_locks</TD>
<TD>set locks for the minor classes (DFS)</TD></TR>
<TR>
<TD>_gc_latches</TD>
<TD>number of latches per lock process (DFS)</TD></TR>
<TR>
<TD>_gc_lck_procs</TD>
<TD>number of background parallel server lock processes to start</TD></TR>
<TR>
<TD>_groupby_nopushdown_cut_ratio</TD>
<TD>groupby nopushdown cut ratio</TD></TR>
<TR>
<TD>_groupby_orderby_combine</TD>
<TD>groupby/orderby don't combine threshold</TD></TR>
<TR>
<TD>_high_server_threshold</TD>
<TD>high server thresholds</TD></TR>
<TR>
<TD>_idl_conventional_index_maintenance</TD>
<TD>enable conventional index maintenance for insert direct load</TD></TR>
<TR>
<TD>_ignore_desc_in_index</TD>
<TD>ignore DESC in indexes, sort those columns ascending anyhow</TD></TR>
<TR>
<TD>_improved_outerjoin_card</TD>
<TD>improved outer-join cardinality calculation</TD></TR>
<TR>
<TD>_improved_row_length_enabled</TD>
<TD>enable the improvements for computing the average row length</TD></TR>
<TR>
<TD>_index_join_enabled</TD>
<TD>enable the use of index joins</TD></TR>
<TR>
<TD>_index_prefetch_factor</TD>
<TD>index prefetching factor</TD></TR>
<TR>
<TD>_init_sql_file</TD>
<TD>File containing SQL statements to execute upon database creation</TD></TR>
<TR>
<TD>_interconnect_checksum</TD>
<TD>if TRUE, checksum interconnect blocks (DFS)</TD></TR>
<TR>
<TD>_io_slaves_disabled</TD>
<TD>Do not use I/O slaves</TD></TR>
<TR>
<TD>_ioslave_batch_count</TD>
<TD>Per attempt IOs picked</TD></TR>
<TR>
<TD>_ioslave_issue_count</TD>
<TD>IOs issued before completion check</TD></TR>
<TR>
<TD>_ipc_fail_network</TD>
<TD>Simulate cluster network failer</TD></TR>
<TR>
<TD>_ipc_test_failover</TD>
<TD>Test transparent cluster network failover</TD></TR>
<TR>
<TD>_ipc_test_mult_nets</TD>
<TD>simulate multiple cluster networks</TD></TR>
<TR>
<TD>_kcl_debug</TD>
<TD>if TRUE, record le history (DFS)</TD></TR>
<TR>
<TD>_kgl_bucket_count</TD>
<TD>index to the bucket count array</TD></TR>
<TR>
<TD>_kgl_latch_count</TD>
<TD>number of library cache latches</TD></TR>
<TR>
<TD>_kgl_multi_instance_invalidation</TD>
<TD>whether KGL to support multi-instance invalidations</TD></TR>
<TR>
<TD>_kgl_multi_instance_lock</TD>
<TD>whether KGL to support multi-instance locks</TD></TR>
<TR>
<TD>_kgl_multi_instance_pin</TD>
<TD>whether KGL to support multi-instance pins</TD></TR>
<TR>
<TD>_kkfi_trace</TD>
<TD>trace expression substitution</TD></TR>
<TR>
<TD>_ksi_trace</TD>
<TD>Trace string of lock type(s)</TD></TR>
<TR>
<TD>_large_pool_min_alloc</TD>
<TD>minimum allocation size in bytes for the large allocation pool</TD></TR>
<TR>
<TD>_latch_miss_stat_sid</TD>
<TD>Sid of process for which to collect latch stats</TD></TR>
<TR>
<TD>_latch_recovery_alignment</TD>
<TD>align latch recovery structures</TD></TR>
<TR>
<TD>_latch_wait_posting</TD>
<TD>post sleeping processes when free latch</TD></TR>
<TR>
<TD>_lazy_freelist_close</TD>
<TD>if TRUE, locks on the freelist are closed (DFS)</TD></TR>
<TR>
<TD>_le_lru_scan</TD>
<TD>if TRUE, scan the lru looking for lock elements (DFS)</TD></TR>
<TR>
<TD>_left_nested_loops_random</TD>
<TD>enable random distribution method for left of nestedloops</TD></TR>
<TR>
<TD>_lgwr_async_io</TD>
<TD>LGWR Asynchronous IO enabling boolean flag</TD></TR>
<TR>
<TD>_lgwr_io_slaves</TD>
<TD>LGWR I/O slaves</TD></TR>
<TR>
<TD>_like_with_bind_as_equality</TD>
<TD>treat LIKE predicate with bind as an equality predicate</TD></TR>
<TR>
<TD>_lm_ast_option</TD>
<TD>enable ast passthrough option</TD></TR>
<TR>
<TD>_lm_cache_res_cleanup</TD>
<TD>percentage of cached resources should be cleanup</TD></TR>
<TR>
<TD>_lm_dd_interval</TD>
<TD>dd time interval in seconds</TD></TR>
<TR>
<TD>_lm_direct_sends</TD>
<TD>Processes which will do direct lock manager sends</TD></TR>
<TR>
<TD>_lm_dlmd_procs</TD>
<TD>number of background lock manager daemon processes to start</TD></TR>
<TR>
<TD>_lm_domains</TD>
<TD>number of groups configured for the lock manager</TD></TR>
<TR>
<TD>_lm_groups</TD>
<TD>number of groups configured for the lock manager</TD></TR>
<TR>
<TD>_lm_non_fault_tolerant</TD>
<TD>disable lock manager fault-tolerance mode</TD></TR>
<TR>
<TD>_lm_procs</TD>
<TD>number of client processes configured for the lock manager</TD></TR>
<TR>
<TD>_lm_rcv_buffer_size</TD>
<TD>the size of receive buffer</TD></TR>
<TR>
<TD>_lm_res_cache</TD>
<TD>enable or disable lock manager resource cache</TD></TR>
<TR>
<TD>_lm_res_cache_interval</TD>
<TD>resource cache cleanup interval in centiseconds</TD></TR>
<TR>
<TD>_lm_send_buffers</TD>
<TD>number of lock manager send buffers</TD></TR>
<TR>
<TD>_lm_statistics</TD>
<TD>enable lock manager statistics collection</TD></TR>
<TR>
<TD>_lm_sync_timeout</TD>
<TD>Synchronization timeout for DLM reconfiguration steps</TD></TR>
<TR>
<TD>_lm_ticket_active_sendback</TD>
<TD>Flow control ticket active sendback threshold</TD></TR>
<TR>
<TD>_lm_xids</TD>
<TD>number of transaction IDs configured for the lock manager</TD></TR>
<TR>
<TD>_lock_sga_areas</TD>
<TD>Lock specified areas of the SGA in physical memory</TD></TR>
<TR>
<TD>_log_archive_buffer_size</TD>
<TD>Size of each archival buffer in log file blocks</TD></TR>
<TR>
<TD>_log_archive_buffers</TD>
<TD>Number of buffers to allocate for archiving</TD></TR>
<TR>
<TD>_log_blocks_during_backup</TD>
<TD>log block images when changed during backup</TD></TR>
<TR>
<TD>_log_buffers_corrupt</TD>
<TD>corrupt redo buffers before write</TD></TR>
<TR>
<TD>_log_buffers_debug</TD>
<TD>debug redo buffers (slows things down)</TD></TR>
<TR>
<TD>_log_checkpoint_recovery_check</TD>
<TD># redo blocks to verify after checkpoint</TD></TR>
<TR>
<TD>_log_debug_multi_instance</TD>
<TD>debug redo multi instance code</TD></TR>
<TR>
<TD>_log_io_size</TD>
<TD>automatically initiate log write if this many redo blocks in buf</TD></TR>
<TR>
<TD>_log_simultaneous_copies</TD>
<TD>number of simultaneous copies into redo buffer(# of copy latches</TD></TR>
<TR>
<TD>_log_space_errors</TD>
<TD>should we report space errors to alert log</TD></TR>
<TR>
<TD>_low_server_threshold</TD>
<TD>low server thresholds</TD></TR>
<TR>
<TD>_max_exponential_sleep</TD>
<TD>max sleep during exponential backoff</TD></TR>
<TR>
<TD>_max_sleep_holding_latch</TD>
<TD>max time to sleep while holding a latch</TD></TR>
<TR>
<TD>_max_transaction_branches</TD>
<TD>max. number of branches per distributed transaction</TD></TR>
<TR>
<TD>_messages</TD>
<TD>message queue resources - dependent on # processes &amp; # buffers</TD></TR>
<TR>
<TD>_minimal_stats_aggregation</TD>
<TD>prohibit stats aggregation at compile/partition maintenance time</TD></TR>
<TR>
<TD>_minimum_giga_scn</TD>
<TD>Minimum SCN to start with in 2^30 units</TD></TR>
<TR>
<TD>_mts_load_constants</TD>
<TD>server load balancing constants (S,P,D,I,L,C,M)</TD></TR>
<TR>
<TD>_mts_rate_scale</TD>
<TD>scale to display rate statistic (100ths of a second)</TD></TR>
<TR>
<TD>_mts_rate_ttl</TD>
<TD>time-to-live for rate statistic (100ths of a second)</TD></TR>
<TR>
<TD>_mv_refresh_selections</TD>
<TD>create materialized views with selections and fast refresh</TD></TR>
<TR>
<TD>_ncmb_readahead_enabled</TD>
<TD>enable multi-block readahead for an index scan</TD></TR>
<TR>
<TD>_ncmb_readahead_tracing</TD>
<TD>turn on multi-block readahead tracing</TD></TR>
<TR>
<TD>_nested_loop_fudge</TD>
<TD>nested loop fudge</TD></TR>
<TR>
<TD>_new_connect_by_enabled</TD>
<TD>enable/disable connect by improvements</TD></TR>
<TR>
<TD>_new_initial_join_orders</TD>
<TD>enable initial join orders based on new ordering heuristics</TD></TR>
<TR>
<TD>_no_objects</TD>
<TD>no object features are used</TD></TR>
<TR>
<TD>_no_or_expansion</TD>
<TD>OR expansion during optimization disabled</TD></TR>
<TR>
<TD>_number_cached_attributes</TD>
<TD>maximum number of cached attributes per instance</TD></TR>
<TR>
<TD>_offline_rollback_segments</TD>
<TD>offline undo segment list</TD></TR>
<TR>
<TD>_ogms_home</TD>
<TD>GMS home directory</TD></TR>
<TR>
<TD>_oneside_colstat_for_equijoins</TD>
<TD>sanity check on default selectivity for like/range predicate</TD></TR>
<TR>
<TD>_open_files_limit</TD>
<TD>Limit on number of files opened by I/O subsystem</TD></TR>
<TR>
<TD>_optim_enhance_nnull_detection</TD>
<TD>TRUE to enable index [fast] full scan more often</TD></TR>
<TR>
<TD>_optimizer_adjust_for_nulls</TD>
<TD>adjust selectivity for null values</TD></TR>
<TR>
<TD>_optimizer_choose_permutation</TD>
<TD>force the optimizer to use the specified permutation</TD></TR>
<TR>
<TD>_optimizer_degree</TD>
<TD>force the optimizer to use the same degree of parallelism</TD></TR>
<TR>
<TD>_optimizer_mode_force</TD>
<TD>force setting of optimizer mode for user recursive SQL also</TD></TR>
<TR>
<TD>_optimizer_search_limit</TD>
<TD>optimizer search limit</TD></TR>
<TR>
<TD>_optimizer_undo_changes</TD>
<TD>undo changes to query optimizer</TD></TR>
<TR>
<TD>_or_expand_nvl_predicate</TD>
<TD>enable OR expanded plan for NVL/DECODE predicate</TD></TR>
<TR>
<TD>_oracle_trace_events</TD>
<TD>Oracle TRACE event flags</TD></TR>
<TR>
<TD>_oracle_trace_facility_version</TD>
<TD>Oracle TRACE facility version</TD></TR>
<TR>
<TD>_ordered_nested_loop</TD>
<TD>enable ordered nested loop costing</TD></TR>
<TR>
<TD>_ordered_semijoin</TD>
<TD>enable ordered semi-join subquery</TD></TR>
<TR>
<TD>_parallel_adaptive_max_users</TD>
<TD>maximum number of users running with default DOP</TD></TR>
<TR>
<TD>_parallel_default_max_instances</TD>
<TD>default maximum number of instances for parallel query</TD></TR>
<TR>
<TD>_parallel_execution_message_align</TD>
<TD>Alignment of PX buffers to OS page boundary</TD></TR>
<TR>
<TD>_parallel_fake_class_pct</TD>
<TD>fake db-scheduler percent used for testing</TD></TR>
<TR>
<TD>_parallel_load_bal_unit</TD>
<TD>number of threads to allocate per instance</TD></TR>
<TR>
<TD>_parallel_load_balancing</TD>
<TD>parallel execution load balanced slave allocation</TD></TR>
<TR>
<TD>_parallel_min_message_pool</TD>
<TD>minimum size of shared pool memory to reserve for pq servers</TD></TR>
<TR>
<TD>_parallel_recovery_stopat</TD>
<TD>stop at -position- to step through SMON</TD></TR>
<TR>
<TD>_parallel_server_idle_time</TD>
<TD>idle time before parallel query server dies</TD></TR>
<TR>
<TD>_parallel_server_sleep_time</TD>
<TD>sleep time between dequeue timeouts (in 1/100ths)</TD></TR>
<TR>
<TD>_parallel_txn_global</TD>
<TD>enable parallel_txn hint with updates and deletes</TD></TR>
<TR>
<TD>_parallelism_cost_fudge_factor</TD>
<TD>set the parallelism cost fudge factor</TD></TR>
<TR>
<TD>_partial_pwise_join_enabled</TD>
<TD>enable partial partition-wise join when TRUE</TD></TR>
<TR>
<TD>_passwordfile_enqueue_timeout</TD>
<TD>password file enqueue timeout in seconds</TD></TR>
<TR>
<TD>_pdml_gim_sampling</TD>
<TD>control separation of global index maintenance for PDML</TD></TR>
<TR>
<TD>_pdml_gim_staggered</TD>
<TD>slaves start on different index when doing index maint</TD></TR>
<TR>
<TD>_pdml_slaves_diff_part</TD>
<TD>slaves start on different partition when doing index maint</TD></TR>
<TR>
<TD>_plsql_dump_buffer_events</TD>
<TD>conditions upon which the PL/SQL circular buffer is dumped</TD></TR>
<TR>
<TD>_plsql_load_without_compile</TD>
<TD>PL/SQL load without compilation flag</TD></TR>
<TR>
<TD>_predicate_elimination_enabled</TD>
<TD>allow predicate elimination if set to TRUE</TD></TR>
<TR>
<TD>_project_view_columns</TD>
<TD>enable projecting out unreferenced columns of a view</TD></TR>
<TR>
<TD>_push_join_predicate</TD>
<TD>enable pushing join predicate inside a view</TD></TR>
<TR>
<TD>_push_join_union_view</TD>
<TD>enable pushing join predicate inside a union view</TD></TR>
<TR>
<TD>_px_async_getgranule</TD>
<TD>asynchronous get granule in the slave</TD></TR>
<TR>
<TD>_px_broadcast_fudge_factor</TD>
<TD>set the tq broadcasting fudge factor percentage</TD></TR>
<TR>
<TD>_px_granule_size</TD>
<TD>default size of a rowid range granule (in KB)</TD></TR>
<TR>
<TD>_px_index_sampling</TD>
<TD>parallel query sampling for index create (100000 = 100%)</TD></TR>
<TR>
<TD>_px_kxib_tracing</TD>
<TD>turn on kxib tracing</TD></TR>
<TR>
<TD>_px_load_publish_interval</TD>
<TD>interval at which LMON will check whether to publish PX load</TD></TR>
<TR>
<TD>_px_max_granules_per_slave</TD>
<TD>maximum number of rowid range granules to generate per slave</TD></TR>
<TR>
<TD>_px_min_granules_per_slave</TD>
<TD>minimum number of rowid range granules to generate per slave</TD></TR>
<TR>
<TD>_px_no_stealing</TD>
<TD>prevent parallel granule stealing in shared nothing environment</TD></TR>
<TR>
<TD>_query_cost_rewrite</TD>
<TD>perform the cost based rewrite with materialized views</TD></TR>
<TR>
<TD>_query_rewrite_2</TD>
<TD>perform query rewrite before&amp;after or only after view merging</TD></TR>
<TR>
<TD>_query_rewrite_expression</TD>
<TD>rewrite with cannonical form for expressions</TD></TR>
<TR>
<TD>_query_rewrite_fudge</TD>
<TD>cost based query rewrite with MVs fudge factor</TD></TR>
<TR>
<TD>_query_rewrite_vop_cleanup</TD>
<TD>prune frocol chain before rewrite after view-merging</TD></TR>
<TR>
<TD>_release_insert_threshold</TD>
<TD>maximum number of unusable blocks to unlink from freelist</TD></TR>
<TR>
<TD>_reuse_index_loop</TD>
<TD>number of blocks being examine for index block reuse</TD></TR>
<TR>
<TD>_rollback_segment_count</TD>
<TD>number of undo segments</TD></TR>
<TR>
<TD>_rollback_segment_initial</TD>
<TD>starting undo segment number</TD></TR>
<TR>
<TD>_row_cache_buffer_size</TD>
<TD>size of row cache circular buffer</TD></TR>
<TR>
<TD>_row_cache_cursors</TD>
<TD>number of cached cursors for row cache management</TD></TR>
<TR>
<TD>_row_cache_instance_locks</TD>
<TD>number of row cache instance locks</TD></TR>
<TR>
<TD>_scn_scheme</TD>
<TD>SCN scheme</TD></TR>
<TR>
<TD>_second_spare_parameter</TD>
<TD>second spare parameter - integer</TD></TR>
<TR>
<TD>_serial_direct_read</TD>
<TD>enable direct read in serial</TD></TR>
<TR>
<TD>_session_idle_bit_latches</TD>
<TD>one latch per session or a latch per group of sessions</TD></TR>
<TR>
<TD>_shared_pool_reserved_min_alloc</TD>
<TD>minimum allocation size in bytes for reserved area of shared poo</TD></TR>
<TR>
<TD>_single_process</TD>
<TD>run without detached processes</TD></TR>
<TR>
<TD>_small_table_threshold</TD>
<TD>threshold level of table size for forget-bit enabled during scan</TD></TR>
<TR>
<TD>_sort_elimination_cost_ratio</TD>
<TD>cost ratio for sort eimination under first_rows mode</TD></TR>
<TR>
<TD>_sort_space_for_write_buffers</TD>
<TD>tenths of sort_area_size devoted to direct write buffers</TD></TR>
<TR>
<TD>_sortmerge_inequality_join_off</TD>
<TD>turns off sort-merge join on inequality</TD></TR>
<TR>
<TD>_spin_count</TD>
<TD>Amount to spin waiting for a latch</TD></TR>
<TR>
<TD>_sql_connect_capability_override</TD>
<TD>SQL Connect Capability Table Override</TD></TR>
<TR>
<TD>_sql_connect_capability_table</TD>
<TD>SQL Connect Capability Table (testing only)</TD></TR>
<TR>
<TD>_sqlexec_progression_cost</TD>
<TD>sql execution progression monitoring cost threshold</TD></TR>
<TR>
<TD>_subquery_pruning_cost_factor</TD>
<TD>subquery pruning cost factor</TD></TR>
<TR>
<TD>_subquery_pruning_enabled</TD>
<TD>enable the use of subquery predicates to perform pruning</TD></TR>
<TR>
<TD>_subquery_pruning_reduction</TD>
<TD>subquery pruning reduction factor</TD></TR>
<TR>
<TD>_system_trig_enabled</TD>
<TD>system triggers are enabled</TD></TR>
<TR>
<TD>_table_scan_cost_plus_one</TD>
<TD>bump estimated full table scan cost by one</TD></TR>
<TR>
<TD>_temp_tran_block_threshold</TD>
<TD>number of blocks for a dimension before we temp transform</TD></TR>
<TR>
<TD>_temp_tran_cache</TD>
<TD>determines if temp table is created with cache option</TD></TR>
<TR>
<TD>_test_param_1</TD>
<TD>test parmeter 1</TD></TR>
<TR>
<TD>_test_param_2</TD>
<TD>test parameter 2</TD></TR>
<TR>
<TD>_test_param_3</TD>
<TD>test parameter 3</TD></TR>
<TR>
<TD>_third_spare_parameter</TD>
<TD>third spare parameter - integer</TD></TR>
<TR>
<TD>_tq_dump_period</TD>
<TD>time period for duping of TQ statistics (s)</TD></TR>
<TR>
<TD>_trace_archive_dest</TD>
<TD>trace archival destination</TD></TR>
<TR>
<TD>_trace_archive_start</TD>
<TD>start trace process on SGA initialization</TD></TR>
<TR>
<TD>_trace_block_size</TD>
<TD>trace block size</TD></TR>
<TR>
<TD>_trace_buffer_flushes</TD>
<TD>trace buffer flushes if otrace cacheIO event is set</TD></TR>
<TR>
<TD>_trace_buffer_gets</TD>
<TD>trace kcb buffer gets if otrace cacheIO event is set</TD></TR>
<TR>
<TD>_trace_buffers_per_process</TD>
<TD>trace buffers per process</TD></TR>
<TR>
<TD>_trace_cr_buffer_creates</TD>
<TD>trace cr buffer creates if otrace cacheIO event is set</TD></TR>
<TR>
<TD>_trace_enabled</TD>
<TD>Should tracing be enabled at startup</TD></TR>
<TR>
<TD>_trace_events</TD>
<TD>turns on and off trace events</TD></TR>
<TR>
<TD>_trace_file_size</TD>
<TD>trace file size</TD></TR>
<TR>
<TD>_trace_files_public</TD>
<TD>Create publicly accessible trace files</TD></TR>
<TR>
<TD>_trace_flushing</TD>
<TD>TRWR should try to keep tracing buffers clean</TD></TR>
<TR>
<TD>_trace_instance_termination</TD>
<TD>trace instance termination actions</TD></TR>
<TR>
<TD>_trace_multi_block_reads</TD>
<TD>trace multi_block reads if otrace cacheIO event is set</TD></TR>
<TR>
<TD>_trace_write_batch_size</TD>
<TD>trace write batch size</TD></TR>
<TR>
<TD>_transaction_recovery_servers</TD>
<TD>max number of parallel recovery slaves that may be used</TD></TR>
<TR>
<TD>_tts_allow_nchar_mismatch</TD>
<TD>allow plugging in a tablespace with a different national charact</TD></TR>
<TR>
<TD>_unnest_subquery</TD>
<TD>enables unnesting of correlated subqueries</TD></TR>
<TR>
<TD>_use_column_stats_for_function</TD>
<TD>enable the use of column statistics for DDP functions</TD></TR>
<TR>
<TD>_use_ism</TD>
<TD>Enable Shared Page Tables - ISM</TD></TR>
<TR>
<TD>_use_nosegment_indexes</TD>
<TD>use nosegment indexes in explain plan</TD></TR>
<TR>
<TD>_use_vector_post</TD>
<TD>use vector post</TD></TR>
<TR>
<TD>_wait_for_sync</TD>
<TD>wait for sync on commit MUST BE ALWAYS TRUE</TD></TR>
<TR>
<TD>_walk_insert_threshold</TD>
<TD>maximum number of unusable blocks to walk across freelist</TD></TR>
<TR>
<TD>_write_clones</TD>
<TD>write clones flag</TD></TR>
<TR>
<TD>_yield_check_interval</TD>
<TD>interval to check whether actses should yield</TD></TR>
<TR>
<TD>active_instance_count</TD>
<TD>number of active instances in the parallel server</TD></TR>
<TR>
<TD>always_anti_join</TD>
<TD>always use this method for anti-join when possible</TD></TR>
<TR>
<TD>always_semi_join</TD>
<TD>always use this method for semi-join when possible</TD></TR>
<TR>
<TD>aq_tm_processes</TD>
<TD>number of AQ Time Managers to start</TD></TR>
<TR>
<TD>audit_file_dest</TD>
<TD>Directory in which auditing files are to reside</TD></TR>
<TR>
<TD>audit_trail</TD>
<TD>enable system auditing</TD></TR>
<TR>
<TD>background_core_dump</TD>
<TD>Core Size for Background Processes</TD></TR>
<TR>
<TD>background_dump_dest</TD>
<TD>Detached process dump directory</TD></TR>
<TR>
<TD>backup_tape_io_slaves</TD>
<TD>BACKUP Tape I/O slaves</TD></TR>
<TR>
<TD>bitmap_merge_area_size</TD>
<TD>maximum memory allow for BITMAP MERGE</TD></TR>
<TR>
<TD>blank_trimming</TD>
<TD>blank trimming semantics parameter</TD></TR>
<TR>
<TD>buffer_pool_keep</TD>
<TD>Number of database blocks/latches in keep buffer pool</TD></TR>
<TR>
<TD>buffer_pool_recycle</TD>
<TD>Number of database blocks/latches in recycle buffer pool</TD></TR>
<TR>
<TD>commit_point_strength</TD>
<TD>Bias this node has toward not preparing in a two-phase commit</TD></TR>
<TR>
<TD>compatible</TD>
<TD>Database will be completely compatible with this software versio</TD></TR>
<TR>
<TD>control_file_record_keep_time</TD>
<TD>control file record keep time in days</TD></TR>
<TR>
<TD>control_files</TD>
<TD>control file names list</TD></TR>
<TR>
<TD>core_dump_dest</TD>
<TD>Core dump directory</TD></TR>
<TR>
<TD>cpu_count</TD>
<TD>number of cpu's for this instance</TD></TR>
<TR>
<TD>create_bitmap_area_size</TD>
<TD>size of create bitmap buffer for bitmap index</TD></TR>
<TR>
<TD>cursor_sharing</TD>
<TD>cursor sharing mode</TD></TR>
<TR>
<TD>cursor_space_for_time</TD>
<TD>use more memory in order to get faster execution</TD></TR>
<TR>
<TD>db_block_buffers</TD>
<TD>Number of database blocks cached in memory</TD></TR>
<TR>
<TD>db_block_checking</TD>
<TD>data and index block checking</TD></TR>
<TR>
<TD>db_block_checksum</TD>
<TD>store checksum in db blocks and check during reads</TD></TR>
<TR>
<TD>db_block_lru_latches</TD>
<TD>number of lru latches</TD></TR>
<TR>
<TD>db_block_max_dirty_target</TD>
<TD>Upper bound on modified buffers/recovery reads</TD></TR>
<TR>
<TD>db_block_size</TD>
<TD>Size of database block in bytes</TD></TR>
<TR>
<TD>db_domain</TD>
<TD>directory part of global database name stored with CREATE DATABA</TD></TR>
<TR>
<TD>db_file_direct_io_count</TD>
<TD>Sequential I/O block count</TD></TR>
<TR>
<TD>db_file_multiblock_read_count</TD>
<TD>db block to be read each IO</TD></TR>
<TR>
<TD>db_file_name_convert</TD>
<TD>datafile name convert pattern and string for standby/clone datab</TD></TR>
<TR>
<TD>db_files</TD>
<TD>max allowable # db files</TD></TR>
<TR>
<TD>db_name</TD>
<TD>database name specified in CREATE DATABASE</TD></TR>
<TR>
<TD>db_writer_processes</TD>
<TD>number of background database writer processes to start</TD></TR>
<TR>
<TD>dblink_encrypt_login</TD>
<TD>enforce password for distributed login always be encrypted</TD></TR>
<TR>
<TD>dbwr_io_slaves</TD>
<TD>DBWR I/O slaves</TD></TR>
<TR>
<TD>disk_asynch_io</TD>
<TD>Use asynch I/O for random access devices</TD></TR>
<TR>
<TD>distributed_transactions</TD>
<TD>max. number of concurrent distributed transactions</TD></TR>
<TR>
<TD>dml_locks</TD>
<TD>dml locks - one for each table modified in a transaction</TD></TR>
<TR>
<TD>enqueue_resources</TD>
<TD>resources for enqueues</TD></TR>
<TR>
<TD>event</TD>
<TD>debug event control - default null string</TD></TR>
<TR>
<TD>fast_start_io_target</TD>
<TD>Upper bound on recovery reads</TD></TR>
<TR>
<TD>fast_start_parallel_rollback</TD>
<TD>max number of parallel recovery slaves that may be used</TD></TR>
<TR>
<TD>fixed_date</TD>
<TD>fixed SYSDATE value</TD></TR>
<TR>
<TD>gc_defer_time</TD>
<TD>how long to defer down converts for hot buffers (DFS)</TD></TR>
<TR>
<TD>gc_files_to_locks</TD>
<TD>mapping between file numbers and lock buckets (DFS)</TD></TR>
<TR>
<TD>gc_releasable_locks</TD>
<TD>number of releasable locks (DFS)</TD></TR>
<TR>
<TD>gc_rollback_locks</TD>
<TD>locks for the rollback segments (DFS)</TD></TR>
<TR>
<TD>global_names</TD>
<TD>enforce that database links have same name as remote database</TD></TR>
<TR>
<TD>hash_area_size</TD>
<TD>size of in-memory hash work area</TD></TR>
<TR>
<TD>hash_join_enabled</TD>
<TD>enable/disable hash join</TD></TR>
<TR>
<TD>hash_multiblock_io_count</TD>
<TD>number of blocks hash join will read/write at once</TD></TR>
<TR>
<TD>hi_shared_memory_address</TD>
<TD>SGA starting address (high order 32-bits on 64-bit platforms)</TD></TR>
<TR>
<TD>hs_autoregister</TD>
<TD>enable automatic server DD updates in HS agent self-registration</TD></TR>
<TR>
<TD>ifile</TD>
<TD>include file in init.ora</TD></TR>
<TR>
<TD>instance_groups</TD>
<TD>list of instance group names</TD></TR>
<TR>
<TD>instance_name</TD>
<TD>instance name supported by the instance</TD></TR>
<TR>
<TD>instance_number</TD>
<TD>instance number</TD></TR>
<TR>
<TD>java_max_sessionspace_size</TD>
<TD>max allowed size in bytes of a Java sessionspace</TD></TR>
<TR>
<TD>java_pool_size</TD>
<TD>size in bytes of the Java pool</TD></TR>
<TR>
<TD>java_soft_sessionspace_limit</TD>
<TD>warning limit on size in bytes of a Java sessionspace</TD></TR>
<TR>
<TD>job_queue_interval</TD>
<TD>Wakeup interval in seconds for job queue processes</TD></TR>
<TR>
<TD>job_queue_processes</TD>
<TD>number of job queue processes to start</TD></TR>
<TR>
<TD>large_pool_size</TD>
<TD>size in bytes of the large allocation pool</TD></TR>
<TR>
<TD>license_max_sessions</TD>
<TD>maximum number of non-system user sessions allowed</TD></TR>
<TR>
<TD>license_max_users</TD>
<TD>maximum number of named users that can be created in the databas</TD></TR>
<TR>
<TD>license_sessions_warning</TD>
<TD>warning level for number of non-system user sessions</TD></TR>
<TR>
<TD>lm_locks</TD>
<TD>number of locks configured for the lock manager</TD></TR>
<TR>
<TD>lm_ress</TD>
<TD>number of resources configured for the lock manager</TD></TR>
<TR>
<TD>local_listener</TD>
<TD>local listener</TD></TR>
<TR>
<TD>lock_name_space</TD>
<TD>lock name space used for generating lock names for standby/clone</TD></TR>
<TR>
<TD>lock_sga</TD>
<TD>Lock entire SGA in physical memory</TD></TR>
<TR>
<TD>log_archive_dest</TD>
<TD>archival destination text string</TD></TR>
<TR>
<TD>log_archive_dest_1</TD>
<TD>archival destination #1 text string</TD></TR>
<TR>
<TD>log_archive_dest_2</TD>
<TD>archival destination #2 text string</TD></TR>
<TR>
<TD>log_archive_dest_3</TD>
<TD>archival destination #3 text string</TD></TR>
<TR>
<TD>log_archive_dest_4</TD>
<TD>archival destination #4 text string</TD></TR>
<TR>
<TD>log_archive_dest_5</TD>
<TD>archival destination #5 text string</TD></TR>
<TR>
<TD>log_archive_dest_state_1</TD>
<TD>archival destination #1 state text string</TD></TR>
<TR>
<TD>log_archive_dest_state_2</TD>
<TD>archival destination #2 state text string</TD></TR>
<TR>
<TD>log_archive_dest_state_3</TD>
<TD>archival destination #3 state text string</TD></TR>
<TR>
<TD>log_archive_dest_state_4</TD>
<TD>archival destination #4 state text string</TD></TR>
<TR>
<TD>log_archive_dest_state_5</TD>
<TD>archival destination #5 state text string</TD></TR>
<TR>
<TD>log_archive_duplex_dest</TD>
<TD>duplex archival destination text string</TD></TR>
<TR>
<TD>log_archive_format</TD>
<TD>archival destination format</TD></TR>
<TR>
<TD>log_archive_max_processes</TD>
<TD>maximum number of active ARCH processes</TD></TR>
<TR>
<TD>log_archive_min_succeed_dest</TD>
<TD>minimum number of archive destinations that must succeed</TD></TR>
<TR>
<TD>log_archive_start</TD>
<TD>start archival process on SGA initialization</TD></TR>
<TR>
<TD>log_archive_trace</TD>
<TD>Establish archivelog operation tracing level</TD></TR>
<TR>
<TD>log_buffer</TD>
<TD>redo circular buffer size</TD></TR>
<TR>
<TD>log_checkpoint_interval</TD>
<TD># redo blocks checkpoint threshold</TD></TR>
<TR>
<TD>log_checkpoint_timeout</TD>
<TD>Maximum time interval between checkpoints in seconds</TD></TR>
<TR>
<TD>log_checkpoints_to_alert</TD>
<TD>log checkpoint begin/end to alert file</TD></TR>
<TR>
<TD>log_file_name_convert</TD>
<TD>logfile name convert pattern and string for standby/clone databa</TD></TR>
<TR>
<TD>max_commit_propagation_delay</TD>
<TD>Max age of new snapshot in .01 seconds</TD></TR>
<TR>
<TD>max_dump_file_size</TD>
<TD>Maximum size (blocks) of dump file</TD></TR>
<TR>
<TD>max_enabled_roles</TD>
<TD>max number of roles a user can have enabled</TD></TR>
<TR>
<TD>max_rollback_segments</TD>
<TD>max. number of rollback segments in SGA cache</TD></TR>
<TR>
<TD>mts_circuits</TD>
<TD>max number of mts circuits</TD></TR>
<TR>
<TD>mts_dispatchers</TD>
<TD>specifications of dispatchers</TD></TR>
<TR>
<TD>mts_listener_address</TD>
<TD>address(es) of network listener</TD></TR>
<TR>
<TD>mts_max_dispatchers</TD>
<TD>max number of dispatchers</TD></TR>
<TR>
<TD>mts_max_servers</TD>
<TD>max number of servers</TD></TR>
<TR>
<TD>mts_multiple_listeners</TD>
<TD>Are multiple listeners enabled?</TD></TR>
<TR>
<TD>mts_servers</TD>
<TD>number of servers to start up</TD></TR>
<TR>
<TD>mts_service</TD>
<TD>service supported by dispatchers</TD></TR>
<TR>
<TD>mts_sessions</TD>
<TD>max number of mts sessions</TD></TR>
<TR>
<TD>nls_calendar</TD>
<TD>NLS calendar system name</TD></TR>
<TR>
<TD>nls_comp</TD>
<TD>NLS comparison</TD></TR>
<TR>
<TD>nls_currency</TD>
<TD>NLS local currency symbol</TD></TR>
<TR>
<TD>nls_date_format</TD>
<TD>NLS Oracle date format</TD></TR>
<TR>
<TD>nls_date_language</TD>
<TD>NLS date language name</TD></TR>
<TR>
<TD>nls_dual_currency</TD>
<TD>Dual currency symbol</TD></TR>
<TR>
<TD>nls_iso_currency</TD>
<TD>NLS ISO currency territory name</TD></TR>
<TR>
<TD>nls_language</TD>
<TD>NLS language name</TD></TR>
<TR>
<TD>nls_numeric_characters</TD>
<TD>NLS numeric characters</TD></TR>
<TR>
<TD>nls_sort</TD>
<TD>NLS linguistic definition name</TD></TR>
<TR>
<TD>nls_territory</TD>
<TD>NLS territory name</TD></TR>
<TR>
<TD>nls_time_format</TD>
<TD>time format</TD></TR>
<TR>
<TD>nls_time_tz_format</TD>
<TD>time with timezone format</TD></TR>
<TR>
<TD>nls_timestamp_format</TD>
<TD>time stamp format</TD></TR>
<TR>
<TD>nls_timestamp_tz_format</TD>
<TD>timestampe with timezone format</TD></TR>
<TR>
<TD>object_cache_max_size_percent</TD>
<TD>percentage of maximum size over optimal of the user session's ob</TD></TR>
<TR>
<TD>object_cache_optimal_size</TD>
<TD>optimal size of the user session's object cache in bytes</TD></TR>
<TR>
<TD>open_cursors</TD>
<TD>max # cursors per process</TD></TR>
<TR>
<TD>open_links</TD>
<TD>max # open links per session</TD></TR>
<TR>
<TD>open_links_per_instance</TD>
<TD>max # open links per instance</TD></TR>
<TR>
<TD>ops_interconnects</TD>
<TD>interconnects for ops use</TD></TR>
<TR>
<TD>optimizer_features_enable</TD>
<TD>optimizer plan compatibility parameter</TD></TR>
<TR>
<TD>optimizer_index_caching</TD>
<TD>optimizer percent index caching</TD></TR>
<TR>
<TD>optimizer_index_cost_adj</TD>
<TD>optimizer index cost adjustment</TD></TR>
<TR>
<TD>optimizer_max_permutations</TD>
<TD>optimizer maximum join permutations per query block</TD></TR>
<TR>
<TD>optimizer_mode</TD>
<TD>optimizer mode</TD></TR>
<TR>
<TD>optimizer_percent_parallel</TD>
<TD>optimizer percent parallel</TD></TR>
<TR>
<TD>oracle_trace_collection_name</TD>
<TD>Oracle TRACE default collection name</TD></TR>
<TR>
<TD>oracle_trace_collection_path</TD>
<TD>Oracle TRACE collection path</TD></TR>
<TR>
<TD>oracle_trace_collection_size</TD>
<TD>Oracle TRACE collection file max. size</TD></TR>
<TR>
<TD>oracle_trace_enable</TD>
<TD>Oracle Trace enabled/disabled</TD></TR>
<TR>
<TD>oracle_trace_facility_name</TD>
<TD>Oracle TRACE default facility name</TD></TR>
<TR>
<TD>oracle_trace_facility_path</TD>
<TD>Oracle TRACE facility path</TD></TR>
<TR>
<TD>os_authent_prefix</TD>
<TD>prefix for auto-logon accounts</TD></TR>
<TR>
<TD>os_roles</TD>
<TD>retrieve roles from the operating system</TD></TR>
<TR>
<TD>parallel_adaptive_multi_user</TD>
<TD>enable adaptive setting of degree for multiple user streams</TD></TR>
<TR>
<TD>parallel_automatic_tuning</TD>
<TD>enable intelligent defaults for parallel execution parameters</TD></TR>
<TR>
<TD>parallel_broadcast_enabled</TD>
<TD>enable broadcasting of small inputs to hash and sort merge joins</TD></TR>
<TR>
<TD>parallel_execution_message_size</TD>
<TD>message buffer size for parallel execution</TD></TR>
<TR>
<TD>parallel_instance_group</TD>
<TD>instance group to use for all parallel operations</TD></TR>
<TR>
<TD>parallel_max_servers</TD>
<TD>maximum parallel query servers per instance</TD></TR>
<TR>
<TD>parallel_min_percent</TD>
<TD>minimum percent of threads required for parallel query</TD></TR>
<TR>
<TD>parallel_min_servers</TD>
<TD>minimum parallel query servers per instance</TD></TR>
<TR>
<TD>parallel_server</TD>
<TD>if TRUE startup in parallel server mode</TD></TR>
<TR>
<TD>parallel_server_instances</TD>
<TD>number of instances to use for sizing OPS SGA structures</TD></TR>
<TR>
<TD>parallel_threads_per_cpu</TD>
<TD>number of parallel execution threads per CPU</TD></TR>
<TR>
<TD>partition_view_enabled</TD>
<TD>enable/disable partitioned views</TD></TR>
<TR>
<TD>plsql_v2_compatibility</TD>
<TD>PL/SQL version 2.x compatibility flag</TD></TR>
<TR>
<TD>pre_page_sga</TD>
<TD>pre-page sga for process</TD></TR>
<TR>
<TD>processes</TD>
<TD>user processes</TD></TR>
<TR>
<TD>query_rewrite_enabled</TD>
<TD>allow rewrite of queries using materialized views if enabled</TD></TR>
<TR>
<TD>query_rewrite_integrity</TD>
<TD>perform rewrite using materialized views with desired integrity</TD></TR>
<TR>
<TD>rdbms_server_dn</TD>
<TD>RDBMS's Distinguished Name</TD></TR>
<TR>
<TD>read_only_open_delayed</TD>
<TD>if TRUE delay opening of read only files until first access</TD></TR>
<TR>
<TD>recovery_parallelism</TD>
<TD>number of server processes to use for parallel recovery</TD></TR>
<TR>
<TD>remote_dependencies_mode</TD>
<TD>remote-procedure-call dependencies mode parameter</TD></TR>
<TR>
<TD>remote_login_passwordfile</TD>
<TD>password file usage parameter</TD></TR>
<TR>
<TD>remote_os_authent</TD>
<TD>allow non-secure remote clients to use auto-logon accounts</TD></TR>
<TR>
<TD>remote_os_roles</TD>
<TD>allow non-secure remote clients to use os roles</TD></TR>
<TR>
<TD>replication_dependency_tracking</TD>
<TD>tracking dependency for Replication parallel propagation</TD></TR>
<TR>
<TD>resource_limit</TD>
<TD>master switch for resource limit</TD></TR>
<TR>
<TD>resource_manager_plan</TD>
<TD>resource mgr top plan</TD></TR>
<TR>
<TD>rollback_segments</TD>
<TD>undo segment list</TD></TR>
<TR>
<TD>row_locking</TD>
<TD>row-locking</TD></TR>
<TR>
<TD>serial_reuse</TD>
<TD>reuse the frame segments</TD></TR>
<TR>
<TD>serializable</TD>
<TD>serializable</TD></TR>
<TR>
<TD>service_names</TD>
<TD>service names supported by the instance</TD></TR>
<TR>
<TD>session_cached_cursors</TD>
<TD>number of cursors to save in the session cursor cache</TD></TR>
<TR>
<TD>session_max_open_files</TD>
<TD>maximum number of open files allowed per session</TD></TR>
<TR>
<TD>sessions</TD>
<TD>user and system sessions</TD></TR>
<TR>
<TD>shadow_core_dump</TD>
<TD>Core Size for Shadow Processes</TD></TR>
<TR>
<TD>shared_memory_address</TD>
<TD>SGA starting address (low order 32-bits on 64-bit platforms)</TD></TR>
<TR>
<TD>shared_pool_reserved_size</TD>
<TD>size in bytes of reserved area of shared pool</TD></TR>
<TR>
<TD>shared_pool_size</TD>
<TD>size in bytes of shared pool</TD></TR>
<TR>
<TD>sort_area_retained_size</TD>
<TD>size of in-memory sort work area retained between fetch calls</TD></TR>
<TR>
<TD>sort_area_size</TD>
<TD>size of in-memory sort work area</TD></TR>
<TR>
<TD>sort_multiblock_read_count</TD>
<TD>multi-block read count for sort</TD></TR>
<TR>
<TD>sql92_security</TD>
<TD>require select privilege for searched update/delete</TD></TR>
<TR>
<TD>sql_trace</TD>
<TD>enable SQL trace</TD></TR>
<TR>
<TD>sql_version</TD>
<TD>sql language version parameter for compatibility issues</TD></TR>
<TR>
<TD>standby_archive_dest</TD>
<TD>standby database archivelog destination text string</TD></TR>
<TR>
<TD>star_transformation_enabled</TD>
<TD>enable the use of star transformation</TD></TR>
<TR>
<TD>tape_asynch_io</TD>
<TD>Use asynch I/O requests for tape devices</TD></TR>
<TR>
<TD>text_enable</TD>
<TD>enable text searching</TD></TR>
<TR>
<TD>thread</TD>
<TD>Redo thread to mount</TD></TR>
<TR>
<TD>timed_os_statistics</TD>
<TD>internal os statistic gathering interval in seconds</TD></TR>
<TR>
<TD>timed_statistics</TD>
<TD>maintain internal timing statistics</TD></TR>
<TR>
<TD>tracefile_identifier</TD>
<TD>trace file custom identifier</TD></TR>
<TR>
<TD>transaction_auditing</TD>
<TD>transaction auditing records generated in the redo log</TD></TR>
<TR>
<TD>transactions</TD>
<TD>max. number of concurrent active transactions</TD></TR>
<TR>
<TD>transactions_per_rollback_segment</TD>
<TD>number of active transactions per rollback segment</TD></TR>
<TR>
<TD>use_indirect_data_buffers</TD>
<TD>Enable indirect data buffers (very large SGA on 32-bit platforms</TD></TR>
<TR>
<TD>user_dump_dest</TD>
<TD>User process dump directory</TD></TR>
<TR>
<TD>utl_file_dir</TD>
<TD>utl_file accessible directories list</TD></TR></TBODY></TABLE>
  
</ul>


<p>&nbsp;</p>


</body>
</html>