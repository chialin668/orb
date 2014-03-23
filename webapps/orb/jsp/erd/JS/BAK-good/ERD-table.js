//
// gloabl variable for table
//
var tmpTable=null;

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
*	tb_AddTable("Role", 150, 450, columnArray1);
*
*
*	tableDiv -------------------------> tb_GetTableObj(tableName),
*											tb_GetTableDivByColumnTr(columnTr),
*											tb_GetTableDivByButton(object) 
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
*								<tr><td>	{ nullable }
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
function tb_AddTable(tableName, top, left, columnArray) {

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
					"tb_AddTable", 
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
	
	return tableDiv;
}




/**
*
* add an empty table to the ERD
*
**/
function tb_AddEmptyTable() {

	// create one empty table
	var column1 = new Array(PRIMARY_EKY_MARK, 		// primary key
								EMPTY_STRING, 		// column name
								"blob", 			// data type
								EMPTY_STRING, 		// data length
								NULLABLE_MARK,		// nullable 
								EMPTY_STRING, 		// validate
								EMPTY_STRING);		// default
	
	var columnArray1 = new Array(column1);
	
	var retTable = tb_AddTable(NEW_TABLE, event.clientY, event.clientX, columnArray1);
	
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

	if (co_AppendColumn(tbody, columnArray) == false) {
	
		var errMsg = "Error adding column for:"
						+ "  table: " + tableName
						+ ", columnArray: " + columnArray 
						+ "\n";
		sy_logError("ERD-table", 
				"tb_AddTable", 
				errMsg);
				
		return null;
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

	tableDiv = document.getElementById(tableName);
	
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
* retrieve the html table body inside a db table
*
**/
function tb_GetHtmlTableBody(tableName) {

	htmlTable = tb_GetHtmlTable(tableName);
	
	if (htmlTable == null) {
		sy_logError("ERD-table", 
				"tb_GetHtmlTableBody", 
				"htmlTable is null!!");
		return null;
	}

	var tableBody = htmlTable.firstChild;
	
	return tableBody;
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
	
		if (co_IsForeighKey(columnTr)) {
		
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
	// title (text --> input text)
	//
	var tableNameTag = tableDiv.firstChild;
	var inputText = ut_TextToInput(tableNameTag, null, null);
	inputText.onchange = tb_RenameTable0;
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
	
	if (tableName == null) {
		sy_logError("ERD-table", 
				"tb_EditNew", 
				"tableName is null!!");
		return false;
	}

	var htmlTBody = tb_GetHtmlTableBody(tableName);

	// creat one empty column
	var tr = co_ColumnTrInput("",					// primary key 
								"",					// column name 
								"",					// data type 
								"",					// data length 
								"",					// nullable 
								EMPTY_STRING, 		// validate
								EMPTY_STRING);		// default 
	htmlTBody.appendChild(tr);

	return true;
}


/**
*
* if renamed the table name (if we change the table name tag)
*
**/
function tb_RenameTable0() {

	//
	// NOTE: this --> tableNameTag
	//	
	var tableDiv = this.parentElement;
	var tableName = tableDiv.id;
	
	var newTableName = this.value;
	
	if (tableName != newTableName) 	
		tb_RenameTable(tableName, newTableName);

	return true;
}



/**
*
* if renamed the table name
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
	// if have a new column
	//
	var columnTr = tb_GetChosenColTr(tableName);

	if (columnTr != null) {
	
		columnTr = co_ColumnInputToText(columnTr);
		
		if (co_IsPrimaryKey(columnTr) == true) 
			co_ForeignKeyControl(columnTr, "add");

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
	
	tb_ForeignKeyControl(tableName);

	re_RedrawRelation(tableName);



	// finish it up!!
	tableDiv.style.background = COLOR_OBJ_DEFAULT;
	tb_RemoveChosenColTr(tableName);
	tmpTable = null;
	chosenTable = null;
	chosenColumn = null;
	selectedObj = null;
	
	return true;
}


/**
* 
* 
* 
**/
function tb_AddForeignkey(tableName, inColumnTr) {

	var tableBody = tb_GetHtmlTableBody(tableName);
	if (tableBody == null) {
		sy_logError("ERD-table", 
				"tb_RemoveForeignKeys", 
				"tableBody is null!!");
		return false;
	}
	
	var columnTr = tableBody.firstChild;
	while(columnTr != null) {
		
		if (co_GetColNameByColTr(columnTr) == co_GetColNameByColTr(inColumnTr)
				&& co_IsForeighKey(columnTr))  // found!!
			return;		
			
		columnTr = columnTr.nextSibling;
	}


	var fKeyColTr = co_ColumnTr(FOREIGN_EKY_MARK, 		// foreign key!!
				co_GetColNameByColTr(inColumnTr),		// column name
				co_GetTypeByColTr(inColumnTr), 			// data type
				co_GetLengthByColTr(inColumnTr),		// data length
				co_GetNullableByColTr(inColumnTr),		// nullable
				co_GetValidateByColTr(inColumnTr),		// validate
				co_GetDefaultByColTr(inColumnTr)		// default
				);	
	tableBody.appendChild(fKeyColTr);

	return true;

}


/**
* 
* 
* 
**/
function tb_RemoveForeignKey(tableName, columnName) {
	var tableBody = tb_GetHtmlTableBody(tableName);
	if (tableBody == null) {
		sy_logError("ERD-table", 
				"tb_RemoveForeignKeys", 
				"tableBody is null!!");
		return false;
	}
	
	var columnTr = tableBody.firstChild;
	while(columnTr != null) {

		if (co_GetColNameByColTr(columnTr) == columnName
				&& co_IsForeighKey(columnTr))  { // found!!
			tableBody.removeChild(columnTr);
			return;
		}
		
		columnTr = columnTr.nextSibling;
	}

	return true;

}


/**
* 
* add ore remove foreign keys for this table
* 
**/
function tb_ForeignKeyControl(tableName) {

	var tableDiv = tb_GetTableObj(tableName);
	var childArray = tableDiv.childArray;

	var tableBody = tb_GetHtmlTableBody(tableName);
	if (tableBody == null) {
		sy_logError("ERD-table", 
				"tb_RemoveForeignKeys", 
				"tableBody is null!!");
		return false;
	}
	
	var columnTr = tableBody.firstChild;
	while(columnTr != null) {
	
		if (co_IsPrimaryKey(columnTr)) {
		
			for (var i=0;i<childArray.length;i++)
				tb_AddForeignkey(childArray[i], columnTr);

		} else {
		
			for (var i=0;i<childArray.length;i++)
				tb_RemoveForeignKey(childArray[i], co_GetColNameByColTr(columnTr));
		}
			

		columnTr = columnTr.nextSibling;
	}


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

	//
	// tableDiv
	//
	var tableDiv = tb_GetTableDivByButton(this);
	
	document.body.removeChild(tableDiv);
	document.body.appendChild(tmpTable);

	tmpTable.style.background = COLOR_OBJ_DEFAULT;
	
	//
	// indexDiv
	//
	//@@@
	// what if we renamed the table??
	
	tmpTable = null;
	chosenTable = null;
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
* add this relationship to the tables
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


