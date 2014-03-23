// =========================================================================
//
// helperFunctions.js - a set of helper functions to assist in the testing of XML for <SCRIPT>
//
// =========================================================================
//
// Copyright (C) 2001 - David Joham (djoham@yahoo.com)
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



/*****************************************************************************
                            MODULE VARIABLES
*****************************************************************************/

var docRef = document.getElementById("frmForm"); //global reference to the form object


/*****************************************************************************
                                    FUNCTIONS
*****************************************************************************/

function centerMe(myWindow) {
    /***********************************************************************************
    function: centerMe()

    author: djoham@yahoo.com

    Description:    takes the window passed in and centers it on the screen

    ************************************************************************************/

    //each test suite is 800px wide and 500px tall

    var xPos = screen.width/2 - 400;
    var yPos = screen.height/2 -255;

    myWindow.moveTo(xPos,yPos);

} // end function centerMe


function clearTestResults() {
    /***********************************************************************************
    function: clearTestResults()

    author: djoham@yahoo.com

    Description:    Loops through the test results select object and clears the contents

    ************************************************************************************/
    var intCount = docRef.lstResults.length;

    //again, Opera is really off base here, but I'll work around them

    for (intLoop = 0; intLoop < intCount; intLoop++) {
        if (navigator.appName == "Opera") {
            docRef.lstResults[0] = null;
        }
        else {
            docRef.lstResults.remove(0);
        }
    }

} // end function clearTestResults


function createTestResultsHeader(header) {
    /***********************************************************************************
    function: createTestResultsHeader

    author: djoham@yahoo.com

    Description:    puts a header block section into the test results section

    ************************************************************************************/
    var blankOption = new Option("");
    var firstStarOption = getTestHeaderOption("**************************************************************************");
    var newOption = getTestHeaderOption(header.toUpperCase());
    var secondStarOption = getTestHeaderOption("**************************************************************************");

    insertOptionElement(blankOption);
    insertOptionElement(firstStarOption);
    insertOptionElement(newOption);
    insertOptionElement(secondStarOption);

} //end function createTestResultsHeader

function getTestFailureOption(optionText) {
    /***********************************************************************************
    function: getTestFailureOption()

    author: djoham@yahoo.com

    Description:    Returns an option element with the "failure" style set

    ************************************************************************************/
    var newOption = new Option(optionText);
    newOption.style.color = "red";
    newOption.style.fontWeight = "bold";
    return newOption;
} // end function getTestFailureOption


function getTestHeaderOption(optionText) {
    /***********************************************************************************
    function: getTestHeaderOption()

    author: djoham@yahoo.com

    Description:    Returns an option element with the "header" style set

    ************************************************************************************/
    var newOption = new Option(optionText);
    newOption.style.color = "green";
    newOption.style.fontSize = "larger"
    newOption.style.fontWeight = "bold";
    return newOption;
} // end function getTestHeaderOption


function getTestSuccessOption(optionText) {
    /***********************************************************************************
    function: getTestSuccessOption()

    author: djoham@yahoo.com

    Description:    Returns an option element with the "success" style set

    ************************************************************************************/
    var newOption = new Option(optionText);

    //IE doesn't support inherit - thanx redmond
    try {
        newOption.style.color = "inherit";
    }
    catch (e) {
        //do nothing
    }
    return newOption;
} // end function getTestSucccessOption


function insertOptionElement(optionObject) {
    /***********************************************************************************
    Function: insertOptionElement()
    Author: djoham@yahoo.com

    Description:    Handles the browser sniffing necessary to insert an
                         option element into the select box

    ************************************************************************************/

   //IE does this wrong according to the W3C. I have to browser sniff
    //http://www.w3.org/TR/2000/CR-DOM-Level-2-20000510/html.html#ID-94282980

   //opera just flat does it wrong. At least IE is in the ballpark

    //with IE being the lowest common denominator, I'll have my API look like it. Nav will take what the
    //API gives it and translate that into what it's supposed to be


    var selectObject = document.getElementById("frmForm").lstResults;

    if (navigator.appName == "Microsoft Internet Explorer") {
        selectObject.add(optionObject);
    }
    else if (navigator.appName == "Opera") {
        selectObject[selectObject.length] = optionObject;
    }
    else {
        //Nav does it right
        selectObject.add(optionObject, null);
    }


} // end function insertOptionElement


function setActionLinkVisibility(visible) {
    /***********************************************************************************
    Function: setActionLinkVisibility
    Author: djoham@yahoo.com

    Description:
        sets the visibility of the action link on the test suite pages -
        this is done to ensure that the user doesn't clink on a link in IE
        before the browser if finished loading the page which results
        in a nasty JavaScript error
    ************************************************************************************/
    if (visible == true) {
        document.getElementById("testSuiteLinkBar").style.visibility = "visible";
    }
    else {
        document.getElementById("testSuiteLinkBar").style.visibility = "hidden";
    }
     
} // end function setActionLinkVisibility
