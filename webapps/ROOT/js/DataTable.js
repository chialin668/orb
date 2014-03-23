//
// get the data from the html table (DBHtmlSortable)
//

var dataAll;
var randomColor = new Array();;  
var colNameArray = new Array();
var rowNameArray = new Array();

var hasRandomColor = false;

function getColNames(sqlTag) {
	var table = document.getElementById(sqlTag);  // sqlTag: the name of the table
	var tbody = table.firstChild;
	var colName = tbody.firstChild;
	
	var i = 0;
	var td = colName.firstChild;
	while(td != null) {
		//alert(td.innerText);
		colNameArray[i] = td.innerText;
		
		td = td.nextSibling;
		i++;
	}
}

function getFirstRow(SqlTag) {

	var table = document.getElementById(sqlTag);  // sqlTag: the name of the table
	var tbody = table.firstChild;
	var tr = tbody.firstChild.nextSibling;

	var index = 0;
	while (tr != null) {
		var td = tr.firstChild;

		var columnNo = 0;
		while (td != null) {
			if (columnNo == 0) {
				rowNameArray[index] = td.innerText;
				//alert(index + rowNameArray[index]);
			} 
			td = td.nextSibling;
			columnNo ++;
		}
		index ++;
		tr = tr.nextSibling;
	}
		

}

// 
// sqlTag: the name of the table
// colNo: column to be displayed
// myData: returned data (in array)
// rowNameArray: the names (in array)
//
function getDataFromTable(sqlTag, colNo, myData) {

	var table = document.getElementById(sqlTag);  // sqlTag: the name of the table
	var tbody = table.firstChild;
	var tr = tbody.firstChild.nextSibling;

	var index = 0;
	while (tr != null) {
		var td = tr.firstChild;

		var columnNo = 0;
		while (td != null) {
			//if (columnNo == 0) {
				//rowNameArray[index] = td.innerText;
				//alert(rowNameArray[index]);
				
			//} else if (columnNo == colNo) {
			if (columnNo == colNo) {
				//alert(td.innerText);
				myData[index] = parseInt(td.innerText);
				index ++;
			}
			td = td.nextSibling;
			columnNo ++;
		}
		tr = tr.nextSibling;
	}
}


//
// retrieve the data from the html table (DBHtmlSortable)
//
function getData(sqlTag, selectedCol) {

	// get column names
	getColNames(sqlTag);
	
	// get the row names
	getFirstRow(sqlTag);
	
	// get data
	var dataAll = new Array();

	var x = 0;
	for (x=1;x<selectedCol.length;x++) {	
		var myData = new Array();
//		var rowNameArray = new Array();
		getDataFromTable(sqlTag, selectedCol[x], myData);
		dataAll[x-1] = myData;
	}
	return dataAll;
}


//
// generate the color array from line, area, and column chart
//
function getRandomColorArr(dataAll) {
	// only generate once
	if (hasRandomColor) 
		return randomColor;
	
	for (i=0;i<dataAll.length;i++) {
		randomColor[i] = parseInt(Math.random()*10000000%819200);
	}
	
	hasRandomColor = true;
	return randomColor;
}