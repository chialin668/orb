//////////////////////////////////////////////
// 			Background of the chart
//////////////////////////////////////////////

//
// mouse activities
//
var downX = 0;
var downY = 0;
var upX = 0;
var upY = 0;

//
// misc
//
var hasCtrlIcn 		= false;		// do we allow poeple to close the chart window?
var movable 		= false;		// do we allow poeple to move the chart?
var hasBackground 	= false;		// has the background?
	
////////////////////////////////////////////////////////////////////////////////////////////////

function mouseDown() {
	downX = event.x;
	downY = event.y;

	var abc = document.getElementById("info");
	document.bob.topVal.value = event.x;
	document.bob.leftVal.value = event.y;
}
	
function mouseUp() {
	upX = event.x;
	upY = event.y;
	var diffX = upX - downX;
	var diffY = upY - downY;

	var Elem1 = document.getElementById("info");
	Elem1.style.left = parseInt(Elem1.style.left) + diffX;
	Elem1.style.top = parseInt(Elem1.style.top) + diffY;
}
	
function mouseMove() {
	//alert(event.x);
}
	
function closeWin() {
	// hide the objects
	hideAll();
		
	// hide the background
	var Elem1 = document.getElementById("info");
	Elem1.style.visibility = "hidden";
}

/**
*
* Create the window and hide it
*
**/
function createWindow(title, left, top, width, height, xCordSize, yCordSize) {

	// some default values
	if (left == null) left = "50pt";	
	if (top == null) top = "100pt";
	if (width == null) width = "400pt";
	if (height == null) height = "200pt";
	if (xCordSize == null || yCordSize == null) {
		xCordSize = borderX;
		yCordSize = borderY;
	}
	var cordStr = xCordSize + "," + yCordSize;

	
	//
	// all objects are based on this one!!
	//
	var obj = document.createElement("v:group");
	obj.id = "info";
	obj.style.position = "absolute";
	obj.style.visibility = "hidden";
    obj.style.left = left;
    obj.style.top = top; 
    obj.style.width = width;
    obj.style.height = height;
    obj.coordsize = cordStr; 
	if (movable) {
		hasCtrlIcn = true;
		obj.onmousedown = mouseDown;
		obj.onmousemove = mouseMove;
		obj.onmouseup = mouseUp;
	} else {
		hasCtrlIcn = false;
	}

	document.body.appendChild(obj);

	//
	// the background
	//
	if (hasBackground) {
		var titleStr = new String(title);
		var rect  = document.createElement("v:rect");
			rect.id = "bg";
			rect.style.position = 'absolute';
			rect.style.left = 0;
  			rect.style.top = 0; 
   		 	rect.style.width = borderX;
	    	rect.style.height = borderY;
   		 	rect.style.backgroundcolor = "green"; 
			rect.fillcolor = "gray"; 
				var title = document.createElement("h3");
				title.align = "center";
					var text = document.createTextNode(titleStr);
  					title.appendChild(text);
			rect.appendChild(title);
		obj.appendChild(rect);  
	}
 	//
	// close window icon
	//
	if (hasCtrlIcn) {
	 	var rect  = document.createElement("v:rect");
			rect.style.position = 'absolute';
			rect.style.left = 30;
	  		rect.style.top = 30; 
    		rect.style.width = 50;
    		rect.style.height = 50;
			rect.fillcolor = "white"; 
			rect.onmousedown = closeWin;
			obj.appendChild(rect);  
 	}
	
 	//
	// objects are drawn here!!
	//
	var rect  = document.createElement("v:rect");
		rect.style.position = 'absolute';
		rect.style.left = 10;
  		rect.style.top = 130; 
    	rect.style.width = borderX-20;
    	rect.style.height = borderY-140;
		rect.fillcolor = "white"; 
		rect.strokecolor = "white"; 
		obj.appendChild(rect);  

}
	
