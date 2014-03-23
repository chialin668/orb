/**
*
*  remove "px" and return an integer
*
* @inputPx	String
* 
* @return 	String
*
**/
function ut_GetNumber(inputPx) {

	if (inputPx == null) {
		sy_logError("ERD-util", 
				"ut_GetNumber", 
				"Input string is null!!");
		return null;
	}

	var indP=inputPx.indexOf('p');
	var outStr = inputPx.substring(0, indP);
	return parseInt(outStr);
}

//////////////////////////////////////////////////////////////////////////////////////////

/**
*
* convert text to input 
*
* @text		Object - Text
* @size		integer
*
* @return 	Object - InputText
*
**/
function ut_TextToInput(text, size, align) {


	if (text == null) {
		sy_logError("ERD-util", 
				"ut_TextToInput", 
				"Input ojbect is null!!");
		return null;
	}

	var inputTxt = document.createElement("input");
		inputTxt.type = "text";
		inputTxt.className = CL_TEXT_INPUT;
		inputTxt.value = text.data;

		if (align != null)
			inputTxt.style.textAlign = align;
			
		if (size != null)
			inputTxt.size = size;

	return inputTxt;
}


/**
*
* convert text to select 
*
* @text		Object - Text
*
* @return 	Object - Select
*
**/
function ut_TextToSelect(text, array) {

	if (text == null) {
		sy_logError("ERD-util", 
				"ut_TextToSelect", 
				"Input ojbect is null!!");
		return null;
	}

	var select = document.createElement("select");
	select.className = CL_SELECT;

	for (var i=0;i<array.length;i++) {

		var opt = document.createElement("option");
			opt.value = array[i];
			opt.innerText = array[i];

		if (text.data == array[i]) 
			opt.selected = true;

		select.appendChild(opt);
	}

	return select;
}


/**
*
* convert text to checlbox 
*
* @text		Object - Text
*
* @return 	Object - CheckBox
*
**/
function ut_TextToCheckbox(text) {

	if (text == null) {
		sy_logError("ERD-util", 
				"ut_TextToCheckbox", 
				"Input ojbect is null!!");
		return null;
	}



	var checkBox = document.createElement("input");
	checkBox.type = "checkbox";
	checkBox.className = CL_CHECKBOX;

	if (text.data==PRIMARY_EKY_MARK || text.data==CHECK_MARK || text.data==NULLABLE_MARK)
		checkBox.defaultChecked = true;
		
	else 
		checkBox.defaultChecked = false;
		
	return checkBox;

/*

	var checkBox;
	if (text.data==PRIMARY_EKY_MARK || text.data==CHECK_MARK)
		checkBox = document.createElement("<input type=checkbox checked>");
		
	else 
		checkBox = document.createElement("<input type=checkbox>");
		
	return checkBox;
*/	
}

/////////////////////////////////////////////////////////////////////////////

/**
*
* convert inputText to text
*
* @text		Object - InputText
*
* @return 	Object - Text
*
**/
function ut_InputTextToText(inputTxt) {
	if (inputTxt == null) {
		sy_logError("ERD-util", 
				"ut_InputTextToText", 
				"Input ojbect is null!!");
		return null;
	}

	//@@@ how about align??
	var text = document.createTextNode(inputTxt.value);
	return text;
}


/**
*
* convert select to text
*
* @text		Object - Select
*
* @return 	Object - Text
*
**/
function ut_SelectToText(select) {

	if (select == null) {
		sy_logError("ERD-util", 
				"ut_SelectToText", 
				"Input ojbect is null!!");
		return null;
	}

	var opt = select.firstChild;

	var text = null;
	while (opt != null) {

		if (opt.selected == true) {
			text = document.createTextNode(opt.value);
			break;
		}

		opt = opt.nextSibling;
	}

	return text;
}

/**
*
* convert checkbox to text
*
* @text		Object - CheckBox
*
* @return 	Object - Text
*
**/
function ut_CheckBoxToText(checkBox) {

	var classType = checkBox.parentElement.className;

	if (checkBox == null) {
		sy_logError("ERD-util", 
				"ut_CheckBoxToText", 
				"Input ojbect is null!!");
		return null;
	}

	var checked;
	if (checkBox.checked) {
		if (classType == CL_PRIMARY_KEY) {
			checked = PRIMARY_EKY_MARK;
			
		} else if (classType == CL_NULLABLE) {
			checked = NULLABLE_MARK;
			
		} else if (classType == CL_CHECK_MARK) {
			checked = CHECK_MARK;
			
		} else if (classType == CL_UNIQUE_MARK) {
			checked = CL_UNIQUE_MARK;
			
		} else {
			sy_logError("ERD-util", 
					"ut_CheckBoxToText", 
					"Class type error!!"
					+ "class type: " + classType);
			return null;
		}
		
	} else
		checked = EMPTY_STRING;
		
	var text = document.createTextNode(checked);
	return text;
}


/**
*
* sorting for arrays
*
**/
function ut_BubbleSort(inputArray, start, rest) {

	for (var i = rest - 1; i >= start;  i--) {
	
		for (var j = start; j <= i; j++) {
		
			if (inputArray[j+1] < inputArray[j]) {
				var tempValue = inputArray[j];
				inputArray[j] = inputArray[j+1];
				inputArray[j+1] = tempValue;
			}
		}
	}
	
	return inputArray;
}
