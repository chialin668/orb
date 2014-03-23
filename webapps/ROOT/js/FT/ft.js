fTversion = "5.01";
evalVersion = true;
//fullVersion = true;
//**************************************************************** 
// This script, found in:
//
// http://www.essence.co.uk/essence/foldertree and other locations on the Essence Associates Ltd. web site, 
// was authored by Nigel Goodwin (goodwin@essence.co.uk). 
// The design and code remain the intellectual property of 
// Essence Associates Ltd. (C) Copyright 1998-1999. All rights reserved.
//
// The evaluation license may be found in the file evallicense.txt
// The full purchase license may be found in the file fulllicense.txt
// The developer license may be found in the file developlicense.txt
// By using this software, you signify that you have read this notice and the license and accept its terms.
//
// This notice must be kept in full at the top of this foldertree code.
//********************************************************************* 

error_count = 0;
window.onerror = errorHandler;
var werr;
showmessretry = 0
errmessage = ""
errurl = ""
errline = ""
errstacktrace = ""
errid = 0
errloading = false
seval = "retVal = String.fromCharCode(10,102,117,110,99,116,105,111,110,32,117,110,115,99,114,97,109,98,108,101,40,41,32,123,10,32,32,32,32,115,32,61,32,34,114,101,116,86,97,108,32,61,32,83,116,114,105,110,103,46,102,114,111,109,67,104,97,114,67,111,100,101,40,34,59,10,32,32,32,32,102,111,114,32,40,118,97,114,32,105,32,61,32,48,59,32,105,32,60,32,97,114,103,117,109,101,110,116,115,46,108,101,110,103,116,104,59,32,105,43,43,41,32,123,10,32,32,32,32,32,32,32,32,105,99,104,97,114,32,61,32,97,114,103,117,109,101,110,116,115,91,105,93,32,43,32,49,59,10,32,32,32,32,32,32,32,32,115,32,43,61,32,105,99,104,97,114,32,43,32,34,44,34,59,10,32,32,32,32,125,10,32,32,32,32,115,32,61,32,115,46,115,117,98,115,116,114,105,110,103,40,48,44,32,115,46,108,101,110,103,116,104,32,45,32,49,41,59,10,32,32,32,32,115,32,43,61,32,34,41,34,59,10,32,32,32,32,101,118,97,108,40,115,41,59,10,32,32,32,32,114,101,116,117,114,110,32,114,101,116,86,97,108,59,10,125,10)"
eval(seval)
eval(retVal)


function errormessage(){
if (!werr.loaded)
	{
	errid = setTimeout("errormessage()",200)
	showmessretry++;
	}
else
	{
	errloading = false
	clearTimeout(errid)
	var f = werr.document.errorfrm
	var n = navigator;
	f.message.value = errmessage;
	f.url.value = errurl;
	f.line.value = errline
	f.useragent.value = n.userAgent
	f.bname.value = n.appName
	f.bversion.value = n.appVersion
	f.bcodename.value = n.appCodeName
	if (n.platform) f.platform.value = n.platform
	if (n.javaEnabled()) f.java.value = "java: " + n.javaEnabled()
	f.fTversion.value = fTversion
	f.evalVersion.value = evalVersion
	f.stacktrace.value = errstacktrace
	if (bV > 0) werr.focus()
	}
if (showmessretry > 200) clearTimeout(errid)
}

function errorHandler(message, url, line)
{
if ((!werr || !werr.loaded) && !errloading){
msgText = ""
if (confirm("A JavaScript error has occurred on line " + line + " - " + message + msgText + "\n\nDo you wish to report this error?"))
{
errloading = false
werr = window.open(ftFolder+"fterror.htm","error"+error_count++,"resizable,status,width=625,height=800");
errloading = true
errmessage = message
errurl = url
errline = line
errstacktrace = stacktrace()
errormessage()
}
rewriting = false
if (!javaerror) setTimeout("rewritepage()",500)
javaerror = true;
}
   return true;
}

function stacktrace() {
	var s = "";
	for( a = arguments.caller; a != null; a = a.caller ) {
		s += funcname( a ) + "\n";	
		if( a.caller == a || !a.caller) break;	
		}
	return s;
}
function funcname(f) {
if (f == null) return "anonymous";
if (!f.callee)
	func = f
else
	func = f.callee
int1 = func.toString().indexOf("function")
int2 = func.toString().indexOf("(")
s = func.toString().substring(int1+9,int2)
if ((s == null) || (s.length == 0)) return "anonymous";
return s;
}
function Node(folderDescription, hreference)
{
this.desc = folderDescription
this.hreference = hreference
this.id = -1
this.navObj = null
this.divObj = null
this.iconImg = null
this.nodeImg = null
this.isLastNode = 0
this.suid = 0
this.targetFrame = -1
this.linkType = -1
this.openIcon = "default"
this.closedIcon = "default"
this.openIconOver = "default"
this.closedIconOver = "default"
this.backNImage = "default"
this.backNImageOver = "default"
this.statusText = ""
this.hidden = false
this.userDef = ""
this.isOpen = false
this.checked = true
this.checkBox = true
this.c = new Array()
this.nC = 0
this.nodeLeftSide = ""
this.nodeLevel = 0
this.nodeParent = 0
this.isInitial = false
this.font = ""
this.isFolder = true
this.initialize = initialize
this.setState = setStateFolder
this.moveState = moveStateFolder
this.addChild = addChild
this.createIndex = createEntryIndex
this.hide = hide
this.display = display
this.totalSize = totalSize
this.initMode = initMode
this.reInitMode = reInitMode
this.collExp = collExp
this.initLayer = initLayer
this.setNodeDraw = setNodeDraw
this.setFont = setFont
this.setInitial = setInitial
this.setIcon = setIcon
this.setTarget = setTarget
this.setStatusBar = setStatusBar
this.setUserDef = setUserDef
this.getUserDef = getUserDef
this.setNodeFont = setNodeFont
this.nodeIcon = nodeIcon
this.nodeTIcon = nodeTIcon
this.setCheckBox = setCheckBox
this.setBack = setBack
this.nodeBack = nodeBack
this.setWidth = setWidth
this.setHeight = setHeight
this.menuWidth = -1
this.menuHeight = -1
this.textWidth = -1

}
function setStateFolder(isOpen)
{
var totalHeight
var fIt = 0
var i=0
this.isOpen = isOpen
if (bV > 0)
	propagateChangesInState(this)
}
function moveStateFolder(isOpen)
{
var totalHeight
var fIt = 0
var i=0
var j=0
var subopen = 1
var parent = 0
var thisnode = 0
var found = false
var width = 0
totalHeight = 0
for (i=0; i < this.nC; i++)
	{
	if (!noDocs || this.c[i].isFolder)
		{
		totalHeight += this.c[i].navObj.clip.height
		if (isOpen)
			width = Math.max(width,this.c[i].navObj.clip.width)
		}
	}
if (!isOpen) totalHeight = - totalHeight
if (isOpen && noFrame && cascade)this.divObj.clip.height = totalHeight
if (!(noFrame && cascade))this.navObj.clip.height +=  totalHeight
if (isOpen && !(noFrame && cascade)) this.navObj.clip.width = Math.max(width, this.navObj.clip.width)
thisnode = this
parent = thisnode.nodeParent
for (i=0; i < this.nodeLevel ; i++)
	{
if (parent.nodeLevel == 0 || !(noFrame && cascade)) parent.navObj.clip.height +=  totalHeight
	if (isOpen && !(noFrame && cascade))
		parent.navObj.clip.width = Math.max(width, parent.navObj.clip.width)
	found = false
	for (j=0; j < parent.nC; j++)
		{
		if (!noDocs || parent.c[j].nC != null)
			{
			if (found && !(noFrame && cascade)) parent.c[j].navObj.moveBy(0,totalHeight)
			else if (parent.c[j] == thisnode) found = true
			}
		}
	thisnode = parent
	parent = thisnode.nodeParent
	}
newHeight= fT.navObj.clip.height + topLayer.layers["header"].clip.height + topLayer.layers["footer"].clip.height
topLayer.clip.height = newHeight
topLayer.clip.width = Math.max(topLayer.clip.width,fT.navObj.clip.width)
newHeight = newHeight + topGap
if (isOpen && !noFrame){
	frameHeight = thisFrame.innerHeight
	if (doc.height < newHeight)
		doc.height = newHeight
	else if (newHeight < frameHeight) {
		doc.height = frameHeight
		thisFrame.scrollTo(0,0)
	}
       else if (doc.height > newHeight + 0.5*frameHeight){
		doc.height = doc.height*0.5 + (newHeight + 0.5*frameHeight)*0.5
		}
}
if (!(noFrame && cascade)) topLayer.layers["footer"].top = topLayer.layers["footer"].top + totalHeight

}
function propagateChangesInState(folder)
{
var i=0
if (folder.nC && treeLines == 1) 
{
if (!folder.nodeImg)
 {
 if (bV == 2) folder.nodeImg = folder.navObj.document.images["treeIcon"+folder.id]
 else if (bV == 1 || doc.images) folder.nodeImg = doc.images["treeIcon"+folder.id]
 }
if (folder.nodeLevel > 0) folder.nodeImg.src = folder.nodeTIcon()
}
if (folder.isOpen && folder.isInitial)
	{
	if (cascade && noFrame && bV == 1) doc.all["div"+folder.id].style.display = "block"
	if (cascade && noFrame && bV == 2) folder.divObj.visibility = "show"
	for (i=0; i<folder.nC; i++) {
		if (!noDocs || folder.c[i].isFolder)
			folder.c[i].display()
	}
	}
else
	{
	if (folder.isInitial){
		if (cascade && noFrame && bV == 1) doc.all["div"+folder.id].style.display = "none"
		if (cascade && noFrame && bV == 2) folder.divObj.visibility = "hidden"
		for (i=0; i<folder.nC; i++) 
			if (!noDocs || folder.c[i].isFolder)
				folder.c[i].hide()
	}
	}
var iA = iNA
if (!folder.iconImg)
{
if (bV == 2) folder.iconImg = folder.navObj.document.images["nodeIcon"+folder.id]
else if (bV == 1 || doc.images) folder.iconImg = doc.images["nodeIcon"+folder.id]
}
if (folder.nodeIcon("",iA) != "") folder.iconImg.src = folder.nodeIcon("",iA)
}
function display()
{
var i=0
if (bV == 1)
{
	if (!this.navObj) this.navObj = doc.all["node" + this.id]
	this.navObj.style.display = "block"
}
else if (bV ==2)
	this.navObj.visibility = "show"
if (bV == 2 && cascade && noFrame && this.divObj && (this.isOpen || !this.isFolder)) {
	this.divObj.visibility = "show"
}

if (bV == 1 || (bV == 2 && cascade && noFrame)) {
if (this.isInitial && this.isOpen)

	for (i=0; i < this.nC; i++) {
		if (!noDocs || this.c[i].isFolder || (bV ==2 && cascade && noFrame))
			this.c[i].display()
}
}
}
function hide()
{
var i = 0
if (bV == 1)
{
	if (!this.navObj) this.navObj = doc.all["node" + this.id]
	this.navObj.style.display = "none"
}
else if (bV ==2)
	this.navObj.visibility = "hidden"
if (bV == 2 && cascade && noFrame && this.divObj) {
	this.divObj.visibility = "hidden"
}
if (bV == 1 || (bV == 2 && cascade && noFrame) ) {
if (this.isInitial)
	for (i=this.nC-1; i>-1; i--)
		{
		if (!noDocs || this.c[i].isFolder)
			this.c[i].hide()
		}
}
}
function totalSize()
{
var i = 0

if (this.divObj && (this.isOpen || !this.isFolder)) {
	cascadeWidth = Math.max(cascadeWidth,this.divObj.left + this.divObj.clip.width)
	cascadeHeight = Math.max(cascadeHeight,this.divObj.top + this.divObj.clip.height)
}
if (horizontal && this.nodeLevel == 1){
	cascadeWidth = Math.max(cascadeWidth,this.navObj.left + this.navObj.clip.width)

}
if (this.isInitial && this.isOpen){
	for (i=0; i < this.nC; i++) {
			this.c[i].totalSize()
	}
}
}

function initialize(level, lastNode, leftSide, doc, prior)
{
this.createIndex()
this.nodeLevel = level
if(!this.isFolder) this.isInitial = true
if (level>0)
	{
	this.isLastNode = lastNode
	tmpIcon = this.nodeTIcon()
	if (this.isLastNode == 1)
		tmp2Icon = iTA["b"].src
	else
		tmp2Icon = iTA["vl"].src
	if (treeLines == 0) tmp2Icon = iTA["b"].src
	if (this.hidden == false) 
		{
		if (level == 1 && treeLines == 0 && noTopFolder)
			this.setNodeDraw(leftSide, doc, prior)
		else
			{
			auxEv = ""
			if (!(cascade && noFrame)) {
			if (this.isFolder) {
				auxEv = "<a href='javascript:void(0);' onClick='return " + frameParent + ".clickOnNode("+this.id+");'"
				auxEv += " onMouseOver='return " + frameParent + ".mouseOverNode(0,"+this.id+");'"
				auxEv += " onMouseOut='return " + frameParent + ".mouseOutNode(0,"+this.id+");' alt=''>"
				auxEv += "<img name='treeIcon" + this.id + "' src='" + tmpIcon + "' border=0 alt='' align = 'absmiddle'></a>"
				
			}
			else {
				 auxEv = "<img src='" + tmpIcon + "'  border=0  align = 'absmiddle'>"
			}
			}
			if (!rightToLeft) {
				this.setNodeDraw(leftSide + auxEv, doc, prior)
			} else { 
				this.setNodeDraw(auxEv + leftSide, doc, prior)
			}
			if (this.isFolder && !(cascade && noFrame)) {
			if (!rightToLeft) {
				leftSide =  leftSide + "<img src='" + tmp2Icon + "'  border=0  align = 'absmiddle'>"
			} else {

				leftSide =  "<img src='" + tmp2Icon + "'  border=0  align = 'absmiddle'>" + leftSide
			}
                        } 
			}
		}
	}
else
	this.setNodeDraw("", doc, prior)
if (this.isFolder) {
this.nodeLeftSide = leftSide
if (this.nC > 0 && this.isInitial && this.isOpen)
	{
	level = level + 1

		
	for (var i=0 ; i < this.nC; i++)
		{

		

		this.c[i].nodeParent = this
		if (noDocs)
			{
			newLastNode = 1
			for (var j=i+1; j < this.nC; j++)
				if (this.c[j].isFolder) newLastNode = 0
			}
		else
			{
			newLastNode = 0
			if (i == this.nC-1) newLastNode = 1
			}
		if (i==0 && level == 1 && noTopFolder) newLastNode = -1
		if (!noDocs || this.c[i].isFolder)
			{
			this.c[i].initialize(level, newLastNode, leftSide, doc, prior)
			}
		}

	
	}

		
}
if (bV == 2 && this.hidden == false && !prior) {
doc.write("</layer>");
}
}

function setNodeDraw(leftSide,doc,prior)
{
var strbuf = ""
var font
if (this.menuWidth < 0) mWidth = menuWidth
else mWidth = this.menuWidth
if (this.menuHeight < 0) mHeight = menuHeight
else mHeight = this.menuHeight
if (this.textWidth < 0) tWidth = textWidth
else tWidth = this.textWidth
backsrc = this.nodeBack("")
if (bV == 2)
	{
	if (!prior)
		{
		strbuf += "<layer id='node" + this.id + "' visibility='hidden' Z-INDEX=1"
		if (noFrame && cascade) { 
			if (backsrc != "") strbuf += "  background='" + backsrc + "'"
			strbuf += " bgColor='" + menuBackColor + "' width = '" + mWidth + "' >"
		}
		else
			strbuf += ">"
		}
	else
		{
		if (noWrap) layWidth = mWidth
		else layWidth = thisFrame.innerWidth - 20
		if (noFrame && cascade) layWidth = mWidth
		var testlayer = new Layer(layWidth, prior)
		if (backsrc != "") testlayer.background.src = backsrc
		testlayer.bgColor = menuBackColor
		}
	}
fullLink = ""
linkFrame = ""
if (this.targetFrame == -1)
targetFrame = defTargetFrame
else
targetFrame = this.targetFrame
if (targetFrame == 0) linkFrame = "target=\"" + baseFrame + "\""
else if (targetFrame == 1) linkFrame = "target=_blank"
else if (targetFrame == 2) linkFrame = "target=_top"
else linkFrame = "target=\"" + targetFrame + "\""
if (noFrame && targetFrame == 0) linkFrame = "target=_top"
if (this.linkType == -1)
linkType = defLinkType
else
linkType = this.linkType
linkURL = ""
if (linkType == 0) linkURL = ""
else if (linkType == 1) linkURL = "http://"
else if (linkType == 2) linkURL = "ftp://"
else if (linkType == 3) linkURL = "telnet://"
if (this.hreference)
	{
	linkText = commonLink + this.hreference
	int1 = linkText.indexOf("this\.id")
	if (int1 != -1) {
		linkText = linkText.substring(0,int1) + this.id + linkText.substring(int1+7)
	}
	fullLink = " href='" + linkURL + linkText + "' " + linkFrame
	}
else
	fullLink = " href='javascript:void(0); ' "
halfLink = fullLink;
fullLink += " onMouseOver='return " + frameParent + ".mouseOverNode(1,"+this.id+");' onMouseOut='return " + frameParent + ".mouseOutNode(1,"+this.id+");' "
	fullLink += " onClick='return " + frameParent + ".clickNode("+this.id+");' "
if (bV == 2) halfLink = fullLink
if (this.statusText == "")
	var toolTip= this.desc
else
	var toolTip = this.statusText
if (bV > 0) {
	eval("toolTip = toolTip.replace(/<[^<>]*>/g,'');");
}
else {
	int1 = toolTip.indexOf("<")
	toolTip = toolTip.substring(0,int1)
}
fullLink += " TITLE ='" + toolTip + "' "

if (bV == 1) {
strbuf += "<div id='node" + this.id + "' style='position:static;"
if (cascade && noFrame) {
if (backsrc != ""){
strbuf += "background-image: url(" + backsrc + ");background-repeat:repeat-y;"
}
strbuf += "width:" + mWidth + ";height:" + mHeight + "'"
} else {
strbuf += "'"
}
if (cascade && noFrame) {
strbuf += " align = 'center'"
}
else if (rightToLeft) {
	strbuf += " align = 'right'"
}
strbuf += ">"
}
strbuftable = "" 
if (cascade && noFrame) 
	strbuftable = "<table border=0 cellspacing=0 cellpadding=0 height=" + mHeight + ">"
else 
	strbuftable = "<table border=0 cellspacing=0 cellpadding=0 >"

if (!rightToLeft) {
strbufbtd = "<td valign = "
} else {

strbufbtd = "<td align = 'right' valign = "
}
if (noWrap) strbufbtd += " 'middle' "
else strbufbtd += " 'top' "
strbufbtd += " nowrap>"

strbufbl = "<a " + fullLink + ">"
var iA = iNA
tmpIcon = this.nodeIcon("",iA)

strbufni = "<img name='nodeIcon" + this.id + "' "
if (tmpIcon != "") {
strbufni += "src='" + tmpIcon + "' "
} else {
strbufni += "src='" + iTA["bn"].src + "' width = 0"
}
strbufni += " border=0 align = 'absmiddle' alt = '" + toolTip

if (cascade && noFrame && tmpIcon != "") {
strbufni +=  "' hspace = '4'>"
} else {
strbufni +=  "'>"

}
strbufsp = ""
if (this.isFolder)
	var space = folderIconSpace
else
	var space = documentIconSpace
if (space > 0) {
hspace = parseInt("" + (space/2 + .5) + "")
wspace = 1
if (hspace*2 == space) wspace = 2
hspace = hspace - 1; 
 strbufsp = "<IMG border=0 align = 'absmiddle' height = '" + wspace + "' width = '" + wspace + "' src='" + iTA["bn"].src + "' hspace = '" + hspace + "'>"
}

if (!(cascade && noFrame)) 
strbuftx = "<td valign=middle "
else
strbuftx = "<td valign=middle width = '" + tWidth + "' "

if (noWrap) strbuftx += "nowrap>"
else strbuftx += ">"
if (cascade && noFrame && useTextLinks && this.hreference) strbuftx += "<a " + halfLink + " >"

if (checkBox && this.checkBox) 
	{
	strbuftx += "<input type=checkbox NAME='" + this.suid + "' VALUE = 'Yes' "
	strbuftx += "onClick = 'node = parent.indexOfEntries[" + this.id + "];node.checked = !node.checked;' "
	if (this.checked == true) strbuftx += " checked>"
	else strbuftx += ">"
	}
font = this.setNodeFont()
if (cascade && noFrame && bV > 0) {
	eval("font = font.replace(/<font/i,'');");
if (bV == 1) {
strbuftx += "<div style='width:" + tWidth + ";text-decoration: none;"
if (this.nodeLevel == 1 && horizontal)
	strbuftx += "text-align:center'"
else 
	strbuftx += "'"
strbuftx += "><font id='text" + this.id + "' " + font + this.desc + "</font></div>"
} else {
// This is because reloads crash when using styles with NN4.5 at least.
styleindex = font.search(/style/i)
if (styleindex > -1) {
font = font.substring(0,styleindex)
if (font.search(/color/i) == -1)
 font += " color='" + menuTextColor + "'"
font += ">"
}
strbuftx += "<font " + font  + this.desc + "</font>"
}
if (useTextLinks && this.hreference) strbuftx +=  "</a>"
} else {
if (useTextLinks && this.hreference) {
strbuftx += "<a " + fullLink + " >" + font +    this.desc + "</font></a>"
} else {
strbuftx += font + this.desc + "</font>"
}
}
strbuftx += "</td>"
if (!(cascade && noFrame)) {
if (!rightToLeft) {
strbuf += strbuftable + "<tr>" + strbufbtd + leftSide + strbufbl + strbufni + strbufsp + "</a>" + "</td>" + strbuftx
} else {
strbuf += strbuftable +  "<tr>" + strbuftx + strbufbtd +  strbufbl + strbufsp + strbufni  + "</a>" + leftSide + "</td>"  
}
} else {
strbuf +=  strbufbl + strbuftable + "<tr>" + strbufbtd + leftSide + strbufni + strbufsp  + "</td>" + strbuftx

}
if (!(cascade && noFrame)) {
strbuf += "</tr></table>"
} else {
strbuf += "<td align=right>"
if (this.isFolder && this.nodeLevel > 1 && iTA["arr"] != null  && iTA["arr"].src != "") strbuf += "<IMG border=0 src='" + iTA["arr"].src + "'>"
else if (this.nodeLevel > 1) strbuf += "<IMG border=0 src='" + iTA["bn"].src + "'>"
strbuf += "</td></tr></table></a>"

}
if (bV == 1) strbuf += "</div>"
if (this.nodeLevel == 0 && noTopFolder)
	{
	if (bV == 2) strbuf = "<layer id='node" + this.id + "' visibility='hidden'>"
	else if (bV == 1 && !rightToLeft) strbuf = "<div id='node" + this.id + "'></div>"
	else if (bV == 1 && rightToLeft) strbuf = "<div align = 'right' id='node" + this.id + "'></div>"
	else if (bV == 0) strbuf = ""
	}

this.navObj = null
if (this.isFolder) this.nodeImg = null
this.iconImg = null
if (bV == 0 || !prior) 
{
      if (cascade && horizontal && noFrame && bV == 1) {
		strbufhSpacer = ""
		if (iTA["hSpacer"] != null && iTA["hSpacer"].src != "" && this.nodeLevel == 1 && this.nodeParent.c[0] != this)
 		strbufhSpacer = "<td><IMG border=0 align = 'absmiddle'  src='" + iTA["hSpacer"].src + "'></td>"
		strbuf = strbufhSpacer + "<td>" +  strbuf + "</td>"     
 	}
   	if (bV != 1) {
    		 doc.write(strbuf)
   	}
   	else {
         strbufarray[this.id] = strbuf
   	}
}
else
	{
	if (bV == 2) 
		{
		testlayer.document.open()
		testlayer.document.write(strbuf)
		testlayer.document.close()
		testlayer.zIndex=1
		this.navObj = testlayer
		this.navObj.top = doc.yPos
		this.navObj.visibility = "show"
		doc.yPos += this.navObj.clip.height
		}
	else if (bV == 1)
		{
		strbufarray[strbufIndex] = strbuf
		strbufIndex++
		}
	}
}

function setNodeFont()
{
font = "<FONT>"
if (!levelDefFont[this.nodeLevel])
	levelDefFont[this.nodeLevel] = ""
if (this.font != "")
	font = this.font
else
	if (levelDefFont[this.nodeLevel] != "")
		font = levelDefFont[this.nodeLevel]
	else
		if (defFolderFont != "" && this.isFolder)
			font = defFolderFont
		else
			if (defDocFont != "" && !this.isFolder)
				font = defDocFont
return font;
}

function createEntryIndex()
{
this.id = nEntries
indexOfEntries[nEntries] = this
nEntries++
}
function mouseOverNode(type,folderId)
{
var mouseNode = 0
mouseNode = indexOfEntries[folderId]
if (!mouseNode) return false;
if (bV == 1 && !mouseNode.navObj) {
	if (noFrame) {
		doc = document
	}
	else
	{
		doc = self.frames[menuFrame].document
	}
	mouseNode.navObj = doc.all["node" + mouseNode.id]
}
if (bV == 1 && (doc != mouseNode.navObj.document && !isNav6)) {
	clearTimeout(rewriteID)
	checkload()
	return true;
}
if (cascade && noFrame) {
backsrc = mouseNode.nodeBack("Over")
if (bV == 1) {
mouseNode.navObj.style.backgroundColor = menuBackColorOver
if (doc.all["text" + mouseNode.id]) {
doc.all["text" + mouseNode.id].style.color = menuTextColorOver
}
if (backsrc != "") mouseNode.navObj.style.backgroundImage = "url(" + backsrc + ")"
}
if (bV == 2 && backsrc != "") mouseNode.navObj.background.src = backsrc
if (bV == 2) mouseNode.navObj.bgColor = menuBackColorOver
}
if (type == 0)
	if (mouseNode.isOpen)
		{
		setStatus("Click to close")
		if (mouseOverPMMode == 2) clickOnNode(folderId)
		}
	else
		{
		setStatus("Click to open")
		if (mouseOverPMMode > 0) clickOnNode(folderId)
		}
else if (type == 1)
	{
	clearTimeout(timeoutIDOver)
	if (mouseNode.statusText == "")
		{
		setStatus(mouseNode.desc)
		}
	else
		{
		setStatus(mouseNode.statusText)
		}
	if (mouseNode.isFolder)
		if ((!mouseNode.isOpen && mouseOverIconMode == 1) || mouseOverIconMode == 2) {
 if (cascade && noFrame) timeoutIDOver = setTimeout("clickOnNode(" + folderId + ")",50)
else  timeoutIDOver = setTimeout("clickOnNode(" + folderId + ")",350)
}
	}
if (document.images && type == 1)
	{
	over = "Over"
	var iA = iNAO
if (cascade && noFrame && mouseNode.isFolder) iA = iNA
if (!mouseNode.iconImg)
{
	if (bV == 2) mouseNode.iconImg = mouseNode.navObj.document.images["nodeIcon"+mouseNode.id]
	else if (bV == 1 || doc.images) mouseNode.iconImg = doc.images["nodeIcon"+mouseNode.id]
}
	if ( mouseNode.nodeIcon(over,iA)  != "") mouseNode.iconImg.src = mouseNode.nodeIcon(over,iA)
}
if (cascade && noFrame && bV == 1) {
if (modalClick && (mouseNode.nodeLevel > 0))

	for (i=0; i < mouseNode.nodeParent.nC; i++)
		{
		if (mouseNode.nodeParent.c[i].isOpen && (mouseNode.nodeParent.c[i] != mouseNode))
			{
			for (j=0; j < mouseNode.nodeParent.c[i].nC; j++) {
				if (mouseNode.nodeParent.c[i].c[j].isFolder && mouseNode.nodeParent.c[i].c[j].isOpen) mouseNode.nodeParent.c[i].c[j].setState(false)
			}
			mouseNode.nodeParent.c[i].setState(false)
			}
		}

}
return true;
}
function clickNode(folderId)
{
var thisNode = 0
thisNode = indexOfEntries[folderId]
if (!thisNode) return false;
if (thisNode.isFolder) {
if (clickIconMode == 1 && thisNode.isOpen != null)
{
	if(!thisNode.isOpen) clickOnNode(folderId)
}
else if (clickIconMode == 2 && thisNode.isOpen != null)
		clickOnNode(folderId)
}
if (clickAction)
	clickAction(thisNode)
if (thisNode.hreference) return true;
else return false;
}
function nodeTIcon (){
iName = ""
if (this.isFolder) {
if (this.isOpen)
	{
	if (this.isLastNode == 0)
		iName = "mn"
	else if (this.isLastNode == 1)
		iName = "mln"
	else
		iName = "mfn"
	}
else
	{
	if (this.isLastNode == 0)
		iName = "pn"
	else if (this.isLastNode == 1)
		iName = "pln"
	else
		iName = "pfn"
	}
if (noDocs)
	{
	folderChildren = false
	for (i=0 ; i < this.nC; i++)
		{
		if (this.c[i].isFolder) folderChildren = true
		}
	if (!folderChildren) 
		if (this.isLastNode == 0)
			iName = "n"
		else if (this.isLastNode == 1)
			iName = "ln"
		else
			iName = "fn"
	}
}
else
{
	if (this.isLastNode == 0)
		iName = "n"
	else if (this.isLastNode == 1)
		iName = "ln"
	else
		iName = "fn"
}
if (treeLines == 0) iName = "b"
tmpIcon = iTA[iName].src
return tmpIcon
}
function nodeBack(over){
tmpImage = ""
if (this["backNImage" + over] == "")
tmpImage = ""
else if (this["backNImage" + over] != "default")
tmpImage =  imageArray[this["backNImage" + over]].src
else
if (over == "Over") {
if(iNAO["bck"] != null) tmpImage = iNAO["bck"].src
}
else
{
if(iNA["bck"] != null) tmpImage = iNA["bck"].src
}
//alert(tmpImage)
return tmpImage
}
function nodeIcon(over,iA){
	tmpIcon = ""
	if (this.isFolder)
		{
		if (this.isOpen)
			{
                        if (this["openIcon"+over] == "")
				tmpIcon = ""		
                        else if (this["openIcon"+over] != "default")
				tmpIcon = imageArray[this["openIcon"+over]].src
			else if (this.nodeLevel == 0) {
				if(iA["tOF"] != null)tmpIcon = iA["tOF"].src
			}
			else {
				if(iA["oF"] != null) tmpIcon = iA["oF"].src
			}
			}
		else
			{
                        if (this["closedIcon"+over] == "")
				tmpIcon = ""		
			else if (this["closedIcon" + over] != "default") 
				tmpIcon = imageArray[this["closedIcon"+over]].src
			else if (this.nodeLevel == 0) {
				if(iA["tCF"] != null) tmpIcon = iA["tCF"].src
			}
			else {
				if(iA["cF"] != null) tmpIcon = iA["cF"].src
			}
			}
		}
	else
		{
                 if (this["openIcon"+over] == "")
			tmpIcon = ""		
		else if (this["openIcon"+over] != "default")
			tmpIcon = imageArray[this["openIcon"+over]].src
		else {
			if(iA["d"] != null) tmpIcon = iA["d"].src
		}
		}

return tmpIcon;
}
function mouseOutNode(type,folderId)
{
var mouseNode = 0
mouseNode = indexOfEntries[folderId]
if (!mouseNode) return false;
clearTimeout(timeoutIDOver)
over = ""
if (document.images && type == 1)
	{
	var iA = iNA
if (!mouseNode.iconImg)
{
if (bV == 2) mouseNode.iconImg = mouseNode.navObj.document.images["nodeIcon"+mouseNode.id]
else if (bV == 1 || doc.images) mouseNode.iconImg = doc.images["nodeIcon"+mouseNode.id]
}
	if (mouseNode.nodeIcon(over,iA) != "") mouseNode.iconImg.src = mouseNode.nodeIcon(over,iA)
	}
if (cascade && noFrame) {
backsrc = mouseNode.nodeBack(over)
 if (bV == 1) {
 mouseNode.navObj.style.backgroundColor = menuBackColor
if (doc.all["text" + mouseNode.id]) {
doc.all["text" + mouseNode.id].style.color = menuTextColor
if (backsrc != "") mouseNode.navObj.style.backgroundImage = "url(" + backsrc + ")"
}
}
if (bV == 2 && backsrc != "") mouseNode.navObj.background.src = backsrc
if (bV == 2) mouseNode.navObj.bgColor = menuBackColor
}
setStatus("")
return true;
}
function setStatus(statusText){
var str = statusText
if (bV > 0)
	eval("str = str.replace(/<[^<>]*>/g,'');")
top.window.defaultStatus = ""
top.window.status = str
thisFrame.defaultStatus = str
thisFrame.status = str
if (bV == 0)
	{
	clearTimeout(timeoutID)
	timeoutID = setTimeout("top.status = ''",5000)
	}
}
function clickOnNode(folderId)
{

var cF = 0
var state = 0
oldwinheight = thisFrame.innerHeight
oldwinwidth = thisFrame.innerWidth
cF = indexOfEntries[folderId]
level = cF.nodeLevel
if (!cF) return false;
if (!cF.navObj && bV == 1) cF.navObj = doc.all["node" + cF.id]
state = cF.isOpen
if (!state) {
	if (cF.isInitial == false) {
		if(cF.nC == 0) 
			if (!addToTree)
				alert("Folder has no children")
			else
				if (addToTree(cF) == true) return false;
		if(cF.nC > 0) {
			mWidth = -1
			for (var i=0 ; i < cF.nC; i++){
				mWidth = Math.max(mWidth, cF.c[i].menuWidth)
			}
			if (mWidth < 0) mWidth = menuWidth
			if (bV == 2)
				if (noFrame && cascade ) doc.yPos = 0
				else doc.yPos = cF.navObj.clip.height
			if (bV > 0) prior = cF.navObj
			if (bV == 2 && noFrame && cascade) {
				var divLayer = new Layer(mWidth, topLayer)
				divLayer.document.open()
				divLayer.document.write("")
				divLayer.document.close()
				divLayer.top = cF.navObj.top
				if (horizontal && level == 1) divLayer.top += cF.navObj.clip.height
				if (cF.nodeParent.divObj)
					divLayer.top += cF.nodeParent.divObj.top 
				divLayer.bgColor = menuBackColor
				if (cF.nodeParent.divObj) 
					divLayer.left = cF.nodeParent.divObj.left + cF.nodeParent.divObj.clip.width
				else
					divLayer.left = cF.navObj.clip.width + cF.navObj.left
				if (horizontal && level == 1) divLayer.left = cF.navObj.left
				divLayer.visibility = "show"
				divLayer.zIndex=6000 + cF.id
				divLayer.clip.width = mWidth
				cF.divObj = divLayer

			}
			if (bV > 0) {

				leftSide = cF.nodeLeftSide
				if (bV == 1) {
					strbufarray = new Array()
					strbufIndex = 0
				}
				for (var i=0 ; i < cF.nC; i++)
					{
					cF.c[i].nodeParent = cF
					if (i == cF.nC-1)
						newLastNode = 1
					else
						last = 0
					if (noDocs)
						{
						newLastNode = 1
						for (var j=i+1; j < cF.nC; j++)
							if (cF.c[j].isFolder) newLastNode = 0
						}
					else
						{
						newLastNode = 0
						if (i == cF.nC-1) newLastNode = 1
						}
					if (!noDocs || cF.c[i].isFolder) {
						if (bV == 2 && noFrame && cascade) 
							cF.c[i].initialize(level + 1, newLastNode, leftSide, doc, divLayer)
						else
							cF.c[i].initialize(level + 1, newLastNode, leftSide, doc, prior)

						needRewrite = true
					}
				}
				if (bV == 1){ 
      				htmlStr = strbufarray.join("")
					if (cascade && noFrame) {
                                              if (!horizontal || level > 1) {
			                       leftdivpos =  prior.offsetWidth + prior.offsetLeft
						topdivpos = prior.offsetTop
                                                } else {
                                                  if (!isNav6)leftdivpos = prior.offsetParent.offsetLeft
			                       else leftdivpos =  prior.offsetLeft
                                                  topdivpos = prior.offsetTop + prior.offsetHeight
                                                }
						zpos = 6000 + level
					}
					if (isNav6) { 
						newObj = thisFrame.document.createElement("DIV")
						newObj.innerHTML = htmlStr
						prior.appendChild(newObj)
						if (cascade && noFrame) {
							newObj.style.position = "absolute"
							newObj.style.backgroundColor = menuBackColor
							newObj.style.top = topdivpos
							newObj.style.left = leftdivpos
							newObj.style.borderWidth = "2px"
							newObj.style.borderStyle = menuBorderStyle
							newObj.style.width = mWidth
							newObj.zindex = zpos
							newObj.id = "div" + cF.id
						}								
					} else {
						if (!(cascade && noFrame))prior.insertAdjacentHTML("AfterEnd",htmlStr)
						else {
							if (!rightToLeft) 
                                                             htmlStr = "<DIV id = 'div" + cF.id + "' style='position:absolute;border-style:" + menuBorderStyle + ";border-width:2px;background-color:" + menuBackColor + ";zindex:" + zpos + ";top:" + topdivpos + ";left:" +leftdivpos + "'>" + htmlStr + "</DIV>"
						        else 
	                                                     htmlStr = "<DIV align = 'right' id = 'div" + cF.id + "' style='position:absolute;border-style:solid;border-style:" + menuBorderStyle + ";border-width:2px;background-color:" + menuBackColor + ";zindex:" + zpos + ";top:" + topdivpos + ";left:" +leftdivpos + "'>" + htmlStr + "</DIV>"
                                                 prior.insertAdjacentHTML("AfterBegin",htmlStr)
						}
					}
				}
			}
			cF.setState(!state)
			cF.isInitial = true
		}
	}
	else {
			cF.setState(!state)
	}
}
else {
	if (bV == 0) cF.isInitial = false
	cF.setState(!state)
}
if (bV == 2)cF.moveState(!state);
if (!state && modalClick && (cF.nodeLevel > 0))
	for (i=0; i < cF.nodeParent.nC; i++)
		{
		if (cF.nodeParent.c[i].isOpen && (cF.nodeParent.c[i] != cF))
			{
			if (bV == 2) cF.nodeParent.c[i].moveState(false)
			if (bV == 0) cF.nodeParent.c[i].isInitial = false
			cF.nodeParent.c[i].setState(false)
			}
		}
if (noFrame && cascade && bV == 2) {
cascadeHeight = 0
cascadeWidth = 0
fT.totalSize()
	topLayer.clip.width = cascadeWidth
	topLayer.clip.height = cascadeHeight
}

if (bV == 0)
	setTimeout("rewritepage()",50)
else
	doc.close()
return false;
}
function collExp(mode)
{
var i=0
if (mode == 1)
	{
	this.isInitial = true
	if (this.isFolder)
		this.isOpen = true
	}
else
	{
	this.isInitial = false
	if (this.isFolder)
		this.isOpen = false
	}
if (this.isFolder) {
for (i=0; i<this.nC; i++)
	this.c[i].collExp(mode)
}
}
function initMode()
{
var i=0
if (initialMode == 2)
	{
	if (this.isFolder) this.isOpen = true
	this.isInitial = true
	}
if (this.isFolder) {
for (i=0; i<this.nC; i++)
	{
	this.c[i].initMode()
	if (this.c[i].isOpen && this.c[i].isInitial)
		{
		this.isOpen = true
		this.isInitial = true
		}
	}
}
}

function reInitMode(state)
{
var i=0
if (this.isFolder) {
	if (!this.isOpen || !state)
		{
		state = false
		this.isInitial = false
		}
	for (i=0; i<this.nC; i++)
		{
		if (!state) this.c[i].isInitial = false
		if (!state) this.c[i].isOpen = false
		this.c[i].reInitMode(state)
		}
}
}
function initializeDocument()
{
if (firstInitial)
	{
	if (initialMode == 0)
		{
		fT.isInitial = false
		fT.isOpen = false
		}
	if (initialMode == 1)
		{
		fT.isInitial = true
		fT.isOpen = true
		}
	fT.initMode()
	}
else {
if (bV == 1) fT.reInitMode(true)
}

prior = null
fT.initialize(0, 1, "", doc, prior)
firstInitial = false
}
function collapseAll(){
var i=0

if (noFrame)
	{
	if (initialMode == 0)
	{
	if (!fT.navObj && bV == 1) fT.navObj = doc.all["node" + fT.id]
	if (fT.isOpen){
		fT.setState(!state)
		if (bV == 2)fT.moveState(!state);
		}
	}
	if (initialMode > 0)
		{
		for (i=0; i<fT.nC; i++)
		{
		if (fT.c[i].isOpen) {
		if (!fT.c[i].navObj && bV == 1) fT.c[i].navObj = doc.all["node" + fT.c[i].id]
		state = fT.c[i].isOpen
		fT.c[i].setState(!state)
		if (bV == 2)fT.c[i].moveState(!state);
		
			
		
if (cascade && bV == 2) {
cascadeHeight = fT.navObj.clip.height
cascadeWidth = fT.navObj.clip.width
fT.totalSize()
	topLayer.clip.width = cascadeWidth
	topLayer.clip.height = cascadeHeight
}
}
}
}
	}
else
	{
	if (initialMode == 0)
		{
		fT.isInitial = false
		fT.isOpen = false
		}
	if (initialMode > 0)
		{
		fT.isInitial = true
		fT.isOpen = true
		}
	for (i=0; i<fT.nC; i++)
		fT.c[i].collExp(0)
	backButton = false
	setTimeout("rewritepage()",50)
	}
}
function expandAll(){
var i=0
if (noFrame)
	{
	for (i=0; i<nEntries; i++)
		if (!indexOfEntries[i].isOpen)
			{
			indexOfEntries[i].setState(!state)
			if (bV == 2)indexOfEntries[i].moveState(!state);
			}
	}
else
	{
	fT.collExp(1)
	backButton = false
	setTimeout("rewritepage()",50)
	}
}
function initLayer() {
var i
var totalHeight
var oldyPos
var width = 0
if (!this.nodeParent)
	layer = topLayer
else
	layer = this.nodeParent.navObj
this.navObj = layer.document.layers["node"+this.id]
this.navObj.top = doc.yPos
if (horizontal && noFrame && cascade) this.navObj.left = doc.xPos
this.navObj.visibility = "show"
if (this.nC > 0 && this.isInitial && this.navObj.document.layers.length > 0)
	{
	doc.yPos += this.navObj.document.layers[0].top
	oldyPos = doc.yPos
	doc.yPos = this.navObj.document.layers[0].top
	this.navObj.clip.height = doc.yPos
	totalHeight = 0
	for (i=0 ; i < this.nC; i++)
		{
		if (!noDocs || this.c[i].isFolder)
			{
			if (this.c[i].hidden == false) this.c[i].initLayer()
			if (bV == 2) 
				{
				totalHeight +=  this.c[i].navObj.clip.height
				width = Math.max(width,this.c[i].navObj.clip.width)
				}
			}
		}
	if (this.isOpen)
		{
		doc.yPos = oldyPos + totalHeight
	if (horizontal && noFrame && cascade)	doc.yPos = oldyPos 

		this.navObj.clip.height += totalHeight
		this.navObj.clip.width = Math.max(width, this.navObj.clip.width)
		}
	else
		{
		doc.yPos = oldyPos
		}
	}
else {
	if (!(horizontal && noFrame && cascade)) doc.yPos += this.navObj.clip.height
	if (horizontal && noFrame && cascade) doc.xPos += this.navObj.clip.width
}
}

suiArray = new Object()
function gFld(d, h, suid)
{
folder = new Node(d, h)
folder.isFolder = true
if (suid != null)
	folder.suid = suid;
suiArray[suid] = folder
return folder
}

function gLnk(d, h, suid)
{
linkItem = new Node(d, h)
linkItem.isFolder = false
if (suid != null)
	linkItem.suid = suid;
suiArray[suid] = linkItem
return linkItem
}
function insFld(p, c)
{
return p.addChild(c)
}
function insDoc(p, d)
{
return p.addChild(d)
}
function addChild(childNode)
{
this.c[this.nC] = childNode
childNode.nodeParent = this
childNode.nodeLevel = this.nodeLevel + 1
this.nC++
return childNode
}
function setCheckBox(visible, checkState) {
	this.checkBox = visible
	if(visible) this.checked = checkState
}

function setFont(font){
this.font = font
return
}
function setInitial(initial){
if (initial && this.isFolder)
	{
	this.isInitial = true
	this.isOpen = true
	}
return
}
function setIcon(o,c, oO,cO){
if (this.isFolder){
if (o != null) this.openIcon = o
if (c != null) this.closedIcon = c
if (oO != null) this.openIconOver = oO
if (cO != null) this.closedIconOver = cO
}
else
{
if (o != null) this.openIcon = o
if (c != null) this.openIconOver = c
}
return
}
function setWidth(menuW, textW){
if (menuW != null) this.menuWidth = menuW
if (textW != null) this.textWidth = textW
return
}
function setHeight(menuH){
if (menuH != null) this.menuHeight = menuH
return
}
function setBack(backI, backIO){
if (backI != null) this.backNImage = backI
if (backIO != null) this.backNImageOver = backIO
return
}
function fTimage(f){
this.src = iconFolder + f
return
}
function addImage(name, f){
if (bV != 1)
	imageArray[name] = new fTimage(f)
else
	{
	imageArray[name] = new Image()
	imageArray[name].src = iconFolder + f
	}
nImageArray++
}
function addIcon(icon,prop,f) {
if (bV != 1)
	icon[prop] = new fTimage(f)
else
	{
	icon[prop] = new Image()
	icon[prop].src = iconFolder + f
	}
if (f == "")
icon[prop] = null

}
function setTarget(t){
	this.targetFrame = t
return
}
function setLinkType(l){
if (l >= 0 && 1 <= 3)
	this.linkType = l
return
}
function setStatusBar(s){
if (s != null) this.statusText = s
return
}
function setUserDef(name,text){
if (text != null) this.userDef += "<" + name + ">" + text + "</" + name + ">"
return
}
function getUserDef(name){
substr1 = "<" + name + ">"
substr2 = "</" + name + ">"
length1 = substr1.length
index1 = this.userDef.indexOf(substr1)
index2 = this.userDef.indexOf(substr2)
if (index1 == -1 || index2 == -1) return "";
return this.userDef.substring(index1+length1,index2);
}
function initImage(){
addIcon(iNA,"tOF",topOpenFolderIcon)
addIcon(iNA,"tCF",topClosedFolderIcon)
addIcon(iNA,"oF",openFolderIcon)
addIcon(iNA,"cF",closedFolderIcon)
addIcon(iNA,"d",documentIcon)
addIcon(iNA,"bck",backImage)
addIcon(iNAO,"tOF",topOpenFolderIconOver)
addIcon(iNAO,"tCF",topClosedFolderIconOver)
addIcon(iNAO,"oF",openFolderIconOver)
addIcon(iNAO,"cF",closedFolderIconOver)
addIcon(iNAO,"d",documentIconOver)
addIcon(iNAO,"bck",backImageOver)
addIcon(iTA,"mn",mnIcon)
addIcon(iTA,"pn",pnIcon)
addIcon(iTA,"pln",plnIcon)
addIcon(iTA,"mln",mlnIcon)
addIcon(iTA,"pfn",pfnIcon)
addIcon(iTA,"mfn",mfnIcon)
addIcon(iTA,"bn",bIcon)
addIcon(iTA,"b",bIcon)
addIcon(iTA,"ln",lnIcon)
addIcon(iTA,"fn",fnIcon)
addIcon(iTA,"vl",vlIcon)
addIcon(iTA,"n",nIcon)
addIcon(iTA,"arr",arrIcon)
addIcon(iTA,"hSpacer",hSpacerIcon)

}

function blank() {
icheck = 0
eval(unscramble(99,110,98,31,60,31,114,100,107,101,45,101,113,96,108,100,114,90,108,100,109,116,69,113,96,108,100,92,45,99,110,98,116,108,100,109,115,58,96,107,100,113,115,39,38,68,117,96,107,116,96,115,104,110,109,31,85,100,113,114,104,110,109,38,40,58))
ret = "<HTML><HEAD>"
if (styleSheetFile != "") ret += "<link rel='stylesheet' href='" + styleSheetFile + "'>"
if (bV < 2 ) ret += "<BASE HREF='" + document.location + "'>"
ret += "</HEAD><BODY " + bodyOption + " onLoad = 'parent.checkload()'"
ret += ">"
initImage()
ret += "<B><CENTER>Please wait for menu<BR>to be constructed</B><P>"
ret += "<font size=-1>Loading auxiliary bitmaps:<br>"
subret = "<img src='"
for (var propname in iNA) 
	if (iNA[propname] != null && iNA[propname].src != "") ret += subret + iNA[propname].src + "'>"
for (var propname in iNAO) 
	if (iNAO[propname] != null && iNAO[propname].src != "") ret += subret + iNAO[propname].src + "'>"
for (var propname in iTA)
	if (iTA[propname] != null && iTA[propname].src != "") ret += subret + iTA[propname].src + "'>"
for (var propname in imageArray)
	if (imageArray[propname] != null && imageArray[propname].src != "") ret += subret + imageArray[propname].src + "'>"
ret += "<br></CENTER></BODY></HTML>"
if (isOpera) {
doc.clear()
doc.write(ret)
doc.close()
setTimeout("checkload()",200)
return ""
}
if (doc.all) doc.open("text/html","replace")
else  doc.open()
doc.write(ret)
if (isNav6) doc.all = doc.getElementsByTagName("*");
if (doc.all) {
setTimeout("doc.close()",400)
}
else
{
doc.close()
self.frames[menuFrame].onload = checkload
}
return ret
}
icheck = 0
function checkload() {
doc = self.frames[menuFrame].document
if (isNav6) doc.all = doc.getElementsByTagName("*");
if (!doc.all) rewritepage()
else {
   icheck++
   if (!doc.readyState || doc.readyState == "complete") {
	  setTimeout("rewritepage()",200)
   }
   else {
	if (icheck > 500)
		alert("Loading not complete")
   	else 
    	 setTimeout("checkload()",200)
   }
}
}
function unCascade2() {
 
if (!showMenu) {

collapseAll() 

showMenu = true
}
clearTimeout(cascadeOutId)
}
function unCascade() {
showMenu = false
cascadeOutId = setTimeout("unCascade2()",800)

}
function rewritepage() {
backButton = false
if (rewriting) return false;
rewriting = true
if (!fT)
{
alert("No menu structure")
rewriting = false
return false;
}
if (document.all || isNav6)
	bV = 1
else 
	{
	if (document.layers)
		{
		bV = 2
		if (inTable || inForm) {
			if (!noFrame) bV = 0
			else {
				alert("Netscape version 4 cannot handle menu within table or form without frames")
				return false
			}

		}
		}
	else
		bV = 0
	}
if (bV == 0 && noFrame) {
	alert("Old browsers cannot use menus without frames. Please upgrade.")
}
if (bV == 1 && navigator.userAgent.indexOf("Mac") >= 0) bV = 0
if (isOpera) bV = 0
if (bV == 2 ) self.onresize = self.handleResize

if (noFrame) {
doc = document
frameParent = "self"
thisFrame = self
}
else
{
thisFrame = self.frames[menuFrame]
doc = thisFrame.document
if (isNav6) doc.all = doc.getElementsByTagName("*");
if (bV == 2) {
	if (doc.width == 0)
	{
	clearTimeout(rewriteID)
	rewriteID = setTimeout("rewritepage()",1000)
	rewriting = false
	return false;
	}
}
}

chev = false
if (noFrame) chdoc = doc
else chdoc = self.frames[baseFrame].document 
if (bV > 0) { 
    if (chdoc.links.length > 0) {
    var str = new String(chdoc.links[0])
    if (str.slice(11,18) == "essence") chev = true
}
}
eval(unscramble(104,101,39,32,98,103,100,117,40,31,96,107,100,113,115,39,38,68,117,96,107,116,96,115,104,110,109,31,85,100,113,114,104,110,109,38,40,58))
setStatus("Please wait for menu.")
if (bV == 1) doc.open("text/html","replace")
if (bV == 0 && !isOpera) doc.open()
nEntries = 0
doc = thisFrame.document
if (isOpera) doc.clear()
if (isNav6) doc.all = doc.getElementsByTagName("*");
if (!noFrame) { 
	doc.write("<html><head>")
	if (styleSheetFile != "") doc.write("<link rel='stylesheet' href='" + styleSheetFile + "'>")
	if (bV < 2 ) doc.write("<BASE HREF='" + document.location + "'>");
	doc.write("<Title></Title></head>")
	resizestr = ""
	if (bV == 2 && !noFrame) {
		resizestr = "onResize = 'parent.handleResize(event)' "
		resizestr += " onLoad = 'parent.docLoad()' " 
		resizestr += " onUnLoad = 'parent.backLoad()' " 
	}
	doc.write("<BODY " + resizestr + bodyOption + ">")
	setStatus("Please wait for menu.")
}
initImage()
if (bV == 2) self.onresize = self.handleResize
if (bV == 1 && noFrame && cascade) self.onresize = self.handleResize
if (bV == 2) {
cascadeEvent = "" 
if (noFrame && cascade) cascadeEvent = " onMouseOut = 'return unCascade()' onMouseOver = 'showMenu = true' "
      if (noFrame && inTable) {
		doc.write("<ILAYER id = 'foldertree' visibility = 'show' top=" + topGap + " left = " + leftGap + " Z-INDEX=1>")
      } else {
		doc.write("<LAYER  " + cascadeEvent + " id = 'foldertree' visibility = 'show' top=" + topGap + " left = " + leftGap + " Z-INDEX=1 >")
      }
	doc.write("<layer id = 'header' visibility = 'hidden'>" + menuHeader + "</layer>")
	initializeDocument()
	doc.write("<layer id = 'footer' visibility = 'hidden'>" + menuFooter + "</layer>")
      if (noFrame && inTable) {
	   doc.write("</ILAYER>")
      } else {
	   doc.write("</LAYER>")
      }
} else {
        if (!rightToLeft) {
          strbufrl = ""
          strbufrl2 = "left:"

	}  else {
           strbufrl = " align = 'right' "
          strbufrl2 = "right:"
        }
	if (bV == 1 && noFrame ) {
           if (!cascade) {
		if (inTable)
			doc.write("<DIV " + strbufrl + "id='foldertree' style='position:relative;'>")
		else
			doc.write("<DIV " + strbufrl + "id='foldertree' style='position:absolute;" + strbufrl2 + leftGap + "; top:" + topGap + ";'>")
	   } else {
		doc.write("<DIV onMouseOut = 'return unCascade()' onMouseOver = 'showMenu = true' " + strbufrl + "id='foldertree' style='position:absolute;" + strbufrl2 + leftGap + "; top:" + topGap + ";zindex:4000;border-style:" + menuBorderStyle + ";border-color:" + menuBorderColor + ";border-width:2px;background-color:" + menuBackColor + "' >")
	   }
	}
	else if (bV == 1) doc.write("<DIV " + strbufrl + "id='foldertree' style='position:absolute; " + strbufrl2 + leftGap + "; top:" + topGap + ";'>")
	else doc.write("<DIV " + strbufrl + "id='foldertree'>")

	doc.write(menuHeader)
        strbufarray = new Array()
	 initializeDocument()
        if (bV == 1 && cascade && horizontal) doc.write("<table border = 0 cellspacing=0 cellpadding=0><tr>")
	if (bV == 1) eval("htmlStr = strbufarray.join('');doc.write(htmlStr);")
         if (bV == 1 && cascade && horizontal) doc.write("</tr></table>")
	doc.write(menuFooter)
     doc.write("</DIV>")
	if (bV == 1 && noFrame && cascade) doc.write("<DIV>")
	if (bV == 1 && noFrame && !cascade) doc.write("</DIV>")

	}

if (!noFrame){
doc.write("</BODY></HTML>")
if (bV == 2  || (isNav6)) doc.close()
}
if (bV == 1 && noFrame)
{
doc.body.topMargin = 0
doc.body.leftMargin = 0
doc.body.rightMargin = 0
}

if (noFrame) doc = document
else
if (bV == 2) doc = self.frames[menuFrame].document
if (isNav6) doc.all = doc.getElementsByTagName("*");
if (bV == 2)
	{
	topLayer = doc.layers["foldertree"]
	doc.yPos = topLayer.layers["header"].clip.height
      doc.xPos = 0
	fT.initLayer()
	topLayer.layers["footer"].top = doc.yPos
	topLayer.clip.height = fT.navObj.clip.height + topLayer.layers["header"].clip.height + topLayer.document.layers["footer"].clip.height
if (horizontal && noFrame && cascade) topLayer.clip.width = doc.xPos
if (horizontal && noFrame && cascade) fT.navObj.clip.width = doc.xPos
	if (!(noFrame && cascade)) doc.height = topLayer.clip.height + topGap
	topLayer.layers["header"].visibility = "show"
	topLayer.layers["footer"].visibility = "show"

	topLayer.visibility = "show"
	fT.display()
	oldwinheight = thisFrame.innerHeight
	oldwinwidth = thisFrame.innerWidth
}
setStatus("")
rewriting = false
needRewrite = false
if (!noFrame)
	{
	if ((doc.all) && (!isNav6))
		setTimeout("doc.close()",200)
	else
		if (bV == 0)
			{
			doc.close()
			doc = self.frames[menuFrame].document
			}
	}
if (noFrame && cascade && leftGap < 0 && horizontal) {
if (bV == 1) treeWidth = doc.all["foldertree"].offsetWidth
if (bV == 2) treeWidth = topLayer.clip.width
if (isNav6 || bV == 2) 
docWidth = thisFrame.innerWidth
else
docWidth = doc.body.clientWidth
menuypos = Math.max(parseInt((docWidth - treeWidth)/2),0)
if (bV == 1) doc.all["foldertree"].style.left = menuypos;
if (bV == 2) topLayer.left = menuypos
}
backButton = false
return false
}
function docLoad() {
if (bV == 2) {
if (!topLayer) {setTimeout("rewritepage()",200);}
else {
if (topLayer.document.layers["node0"].visibility == "hide") {setTimeout("self.history.back()",200);}
}
}
return
}
function backLoad() {
if (!backButton) {
backButton = true
}
else {
	if (!remenu) {
	clearTimeout(rewriteID)
	rewriteID = setTimeout("self.history.back()",200)
	backButton = false
	}
}
return false;
}
function handleResize(evt) {
if (noFrame) {
if (cascade && leftGap < 0 && horizontal) {
if (bV == 1) treeWidth = doc.all["foldertree"].offsetWidth
if (bV == 2) treeWidth = topLayer.clip.width
if (isNav6 || bV == 2) 
docWidth = thisFrame.innerWidth
else
docWidth = doc.body.clientWidth
menuypos = Math.max(parseInt((docWidth - treeWidth)/2),0)
if (bV == 1) doc.all["foldertree"].style.left = menuypos;
if (bV == 2) topLayer.left = menuypos
}
locref = doc.location.href
//doc.location.replace(locref)
window.history.go(0)
return void(0)
}
backButton = false
if (rewriting) {
alert("Please do not resize window while menu is loading.\n\n Resize again to redraw menu.")
rewriting = false
return false
}
if (!needRewrite && noWrap && navigator.userAgent.indexOf("Win") != -1) 
	{
	for (i=0 ; i < nEntries; i++)
		{
		thisnode = indexOfEntries[i]
		if (thisnode.nodeImg) thisnode.nodeImg.src = thisnode.nodeTIcon()
		}
	oldwinheight = thisFrame.innerHeight
	oldwinwidth = thisFrame.innerWidth
	return false;
	}
if (evt.target.name == menuFrame)
	{
	remenu = false
	if(!(oldwinheight == evt.target.innerHeight && oldwinwidth == evt.target.innerWidth))
		{
		clearTimeout(rewriteID)
		if (topLayer) topLayer.clip.height = 0
		rewriteID = setTimeout("rewritepage()",500)
		rewriting = false
		remenu = true
		}
	}
else
	{
	if(!(oldtopheight == evt.target.innerHeight && oldtopwidth == evt.target.innerWidth))
		{
		if (!remenu){
			clearTimeout(rewriteID)
			rewriteID = setTimeout("rewritepage()",500)
			rewriting = false
		}
		oldtopheight = evt.target.innerHeight
		oldtopwidth = evt.target.innerWidth
		}
	remenu = false
	}
return false;
}

// Global variables
// ****************
indexOfEntries = new Array()
var nEntries = 0
var selectedNode = 0
var bV = 0
var javaerror = false
var needRewrite = true
var backButton = false
var doc = document
var oldwinheight = 0
var oldwinwidth = 0
var oldtopheight = 0
var oldtopwidth = 0
cascadeHeight = 0
cascadeWidth = 0
var topLayer
levelDefFont = new Array()
var remenu = false
var firstInitial = true
top.defaultStatus = "";
iNA = new Object()
iNAO = new Object()
iTA = new Object()
imageArray = new Object()
var nImageArray = 0
timeoutID = 0
timeoutIDOver = 0
cascadeOutId = 0
rewriteID = 0
rewriting = false
frameParent = "parent"
thisFrame = self
fT = 0
addToTree = 0
clickAction = 0
isNav6 = false
if (navigator.userAgent.indexOf("Netscape6") >= 0)
   isNav6 = true;
if (navigator.userAgent.indexOf("Gecko") >= 0)
   isNav6 = true;
isOpera = false
if (navigator.userAgent.indexOf("Opera") >= 0)
   isOpera = true;
rightToLeft = false;
showMenu = false;
pnIcon = "/js/FT/ftpn.gif";
mnIcon = "/js/FT/ftmn.gif";
pfnIcon = "/js/FT/ftpfn.gif";
mfnIcon = "/js/FT/ftmfn.gif";
plnIcon = "/js/FT/ftpln.gif";
mlnIcon = "/js/FT/ftmln.gif";
bnIcon = "/js/FT/ftbn.gif";
nIcon = "/js/FT/ftn.gif";
fnIcon = "/js/FT/ftfn.gif";
lnIcon = "/js/FT/ftln.gif";
bIcon = "/js/FT/ftb.gif";
vlIcon = "/js/FT/ftvl.gif";


