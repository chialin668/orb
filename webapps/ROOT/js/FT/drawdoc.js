function ftdoc(identifier,title, doctext) //constructor 
{ 

 this.identifier = identifier
 this.title = title
 this.doctext = doctext
this.drawdoc = drawdoc 
} 

function drawact(){
var strbuf = "<HTML><HEAD><TITLE></TITLE><link rel='stylesheet' Type='text/css' href='ftstyle.css'></HEAD><BODY>"
strbuf = strbuf + this.title
strbuf = strbuf + this.doctext
strbuf = strbuf + "</BODY></HTML>"
top.basefrm.window.document.write(strbuf)
top.basefrm.window.document.close()
}

function adddoc(identifier, title, doctext) {
act = new ftdoc(identifier, title, doctext)
indexofActivity[nActivity] = act
idofActivity[nActivity] = identifier
nActivity++
return act
}

function outputact(id){
for (var i=0; i < nActivity; i++)
{
if (idofActivity[i] == id) 
  indexofActivity[i].drawact() 
}
}

indexofDoc = new Array
idofDoc = new Array
nDoc = 0

