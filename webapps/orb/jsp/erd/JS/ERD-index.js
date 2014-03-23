//
// gloabl variable for index
//
var tmpIndex = null;

var PRIMARY_KEY 	= "primary"
var FOREIGN_KEY 	= "foreign";
var IND_			= "IND_";
var PK_				= "PK_";
var FK_				= "FK_";



/////////////////////////////////////////////////////////
//						Definition:
/////////////////////////////////////////////////////////
//	indexDiv
//		columnHashTable
//			columnArray
// 				columnArray.unique
// 				columnArray.keyType
//
//				columnNameObj
//	 				columnNameObj.columnName
//	 				columnNameObj.desc
//
/////////////////////////////////////////////////////////

/**
*
* Note: indexDivId = "IND_" + tableName
*
**/
function in_GetTableName(indexDivId) {

	var i = indexDivId.indexOf('_');  
	var tableName = indexDivId.substring(i+1);
	
	return tableName;
}



/**
*
* Note: indexDivId = "IND_" + tableName
*
**/
function in_GetIndexDivByTableName(tableName) {

	var indexDivId = "IND_" + tableName;
	var indexDiv = document.getElementById(indexDivId);
	
	return indexDiv;
}

////////////////////////////////////////////////////////////////////////////////////////


/**
*
* add indexes
*
* @tableBody <TABLEBODY> from tableDiv.dataTd --> for getting table columns
*
* 	- indexDiv only store columns (for GUI purpose) from the parent table
*
*	- the true index columns are stored in the hash table 'columnHashTable'
*		where the hash key is the index name
*
**/
function in_CreateIndexDiv(tableName) {

	//
	// create one index DIV
	//
	indexDiv = document.createElement("div");
		indexDiv.id = "IND_" + tableName;	
		indexDiv.name = "IND_" + tableName;	
		indexDiv.align = "center";
		indexDiv.className = CL_DB_INDEX;
			indexDiv.style.position = "absolute";
			indexDiv.style.color = "captiontext";
			indexDiv.style.font = "caption";
			indexDiv.style.padding = "1px";
			indexDiv.style.margin = "0px";
			indexDiv.style.background = COLOR_INDEX_DIV;
			indexDiv.style.visibility = "hidden";		

	document.body.appendChild(indexDiv);

	//
	// index names
	//
	var inputTxt = document.createElement("input");
		inputTxt.className = CL_TEXT_INPUT;
		inputTxt.value = tableName;
		inputTxt.disabled = true;
	indexDiv.appendChild(inputTxt);

	//
	// for saving indexes columns
	//
	var columnHashTable = {};
	indexDiv.columnHashTable = columnHashTable;

	///////////////////////////////////////////////////////////
	if (!in_SetLocation(tableName)) {
		sy_logError("ERD-index", 
				"in_CreateIndexDiv", 
				"Error setting indexDiv location!!"
				+ " tableName: " + tableName);
		return null;
	}

/*
	if (!in_RefreshIndexDiv(tableName)) {
		sy_logError("ERD-index", 
				"in_CreateIndexDiv", 
				"Error refreshing indexDiv!!"
				+ " tableName: " + tableName);
		return null;
	}
*/

	///////////// from table /////////////////
	var tbody = tb_GetHtmlTableBody(tableName);
	if (tbody == null) {
		sy_logError("ERD-index", 
				"in_EditIndex", 
				"tableBody is null!!");
		return null;
	}

	//
	// cloen one table columns
	//
	var tableBody = tbody.cloneNode(true);
	///////////////////////////////////////

	var tbl = document.createElement("table");
		tbl.border ='0';
		tbl.cellSpacing='0';
		tbl.cellPadding='0';

	// html table
	var tbody = document.createElement("tbody");
	tbl.appendChild(tbody);

		// data tr
		var dataTr = document.createElement("tr");
		var dataTd = in_CreateDataTd(tableBody);
		dataTr.appendChild(dataTd);
		tbody.appendChild(dataTr);	


		// control tr
		var controlTr = document.createElement("tr");
		var controlTd = in_CreateControlTd(indexDiv);
		controlTr.appendChild(controlTd);

	tbody.appendChild(controlTr);
	indexDiv.appendChild(tbl);


	// some management works
//	choosenIndex = indexDiv.id;
//	ev_MakeOnTop(indexDiv);
	
	// we're done!!
	return indexDiv;
}


////////////////////////////////////////////////////////////////////////////////////////////



/**
*
* create a primary key index (into the hash table)
*
**/
function in_CreatePKeyIndex(tableName, columnHashTable) {
	
	// if we have one, update else create
	var pKeyArray = tb_GetPrimaryKeyArray(tableName);
	var indexColumnArray = columnHashTable["PK_" + tableName];

	//
	// copy the current 'desc' state 
	//	(if we add/remove a primary key
	//
	if (indexColumnArray != null) {
	
		for (var i=0;i<pKeyArray.length;i++) {

			var pKeyColumnName = pKeyArray[i].columnName;

			for (var j=0;j<indexColumnArray.length;j++) {

				var indexColumnName = indexColumnArray[j].columnName;

				if (pKeyColumnName == indexColumnName)
					pKeyArray[i].desc = indexColumnArray[j].desc
			}
		}
	}

	// set the unique flag and add it!!
	if (pKeyArray.length != 0) {

		pKeyArray.unique = true;
		pKeyArray.keyType = PRIMARY_KEY;

		columnHashTable["PK_" + tableName] = pKeyArray;
	
	} 

	return true;
}


/**
*
* create a foreign key index (into the hash table) for all parents
*
**/
function in_CreateFKeyIndex(tableName, columnHashTable) {

	var tableDiv = tb_GetTableObj(tableName);
	var parentArray = tableDiv.parentArray;
	
	if (parentArray == null) {
		sy_logError("ERD-index", 
				"in_CreateFKeyIndex", 
				"parent array is null for table: " + tableName);
		return false;
	}

	// for each parent
	for (var i=0;i<parentArray.length;i++) {
	
		var pTableDiv = tb_GetTableObj(parentArray[i]);
		var pTableName = pTableDiv.id;
		var pPKeyArray = tb_GetPrimaryKeyArray(pTableName);
		var indexColumnArray = columnHashTable["FK_" + pTableName + "__" + tableName];

		//
		// copy the current 'desc' state 
		//	(if we add/remove a primary key from the parent table
		//
		if (indexColumnArray != null) {

			for (var i=0;i<pPKeyArray.length;i++) {

				var pKeyColumnName = pPKeyArray[i].columnName;

				for (var j=0;j<indexColumnArray.length;j++) {

					var indexColumnName = indexColumnArray[j].columnName;

					if (pKeyColumnName == indexColumnName)
						pPKeyArray[i].desc = indexColumnArray[j].desc
				}
			}
		}

		
		pPKeyArray.unique = false;
		pPKeyArray.keyType = FOREIGN_KEY;

		columnHashTable["FK_" + pTableName + "__" + tableName] = pPKeyArray;
	}
	
	return true;
}



/////////////////////////////////////////////////////////////////////////////////////
//
// if we rename a table, we need to rename the following (for indexes):
//		- indexDivId
//		- primary key
//		- foreign key (for the 'parent' part)
//		- foreign key (for the 'child' part)
//
/////////////////////////////////////////////////////////////////////////////////////


/**
*
* if we rename table name, we need to rename index DIV id
*
**/
function in_RenameIndexDivId(oldPTableName, newPTableName) {

	var indexDiv = in_GetIndexDivByTableName(oldPTableName);
	indexDiv.id = "IND_" + newPTableName;

}


/**
*
* if we rename table name, we need to rename primary key index name
* 	eg. DB_USER --> ABC
*			PK_DB_USER --> PK_ABC
*			   ^^^^^^^		  ^^^
**/
function in_RenamePKeyIndex(oldPTableName, newPTableName) {

	var indexDiv = in_GetIndexDivByTableName(oldPTableName);
	
	if (indexDiv == null) // don't have any index, yet
		return;
	
	var columnHashTable = indexDiv.columnHashTable;
	var oldIndexName = "PK_" + oldPTableName;
	var newIndexName = "PK_" + newPTableName;
	
	var pKeyArray = columnHashTable[oldIndexName]; //save it!

	if (pKeyArray != null && pKeyArray.length >0) {
		delete columnHashTable[oldIndexName];
		columnHashTable[newIndexName] = pKeyArray;
	}
	
	return true;
}


/**
*
* if we rename parent table name, we need to rename index names in the child table
*
* eg. DB_USER_ROLE --> ABC
*		FK_DB_USER__DB_USER_ROLE --> FK_ABC__DB_USER_ROLE
*		   ^^^^^^^						^^^
**/
function in_RenameChildFKeyIndex(oldPTableName, newPTableName) {
	
	tableDiv = document.getElementById(newPTableName);

	var childArray = tableDiv.childArray;

	for (var i=0;i<childArray.length;i++) {

		var childTableName = childArray[i];

		var indexDiv = in_GetIndexDivByTableName(childTableName);

		if (indexDiv == null) // don't have index, yet
			return;

		var columnHashTable = indexDiv.columnHashTable;
		var oldIndexName = "FK_" + oldPTableName + "__" + childTableName;
		var newIndexName = "FK_" + newPTableName + "__" + childTableName;

		var fKeyArray = columnHashTable[oldIndexName]; 

		if (fKeyArray != null && fKeyArray.length != 0) {
			delete columnHashTable[oldIndexName];
			columnHashTable[newIndexName] = fKeyArray;
		}
	}

	return true;
}


/**
*
* if we rename table name, we need to rename foreign key index name
* eg. DB_USER_ROLE --> ABC
*		FK_DB_USER__DB_USER_ROLE --> FK_DB_USER__ABC
*				    ^^^^^^^^^^^^				 ^^^
**/
function in_RenameFKeyIndex(oldTableName, newTableName) {

	var indexDiv = in_GetIndexDivByTableName(oldTableName);
	
	if (indexDiv == null) // don't have any index, yet
		return;
	
	var columnHashTable = indexDiv.columnHashTable;
	
	for (var property in columnHashTable) {
		var indexName = property;
		
		var i = indexName.indexOf('_');
		var chkStr = indexName.substring(0, i);

		if (chkStr == "FK") {  // only interested in foreigh keys
		
			var j = indexName.indexOf('__');
			var parentTableName = indexName.substring(i+1, j);
			var chkTableName = indexName.substring(j+2);

			if (chkTableName == oldTableName) {
			
				var fKeyArray = columnHashTable[indexName];  //save it to temp
				delete columnHashTable[indexName];			 // delete the old one
				
				var newIndexName = "FK_" + parentTableName + "__" + newTableName;
				columnHashTable[newIndexName] = fKeyArray;
			}
			
		} 
		
	}	
	
	return true;
}


////////////////////////////////////////////////////////////////////////////////////////////


/**
*
* edit indexes (from tableDiv) 
*
**/
function in_EditIndex() {

	var tableName = tb_GetTableNameByButton(this);  // this --> "Index" button
	var indexDiv = in_GetIndexDivByTableName(tableName);

	// tag name
	var indexNameTag = indexDiv.firstChild;
	indexNameTag.value = tableName;
	indexNameTag.disabled = true;

	if (!in_SetLocation(tableName)) {
		sy_logError("ERD-index", 
				"in_EditIndex", 
				"Error setting indexDiv location!!"
				+ " tableName: " + tableName);
		return null;

	}

/*
	// remove table body (dataTD) --> see below 
	var table = indexDiv.firstChild.nextSibling;
	indexDiv.removeChild(table);
*/

	if (!in_RefreshIndexDiv(tableName)) {
		sy_logError("ERD-index", 
				"in_EditIndex", 
				"Error refreshing indexDiv!!"
				+ " tableName: " + tableName);
		return null;
	}
	
	indexDiv.style.visibility = "visible";		

	choosenIndex = indexDiv.id;
	ev_MakeOnTop(indexDiv);
	
	return indexDiv;
}




/**
*
* display a given indexDiv
*
**/
function in_SetLocation(tableName) {

	//
	// get table location
	//
	var tableDiv = tb_GetTableObj(tableName);
	
	if (tableDiv == null) {
		sy_logError("ERD-index", 
				"in_EditIndex0", 
				"indexDiv is null!! tableName: " + tableName);
		return false;
	}

	// index div position
	var tableDivLeft = ut_GetNumber(tableDiv.style.left);
	var tableDivTop = ut_GetNumber(tableDiv.style.top);
	
	if(tableDivLeft==null || tableDivTop==null) {
		sy_logError("ERD-index", 
				"in_EditIndex", 
				"Error getting table location!!"
				+ " tableDivLeft: " + tableDivLeft
				+ ", tableDivTop: " + tableDivTop);
		return false;
	}

	
	//
	// set index location
	//
	var indexDiv = in_GetIndexDivByTableName(tableName);

	indexDiv.style.left = (tableDivLeft+20) + "px";
	indexDiv.style.top = (tableDivTop+20) + "px";
	
	return true;
}


/**
*
* display a given indexDiv
*
**/
function in_ShowIndexDiv(tableName) {

	var indexDiv = in_GetIndexDivByTableName(tableName);
	
	if (indexDiv == null) {
		sy_logError("ERD-index", 
				"in_ShowIndexDiv", 
				"IndexDiv should not be null but it is!!"
				+ " tableName: " + tableName);
		return null;
	}

	ev_MakeOnTop(indexDiv);
	indexDiv.style.visibility = "visible";		
}


/**
*
* hide a given indexDiv
*
**/
function in_HideIndexDiv(tableName) {

	var indexDiv = in_GetIndexDivByTableName(tableName);
	
	if (indexDiv == null) {
		sy_logError("ERD-index", 
				"in_HideIndexDiv", 
				"IndexDiv should not be null but it is!!"
				+ " tableName: " + tableName);
		return null;
	}

	ev_MakeOnTop(indexDiv);
	indexDiv.style.visibility = "hidden";		
}


/**
*
* refresh a given indexDiv
*
*	- if we add/delete/rename the primary key
*	- change the primary key of the parent table
*
**/
function in_RefreshIndexDiv(tableName) {

	var indexDiv = in_GetIndexDivByTableName(tableName);
	if (indexDiv == null) {
		sy_logError("ERD-index", 
				"in_RefreshIndexDiv", 
				"IndexDiv should not be null but it is!!"
				+ " tableName: " + tableName);
		return false;
	}

	indexDiv.style.visibility = "hidden";		

	//
	// remove table body (dataTD) --> see below 
	//
	var htmlTable = indexDiv.firstChild.nextSibling;
	indexDiv.removeChild(htmlTable);


	//
	// column names from table
	//
	var tbody = tb_GetHtmlTableBody(tableName);
	if (tbody == null) {
		sy_logError("ERD-index", 
				"in_EditIndex", 
				"tableBody is null!!");
		return null;
	}

	// cloen one table columns
	var tableBody = tbody.cloneNode(true);
	///////////////////////////////////////


	//
	// index columns
	//
	var tbl = document.createElement("table");
		tbl.border ='0';
		tbl.cellSpacing='0';
		tbl.cellPadding='0';

	// html table
	var tbody = document.createElement("tbody");
	tbl.appendChild(tbody);

		// data tr
		var dataTr = document.createElement("tr");
		var dataTd = in_CreateDataTd(tableBody);
		dataTr.appendChild(dataTd);
		tbody.appendChild(dataTr);	


		// control tr
		var controlTr = document.createElement("tr");
		var controlTd = in_CreateControlTd(indexDiv);
		controlTr.appendChild(controlTd);

	tbody.appendChild(controlTr);
	indexDiv.appendChild(tbl);
	

	//
	// create primary/foreign keys
	//
	if (in_CreatePKeyIndex(tableName, indexDiv.columnHashTable) == false) {
		sy_logError("ERD-index", 
				"in_RefreshIndexDiv", 
				"Error adding primary index to the hashtable"
				+ " tableName: " + tableName);
		return false;
	}

	if (in_CreateFKeyIndex(tableName, indexDiv.columnHashTable) == false) {
		sy_logError("ERD-index", 
				"in_RefreshIndexDiv", 
				"Error adding foreign index(es) to the hashtable"
				+ " tableName: " + tableName);
		return false;
	} 


	if (in_RefreshSelect(indexDiv) == false) {
		sy_logError("ERD-index", 
				"in_RefreshIndexDiv", 
				"Error refreshing index name for select!!"
				+ " indexDivId=" + indexDivId);
		return false;
	}

	return true;
}


/**
*
* data td  --> index columns
*
**/
function in_CreateDataTd(tableBody) {

	var dataTd = document.createElement("td");
	var tbl = document.createElement("table");
		tbl.className = CL_HTML_TABLE;
		tbl.border ='1';
		tbl.cellSpacing='0';
		tbl.cellPadding='1';
		tbl.style.width="100%";

	var tbody = document.createElement("tbody");
	
	var columnTr = tableBody.firstChild;
	while(columnTr != null) {

		var newColumnTr = document.createElement("tr");		

		// select
		var selectTd = document.createElement("td");	
			selectTd.className = CL_CHECK_MARK;
			var checkBox = document.createElement("input");
				checkBox.type = "checkbox";
				checkBox.disabled = true;
			selectTd.appendChild(checkBox);
			newColumnTr.appendChild(selectTd);

		// primary key		
		var pKeyTd = document.createElement("td");
			pKeyTd.className = CL_PRIMARY_KEY;
			var primaryKey = document.createTextNode(co_GetPKeyByColTr(columnTr));
			pKeyTd.appendChild(primaryKey);
			newColumnTr.appendChild(pKeyTd);

		// column name		
		var columnTd = document.createElement("td");	
			columnTd.className = CL_COLUMN_NAME;
			var columnName = document.createTextNode(co_GetColNameByColTr(columnTr));
			columnTd.appendChild(columnName);
			newColumnTr.appendChild(columnTd);
		
		// desc
		var descTd = document.createElement("td");
			descTd.className = CL_CHECK_MARK;
			var checkBox = document.createElement("input");
				checkBox.type = "checkbox";
				checkBox.disabled = true;
			descTd.appendChild(checkBox);
			newColumnTr.appendChild(descTd);
		
		tbody.appendChild(newColumnTr);
		
		columnTr = columnTr.nextSibling;
	}

	tbl.appendChild(tbody);
	dataTd.appendChild(tbl);
	
	return dataTd;
}


/**
*
* create button TR
*
**/
function in_CreateControlTd(indexDiv) {

	controlTd = document.createElement("td");
	
	var tbl = document.createElement("table");
		tbl.className = CL_HTML_TABLE;
		tbl.border ='0';
		tbl.cellSpacing='0';
		tbl.cellPadding='2';

	var tbody = document.createElement("tbody");
	tbl.appendChild(tbody);
	
		////////////////////////////
		// for index name select
		////////////////////////////
		var tr = document.createElement("tr");
		tr.align = "left";

			//
			// index name select td
			//
			var iNameTd = in_CreateSelectTd(indexDiv);
			if (iNameTd == null) {
				sy_logError("ERD-index", 
						"in_CreateControlTd", 
						"Error creating index name select td!!");
				return null;
			}
			tr.appendChild(iNameTd);

			//
			// unique 
			//
			var uniqueTxtTd = document.createElement("td");
			var text = document.createTextNode("Unique:");
			uniqueTxtTd.appendChild(text);
			tr.appendChild(uniqueTxtTd);
			
			// unique checkbox
			var uniqueTd = document.createElement("td");
			uniqueTd.className = CL_UNIQUE_MARK;
			var checkBox = document.createElement("input");
				checkBox.type = "checkbox";
				checkBox.disabled = true;
			uniqueTd.appendChild(checkBox);

			tr.appendChild(uniqueTd);


		tbody.appendChild(tr);
	
	
		////////////////////////////
		// for buttons
		////////////////////////////
		var tr = document.createElement("tr");
		var buttonTd = in_CreateButtonTd();
		tr.appendChild(buttonTd);


	tbody.appendChild(tr);
	controlTd.appendChild(tbl);

	return controlTd;
}


/**
*
* select td for the index names
*
**/
function in_CreateSelectTd(indexDiv) {
	var td = document.createElement("td");

	//
	// create select
	//
	var select = document.createElement("select");
		select.onchange = in_IndexChosen;

		// some default values
		var opt = document.createElement("option");
			opt.value = "";
			opt.innerText = "";
		select.appendChild(opt);

		var opt = document.createElement("option");
			opt.value = TG_NEW_INDEX;
			opt.innerText = TG_NEW_INDEX;
			
	select.appendChild(opt);


	//
	// get the indexe names (through the column hash table)
	//		NOTE: index name are saved as hash key
	//
	var columnHashTable = indexDiv.columnHashTable;
	if (columnHashTable == null) {
		sy_logError("ERD-index", 
				"in_CreateSelectTd", 
				"columnHashTable is null!!"
				+ " indexDivId: " + indexDiv.id);
		return null;
	}
	
	
	// sort the indexe names
	var iNameArray = new Array();
	var i=0;
	for (var property in columnHashTable) {
		iNameArray[i] = property;
		i++;
	}	
	
	var iNameArray = ut_BubbleSort(iNameArray, 0, iNameArray.length - 1);


	// primary keys first
	for (var i=0;i<iNameArray.length;i++) {
	
		if (in_IsPKeyIndex(iNameArray[i])) {
		
			var opt = document.createElement("option");
				opt.value = iNameArray[i];
				opt.innerText = iNameArray[i];
			select.appendChild(opt);
		}
	}

	// forgien key(s)
	for (var i=0;i<iNameArray.length;i++) {
	
		if (in_IsFKeyIndex(iNameArray[i])) {
		
			var opt = document.createElement("option");
				opt.value = iNameArray[i];
				opt.innerText = iNameArray[i];
			select.appendChild(opt);
		}
	}
	
	// others
	for (var i=0;i<iNameArray.length;i++) {
	
		if (!in_IsPKeyIndex(iNameArray[i]) 
					&& !in_IsFKeyIndex(iNameArray[i])) {
					
			var opt = document.createElement("option");
				opt.value = iNameArray[i];
				opt.innerText = iNameArray[i];
			select.appendChild(opt);
		}
	}

	td.appendChild(select);
	return td;
}


/**
*
* buttons
*
**/
function in_CreateButtonTd() {

	var td = document.createElement("td");

	// delete button
	var deleteBtn = document.createElement("button");
	  deleteBtn.innerText = "Delete";
	  deleteBtn.onclick = in_EditDelete;
	  deleteBtn.className = CL_IN_COMMAND;
	td.appendChild(deleteBtn);

	// apply button
	var applyBtn = document.createElement("button");
	  applyBtn.innerText = "Apply";
	  applyBtn.onclick = in_EditOk;
	  applyBtn.className = CL_IN_COMMAND;
	td.appendChild(applyBtn);

	// cancel button
	var cancelBtn = document.createElement("button");
	  cancelBtn.innerText = "Cancel";
	  cancelBtn.onclick = in_EditCancel;
	  cancelBtn.className = CL_IN_COMMAND;
	td.appendChild(cancelBtn);

	// up button
	var upBtn = document.createElement("button");
	  upBtn.innerText = "Up";
	  upBtn.onclick = co_MoveColumnUp;
	  upBtn.className = CL_CO_COMMAND_TEXT;
	  upBtn.disabled = true;
	td.appendChild(upBtn);

	// down button
	var downBtn = document.createElement("button");
	  downBtn.innerText = "Down";
	  downBtn.onclick = co_MoveColumnDown;
	  downBtn.className = CL_CO_COMMAND_TEXT;
	  downBtn.disabled = true;
	td.appendChild(downBtn);

	return td;
}


/////////////////////////////////////////////////////////////////////////////////////


/**
*
* if this index is primary key index
*
**/
function in_IsPKeyIndex(indexDivId) {

	var i = indexDivId.indexOf('_');
	var chkStr = indexDivId.substring(0, i);

	if (chkStr == "PK") 
		return true;
	else
		return false;
}


/**
*
* if this index is foreign key index
*
**/
function in_IsFKeyIndex(indexDivId) {

	var i = indexDivId.indexOf('_');
	var chkStr = indexDivId.substring(0, i);

	if (chkStr == "FK") 
		return true;
	else
		return false;

}


/**
*
* this column is index column
*
**/
function in_IsIndexColumn(indexColumnArray, columnName) {

	if (indexColumnArray == null) // is a TG_NEW_INDEX
		return false;
	
	for (var i=0;i<indexColumnArray.length;i++) {
	
		var columnNameObj = indexColumnArray[i];
	
		if (columnNameObj.columnName == columnName)
			return true;
	}
	
	return false;
}


/**
*
* save it to the hash table (in the indexDiv)
*
**/
function in_SaveIndex(indexDiv, indexName) {

	var indexDivId = indexDiv.id;

	if (("IND_" + indexName) != indexDivId) {  // indexDivId --> blank form 
											   // 	(don't want to save it)

		var columnHashTable = indexDiv.columnHashTable;

		// delete the old one
		delete columnHashTable[indexName];

		// for the new one
		var tbody = tb_GetHtmlTableBody(indexDivId);
		var columnTr = tbody.firstChild;

		var columnArray = new Array();
		
		var i=0
		while(columnTr != null) {
	
			var columnName = in_GetColNameByColTr(columnTr);

			// is an index column?				
			var selectTd = columnTr.firstChild;
			var colChkBox = selectTd.firstChild;

			if (colChkBox.checked) {  

				var columnNameObj = new Object();
				
				// column name
				columnNameObj.columnName = columnName;
				
				// desc?
				var selectTd = columnTr.lastChild;
				var colChkBox = selectTd.firstChild;

				if (colChkBox.checked)
					columnNameObj.desc = true;
				else 
					columnNameObj.desc = false;


				columnArray[i] = columnNameObj;
				
				i++;
			}

			columnTr = columnTr.nextSibling;
		}

		// a unique index?
		var uniqueTd = in_GetUniqueTd(indexDivId);
		var checkBox = uniqueTd.firstChild;
		
		if(checkBox.checked == true)  
			columnArray.unique=true;
		else	
			columnArray.unique=false;

		//
		// save it!!
		//
		columnHashTable[indexName] = columnArray;
		
		
		if (in_RefreshSelect(indexDiv) == false) {
			sy_logError("ERD-index", 
					"in_SaveIndex", 
					"Error refreshing index name for select!!"
					+ " indexDivId=" + indexDivId);
			return false;
		}
	}
	
	return true;
}


/**
*
* if we have a new index or we rename one
*
**/
function in_RefreshSelect(indexDiv) {
		
	var indexDivId = indexDiv.id;
	
	// old select td
	var iNameSelectTd = in_GetINameSelectTd(indexDivId);
	if (iNameSelectTd == null) {
		sy_logError("ERD-index", 
				"in_RefreshSelect", 
				"Error getting old index name select td!!"
				+ " indexDivId=" + indexDivId);
		return false;
	}	
	
	// new select td
	var newINameSelectTd = in_CreateSelectTd(indexDiv);
	if (newINameSelectTd == null) {
		sy_logError("ERD-index", 
				"in_RefreshSelect", 
				"Error creating new index name select td!!"
				+ " indexDivId=" + indexDivId);
		return false;
	}	

	// replace the old one with the new one
	var iNameSelectTr = iNameSelectTd.parentElement;
	iNameSelectTr.replaceChild(newINameSelectTd, iNameSelectTd);
	
	return true;
}


/**
*
* if index name is renamed, modify the hash table
*
**/
function in_RenameIndex() {

	// old index name
	var oldIndexName = selectedValue;

	// new index name
	var indexDiv = this.parentElement;  // "this" ==> index name input text
	var indexNameTag = indexDiv.firstChild;
	var newIndexName = indexNameTag.value;

	// if name changed
	if (oldIndexName != TG_NEW_INDEX && oldIndexName != newIndexName) {

		var columnHashTable = indexDiv.columnHashTable;
		var indexColumnArray = columnHashTable[oldIndexName];
		
		delete columnHashTable[oldIndexName];
		columnHashTable[newIndexName] = indexColumnArray; 
		
		selectedValue = newIndexName;

		if (in_RefreshSelect(indexDiv) == false) {
			sy_logError("ERD-index", 
					"in_RenameIndex", 
					"Error refreshing index name for select!!"
					+ " indexDivId=" + indexDivId);
			return false;
		}

	}

}



////////////////////////////////////////
// global variable for renaming
////////////////////////////////////////

var selectedValue; 

////////////////////////////////////////



/**
*
* choosed this index name from the index name select pull-down
*
**/
function in_IndexChosen() {

	var indexName = this.options[this.selectedIndex].value;  
								// this --> index name select
	
	// save the index name to the temp (for name change --> in_RenameIndex())
	selectedValue = indexName;

	if (indexName != "") {  // blank one (in which selectedIndex=0)

		var indexDiv = in_GetIndexDivBySelect(this);
		var indexDivId = indexDiv.id;
		var indexNameTag = indexDiv.firstChild;
		
		oldIndexName = indexNameTag.value;

		if (oldIndexName == null) {
			// user didn't enter the index name
			this.selectedIndex = 0;
			return true;
		}
		
		if (indexName == oldIndexName) {
			// don't need to change
			this.selectedIndex = 0;
			return true;
		}
		
		////////////////////////////////////////
		// save the old one to the hash table
		////////////////////////////////////////
		if (in_SaveIndex(indexDiv, oldIndexName) == false) {
			sy_logError("ERD-index", 
					"in_IndexChosen", 
					"Error saving index: " + oldIndexName);
			return false;
		}


		////////////////////////////////////////
		// display the new one
		////////////////////////////////////////

		// display the index name on the name tag
			
		indexNameTag.value = indexName;
		indexNameTag.onchange = in_RenameIndex;
		
		if (in_IsPKeyIndex(indexName) || in_IsFKeyIndex(indexName)) {
			indexNameTag.disabled = true;
		} else {
			indexNameTag.disabled = false;
			indexNameTag.focus();
			indexNameTag.select();
		}


		in_MoveSelectedColumnUp(indexDiv, indexName);

		// index columns
		var columnHashTable = indexDiv.columnHashTable;
		var indexColumnArray = columnHashTable[indexName];

		var tbody = tb_GetHtmlTableBody(indexDivId);
		var columnTr = tbody.firstChild;

		while(columnTr != null) {

			//
			// select
			//
			var selectTd = columnTr.firstChild;
			var select = selectTd.firstChild;

			if (in_IsIndexColumn(indexColumnArray, 
									in_GetColNameByColTr(columnTr)))
				select.checked = true;
			else
				select.checked = false;


			if (in_IsPKeyIndex(indexName) || in_IsFKeyIndex(indexName)) {
				select.disabled  = true;
			} else {
				select.onclick = in_EnableDescObj;
				select.disabled  = false;
			}
			
			//
			// column names will NOT change here!!!
			//
			
			//
			// desc
			//
			var descTd = columnTr.lastChild;
			var desc = descTd.firstChild;
			var columnName = in_GetColNameByColTr(columnTr);
			
			if (indexName == TG_NEW_INDEX) {
			
				// select.onclick (in_EnableDescObj) will enabel it if necessary
				desc.disabled = true;
				desc.checked = false;
			
			} else if (in_IsIndexColumn(indexColumnArray, columnName)) {

				desc.disabled = false;
				desc.checked = getDescFlag(indexColumnArray, columnName);
				//object.defaultChecked = getDescFlag(indexColumnArray, columnName);
				
			} else {

				desc.disabled = true;
				desc.checked = false;
			}
			
			columnTr = columnTr.nextSibling;
		}


		// unique
		var uniqueTd = in_GetUniqueTd(indexDivId);
		var unique = uniqueTd.firstChild;


		if (indexName != TG_NEW_INDEX 
				&& indexColumnArray.unique == true)
				
			unique.checked = true;
		else
			unique.checked = false;

		if (in_IsPKeyIndex(indexName) || in_IsFKeyIndex(indexName))
			unique.disabled  = true;
		else
			unique.disabled  = false;

	}
	
	this.selectedIndex = 0;
	return true;
}


/**
*
* Is this column desc?
*
**/
function getDescFlag(indexColumnArray, columnName) {

	for (var i=0; i<indexColumnArray.length; i++) {
	
		var columnNameObj = indexColumnArray[i];
	
		if (columnNameObj.columnName == columnName)
			return columnNameObj.desc;
	}
	
	return false;
}


/**
*
* move selected columns up
*
**/
function in_MoveSelectedColumnUp(indexDiv, selectedValue) {
		
	if (selectedValue != TG_NEW_INDEX) {
	
		var indexDivId = indexDiv.id;
		var columnHashTable = indexDiv.columnHashTable;

		var indexColumnArray = columnHashTable[selectedValue];

		var htmlTable = tb_GetHtmlTable(indexDivId);
		var tbody = htmlTable.firstChild;
		
		var newTBody = document.createElement("tbody");

		// selected columns
		var columnTr = tbody.firstChild;
		while(columnTr != null) {

			if (in_IsIndexColumn(indexColumnArray, in_GetColNameByColTr(columnTr)))
				newTBody.appendChild(columnTr.cloneNode(true));

			columnTr = columnTr.nextSibling;
		}


		// non selected columns
		var columnTr = tbody.firstChild;
		while(columnTr != null) {

			if (!in_IsIndexColumn(indexColumnArray, in_GetColNameByColTr(columnTr)))
				newTBody.appendChild(columnTr.cloneNode(true));

			columnTr = columnTr.nextSibling;
		}

		htmlTable.replaceChild(newTBody, tbody);
		tbody = null;
	}
}


/**
*
* if we select this column, we can set whether we want to sort 
*	as desc on this column or not
*
**/
function in_EnableDescObj() {

	var selectTd = this.parentElement;  // this --> select check box
	var selectTr = selectTd.parentElement;
	
	var descTd = selectTr.lastChild;
	var descChkBox = descTd.firstChild;

	if (this.checked == true)
		descChkBox.disabled = false;
	else {
		descChkBox.checked = false;
		descChkBox.disabled = true;
	}
}



////////////////////////////////////////////////////////////////////////////////////////////////////


/**
*
* 
*

function in_GetIndexNameByNameTag(indexNameTag) {

	var indexName;
	if (indexNameTag.tagName == null) 
		indexName = indexNameTag.data;
	else
		indexName = indexNameTag.value;

	if (indexName == TG_NEW_INDEX || indexName == "") {
		alert("Please enter index name.");
		return null;
	}
	
	return indexName;
}
**/

/**
*
* get control td
*
**/
function in_GetControlTd(indexDivId) {

	var controlTr = tb_GetControlTr(indexDivId);
	if (controlTr == null) {
		sy_logError("ERD-index", 
				"in_GetControlTd", 
				"controlTr is null for indexDivId: " + indexDivId);
		return null;
	}
	
	var controlTd = controlTr.firstChild;

	return controlTd;
}


/**
*
* retrieve index name select td
*
**/
function in_GetINameSelectTd(indexDivId) {

	var controlTd = in_GetControlTd(indexDivId);
	if (controlTd == null) {
		sy_logError("ERD-index", 
				"in_GetINameSelectTd", 
				"controlTd is null for indexDivId: " + indexDivId);
		return null;
	}
	
	var table = controlTd.firstChild;
	var tbody = table.firstChild;
	var tr = tbody.firstChild;
	var iNameSelectTd = tr.firstChild;

	return iNameSelectTd;
}


/**
*
* 
*
**/
function in_GetUniqueTd(indexDivId) {

	var controlTd = in_GetControlTd(indexDivId);
	if (controlTd == null) {
		sy_logError("ERD-index", 
				"in_GetUniqueTd", 
				"controlTd is null for indexDivId: " + indexDivId);
		return null;
	}

	var table = controlTd.firstChild;
	var tbody = table.firstChild;
	var tr = tbody.firstChild;
	//var iNameSelectTd = tr.firstChild;
	//var uniqueTxtTd = iNameSelectTd.nextSibling;
	var uniqueTd = tr.lastChild;

	return uniqueTd;
}


/**
*
* Retrieve column name key 
*
**/
function in_GetColNameByColTr(columnTr) {

	var checkTd = columnTr.firstChild;  // select checkbox
	var pKeyTd = checkTd.nextSibling;	// primary key
	var columnTd = pKeyTd.nextSibling;	// column name
	var text = columnTd.firstChild
	
	return text.data;
}


/**
*
* 
*
**/
function in_GetIndexDivByButton(button) {

	var buttonTd = button.parentElement;
	var buttonTr = buttonTd.parentElement;
	var tbody = buttonTr.parentElement;
	var table = tbody.parentElement;
	var controlTd =table.parentElement;
	
	var controlTr = controlTd.parentElement;
	var htmlTbody = controlTr.parentElement;
	var htmlTable = htmlTbody.parentElement;
	var indexDiv = htmlTable.parentElement;
	
	return indexDiv;
}


/**
*
* 
*
**/
function in_GetIndexDivBySelect(object) {
	
	var selectTd = object.parentElement;
	var selectTr = selectTd.parentElement;
	var selectTbody = selectTr.parentElement;
	var selectTable = selectTbody.parentElement;

	var controlTd = selectTable.parentElement;
	var controlTr = controlTd.parentElement;
	
	var tbody = controlTr.parentElement;
	var table = tbody.parentElement;
	
	var indexDiv = table.parentElement;

	return indexDiv;
}


////////////////////////////////////////////////////////////////////////////////////

/**
*
* 
*
**/
function in_EditDelete() {
}


/**
*
* 
*
**/
function in_EditOk() {

	var indexDiv = in_GetIndexDivByButton(this);

	// save it
	var indexNameTag = indexDiv.firstChild;
	var indexName = indexNameTag.value;
	
	if (indexName == null) {
		this.selectedIndex = 1;
		return;
	}

	if (in_SaveIndex(indexDiv, indexName) == false) {
		sy_logError("ERD-index", 
				"in_EditOk", 
				"Error saving index: " + oldIndexName);
		return false;
	}

	indexDiv.style.visibility = "hidden";	 	

	tableDiv.style.background = COLOR_OBJ_DEFAULT;
	selectedObj = null;
	choosenIndex = null;

	return true;
}


/**
*
* 
*
**/
function in_EditCancel() {


	choosenIndex = null;
}


////////////////////////////////////////////////////////////////////////////////////////


/**
*
* print out primary key column names for a give table
*
**/
function in_Debug_IndexColumn(tableName) {

	var indexDiv = in_GetIndexDivByTableName(tableName);

	var columnHashTable = indexDiv.columnHashTable;

	var pKeyArray = columnHashTable["PK_" + tableName];
	
	var outStr = "name: " + tableName + "\n" 
				+ "keyType: " + pKeyArray.keyType + "\n";
	
	for (var i=0;i<pKeyArray.length;i++) {
		var columnNameObj = pKeyArray[i];
		outStr = outStr + "   " + columnNameObj.columnName + "\n";
	}

	alert(outStr);

}


