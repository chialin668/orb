//
// gloabl variable for index
//
var tmpIndex = null;


var PRIMARY_KEY 	= "primary"
var FOREIGN_KEY 	= "foreign";
var IND_			= "IND_";
var PK_				= "PK_";
var FK_				= "FK_";

/**
*
*	indexDiv
*		indexNameTag
*		columnHashTable[indexName] = columnArray (see below ***)
*					indexName:
*						PK_tableName
*						FK_parentTable__childTable
*
*			*** NOTE: columnArray: 
*				columnObj
*					columnObj.columnName
*					columnObj.desc (true/false)
*
*				keyType (primary/foreign)
*				unique (true/false)
*
*		<table>
*			<tbody>
*				<tr>  (dataTr)
*					<td>
*						<table>
*							<tbody>
*								<tr><td> { select }
*								<tr><td> { primary key }
*								<tr><td> { columnName }
*								<tr><td> { desc }
*				<tr>  (controlTr)
*					<td>
*						<table>
*							<tbody>
*								<tr><td><button>
*								<tr><td><button>
*								<tr><td><button>
*
**/


////////////////////////////////////////////////////////////////////////////////////////


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




////////////////////////////////////////////////////////////////////////////////////////


/**
*
* create a primary key index (into the hash table)
*
**/
function in_CreatePKeyIndex(tableName, columnHashTable) {
	
	
	var pKeyArray = tb_GetPrimaryKeyArray(tableName);
	
	if (pKeyArray == null) {
		sy_logError("ERD-index", 
				"in_CreatePKeyIndex", 
				"primary key array is null for table: " + tableName);
		return false;
	}

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
		
		if (parentArray == null) {
			sy_logError("ERD-index", 
					"in_CreateFKeyIndex", 
					"parent array is null for table: " + tableName
					+ ", parent table: " + pTableName);
			return false;
		}
		
		pPKeyArray.unique = false;
		pPKeyArray.keyType = FOREIGN_KEY;

		columnHashTable["FK_" + pTableName + "__" + tableName] = pPKeyArray;
		
	}
	
	return true;
}

////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////
//	if we renamed the table, do the folloging....
////////////////////////////////////////////////////

/**
*
* if we rename table name, we need to rename index DIV id
*
**/
function in_RenameIndexDivId(oldPTableName, newPTableName) {

	var indexDivId = "IND_" + oldPTableName;
	var indexDiv = document.getElementById(indexDivId);
	indexDiv.id = "IND_" + newPTableName;
}


/**
*
* if we rename table name, we need to rename primary index name
*
* 	eg. DB_USER --> ABC
*			PK_DB_USER --> PK_ABC
*
**/
function in_RenamePKeyIndex(oldPTableName, newPTableName) {

	var indexDivId = "IND_" + oldPTableName;
	var indexDiv = document.getElementById(indexDivId);
	
	if (indexDiv == null) // don't have index, yet
		return;
	
	var columnHashTable = indexDiv.columnHashTable;
	var oldIndexName = "PK_" + oldPTableName;
	var newIndexName = "PK_" + newPTableName;
	
	var pKeyArray = columnHashTable[oldIndexName]; 
	delete columnHashTable[oldIndexName];
	columnHashTable[newIndexName] = pKeyArray;
}


/**
*
* if we rename table name, we need to rename foreign key index name for this table
*
* eg. DB_USER_ROLE --> ABC
*		FK_DB_USER__DB_USER_ROLE --> FK_DB_USER__ABC
*				    ^^^^^^^^^^^^				 ^^^
**/
function in_RenameFKeyIndex(oldTableName, newTableName) {

	var indexDivId = "IND_" + oldTableName;
	var indexDiv = document.getElementById(indexDivId);
	
	if (indexDiv == null) // don't have index, yet
		return;
	
	var columnHashTable = indexDiv.columnHashTable;
	
	for (var property in columnHashTable) {
		var indexName = property;
		
		var i = indexName.indexOf('_');
		var chkStr = indexName.substring(0, i);

		if (chkStr == "FK") {
		
			var j = indexName.indexOf('__');
			var parentTableName = indexName.substring(i+1, j);
			var childTableName = indexName.substring(j+2);

			if (childTableName == oldTableName) {
			
				var fKeyArray = columnHashTable[indexName];  //save it to temp
				delete columnHashTable[indexName];			 // delete the old one
				indexName = "FK_" + parentTableName + "__" + newTableName;
				columnHashTable[indexName] = fKeyArray;
			}
			
		} 
		
	}	
	
}


/**
*
* if we rename parent table name, we need to rename index names in the child table
*
* eg. DB_USER_ROLE --> ABC
*		FK_DB_USER__DB_USER_ROLE --> FK_ABC__DB_USER_ROLE
*		   ^^^^^^^						^^^
**/
function in_RenameChildFKeyIndex(oldPTableName, newPTableName, cTableName) {
	
	var indexDivId = "IND_" + cTableName;
	var indexDiv = document.getElementById(indexDivId);
	
	if (indexDiv == null) // don't have index, yet
		return;
	
	var columnHashTable = indexDiv.columnHashTable;
	var oldIndexName = "FK_" + oldPTableName + "__" + cTableName;
	var newIndexName = "FK_" + newPTableName + "__" + cTableName;
	
	var pKeyArray = columnHashTable[oldIndexName]; 
	delete columnHashTable[oldIndexName];
	columnHashTable[newIndexName] = pKeyArray;
	
	return true;
}


////////////////////////////////////////////////////////////////////////////////////////////

/**
*
* edit indexes (from tableDiv) 
*
**/
function in_EditIndex() {

	var tableName = tb_GetTableNameByButton(this);
	indexDiv = in_EditIndex0(tableName);

	if (indexDiv == null) {
		sy_logError("ERD-index", 
				"in_EditIndex", 
				"indexDiv is null!! tableName: " + tableName);
		return null;
	}
	
	indexDiv.style.visibility = "visible";		
	
	return indexDiv;
}



/**
*
* edit indexes (if we have table name) ---> for ERD-xmlschema
*
**/
function in_EditIndex0(tableName) {

	// table body from tableDiv
	var tableDiv = tb_GetTableObj(tableName);
	var tbody = tb_GetHtmlTableBody(tableName);
	var tableBody = tbody.cloneNode(true);
	
	if (tableBody == null) {
		sy_logError("ERD-index", 
				"in_EditIndex", 
				"tableBody is null!!");
		return null;
	}


	// for index div position
	tableDivLeft = ut_GetNumber(tableDiv.style.left);
	tableDivTop = ut_GetNumber(tableDiv.style.top);
	
	if(tableDivLeft==null || tableDivTop==null) {
		sy_logError("ERD-index", 
				"in_EditIndex", 
				"Error getting table location!!"
				+ " tableDivLeft: " + tableDivLeft
				+ ", tableDivTop: " + tableDivTop);
		return null;
	}


	indexDiv = in_AddIndex(tableName, tableDivTop+20, tableDivLeft+20, tableBody);

	if (indexDiv == null) {
		sy_logError("ERD-index", 
				"in_EditIndex", 
				"Error creating index div!!");
		return null;
	}
		
	choosenIndex = indexDiv.id;
	ev_MakeOnTop(indexDiv);
	
	return indexDiv;
}


/**
*
* add indexes
*
**/
function in_AddIndex(tableName, top, left, tableBody) {

	var indexDivId = "IND_" + tableName;
	var indexDiv = document.getElementById(indexDivId);
	
	if (indexDiv == null) {

		indexDiv = document.createElement("div");
			indexDiv.id = "IND_" + tableName;	
			indexDiv.name = "IND_" + tableName;	
			indexDiv.align = "center";
			indexDiv.className = CL_DB_INDEX;
				indexDiv.style.position = "absolute";
				indexDiv.style.top = top + "px";
				indexDiv.style.left = left + "px";
				indexDiv.style.color = "captiontext";
				indexDiv.style.font = "caption";
				indexDiv.style.padding = "1px";
				indexDiv.style.margin = "0px";
				indexDiv.style.background = COLOR_INDEX_DIV;

				indexDiv.style.visibility = "hidden";		
	
		document.body.appendChild(indexDiv);

		// index name tag
		var indexNameTag = document.createElement("input");
			indexNameTag.type = "text";
			indexNameTag.className = CL_TEXT_INPUT;
			indexNameTag.value = tableName;
			indexNameTag.disabled = true;
		indexDiv.appendChild(indexNameTag);


		//
		// index hash table (for saving indexe columns)
		//
		var columnHashTable = {};
		indexDiv.columnHashTable = columnHashTable;

		//
		// primary/foreigh key indexes
		//
		if (in_CreatePKeyIndex(tableName, columnHashTable) == false) {
			sy_logError("ERD-index", 
					"in_AddIndex", 
					"Error adding primary index to the hashtable"
					+ " tableName: " + tableName);
			return null;
		}

		if (in_CreateFKeyIndex(tableName, columnHashTable) == false) {
			sy_logError("ERD-index", 
					"in_AddIndex", 
					"Error adding foreign index(es) to the hashtable"
					+ " tableName: " + tableName);
			return null;
		} 

	} else {

		// index name
		var indexNameTag = indexDiv.firstChild;
		indexNameTag.value = tableName;
		
		// remove html table
		var table = indexNameTag.nextSibling;
		indexDiv.removeChild(table);
	
		// index div position
		tableDivLeft = ut_GetNumber(tableDiv.style.left);
		tableDivTop = ut_GetNumber(tableDiv.style.top);
		indexDiv.style.top = (top+20) + "px";
		indexDiv.style.left = (left+20) + "px";


		indexDiv.style.visibility = "visible";		
	}


	//////////////////////////////////////////
	// the columns could be changed.  
	//	--> we always refresh the columns
	//////////////////////////////////////////
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
	
	return indexDiv;
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
				var selectChkBox = document.createElement("input");
				selectChkBox.type = "checkbox";
				selectChkBox.className = CL_CHECKBOX;
				selectChkBox.checked = false;
				selectChkBox.disabled = true;
				selectChkBox.onclick = in_EnableDescObj;
				selectTd.appendChild(selectChkBox);
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
				var descChkBox = document.createElement("input");
				descChkBox.type = "checkbox";
				descChkBox.className = CL_CHECKBOX;
				descChkBox.checked = false;
				descChkBox.disabled = true;
			descTd.appendChild(descChkBox);
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

			var uniqueTd = document.createElement("td");
			uniqueTd.className = CL_UNIQUE_MARK;
				var uniqueChkBox = document.createElement("input");
				uniqueChkBox.type = "checkbox";
				uniqueChkBox.className = CL_CHECKBOX;
				uniqueChkBox.checked = false;
				uniqueChkBox.disabled = true;
			uniqueTd.appendChild(uniqueChkBox);
			tr.appendChild(uniqueTd);


		tbody.appendChild(tr);
	
	
		// buttons
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
	// select
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
	// for known indexes
	//
	var columnHashTable = indexDiv.columnHashTable;
	
	if (columnHashTable == null) {
		sy_logError("ERD-index", 
				"in_CreateSelectTd", 
				"columnHashTable is null!!"
				+ " indexDivId: " + indexDiv.id);
		return null;
	}
	
	//
	// sort the indexe names
	//
	var indexNameArray = new Array();
	i=0;
	for (var property in columnHashTable) {
		indexNameArray[i] = property;
		i++;
	}	
	var indexNameArray = bubbleSort(indexNameArray, 0, indexNameArray.length - 1);


	// primary keys first
	for (var i=0;i<indexNameArray.length;i++) {
	
		if (in_IsPKeyIndex(indexNameArray[i])) {
		
			var opt = document.createElement("option");
				opt.value = indexNameArray[i];
				opt.innerText = indexNameArray[i];
			select.appendChild(opt);
		}
	}

	// foreign key
	for (var i=0;i<indexNameArray.length;i++) {
	
		if (in_IsFKeyIndex(indexNameArray[i])) {
		
			var opt = document.createElement("option");
				opt.value = indexNameArray[i];
				opt.innerText = indexNameArray[i];
			select.appendChild(opt);
		}
	}
	
	// then, others
	for (var i=0;i<indexNameArray.length;i++) {
	
		if (!in_IsPKeyIndex(indexNameArray[i]) 
					&& !in_IsFKeyIndex(indexNameArray[i])) {
					
			var opt = document.createElement("option");
				opt.value = indexNameArray[i];
				opt.innerText = indexNameArray[i];
			select.appendChild(opt);
		}
	}

	td.appendChild(select);
	
	return td;
}


/**
*
* 
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
* display index columns (in text mode) when you click "Index" from tableDiv
*

function in_DisplayEmptyIndex(tableName) {

	var indexDiv = document.getElementById("IND_" + tableName);

	// index name tag ---> table name
	var indexNameTag = indexDiv.firstChild;
	
	if (indexNameTag.data == null) {  
		// is an input text
		var text = ut_InputTextToText(indexNameTag);
		text.data = tableName;
		indexDiv.replaceChild(text, indexNameTag);
	} else 
		// is a text field
		indexNameTag.data = tableName;

			
	// index column select check box ---> text
	var indexDivId = indexDiv.id;
	var htmlTableBody = tb_GetHtmlTableBody(indexDivId);
	var columnTr = htmlTableBody.firstChild;
	
	while(columnTr != null) {
		// disable highlight??? @@@
		columnTr.style.backgroundColor = DEFAULT_BG_COLOR;
		
		//
		// convert everything to text (no checkboxes)
		//
		
		// column select checkbox ---> empty text 
		var checkBoxTd = columnTr.firstChild;
		var object = checkBoxTd.firstChild;

		if (object.data == null) {
			var text = ut_CheckBoxToText(object);
			text.data = EMPTY_STRING;
			checkBoxTd.replaceChild(text, object);
		} else
			object.data = EMPTY_STRING;

		// desc	checkbox ---> text
		var descTd = columnTr.lastChild;
		var object = descTd.firstChild;
		
		if (object.data == null) {
			var text = ut_CheckBoxToText(object);
			text.data = EMPTY_STRING;
			descTd.replaceChild(text, object);
		} else
			object.data = EMPTY_STRING;
		
			
		columnTr = columnTr.nextSibling;
	}
	
	// index name select pulldown  
	//		---> display empty in the pull down
	var selectTd = in_GetINameSelectTd(indexDivId);
	if (selectTd == null) {
		sy_logError("ERD-index", 
				"in_DisplayEmptyIndex", 
				"Error getting index name select TD!!"
				+ " indexDivId: " + indexDivId);
		return false;
	}
	
	var select = selectTd.firstChild;
	select.selectedIndex = 0;
	
	// unique checkbox
	var uniqueTd = in_GetUniqueTd(indexDivId);
	if (uniqueTd == null) {
		sy_logError("ERD-index", 
				"in_DisplayEmptyIndex", 
				"Error getting unique TD!!"
				+ " indexDivId: " + indexDivId);
		return false;
	}
	
	var checkBox = uniqueTd.firstChild;
	if (checkBox.data == null) {
		var text = ut_CheckBoxToText(checkBox);
		text.data = EMPTY_STRING;
		uniqueTd.replaceChild(text, checkBox);
	} else
		checkBox.data = EMPTY_STRING;

	
	return true;
}
**/

/**
*
* if this index is primary key index
*
**/
function in_IsPKeyIndex(indexName) {

	var i = indexName.indexOf('_');
	var chkStr = indexName.substring(0, i);

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
function in_IsFKeyIndex(indexName) {

	var i = indexName.indexOf('_');
	var chkStr = indexName.substring(0, i);

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

	if (indexColumnArray == null) return false;
	
	for (var i=0;i<indexColumnArray.length;i++) {
	
		if (indexColumnArray[i].columnName == columnName)
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

	if (("IND_" + indexName) != indexDivId) {

		var columnHashTable = indexDiv.columnHashTable;

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

				
				// is desc?
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

		//
		// a unique index?
		//
		var uniqueTd = in_GetUniqueTd(indexDivId);
		var checkBox = uniqueTd.firstChild;
		
		if(checkBox.checked == true)  
			columnArray.unique=true ;
		else	
			columnArray.unique=false;

		columnHashTable[indexName] = columnArray;
		
		if (in_RefreshSelect(indexDiv) == false) {
			sy_logError("ERD-index", 
							"in_SaveIndex", 
							"Error refreshing select select after saving..."
							+ " indexName: " + indexName);
			return false;
		}
		
		//
		// don't change the key type
		//
		
	}
	
//	alert(indexName + ".. saved");
	return true;
}


/**
*
* if we have a new index or we rename one
*
*	NOTE: Just re-create a new one (and replace the old one)
*
**/
function in_RefreshSelect(indexDiv) {
		
	var indexDivId = indexDiv.id;
	var iNameSelectTd = in_GetINameSelectTd(indexDivId);
	var iNameSelectTr = iNameSelectTd.parentElement;
	
	var newINameSelectTd = in_CreateSelectTd(indexDiv);
	
	if (newINameSelectTd == null) {
		sy_logError("ERD-index", 
				"in_RefreshSelect", 
				"Error creating index name select td!!"
				+ " indexDivId=" + indexDivId);
		return false;
	}	

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
	var newIndexName = in_GetIndexNameByNameTag(indexNameTag);

	// if name changed
	if (oldIndexName != TG_NEW_INDEX && oldIndexName != newIndexName) {

		var columnHashTable = indexDiv.columnHashTable;
		var indexColumnArray = columnHashTable[oldIndexName];
		
		delete columnHashTable[oldIndexName];
		columnHashTable[newIndexName] = indexColumnArray; 
		
		selectedValue = newIndexName;

		in_RefreshSelect(indexDiv);
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

	var indexName = this.options[this.selectedIndex].value;  // this --> select
	
	// save the index name to the temp (for name change --> in_RenameIndex())
	selectedValue = indexName;

	if (indexName != "") {

		var indexDiv = in_GetIndexDivBySelect(this);
		var indexDivId = indexDiv.id;
		var indexNameTag = indexDiv.firstChild;
		
		oldIndexName = in_GetIndexNameByNameTag(indexNameTag);

		if (oldIndexName == null) {
			// user didn't enter the index name
			this.selectedIndex = 0;
			return;
		}
		
		if (indexName == oldIndexName) {
			// don't need to change
			this.selectedIndex = 0;
			return;
		}
		
		////////////////////////////////////////
		// save the old one to the hash table
		////////////////////////////////////////
		if (in_SaveIndex(indexDiv, oldIndexName) == false) {
			sy_logError("ERD-index", 
					"in_IndexChosen", 
					"Error saving index: " + oldIndexName);
			return;
		}


		////////////////////////////////////////
		// display the new one
		////////////////////////////////////////

		// display the index name on the name tag
		indexNameTag.value = indexName;

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
			var selectChkBox = selectTd.firstChild;
			selectChkBox.onclick = in_EnableDescObj;  // keep this!!

			if (in_IsIndexColumn(indexColumnArray, in_GetColNameByColTr(columnTr)))
				selectChkBox.checked = true;
			else
				selectChkBox.checked = false;
			
			if (in_IsPKeyIndex(indexName) || in_IsFKeyIndex(indexName))
				selectChkBox.disabled = true;
			else
				selectChkBox.disabled = false;
				
				
			//
			// column name --> do nothing
			//


			//
			// desc
			//
			var descTd = columnTr.lastChild;
			var descChkBox = descTd.firstChild;
			var columnName = in_GetColNameByColTr(columnTr);
			
			if (indexName == TG_NEW_INDEX) {
			
				descChkBox.disabled = true;
				descChkBox.checked = false;
			
			} else if (in_IsIndexColumn(indexColumnArray, columnName)) {

				descChkBox.disabled = false;
				descChkBox.checked = getDescFlag(indexColumnArray, columnName);
				
			} else {

					descChkBox.disabled = true;
					descChkBox.checked = false;
			}
			
			columnTr = columnTr.nextSibling;
		}


		//
		// unique ?
		//
		var uniqueTd = in_GetUniqueTd(indexDivId);
		var uniqueChkBox = uniqueTd.firstChild;

		if (indexName == TG_NEW_INDEX) {

				uniqueChkBox.disabled = false;
				uniqueChkBox.checked = false;
		} else {

			if (indexColumnArray.unique == true)
				uniqueChkBox.checked = true;
			else
				uniqueChkBox.checked = false;

			if (in_IsPKeyIndex(indexName) || in_IsFKeyIndex(indexName))
				uniqueChkBox.disabled = true;
			else
				uniqueChkBox.disabled = false;
		}

	}
	
	this.selectedIndex = 0;
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
* checkbox and text conversion
*

function in_ChkBoxTxt(indexName, objectTd, object, flag) {

	if (objectTd==null || object==null) {
		sy_logError("ERD-index", 
				"in_GetControlTd", 
				"One of the following is null:" 
				+ " objectTd: " + objectTd
				+ ", object:" + object);
		return null;
	}
	
	if (objectTd.tagName.toUpperCase() != "TD") {
		sy_logError("ERD-index", 
				"in_GetControlTd", 
				"tag name is not TD!!"
					+ "  index name: " + indexName);
		return null;
	}
	

	if (object.data == null) {

		// checkbox ---> checkbox
		if (flag == true)
			object.checked = true;
		else
			object.checked = false;

		if (in_IsPKeyIndex(indexName) || in_IsFKeyIndex(indexName)) {
			object.disabled  = true;
		} else {
			object.onclick = in_EnableDescObj;
			object.disabled  = false;
		}
	} else {

		// text ---> checkbox
		var checkBox = ut_TextToCheckbox(object);
		if (flag == true)
			checkBox.defaultChecked = true;
		else
			checkBox.defaultChecked = false;

		objectTd.replaceChild(checkBox, object);

		if (in_IsPKeyIndex(indexName) || in_IsFKeyIndex(indexName)) {
			checkBox.disabled  = true;
		} else {
			checkBox.onclick = in_EnableDescObj;
			checkBox.disabled  = false;
		}
		
	}

}
**/


/**
*
* if we select this column, we can set whether we want to sort 
*	as desc on this column or not
*
**/function in_EnableDescObj() {

	var selectTd = this.parentElement;
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
**/
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
	var iNameSelectTd = tr.firstChild;
	var uniqueTxtTd = iNameSelectTd.nextSibling;
	var uniqueTd = uniqueTxtTd.nextSibling;

	return uniqueTd;
}


/**
*
* Retrieve column name key 
*
**/
function in_GetColNameByColTr(columnTr) {

	var checkTd = columnTr.firstChild;
	var pKeyTd = checkTd.nextSibling;
	var columnTd = pKeyTd.nextSibling;
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
	var indexName = in_GetIndexNameByNameTag(indexNameTag);
	if (indexName == null) {
		this.selectedIndex = 1;
		return;
	}

	in_SaveIndex(indexDiv, indexName)  
	indexDiv.style.visibility = "hidden";	 	

	tableDiv.style.background = COLOR_OBJ_DEFAULT;
	selectedObj = null;
	
	choosenIndex = null;

}


/**
*
* 
*
**/
function in_EditCancel() {


	choosenIndex = null;
}

