function equipment(equipname,identifier,description) //constructor 
{ 
  //constant data 
 this.equipname = equipname
 this.identifier = identifier
 this.description = description

 this.partof = new Array
 this.npartof = 0
 this.part = new Array
 this.npart = 0
 this.addpart = addpart
this.drawequip = drawequip 
} 
function drawequip(){

var strbuf = "<HTML><HEAD><TITLE></TITLE><link rel='stylesheet' href='ftstyle.css'></HEAD><BODY><P>"
strbuf = strbuf + "<FORM NAME='equipform'>"
strbuf = strbuf + "<TABLE CELLSPACING=0 CELLPADDING=0 WIDTH='95%' COLS=4 BORDER=0>"
strbuf = strbuf + "<TR><TH align=left >Name</TH>"
strbuf = strbuf + "<TD><INPUT TYPE=text NAME='equipname' size=15></TD>"
strbuf = strbuf + "<TH align=left>Identifier</TH>"
strbuf = strbuf + "<TD><INPUT TYPE=text NAME='identifier' size=4> </TD></TR>"
strbuf = strbuf + "<TR><TH align=left>Description</TH>"
strbuf = strbuf + "<TD colspan=3><TEXTAREA ROWS = 5 NAME='description' WRAP cols=40> </TEXTAREA></TD></TR>"
strbuf = strbuf + "<TR><TH align=left>Normal properties</TH><TD>"
strbuf = strbuf + "<SELECT NAME='partlist' size=1>"
if (this.npart == 0)
strbuf = strbuf + "<OPTION VALUE='1'>None"
for (var i=0; i < this.npart; i++)
{
strbuf += "<OPTION VALUE='" + i + "'>" + this.part[i]
}

strbuf = strbuf + "</SELECT>"
strbuf = strbuf + "</TD></TR></TABLE></FORM><P></Basefont></BODY></HTML>"

top.basefrm.window.document.write(strbuf)
top.basefrm.window.document.close()

var afrm = top.basefrm.window.document.forms.equipform

afrm.equipname.value=this.equipname
afrm.identifier.value=this.identifier
afrm.description.value=this.description


//afrm.partlist.options.length = 0
//if (this.npart == 0)
//afrm.partlist.options[0] = new Option("None","None",false,false)
//for (var i=0; i < this.npart; i++)
//{
//var howMany = afrm.partlist.options.length 
//afrm.partlist.options[howMany] = new Option(this.part[i],this.part[i],false,false)
//}

top.basefrm.window.document.close()
if (top.browserVersion ==2) top.basefrm.window.history.go(0)

}
function addequip(equipname, identifier, description) {
equip = new equipment(equipname, identifier, description)
indexofEquipment[nEquipment] = equip
idofEquipment[nEquipment] = identifier
nEquipment++
return equip
}
function addpart(){
for (var i=0; i < arguments.length; i++)
{
this.part[this.npart] = arguments[i]
this.npart++
}
}
function outputequip(id){
for (var i=0; i < nEquipment; i++)
{
if (idofEquipment[i] == id) 
  indexofEquipment[i].drawequip() 
}
return void(0);
}
indexofEquipment = new Array
idofEquipment = new Array
var nEquipment = 0;