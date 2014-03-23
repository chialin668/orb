
function aaa() {alert("111");}

/**
*
* generate ERD by reading the schema in xml format
*
**/
function xm_ReadSchema() {
		
	var xmlStr = document.getElementById("xml").value;

	var objDom = new XMLDoc(xmlStr, xm_Error)
	var objDomTree = objDom.docNode;


	////////////////////////
	//	table
	////////////////////////
	var tag1Elements = objDomTree.getElements("table");
	
	for (var i=0;i<tag1Elements.length;i++) {
		var element = tag1Elements[i];
		var tableName = element.getAttribute("id");
	
		var left = element.getAttribute("left");
		var top = element.getAttribute("top");

		var columnArray = xm_GetTableColumnArray(element.getUnderlyingXMLText());
		
		if (tb_AddTable(tableName, top, left, columnArray) == null) {
		
			sy_logError("ERD-xmlschema", 
					"xm_ReadSchema", 
					"Error adding table: " + tableName);
			return false;
		} 
		
	}
	

	////////////////////////
	//	relation
	////////////////////////
	var tag1Elements = objDomTree.getElements("relation");
	
	var sqlStr = ""
	for (var i=0;i<tag1Elements.length;i++) {
		var element = tag1Elements[i];
		var relationId = element.getAttribute("id");
		var parentName = element.getAttribute("parent");
		var childName = element.getAttribute("child");

		if (re_AddRelationship(parentName, childName) == false) { 

			alert("ERD-xmlschema", 
					"xm_ReadSchema", 
					"Error adding relationship. "
					+ " parent: " + parentName
					+ ", child: " + childName);
			return false;
		}

	}




	////////////////////////
	//	index
	////////////////////////
	//
	// generate indexDiv(s) primary key, foreign key indexes
	//
	var tag1Elements = objDomTree.getElements("table");
	
	for (var i=0;i<tag1Elements.length;i++) {
		var element = tag1Elements[i];
		var tableName = element.getAttribute("id");
	
		if (in_EditIndex0(tableName)==null) {
		
			sy_logError("ERD-xmlschema", 
					"xm_ReadSchema", 
					"Error adding index for table: " + tableName);
			return false;
		}
		
		// just create.  nothing got chosen!!
		choosenIndex = null;
	}


	//
	// other indexes
	//
	var tag1Elements = objDomTree.getElements("index");
	
	for (var i=0;i<tag1Elements.length;i++) {
		var element = tag1Elements[i];
		var indexName = element.getAttribute("id");
		var tableName = element.getAttribute("tableName");
		var unique = element.getAttribute("unique");
		var keyType = element.getAttribute("keyType");
	
		if (keyType != "primary" && keyType != "foreign") {

			var indexDivId = "IND_" + tableName;
			var indexDiv = document.getElementById(indexDivId);
			
			var indexColumnArray = xm_GetIndexColumnArray(element.getUnderlyingXMLText());

			if (unique == "y")
				indexColumnArray.unique = true;
			var columnHashTable = indexDiv.columnHashTable;
			columnHashTable[indexName] = indexColumnArray;	
		}
		
	}


	////////////////////////
	//	validate
	////////////////////////
	var validateDiv = va_GetValidateDiv();
	var validateHashTable = validateDiv.validateHashTable;		
	
	var tag1Elements = objDomTree.getElements("validate");
	for (var i=0;i<tag1Elements.length;i++) {
		var element = tag1Elements[i];
		var name = element.getAttribute("name");
		var value = element.getAttribute("value");
		validateHashTable[name] = value;
	}


	////////////////////////
	//	default
	////////////////////////
	var defaultDiv = df_GetDefaultDiv();
	var defaultHashTable = defaultDiv.defaultHashTable;		
	
	var tag1Elements = objDomTree.getElements("default");
	for (var i=0;i<tag1Elements.length;i++) {
		var element = tag1Elements[i];
		var name = element.getAttribute("name");
		var value = element.getAttribute("value");
		defaultHashTable[name] = value;
	}


	return true;
} 


/**
*
* column for tables
*
**/
function xm_GetTableColumnArray(xml) {

	var objDom = new XMLDoc(xml, xm_Error)
	var objDomTree = objDom.docNode;
	var tag1Elements = objDomTree.getElements("column");
	
	var columnArray = new Array();
	for (var i=0;i<tag1Elements.length;i++) {
		
		var element = tag1Elements[i];
		
		var primaryKey = element.getAttribute("primaryKey")!=null? 
					PRIMARY_EKY_MARK:EMPTY_STRING;
		var columnName = element.getAttribute("columnName");
		var dataType = element.getAttribute("dataType");
		var dataLength = element.getAttribute("dataLength")!=null? 
					element.getAttribute("dataLength"):EMPTY_STRING;
		var nullable = element.getAttribute("nullable")!=null? "y":EMPTY_STRING;
		var validate = element.getAttribute("validate")!=null? 
					element.getAttribute("validate"):EMPTY_STRING;
		var dfltValue = element.getAttribute("default")!=null? 
					element.getAttribute("default"):EMPTY_STRING;
							
		var newColumn = new Array(primaryKey, columnName, dataType, dataLength, 
						nullable, validate, dfltValue);
						
//		alert(primaryKey+"\t"+columnName+"\t"+dataType+"\t"+dataLength+"\t"+
//						nullable+"\t"+validate+"\t"+dfltValue);
						
		columnArray[columnArray.length] = newColumn;
	}

	return columnArray;
} 


/**
*
* columns for indexes
*
**/
function xm_GetIndexColumnArray(xml) {

	var objDom = new XMLDoc(xml, xm_Error)
	var objDomTree = objDom.docNode;
	var tag1Elements = objDomTree.getElements("column");
	
	var indexColumnArray = new Array();

	for (var i=0;i<tag1Elements.length;i++) {
		
		var element = tag1Elements[i];
		var columnName = element.getAttribute("columnName");
		var desc = element.getAttribute("desc");
		
		var columnNameObj = new Object();
		columnNameObj.columnName = columnName;
		if (desc == "y")
			columnNameObj.desc = true;

		indexColumnArray[i] = columnNameObj;
	}

	return indexColumnArray;
}


///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/**
*
* save the schema in xml format
*
**/
function xm_SaveSchema() {


	var objArray = document.all;
	var xmlStr = "<schema>\n";

	/////////////////////
	// 	table
	/////////////////////
	var tableStr = "";
	for (var i=0; i<objArray.length; i++) {
		object = objArray[i];

		if (object.className == CL_DB_TABLE) {

			var tableName = object.id;

			tableDivLeft = ut_GetNumber(object.style.left);
			tableDivTop = ut_GetNumber(object.style.top);
			

			var tableBody = tb_GetHtmlTableBody(tableName);
			var columnTr = tableBody.firstChild;

			tableStr = tableStr + "<table id='" + tableName + "'" 
						+ " left='" + tableDivLeft + "'"
						+ " top='" + tableDivTop + "'"
						+ ">\n";
			
			var columnStr = "";
			while(columnTr != null) {
				
				var pKeyTd 	= columnTr.firstChild;
				var columnTd 	= pKeyTd.nextSibling;
				var typeTd 	= columnTd.nextSibling;
				var lengthTd 	= typeTd.nextSibling;
				var nullableTd 	= lengthTd.nextSibling;
				var validateTd 	= nullableTd.nextSibling;
				var defaultTd 	= validateTd.nextSibling;

				if (pKeyTd.firstChild.data!='f') {

					columnStr = columnStr + "\t<column" 
						+ (pKeyTd.firstChild.data!='-' ? 
							" primaryKey='" + pKeyTd.firstChild.data + "'"	:"")
						+ (columnTd.firstChild.data!='-'? 
							" columnName='" + columnTd.firstChild.data + "'":"")
						+ (typeTd.firstChild.data!="-"	? 
							" dataType='" + typeTd.firstChild.data + "'" : "")
						+ (lengthTd.firstChild.data!="-"? 
							" dataLength='" + lengthTd.firstChild.data + "'": "")
						+ (nullableTd.firstChild.data!="-" ? 
							" nullable='" + nullableTd.firstChild.data + "'": "")
						+ (validateTd.firstChild.data!="-" ? 
							" validate='" + validateTd.firstChild.data + "'": "")
						+ (defaultTd.firstChild.data!="-" ? 
							" default='" + defaultTd.firstChild.data + "'": "")
						+ " />\n";
				}
				
				columnTr = columnTr.nextSibling;
			}

			tableStr = tableStr + columnStr + "</table>\n\n";
		
		} 
	}


	/////////////////////
	// 	relation
	/////////////////////
	var relStr = "";
	for (var i=0; i<objArray.length; i++) {
		object = objArray[i];

		if (object.className == CL_DB_RELATION) {
		
			var relationId = object.id;
			var parentName = re_GerParentTableName(relationId);
			var childName = re_GerChildTableName(relationId);
			var pKeyArray = tb_GetPrimaryKeyArray(parentName);
			
			var pKeyStr = "";
			for (var j=0;j<pKeyArray.length;j++) {
				var columnObj = pKeyArray[j];
				var columnName = columnObj.columnName;
				pKeyStr = pKeyStr + columnName + ", ";
			}
			
			pKeyStr = pKeyStr.substring(0, pKeyStr.length-2);
			
			relStr = relStr + "<relation id='" + relationId + "'" 
						+ "\n\t parent='" + parentName + "'"
						+ "\n\t child='" + childName + "'"
						+ "\n\t columns='" + pKeyStr + "'"
						+ ">\n";
			
			relStr = relStr + "</relation>\n\n";
		}
	}


	/////////////////////
	// 	index
	/////////////////////
	var indStr = "";
	for (var i=0; i<objArray.length; i++) {
		object = objArray[i];

		if (object.className == CL_DB_INDEX) {
		
			var indexDivId = object.id;
			var tableDivId = indexDivId.substring(indexDivId.indexOf('_')+1);  // IND_
			
			var indexDiv = document.getElementById(indexDivId);
			var columnHashTable = indexDiv.columnHashTable;
			var descColHashTable = indexDiv.descColHashTable;
	

			for (var property in columnHashTable) {
				var indexName = property;
				var columnArray = columnHashTable[indexName];
				var keyType = columnArray.keyType;

				indStr = indStr + "<index id='" + indexName + "'"
								+ " tableName='" + tableDivId + "'"
								+ (keyType? " keyType='" + keyType + "'": "")
								+ (columnArray.unique ? " unique='y'" : "")
								+ ">\n";

				
				// for each column
				var columnArray = columnHashTable[indexName];
				for (var j=0;j<columnArray.length;j++) {
						var columnObj = columnArray[j];
						columnName = columnObj.columnName;
						indStr = indStr + "\t<column columnName='" + columnName + "'" 
									+ (columnArray[j].desc? " desc='y'":"") + " />\n";

				}
				
				indStr = indStr + "</index>\n\n";
			}			
			
		}
	}


	/////////////////////
	// 	validate
	/////////////////////
	var validateStr = "";
	var validateDiv = va_GetValidateDiv();
	validateHashTable = validateDiv.validateHashTable;
	
	for (var property in validateHashTable)
		validateStr = validateStr + "<validate name='" + property + "'" 
									+ " value='" + validateHashTable[property] + "'"
									+ " />\n\n";



	/////////////////////
	// 	default
	/////////////////////
	var defaultStr = "";
	var defaultDiv = df_GetDefaultDiv();
	defaultHashTable = defaultDiv.defaultHashTable;
	
	for (var property in defaultHashTable)
		defaultStr = defaultStr + "<default name='" + property + "'" 
									+ " value='" + defaultHashTable[property] + "'"
									+ " />\n\n";



	xmlStr = "<schema>\n" 
			+ tableStr 
			+ relStr
			+ indStr
			+ validateStr
			+ defaultStr
			+ "</schema>\n";
			
	//
	// then to SQL
	//
	xm_WriteSQL(xmlStr);
	
}



/**
*
* convert xml into sql string
*
**/
function xm_WriteSQL(xmlStr) {

	var projectName = document.getElementById("projectName").value;

	// table
	var sqlStr = xm_GenerateSQL(xmlStr);

	document.write("<form method='POST' action='/orb/jsp/erd/ERD-xml.jsp'>");
	document.write("<textarea name='xml' rows='20' cols='100'>" + xmlStr + "</textarea>");
	document.write("<textarea name='sql' rows='20' cols='100'>" + sqlStr + "</textarea>");
	document.write("<INPUT TYPE='hidden' NAME='projectName' VALUE='" + projectName + "'>");
	document.write("<input type='submit' value='Save'>");
	document.write("</form>");

}


/**
*
* 
*
**/
function xm_GenerateSQL(xml) {

	var objDom = new XMLDoc(xml, xm_Error)
	var objDomTree = objDom.docNode;
	
	//
	// table
	//
	var tableElements = objDomTree.getElements("table");
	
	var sqlStr = "";
	
	var tableStr = "";
	for (var i=0;i<tableElements.length;i++) {
		var element = tableElements[i];
		var tableName = element.getAttribute("id");
		
		tableStr = tableStr + "DROP TABLE " + tableName + " CASCADE CONSTRAINTS;\n";
		tableStr = tableStr + "CREATE TABLE " + tableName + "(\n";
		tableStr = tableStr + xm_GenerateColumn(tableName, element.getUnderlyingXMLText());
		tableStr = tableStr + ");\n\n";
	}
	
	//
	// relation
	//
	var indexElements = objDomTree.getElements("relation");
	
	var relationStr = ""
	for (var i=0;i<indexElements.length;i++) {
		var element = indexElements[i];
		var relationName = element.getAttribute("id");
		var parent = element.getAttribute("parent");
		var child = element.getAttribute("child");
		var columns = element.getAttribute("columns");
		
		relationStr = relationStr 
						+ "ALTER TABLE " + child
						+ "\n\tADD (CONSTRAINT " + relationName
						+ "\n\tFOREIGN KEY (" + columns + ")"
						+ "\n\tREFERENCES " + parent 
						+ ");\n\n";
	}
	
	
	
	//
	// index
	//
	var indexElements = objDomTree.getElements("index");
	
	var indexStr = ""
	for (var i=0;i<indexElements.length;i++) {
		var element = indexElements[i];
		var indexName = element.getAttribute("id");
		var tableName = element.getAttribute("tableName");
		var keyType = element.getAttribute("keyType");
		var unique = element.getAttribute("unique");
		
		indexStr = indexStr + "DROP INDEX " + indexName + ";\n";
		indexStr = indexStr + "CREATE " 
						+ (unique=="y"? "UNIQUE " : "")
						+ "INDEX " + tableName + " ON " + tableName + "(\n";
		indexStr = indexStr + xm_GetIndexColumnStr(element.getUnderlyingXMLText());
		indexStr = indexStr + "\n);\n\n";
	}

		
	sqlStr = tableStr + relationStr + indexStr;
	
	return sqlStr;
} 


/**
*
* columns for tables
*
**/
function xm_GenerateColumn(tableName, xml) {

	var objDom = new XMLDoc(xml, xm_Error)
	var objDomTree = objDom.docNode;
	var columnElements = objDomTree.getElements("column");
	
	var sqlStr = "";
	for (var i=0;i<columnElements.length;i++) {
		
		var element = columnElements[i];
		
		var primaryKey = element.getAttribute("primaryKey");
		var columnName = element.getAttribute("columnName");
		var dataType = element.getAttribute("dataType");
		var dataLength = element.getAttribute("dataLength")!= null? 
							"("+element.getAttribute("dataLength")+")":"";
		var nullable = element.getAttribute("nullable")!= null? 
							" NOT NULL":" NULL";
		var validate = element.getAttribute("validate")!= null? 
							"\n\t\tCONSTRAINT "
							+ tableName + "_" + columnName + "_" + element.getAttribute("validate")
							+ "\n\t\tCHECK (" + columnName + " IN (" 
							+ va_GetValidateValueByName(element.getAttribute("validate"))
							+ "))":"";
		var dfltValue = element.getAttribute("default")!= null? 
							" DEFAULT " 
							+ df_GetDefaultValueByName(element.getAttribute("default")):"";
							
		sqlStr = sqlStr + "\t" + columnName + "\t" + dataType + dataLength 
					+ dfltValue + nullable + validate + ",\n"; 
	}
	
	return sqlStr;
} 


/**
*
* columns for indexes
*
**/
function xm_GetIndexColumnStr(xml) {

	var objDom = new XMLDoc(xml, xm_Error)
	var objDomTree = objDom.docNode;
	var columnElements = objDomTree.getElements("column");
	
	var retStr = "";
	for (var i=0;i<columnElements.length;i++) {
		
		var element = columnElements[i];
		var columnName = element.getAttribute("columnName");
		var desc = element.getAttribute("desc");

		retStr = retStr + "\t" + columnName 
					+ (desc == "y" ? " DESC" : " ASC") 
					+ ",\n";
	}
	
	retStr = retStr.substring(0, retStr.length-2);
	
	return retStr;
}


/**
*
* 
*
**/
function xm_Error(e) {
	alert(e);

} 

////////////////////////////////////////////////////////////////////////////////////

