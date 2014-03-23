/*Credit JavaScript Kit www.javascriptkit.com*/
var dragapproved=false
var z,x,y

function makeOnTop(el) {
	var daiz;
	var max = 0;

//fnChangeText(el.style.zIndex);
	var da = document.all;

	for (var i=0; i<da.length; i++) {
		daiz = da[i].style.zIndex;
		if (daiz != "" && daiz > max)
			max = daiz;
	}

	el.style.zIndex = max + 1;
}
function move(){
	if (event.button==1&&dragapproved){
		z.style.pixelLeft=temp1+event.clientX-x
		z.style.pixelTop=temp2+event.clientY-y
		return false
	}
}

function drags(){
	if (!document.all)
		return

	if (event.srcElement.className=="drag"){
		dragapproved=true
		z=event.srcElement
		makeOnTop(z)
		temp1=z.style.pixelLeft
		temp2=z.style.pixelTop
		x=event.clientX
		y=event.clientY
		document.onmousemove=move
	}
}

function done() {
	dragapproved=false;
}

document.onmousedown=drags
//document.onmouseup=new Function("dragapproved=false")
document.onmouseup=done
function fnChangeText(data){
   var oTextNode = document.createTextNode(data);
   var oReplaceNode = oItem1.firstChild.replaceNode(oTextNode);
}
