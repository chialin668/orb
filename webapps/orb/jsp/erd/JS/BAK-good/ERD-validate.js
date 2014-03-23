//var validateArray = new Array(EMPTY_STRING, "<Edit>", "male", "female");

/**
*
* va_GetValidateDiv will create one,  DON'T call this one!!
*
**/
function va_CreateValidate() {

	var validateDiv = document.createElement("div");
			validateDiv.id = TAG_VALIDATE;	
			validateDiv.align = "center";
			validateDiv.innerText = TAG_VALIDATE;
			validateDiv.className = CL_DB_VALIDATE;
				validateDiv.style.position = "absolute";
				validateDiv.style.top = "120px";
				validateDiv.style.left = "120px";
				validateDiv.style.color = "captiontext";
				validateDiv.style.font = "caption";
				validateDiv.style.padding = "1px";
				validateDiv.style.margin = "0px";
				validateDiv.style.background = COLOR_VALIDATE_DIV;
				validateDiv.style.visibility = "hidden";

	//
	// validate name value pairs
	//
	var validateHashTable = {};
	validateDiv.validateHashTable = validateHashTable;

	// 
	var selectObj = null
	validateDiv.validateSelectObj = selectObj;


	var tbl = document.createElement("table");
		tbl.border ='0';
		tbl.cellSpacing='0';
		tbl.cellPadding='0';

	// html table
	var tbody = document.createElement("tbody");
	tbl.appendChild(tbody);

			// data tr
			var dataTr = document.createElement("tr");
			var dataTd = va_CreateDataTd();
			dataTr.appendChild(dataTd);
		tbody.appendChild(dataTr);

			// control tr
			var controlTr = document.createElement("tr");
			var controlTd = va_CreateControlTd(validateDiv);
			controlTr.appendChild(controlTd);
		tbody.appendChild(controlTr);
	
	
	validateDiv.appendChild(tbl);
	document.body.appendChild(validateDiv);
	
	ev_MakeOnTop(validateDiv);
	return validateDiv;
}


/**
*
* 
*
**/
function va_GetValidateDiv() {

	var validateDiv = document.getElementById(TAG_VALIDATE);

	if (validateDiv == null)
		return va_CreateValidate();
	
	va_RefreshSelect(validateDiv);
	return validateDiv;
}


/**
*
* 
*
**/
function va_SetLocation(top, left) {

	var validateDiv = va_GetValidateDiv();
	validateDiv.style.top = top;
	validateDiv.style.left = left;
}


/**
*
* 
*
**/
function va_ShowValidate() {

	var validateDiv = va_GetValidateDiv();
	
	ev_MakeOnTop(validateDiv);
	
	validateDiv.style.visibility = "visible";		
}


/**
*
* 
*
**/
function va_HideValidate() {
	var validateDiv = va_GetValidateDiv();
	validateDiv.style.visibility = "hidden";		
}


/**
*
* 
*
**/
function va_GetValidateValueByName(validateName) {

	var validateDiv = va_GetValidateDiv();
	var validateHashTable = validateDiv.validateHashTable;
	return validateHashTable[validateName];

}


/**
*
* for column select object pull down
*
**/
function va_GetValidateNameArray() {

	var validateDiv = va_GetValidateDiv();
	validateHashTable = validateDiv.validateHashTable;
	
	var validateArray = new Array();
	
	validateArray[0] = EMPTY_STRING;
	validateArray[1] = TAG_EDIT;
	
	var i=2;
	for (var property in validateHashTable) {
		validateArray[i] = property;
		i++;
	}	

	return validateArray;
}


/**
*
* 
*
**/
function va_SetSelectObj(selectObj) {
	validateDiv = va_GetValidateDiv();
	validateDiv.validateSelectObj = selectObj;
}


/**
*
* 
*
**/
function va_CreateDataTd() {

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
function va_CreateControlTd(validateDiv) {

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

			// validate name select td
			var iNameTd = va_CreateSelectTd(validateDiv);
			tr.appendChild(iNameTd);
		tbody.appendChild(tr);

			// buttons
			var tr = document.createElement("tr");
			var buttonTd = va_CreateButtonTd();
			tr.appendChild(buttonTd);
		tbody.appendChild(tr);

	tbody.appendChild(tr);
	controlTd.appendChild(tbl);

	return controlTd;

}


/**
*
* select td for the validate names
*
**/
function va_CreateSelectTd(validateDiv) {
	var td = document.createElement("td");

	//
	// select
	//
	var select = document.createElement("select");
		select.onchange = va_ValidateChosen;

	// some validate values
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
	validateHashTable = validateDiv.validateHashTable;
	
	for (var property in validateHashTable) {
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
function va_CreateButtonTd() {
	var td = document.createElement("td");

	// delete button
	var deleteBtn = document.createElement("button");
	  deleteBtn.innerText = "Delete";
	  deleteBtn.onclick = va_EditDelete;
	  deleteBtn.className = CL_IN_COMMAND;
	td.appendChild(deleteBtn);

	// ok button
	var okBtn = document.createElement("button");
	  okBtn.innerText = "OK";
	  okBtn.onclick = va_EditOk;
	  okBtn.className = CL_IN_COMMAND;
	td.appendChild(okBtn);

	// cancel button
	var cancelBtn = document.createElement("button");
	  cancelBtn.innerText = "Cancel";
	  cancelBtn.onclick = va_EditCancel;
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
function va_GetValidateName() {

	var tbody = tb_GetHtmlTableBody(TAG_VALIDATE);

	// name	
	var nameTr = tbody.firstChild;
	var nameTd = nameTr.firstChild;
	var nameInput = nameTd.firstChild.nextSibling;
	var validateName = nameInput.value;
	
	return validateName;
}


/**
*
* from screen
*
**/
function va_GetValidateValue() {

	var tbody = tb_GetHtmlTableBody(TAG_VALIDATE);

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
function va_SetValidateNameValue(validateName, validateValue) {

	var tbody = tb_GetHtmlTableBody(TAG_VALIDATE);

	// name	
	var nameTr = tbody.firstChild;
	var nameTd = nameTr.firstChild;
	var nameInput = nameTd.firstChild.nextSibling;
	nameInput.readOnly = false;
	nameInput.style.backgroundColor = COLOR_READ_WRITE;
	nameInput.value = validateName;
	nameInput.focus();
	nameInput.select();

	// value
	var valueTr = tbody.firstChild.nextSibling;
	var valueTd = valueTr.firstChild;
	var valueInput = valueTd.firstChild.nextSibling;
	valueInput.readOnly = false;
	valueInput.style.backgroundColor = COLOR_READ_WRITE;
	valueInput.value = validateValue;
}


/**
*
* 
*
**/
function va_EnableInputs() {

	var tbody = tb_GetHtmlTableBody(TAG_VALIDATE);

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
function va_DisableInputs() {

	var tbody = tb_GetHtmlTableBody(TAG_VALIDATE);

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
function va_GetSelectTd(validateDivId) {
	var controlTd = in_GetControlTd(validateDivId);  //@@@	

	var table = controlTd.firstChild;
	var tbody = table.firstChild;
	var tr = tbody.firstChild;
	var selectTd = tr.firstChild;

	return selectTd;
}


function va_RefreshSelect(validateDiv) {
		
	var indexDivId = validateDiv.id;
	var selectTd = va_GetSelectTd(indexDivId);
	var selectTr = selectTd.parentElement;
	
	var newSelectTd = va_CreateSelectTd(validateDiv);
	if (newSelectTd == null) {
		sy_logError("ERD-validate", 
				"va_RefreshSelect", 
				"Error creating validate name select td!!");
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
function va_SaveValidate(validateDiv) {

	var validateName = va_GetValidateName();
	
	if (validateName != "" && validateName != TAG_NEW) {
		validateHashTable = validateDiv.validateHashTable;
		validateHashTable[validateName] = va_GetValidateValue();
	}
}

/**
*
* 
*
**/
function va_ValidateChosen() {

	var validateName = this.options[this.selectedIndex].value;
	var validateDiv = va_GetValidateDiv();
	
	if (validateName != null) {
	
		var oldValidateName = va_GetValidateName();
		if (oldValidateName == null) {
			this.selectedIndex = 0;
			return;
		}
		
		
		if (oldValidateName == null) {
			this.selectedIndex = 0;
			return;
		}
		
		if (validateName == oldValidateName) {
			this.selectedIndex = 0;
			return;
		}

		// save the old one...
		if (oldValidateName != "") {
			
			va_SaveValidate(validateDiv);
			va_RefreshSelect(validateDiv);
		}
		


		// display the new one
		if (validateName == TAG_NEW)
			va_SetValidateNameValue(TAG_NEW, "");
		else 
			va_SetValidateNameValue(validateName, validateHashTable[validateName]);
			
	}
	
	this.selectedIndex = 0;
}


function va_EditDelete() {

}


function va_EditOk() {

	var validateDiv = va_GetValidateDiv();
	va_SaveValidate(validateDiv);
	va_RefreshSelect(validateDiv);

	var validateName = va_GetValidateName();

	if (validateName == "") validateName = TAG_NEW;  // we don't like ""

		var selectObj = validateDiv.validateSelectObj;
	
	in_ReplaceValidateSelect(selectObj, validateName);

		
	va_DisableInputs();
	va_HideValidate();
	
}


function va_EditCancel() {
	
}

