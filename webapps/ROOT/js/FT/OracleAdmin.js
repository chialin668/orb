fT = gFld("<i>Admin</i>", "")

SCHEMA = insFld(fT, gFld("Schema", ""))
	insDoc(SCHEMA, gLnk("Advanced Queues", ""))
	insDoc(SCHEMA, gLnk("Array Type", ""))
	insDoc(SCHEMA, gLnk("Cluster", ""))
	insDoc(SCHEMA, gLnk("Database Link", ""))
	insDoc(SCHEMA, gLnk("Dimension", ""))
	insDoc(SCHEMA, gLnk("Function", ""))
	insDoc(SCHEMA, gLnk("Index", ""))
	insDoc(SCHEMA, gLnk("Materialized View", ""))
	insDoc(SCHEMA, gLnk("Materialized View Log", ""))
	insDoc(SCHEMA, gLnk("Object Type", ""))
	insDoc(SCHEMA, gLnk("Package", ""))
	insDoc(SCHEMA, gLnk("Package Body", ""))
	insDoc(SCHEMA, gLnk("Procedure", ""))
	insDoc(SCHEMA, gLnk("Refresh Group", ""))
	insDoc(SCHEMA, gLnk("Sequence", ""))
	insDoc(SCHEMA, gLnk("Synonym", ""))
	insDoc(SCHEMA, gLnk("Table", ""))
	insDoc(SCHEMA, gLnk("Table Type", ""))
	insDoc(SCHEMA, gLnk("Trigger", ""))
	insDoc(SCHEMA, gLnk("View", ""))

USERS = insFld(fT, gFld("Users", ""))
	insDoc(USERS, gLnk("Users", ""))
	insDoc(USERS, gLnk("Role", ""))
	insDoc(USERS, gLnk("Profile", ""))
			