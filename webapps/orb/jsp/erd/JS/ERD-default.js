//var defaultArray = new Array(EMPTY_STRING, "<Edit>", "male", "female");

/**
*
* df_GetDefaultDiv will create one,  DON'T call this one!!
*
**/
function df_CreateDefault() {

	var defaultDiv = document.createElement("div");
			defaultDiv.id = TAG_DEFAULT;	
			defaultDiv.align = "center";
			defaultDiv.innerText = TAG_DEFAULT;
			defaultDiv.className = CL_DB_DEFAULT;
				defaultDiv.style.position = "absolute";
				defaultDiv.style.top = "120px";
				defaultDiv.style.left = "120px";
				defaultDiv.style.color = "captiontext";
				defaultDiv.style.font = "caption";
				defaultDiv.style.padding = "1px";
				defaultDiv.style.margin = "0px";
				defaultDiv.style.background = COLOR_DEFAULT_DIV;
				defaultDiv.style.visibility = "hidden";

	//
	// default name value pairs
	//
	var defaultHashTable = {};
	defaultDiv.defaultHashTable = defaultHashTable;

	// 
	var selectObj = null
	defaultDiv.defaultSelectObj = selectObj;


	var tbl = document.createElement("table");
		tbl.border ='0';
		tbl.cellSpacing='0';
		tbl.cellPadding='0';

	// html table
	var tbody = document.createElement("tbody");
	tbl.appendChild(tbody);

			// data tr
			var dataTr = document.createElement("tr");
			var dataTd = df_CreateDataTd();
			dataTr.appendChild(dataTd);
		tbody.appendChild(dataTr);

			// control tr
			var controlTr = document.createElement("tr");
			var controlTd = df_CreateControlTd(defaultDiv);
			controlTr.appendChild(controlTd);
		tbody.appendChild(controlTr);
	
	
	defaultDiv.appendChild(tbl);
	document.body.appendChild(defaultDiv);
	
	ev_MakeOnTop(defaultDiv);
	return defaultDiv;
}


/**
*
* 
*
**/
function df_GetDefaultDiv() {

	var defaultDiv = document.getElementById(TAG_DEFAULT);

	if (defaultDiv == null)
		return df_CreateDefault();
	
	df_RefreshSelect(defaultDiv);
	return defaultDiv;
}


/**
*
* 
*
**/
function df_SetLocation(top, left) {

	var defaultDiv = df_GetDefaultDiv();
	defaultDiv.style.top = top;
	defaultDiv.style.left = left;
}


/**
*
* 
*
**/
function df_ShowDefault() {
	var defaultDiv = df_GetDefaultDiv();
	
	
	ev_MakeOnTop(defaultDiv);
	
	defaultDiv.style.visibility = "visible";		
}


/**
*
* 
*
**/
function df_HideDefault() {
	var defaultDiv = df_GetDefaultDiv();
	defaultDiv.style.visibility = "hidden";		
}


/**
*
* 
*
**/
function df_GetDefaultValueByName(defaultName) {

	var defaultDiv = df_GetDefaultDiv();
	var defaultHashTable = defaultDiv.defaultHashTable;
	return defaultHashTable[defaultName];

}


/**
*
* for column select object pull down
*
**/
function df_GetDefaultNameArray() {

	var defaultDiv = df_GetDefaultDiv();
	defaultHashTable = defaultDiv.defaultHashTable;
	
	var defaultArray = new Array();
	
	defaultArray[0] = EMPTY_STRING;
	defaultArray[1] = TAG_EDIT;
	
	var i=2;
	for (var property in defaultHashTable) {
		defaultArray[i] = property;
		i++;
	}	

	return defaultArray;
}


/**
*
* 
*
**/
function df_SetSelectObj(selectObj) {
	defaultDiv = df_GetDefaultDiv();
	defaultDiv.defaultSelectObj = selectObj;
}


/**
*
* 
*
**/
function df_CreateDataTd() {

	dataTd = document.createElement("td");
	
	var tbl = document.createElement("table");
		tbl.className = CL_HTML_TABLE;
		tbl.border ='0';
		tbl.cellSpacing='0';
		tbl.cellPadding='2';
		tbl.style.width="100%";

	var tbody = document.createElement("tbody");
	tbl.appendChild(tbody);
	
	// name
	var tr = document.createElement("tr");
			var nameTd = document.createElement("td");
				var text = document.createTextNode("Name:");
				nameTd.appendChild(text);
			
				var inputTxt = document.createElement("input");
				inputTxt.readOnly = true;
				inputTxt.style.backgroundColor = COLOR_READ_ONLY;
				nameTd.appendChild(inputTxt);
				
			tr.appendChild(nameTd);
	tbody.appendChild(tr);

	// value
	var tr = document.createElement("tr");
			var valueTd = document.createElement("td");
				var text = document.createTextNode("Value:");
				valueTd.appendChild(text);

				var inputTxt = document.createElement("input");
				inputTxt.readOnly = true;
				inputTxt.style.backgroundColor = COLOR_READ_ONLY;
				valueTd.appendChild(inputTxt);

			tr.appendChild(valueTd);
	
	tbody.appendChild(tr);
	dataTd.appendChild(tbl);

	return dataTd;


}


/**
*
* 
*
**/
function df_CreateControlTd(defaultDiv) {

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
		tr.align = "left";

			// default name select td
			var iNameTd = df_CreateSelectTd(defaultDiv);
			tr.appendChild(iNameTd);
		tbody.appendChild(tr);

			// buttons
			var tr = document.createElement("tr");
			var buttonTd = df_CreateButtonTd();
			tr.appendChild(buttonTd);
		tbody.appendChild(tr);

	tbody.appendChild(tr);
	controlTd.appendChild(tbl);

	return controlTd;

}


/**
*
* select td for the default names
*
**/
function df_CreateSelectTd(defaultDiv) {
	var td = document.createElement("td");

	//
	// select
	//
	var select = document.createElement("select");
		select.onchange = df_DefaultChosen;

	// some default values
	var opt = document.createElement("option");
		opt.value = "";
		opt.innerText = "";
	select.appendChild(opt);

	var opt = document.createElement("option");
		opt.value = TAG_NEW;
		opt.innerText = TAG_NEW;
	select.appendChild(opt);
	
	//
	//
	//
	defaultHashTable = defaultDiv.defaultHashTable;
	
	for (var property in defaultHashTable) {
		var opt = document.createElement("option");
			opt.value = property;
			opt.innerText = property;
		select.appendChild(opt);
	}

	td.appendChild(select);
	return td;
}


/**
*
* 
*
**/
function df_CreateButtonTd() {
	var td = document.createElement("td");

	// delete button
	var deleteBtn = document.createElement("button");
	  deleteBtn.innerText = "Delete";
	  deleteBtn.onclick = df_EditDelete;
	  deleteBtn.className = CL_IN_COMMAND;
	td.appendChild(deleteBtn);

	// ok button
	var okBtn = document.createElement("button");
	  okBtn.innerText = "OK";
	  okBtn.onclick = df_EditOk;
	  okBtn.className = CL_IN_COMMAND;
	td.appendChild(okBtn);

	// cancel button
	var cancelBtn = document.createElement("button");
	  cancelBtn.innerText = "Cancel";
	  cancelBtn.onclick = df_EditCancel;
	  cancelBtn.className = CL_IN_COMMAND;
	td.appendChild(cancelBtn);

	return td;
}


////////////////////////////////////////////////////////////////////////


/**
*
* 
*
**/
function df_GetDefaultName() {

	var tbody = tb_GetHtmlTableBody(TAG_DEFAULT);

	// name	
	var nameTr = tbody.firstChild;
	var nameTd = nameTr.firstChild;
	var nameInput = nameTd.firstChild.nextSibling;
	var defaultName = nameInput.value;
	
	return defaultName;
}


/**
*
* from screen
*
**/
function df_GetDefaultValue() {

	var tbody = tb_GetHtmlTableBody(TAG_DEFAULT);

	var valueTr = tbody.firstChild.nextSibling;
	var valueTd = valueTr.firstChild;
	var valueInput = valueTd.firstChild.nextSibling;
	return valueInput.value;
}


/**
*
* 
*
**/
function df_SetDefaultNameValue(defaultName, defaultValue) {

	var tbody = tb_GetHtmlTableBody(TAG_DEFAULT);

	// name	
	var nameTr = tbody.firstChild;
	var nameTd = nameTr.firstChild;
	var nameInput = nameTd.firstChild.nextSibling;
	nameInput.readOnly = false;
	nameInput.style.backgroundColor = COLOR_READ_WRITE;
	nameInput.value = defaultName;
	nameInput.focus();
	nameInput.select();

	// value
	var valueTr = tbody.firstChild.nextSibling;
	var valueTd = valueTr.firstChild;
	var valueInput = valueTd.firstChild.nextSibling;
	valueInput.readOnly = false;
	valueInput.style.backgroundColor = COLOR_READ_WRITE;
	valueInput.value = defaultValue;
}


/**
*
* 
*
**/
function df_EnableInputs() {

	var tbody = tb_GetHtmlTableBody(TAG_DEFAULT);

	// name	
	var nameTr = tbody.firstChild;
	var nameTd = nameTr.firstChild;
	var nameInput = nameTd.firstChild.nextSibling;
	nameInput.readOnly = false;
	nameInput.style.backgroundColor = COLOR_READ_WRITE;

	// value
	var valueTr = tbody.firstChild.nextSibling;
	var valueTd = valueTr.firstChild;
	var valueInput = valueTd.firstChild.nextSibling;
	valueInput.readOnly = false;
	valueInput.style.backgroundColor = COLOR_READ_WRITE;
}


/**
*
* 
*
**/
function df_DisableInputs() {

	var tbody = tb_GetHtmlTableBody(TAG_DEFAULT);

	// name	
	var nameTr = tbody.firstChild;
	var nameTd = nameTr.firstChild;
	var nameInput = nameTd.firstChild.nextSibling;
	nameInput.value = "";
	nameInput.readOnly = true;
	nameInput.style.backgroundColor = COLOR_READ_ONLY;

	// value
	var valueTr = tbody.firstChild.nextSibling;
	var valueTd = valueTr.firstChild;
	var valueInput = valueTd.firstChild.nextSibling;
	valueInput.value = "";
	valueInput.readOnly = true;
	valueInput.style.backgroundColor = COLOR_READ_ONLY;
}


/**
*
* 
*
**/
function df_GetSelectTd(defaultDivId) {
	var controlTd = in_GetControlTd(defaultDivId);  //@@@	

	var table = controlTd.firstChild;
	var tbody = table.firstChild;
	var tr = tbody.firstChild;
	var selectTd = tr.firstChild;

	return selectTd;
}


function df_RefreshSelect(defaultDiv) {
		
	var indexDivId = defaultDiv.id;
	var selectTd = df_GetSelectTd(indexDivId);
	var selectTr = selectTd.parentElement;
	
	var newSelectTd = df_CreateSelectTd(defaultDiv);
	if (newSelectTd == null) {
		sy_logError("ERD-default", 
				"df_RefreshSelect", 
				"Error creating default name select td!!");
		return false;
	}	

	selectTr.replaceChild(newSelectTd, selectTd);
	return true;
}


/**
*
* to hash table
*
**/
function df_SaveDefault(defaultDiv) {

	var defaultName = df_GetDefaultName();
	
	if (defaultName != "" && defaultName != TAG_NEW) {
		defaultHashTable = defaultDiv.defaultHashTable;
		defaultHashTable[defaultName] = df_GetDefaultValue();
	}
}

/**
*
* 
*
**/
function df_DefaultChosen() {

	var defaultName = this.options[this.selectedIndex].value;
	var defaultDiv = df_GetDefaultDiv();
	
	if (defaultName != null) {
	
		var oldDefaultName = df_GetDefaultName();
		if (oldDefaultName == null) {
			this.selectedIndex = 0;
			return;
		}
		
		
		if (oldDefaultName == null) {
			this.selectedIndex = 0;
			return;
		}
		
		if (defaultName == oldDefaultName) {
			this.selectedIndex = 0;
			return;
		}

		// save the old one...
		if (oldDefaultName != "") {
			
			df_SaveDefault(defaultDiv);
			df_RefreshSelect(defaultDiv);
		}
		


		// display the new one
		if (defaultName == TAG_NEW)
			df_SetDefaultNameValue(TAG_NEW, "");
		else 
			df_SetDefaultNameValue(defaultName, defaultHashTable[defaultName]);
			
	}
	
	this.selectedIndex = 0;
}


function df_EditDelete() {

}


function df_EditOk() {

	var defaultDiv = df_GetDefaultDiv();
	df_SaveDefault(defaultDiv);
	df_RefreshSelect(defaultDiv);

	var defaultName = df_GetDefaultName();

	if (defaultName == "") defaultName = TAG_NEW;  // we don't like ""

		var selectObj = defaultDiv.defaultSelectObj;
	
	in_ReplaceDefaultSelect(selectObj, defaultName);

		
	df_DisableInputs();
	df_HideDefault();
	
}


function df_EditCancel() {
	
}

