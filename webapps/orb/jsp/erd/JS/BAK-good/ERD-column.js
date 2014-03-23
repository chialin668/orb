var colTmpTable=null;


/**
*
* some retrival functions 
*
**/
function co_GetPKey(pKeyTd) 		{ return pKeyTd.firstChild.data; }



function co_GetPKeyTd(columnTr)		{ return columnTr.firstChild; }
function co_GetColumnTd(columnTr) 	{ return co_GetPKeyTd(columnTr).nextSibling; }
function co_GetTypeTd(columnTr) 	{ return co_GetColumnTd(columnTr).nextSibling; }
function co_GetNullableTd(columnTr) 	{ return co_GetTypeTd(columnTr).nextSibling; }
function co_GetValidateTd(columnTr) 	{ return co_GetNullableTd(columnTr).nextSibling; }
function co_GetDefaultTd(columnTr) 	{ return co_GetValidateTd(columnTr).nextSibling; }

//////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
*
* Retrieve primary key 
*
**/
function co_GetPKeyByColTr(columnTr) {
	var pKeyTd = columnTr.firstChild;
	var object = pKeyTd.firstChild;
	
	if (object.data != null)
		return object.data;
	else 
		return object.checked;
}

/**
*
* Retrieve column name key 
*
**/
function co_GetColNameByColTr(columnTr) {
	var pKeyTd = columnTr.firstChild;
	var columnTd = pKeyTd.nextSibling;
	var object = columnTd.firstChild
	
	if (object.data != null)
		return object.data;
	else
		return object.value;
}


/**
*
* Retrieve data type
*
**/
function co_GetTypeByColTr(columnTr) {
	var pKeyTd = columnTr.firstChild;
	var columnTd = pKeyTd.nextSibling;
	var typeTd = columnTd.nextSibling;
	var object = typeTd.firstChild;
	
	if (object.data != null) {
		return object.data;
	} else {
		var text = ut_SelectToText(object);
		return text.data;
	} 	
}


/**
*
* Retrieve data length
*
**/
function co_GetLengthByColTr(columnTr) {
	var pKeyTd = columnTr.firstChild;
	var columnTd = pKeyTd.nextSibling;
	var typeTd = columnTd.nextSibling;
	var lengthTd = typeTd.nextSibling;
	var object = lengthTd.firstChild;
	
	if (object.data != null)
		return object.data;
	else
		return object.value;
}


/**
*
* Retrieve nullabel column
*
**/
function co_GetNullableByColTr(columnTr) {
	var pKeyTd = columnTr.firstChild;
	var columnTd = pKeyTd.nextSibling;
	var typeTd = columnTd.nextSibling;
	var lengthTd = typeTd.nextSibling;
	var nullableTd = lengthTd.nextSibling;
	
	var object = nullableTd.firstChild;
	
	if (object.data != null)
		return object.data;
	else 
		return object.checked;
}


/**
*
* Retrieve validation
*
**/
function co_GetValidateByColTr(columnTr) {
	var pKeyTd = columnTr.firstChild;
	var columnTd = pKeyTd.nextSibling;
	var typeTd = columnTd.nextSibling;
	var lengthTd = typeTd.nextSibling;
	var nullableTd = lengthTd.nextSibling;
	var validateTd = nullableTd.nextSibling;
	
	var object = validateTd.firstChild;
	
	if (object.data != null) {
		return object.data;
	} else {
		var text = ut_SelectToText(object);
		return text.data;
	} 	
}


/**
*
* Retrieve default
*
**/
function co_GetDefaultByColTr(columnTr) {
	var pKeyTd = columnTr.firstChild;
	var columnTd = pKeyTd.nextSibling;
	var typeTd = columnTd.nextSibling;
	var lengthTd = typeTd.nextSibling;
	var nullableTd = lengthTd.nextSibling;
	var validateTd = nullableTd.nextSibling;
	var defaultTd = validateTd.nextSibling;

	var object = defaultTd.firstChild;
	
	if (object.data != null) {
		return object.data;
	} else {
		var text = ut_SelectToText(object);
		return text.data;
	} 	
}


/**
*
* is the column a primary key?
*
**/
function co_IsPrimaryKey(columnTr) {

	var pKeyTd = columnTr.firstChild;	
	var object = pKeyTd.firstChild;
	
	var columnTd = pKeyTd.nextSibling;
	var text = columnTd.firstChild;
	
	if (object.checked == true || object.data == PRIMARY_EKY_MARK)
		return true;
	else
		return false;
}


/**
*
* is the column a foreigh key?
*
**/
function co_IsForeighKey(columnTr) {

	var pKeyTd = columnTr.firstChild;	
	var object = pKeyTd.firstChild;
	
	var columnTd = pKeyTd.nextSibling;
	var text = columnTd.firstChild;
	
	if (object.checked == true || object.data == FOREIGN_EKY_MARK)
		return true;
	else
		return false;
}



/**
*
* get tr
*
**/
function co_GetColumnTrByColumnName(tableName, columnName) {



}

/////////////////////////////////////////////////////////////////////////////////////////////////////

/**
*
* generate a column for a table in input mode
*
* @tableName 	String
* @primaryKey 	String
* @columnName 	String
* @dataType 	String
* @dataLength 	String
*
* @return	Object - <TR>
*
**/
function co_ColumnTrInput(primaryKey, columnName, dataType, dataLength, nullable, validate, dftValue) {

	if (primaryKey==null || columnName==null || dataType==null || dataLength==null 
			|| nullable==null || validate==null || dftValue==null) {
			
		var errMsg = "One of the following string is null:"
				+ "  primaryKey: " + primaryKey
				+ ", columnName: " + columnName
				+ ", dataType: " + dataType
				+ ", dataLength: " + dataLength
				+ ", nullable: " + nullable
				+ ", validate: " + validate
				+ ", default: " + dftValue
				+ "\n";
				
		sy_logError("ERD-column", 
				"co_ColumnTrInput", 
				errMsg);
		return null;
	}


	var tr = document.createElement("TR");
	
	// primary key
	var pKeyTd = document.createElement("TD");
	pKeyTd.className = CL_PRIMARY_KEY;
		var checkBox = document.createElement("input");
		checkBox.type = "checkbox";
		checkBox.value = primaryKey;
	pKeyTd.appendChild(checkBox);
	tr.appendChild(pKeyTd);

	// column name
	var columnTd = document.createElement("TD");
	columnTd.className = CL_COLUMN_NAME;		
		var inputTxt = document.createElement("input");
		inputTxt.type = "text";
		inputTxt.value = columnName;
	columnTd.appendChild(inputTxt);
	tr.appendChild(columnTd);

	// data type
	typeTd = document.createElement("TD");
	typeTd.className = CL_DATA_TYPE;
		var select = document.createElement("select");
		for (var i=0;i<typeArray.length;i++) {
			var opt = document.createElement("option");
				opt.value = typeArray[i];
				opt.innerText = typeArray[i];

			select.appendChild(opt);
		}
	typeTd.appendChild(select);
	tr.appendChild(typeTd);

	// data length
	lengthTd = document.createElement("TD");
		lengthTd.className = CL_DATA_LENGTH;
		lengthTd.style.textAlign = "right";

		var inputTxt = document.createElement("input");
		inputTxt.type = "text";
		inputTxt.value = dataLength;
		inputTxt.size = 3;
	lengthTd.appendChild(inputTxt);
	tr.appendChild(lengthTd);


	// nullable
	var nullableTd = document.createElement("TD");
	nullableTd.className = CL_NULLABLE;
		var checkBox = document.createElement("input");
		checkBox.type = "checkbox";
		checkBox.value = nullable;
	nullableTd.appendChild(checkBox);
	tr.appendChild(nullableTd);

	// validate
	validateTd = document.createElement("TD");
	validateTd.className = CL_VALIDATE;
	
		var validateDiv = va_GetValidateDiv();
		var validateArray = va_GetValidateNameArray();	

		var select = document.createElement("select");
		for (var i=0;i<validateArray.length;i++) {
			var opt = document.createElement("option");
				opt.value = validateArray[i];
				opt.innerText = validateArray[i];

			select.appendChild(opt);
		}
	validateTd.appendChild(select);
	tr.appendChild(validateTd);

	// default
	defaultTd = document.createElement("TD");
	defaultTd.className = CL_DEFAULT;
		var select = document.createElement("select");
		
		var defaultDiv = df_GetDefaultDiv();
		var defaultArray = df_GetDefaultNameArray();	
		
		for (var i=0;i<defaultArray.length;i++) {
			var opt = document.createElement("option");
				opt.value = defaultArray[i];
				opt.innerText = defaultArray[i];

			select.appendChild(opt);
		}
	defaultTd.appendChild(select);
	tr.appendChild(defaultTd);

	return tr;
}


/**
*
* 
*
**/
function co_MouseEnterTr() {


	if (selectedObj != null) {
		var tableDiv = co_GetTDivByColTr(this);
		var tableName = tableDiv.id;
		var selectedName = selectedObj.id;

		if (selectedObj.className == CL_DB_TABLE
			&& tableName == selectedName) {

//			this.style.backgroundColor = COLOR_COL_CHOSEN;

		}
	}	

}

function co_MouseLeaveTr() {
//	this.style.backgroundColor = COLOR_COL_DEFAULT;
}


function co_MouseDownTr() {


	var columnTd = this.firstChild.nextSibling;  // @@@@ columnTr --> columnTd
	var text = columnTd.firstChild;

	var tableDiv = co_GetTDivByColTd(columnTd);
	var tableName = tableDiv.id;
	var columnName = text.data;
	chosenColumn = columnName;

	var columnTr = columnTd.parentElement;
	tb_SetChosenColTr(tableName, columnTr);

//	columnTr.style.backgroundColor = COLOR_COL_CHOSEN;

	// bring the table to top		
	ev_MakeOnTop(tableDiv);

	if (co_EditColumn(columnTd) == false) {
		sy_logError("ERD-mouseEvent", 
				"ev_Dbclick", 
				"Error editing column!!"
				+ " tableName: " + tableName
				+ ", columnName: " + columnName);
		
//		this.style.backgroundColor = COLOR_COL_DEFAULT;
		return;
	}
	
//	this.style.backgroundColor = COLOR_COL_DEFAULT;

}


/**
*
* generate a column for a table in text mode
*
* @tableName 	String
* @primaryKey 	String
* @columnName 	String
* @dataType 	String
* @dataLength 	String
*
* @return	Object - <TR>
*
**/
function co_ColumnTr(primaryKey, columnName, dataType, dataLength,
							nullable, validate, dftValue) {
				
	if (primaryKey==null || columnName==null || dataType==null || dataLength==null
			|| nullable == null || validate == null || dftValue == null) {
			
		var errMsg = "One of the following string is null:"
				+ "  primaryKey: " + primaryKey
				+ ", columnName: " + columnName
				+ ", dataType: " + dataType
				+ ", dataLength: " + dataLength
				+ ", nullable: " + nullable
				+ ", validate: " + validate
				+ ", default: " + dftValue
				+ "\n";
				
		sy_logError("ERD-column", 
				"co_ColumnTr", 
				errMsg);
		return null;
	}


	var tr = document.createElement("TR");
//tr.onmouseenter = co_MouseEnterTr;
//tr.onmouseleave = co_MouseLeaveTr;
//tr.onmousedown = co_MouseDownTr;
	
	
	// primary key
	var pKeyTd = document.createElement("TD");
	pKeyTd.className = CL_PRIMARY_KEY;
	var text = document.createTextNode(primaryKey);
	pKeyTd.appendChild(text);
	tr.appendChild(pKeyTd);

	// column name
	var columnTd = document.createElement("TD");
	columnTd.className = CL_COLUMN_NAME;
	var text = document.createTextNode(columnName);
	columnTd.appendChild(text);
	tr.appendChild(columnTd);

	// data type
	typeTd = document.createElement("TD");
	typeTd.className = CL_DATA_TYPE;
	text = document.createTextNode(dataType);
	typeTd.appendChild(text);
	tr.appendChild(typeTd);

	// data length
	lengthTd = document.createElement("TD");
	lengthTd.className = CL_DATA_LENGTH;
		lengthTd.style.textAlign = "right";
	text = document.createTextNode(dataLength);
	lengthTd.appendChild(text);
	tr.appendChild(lengthTd);

	// nullable
	var nullableTd = document.createElement("TD");
	nullableTd.className = CL_NULLABLE;
	var text = document.createTextNode(nullable);
	nullableTd.appendChild(text);
	tr.appendChild(nullableTd);

	// validate
	var validateTd = document.createElement("TD");
	validateTd.className = CL_VALIDATE;
	var text = document.createTextNode(validate);
	validateTd.appendChild(text);
	tr.appendChild(validateTd);

	// default
	var defaultTd = document.createElement("TD");
	defaultTd.className = CL_DEFAULT;
	var text = document.createTextNode(dftValue);
	defaultTd.appendChild(text);
	tr.appendChild(defaultTd);


	return tr;
}


//////////////////////////////////////////////////////////////////////////////////////////////


/**
*
* Add a new column to this table body - tbody
*
* @tbody table 	Object - body <TBODY>
* @columnArray 	Array
*
* @return 	boolean
*
**/
function co_AppendColumn(tbody, columnArray) {

	if (tbody == null || columnArray == null) {
		var errMsg = "One of the following string is null:"
				+ " tbody: " + tbody
				+ ", columnArray: " + columnArray 
				+ "\n";
	
		sy_logError("ERD-column", 
				"co_AppendColumn", 
				errMsg);
		return false;
	}
	
	if (columnArray.length == 0) {
		sy_logError("ERD-column", 
				"co_AppendColumn", 
				"The length of columnArray is 0!!");
		return false;
	}

	for (var i=0; i<columnArray.length; i++) {
		var column = columnArray[i];

		var tr = co_ColumnTr(column[0], 	// primary key
				column[1], 		// column name
				column[2], 		// data type
				column[3],		// data length
				column[4],		// nullable
				column[5], 		// validate
				column[6]		// default
				); 		
		tbody.appendChild(tr);
	}
	
	return true;
}


//////////////////////////////////////////////////////////////////////////////////////////////

function co_DisableUpDownButtons() {  
	var downBtn = document.getElementById(CL_CO_COMMAND_TEXT + "Up");
	downBtn.disabled = true;

	var downBtn = document.getElementById(CL_CO_COMMAND_TEXT + "Down");
	downBtn.disabled = true;
}

/**
*
* convert a whole column text to input
*
* @tableName	String
* @tr		Object - <TR>
*
* @return	Object - <TR>
*
**/
function co_ColumnTextToInput(columnTr) {

	if (columnTr == null) {
		sy_logError("ERD-column", 
				"co_ColumnTextToInput", 
				"column tr is null!!");
		return null;
	}

	
	var pKeyTd = columnTr.firstChild;
	var text = pKeyTd.firstChild;
	var checkBox = ut_TextToCheckbox(text);
		checkBox.onmousedown = co_DisableUpDownButtons;
	pKeyTd.replaceChild(checkBox, text);

	var columnTd = pKeyTd.nextSibling;
	var text = columnTd.firstChild;
	columnTd.replaceChild(ut_TextToInput(text, null, null), text);

	var typeTd = columnTd.nextSibling;
	text = typeTd.firstChild;
	var dataTypeSelect = ut_TextToSelect(text, typeArray);
	//dataTypeSelect = ut_TextToInput(text, null, null);
	typeTd.replaceChild(dataTypeSelect, text);

	var lengthTd = typeTd.nextSibling;
	var text = lengthTd.firstChild;
	lengthTd.replaceChild(ut_TextToInput(text, 3, "right"), text);

	var nullableTd = lengthTd.nextSibling;
	var text = nullableTd.firstChild;
	nullableTd.replaceChild(ut_TextToCheckbox(text), text);

	var validateTd = nullableTd.nextSibling;
	text = validateTd.firstChild;
		//
		// validate div
		//
		var validateDiv = va_GetValidateDiv();
		var validateArray = va_GetValidateNameArray();	
		var validateSelect = ut_TextToSelect(text, validateArray);

	validateSelect.onchange = in_Validate;
	validateTd.replaceChild(validateSelect, text);

// ###
	var defaultTd = validateTd.nextSibling;
	text = defaultTd.firstChild;
		//
		// default div
		//
		var defaultDiv = df_GetDefaultDiv();
		var defaultArray = df_GetDefaultNameArray();	
		var defaultSelect = ut_TextToSelect(text, defaultArray);

	defaultSelect.onchange = in_Default;
	defaultTd.replaceChild(defaultSelect, text);

	return columnTr;
}


//////////////////////////////////////////////////////////////////////////////////

/**
*
* 
*
**/
function in_ReplaceValidateSelect(selectObj, validateName) {

	//
	// for validate select on table
	//
	var validateTd = selectObj.parentElement;	

	var newSelect = document.createElement("select");
		newSelect.className = "SELECT_VALIDATE";
		newSelect.onchange = in_Validate;
	
		var opt = document.createElement("option");
			opt.value = EMPTY_STRING;
			opt.innerText = EMPTY_STRING;
		newSelect.appendChild(opt);

		var opt = document.createElement("option");
			opt.value = TAG_EDIT;
			opt.innerText = TAG_EDIT;
		newSelect.appendChild(opt);

		for (var property in validateHashTable) {

			var opt = document.createElement("option");
				opt.value = property;
				opt.innerText = property;

			if (property == validateName) 
				opt.selected = true;

			newSelect.appendChild(opt);
		}
	
	validateTd.replaceChild(newSelect, selectObj);

}


/**
*
* 
*
**/
function in_Validate() {

	var validateName = this.options[this.selectedIndex].value;

	if (validateName == TAG_EDIT) {

		var validateTd = this.parentElement;
		var columnTr = validateTd.parentElement;
		
		//@@@@
		// get the locations
		var tableDiv = tb_GetTableDivByColumnTr(columnTr);
		var tableDivLeft = ut_GetNumber(tableDiv.style.left);
		var tableDivTop = ut_GetNumber(tableDiv.style.top);
		var tableHeight = tableDiv.offsetHeight;
		
		va_SetLocation(tableDivTop+tableHeight-20, tableDivLeft+20);
		
		va_ShowValidate();
		va_SetSelectObj(this);
	}

}



/**
*
* 
*
**/
function in_ReplaceDefaultSelect(selectObj, defaultName) {

	//
	// for default select on table
	//
	var defaultTd = selectObj.parentElement;	

	var newSelect = document.createElement("select");
		newSelect.className = "SELECT_DEFAULT";
		newSelect.onchange = in_Default;
	
		var opt = document.createElement("option");
			opt.value = EMPTY_STRING;
			opt.innerText = EMPTY_STRING;
		newSelect.appendChild(opt);

		var opt = document.createElement("option");
			opt.value = TAG_EDIT;
			opt.innerText = TAG_EDIT;
		newSelect.appendChild(opt);

		for (var property in defaultHashTable) {

			var opt = document.createElement("option");
				opt.value = property;
				opt.innerText = property;

			if (property == defaultName) 
				opt.selected = true;

			newSelect.appendChild(opt);
		}
	
	defaultTd.replaceChild(newSelect, selectObj);

}


/**
*
* 
*
**/
function in_Default() {

	var defaultName = this.options[this.selectedIndex].value;

	if (defaultName == TAG_EDIT) {

		var defaultTd = this.parentElement;
		var columnTr = defaultTd.parentElement;
		
		//@@@@
		// get the locations
		var tableDiv = tb_GetTableDivByColumnTr(columnTr);
		var tableDivLeft = ut_GetNumber(tableDiv.style.left);
		var tableDivTop = ut_GetNumber(tableDiv.style.top);
		var tableHeight = tableDiv.offsetHeight;
		
		df_SetLocation(tableDivTop+tableHeight-20, tableDivLeft+20);
		
		df_ShowDefault();
		df_SetSelectObj(this);
	}

}


///////////////////////////////////////////////////////////////////////////////


/**
*
* convert a whole column from input to text
*
* @tableName	String
* @tr		Object - <TR>
*
* @return	Object - <TR>
*
**/
function co_ColumnInputToText(columnTr) {

	if (columnTr == null) {
		sy_logError("ERD-column", 
				"co_ColumnInputToText", 
				"column tr is null!!");
		return null;
	}

	var pKeyTd = columnTr.firstChild;
	var checkbox = pKeyTd.firstChild;
	pKeyTd.replaceChild(ut_CheckBoxToText(checkbox), checkbox);

	var columnTd = pKeyTd.nextSibling;
	var inputTxt = columnTd.firstChild;
	columnTd.replaceChild(ut_InputTextToText(inputTxt), inputTxt);

	var typeTd = columnTd.nextSibling;
	var select = typeTd.firstChild;
	typeTd.replaceChild(ut_SelectToText(select), select);

	var lengthTd = typeTd.nextSibling;
	var inputTxt = lengthTd.firstChild;
	lengthTd.replaceChild(ut_InputTextToText(inputTxt), inputTxt);

	var nullableTd = lengthTd.nextSibling;
	var checkbox = nullableTd.firstChild;
	nullableTd.replaceChild(ut_CheckBoxToText(checkbox), checkbox);

	var validateTd = nullableTd.nextSibling;
	var select = validateTd.firstChild;
	validateTd.replaceChild(ut_SelectToText(select), select);

	var defaultTd = validateTd.nextSibling;
	var select = defaultTd.firstChild;
	defaultTd.replaceChild(ut_SelectToText(select), select);


	return columnTr;
}


/**
*
* notify children 
*
**/
function co_ModifyChildren(tableDiv) {
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



//////////////////////////////////////////////////////////////////////////////////////////////

/**
*
* retrieve all columns
*
* @tableName	String
*
* @return	Object 
*
**/
function co_GetColumnArray(tableName) {

	if (tableName == null) {
		sy_logError("ERD-column", 
				"co_GetColumnArray", 
				"Input table name is null!!");
		return null;
	}


	var tbody = tb_GetHtmlTableBody(tableName);
	tr = tbody.firstChild;

	var columnArray = new Array();	
	var i=0;
	
	while (tr != null) {

		var column = new Array(); 
		var td = tr.firstChild;
		
		var j=0
		while (td != null) {
			var text = td.firstChild;
			column[j] = text.data;
			j++;
			
			td = td.nextSibling;
		}
		
		columnArray[i] = column;
		i++;
		
		tr = tr.nextSibling;
	}

	/*
	for (var i=0;i<columnArray.length;i++) {
		var co = columnArray[i];
		
		for (j=0;j<co.length;j++) 
			alert(co[j]);
	}
	*/
	
	return columnArray;
}


/**
*
* retrieve an array of primary key columns
*
* @tableName	String
*
* @return	Object 
*
**/
function co_GetPKeyTrArray(tableName) {
	
	if (tableName == null) {
		sy_logError("ERD-column", 
				"co_GetPKeyTrArray", 
				"Table name is null!!");
		return null;
	}

	var tbody = tb_GetHtmlTableBody(tableName);
	columnTr = tbody.firstChild;

	var columnTrArray = new Array();	
	var i=0;
	
	while (columnTr != null) {

		if (co_IsPrimaryKey(columnTr) == true) {
			columnTrArray[i] = columnTr;
			i++;
		}
					
		columnTr = columnTr.nextSibling;
	}

	return columnTrArray;
}


/**
*
* Add a new column to this table
*
* @tbody	Object - table body <TBODY>
* @columnArray	Array
*
* @return	boolean
*
**/
function co_AddFKeyTrArray(tableName, columnTrArray) {

	//@@@ 
	//
	// if foreign key NAME exists, 
	//	-> replace
	//	-> rename the child key
	//	-> ?
	//
	//

	if (tableName == null || columnTrArray == null) {
		var errMsg = "One of the following string is null:"
				+ " tableName: " + tableName
				+ ", columnArray: " + columnArray //@@@
				+ "\n";
	
		sy_logError("ERD-column", 
				"co_AddFKeyTrArray", 
				errMsg);
		return false;
	}

	if (columnTrArray.length == 0) 
		return true;


	for (var i=0; i<columnTrArray.length; i++) {
		var pKeyColTr = columnTrArray[i];

		var fKeyColTr = co_ColumnTr(FOREIGN_EKY_MARK, 		// foreign key!!
				co_GetColNameByColTr(pKeyColTr),	// column name
				co_GetTypeByColTr(pKeyColTr), 		// data type
				co_GetLengthByColTr(pKeyColTr),		// data length
				co_GetNullableByColTr(pKeyColTr),	// nullable
				co_GetValidateByColTr(pKeyColTr),	// validate
				co_GetDefaultByColTr(pKeyColTr)		// default
				);	

		if (fKeyColTr == null) {
			sy_logError("ERD-column", 
					"co_AddFKeyTrArray", 
					"Error adding foreign key!!");
			return false;
		}
		
		var tbody = tb_GetHtmlTableBody(tableName);
		tbody.appendChild(fKeyColTr);
	}
	
	return true;
}


//////////////////////////////////////////////////////////////////////////////////////////////////////


/**
*
* When the user wants to edit a column
*
* @columnTd	Object - <TD>
*
* @return	boolean 
*
**/
function co_EditColumn(columnTd) {


	if (columnTd == null) {
		sy_logError("ERD-column", 
				"co_EditColumn", 
				"Column TD object is null!!");
		return false;
	} 
	
	
	columnTd.parentElement.style.backgroundColor = COLOR_COL_DEFAULT

	var tableName = co_GetTNameByColTd(columnTd);

	// is it a foreign key?
	var columnTr = columnTd.parentElement;
	var columName = co_GetColNameByColTr(columnTr);
	
	if (co_GetPKeyByColTr(columnTr) == FOREIGN_EKY_MARK) {
		alert("Foreign key column can't be modified!!");
		
		colTmpTable = null;
		chosenColumn = null;

		return true;
	}


	// save a temp copy in case if we want to rollback (cancel)
	tableDiv = tb_GetTableObj(tableName);
	colTmpTable = tableDiv.cloneNode(true);

	//
	// if renamed the table
	//
	var newTableName = tableDiv.firstChild.value;

	if (tableName != newTableName) {

		tb_RenameTable(tableName, newTableName);
		
		tableName = newTableName;
	}
	
	var tableNameTag = tableDiv.firstChild;
	tableNameTag.data = newTableName;
	tableDiv.replaceChild(ut_InputTextToText(tableNameTag), tableNameTag);


	//
	// replace text with an input
	//
	if (co_ColumnTextToInput(columnTr) == null) {
		sy_logError("ERD-column", 
				"co_EditColumn", 
				"Error converting text field to input");
		return false;
	}


	////////////////////////////////
	//	the buttons
	////////////////////////////////
	var controlTr = tb_GetControlTr(tableName);
	if (controlTr == null) {
		sy_logError("ERD-table", 
				"co_EditColumn", 
				"controlTr is null!!"
				+ "  Table name: " + tableName);
		return false;
	}
	
	var oldTd = controlTr.firstChild;
	var newTd = co_CreateControlTd(tableName);
	controlTr.replaceChild(newTd, oldTd);

	if (co_IsPrimaryKey(columnTr) == true) {

		// last primary key?
		var nextColumnTr = columnTr.nextSibling;
		if (nextColumnTr == null || co_IsPrimaryKey(nextColumnTr) != true) {
			var downBtn = document.getElementById(CL_CO_COMMAND_TEXT + "Down");
			downBtn.disabled = true;
		}

		// first primary key?
		var prevColumnTR = columnTr.previousSibling;
		if (prevColumnTR == null) {
			var upBtn = document.getElementById(CL_CO_COMMAND_TEXT + "Up");
			upBtn.disabled = true;
		}

		
	} else {

		// first non primary key
		var prevColumnTR = columnTr.previousSibling;
		if (prevColumnTR == null || co_IsPrimaryKey(prevColumnTR) == true) {
			var upBtn = document.getElementById(CL_CO_COMMAND_TEXT + "Up");
			upBtn.disabled = true;
		}

		// last non primary key?
		var nextColumnTr = columnTr.nextSibling;
		if (nextColumnTr == null) {
			var downBtn = document.getElementById(CL_CO_COMMAND_TEXT + "Down");
			downBtn.disabled = true;
		}
	}

	if (re_RedrawRelation(tableName) == false) {
		sy_logError("ERD-column", 
				"co_EditColumn", 
				"Error redrawing relationship for table: " + tableName);
		return false;
	}
	
	return true;
}



/**
*
* create button TR
* 
* @tableName	String
* @columnName	String
* @tr		Object
*
**/
function co_CreateControlTd(tableName) {


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
/*	
		// new button
		var newBtn = document.createElement("button");
		  newBtn.id = CL_CO_COMMAND_TEXT + "New";
		  newBtn.innerText = "New";
		  newBtn.onclick = co_NewColumn;
		  newBtn.className = CL_CO_COMMAND_TEXT;
		td.appendChild(newBtn);
*/
		// delete button
		var delBtn = document.createElement("button");
		  delBtn.id = CL_CO_COMMAND_TEXT + "Delete";
		  delBtn.innerText = "Delete";
		  delBtn.onclick = co_DeleteColumn;
		  delBtn.className = CL_CO_COMMAND_TEXT;
		td.appendChild(delBtn);

		// apply button
		var applyBtn = document.createElement("button");
		  applyBtn.id = CL_CO_COMMAND_TEXT + "Apply";
		  applyBtn.innerText = "Apply";
		  applyBtn.onclick = co_EditApply;
		  applyBtn.className = CL_CO_COMMAND_TEXT;
		td.appendChild(applyBtn);

		// cancel button
		var cancelBtn = document.createElement("button");
		  cancelBtn.id = CL_CO_COMMAND_TEXT + "Cancel";
		  cancelBtn.innerText = "Cancel";
		  cancelBtn.onclick = co_EditCancel;
		  cancelBtn.className = CL_CO_COMMAND_TEXT;
		td.appendChild(cancelBtn);
	
		// up button
		var upBtn = document.createElement("button");
		  upBtn.id = CL_CO_COMMAND_TEXT + "Up";
		  upBtn.innerText = "Up";
		  upBtn.onclick = co_MoveColumnUp;
		  upBtn.className = CL_CO_COMMAND_TEXT;
		td.appendChild(upBtn);

		// down button
		var downBtn = document.createElement("button");
		  downBtn.id = CL_CO_COMMAND_TEXT + "Down";
		  downBtn.innerText = "Down";
		  downBtn.onclick = co_MoveColumnDown;
		  downBtn.className = CL_CO_COMMAND_TEXT;
		td.appendChild(downBtn);
		
	tr.appendChild(td);
	tbody.appendChild(tr);

	
	controlTd.appendChild(tbl);

	return controlTd;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////

/**
*
* create a new column
*
**/
function co_NewColumn() {

	// get table name
	var tableDiv = tb_GetTableDivByButton(this);
	var tableName = tableDiv.id;

	// old column (from input text --> to text)
	var htmlTBody = tb_GetHtmlTableBody(tableName);
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
	}

	// create one empty column
	var newTr = co_ColumnTrInput("", "", "", "", "", EMPTY_STRING, EMPTY_STRING); //@@@
	
	
	tb_SetChosenColTr(tableName, newTr);
	chosenColumn = EMPTY_STRING;
	
	htmlTBody.appendChild(newTr);

	if (re_RedrawRelation(tableName) == false) {
		sy_logError("ERD-column", 
				"co_NewColumn", 
				"Error redrawing relationship for table: " + tableName);
		return false;
	}


	return true;
}


/**
*
* Delete this column
*
**/
function co_DeleteColumn() {

	// get table name
	var tableDiv = tb_GetTableDivByButton(this);
	var tableName = tableDiv.id;

	//
	// title 
	//
	var tableNameTag = tableDiv.firstChild;
	var inputText = ut_TextToInput(tableNameTag, null, null);
	tableDiv.replaceChild(inputText, tableNameTag);


	// remove column tr
	var columnTr = tb_GetChosenColTr(tableName);
	var tbody = tb_GetHtmlTableBody(tableName)
/*	
	//
	// @@@ for co_ForeignKeyControl
	//	for so if it's the last one, 
	//	we'll remove the child relationship
	//
	var pKeyTd = columnTr.firstChild;
	var object = pKeyTd.firstChild;
	object.checked = false;
	//
	co_ForeignKeyControl(columnTr, "remove");


	var nextColumnTr = columnTr.nextSibling;
	if (nextColumnTr != null) {
		tb_SetChosenColTr(tableName, nextColumnTr);

		var columnTd = co_GetColumnTd(nextColumnTr);
		if (co_EditColumn(columnTd) == false) {
			sy_logError("ERD-column", 
					"co_DeleteColumn", 
					"Error editing column!!"
					+ " tableName: " + tableName
					+ ", columnName: " + co_GetColNameByColTr(columnTr));
			return false;
		}
		
	} else {
		var downBtn = document.getElementById(CL_CO_COMMAND_TEXT + "Delete");
		downBtn.disabled = true;
	}

*/
	tbody.removeChild(columnTr);



	////////////////////////////////
	//	the buttons
	////////////////////////////////
	var controlTr = tb_GetControlTr(tableName);
	if (controlTr == null) {
		sy_logError("ERD-table", 
				"co_EditColumn", 
				"controlTr is null!!"
				+ "  Table name: " + tableName);
		return false;
	}
	
	var oldTd = controlTr.firstChild;
	var newTd = tb_CreateControlTd(tableName);
	controlTr.replaceChild(newTd, oldTd);
	
/*	

	if (tb_RemoveButtons(tableName) == false) {
		sy_logError("ERD-column", 
				"tb_Editapply", 
				"Error removing buttons!!"
				+ "  Table name: " + tableName);
		return false;
	}


	if (re_RedrawRelation(tableName) == false) {
		sy_logError("ERD-column", 
				"co_DeleteColumn", 
				"Error redrawing relationship for table: " + tableName);
		return false;
	}
*/
//	colTmpTable = null;
	chosenColumn = null;

	return true;
}


/**
*
* add or remove foreign key if we change the primary key in the parent table
*
**/
function co_ForeignKeyControl(columnTr, command) {

	var tableDiv = co_GetTDivByColTr(columnTr);
	var tableName = tableDiv.id;

	// just add this primary key
	if (command == "add") {
		
		// do we have any children?
		var childArray = tableDiv.childArray;
		if (childArray.length > 0) {

			// for each child
			for (var i=0;i<childArray.length;i++) {
				var chileTableName = childArray[i];
				var tbody = tb_GetHtmlTableBody(chileTableName);

				var fKeyColTr = co_ColumnTr(FOREIGN_EKY_MARK, 	// foreign key!!
						co_GetColNameByColTr(columnTr),	// column name
						co_GetTypeByColTr(columnTr), 	// data type
						co_GetLengthByColTr(columnTr),	// data length
						co_GetNullableByColTr(columnTr),// nullable
						co_GetValidateByColTr(columnTr),// validate
						co_GetDefaultByColTr(columnTr)	// default
						);	
				tbody.appendChild(fKeyColTr);


			}
		}

	
	} else if (command == "remove") { // just remove this primary key
		var columnName = co_GetColNameByColTr(columnTr);
	
		//do we have any children?
		var childArray = tableDiv.childArray;
		if (childArray.length > 0) {

			// for each child
			for (var i=0;i<childArray.length;i++) {
				
				var childTableName = childArray[i];
				var htmlTable = tb_GetHtmlTableBody(childTableName);
				
				var cTr = htmlTable.firstChild;
				while(cTr != null) {
					// remove this column
					var childColName = co_GetColNameByColTr(cTr);
					if (co_IsForeighKey(cTr) && columnName == childColName) {
						var tbody = tb_GetHtmlTableBody(childTableName);
						tbody.removeChild(cTr);
					}

					cTr = cTr.nextSibling;
				}
			
			
				// if we don't have any primary key, remove all relationships
				if (tb_HasPrimaryKey(tableName) == false) {
					re_RemoveRelation(tableName, childTableName);
				}
			}
		}
		
	} else {
		sy_logError("ERD-column", 
				"co_ForeignKeyControl", 
				"Error input command!!"
				+ "  command: " + command);
		return false;
	}
	
	return true;
}


/**
*
* Want to save the modifiction
*
**/
function co_EditApply() {

	// get table name
	var tableDiv = tb_GetTableDivByButton(this);
	var tableName = tableDiv.id;

	// chnage input to text
	var columnTr = tb_GetChosenColTr(tableName);
//	columnTr.style.backgroundColor = COLOR_COL_DEFAULT;
	columnTr = co_ColumnInputToText(columnTr);

	if (columnTr == null) {
		sy_logError("ERD-column", 
				"co_EditApply", 
				"Error converting input field to text field!!");
		return;
	} 

/*
	// if we need to add or remove any foreign key
	if (co_IsPrimaryKey(columnTr) == true) 
		co_ForeignKeyControl(columnTr, "add");
	else 
		co_ForeignKeyControl(columnTr, "remove");
*/

	//
	// title 
	//
	var tableNameTag = tableDiv.firstChild;
	var inputText = ut_TextToInput(tableNameTag, null, null);
	tableDiv.replaceChild(inputText, tableNameTag);


	////////////////////////////////
	//	the buttons
	////////////////////////////////
	var controlTr = tb_GetControlTr(tableName);
	if (controlTr == null) {
		sy_logError("ERD-table", 
				"co_EditColumn", 
				"controlTr is null!!"
				+ "  Table name: " + tableName);
		return false;
	}
	
	var oldTd = controlTr.firstChild;
	var newTd = tb_CreateControlTd(tableName);
	controlTr.replaceChild(newTd, oldTd);
/*
	
	// remove buttons
	if (tb_RemoveButtons(tableName) == false) {
		sy_logError("ERD-column", 
				"tb_EditApply", 
				"Error removing buttons!!"
				+ "  Table name: " + tableName);
		return false;
	}
*/	
	var htmlTable = tb_GetHtmlTable(tableName);
	var tbody = htmlTable.firstChild;
	htmlTable.replaceChild(co_MovePKeyUp(tableName, tbody), tbody);

	if (re_RedrawRelation(tableName) == false) {
		sy_logError("ERD-column", 
				"co_EditApply", 
				"Error redrawing relationship for table: " + tableName);
		return false;
	}


//	tableDiv.style.background = TBL_DEFAULT_COLOR;
	tb_RemoveChosenColTr(tableName);
	colTmpTable = null;
//	chosenTable = null;
	chosenColumn = null;
	selectedObj = null;
	
	return true;
}


/**
*
* Rollback the change
*
**/
function co_EditCancel() {

	var tableDiv = tb_GetTableDivByButton(this);
	var tableName = tableDiv.id;
	
	if(tb_RemoveChosenColTr(tableName) == false) {
		sy_logError("ERD-table", 
				"co_EditCancel", 
				"Error removing chosen Tr");
		return;
	}
	
	document.body.removeChild(tableDiv);
	document.body.appendChild(colTmpTable);
	
	if (re_RedrawRelation(tableName) == false) {
		sy_logError("ERD-column", 
				"co_EditCancel", 
				"Error redrawing relationship for table: " + tableName);
		return false;
	}

//@@@ @@@ @@@ buttons wonot work if we don't replace the buttons????
	////////////////////////////////
	//	the buttons
	////////////////////////////////
	var controlTr = tb_GetControlTr(tableName);
	if (controlTr == null) {
		sy_logError("ERD-table", 
				"co_EditColumn", 
				"controlTr is null!!"
				+ "  Table name: " + tableName);
		return false;
	}
	
	var oldTd = controlTr.firstChild;
	var newTd = tb_CreateControlTd(tableName);
	controlTr.replaceChild(newTd, oldTd);
///@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@///

//	tableDiv.style.background = TBL_DEFAULT_COLOR;
	colTmpTable = null;
//	chosenTable = null;
	chosenColumn = null;
	selectedObj = null;
	
	return true;
}


/**
*
* Move this column up
*
**/
function co_MoveColumnUp() {

	var tableName = tb_GetTableNameByButton(this);
	var columnTr = tb_GetChosenColTr(tableName);
	var prevTr = columnTr.previousSibling;

	if(co_IsPrimaryKey(columnTr) != true) {
	
		var prevPrevTr = prevTr.previousSibling;

		if (co_GetPKeyByColTr(prevPrevTr) == PRIMARY_EKY_MARK) {
		
			// first non primary key
			var upBtn = document.getElementById(CL_CO_COMMAND_TEXT + "Up");
			upBtn.disabled = true;
		}		
	}


	// enable the down button
	var downBtn = document.getElementById(CL_CO_COMMAND_TEXT + "Down");
	downBtn.disabled = false;

	var tbody = tb_GetHtmlTableBody(tableName);

	//disable the up button
	if (prevTr == tbody.firstChild) {
		var upBtn = document.getElementById(CL_CO_COMMAND_TEXT + "Up");
		upBtn.disabled = true;
	}

	// move it up
	tbody.removeChild(columnTr);
	tbody.insertBefore(columnTr, prevTr);

	return;
}


/**
*
* move this column down
*
**/
function co_MoveColumnDown() {

	// get table name
	var tableName = tb_GetTableNameByButton(this);

	// get columns
	var columnTr = tb_GetChosenColTr(tableName);
	var nextSiblingTr = columnTr.nextSibling;
	var nextSecondTr = nextSiblingTr.nextSibling;

	if(co_IsPrimaryKey(columnTr) == true) {
		if(co_GetPKeyByColTr(nextSecondTr) != PRIMARY_EKY_MARK) {
			// last primary key
			var downBtn = document.getElementById(CL_CO_COMMAND_TEXT + "Down");
			downBtn.disabled = true;
		}
	}

	// enable the up button
	var upBtn = document.getElementById(CL_CO_COMMAND_TEXT + "Up");
	upBtn.disabled = false;

	// move it down
	var tbody = tb_GetHtmlTableBody(tableName);
	tbody.removeChild(columnTr);
	tbody.insertBefore(columnTr, nextSecondTr);

	//disable the down button
	if (columnTr.nextSibling == null) {
		var downBtn = document.getElementById(CL_CO_COMMAND_TEXT + "Down");
		downBtn.disabled = true;
	}

	return;
}



/**
*
* move primary key columns up 
*
* @tableName	String
* @tbody	Object
*
**/
function co_MovePKeyUp(tableName, tbody) {
	
	var newTbody = document.createElement("TBODY");
	tbody.id = "TBODY_" + tableName;

	// pkey	
	var columnTr = tbody.firstChild;
	while (true) {
		if (co_IsPrimaryKey(columnTr) == true)
			newTbody.appendChild(columnTr.cloneNode(true));

		columnTr = columnTr.nextSibling;
		if (columnTr == null) break;
	}


	// non pkey	
	var columnTr = tbody.firstChild;
	while (true) {
		
		if (co_IsPrimaryKey(columnTr) != true)
			newTbody.appendChild(columnTr.cloneNode(true));

		columnTr = columnTr.nextSibling;
		if (columnTr == null) break;
	}
	
	return newTbody;
}


//////////////////////////////////////////////////////////////////////////////////////////////

function co_GetTDivByColTr(columnTr) {

	var tbody = columnTr.parentElement;

	var table = tbody.parentElement;
		var dataTd = table.parentElement;
		var dataTr = dataTd.parentElement;
		var tbody = dataTr.parentElement;
		var table = tbody.parentElement;
		var tableDiv = table.parentElement;

	return tableDiv;
}


/**
*
* retrieve table name by a column tr
*
**/
function co_GetTNameByColTr(columnTr) {

	var tableDiv = co_GetTDivByColTr(columnTr);
	
	if (tableDiv == null) {
		sy_logError("ERD-table", 
				"co_GetTNameByColTr", 
				"tableDiv is null!!");
		return null;
	}
	
	return tableDiv.id;
}



/**
*
* retrieve table div by a column td
*
**/
function co_GetTDivByColTd(columnTd) {
	return co_GetTDivByColTr(columnTd.parentElement);
}


/**
*
* retrieve table name by a column td
*
**/
function co_GetTNameByColTd(columnTd) {

	var tableDiv = co_GetTDivByColTd(columnTd);
	
	if (tableDiv == null) {
		sy_logError("ERD-table", 
				"co_GetTNameByColTd", 
				"tableDiv is null!!");
		return null;
	}
	
	return tableDiv.id;
}



