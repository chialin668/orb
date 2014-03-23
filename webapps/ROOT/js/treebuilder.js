foldersTree = gFld("<b>Overview</b>", "/orb/jsp/sys/Overview.jsp?sid=ORANT")

	aux1 = insFld(foldersTree, gFld("192.168.1", "http://www.yahoo.com"))
	
		aux2 = insFld(aux1, gFld("collection-qa", "/orb/jsp/sys/UnixOverview1.jsp?machine=collection-qa"))
			insDoc(aux2, gLnk(2, "DVLMS", "/orb/jsp/sys/Overview.jsp?sid=DVLMS"))
			insDoc(aux2, gLnk(2, "QALMS", "/orb/jsp/sys/Overview.jsp?sid=QALMS"))

		aux2 = insFld(aux1, gFld("gino", "/orb/jsp/sys/UnixOverview1.jsp?machine=gino"))
			insDoc(aux2, gLnk(2, "PDLMS", "/orb/jsp/sys/Overview.jsp?sid=PDLMS"))

		aux2 = insFld(aux1, gFld("devdcx", "/orb/jsp/sys/UnixOverview1.jsp?machine=devdcx"))
			insDoc(aux2, gLnk(2, "DDW", "/orb/jsp/sys/Overview.jsp?sid=DDW"))
			insDoc(aux2, gLnk(2, "PRODLIMS", "/orb/jsp/sys/Overview.jsp?sid=PRODLIMS"))
			
		aux2 = insFld(aux1, gFld("cchouxp", "/orb/jsp/sys/UnixOverview1.jsp?machine=cchouxp"))
			insDoc(aux2, gLnk(2, "CCHOUXP", "/orb/jsp/sys/Overview.jsp?sid=CCHOUXP"))

		aux2 = insFld(aux1, gFld("dnareports", ""))
			insDoc(aux2, gLnk(2, "ORCL", "/orb/jsp/sys/Overview.jsp?sid=ORCL"))

	aux1 = insFld(foldersTree, gFld("172.20.100", "http://www.yahoo.com"))
			aux2 = insFld(aux1, gFld("bioserv-gc", ""))
				insDoc(aux2, gLnk(2, "PGTL", "/orb/jsp/sys/Overview.jsp?sid=PGTL"))
				insDoc(aux2, gLnk(2, "VGTL", "/orb/jsp/sys/Overview.jsp?sid=VGTL"))



	GENERAL_INFO = insFld(foldersTree, gFld("General Server Information", ""))
		DATABASE = insFld(GENERAL_INFO, gFld("Database", ""))
			insDoc(DATABASE, gLnk(2, "Database Information", ""))

			INIT_PARAM = insFld(DATABASE, gFld("Init Parameters", ""))
				insDoc(INIT_PARAM, gLnk(2, "Parameters", ""))
				insDoc(INIT_PARAM, gLnk(2, "Non-Default", ""))				
				insDoc(INIT_PARAM, gLnk(2, "Description", ""))
				insDoc(INIT_PARAM, gLnk(2, "UnDocument", ""))
				insDoc(INIT_PARAM, gLnk(2, "System Modifiable", ""))
				insDoc(INIT_PARAM, gLnk(2, "Session Modifiable", ""))
				
		INSTANCE = insFld(GENERAL_INFO, gFld("Instance", ""))
			insDoc(INSTANCE, gLnk(2, "Background Processes", ""))
			insDoc(INSTANCE, gLnk(2, "SGA", ""))
			insDoc(INSTANCE, gLnk(2, "System Statistics", ""))
			
		CONTROL_FILE = insFld(GENERAL_INFO, gFld("Control File", ""))
			insDoc(CONTROL_FILE, gLnk(2, "Info", ""))
			
		LOG = insFld(GENERAL_INFO, gFld("Log", ""))
			insDoc(LOG, gLnk(2, "Redo Logs", ""))
			insDoc(LOG, gLnk(2, "Log History", ""))
			insDoc(LOG, gLnk(2, "Buffer Allocation Retry", ""))
			insDoc(LOG, gLnk(2, "Archive", ""))

	USER_INFO = insFld(foldersTree, gFld("User Information", ""))
		insDoc(USER_INFO, gLnk(2, "Session Info", ""))
		insDoc(USER_INFO, gLnk(2, "Session Stat", ""))
		insDoc(USER_INFO, gLnk(2, "Open Cursor", ""))
		insDoc(USER_INFO, gLnk(2, "Session Cursor Cache", ""))
		insDoc(USER_INFO, gLnk(2, "System Cursor Cache", ""))
		insDoc(USER_INFO, gLnk(2, "User SQL", ""))
		insDoc(USER_INFO, gLnk(2, "Problem SQL", ""))
		insDoc(USER_INFO, gLnk(2, "User Lock", ""))
		insDoc(USER_INFO, gLnk(2, "User Lock Detail", ""))
		insDoc(USER_INFO, gLnk(2, "User In RBS", ""))
		insDoc(USER_INFO, gLnk(2, "Lock in RBS", ""))
		
	CUP = insFld(foldersTree, gFld("CPU", ""))
		REPARSING = insFld(CUP, gFld("Reparsing", ""))
			insDoc(REPARSING, gLnk(2, "Counts", ""))
			insDoc(REPARSING, gLnk(2, "SQL", ""))
			insDoc(REPARSING, gLnk(2, "High Buffer Gets", ""))
			insDoc(REPARSING, gLnk(2, "Session CPU", ""))
			
		BUFFER_SCAN = insFld(CUP, gFld("Buffer Scan", ""))
			insDoc(BUFFER_SCAN, gLnk(2, "Average", ""))
			
		EVENT_WAIT = insFld(CUP, gFld("Event Wait", ""))
			insDoc(EVENT_WAIT, gLnk(2, "Detection", ""))
			insDoc(EVENT_WAIT, gLnk(2, "User", ""))
			insDoc(EVENT_WAIT, gLnk(2, "Background", ""))
			

	MEMORY = insFld(foldersTree, gFld("Memory", ""))
		SGA = insFld(MEMORY, gFld("Log", ""))
			insDoc(SGA, gLnk(2, "SGA", ""))
			insDoc(SGA, gLnk(2, "SGA Detail", ""))
			
		DETAIL = insFld(MEMORY, gFld("Detail", ""))
			insDoc(DETAIL, gLnk(2, "Redo Buffer", ""))
			
			VARIALBE = insFld(DETAIL, gFld("Variable Size", ""))
				SHARED_POOL = insFld(VARIALBE, gFld("Shared Pool", ""))
					insDoc(SHARED_POOL, gLnk(2, "Dictionary", ""))
					insDoc(SHARED_POOL, gLnk(2, "Library", ""))
					insDoc(SHARED_POOL, gLnk(2, "Reserved", ""))
					
				PRIVATE_SQL = insFld(VARIALBE, gFld("Private SQL", ""))
					insDoc(PRIVATE_SQL, gLnk(2, "Reparsing", ""))
					insDoc(PRIVATE_SQL, gLnk(2, "Who", ""))
					
				SESSION_CACHE_CURSOR = insFld(VARIALBE, gFld("Session Cache Cursor", ""))

	IO = insFld(foldersTree, gFld("I/O", ""))
		SPACE_MANAGEMENT = insFld(IO, gFld("Space Management", ""))
			TABLESPACE = insFld(SPACE_MANAGEMENT, gFld("Tablespace", ""))
				insDoc(TABLESPACE, gLnk(2, "Size & Status", ""))
				insDoc(TABLESPACE, gLnk(2, "Parameters", ""))
				insDoc(TABLESPACE, gLnk(2, "Free Space", ""))

			DATA_FILE = insFld(SPACE_MANAGEMENT, gFld("Data File", ""))
				insDoc(DATA_FILE, gLnk(2, "Size & Status", ""))
				insDoc(DATA_FILE, gLnk(2, "Free Space", ""))

			EXTENT = insFld(SPACE_MANAGEMENT, gFld("Extent", ""))
				insDoc(EXTENT, gLnk(2, "Extent", ""))
				insDoc(EXTENT, gLnk(2, "Fragmentated?", ""))

			OBJECT = insFld(SPACE_MANAGEMENT, gFld("Extent", ""))
				insDoc(OBJECT, gLnk(2, "Size", ""))
				
		LOAD_DISTRIBUTION = insFld(IO, gFld("Load Distribution", ""))	
			insDoc(LOAD_DISTRIBUTION, gLnk(2, "File Location", ""))
			insDoc(LOAD_DISTRIBUTION, gLnk(2, "Move Data File", ""))
			insDoc(LOAD_DISTRIBUTION, gLnk(2, "Contention?", ""))
			
		insDoc(IO, gLnk(2, "Table Scan", ""))			
		insDoc(IO, gLnk(2, "Data & Index Contention", ""))			
		
		PARTITION = insFld(IO, gFld("Partition", ""))	
			insDoc(PARTITION, gLnk(2, "Partition", ""))
		
		FRAGMENTATION = insFld(IO, gFld("Fragmentation", ""))	
			insDoc(FRAGMENTATION, gLnk(2, "Fragmentated?", ""))
			insDoc(FRAGMENTATION, gLnk(2, "Use Proper Size", ""))
			insDoc(FRAGMENTATION, gLnk(2, "Create New Table & Move Data", ""))
			insDoc(FRAGMENTATION, gLnk(2, "Export, Compress, & Import", ""))
			insDoc(FRAGMENTATION, gLnk(2, "Increase Extent Size", ""))

		ROW_CHAIN = insFld(IO, gFld("Row Chain", ""))	

		LOG_CONTENTION = insFld(IO, gFld("Log Contention", ""))	
			insDoc(LOG_CONTENTION, gLnk(2, "Log Info", ""))
			insDoc(LOG_CONTENTION, gLnk(2, "Last 100 Logs", ""))
			insDoc(LOG_CONTENTION, gLnk(2, "Some commands", ""))
			
		SORTING = insFld(IO, gFld("Sorting", ""))	
			insDoc(SORTING, gLnk(2, "Parameters", ""))
			insDoc(SORTING, gLnk(2, "When", ""))
			insDoc(SORTING, gLnk(2, "Where", ""))
			insDoc(SORTING, gLnk(2, "What TS", ""))
		
		RBS = insFld(IO, gFld("RBS", ""))
		
		CONTROL_FILE = insFld(IO, gFld("Control File", ""))	


	SPACE = insFld(foldersTree, gFld("Space Management", ""))
		insDoc(SPACE, gLnk(2, "Object Counts/User", ""))
		insDoc(SPACE, gLnk(2, "Space Usage/User", ""))
		insDoc(SPACE, gLnk(2, "TS Usage & Free Space", ""))
		insDoc(SPACE, gLnk(2, "Obj Size Summary By Type", ""))
		insDoc(SPACE, gLnk(2, "Big Objs", ""))
		insDoc(SPACE, gLnk(2, "Fragmented Objs", ""))
		insDoc(SPACE, gLnk(2, "Blook Needed/Table", ""))
		insDoc(SPACE, gLnk(2, "Extent Summary/User", ""))
		FREE_SPACE = insFld(SPACE, gFld("Free Space", ""))
			insDoc(FREE_SPACE, gLnk(2, "Inside TS", ""))
			insDoc(FREE_SPACE, gLnk(2, "Inside Data File", ""))
			insDoc(FREE_SPACE, gLnk(2, "Coalesce", ""))
		insDoc(SPACE, gLnk(2, "TS, Data File, & Free Space", ""))
		insDoc(SPACE, gLnk(2, "Data File Map", ""))
		insDoc(SPACE, gLnk(2, "Tables & Indexes Per TS", ""))
		insDoc(SPACE, gLnk(2, "Segment Extent By Owner Segment Name", ""))
		insDoc(SPACE, gLnk(2, "Segment Extent By Owner", ""))


	CONTENTION = insFld(foldersTree, gFld("Contention Management", ""))
		LATCHES = insFld(CONTENTION, gFld("Latches", ""))
			insDoc(LATCHES, gLnk(2, "Overview", ""))
			insDoc(LATCHES, gLnk(2, "Hit Ratio", ""))
			insDoc(LATCHES, gLnk(2, "Process Hoding", ""))
			insDoc(LATCHES, gLnk(2, "Process Waiting", ""))
			RBS = insFld(LATCHES, gFld("RBS", ""))
				insDoc(RBS, gLnk(2, "Overview", ""))
				insDoc(RBS, gLnk(2, "RBS", ""))
				insDoc(RBS, gLnk(2, "Shrink", ""))
				insDoc(RBS, gLnk(2, "Discrete", ""))
				insDoc(RBS, gLnk(2, "Locks", ""))
			insDoc(LATCHES, gLnk(2, "Redo Log Buffer", ""))
			insDoc(LATCHES, gLnk(2, "LRU", ""))
			insDoc(LATCHES, gLnk(2, "Free List", ""))
			insDoc(LATCHES, gLnk(2, "Spin Count", ""))
			insDoc(LATCHES, gLnk(2, "Who", ""))
			
		USER_LOCK = insFld(CONTENTION, gFld("User Lock", ""))
			insDoc(USER_LOCK, gLnk(2, "Overview", ""))
			insDoc(USER_LOCK, gLnk(2, "Who Locks Who", ""))
			insDoc(USER_LOCK, gLnk(2, "Whos is doing What", ""))
			insDoc(USER_LOCK, gLnk(2, "DDL", ""))
			insDoc(USER_LOCK, gLnk(2, "DML", ""))
			
		ENQUEUE = insFld(CONTENTION, gFld("Enqueue", ""))
			insDoc(ENQUEUE, gLnk(2, "Lock", ""))
			
	OBJECT = insFld(foldersTree, gFld("Object Management", ""))
		