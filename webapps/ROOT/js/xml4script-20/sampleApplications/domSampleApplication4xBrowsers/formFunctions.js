
// =========================================================================
//
// formFunctions.js - functions for DOM sample application for 4.x and above browsers for XML for <SCRIPT>
//
// =========================================================================
//
// Copyright (C) 2000 - 2001 Michael Houghton (mike@idle.org) and David Joham (djoham@yahoo.com)
//
// This library is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 2.1 of the License, or (at your option) any later version.

// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.

// You should have received a copy of the GNU Lesser General Public
// License along with this library; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

var errs ="";
var colours = new Array();
colours[1] = "#f0f0ff";
colours[2] = "#e0e0ff";
colours[3] = "#d0d0ff";
colours[4] = "#c0c0ff";
colours[5] = "#b0b0ff";
colours[6] = "#a0a0ff";
colours[7] = "#9090ff";
colours[8] = "#8080ff";
colours[9] = "#7070ff";
colours[10] = "#6060ff";
colours[11] = "#5050ff";

function centerMe() {
    //the application is 800px wide and 500px tall
    var xPos = screen.width/2 - 400;
    var yPos = screen.height/2 -255;

    window.moveTo(xPos,yPos);

} // end function centerMe

function displayDocument(d) {
    var disp;
    if(d.docNode==null) return;
    disp = newWin();
    disp.write("<HTML><head><title>output hello</title></head><BODY bgcolor=white></body></html>");
    
    displayElement(d.docNode, disp,0);

    disp.write("</BODY></HTML>");
    disp.close();
} // end function displayDocument



function displayElement(el, disp,depth) {
    if(el==null) {
        return;
    }

    if(!(el.nodeType=='ELEMENT')) {
        return;
    }

    // title
    disp.write('<font face="Arial, Helvetica" size="+2"><b>' + el.tagName + "</b></font>");

    // attributes

    var atts = "";

    var attlist = el.getAttributeNames();

    for(var i=0; i < attlist.length; i++) {
        var a = attlist[i];
        atts += '<tr><td><font face="Arial, Helvetica"><b>' + a + ": </b></font></td>" + '<td><font face="Arial, Helvetica">' + el.getAttribute(a) + "</td></tr>";
    }

    if(atts!="") {
        disp.write('<table>' + atts + "</table>");
    }
    else {
        disp.write('<br>');
    }

    // children

    if(el.children!=null) {
        var els = el.children;

        for(var e=0; e < els.length; e++) {

            var ch = els[e];
            if(ch.nodeType=='TEXT') {
                var cont = trim(ch.content,true,true);
                if(cont.length!=0) {
                    disp.write('<font face="Arial, Helvetica"><i>' + ch.content + "</i></font>");
                }
            }
            else if (ch.nodeType=='CDATA') {

                disp.write("<pre>");

                var output = "";

                for(var p=0; p<ch.content.length; p++) {
                    var cp = ch.content.charAt(p);
                    output += (cp=='<' ? '&lt;' : cp);
                }
                disp.write(output + "</pre>");
            }
            else {
                disp.write('<table width="100%" cellspacing=10><tr><td bgcolor="' + colours[depth+1] + '">');
                displayElement(ch, disp,depth+1);
                disp.write("</td></tr></table>");
            }
        }

    }
} // end function displayElement



function err(str) {
    errs += str;
} // end function err



function newWin() {
    var w = window.open("blank.html","output", "width=300,height=300,location=no,menu=no,status=no");
    return w.document;
} // end function newWin


function process() {
    var src = document.frm4xSample.elements['in'].value;
    errs = "";

    var xd;
    xd = new XMLDoc(src, err);
    if(xd.hasErrors){
        writeErrorReport();
    }
    else {
        displayDocument(xd);
    }
} // end function process



function wipeText() {
    document.frm4xSample.elements['in'].value ="";
} // end function wipeText


function writeErrorReport() {
    var disp = newWin();
    disp.open();
    disp.write("<HTML><BODY>");
    disp.write("<h1>Error report</h1>");
    disp.write("<pre>" + errs + "</pre>");
    disp.write("</BODY></HTML>");
    disp.close();
} // end function writeErrorReport





