clickIconMode = 2
mouseOverIconMode = 1
noWrap = true
noTopFolder = true
treeLines = 0
noFrame = true
noFrameBody = ""
modalClick = true
cascade = true
topGap = 22
leftGap = -1
var folderIconSpace = 0				// blank space after folder icons
var documentIconSpace = 0	
var menuWidth = 140				// Menu width for cascading frameless menus
var menuHeight = 22
var textWidth = 96				// Text width for cascading frameless menus
var horizontal = true	
var menuTextColor = "lightgrey"		        // Background color for cascading frameless menus		
var menuTextColorOver = "white"		        // Background highlight color for cascading frameless menus		
var menuBorderStyle= "none"				// Border style for cascading frameless menus
useTextLinks = true
addImage("blank","ftbn.gif")
addImage("back80","menuback2280.gif")
addImage("backo80","menubackover2280.gif")
defFolderFont = "<font style = 'font-size:10pt;font-family:verdana;text-decoration: none;color:lightgrey'>"
defDocFont = "<font style = 'font-size:10pt;font-family:verdana;text-decoration: none;color:lightgrey'>"
var backImage = "menuback22140.gif"
var backImageOver = "menubackover22140.gif"
var hSpacerIcon = ""

fT = gFld("<i>Been There</i>", "ftbase.htm")
	aux1 = insFld(fT, gFld("Europe", "ftbase2.htm"))	
	aux1.setIcon("","","","")
	aux1.setBack("back80", "backo80")	
	
aux1.setWidth(80,40)
	      aux2 = insFld(aux1, gFld("U.K.", "ftbase3.htm"))
		aux2.setIcon("blank","blank","blank","blank")
		insDoc(aux1, gLnk("Edinburgh", "ftbase2.htm"))
		      aux3 = insFld(aux2, gFld("Scotland", "ftbase.htm"))
				insDoc(aux3, gLnk("Edinburgh", "ftbase2.htm"))
 			insDoc(aux2, gLnk("London", "ftbase3.htm"))
	      aux2 = insFld(aux1, gFld("Germany", "ftbase.htm"))
 			insDoc(aux2, gLnk("Munich", "ftbase2.htm"))
	      aux2 = insFld(aux1, gFld("Greece", "ftbase3.htm"))
 			insDoc(aux2, gLnk("Athens", "ftbase.htm"))
	      aux2 = insFld(aux1, gFld("Italy", "ftbase2.htm"))
		      aux3 = insFld(aux2, gFld("Tuscany", "ftbase3.htm"))	
			insDoc(aux3, gLnk("Florence", "ftbase.htm"))
				insDoc(aux3, gLnk("Pisa pie", "ftbase2.htm"))
			insDoc(aux2, gLnk("Rome", "ftbase3.htm"))
	      aux2 = insFld(aux1, gFld("Portugal", "ftbase.htm"))
 			insDoc(aux2, gLnk("Lisboa", "ftbase2.htm"))
	aux1 = insFld(fT, gFld("America", "ftbase3.htm"))
aux1.setIcon("","","","")
	aux1.setBack("back80", "backo80")
aux1.setWidth(80,40)
	      aux2 = insFld(aux1, gFld("Canada", "ftbase.htm"))
 			insDoc(aux2, gLnk("Montreal", "ftbase2.htm"))
	      aux2 = insFld(aux1, gFld("United States", "ftbase3.htm"))
 			insDoc(aux2, gLnk("Boston", "ftbase.htm"))
 			insDoc(aux2, gLnk("New York", "ftbase2.htm"))
 			insDoc(aux2, gLnk("Washington", "ftbase3.htm"))
