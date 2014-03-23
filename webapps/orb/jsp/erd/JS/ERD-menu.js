/*
Slide-in Menu by Al Sparber (www.projectseven.com)
To add more shock to your site, visit www.DHTML Shock.com
*/

//Variables to be defined by user. Pee=-200 is the ending position of the menu upon closing
//It must match the left position of the menuBar layer as defined in the Style Sheet
//drec and speed can be experimented with to adjust smoothness and speed of animation

var pee = -200
var drec = 40;
var speed = 20;

//Don't touch!
var l = pee;

//Don't touch. This is the function that closes the menu
function Proj7GlideBack () {l += drec;
  if (document.layers) {
    document.menuBar.left = l;
  }
  else if (document.all) {document.all.menuBar.style.pixelLeft = l;
  }
  else if (document.getElementById) {document.getElementById('menuBar').style.left = l + 'px';
  }
  if (l < 0)
    setTimeout('Proj7GlideBack()', speed);
  
else {
	  if (document.layers) {
      var html = '';
      html += '<A HREF="javascript:;"';
      html += 'onClick="Proj7GlideOut(); return false;"';
      html += 'Class="glideText"';
      html += 'close'+ '<br>';
      html += 'close'+ '<Br>';
      html += '<\/A>';
      var a = window.document.menuBar.document.glider;
      a.document.open();
      a.document.write(html);
      a.document.close();
    }
    else if (document.all) {document.all.glidetextLink.innerHTML = 'close';
      document.all.glidetextLink.onclick = moveIn;
    }
    else if (document.getElementById) {
      document.getElementById('glidetextLink').firstChild.nodeValue ='close';
      document.getElementById('glidetextLink').onclick = moveIn;
    }
  }
}
//Don't touch. This is the function that opens the menu
function Proj7GlideOut () {l -= drec;
  if (document.layers) {document.menuBar.left = l;
  }
  else if (document.all) {document.all.menuBar.style.pixelLeft = l;
  }
  else if (document.getElementById) {document.getElementById('menuBar').style.left = l + 'px';
  }
  if (l > pee)
    setTimeout('Proj7GlideOut()', speed);
  else {
    if (document.layers) {
      var html = '';
      html += '<A HREF="javascript:;"';
      html += 'onclick="Proj7GlideBack(); return false;"';
      html += 'Class="glideText"';
      html += 'menu'+ '<Br>';
      html += 'menu'+ '<Br>';
      html += '<\/A>';
      var a = window.document.menuBar.document.glider;
      a.document.open();
      a.document.write(html);
      a.document.close();
    }
    else if (document.all) {document.all.glidetextLink.innerHTML = 'menu';
      document.all.glidetextLink.onclick = moveOut;
    }
    else if (document.getElementById) {
      document.getElementById('glidetextLink').firstChild.nodeValue ='menu';
      document.getElementById('glidetextLink').onclick = moveOut;
    }
  }
}
function moveIn () {Proj7GlideOut();return false;
}
function moveOut() {Proj7GlideBack();return false;
}

<!--NNresizeFix Reloads the page to workaround a Netscape Bug-->
if (document.layers) {
origWidth = innerWidth;
origHeight = innerHeight;}
function reDo() {
if (innerWidth != origWidth || innerHeight != origHeight)
location.reload();}
if (document.layers) onresize = redo;
