fT = gFld("<i>Overview</i>", "/orb/jsp/oracle/Overview-Database.jsp?sid=DDW")

	aux1 = insFld(fT, gFld("192.168.1", "http://www.yahoo.com"))
	
		aux2 = insFld(aux1, gFld("collection-qa", "/orb/jsp/sys/UnixOverview1.jsp?machine=collection-qa"))
			insDoc(aux2, gLnk("DVLMS", "/orb/jsp/sys/Overview.jsp?sid=DVLMS"))
			insDoc(aux2, gLnk("QALMS", "/orb/jsp/sys/Overview.jsp?sid=QALMS"))

		aux2 = insFld(aux1, gFld("gino", "/orb/jsp/sys/UnixOverview1.jsp?machine=gino"))
			insDoc(aux2, gLnk("PDLMS", "/orb/jsp/sys/Overview.jsp?sid=PDLMS"))

		aux2 = insFld(aux1, gFld("devdcx", "/orb/jsp/sys/UnixOverview1.jsp?machine=devdcx"))
			insDoc(aux2, gLnk("DDW", "/orb/jsp/sys/Overview.jsp?sid=DDW"))
			insDoc(aux2, gLnk("PRODLIMS", "/orb/jsp/sys/Overview.jsp?sid=PRODLIMS"))
			
		aux2 = insFld(aux1, gFld("cchouxp", "/orb/jsp/sys/UnixOverview1.jsp?machine=cchouxp"))
			insDoc(aux2, gLnk("CCHOUXP", "/orb/jsp/sys/Overview.jsp?sid=CCHOUXP"))

		aux2 = insFld(aux1, gFld("dnareports", ""))
			insDoc(aux2, gLnk("ORCL", "/orb/jsp/sys/Overview.jsp?sid=ORCL"))


	GENERAL_INFO = insFld(fT, gFld("General Server Information", ""))
		DATABASE = insFld(GENERAL_INFO, gFld("Database", ""))
			insDoc(DATABASE, gLnk("Database Information", "/orb/jsp/oracle/info/DBInfo.jsp"))

			INIT_PARAM = insFld(DATABASE, gFld("Init Parameters", ""))
				insDoc(INIT_PARAM, gLnk("Parameters", "/orb/jsp/oracle/Generic-sys.jsp?sqlTag=DB_INIT_PARAM"))
				insDoc(INIT_PARAM, gLnk("Non-Default", ""))				
				insDoc(INIT_PARAM, gLnk("Description", ""))
				insDoc(INIT_PARAM, gLnk("UnDocument", ""))
				insDoc(INIT_PARAM, gLnk("System Modifiable", ""))
				insDoc(INIT_PARAM, gLnk("Session Modifiable", ""))
				
		INSTANCE = insFld(GENERAL_INFO, gFld("Instance", ""))
			insDoc(INSTANCE, gLnk("Background Processes", ""))
			insDoc(INSTANCE, gLnk("SGA", ""))
			insDoc(INSTANCE, gLnk("System Statistics", ""))
			
		CONTROL_FILE = insFld(GENERAL_INFO, gFld("Control File", ""))
			insDoc(CONTROL_FILE, gLnk("Info", ""))
			
		LOG = insFld(GENERAL_INFO, gFld("Log", ""))
			insDoc(LOG, gLnk("Redo Logs", ""))
			insDoc(LOG, gLnk("Log History", ""))
			insDoc(LOG, gLnk("Buffer Allocation Retry", ""))
			insDoc(LOG, gLnk("Archive", ""))

	USER_INFO = insFld(fT, gFld("User Information", ""))
		insDoc(USER_INFO, gLnk("Session Info", ""))
		insDoc(USER_INFO, gLnk("Session Stat", ""))
		insDoc(USER_INFO, gLnk("Open Cursor", ""))
		insDoc(USER_INFO, gLnk("Session Cursor Cache", ""))
		insDoc(USER_INFO, gLnk("System Cursor Cache", ""))
		insDoc(USER_INFO, gLnk("User SQL", ""))
		insDoc(USER_INFO, gLnk("Problem SQL", ""))
		insDoc(USER_INFO, gLnk("User Lock", ""))
		insDoc(USER_INFO, gLnk("User Lock Detail", ""))
		insDoc(USER_INFO, gLnk("User In RBS", ""))
		insDoc(USER_INFO, gLnk("Lock in RBS", ""))
		
	CUP = insFld(fT, gFld("CPU", ""))
		REPARSING = insFld(CUP, gFld("Reparsing", ""))
			insDoc(REPARSING, gLnk("Counts", ""))
			insDoc(REPARSING, gLnk("SQL", ""))
			insDoc(REPARSING, gLnk("High Buffer Gets", ""))
			insDoc(REPARSING, gLnk("Session CPU", ""))
			
		BUFFER_SCAN = insFld(CUP, gFld("Buffer Scan", ""))
			insDoc(BUFFER_SCAN, gLnk("Average", ""))
			
		EVENT_WAIT = insFld(CUP, gFld("Event Wait", ""))
			insDoc(EVENT_WAIT, gLnk("Detection", ""))
			insDoc(EVENT_WAIT, gLnk("User", ""))
			insDoc(EVENT_WAIT, gLnk("Background", ""))
			

	MEMORY = insFld(fT, gFld("Memory", ""))
		SGA = insFld(MEMORY, gFld("Log", ""))
			insDoc(SGA, gLnk("SGA", ""))
			insDoc(SGA, gLnk("SGA Detail", ""))
			
		DETAIL = insFld(MEMORY, gFld("Detail", ""))
			insDoc(DETAIL, gLnk("Redo Buffer", ""))
			
			VARIALBE = insFld(DETAIL, gFld("Variable Size", ""))
				SHARED_POOL = insFld(VARIALBE, gFld("Shared Pool", ""))
					insDoc(SHARED_POOL, gLnk("Dictionary", ""))
					insDoc(SHARED_POOL, gLnk("Library", ""))
					insDoc(SHARED_POOL, gLnk("Reserved", ""))
					
				PRIVATE_SQL = insFld(VARIALBE, gFld("Private SQL", ""))
					insDoc(PRIVATE_SQL, gLnk("Reparsing", ""))
					insDoc(PRIVATE_SQL, gLnk("Who", ""))
					
				SESSION_CACHE_CURSOR = insFld(VARIALBE, gFld("Session Cache Cursor", ""))

	IO = insFld(fT, gFld("I/O", ""))
		SPACE_MANAGEMENT = insFld(IO, gFld("Space Management", ""))
			TABLESPACE = insFld(SPACE_MANAGEMENT, gFld("Tablespace", ""))
				insDoc(TABLESPACE, gLnk("Size & Status", ""))
				insDoc(TABLESPACE, gLnk("Parameters", ""))
				insDoc(TABLESPACE, gLnk("Free Space", ""))

			DATA_FILE = insFld(SPACE_MANAGEMENT, gFld("Data File", ""))
				insDoc(DATA_FILE, gLnk("Size & Status", ""))
				insDoc(DATA_FILE, gLnk("Free Space", ""))

			EXTENT = insFld(SPACE_MANAGEMENT, gFld("Extent", ""))
				insDoc(EXTENT, gLnk("Extent", ""))
				insDoc(EXTENT, gLnk("Fragmentated?", ""))

			OBJECT = insFld(SPACE_MANAGEMENT, gFld("Extent", ""))
				insDoc(OBJECT, gLnk("Size", ""))
				
		LOAD_DISTRIBUTION = insFld(IO, gFld("Load Distribution", ""))	
			insDoc(LOAD_DISTRIBUTION, gLnk("File Location", ""))
			insDoc(LOAD_DISTRIBUTION, gLnk("Move Data File", ""))
			insDoc(LOAD_DISTRIBUTION, gLnk("Contention?", ""))
			
		insDoc(IO, gLnk("Table Scan", ""))			
		insDoc(IO, gLnk("Data & Index Contention", ""))			
		
		PARTITION = insFld(IO, gFld("Partition", ""))	
			insDoc(PARTITION, gLnk("Partition", ""))
		
		FRAGMENTATION = insFld(IO, gFld("Fragmentation", ""))	
			insDoc(FRAGMENTATION, gLnk("Fragmentated?", ""))
			insDoc(FRAGMENTATION, gLnk("Use Proper Size", ""))
			insDoc(FRAGMENTATION, gLnk("Create New Table & Move Data", ""))
			insDoc(FRAGMENTATION, gLnk("Export, Compress, & Import", ""))
			insDoc(FRAGMENTATION, gLnk("Increase Extent Size", ""))

		ROW_CHAIN = insFld(IO, gFld("Row Chain", ""))	

		LOG_CONTENTION = insFld(IO, gFld("Log Contention", ""))	
			insDoc(LOG_CONTENTION, gLnk("Log Info", ""))
			insDoc(LOG_CONTENTION, gLnk("Last 100 Logs", ""))
			insDoc(LOG_CONTENTION, gLnk("Some commands", ""))
			
		SORTING = insFld(IO, gFld("Sorting", ""))	
			insDoc(SORTING, gLnk("Parameters", ""))
			insDoc(SORTING, gLnk("When", ""))
			insDoc(SORTING, gLnk("Where", ""))
			insDoc(SORTING, gLnk("What TS", ""))
		
		RBS = insFld(IO, gFld("RBS", ""))
		
		CONTROL_FILE = insFld(IO, gFld("Control File", ""))	


	SPACE = insFld(fT, gFld("Space Management", ""))
		insDoc(SPACE, gLnk("Object Counts/User", ""))
		insDoc(SPACE, gLnk("Space Usage/User", ""))
		insDoc(SPACE, gLnk("TS Usage & Free Space", ""))
		insDoc(SPACE, gLnk("Obj Size Summary By Type", ""))
		insDoc(SPACE, gLnk("Big Objs", ""))
		insDoc(SPACE, gLnk("Fragmented Objs", ""))
		insDoc(SPACE, gLnk("Blook Needed/Table", ""))
		insDoc(SPACE, gLnk("Extent Summary/User", ""))
		FREE_SPACE = insFld(SPACE, gFld("Free Space", ""))
			insDoc(FREE_SPACE, gLnk("Inside TS", ""))
			insDoc(FREE_SPACE, gLnk("Inside Data File", ""))
			insDoc(FREE_SPACE, gLnk("Coalesce", ""))
		insDoc(SPACE, gLnk("TS, Data File, & Free Space", ""))
		insDoc(SPACE, gLnk("Data File Map", ""))
		insDoc(SPACE, gLnk("Tables & Indexes Per TS", ""))
		insDoc(SPACE, gLnk("Segment Extent By Owner Segment Name", ""))
		insDoc(SPACE, gLnk("Segment Extent By Owner", ""))


	CONTENTION = insFld(fT, gFld("Contention Management", ""))
		LATCHES = insFld(CONTENTION, gFld("Latches", ""))
			insDoc(LATCHES, gLnk("Overview", ""))
			insDoc(LATCHES, gLnk("Hit Ratio", ""))
			insDoc(LATCHES, gLnk("Process Hoding", ""))
			insDoc(LATCHES, gLnk("Process Waiting", ""))
			RBS = insFld(LATCHES, gFld("RBS", ""))
				insDoc(RBS, gLnk("Overview", ""))
				insDoc(RBS, gLnk("RBS", ""))
				insDoc(RBS, gLnk("Shrink", ""))
				insDoc(RBS, gLnk("Discrete", ""))
				insDoc(RBS, gLnk("Locks", ""))
			insDoc(LATCHES, gLnk("Redo Log Buffer", ""))
			insDoc(LATCHES, gLnk("LRU", ""))
			insDoc(LATCHES, gLnk("Free List", ""))
			insDoc(LATCHES, gLnk("Spin Count", ""))
			insDoc(LATCHES, gLnk("Who", ""))
			
		USER_LOCK = insFld(CONTENTION, gFld("User Lock", ""))
			insDoc(USER_LOCK, gLnk("Overview", ""))
			insDoc(USER_LOCK, gLnk("Who Locks Who", ""))
			insDoc(USER_LOCK, gLnk("Whos is doing What", ""))
			insDoc(USER_LOCK, gLnk("DDL", ""))
			insDoc(USER_LOCK, gLnk("DML", ""))
			
		ENQUEUE = insFld(CONTENTION, gFld("Enqueue", ""))
			insDoc(ENQUEUE, gLnk("Lock", ""))
			
	OBJECT = insFld(fT, gFld("Object Management", ""))
		