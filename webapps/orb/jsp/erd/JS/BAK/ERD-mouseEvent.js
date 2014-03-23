/**
*
* originally: 	JavaScript Kit www.javascriptkit.com
* modified:	Chialin Chou
*
**/


var dragapproved=false;
var x,y;


/**
*
* move this object to the top 
*
**/
function ev_MakeOnTop(inObj) {

	var checkObj;
	var maxZ = 0;


	var objArray;
	
	if (isNS) 
		objArray = document.getElementsByTagName("*");
	else
		objArray = document.all;


	for (var i=0; i<objArray.length; i++) {
	
		checkObj = objArray[i].style.zIndex;
		
		if (checkObj != "" && checkObj > maxZ)
			maxZ = checkObj;
	}

	var newMaxZ = maxZ + 1;
	inObj.style.zIndex = newMaxZ;
	
	return newMaxZ;
}


/**
*
* move the mouse
*
**/
function ev_MouseMove(){

	if (event.button==1 && dragapproved && event.srcElement.className==CL_DB_TABLE){
	
		event.srcElement.style.pixelLeft = temp1+event.clientX - x
		event.srcElement.style.pixelTop = temp2+event.clientY - y
		
		// redraw relationship when moving the table
		var activeTableName = event.srcElement.name;			
		
		if (activeTableName != null) {
		
			if (re_RedrawRelation(activeTableName) == false) {
				sy_logError("ERD-column", 
						"ev_MouseMove", 
						"Error redrawing relation for table:" + activeTableName);
				return;
			}
			
		}
		
		return false
	}
}


/**
*
* press the left button 
*
**/
function ev_MouseDown(){


	/////////////////////////////////////
	//	new table
	/////////////////////////////////////
	if (sysModeField == MOD_TABLE) {

		if (event.srcElement.className == CL_MODE_CONTROL
				|| event.srcElement.className == CL_DB_TABLE) 
			return;
		
		//
		// create one empty table
		//
		var tableName = NEW_TABLE;
		
		var tableDiv = tb_AddEmptyTable(tableName);
		if (tableDiv == false) {
			sy_logError("ERD-column", 
					"ev_MouseDown", 
					"Error creating a new table!!");
			return;
		}


		//
		// create indexDiv
		//
		if (in_EditIndex0(tableName)==null) {
		
			sy_logError("ERD-xmlschema", 
					"xm_ReadSchema", 
					"Error adding index for table: " + tableName);
			return false;
		}
		
		// just create.  nothing got chosen!!
		choosenIndex = null;


		ev_MakeOnTop(tableDiv);
		tableDiv.style.background = COLOR_OBJ_CHOSEN;

		//
		// edit this table
		//
		chosenTable = tableName;
		
		if (tb_EditTable(tableName) == false) {
			sy_logError("ERD-column", 
					"ev_Dbclick", 
					"Error change the table to edit mode!!"
					+ "  Table name: " + tableName);
			return;
		}

		sysModeField = MOD_SELECT;
		

	/////////////////////////////////////
	//	relationship
	/////////////////////////////////////
	} else if (sysModeField == MOD_RELATIONSHIP) {

		ev_MakeOnTop(event.srcElement);

		if (event.srcElement.className == CL_DB_TABLE) {
		
			var chosenTableName = event.srcElement.id;

			if (srcTableName == null) {
				//	
				// source table
				//
				srcTableName = chosenTableName;

				if (tb_HasPrimaryKey(srcTableName) == false) {
				
					alert("No primary key found!!");
					srcTableName =  null;
					return;
				}
				
				event.srcElement.style.background = COLOR_OBJ_CHOSEN;
				
				return;
				
			} else {  	
				//
				// destination table is chosen (have source table already)
				//
				destTableName = chosenTableName;
				event.srcElement.style.background = COLOR_OBJ_CHOSEN;
				
				if (re_HasRelationship(srcTableName, destTableName) == true) {
				
					srcTableName = null;
					destTableName = null;
					return;
				} 
				
				//
				// adding relationship for the tables
				//
				if (re_AddRelationship(srcTableName, destTableName) == false) { 
				
					sy_logError("ERD-mouseEvent", 
							"ev_MouseDown", 
							"Error adding relationship. "
							+ " parent: " + srcTableName
							+ ", child: " + destTableName);
					return;
				}

				//
				//	index (for adding foreign key indexe)
				//
				if (in_EditIndex0(destTableName)==null) {

					sy_logError("ERD-xmlschema", 
							"xm_ReadSchema", 
							"Error adding (foreign key) index for table: " + destTableName);
					return false;
				}
				

				// done!!
				var srcTable = tb_GetTableObj(srcTableName);
				var destTable = tb_GetTableObj(destTableName);
				
				if (srcTable==null || destTable==null) {
					var errMsg = "One of the following table is null:" 
								+ "srcTable: " + srcTable
								+ "destTable: " + destTable;
								
					sy_logError("ERD-mouseEvent", 
							"ev_MouseDown", 
							errMsg);
					return;
				}

				srcTable.style.background = COLOR_OBJ_DEFAULT;
				destTable.style.background = COLOR_OBJ_DEFAULT;
				
				srcTableName = null;
				destTableName = null;
				return;
			}
			
		} else {
	
			srcTableName = null;
			destTableName = null;
			return;
		}		
		
	/////////////////////////////////////
	//	select an object
	/////////////////////////////////////
	} else if (sysModeField == MOD_SELECT) {
	
		// default --> select mode
		if (event.srcElement.className==CL_DB_TABLE){

			if (chosenTable!=null)
				return;

			ev_MakeOnTop(event.srcElement);
			event.srcElement.style.background = COLOR_OBJ_CHOSEN;
			dragapproved = true;
			
			temp1 = event.srcElement.style.pixelLeft;
			temp2 = event.srcElement.style.pixelTop;
			x = event.clientX;
			y = event.clientY;
			
			
		} else if ((event.srcElement.className == CL_PRIMARY_KEY
					||
				event.srcElement.className == CL_COLUMN_NAME
					||
				event.srcElement.className == CL_DATA_TYPE
					||
				event.srcElement.className == CL_DATA_LENGTH
					||
				event.srcElement.className == CL_NULLABLE
					|| 
				event.srcElement.className == CL_VALIDATE
					|| 
				event.srcElement.className == CL_DEFAULT)
					&& chosenTable != null) {

			var columnTr = event.srcElement.parentElement;
			var columnTd = columnTr.firstChild.nextSibling;  // column name
			var text = columnTd.firstChild;
			var columnName = text.data;
			
			var tableDiv = co_GetTDivByColTd(columnTd);
			var tableName = tableDiv.id;


			if (tableName != chosenTable)
				return ;
			
			if (chosenColumn != null && columnName != chosenColumn)
				return;

			if (choosenIndex != null)
				return;

			chosenColumn = columnName;
			tb_SetChosenColTr(tableName, columnTr);
			ev_MakeOnTop(tableDiv);

			if (co_EditColumn(columnTd) == false) {
				sy_logError("ERD-mouseEvent", 
						"ev_MouseDown", 
						"Error editing column!!"
						+ " tableName: " + tableName
						+ ", columnName: " + columnName);
				return;
			}

		} 
	
		
	}

}


/**
*
* release the left button
*
**/
function ev_MouseUp() {

	dragapproved=false;
	
	if (sysModeField == MOD_SELECT) {
	
		if (event.srcElement.className==CL_DB_TABLE){

			if (choosenIndex != null)
				return;

			var chosenTableName = event.srcElement.name;	
			event.srcElement.style.background = COLOR_OBJ_DEFAULT;
			re_RedrawRelation(chosenTableName);
		}

		// mouse move too fast???		
		//if (event.srcElement.className==""){
		//	event.srcElement.style.background = COLOR_OBJ_DEFAULT;
		//}

	} 
}


/**  www.ctuaa.org
*
* double click an object
*
**/
function ev_Dbclick(e) {

/* @@@
	if (isNS) {
	   selectedObj = e.srcElement;
	   //alert('className = ' + selectedObj.className);
	   
	} else if (isIE) {
		selectedObj = event.srcElement;
	}
*/


	if (chosenTable != null || chosenColumn != null)
		return;

	/////////////////////////////////////////////////
	//		table
	/////////////////////////////////////////////////
	if (event.srcElement.className == CL_DB_TABLE) {

		ev_MakeOnTop(event.srcElement);
		event.srcElement.style.background = COLOR_OBJ_CHOSEN;

		var tableName = event.srcElement.name;
		chosenTable = tableName;

		if (tb_EditTable(tableName) == false) {
			sy_logError("ERD-column", 
					"ev_Dbclick", 
					"Error change the table to edit mode!!"
					+ "  Table name: " + tableName);
			return;
		}

	}


}


/**  
*
* for column updates only
*
**/
function ev_MouseOver() {

	if (chosenTable==null)
		return;

	if (chosenColumn != null)
		return;

//	if (choosenIndex != null)
//		return;



	if (event.srcElement.className == CL_PRIMARY_KEY
				||
			event.srcElement.className == CL_COLUMN_NAME
				||
			event.srcElement.className == CL_DATA_TYPE
				||
			event.srcElement.className == CL_DATA_LENGTH
				||
			event.srcElement.className == CL_NULLABLE
				|| 
			event.srcElement.className == CL_VALIDATE
				|| 
			event.srcElement.className == CL_DEFAULT) {


		var columnTd = event.srcElement;
		var objectDiv = co_GetTDivByColTd(columnTd);
		
		// table or index
		var className = objectDiv.className;

		if (className == CL_DB_TABLE) {
			var tableName = objectDiv.id;
			
			// don't want to highlight other guy's columns
			if (tableName != chosenTable)  
				return;

			// working on index			
			var indexDivId = "IND_" + tableName;
			var indexDiv = document.getElementById(indexDivId);

			if (indexDiv.style.visibility == "visible")
				return;
	
			event.srcElement.parentElement.style.background = COLOR_COL_CHOSEN;
			
		} else if (className == CL_DB_INDEX) {
/*			
			var indexNameTag = objectDiv.firstChild;
			var tagName = in_GetIndexNameByNameTag(indexNameTag);

			//if (in_IsPKeyIndex(tagName) || in_IsFKeyIndex(tagName))
			//	return;

			if (tagName == chosenTable)  // table not index
				return;
			
			event.srcElement.parentElement.style.background = COLOR_COL_CHOSEN;
*/			
		}
		
		

		
	}
}


/**  
*
* for column updates only
*
**/
function ev_MouseOut() {

	
	if (event.srcElement.className == CL_PRIMARY_KEY
				||
			event.srcElement.className == CL_COLUMN_NAME
				||
			event.srcElement.className == CL_DATA_TYPE
				||
			event.srcElement.className == CL_DATA_LENGTH
				||
			event.srcElement.className == CL_NULLABLE
				|| 
			event.srcElement.className == CL_VALIDATE
				|| 
			event.srcElement.className == CL_DEFAULT) {
			
		event.srcElement.parentElement.style.background = COLOR_COL_DEFAULT;
	}
}



///////////////////////
// register events
///////////////////////
document.onmousedown		= ev_MouseDown;
document.onmouseup			= ev_MouseUp;
document.onmousemove		= ev_MouseMove;
//document.onmouseenter 	= ev_MouseEnter;
//document.onmouseleave 	= ev_MouseLeave;

document.onmouseover		= ev_MouseOver;
document.onmouseout			= ev_MouseOut;

// for Netscape!!
if (document.addEventListener)
   document.addEventListener("dblclick", ev_Dbclick, false)
else
   document.ondblclick = ev_Dbclick;


//document.ondblclick	= ev_Dbclick
//document.ondeactivate	= ev_DeActivate
