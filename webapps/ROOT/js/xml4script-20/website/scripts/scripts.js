// =========================================================================
//
// scripts.js - scripts to handle functionality of the main web site
//
// =========================================================================
//
// Copyright (C) 2001, 2002 - David Joham (djoham@yahoo.com)
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

function changeTab(whichTab) {
    /***********************************************************************************
    function: changeTab()

    author: djoham@yahoo.com

    Description:    sets the selected tab to be the one displayed

    ************************************************************************************/

    clearTabs();
    eval("switchToTab" + whichTab + "()");

} // end function changeTab


function clearTabs() {

    /***********************************************************************************
    function: clearTabs()

    author: djoham@yahoo.com

    Description:    makes all of the tabs display in the "off" position

    ************************************************************************************/

    document.getElementById("tabGeneral").src = "./images/tabOff.gif";
    document.getElementById("tabFAQ").src = "./images/tabOff.gif";
    document.getElementById("tabDOM").src = "./images/tabOff.gif";
    document.getElementById("tabSAX").src = "./images/tabOff.gif";
    document.getElementById("tabMISC").src = "./images/tabOff.gif";

} // end function clearTabs


function launch4xDomSample() {
    /***********************************************************************************
    function: launch4xDomSample()

    author: djoham@yahoo.com

    Description:  opens a new window with the 4x sample application

    ************************************************************************************/

    window.open("./../sampleApplications/domSampleApplication4xBrowsers/index.html", "hndl", "location=no,menubar=no,resizable=no,scrollbars=no,status=no,titlebar=no,toolbar=no,width=800,height=500");


} // end function launch4xDomSample

function launchDOMTestSuite() {

    /***********************************************************************************
    function: launchDOMTestSuite()

    author: djoham@yahoo.com

    Description:    opens a new window with the DOM test suite as the
                         active page

    ************************************************************************************/

    window.open("./../testSuites/domTest/domTestSuite.html", "hndl", "location=no,menubar=no,resizable=no,scrollbars=no,status=no,titlebar=no,toolbar=no,width=800,height=500");

} // end function launchDOMTestSuite


function launchSAXSample1() {

    /***********************************************************************************
    function: launchSAXSample1

    author: djoham@yahoo.com

    Description:    opens a new window with the SAX Sample application 1

    ************************************************************************************/

    window.open("./../sampleApplications/saxSampleApplication1/saxSampleApplication1.html", "hndl", "location=no,menubar=no,resizable=no,scrollbars=yes,status=no,titlebar=no,toolbar=no,width=800,height=500");

} // end function launchSAXSample1


function launchSAXTestSuite() {

    /***********************************************************************************
    function: launchSAXTestSuite()

    author: djoham@yahoo.com

    Description:    opens a new window with the SAX test suite as the
                         active page

    ************************************************************************************/

    window.open("./../testSuites/saxTest/saxTestSuite.html", "hndl", "location=no,menubar=no,resizable=no,scrollbars=no,status=no,titlebar=no,toolbar=no,width=800,height=500");

} // end function launchSAXTestSuite


function launchSAXTreeViewSample() {

    /***********************************************************************************
    function: launchSAXTreeViewSample

    author: djoham@yahoo.com

    Description:    opens a new window with the SAX Tree View sample

    ************************************************************************************/

    window.open("./../sampleApplications/saxTreeViewSample/saxTreeViewSample.html", "hndl", "location=no,menubar=no,resizable=no,scrollbars=yes,status=no,titlebar=no,toolbar=no,width=800,height=500");

} // end function launchSAXTreeViewSample


function launchModernDomSample() {
    /***********************************************************************************
    function: launchModernDomSample()

    author: djoham@yahoo.com

    Description:    opens a new window with the modern sample application

    ************************************************************************************/

    window.open("./../sampleApplications/domSampleApplicationModernBrowsers/contactManager.html", "hndl", "location=no,menubar=no,resizable=no,scrollbars=no,status=no,titlebar=no,toolbar=no,width=800,height=500");

} // end function launchModernDomSample


function launchXMLEscapeSample() {
    /***********************************************************************************
    function: launchXMLEscapeSample()

    author: djoham@yahoo.com

    Description:    opens a new window with the XMLEscape sample

    ************************************************************************************/

    window.open("./../tools/xmlEscape/xmlEscape.html", "hndl", "location=no,menubar=no,resizable=no,scrollbars=no,status=no,titlebar=no,toolbar=no,width=800,height=500");

} // end function launchXMLEscapeSample



function launchXMLIOSample() {
    /***********************************************************************************
    function: launchXMLIOSample()

    author: djoham@yahoo.com

    Description:    opens a new window with the XMLIO sample application

    ************************************************************************************/

    window.open("./../tools/xmlIO/xmlIO.html", "hndl", "location=no,menubar=no,resizable=no,scrollbars=no,status=no,titlebar=no,toolbar=no,width=800,height=500");

} // end function launchXMLIOSample


function switchToTabDOM() {
    /***********************************************************************************
    function: switchToTabDOM()

    author: djoham@yahoo.com

    Description:    makes the "DOM" tab be the active tab

    ************************************************************************************/

    document.getElementById("tabDOM").src = "./images/tabOn.gif";
    document.getElementById("generalTabContent").style.display = "none";
    document.getElementById("faqTabContent").style.display = "none";
    document.getElementById("saxTabContent").style.display = "none";
    document.getElementById("miscTabContent").style.display = "none";
    document.getElementById("domTabContent").style.display = "none";
    document.getElementById("domTabContent").style.display = "block";

} // end function switchToTabDOM


function switchToTabFAQ() {
    /***********************************************************************************
    function: switchToTabFAQ()

    author: djoham@yahoo.com

    Description:    makes the "FAQ" tab be the active tab

    ************************************************************************************/

    document.getElementById("tabFAQ").src = "./images/tabOn.gif";
    document.getElementById("generalTabContent").style.display = "none";
    document.getElementById("domTabContent").style.display = "none";
    document.getElementById("saxTabContent").style.display = "none";
    document.getElementById("miscTabContent").style.display = "none";
    document.getElementById("faqTabContent").style.display = "none";
    document.getElementById("faqTabContent").style.display = "block";

} // end function switchToTabFAQ



function switchToTabGeneral() {
    /***********************************************************************************
    function: switchToTabGeneral()

    author: djoham@yahoo.com

    Description:    makes the "General" tab be the active tab

    ************************************************************************************/

    document.getElementById("tabGeneral").src = "./images/tabOn.gif";
    document.getElementById("faqTabContent").style.display = "none";
    document.getElementById("domTabContent").style.display = "none";
    document.getElementById("saxTabContent").style.display = "none";
    document.getElementById("miscTabContent").style.display = "none";
    document.getElementById("generalTabContent").style.display = "none";
    document.getElementById("generalTabContent").style.display = "block";

} // end function switchToTabGeneral


function switchToTabMISC() {
    /***********************************************************************************
    function: switchToTabMISC()

    author: djoham@yahoo.com

    Description:    makes the "MISC" tab be the active tab

    ************************************************************************************/

    document.getElementById("tabMISC").src = "./images/tabOn.gif";
    document.getElementById("generalTabContent").style.display = "none";
    document.getElementById("faqTabContent").style.display = "none";
    document.getElementById("domTabContent").style.display = "none";
    document.getElementById("saxTabContent").style.display = "none";
    document.getElementById("miscTabContent").style.display = "none";
    document.getElementById("miscTabContent").style.display = "block"

} // end function switchToTabMISC



function switchToTabSAX() {
    /***********************************************************************************
    function: switchToTabSAX()

    author: djoham@yahoo.com

    Description:    makes the "SAX" tab be the active tab

    ************************************************************************************/

    document.getElementById("tabSAX").src = "./images/tabOn.gif";
    document.getElementById("generalTabContent").style.display = "none";
    document.getElementById("faqTabContent").style.display = "none";
    document.getElementById("domTabContent").style.display = "none";
    document.getElementById("miscTabContent").style.display = "none";
    document.getElementById("saxTabContent").style.display = "none";
    document.getElementById("saxTabContent").style.display = "block";

} // end function switchToTabSAX

