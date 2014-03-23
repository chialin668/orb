//
// gloabl variable for table
//
var tmpTable=null;

var longTBodyHashTable = {};

/**
*
* add a pre-defined table table to the window
*
*	example: 
*	//ROLE
*	var Role_WID = new Array("Role_WID", "number", "-");
*	var Role_Name = new Array("Role_Name", "varchar2", "32");
*	var Version_Nbr = new Array("Version_Nbr", "number", "3");
*	var columnArray1 = new Array(Role_WID, Role_Name, Version_Nbr);
*	tb_CreateTable("Role", 150, 450, columnArray1);
*
*
*	tableDiv -------------------------> tb_GetTableObj(tableName),
*											tb_GetTableDivByColumnTr(columnTr),
*											tb_GetTableDivByButton(object) 
*		id
*		name
*
*		tableNameTag
*		parentArray
*		childArray
*		chosenColTrArr ------> tb_SetChosenColTr(tableName, columnTr), 
*								tb_GetChosenColTr(tableName), 	
*								tb_RemoveChosenColTr(tableName)
*
*		<table>
*			<tbody>
*				<tr> (dataTr)------------------------------> tb_GetDataTr(tableName)
*					<td>
*						<table> ---------------------------> tb_GetHtmlTable(tableName)
*							<tbody> -----------------------> tb_GetHtmlTableBody(tableName)
*								<tr><td>	{ primary key }
*								<tr><td>	{ column name }
*								<tr><td>	{ data type }
*								<tr><td>	{ data length }
*								<tr><td>	{ notNull }
*								<tr><td>	{ validate }
*								<tr><td>	{ default }
*
*				<tr> (controlTr) --------------------------> tb_GetControlTr(tableName)
*					<td>
*						<table>
*							<tbody>
*								<tr><td><button>
*								<tr><td><button>
*								<tr><td><button>
*									:
*	
*
**/
function tb_CreateTable(tableName, top, left, columnArray) {

	var tableDiv = document.createElement("div");
		tableDiv.id = tableName;					// for getting the table object: getElementById()
		tableDiv.name = tableName;					// for getting the table name
		tableDiv.className = CL_DB_TABLE;
			tableDiv.style.position = "absolute";
			tableDiv.style.top = top + "px";
			tableDiv.style.left = left + "px";
			tableDiv.style.color = "captiontext";
			tableDiv.style.font = "caption";
			tableDiv.style.padding = "1px";
			tableDiv.style.margin = "0px";
			tableDiv.style.background = COLOR_OBJ_DEFAULT;
			tableDiv.style.textAlign='center';

	document.body.appendChild(tableDiv);
	
	
	///////////////////////////////////////////////////////
	//
	// tag --> table name
	//
	var tableNameTag = document.createTextNode(tableName);
	tableDiv.appendChild(tableNameTag);

	//
	// for saving htmlTableBody
	//
	var longTableBody = null;

	//
	// relationships
	//
	var parentArray = new Array();
	tableDiv.parentArray = parentArray;
	
	var childArray = new Array();
	tableDiv.childArray = childArray;

	//
	// for column
	//
	var chosenColTrArr = new Array();
	tableDiv.chosenColTrArr = chosenColTrArr;
	
	
	///////////////////////////////////////////////////////
	var tbl = document.createElement("table");
		tbl.border ='0';
		tbl.cellSpacing='0';
		tbl.cellPadding='0';

	// html table
	var tbody = document.createElement("tbody");
	tbl.appendChild(tbody);


		// 
		// data tr
		//
		var dataTr = document.createElement("tr");
		var dataTd = tb_CreateDataTd(tableName, columnArray);
		if (dataTd == null) {
			var errMsg = "Error creating html table for:"
					+ "  table: " + tableName
					+ "\n";

			sy_logError("ERD-table", 
					"tb_CreateTable", 
					errMsg);
			return null;
		}
		dataTr.appendChild(dataTd);
		tbody.appendChild(dataTr);	


		//
		// control tr
		//
		var controlTr = document.createElement("tr");
			controlTr.style.width="100%";
		var controlTd = document.createElement("td");
			controlTd.style.width="100%";
		controlTd.align = "center";
		controlTr.appendChild(controlTd);

	tbody.appendChild(controlTr);
	tableDiv.appendChild(tbl);
	
	
	/////////////////////
	// 	indexDiv
	/////////////////////
	if(!in_CreateIndexDiv(tableName)) {
		sy_logError("ERD-table", 
				"tb_CreateTable", 
				"Error creating indexDiv!!");
		return null;
	}
	
	return tableDiv;
}




/**
*
* add an empty table to the ERD
*
**/
function tb_AddEmptyTable(tableName, top, left) {

	// create one empty table
	/*
	var column1 = new Array(PRIMARY_EKY_MARK, 		// primary key
								EMPTY_STRING, 		// column name
								"blob", 			// data type
								EMPTY_STRING, 		// data length
								NULLABLE_MARK,		// notNull 
								EMPTY_STRING, 		// validate
								EMPTY_STRING);		// default
	*/
	var columnArray1 = new Array();
	
	var retTable = tb_CreateTable(tableName, top, left, columnArray1);
	
	if (retTable == null) {
		sy_logError("ERD-table", 
				"tb_AddEmptyTable", 
				"Error creating a new empty table!!");
		return null;
	}
	
	return retTable;
}


////////////////////////////////////////////////////////////////////////////////////////////////

/**
*
* set the chosen column tr
*
**/
function tb_SetChosenColTr(tableName, columnTr) {

	tableDiv = tb_GetTableObj(tableName);
	tableDiv.chosenColTrArr[0] = columnTr;
}


/**
*
* retrieve the chosen column tr
*
**/
function tb_GetChosenColTr(tableName) {

	var tableDiv = tb_GetTableObj(tableName);
	var columnTrArr = tableDiv.chosenColTrArr;

	return columnTrArr[0];
}

/**
*
* remove the chosen column tr
*
**/
function tb_RemoveChosenColTr(tableName) {

	var tableDiv = tb_GetTableObj(tableName);
	var columnTrArr = tableDiv.chosenColTrArr;

	columnTrArr[0] = null;
	
	return true;
}


////////////////////////////////////////////////////////////////////////////////////////////////


/**
*
* retrieve the table object
*
**/
function tb_CreateDataTd(tableName, columnArray) {

	var td = document.createElement("td");
	var tbl = document.createElement("table");
		tbl.className = CL_HTML_TABLE;
		tbl.border ='1';
		tbl.cellSpacing='0';
		tbl.cellPadding='3';
		tbl.style.width="100%";

	var tbody = document.createElement("tbody");
	tbl.appendChild(tbody);

	if (tableName!=NEW_TABLE) {
	
		if (co_AppendColumn(tbody, columnArray) == false) {

			var errMsg = "Error adding column for:"
							+ "  table: " + tableName
							+ ", columnArray: " + columnArray 
							+ "\n";
			sy_logError("ERD-table", 
					"tb_CreateDataTd", 
					errMsg);

			return null;
		}
	}
	
	td.appendChild(tbl);

	return td;
}


/**
*
* create control button TD
*
**/
function tb_CreateControlTd(tableName) {

	controlTd = document.createElement("td");
	
	var tbl = document.createElement("table");
		tbl.className = CL_HTML_TABLE;
		tbl.border ='0';
		tbl.cellSpacing='0';
		tbl.cellPadding='2';
		tbl.style.width="100%";

	var tbody = document.createElement("tbody");
	tbl.appendChild(tbody);

		var tr = document.createElement("tr");
		var td = document.createElement("td");

		// new button
		var newBtn = document.createElement("button");
		  newBtn.innerText = "New Column";
		  newBtn.onclick = co_NewColumn;
		  newBtn.className = CL_TB_COMMAND;
		  newBtn.title = "Create a New Column";
		td.appendChild(newBtn);


		// index button
		var indBtn = document.createElement("button");
		  indBtn.innerText = "Index";
		  indBtn.onclick = in_EditIndex;
		  indBtn.className = CL_TB_COMMAND;
		  indBtn.title = "Edit Index";
		td.appendChild(indBtn);

		// oracle
		var orclBtn = document.createElement("button");
		  orclBtn.innerText = "Oracle";
		  orclBtn.onclick = in_EditIndex;
		  orclBtn.className = CL_TB_COMMAND;
		  orclBtn.title = "Oracle Specific";
		td.appendChild(orclBtn);


		// ok button
		var okBtn = document.createElement("button");
		  okBtn.innerText = "OK";
		  okBtn.onclick = tb_EditOk;
		  okBtn.className = CL_TB_COMMAND;
		  okBtn.title = "OK";
		td.appendChild(okBtn);

		// cancel button
		var cancelBtn = document.createElement("button");
		  cancelBtn.innerText = "Cancel";
		  cancelBtn.onclick = tb_EditCancel;
		  cancelBtn.className = CL_TB_COMMAND;
		  cancelBtn.title = "Cancel";
		td.appendChild(cancelBtn);
		
	tr.appendChild(td);
	tbody.appendChild(tr);

	
	controlTd.appendChild(tbl);

	return controlTd;
}


///////////////////////////////////////////////////////////////////////////////////////////////


/**
*
* 
*
**/
function tb_DoesTableExist(tableDiv, tableName) {

	if (tableName == null) {
		sy_logError("ERD-table", 
				"tb_DoesTableExist", 
				"Input table name is null!!");
		return null;
	}

	var retTableDiv = document.getElementById(tableName);
	
	if (retTableDiv == null)	// doesn't exist
		return false;
		
	if (tableDiv == retTableDiv)  // table itself
		return false;
	
	if (retTableDiv.className != CL_DB_TABLE) // not a table
		return false;
		
	return true;
}


/**
*
* retrieve the table object
*
**/
function tb_GetTableObj(tableName) {

	if (tableName == null) {
		sy_logError("ERD-table", 
				"tb_GetTableObj", 
				"Input table name is null!!");
		return null;
	}

	var tableDiv = document.getElementById(tableName);
	
	if (tableDiv == null) {
		sy_logError("ERD-table", 
				"tb_GetTableObj", 
				"Couldn't find tableDiv by tableName: " + tableName);
		return null;
	}
	
	return tableDiv;
}



/**
* 
* retrieve the data tr
*
**/
function tb_GetDataTr(tableName) {

	tableDiv = tb_GetTableObj(tableName);

	if (tableDiv == null) {
		sy_logError("ERD-table", 
				"tb_GetDataTr", 
				"tableDiv is null!!"
				+ "  tableName: " + tableName);
		return null;
	}
	
	var tableNameTag = tableDiv.firstChild;
	var table = tableNameTag.nextSibling;
	var tbody = table.firstChild;
	var dataTr = tbody.firstChild;
	
	return dataTr;
}


/**
* 
* retrieve the control tr
*
**/
function tb_GetControlTr(tableName) {
	var dataTr = tb_GetDataTr(tableName);
	
	if (dataTr == null) {
		sy_logError("ERD-table", 
				"tb_GetControlTr", 
				"dataTr is null!!"
				+ "  tableName: " + tableName);
		return null;
	}
	
	var controlTr = dataTr.nextSibling;
	
	return controlTr;
}


/**
* 
* retrieve the html table inside a db table
*
**/
function tb_GetHtmlTable(tableName) {

	var dataTr = tb_GetDataTr(tableName);
	if (dataTr == null) {
		sy_logError("ERD-table", 
				"tb_GetHtmlTable", 
				"dataTr is null!!"
				+ "  tableName: " + talbeName);
		return null;
	}
	
	var dataTd = dataTr.firstChild;
	var htmlTable = dataTd.firstChild;
	
	return htmlTable;
}


/**
*
* retrieve the html SHORT/DISPLAY table body inside a db table
*
**/
function tb_GetHtmlShortTableBody(tableName) {

	htmlTable = tb_GetHtmlTable(tableName);
	
	if (htmlTable == null) {
		sy_logError("ERD-table", 
				"tb_GetHtmlShortTableBody", 
				"htmlTable is null!!");
		return null;
	}

	var tableBody = htmlTable.firstChild;
	
	return tableBody;
}


/**
*
* retrieve the html LONG table body inside a db table
*
**/
function tb_GetHtmlTableBody(tableName) {

	return tb_GetHtmlShortTableBody(tableName);
}

/**
*
* retrieve the html LONG table body inside a db table
*
**/
function tb_GetHtmlTableBody0(tableName) {

	var tableDiv = tb_GetTableObj(tableName);
	
	if (tableDiv.longTableBody != null) {
		
//		sy_logError("","", "long");
		
		return tableDiv.longTableBody;
		
		
	} else {

//		sy_logError("","", "short");
		
		htmlTable = tb_GetHtmlTable(tableName);
		var tableBody = htmlTable.firstChild;
		return tableBody;
	}

}



/**
*
* retrieve a column tr by a given column name
*
**/
function tb_GetColumnTr(tableName, columnName) {

	var tableBody = tb_GetHtmlTableBody(tableName);

	if (tableBody == null) {
		sy_logError("ERD-table", 
				"tb_GetColumnTr", 
				"tableBody is null!!");
		return null;
	}
	
	var columnTr = tableBody.firstChild;
	
	while(columnTr != null) {
	
		if (columnName == co_GetColNameByColTr(columnTr))
			return columnTr;
			
		columnTr = columnTr.nextSibling;
	}

	return null;
}


/**
*
* 
*
**/
function tb_HasPrimaryKey(tableName) {

	var tableBody = tb_GetHtmlTableBody(tableName);

	if (tableBody == null) {
		sy_logError("ERD-table", 
				"tb_HasPrimaryKey", 
				"tableBody is null!!");
		return null;
	}
	
	var columnTr = tableBody.firstChild;
	
	while(columnTr != null) {
	
		if (co_IsPrimaryKey(columnTr))
			return true;
			
		columnTr = columnTr.nextSibling;
	}

	return false;
}


/**
*
* retrieve primary key (column name) array
*
**/
function tb_GetPrimaryKeyArray(tableName) {

	var tableBody = tb_GetHtmlTableBody(tableName);

	if (tableBody == null) {
		sy_logError("ERD-table", 
				"tb_GetPrimaryKeyArray", 
				"tableBody is null!!");
		return null;
	}
	
	var pKeyArray = new Array();
	var i=0;
	
	var columnTr = tableBody.firstChild;
	
	while(columnTr != null) {
	
		if (co_IsPrimaryKey(columnTr)) {

			var columnNameObj = new Object();
			columnNameObj.columnName = co_GetColNameByColTr(columnTr);
			pKeyArray[i] = columnNameObj;

			i++;
		}
			
		columnTr = columnTr.nextSibling;
	}



	return pKeyArray;

}


/**
*
* retrieve foreign key (column name) array
*
**/
function tb_GetForeignKeyArray(tableName) {

	var tableBody = tb_GetHtmlTableBody(tableName);

	if (tableBody == null) {
		sy_logError("ERD-table", 
				"tb_GetForeignKeyArray", 
				"tableBody is null!!");
		return null;
	}
	
	var fKeyArray = new Array();
	var i=0;
	
	var columnTr = tableBody.firstChild;
	
	while(columnTr != null) {
	
		// only interested in MOD_ONE2MANY foreign key (marked 'f')
		if (co_IsForeighKey(MOD_ONE2MANY, columnTr)) {
		
			var columnNameObj = new Object();
			columnNameObj.columnName = co_GetColNameByColTr(columnTr);
			fKeyArray[i] = columnNameObj;
			
			i++;
		}
			
		columnTr = columnTr.nextSibling;
	}

	return fKeyArray;

}


///////////////////////////////////////////////////////////////////////////////////////////////


/**
*
* edit the chosen table (tableDiv)
* 	(change text to input mode for all fields)
*
**/
function tb_EditTable(tableName) {

	tableDiv = tb_GetTableObj(tableName);
	
	if (tableDiv == null) {
		sy_logError("ERD-table", 
				"tb_EditTable", 
				"tableDiv is null!!"
				+ "  Table name: " + tableName);
		return false;
	}


	//
	// save a temp copy in case if we want to rollback (cancel)
	//
	tmpTable = tableDiv.cloneNode(true);


	//
	// change it to long view
	//
	tb_ToLongView(tableName);


	//
	// title (text --> input text)
	//
	var tableNameTag = tableDiv.firstChild;
	var inputText = ut_TextToInput(tableNameTag, null, null);
	//inputText.onchange = tb_RenameTable0;
	inputText.ondeactivate = tb_RenameTable0;	
	tableDiv.replaceChild(inputText, tableNameTag);

	inputText.focus();
	inputText.select();
	

	//
	// add the buttons
	//
	var controlTr = tb_GetControlTr(tableName);
	if (controlTr == null) {
		sy_logError("ERD-table", 
				"tb_EditTable", 
				"controlTr is null!!"
				+ "  Table name: " + tableName);
		return false;
	}
	
	var oldTd = controlTr.firstChild;
	var newTd = tb_CreateControlTd(tableName);
	controlTr.replaceChild(newTd, oldTd);
	
	return true;
}


/**
*
* for validate and default
*
**/
function tb_GetTableDivByColumnTr(columnTr) {

	var coTbody = columnTr.parentElement;
	var coTable = coTbody.parentElement;

	var dataTd = coTable.parentElement;
	var dataTr = dataTd.parentElement;
	
	var tbody = dataTr.parentElement;
	var table = tbody.parentElement;
	var tableDiv = table.parentElement;

	return tableDiv;
}


/**
*
* retrieve table from a pressed button
*
**/
function tb_GetTableDivByButton(object) {

	var btnTd = object.parentElement;
	var btnTr = btnTd.parentElement;
	var btnTbody = btnTr.parentElement;
	var btnTable = btnTbody.parentElement;

	var controlTd = btnTable.parentElement;
	var controlTr = controlTd.parentElement;
	
	var tbody = controlTr.parentElement;
	var table = tbody.parentElement;
	var tableDiv = table.parentElement;

	return tableDiv;
}



/**
*
* retrieve table name from a pressed button
*
**/
function tb_GetTableNameByButton(object) {

	var tableDiv = tb_GetTableDivByButton(object);
	
	if (tableDiv == null) {
		sy_logError("ERD-table", 
				"tb_GetTableNameByButton", 
				"tableDiv is null!!");
		return null;
	}

	return tableDiv.id;
}



/**
*
* add a new empty column 
*
**/
function tb_EditNew() {

	var tableName = tb_GetTableNameByButton(this);
	
	var htmlTBody = tb_GetHtmlTableBody(tableName);

	// creat one empty column
	var tr = co_ColumnTrInput("",					// primary key 
								"",					// column name 
								"",					// data type 
								"",					// data length 
								"",					// notNull 
								EMPTY_STRING, 		// validate
								EMPTY_STRING);		// default 
	htmlTBody.appendChild(tr);

	return true;
}


/**
*
*
*
**/
function tb_CheckTableName() {

alert("000");
return;

	var tableName = this.value // this --> tableNameTag
	
	if (tableName == "" || tableName == NEW_TABLE) {
		alert("Please enter table name");
		this.focus();
		this.select();
		return;
	}

	return;
}


/**
*
* if renamed the table name (if we change the table name tag)
*
**/
function tb_RenameTable0() {

	var newTableName = this.value;	// this --> tableNameTag
	var tableDiv = this.parentElement;

	if (!PATTERN_VALID_NAME.test(newTableName)) {
		alert("Please enter a valid table name.");
		
		this.focus();
		this.select();
		return;
	}

	if (tb_DoesTableExist(tableDiv, newTableName)) {
		alert("Table exists!!");
		
		this.focus();
		this.select();
		return;
	}


	//
	// NOTE: this --> tableNameTag
	//	
	var tableDiv = this.parentElement;
	var tableName = tableDiv.id;
	
	
	if (tableName != newTableName) 	
		tb_RenameTable(tableName, newTableName);

	return true;
}



/**
*
* if tableNameTag is changed
*
**/
function tb_RenameTable(tableName, newTableName) {

	var tableDiv = document.getElementById(tableName);
	

	//////////////
	// table
	//////////////
	tableDiv.id = newTableName;
	tableDiv.name = newTableName;


	// relationship
	tb_NotifyParents(tableDiv, tableName, newTableName);
	tb_NotifyChildren(tableDiv, tableName, newTableName);


	//////////////
	// indexes
	//////////////

	// pkey index
	in_RenamePKeyIndex(tableName, newTableName);

	// fkey index for this table
	in_RenameFKeyIndex(tableName, newTableName);

	// fkey indexes for the children tables
	var childArray = tableDiv.childArray;
	for (var i=0;i<childArray.length;i++)
		in_RenameChildFKeyIndex(tableName, newTableName, childArray[i]);

	// then, indexDiv ID
	in_RenameIndexDivId(tableName, newTableName);
	
	return true;
	
}


/**
*
* save the modified table
*
**/
function tb_EditOk(button) {

	var tableDiv = tb_GetTableDivByButton(this);
	var tableName = tb_GetTableNameByButton(this);

	// at least one column
	var columnCount = tb_GetColumnCount(tableName);
	if (columnCount == 0) {
		alert("Please create column(s)");
		return;
	}
	

	////////////////////////////
	//   if renamed the table
	////////////////////////////
	var newTableName = tableDiv.firstChild.value;  // tableNameTag
	
	if (tableName != newTableName) {

		tb_RenameTable(tableName, newTableName);
		
		tableName = newTableName;
	}
	
	
	var tableNameTag = tableDiv.firstChild;
	tableNameTag.data = newTableName;
	tableDiv.replaceChild(ut_InputTextToText(tableNameTag), tableNameTag);

	//
	// if have a new column (from "New Column" button)
	//
	var columnTr = tb_GetChosenColTr(tableName);

	if (columnTr != null) {
	
		if (co_IsInput(columnTr))
			columnTr = co_ColumnInputToText(columnTr);
		
//		if (co_IsPrimaryKey(columnTr) == true) 
//			co_ForeignKeyControl(columnTr, "add");

		if(tb_RemoveChosenColTr(tableName) == false) {
			sy_logError("ERD-table", 
					"co_NewColumn", 
					"Error removing chosen Tr");
			return;
		}

		// reorganize the columns		
		var htmlTable = tb_GetHtmlTable(tableName);
		var tbody = htmlTable.firstChild;
		
		htmlTable.replaceChild(co_MovePKeyUp(tableName, tbody), tbody);
		
	}

	
	//
	// remove the buttons
	//
	var controlTr = tb_GetControlTr(tableName);
	if (controlTr == null) {
		sy_logError("ERD-table", 
				"tb_EditOk", 
				"controlTr is null!!"
				+ "  Table name: " + tableName);
		return false;
	}

	var oldTd = controlTr.firstChild;
	var newTd = document.createElement("td");
	controlTr.replaceChild(newTd, oldTd);
	
	//
	// foreign key control
	//
	if(!tb_ForeignKeyControl(tableName)) {
		sy_logError("ERD-table", 
				"tb_EditOk", 
				"Error executing tb_ForeignKeyControl!!"
				+ "  Table name: " + tableName);
		return false;
	}

	tb_ToShortView(tableName);

	re_RedrawRelation(tableName);

	// finish it up!!
	tableDiv.style.background = COLOR_OBJ_DEFAULT;
	tb_RemoveChosenColTr(tableName);
	tmpTable = null;
	chosenTableName = null;
	chosenColumn = null;
	selectedObj = null;
	
	return true;
}


/**
*
* change the table view from short to long
*
**/
function tb_ToLongView(tableName) {

	var tableDiv = tb_GetTableObj(tableName);
	
	var longTableBody = tableDiv.longTableBody;
	var shortTableBody = tb_GetHtmlShortTableBody(tableName);

	if (longTableBody == null || shortTableBody == null) {
		sy_logError("ERD-table", 
				"tb_EditTable", 
				"longTableBody or shortTableBody is null!!"
				+ "  Table name: " + tableName);
		return false;
	}

	var htmlTable = shortTableBody.parentElement;
	htmlTable.replaceChild(longTableBody, shortTableBody);

	tableDiv.longTableBody = null;
}


/**
* 
* Change the view from long view to short view 
*	(long view are hidden in tableDiv.longTableBody)
*
* display "primary key, columnName: dataType(dataLength)" only
* 
**/
function tb_ToShortView(tableName) {

	var longTableBody = tb_GetHtmlTableBody(tableName);
	var shortTableBody = document.createElement("tbody");

	var columnTr = longTableBody.firstChild;

	while(columnTr != null) {

		var primaryKey = co_GetPKeyByColTr(columnTr);
		var columnName = co_GetColNameByColTr(columnTr);
		var dataType = co_GetTypeByColTr(columnTr);
		var dataLength = co_GetLengthByColTr(columnTr);

		// create new tr
		var shortColumnTr = document.createElement("TR");
		
		var pKeyTd = document.createElement("TD");
			var newPkeyTxt = document.createTextNode(primaryKey);
			pKeyTd.appendChild(newPkeyTxt);
		shortColumnTr.appendChild(pKeyTd);
		
		// column name + data type + data length
		var columnTd = document.createElement("TD");
			var columnStr = columnName + ": "
								+ dataType 
								+ (dataLength!="-"? "(" + dataLength + ")" : "");
			var newColumnTxt = document.createTextNode(columnStr);
			columnTd.appendChild(newColumnTxt);
		shortColumnTr.appendChild(columnTd);

		shortTableBody.appendChild(shortColumnTr);

		// next column
		columnTr = columnTr.nextSibling;
	}

	// saving the long one
	var tableDiv = tb_GetTableObj(tableName);
	tableDiv.longTableBody = longTableBody;	

	// replace the long one with the short view
	var htmlTable = longTableBody.parentElement;
	htmlTable.replaceChild(shortTableBody, longTableBody);

	return true;

}


/**
* 
* Refresh short view (while we're displaying it)
*
*	(if we add/remove a foreign key)
* 
**/
function refreshShortView(tableName) {

	var tableDiv = tb_GetTableObj(tableName);
	var longTableBody = tableDiv.longTableBody;

	var shortTableBody = tb_GetHtmlShortTableBody(tableName);
	var htmlTable = shortTableBody.parentElement;

	// change it to long view
	htmlTable.replaceChild(longTableBody, shortTableBody);
	
	// RE-create a short view
	tb_ToShortView(tableName);
}



/**
* 
* 
* 
**/
function tb_AddForeignkey(childTableName, parentColumnTr) {

	var tableBody = tb_GetHtmlTableBody(childTableName);
	if (tableBody == null) {
		sy_logError("ERD-table", 
				"tb_AddForeignkey", 
				"tableBody is null!!");
		return false;
	}
	
	var columnTr = tableBody.firstChild;
	while(columnTr != null) {
		
		// only interested in MOD_ONE2MANY foreign key (marked 'f')
		if (co_GetColNameByColTr(columnTr) == co_GetColNameByColTr(parentColumnTr)
				&& co_IsForeighKey(MOD_ONE2MANY, columnTr))  { 
			//
			// found!!	make sure the data is right!! 
			//		(we might change the column in the parent table)
			//
			
			// fkey only 
			// column name 
			co_GetDataTypeTd(columnTr).firstChild.data = co_GetTypeByColTr(parentColumnTr);
			co_GetDataLengthTd(columnTr).firstChild.data = co_GetLengthByColTr(parentColumnTr);
			// should NOT be null
			co_GetValidateTd(columnTr).firstChild.data = co_GetValidateByColTr(parentColumnTr);
			co_GetDefaultTd(columnTr).firstChild.data = co_GetDefaultByColTr(parentColumnTr);
			
			return;		
			
		}
		columnTr = columnTr.nextSibling;
	}

	//
	// create a new foreign key
	//
	var fKeyColTr = co_ColumnTr(FOREIGN_EKY_MARK, 					// foreign key!!
						co_GetColNameByColTr(parentColumnTr),		// column name
						co_GetTypeByColTr(parentColumnTr), 			// data type
						co_GetLengthByColTr(parentColumnTr),		// data length
						co_GetNotNullByColTr(parentColumnTr),		// notNull
						co_GetValidateByColTr(parentColumnTr),		// validate
						co_GetDefaultByColTr(parentColumnTr)		// default
						);	
//alert("append to " + childTableName);

	tableBody.appendChild(fKeyColTr);

	// refresh the view
	refreshShortView(childTableName);
	
	return true;

}


/**
* 
* remove foreign key (pColumnName) from this (child) table
*
* @ tableName - name of the child table
* @ columnName - column name of the parent table 
* 
**/
function tb_RemoveForeignKey(tableName, pColumnName) {

	var tableBody = tb_GetHtmlTableBody(tableName);
	if (tableBody == null) {
		sy_logError("ERD-table", 
				"tb_RemoveForeignKeys", 
				"tableBody is null!!");
		return false;
	}
	
	var columnTr = tableBody.firstChild;
	while(columnTr != null) {

		var cColumnName = co_GetColNameByColTr(columnTr);

		if ((cColumnName == pColumnName && co_IsForeighKey(MOD_ONE2MANY, columnTr)) 
						||
				(cColumnName == pColumnName && co_IsPrimaryKey(columnTr)) )  { // found!!

			tableBody.removeChild(columnTr);
			return;
		}
		
		columnTr = columnTr.nextSibling;
	}

	// refresh the view
	refreshShortView(tableName);

	return true;

}


/**
* 
* whether this table has this column 
* 
**/
function tb_HasColumn(tableName, columnName) {

	var tableDiv = tb_GetTableObj(tableName);
	var tableBody = tb_GetHtmlTableBody(tableName);
	var columnTr = tableBody.firstChild;
	
	while(columnTr != null) {

		if (co_GetColNameByColTr(columnTr) == columnName) 
			return true;
			
		columnTr = columnTr.nextSibling;
	}

	return false;
}


/**
* 
* add ore remove foreign keys (in the child table) for this table
* 
**/
function tb_ForeignKeyControl(tableName) {

	var tableDiv = tb_GetTableObj(tableName);
	var childArray = tableDiv.childArray;

	var tableBody = tb_GetHtmlTableBody(tableName);
	if (tableBody == null) {
		sy_logError("ERD-table", 
				"tb_ForeignKeyControl", 
				"tableBody is null!!");
		return false;
	}
	
	var columnTr = tableBody.firstChild;
	
	var primaryKeyCount = 0;
	while(columnTr != null) {
	
		if (co_IsPrimaryKey(columnTr)) {
		
			// add
			for (var i=0;i<childArray.length;i++)
				tb_AddForeignkey(childArray[i], columnTr);

			primaryKeyCount++;
			
		} else {
		
			// remove
			for (var i=0;i<childArray.length;i++)
				tb_RemoveForeignKey(childArray[i], co_GetColNameByColTr(columnTr));
		}
			

		columnTr = columnTr.nextSibling;
	}

	//
	// no primary key found? (all primary key got removed)
	//

	if (primaryKeyCount == 0) {
		

		for (var i=0;i<childArray.length;i++) {
		
			var childTableName = childArray[i];
			
			// remove foreign key indexes
			var indexDiv = in_GetIndexDivByTableName(childTableName);
			var columnHashTable = indexDiv.columnHashTable;
			var indexName = "FK_" + tableName + "__" + childTableName;
			delete columnHashTable[indexName]; 

			// relationship line
			re_RemoveRelation(tableName, childTableName) 

			// from parentArray and childArray	
			tb_RemoveRelationFromTable(tableName, childTableName);
			
		}
	
	}

	return true;
}


/**
*
* notify parents that we have a name change
*
**/
function tb_NotifyParents(tableDiv, oldTableName, newTableName) {
	parentArray = tableDiv.parentArray;
	
	for (var i=0;i<parentArray.length;i++) {
		var pTableName = parentArray[i];
		var pTableDiv = tb_GetTableObj(pTableName);
		
		var childArray = pTableDiv.childArray;

		for (var j=0;j<childArray.length; j++) {
			var cTableName = childArray[j];

			if (cTableName == oldTableName) {

				childArray[j] = newTableName;

				// rename relationship id
				re_RenameRelation(pTableName + "__" + oldTableName,		// old id
							pTableName + "__" + newTableName	// new id
							);
				break;
			}
		}
	}

	return true;
}


/**
*
* notify children that we have a name change
*
**/
function tb_NotifyChildren(tableDiv, oldTableName, newTableName) {
	childArray = tableDiv.childArray;
	
	for (var i=0;i<childArray.length;i++) {
		var cTableName = childArray[i];
		var cTableDiv = tb_GetTableObj(cTableName);
		
		var parentArray = cTableDiv.parentArray;
		for (var j=0;j<parentArray.length;j++) {
			var pTableName = parentArray[j];
			
			if (pTableName == oldTableName) {
				parentArray[j] = newTableName;

				// rename relationship id
				re_RenameRelation(oldTableName + "__" + cTableName,		// old id
							newTableName + "__" + cTableName	// new id
							);
				break;
			}
		}
	}

	return true;
}


/**
*
* undo the editing
*
**/
function tb_EditCancel() {

	var tableDiv = tb_GetTableDivByButton(this);
	var oldTableName = tmpTable.id;
	var newTableName = tb_GetTableNameByButton(this);

	if (oldTableName != newTableName) {

		// rollback (table, relation, and index)
		tb_RenameTable(newTableName, oldTableName);
	}


	document.body.removeChild(tableDiv);
	document.body.appendChild(tmpTable);

	tmpTable.style.background = COLOR_OBJ_DEFAULT;

	re_RedrawRelation(oldTableName);

	// done!
	tmpTable = null;
	chosenTableName = null;
	chosenColumn = null;
	selectedObj = null;

	
	return true;
}


/**
*
* remove buttons (replace the button td with an empty td)
*
**/
function tb_RemoveButtons(tableName) {

	// remove the buttons
	var controlTr = tb_GetControlTr(tableName);
	if (controlTr == null) {
		sy_logError("ERD-table", 
				"tb_EditOk", 
				"controlTr is null!!"
				+ "  Table name: " + tableName);
		return false;
	}

	var oldTd = controlTr.firstChild;
	var newTd = document.createElement("td");
	controlTr.replaceChild(newTd, oldTd);
	
	return true;
}


/**
*
* add parent/child table names to arrays
*
**/
function tb_AddRelationshipToTables(parentName, childName) {

	if (parentName==null || childName==null) {
		var errMsg = "One of the following string is null:"
				+ "  parent: " + parentName
				+ ", child: " + childName
				+ "\n";
		sy_logError("ERD-table", 
				"tb_AddRelationshipToTables", 
				errMsg);
		return false;
	}

	// add child to parent
	var parentTab = document.getElementById(parentName);
	parentTab.childArray[parentTab.childArray.length] = childName;

	// add parent to child
	var childTab = document.getElementById(childName);
	childTab.parentArray[childTab.parentArray.length] = parentName;

	return true;
}


/**
*
* remove relationship for both parent and child
*
**/
function tb_RemoveRelationFromTable(parentName, childName) {

	// remove child from parent
	var parentTab = document.getElementById(parentName);
	childArray = parentTab.childArray;
	
	var newChildArray = new Array();
	
	var j=0;
	for (var i=0;i<childArray.length;i++) {
		if (childArray[i] != childName) {
			newChildArray[j] = childArray[i];
			j++;
		}
	}
	
	parentTab.childArray = newChildArray;
	

	// remove parent from child
	var childTab = document.getElementById(childName);
	parentArray = childTab.parentArray;
	
	var newParentArray = new Array();
	
	var j=0;
	for (var i=0;i<parentArray.length;i++) {
		if (parentArray[i] != parentName) {
			newParentArray[j] = parentArray[i];
			j++;
		}
	}
	
	childTab.parentArray = newParentArray;
}


/**
*
* 
*
**/
function tb_GetColumnCount(tableName) {

	var tableBody = tb_GetHtmlTableBody(tableName);
	if (tableBody == null) {
		sy_logError("ERD-table", 
				"tb_GetColumnCount", 
				"tableBody is null!!");
		return false;
	}
	
	var columnTr = tableBody.firstChild;
	
	var columnCount = 0;
	while(columnTr != null) {
		
		columnCount++;
		
		columnTr = columnTr.nextSibling;
	}

	return columnCount;
}


/**
*
* 
*
**/
function tb_HasPrimaryKey(tableName) {

	var tableBody = tb_GetHtmlTableBody(tableName);
	
	if (tableBody == null) {
		sy_logError("ERD-table", 
				"tb_GetColumnCount", 
				"tableBody is null!!");
		return false;
	}
	
	var columnTr = tableBody.firstChild;
	
	while(columnTr != null) {
		
		if (co_IsPrimaryKey(columnTr))
			return true;
			
		columnTr = columnTr.nextSibling;
	}

	return false;

}

////////////////////////////////////////////////////////////////////////////////////////////////

/**
*
* 
*
**/
function tb_ChangeView() {

	var list = document.forms[0].viewType;
	var viewType = list.options[list.selectedIndex].value;
	
	var objArray = document.all;

	for (var i=0; i<objArray.length; i++) {
	
		object = objArray[i];

		if (object.className == CL_DB_TABLE) {
			var tableName = object.id;
			
			var tableBody = tb_GetHtmlTableBody(tableName);

			// clone a tablebody
//			var clonedTBody = tableBody.cloneNode(true);
//			clonedTBody.style.visibility = "hidden";
//			object.appendChild(clonedTBody);


			var columnTr = tableBody.firstChild;

			while(columnTr != null) {

				var td = co_GetDefaultTd(columnTr);
				columnTr.removeChild(td);				
				td.style.visibility = "hidden";
				
				columnTr.appendChild(td);

				columnTr = columnTr.nextSibling;
			}

			
			
		}
	}

}