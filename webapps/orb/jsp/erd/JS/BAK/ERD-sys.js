var logWindow;

/**
*
* initialize .......
*
**/
function sy_Init() {
	//
	logWindow = document.createElement("textarea");	
		logWindow.value = "";
		logWindow.font = "8pt";
		logWindow.style.top = "100px";
		logWindow.style.left = "100px";
		logWindow.style.width = "800px";
		logWindow.style.height = "300px";
		logWindow.style.visibility = "hidden";
		//logWindow.style.zIndex = 500;
	document.body.appendChild(logWindow);
	ev_MakeOnTop(logWindow);		

}


/**
*
* log the error message
*
**/
function sy_logError(fileName, functionName, errMsg) {
	var errStr = "[" + fileName 
			+ "." + functionName + "]: "
			+ errMsg
			+ "\n";
			
//	logWindow.value = logWindow.value + errStr;
//	logWindow.style.visibility = "visible";
	
	alert(errStr);
	
}


/**
*
* 
*
**/
function sy_FnChangeText(data){
	var oTextNode = document.createTextNode(data);
	var oReplaceNode = oItem1.firstChild.replaceNode(oTextNode);
}


/**
*
* change the system mode
*
**/
function sy_SetSysMode(sysMode) {

	if (sysMode == null) {
		sy_logError("ERD-util", 
				"sy_SetSysMode", 
				"sysMode string is null!!");
				
		// set default 
		sysModeField = MOD_SELECT;
		return false;
	}

	var field = document.getElementById("sysModeField");
	field.value = sysMode;
	sysModeField = sysMode;
	
	return true;
}


