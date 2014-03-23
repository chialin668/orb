//
// gloabal variable for relationship
//
var parentLeft=0;
var parentTop=0;
var parentWidth=0;
var parentHeight=0;
var childLeft=0;
var childTop=0;
var childWidth=0;
var childHeight=0;

var fromX=0;
var fromY=0;
var toX=0;
var toY=0;

/**
*
* retrieve the table locations 
*
**/
function re_GetTableLocation(parentTableName, childTableName) {

	if (parentTableName == null || childTableName == null) {
		var errMsg = "One of the following string is null:"
				+ "  parentTableName: " + parentTableName
				+ ", childTableName: " + childTableName
				+ "\n";
				
		sy_logError("ERD-relationship", 
				"re_GetTableLocation", 
				errMsg);
		return false;
	}
	
	////////////////////////
	// get locations
	////////////////////////
	var parentTab = document.getElementById(parentTableName);
		parentLeft = ut_GetNumber(parentTab.style.left);
		parentTop = ut_GetNumber(parentTab.style.top);
		parentWidth = parentTab.offsetWidth;
		parentHeight = parentTab.offsetHeight;

               
	var childTab = document.getElementById(childTableName);
		childLeft = ut_GetNumber(childTab.style.left);
		childTop = ut_GetNumber(childTab.style.top);
		childWidth = childTab.offsetWidth;
		childHeight = childTab.offsetHeight;
		
	return true;
}


/**
*
* retrieve the points for drawing 
*
**/
function re_GetPoints(parentTableName, childTableName) {

	var relationID = parentTableName + "__" + childTableName;
	var container = document.getElementById(relationID);

if (container == null) alert(relationID)

	var	fromRandom = container.fromRandom;
	var	toRandom = container.toRandom;

	if (parentLeft==0 || parentTop==0 || parentWidth==0 || parentHeight== 0) {
		var errMsg = "One of the following string is 0:"
				+ " parentLeft: " + parentLeft
				+ ", parentTop: " + parentTop
				+ ", parentWidth: " + parentWidth
				+ ", parentHeight: " + parentHeight
				+ "\n";
				
		sy_logError("ERD-relationship", 
				"re_GetPoints", 
				errMsg);
		return false;
	}

	if (parentTop > childTop+childHeight) {
	
		///////////////////////////////////////////////////
		// parent higher than the bottom of the child 
		// 	-> draw from the top center of the parent
		//alert("parent higher");
		///////////////////////////////////////////////////
	
		fromX = parentLeft + parentWidth/2 + fromRandom;
		fromY = parentTop;
		
		if ((parentLeft + parentWidth/2) < childLeft) {
			// left side of child
			//alert("left");
			toX = childLeft
			toY = childTop + childHeight/2 + toRandom;
		
		} else if ((parentLeft + parentWidth/2) > (childLeft+childWidth)) {
			// right side of child
			//alert("right");
			toX = childLeft + childWidth;
			toY = childTop + childHeight/2 + toRandom;
		
		} else {
			// under the child
			//alert("under");
			toX = childLeft + childWidth/2 + toRandom;
			toY = childTop + childHeight;
		}
		
	} else if (parentTop+parentHeight < childTop) {
	
		///////////////////////////////////////////////////
		// child higher than the bottom of the parent
		// 	-> draw from the bottom center fo the parent
		//alert("child higher");
		///////////////////////////////////////////////////
	
		fromX = parentLeft + parentWidth/2 + fromRandom;
		fromY = parentTop + parentHeight;

		if ((parentLeft + parentWidth/2) < childLeft) {
			// left side of child
			//alert("left");
			toX = childLeft
			toY = childTop + childHeight/2 + toRandom;
		
		} else if ((parentLeft + parentWidth/2) > (childLeft+childWidth)) {
			// right side of child
			//alert("right");
			toX = childLeft + childWidth;
			toY = childTop + childHeight/2 + toRandom;
		
		} else {
			// above the child
			//alert("above");
			toX = childLeft + childWidth/2 + toRandom;
			toY = childTop;
		}
	} else {
	
		///////////////////////////////////////////////////
		// inbetween
		//alert("between");
		///////////////////////////////////////////////////

		if ((parentLeft + parentWidth) < childLeft) {
			// left side of child
			//alert("left");
			fromX = parentLeft + parentWidth;
			fromY = parentTop + parentHeight/2 + fromRandom;

			toX = childLeft
			toY = childTop + childHeight/2 + toRandom;
		
		} else if (parentLeft > (childLeft+childWidth)) {
			// right side of child
			//alert("right");
			fromX = parentLeft;
			fromY = parentTop + parentHeight/2 + fromRandom;

			toX = childLeft + childWidth;
			toY = childTop + childHeight/2 + toRandom;
		
		} else {
			// on top of the child
			// don't draw the line
			fromX = -1;
			fromY = -1;

			toX = -1;
			toY = -1;
		}
	
	}

	if (fromX==0 || fromY==0 || toX==0 || toY== 0) {
		var errMsg = "One of the following string is 0:"
				+ " fromX: " + fromX
				+ ", fromY: " + fromY
				+ ", toX: " + toX
				+ ", toY: " + toY
				+ "\n";
				
		sy_logError("ERD-relationship", 
				"re_GetPoints", 
				errMsg);
		return false;
	}
	
	
	return true;
}

/**
*
* check relationship
*
**/
function re_HasRelationship(parentTableName, childTableName) {

	// have we had the relationship?
	if ((document.getElementById(parentTableName + "__" + childTableName) != null)
		|| (document.getElementById(childTableName + "__" + parentTableName) != null)) {

		if (document.getElementById(parentTableName + "__" + childTableName) != null)
			alert("found relation: " + parentTableName + "__" + childTableName);
			
		if(document.getElementById(childTableName + "__" + parentTableName) != null)
			alert("found relation: " + childTableName + "__" + parentTableName);
		

		return true;
	} else
		return false;
}


/**
*
* 
*
**/
function re_GetParentTableName(relationDivId) {
/*
	var relationDiv = document.getElementById(relationDivId);
	
	if (relationDiv == null) {
		sy_logError("ERD-relationship", 
				"re_GetParentTableName", 
				"Error retrieveing relationDiv By id:" + relationDivId);
		return null;
	}
	
	return relationDiv.parent;
*/	
	var ind = relationDivId.indexOf('__');
	var parentTableName = relationDivId.substring(0, ind);
	
	return parentTableName;
}


/**
*
* 
*
**/
function re_GetChildTableName(relationDivId) {

	var ind = relationDivId.indexOf('__');
	var childTableName = relationDivId.substring(ind+2);

	return childTableName;
}


/**
*
* draw relationship to window
*
**/
function re_AddRelationship(parentTableName, childTableName) {

	if (parentTableName == null || childTableName == null) {
		var errMsg = "One of the following string is null:"
				+ "  parentTableName: " + parentTableName
				+ ", childTableName: " + childTableName
				+ "\n";
				
		sy_logError("ERD-relationship", 
				"re_AddRelationship", 
				errMsg);
		return false;
	}
		
	
	// create a container
	var relationID = parentTableName + "__" + childTableName;
	container = document.createElement("div");
		container.id = relationID;
		container.className = CL_DB_RELATION;

		// random number between -25 and 25
		container.fromRandom = Math.floor((Math.random()-0.5)*50);
		container.toRandom = Math.floor((Math.random()-0.5)*50);
	
	document.body.appendChild(container);

	
	if (tb_AddRelationshipToTables(parentTableName, childTableName) == false) {
		sy_logError("ERD-relationship", 
				"re_AddRelationship", 
				"Error adding relationship for: "
				+ "parentTableName: " + parentTableName
				+ ", childTableName: " + childTableName);
		return false;
	}
	

	// retrieve the primary key from the source table
	var columnArray = co_GetPKeyTrArray(parentTableName);

	// adding foreign keys
	if (co_AddFKeyTrArray(childTableName, columnArray) == false) {
		sy_logError("ERD-mouseEvent", 
				"ev_MouseDown", 
				"Error adding foreing key for html table body: "
				+ "parentTableName: " + srcTableName
				+ ", childTableName: " + destTableName);
	}

	
	if (re_GetTableLocation(parentTableName, childTableName) == false) {
		sy_logError("ERD-relationship", 
				"re_AddRelationship", 
				"Error getting table location for: "
				+ "parentTableName: " + parentTableName
				+ ", childTableName: " + childTableName);
		return false;
	}
	
	if (re_GetPoints(parentTableName, childTableName) == null) {
		sy_logError("ERD-relationship", 
				"re_AddRelationship", 
				"Error getting relationship from and to points for: "
				+ "parentTableName: " + parentTableName
				+ ", childTableName: " + childTableName);
		return false;
	}

	/*
	// poly line
	var p = document.createElement("v:polyline");
		p.strokeweight = .1+"pt";
		p.strokecolor = "green";
		p.points = "50,235,50,145,12,123";
		document.body.appendChild(p);
	*/
	
	  //line
	  var l = document.createElement("v:line");
	  	l.id = "LN" + relationID;
		l.style.left = 0;
		l.style.top = 0;
		l.strokeweight = .1+"pt";
		l.strokecolor = "black";
		l.from = fromX + "px, " + fromY + "px";
		l.to = (toX-2) + "px, " + (toY-2) + "px";
		l.style.position = "absolute";

	container.appendChild(l);
	
	  var circle = document.createElement("v:oval");
	  	circle.id = "CR" + relationID;
		circle.style.width="4pt";
		circle.style.height="4pt";
		circle.style.left = (toX-4) + "px";
		circle.style.top = (toY-4) + "px";
		circle.style.position = "absolute";

	container.appendChild(circle);
	
	
	return true;
}



/**
*
* after we move the table, ...
*
**/
function re_RedrawRelation(tableName) {

	if (tableName == null) {
		sy_logError("ERD-column", 
				"re_RedrawRelation", 
				"Table name is null!!");
		return false;
	}

	var table = document.getElementById(tableName);

	///////////////////////////
	// if we move the child
	///////////////////////////
	var parentArray = table.parentArray;
	if (parentArray == null) {
		sy_logError("ERD-column", 
				"re_RedrawRelation", 
				"Parent array is null for child table!!");
		return false;
	}
	
	for (var i=0;i<parentArray.length;i++) {
		var parentTableName = parentArray[i];
		var relationID = parentTableName + "__" + tableName;
		
		if (re_GetTableLocation(parentTableName, tableName) == false) {
			sy_logError("ERD-relationship", 
					"re_RedrawRelation", 
					"Error getting table locations for: "
					+ "parentTableName: " + parentTableName
					+ ", child: " + tableName);
			return false;
		}

		if (re_GetPoints(parentTableName, tableName) == false) {
			sy_logError("ERD-relationship", 
					"re_RedrawRelation", 
					"Error getting relationship from and to points for: "
					+ "parentTableName: " + parentTableName
					+ ", child: " + tableName);
			return false;
		}

		var line = document.getElementById("LN" + relationID);
			line.from = fromX + "px, " + fromY + "px";
			line.to = (toX-2) + "px, " + (toY-2) + "px";

		var circle = document.getElementById("CR" + relationID);
			circle.style.left = (toX-4) + "px";
			circle.style.top = (toY-4) + "px";
	}


	///////////////////////////
	// if we move the parent
	///////////////////////////
	var childArray = table.childArray;
	if (childArray == null) {
		sy_logError("ERD-column", 
				"re_RedrawRelation", 
				"Child array is null for parent table!!");
		return false;
	}

	for (var i=0;i<childArray.length;i++) {
		var childTableName = childArray[i];
		var relationID = tableName + "__" + childTableName;

		if (re_GetTableLocation(tableName, childTableName) == false) {
			sy_logError("ERD-relationship", 
					"re_RedrawRelation", 
					"Error getting table locations for: "
					+ "parentTableName: " + tableName
					+ ", childTableName: " + childTableName);
			return false;
		}
		
		if (re_GetPoints(tableName, childTableName) == false) {
			sy_logError("ERD-relationship", 
					"re_RedrawRelation", 
					"Error getting relationship from and to points for: "
					+ "parentTableName: " + tableName
					+ ", childTableName: " + childTableName);
			return false;
		}

		var line = document.getElementById("LN" + relationID);
			line.from = (fromX-2) + "px, " + (fromY-2) + "px";
			line.to = toX + "px, " + toY + "px";

		var circle = document.getElementById("CR" + relationID);
			circle.style.left = (toX-4) + "px";
			circle.style.top = (toY-4) + "px";
	}
	
	return true;

}


/**
*
* remove relationship from the tables
*
**/
function re_RemoveRelation(parentTableName, childTableName) {

	// remove relationship from the tables	
	tb_RemoveRelationFromTable(parentTableName, childTableName);
	
	// remove the relationship object	
	var relationID = parentTableName + "__" + childTableName;
	var relationDiv = document.getElementById(relationID);
	
	document.body.removeChild(relationDiv);

}


/**
*
* rename the relationship if table name got changed
*
**/
function re_RenameRelation(oldId, newId) {

	// rename relationship id
	var relationDiv = document.getElementById(oldId);
	relationDiv.id = newId;

	// line
	var line = document.getElementById("LN" + oldId);
	line.id = "LN" + newId;
	
	// circle
	var circle = document.getElementById("CR" + oldId);
	circle.id = "CR" + newId;
	
}

