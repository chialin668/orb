
// =========================================================================
//
// domTestSuite.js - a test suite for testing xmldom.js
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

var testErrorCalling = "";

var testXML =""
                    + "<?xml version=\"1.0\"?>"
                    + "<ROOTNODE>"
                        + "<TAG1 name=\"foo\">"
                            + "tag1content"
                        + "</TAG1>"
                        + "<TAG2>"
                            + "1 is &lt;&amp;&gt; 2"
                        + "</TAG2>"
                        + "<TAG3>"
                            + "<TAG4>"
                                + "tag4content"
                            + "</TAG4>"
                        + "</TAG3>"
                        + "<TAG5>tag5content</TAG5>"
                        + "<TAG6 nodeType=\"ELEMENT\" id=\"4\">"
                            + "This child is of nodeType TEXT"
                            + "<!--This child is of nodeType COMMENT-->"
                            + "<![CDATA[this child is of <<<>nodeType CDATA]]>"
                            + "this child has a special &amp;lt; character that should come out escaped"
                        + "</TAG6>"
                    + "</ROOTNODE>";

/*****************************************************************************
                                    FUNCTIONS
*****************************************************************************/

function domManipulationTestEight() {
    /*****************************************************************************
    function: domManipulationTestEight

    author: djoham@yahoo.com

    description:
        Tests the parser's capability to get a list of the attributes
        from the node

    *****************************************************************************/
    var objDom = new XMLDoc("<?xml version=\"1.0\"?><ROOTNODE><TAG1 elementOne=\"elementValueOne\" elementTwo=\"elementValueTwo\">foo</TAG1></ROOTNODE>", xmlError);
    //first find the node for which we want to read the attributes, in this case it is TAG1
    var domTree = objDom.docNode;
    var referenceNode = domTree.getElements("TAG1")[0];


    var elements = referenceNode.getAttributeNames();

    //now check the values in the array. I should have two, elementOne and elementTwo
    //Most browsers return elementOne in elements[0] and elementTwo in elements[1] but
    //Konqueror seems to switch them. While maybe annoying, this is perfectly legal and
    //I have to accomodate it.

    if ( (elements.length ==2) && ( (elements[0] == "elementOne") || (elements[0] == "elementTwo") ) && ( (elements[1] == "elementOne") || (elements[1] == "elementTwo") ) && (elements[0] != elements[1])) {
        newOption = getTestSuccessOption("domManipulationTestEight --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("domManipulationTestEight --- Failure");
        insertOptionElement(newOption);
    }

} // end function domManipulationTestEight

function domManipulationTestEleven() {
    /*****************************************************************************
    function: domManipulationTestEleven

    author: djoham@yahoo.com

    description:
        Tests the parser's capability to get a node's parent

    *****************************************************************************/
    var objDom = new XMLDoc("<?xml version=\"1.0\"?><ROOTNODE><TAG1>foo</TAG1></ROOTNODE>", xmlError);

    //first find the node for which we want to find the parent, in this case it is TAG1
    var domTree = objDom.docNode;
    var referenceNode = domTree.getElements("TAG1")[0];


    var elementParent = referenceNode.getParent();

    //now check the parent's tag name, it should be ROOTNODE
    if ( elementParent.tagName == "ROOTNODE") {
        newOption = getTestSuccessOption("domManipulationTestEleven --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("domManipulationTestEleven --- Failure");
        insertOptionElement(newOption);
    }

} // end function domManipulationTestEleven


function domManipulationTestFive() {
    /*****************************************************************************
    function: domManipulationTestFive

    author: djoham@yahoo.com

    description:
        Tests the parser's capability to add attributes to a node

    *****************************************************************************/
    var objDom = new XMLDoc("<?xml version=\"1.0\"?><ROOTNODE><TAG1>foo</TAG1></ROOTNODE>", xmlError);

    //first find the node for which we want to add the attribute, in this case it is TAG1
    var domTree = objDom.docNode;
    var referenceNode = domTree.getElements("TAG1")[0];

    //now add the attribute
    referenceNode.addAttribute("attribute", "attributeValue");

    //now check the XML. I check the DOM tree, which will also be updated with the new attribute.
    if (objDom.getUnderlyingXMLText() == "<?xml version=\"1.0\"?><ROOTNODE><TAG1 attribute=\"attributeValue\">foo</TAG1></ROOTNODE>") {
        newOption = getTestSuccessOption("domManipulationTestFive --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("domManipulationTestFive --- Failure");
        insertOptionElement(newOption);
    }

} // end function domManipulationTestFive


function domManipulationTestFour() {
    /*****************************************************************************
    function: domManipulationTestFour

    author: djoham@yahoo.com

    description:
        Tests the parser's capability to replace the contents of a node

    *****************************************************************************/
    var objDom = new XMLDoc("<?xml version=\"1.0\"?><ROOTNODE><TAG1 attribute=\"keepme\">foo</TAG1></ROOTNODE>", xmlError);

    //first find the node for which we want to replace the contents, in this case it is TAG1
    var domTree = objDom.docNode;
    var referenceNode = domTree.getElements("TAG1")[0];


    //now do the replace
    //******** REMEMBER that the return value is a new DOM object!!! ********
    objDom = objDom.replaceNodeContents(referenceNode, "This is the new value");
    //now check the XML. ***NOTE the attribute in the TAG1 tag should be retained
    if (objDom.getUnderlyingXMLText() == "<?xml version=\"1.0\"?><ROOTNODE><TAG1 attribute=\"keepme\">This is the new value</TAG1></ROOTNODE>") {
        newOption = getTestSuccessOption("domManipulationTestFour --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("domManipulationTestFour --- Failure");
        insertOptionElement(newOption);
    }

} // end function domManipulationTestFour

function domManipulationTestNine() {
    /*****************************************************************************
    function: domManipulationTestNine

    author: djoham@yahoo.com

    description:
        Tests the parser's capability get the value of an attribute
        from the node

    *****************************************************************************/
    var objDom = new XMLDoc("<?xml version=\"1.0\"?><ROOTNODE><TAG1 elementOne=\"elementValueOne\" elementTwo=\"elementValueTwo\">foo</TAG1></ROOTNODE>", xmlError);

    //first find the node for which we want to read the attribute's value, in this case it is TAG1
    var domTree = objDom.docNode;
    var referenceNode = domTree.getElements("TAG1")[0];


    //now check the values in the array. I should have two, elementOne and elementTwo
    if ( referenceNode.getAttribute("elementOne") == "elementValueOne") {
        newOption = getTestSuccessOption("domManipulationTestNine --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("domManipulationTestNine --- Failure");
        insertOptionElement(newOption);
    }

} // end function domManipulationTestNine


function domManipulationTestOne() {
    /*****************************************************************************
    function: domManipulationTestOne

    author: djoham@yahoo.com

    description:
        Tests the parser's capability to add elements to the DOM tree
        after the tag specified
    *****************************************************************************/
    var objDom = new XMLDoc("<?xml version=\"1.0\"?><ROOTNODE><TAG1></TAG1></ROOTNODE>", xmlError);
    //first find the node that we want to insert after, in this case it is TAG1
    var domTree = objDom.docNode;
    var referenceNode = domTree.getElements("TAG1")[0];

    //create the new node
    var newNode = objDom.createXMLNode("<TAG2>test</TAG2>");

    //now add it to the tree
    //******** REMEMBER that the return value is a new DOM object!!! ********
    objDom = objDom.insertNodeAfter(referenceNode, newNode);

    //now check the XML.
    if (objDom.getUnderlyingXMLText() == "<?xml version=\"1.0\"?><ROOTNODE><TAG1></TAG1><TAG2>test</TAG2></ROOTNODE>") {
        newOption = getTestSuccessOption("domManipulationTestOne --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("domManipulationTestOne --- Failure");
        insertOptionElement(newOption);
    }

} // end function domManipulationTestOne

function domManipulationTestSeven() {
    /*****************************************************************************
    function: domManipulationTestSeven

    author: djoham@yahoo.com

    description:
        Tests the parser's capability to remove an attribute from a node

    *****************************************************************************/
    var objDom = new XMLDoc("<?xml version=\"1.0\"?><ROOTNODE><TAG1 attribute=\"here\">foo</TAG1></ROOTNODE>", xmlError);

    //first find the node for which we want to remove the attribute, in this case it is TAG1
    var domTree = objDom.docNode;
    var referenceNode = domTree.getElements("TAG1")[0];


    //now add the attribute
    referenceNode.removeAttribute("attribute");

    //now check the XML. I check the DOM tree, which will also be updated with the new attribute.
    if (objDom.getUnderlyingXMLText() == "<?xml version=\"1.0\"?><ROOTNODE><TAG1>foo</TAG1></ROOTNODE>") {
        newOption = getTestSuccessOption("domManipulationTestSeven --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("domManipulationTestSeven --- Failure");
        insertOptionElement(newOption);
    }

} // end function domManipulationTestSeven


function domManipulationTestSix() {
    /*****************************************************************************
    function: domManipulationTestSix

    author: djoham@yahoo.com

    description:
        Tests the parser's capability to change the value of an attribute
        in a node

    *****************************************************************************/
    var objDom = new XMLDoc("<?xml version=\"1.0\"?><ROOTNODE><TAG1 attributeValue=\"old\">foo</TAG1></ROOTNODE>", xmlError);

    //first find the node for which we want to change the attribute value, in this case it is TAG1
    var domTree = objDom.docNode;
    var referenceNode = domTree.getElements("TAG1")[0];


    //now add the attribute
    referenceNode.addAttribute("attributeValue", "new");

    //now check the XML. I check the DOM tree, which will also be updated with the new attribute.
    if (objDom.getUnderlyingXMLText() == "<?xml version=\"1.0\"?><ROOTNODE><TAG1 attributeValue=\"new\">foo</TAG1></ROOTNODE>") {
        newOption = getTestSuccessOption("domManipulationTestSix --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("domManipulationTestSix --- Failure");
        insertOptionElement(newOption);
    }

} // end function domManipulationTestSix


function domManipulationTestTen() {
    /*****************************************************************************
    function: domManipulationTestTen

    author: djoham@yahoo.com

    description:
        Tests the parser's capability to get a node's tag name

    *****************************************************************************/
    var objDom = new XMLDoc("<?xml version=\"1.0\"?><ROOTNODE><TAG1>foo</TAG1></ROOTNODE>", xmlError);

    //first find the node for which we want to find the tag name, in this case it is TAG1
    var domTree = objDom.docNode;
    var referenceNode = domTree.getElements("TAG1")[0];


    //now check the tag name
    if ( referenceNode.tagName == "TAG1") {
        newOption = getTestSuccessOption("domManipulationTestTen --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("domManipulationTestTen --- Failure");
        insertOptionElement(newOption);
    }

} // end function domManipulationTestTen


function domManipulationTestThree() {
    /*****************************************************************************
    function: domManipulationTestThree

    author: djoham@yahoo.com

    description:
        Tests the parser's capability to remove elements from the tree
    *****************************************************************************/
    var objDom = new XMLDoc("<?xml version=\"1.0\"?><ROOTNODE><TAG1><TAG2>hello</TAG2></TAG1></ROOTNODE>", xmlError);
    //first find the node that we want to delete in this case it is TAG2
    var domTree = objDom.docNode;
    var referenceNode = domTree.getElements("TAG1")[0].getElements("TAG2")[0];

    //now remove the node
    //******** REMEMBER that the return value is a new DOM object!!! ********
    objDom = objDom.removeNodeFromTree(referenceNode);

    //now check the XML.
    if (objDom.getUnderlyingXMLText() == "<?xml version=\"1.0\"?><ROOTNODE><TAG1></TAG1></ROOTNODE>") {
        newOption = getTestSuccessOption("domManipulationTestThree --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("domManipulationTestThree --- Failure");
        insertOptionElement(newOption);
    }

} // end function domManipulationTestThree



function domManipulationTestTwo() {
    /*****************************************************************************
    function: domManipulationTestTwo

    author: djoham@yahoo.com

    description:
        Tests the parser's capability to add elements to the DOM tree
        into the tag specified
    *****************************************************************************/
    var objDom = new XMLDoc("<?xml version=\"1.0\"?><ROOTNODE><TAG1 attribute=\"keepme\"><TAG3>keepmetoo</TAG3></TAG1></ROOTNODE>", xmlError);
    //first find the node that we want to insert into, in this case it is TAG1
    var domTree = objDom.docNode;
    var referenceNode = domTree.getElements("TAG1")[0];

    //create the new node
    var newNode = objDom.createXMLNode("<TAG2>test</TAG2>");

    //now add it to the tree
    //******** REMEMBER that the return value is a new DOM object!!! ********
    objDom = objDom.insertNodeInto(referenceNode, newNode);

    //now check the XML.
    if (objDom.getUnderlyingXMLText() == "<?xml version=\"1.0\"?><ROOTNODE><TAG1 attribute=\"keepme\"><TAG2>test</TAG2><TAG3>keepmetoo</TAG3></TAG1></ROOTNODE>") {
        newOption = getTestSuccessOption("domManipulationTestTwo --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("domManipulationTestTwo --- Failure");
        insertOptionElement(newOption);
    }

} // end function domManipulationTestTwo


function errorReportingTestOne() {
    /*****************************************************************************
    function: errorReportingTestOne

    author: djoham@yahoo.com

    description:
        Tests the parser's capability to call the error function if
        something goes wrong

    *****************************************************************************/
    // the following line will cause the XMLDoc object to generate an error to the xmlError function
    var objDom = new XMLDoc("<?xml version=\"1.0\"?><OPENTAG1><NOCLOSETAG></OPENTAG1>", xmlError);

    if (testErrorCalling == "ERROR: expected closing NOCLOSETAG, found closing OPENTAG1") {
        newOption = getTestSuccessOption("errorReportingTestOne --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("errorReportingTestOne --- Failure");
        insertOptionElement(newOption);
    }


} // end function errorReportingTestOne



function errorReportingTestThree() {
    /*****************************************************************************
    function: errorReportingTestThree

    author: djoham@yahoo.com

    description:
        Tests the parser's capability to call the error function if
        there is an empty tag

    *****************************************************************************/
    // the following line will cause the XMLDoc object to generate an error to the xmlError function
    testErrorCalling = "";
    var objDom = new XMLDoc("<?xml version=\"1.0\"?><ROOTNODE><></ROOTNODE>", xmlError);
    if (testErrorCalling == "ERROR: empty tag") {
        newOption = getTestSuccessOption("errorReportingTestThree --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("errorReportingTestThree --- Failure");
        insertOptionElement(newOption);
    }


} // end function errorReportingTestThree


function errorReportingTestTwo() {
    /*****************************************************************************
    function: errorReportingTestTwo

    author: djoham@yahoo.com

    description:
        Tests the parser's capability to call the error function if
        no parameter is passed to removeAttribute

    *****************************************************************************/

    var objDom = new XMLDoc("<?xml version=\"1.0\"?><ROOTNODE><TAG1 attribute=\"keepme\"></TAG1></ROOTNODE>", xmlError);
    //first find the node that we want to insert into, in this case it is TAG1
    var domTree = objDom.docNode;
    var referenceNode = domTree.getElements("TAG1")[0];

    //now try to remove the node without passing the parameter
    testErrorCalling = "";
    referenceNode.removeAttribute();

    if (testErrorCalling == "ERROR: You must pass an attribute name into the removeAttribute function") {
        newOption = getTestSuccessOption("errorReportingTestTwo --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("errorReportingTestTwo --- Failure");
        insertOptionElement(newOption);
    }

} // end function errorReportingTestTwo


function escapeCharactersTestEight() {
    /*****************************************************************************
    function: escapeCharactersTestEight

    author: djoham@yahoo.com

    description:
        test the unescaping out of &amp; to & by the function convertEscapes
    *****************************************************************************/
    var strOrig = "&amp;hello&amp;";
    var strNew = convertEscapes(strOrig);
    var newOption;
    if (strNew == "&hello&") {
        newOption = getTestSuccessOption ("escapeCharactersTestEight --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("escapeCharactersTestEight --- Failure");
        insertOptionElement(newOption);
    }

} // end function escapeCharactersTestEight



function escapeCharactersTestFive() {
    /*****************************************************************************
    function: escapeCharactersTestFive

    author: djoham@yahoo.com

    description:
        tests that the parser can escape out all three illegal characters in a string

    *****************************************************************************/
    var strOrig = "<h<e&l&l>o>";
    var strNew = convertToEscapes(strOrig);
    var newOption;
    if (strNew == "&lt;h&lt;e&amp;l&amp;l&gt;o&gt;") {
        newOption = getTestSuccessOption ("escapeCharactersTestFive --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("escapeCharactersTestFive --- Failure");
        insertOptionElement(newOption);
    }

} // end function escapeCharactersTestFive


function escapeCharactersTestFour() {
    /*****************************************************************************
    function: escapeCharactersTestFour

    author: djoham@yahoo.com

    description:
        Tests that the parser correctly passes back the
        "true" value of the text in a node, rather than the
        escaped values

    *****************************************************************************/
    var objDom = new XMLDoc(testXML, xmlError)
    var domTree = objDom.docNode; // this gives you a reference to the ROOTNODE Node
    var domElement = domTree.getElements("TAG2")[0];
    var newOption;

    if (trim(domElement.getText(), true, true) == "1 is <&> 2") {
        newOption = getTestSuccessOption("escapeCharactersTestFour --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("escapeCharactersTestFour --- Failure");
        insertOptionElement(newOption);
    }

} // end function escapeCharactersTestFour


function escapeCharactersTestOne() {
    /*****************************************************************************
    function: escapeCharactersTestOne

    author: djoham@yahoo.com

    description:
        Tests the escaping out of less than signs
        by the function convertToEscapes

    *****************************************************************************/
    var strOrig = "<hello<";
    var strNew = convertToEscapes(strOrig);
    var newOption;
    if (strNew == "&lt;hello&lt;") {
        newOption = getTestSuccessOption ("escapeCharactersTestOne --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("escapeCharactersTestOne --- Failure");
        insertOptionElement(newOption);
    }

}   // end function escapeCharactersTestOne


function escapeCharactersTestSeven() {
    /*****************************************************************************
    function: escapeCharactersTestSeven

    author: djoham@yahoo.com

    description:
        test the unescaping out of &gt; to > by the function convertEscapes
    *****************************************************************************/
    var strOrig = "&gt;hello&gt;";
    var strNew = convertEscapes(strOrig);
    var newOption;
    if (strNew == ">hello>") {
        newOption = getTestSuccessOption ("escapeCharactersTestSeven --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("escapeCharactersTestSeven --- Failure");
        insertOptionElement(newOption);
    }

} // end function escapeCharactersTestSeven


function escapeCharactersTestSix() {
    /*****************************************************************************
    function: escapeCharactersTestSix

    author: djoham@yahoo.com

    description:
        test the unescaping out of &lt; to < by the function convertEscapes
    *****************************************************************************/
    var strOrig = "&lt;hello&lt;";
    var strNew = convertEscapes(strOrig);
    var newOption;
    if (strNew == "<hello<") {
        newOption = getTestSuccessOption ("escapeCharactersTestSix --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("escapeCharactersTestSix --- Failure");
        insertOptionElement(newOption);
    }

} // end function escapeCharactersTestSix



function escapeCharactersTestThree() {
    /*****************************************************************************
    function: escapeCharactersTestThree

    author: djoham@yahoo.com

    description:
        Tests the escaping out ampersand signs
        by the function convertToEscapes

    *****************************************************************************/
    var strOrig = "&hello&";
    var strNew = convertToEscapes(strOrig);
    var newOption;
    if (strNew == "&amp;hello&amp;") {
        newOption = getTestSuccessOption ("escapeCharactersTestThree --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("escapeCharactersTestThree --- Failure");
        insertOptionElement(newOption);
    }

}   // end function escapeCharactersTestThree



function escapeCharactersTestTwo() {
    /*****************************************************************************
    function: escapeCharactersTestTwo

    author: djoham@yahoo.com

    description:
        Tests the escaping out of greater than signs
        by the function convertToEscapes

    *****************************************************************************/
    var strOrig = ">hello>";
    var strNew = convertToEscapes(strOrig);
    var newOption;
    if (strNew == "&gt;hello&gt;") {
        newOption = getTestSuccessOption ("escapeCharactersTestTwo --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("escapeCharactersTestTwo --- Failure");
        insertOptionElement(newOption);
    }

}   // end function escapeCharactersTestTwo


function getElementByIdTestOne() {
    /*****************************************************************************
    function: getElementByIdTestOne

    author: djoham@yahoo.com

    description:
        Tests the capability of the parser to find a node based on it's ID
    *****************************************************************************/

    var objDom = new XMLDoc(testXML, xmlError)
    var domTree = objDom.docNode;
    var node = domTree.getElementById("4");
    if (node.tagName == "TAG6") {
        newOption = getTestSuccessOption ("getElementByIdTestOne --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("getElementByIdTestOne --- Failure");
        insertOptionElement(newOption);
    }

} // end function getElementByIdTestOne



function getTextTestOne() {
    /*****************************************************************************
    function: getTextTestOne

    author: djoham@yahoo.com

    description:
        The escapeCharacters tests also do a lot of
        getText stuff. These test cases cover the bases
        that have not been tested

        This test tests getText() from comment nodes
    *****************************************************************************/
    var objDom = new XMLDoc(testXML, xmlError)
    var domTree = objDom.docNode; // this gives you a reference to the ROOTNODE Node
    var domElement = domTree.getElements("TAG6")[0];
    var newOption;

    if (domElement.children[1].getText() == "This child is of nodeType COMMENT") {
        newOption = getTestSuccessOption("getTextTestOne --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("getTextTestOne --- Failure");
        insertOptionElement(newOption);
    }
} // end function getTextTestOne

function getTextTestTwo() {
    /*****************************************************************************
    function: getTextTestTwo

    author: djoham@yahoo.com

    description:
        tests the parser's ability to return values from CDATA nodes

    *****************************************************************************/
    var objDom = new XMLDoc(testXML, xmlError)
    var domTree = objDom.docNode; // this gives you a reference to the ROOTNODE Node
    var domElement = domTree.getElements("TAG6")[0];
    var newOption;

    //get the CDATA element
    domElement = domElement.children[2];
    if (domElement.getText() == "this child is of <<<>nodeType CDATA") {
        newOption = getTestSuccessOption("getTextTestTwo --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("getTextTestTwo --- Failure");
        insertOptionElement(newOption);
    }
} // end function getTextTestTwo


function nodeTypeTestFour() {
    /*****************************************************************************
    function: nodeTypeTestFour

    author: djoham@yahoo.com

    description:
        tests the parser's ability to identify CDATA nodes

    *****************************************************************************/
    var objDom = new XMLDoc(testXML, xmlError)
    var domTree = objDom.docNode; // this gives you a reference to the ROOTNODE Node
    var domElement = domTree.getElements("TAG6")[0];
    var newOption;

    domElement = domElement.children[2];
    if (domElement.nodeType == "CDATA") {
        newOption = getTestSuccessOption("nodeTypeTestFour --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("nodeTypeTestFour --- Failure");
        insertOptionElement(newOption);
    }

} //end function nodeTypeTestFour



function nodeTypeTestOne() {
    /*****************************************************************************
    function: nodeTypeTestOne

    author: djoham@yahoo.com

    description:
        tests the parser's ability to identify ELEMENT nodes

    *****************************************************************************/
    var objDom = new XMLDoc(testXML, xmlError)
    var domTree = objDom.docNode; // this gives you a reference to the ROOTNODE Node
    var domElement = domTree.getElements("TAG6")[0];
    var newOption;

    if (domElement.nodeType == "ELEMENT") {
        newOption = getTestSuccessOption("nodeTypeTestOne --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("nodeTypeTestOne --- Failure");
        insertOptionElement(newOption);
    }

} //end function nodeTypeTestOne

function nodeTypeTestThree() {
    /*****************************************************************************
    function: nodeTypeTestThree

    author: djoham@yahoo.com

    description:
        tests the parser's ability to identify COMMENT nodes

    *****************************************************************************/
    var objDom = new XMLDoc(testXML, xmlError)
    var domTree = objDom.docNode; // this gives you a reference to the ROOTNODE Node
    var domElement = domTree.getElements("TAG6")[0];
    var newOption;

    //get the second child
    domElement = domElement.children[1]

    if (domElement.nodeType == "COMMENT") {
        newOption = getTestSuccessOption("nodeTypeTestThree --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("nodeTypeTestThree --- Failure");
        insertOptionElement(newOption);
    }

} //end function nodeTypeTestThree


function nodeTypeTestTwo() {
    /*****************************************************************************
    function: nodeTypeTestTwo

    author: djoham@yahoo.com

    description:
        tests the parser's ability to identify TEXT nodes

    *****************************************************************************/
    var objDom = new XMLDoc(testXML, xmlError)
    var domTree = objDom.docNode; // this gives you a reference to the ROOTNODE Node
    var domElement = domTree.getElements("TAG6")[0];
    var newOption;

    //get the first child
    domElement = domElement.children[0];

    if (domElement.nodeType == "TEXT") {
        newOption = getTestSuccessOption("nodeTypeTestTwo --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("nodeTypeTestTwo --- Failure");
        insertOptionElement(newOption);
    }

} //end function nodeTypeTestTwo


function runTests() {
    /*****************************************************************************
    function: runTests

    author: djoham@yahoo.com

    description: Begins the test run. An alert box informs the user
                    when the test has been completed

    *****************************************************************************/

    clearTestResults()
    
    createTestResultsHeader("Starting Test Run");

    createTestResultsHeader("Text Functions");
    textFunctionsTestOne(); //tests the trim function's capability to trim the leading spaces
    textFunctionsTestTwo(); //tests the trim function's capability to trim the trailing spaces
    textFunctionsTestThree(); //tests the trim function's capability to trim the leading spaces and the trailing spaces from a string
    textFunctionsTestFour(); //tests the trim function's capability to deal with strings that are all whitespace
    textFunctionsTestFive(); //tests the trim function's capability to default to true for the left and right trim bools when not passed in

    createTestResultsHeader("Escape Functions");
    escapeCharactersTestOne(); //Tests the escaping out of less than signs by the function convertToEscapes
    escapeCharactersTestTwo(); //Tests the escaping out of greater than signs by the function convertToEscapes
    escapeCharactersTestThree(); //Tests the escaping out ampersand signs by the function convertToEscapes
    escapeCharactersTestFour(); //Tests that the parser correctly passes back the "true" value of the text in a node, rather than the escaped values
    escapeCharactersTestFive(); //Tests the escaping out of all three illegal characters by the function convertToEscapes
    escapeCharactersTestSix(); //test the unescaping out of &lt; to < by the function convertEscapes
    escapeCharactersTestSeven(); //test the unescaping out of &gt; to > by the function convertEscapes
    escapeCharactersTestEight(); //test the unescaping out of &amp; to & by the function convertEscapes


    createTestResultsHeader("Underlying XML Functions");
    underlyingXMLFunctionsTestOne(); //tests the underlying XML functions of the document element
    underlyingXMLFunctionsTestTwo(); //tests the underlying XML functions of the node element

    createTestResultsHeader("Node Type Tests");
    nodeTypeTestOne(); //tests the parser's ability to identify ELEMENT nodes
    nodeTypeTestTwo(); //tests the parser's ability to identify TEXT nodes
    nodeTypeTestThree(); //tests the parser's ability to identify COMMENT nodes
    nodeTypeTestFour(); //tests the parser's ability to identify CDATA nodes

    createTestResultsHeader("Get Text Tests");
    getTextTestOne(); //The escapeCharacters tests also do a lot of getText stuff. These test cases cover the bases that have not been tested This test tests getText() from comment nodes
    getTextTestTwo(); //tests the parser's ability to return values from CDATA nodes

    createTestResultsHeader("Error Reporting");
    errorReportingTestOne(); //Tests the parser's capability to call the error function if something goes wrong
    errorReportingTestTwo(); //Tests the parser's capability to call the error function if no parameter is passed to removeAttribute
    errorReportingTestThree(); //Tests the parser's capability to call the error function if there is an empty tag


    createTestResultsHeader("DOM Manipulation");
    domManipulationTestOne(); //Tests the parser's capability to add elements to the DOM tree after the tag specified
    domManipulationTestTwo(); //Tests the parser's capability to add elements to the DOM tree into the tag specified
    domManipulationTestThree(); //Tests the parser's capability to remove elements from the tree
    domManipulationTestFour(); //Tests the parser's capability to replace the contents of a node
    domManipulationTestFive(); //Tests the parser's capability to add attributes to a node
    domManipulationTestSix(); //Tests the parser's capability to change the value of an attribute in a node
    domManipulationTestSeven(); //Tests the parser's capability to remove an attribute from a node
    domManipulationTestEight(); // Tests the parser's capability to get a list of the attributes from the node
    domManipulationTestNine(); //Tests the parser's capability get the value of an attribute from the node
    domManipulationTestTen(); //Tests the parser's capability to get a node's tag name
    domManipulationTestEleven(); //Tests the parser's capability to get a node's parent

    createTestResultsHeader("Get Element By ID Test");
    getElementByIdTestOne(); //Tests the capability of the parser to find a node based on it's ID


    createTestResultsHeader("Test Concluded");

} //end function runTests


function textFunctionsTestFive() {
    /*****************************************************************************
    function: textFunctionsTestFive

    author: djoham@yahoo.com

    description:
        tests the trim function's capability to default to true
        for the left and right trim bools when not passed in
    *****************************************************************************/
    var origText = "   hello      ";
    var newText = trim(origText);
    var newOption;
    if (newText == "hello") {
        newOption = getTestSuccessOption("textFunctionsTestFive --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("textFunctionsTestFive --- Fauilure");
        insertOptionElement(newOption);
    }


} //end function textFunctionsTestFive

function textFunctionsTestFour() {
    /*****************************************************************************
    function: textFunctionsTestOne

    author: djoham@yahoo.com

    description:
        tests the trim function's capability to deal with strings
        that are all whitespace

    *****************************************************************************/
    var origText = "          ";
    var newText = trim(origText, true, true);
    var newOption;
    if (newText == "") {
        newOption = getTestSuccessOption("textFunctionsTestFour --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("textFunctionsTestFour --- Failure");
        insertOptionElement(newOption);
    }


} //end function textFunctionsTestFour

function textFunctionsTestOne() {
    /*****************************************************************************
    function: textFunctionsTestOne

    author: djoham@yahoo.com

    description:
        tests the trim function's capability to trim the leading spaces

    *****************************************************************************/
    var origText = "     hello     ";
    var newText = trim(origText, true, false);
    var newOption;
    if (newText == "hello     ") {
        newOption = getTestSuccessOption("textFunctionsTestOne --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("textFunctionsTestOne --- Fauilure");
        insertOptionElement(newOption);
    }


} //end function textFunctionsTestOne

function textFunctionsTestThree() {
    /*****************************************************************************
    function: textFunctionsTestThree

    author: djoham@yahoo.com

    description:
        tests the trim function's capability to trim the leading spaces
        and the trailing spaces from a string

    *****************************************************************************/
    var origText = "     hello     ";
    var newText = trim(origText, true, true);
    var newOption;
    if (newText == "hello") {
        newOption = getTestSuccessOption("textFunctionsTestThree --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("textFunctionsTestThree --- Failure");
        insertOptionElement(newOption);
    }


} //end function textFunctionsTestThree

function textFunctionsTestTwo() {
    /*****************************************************************************
    function: textFunctionsTestTwo

    author: djoham@yahoo.com

    description:
        tests the trim function's capability to trim the trailing spaces

    *****************************************************************************/
    var origText = "     hello     ";
    var newText = trim(origText, false, true);
    var newOption;
    if (newText == "     hello") {
        newOption = getTestSuccessOption("textFunctionsTestTwo --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("textFunctionsTestTwo --- Failure");
        insertOptionElement(newOption);
    }


} //end function textFunctionsTestTwo


function underlyingXMLFunctionsTestOne() {
    /*****************************************************************************
    function: underlyingXMLFunctionsTestOne

    author: djoham@yahoo.com

    description:
        tests the underlying XML functions of the document element

    *****************************************************************************/

    var objDom = new XMLDoc("<?xml version=\"1.0\"?><FOO><BAR>hello</BAR></FOO>", xmlError);
    var text = objDom.getUnderlyingXMLText();
    var newOption;

    if (text == "<?xml version=\"1.0\"?><FOO><BAR>hello</BAR></FOO>") {
        newOption = getTestSuccessOption("underlyingXMLFunctionsTestOne --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("underlyindXMLFunctionsTestOne -- Failure");
        insertOptionElement(newOption);
    }

} //end function underlyingXMLFunctionsTestOne

function underlyingXMLFunctionsTestTwo() {
    /*****************************************************************************
    function: underlyingXMLFunctionsTestTwo

    author: djoham@yahoo.com

    description:
        tests the underlying XML functions of the node element

    *****************************************************************************/
    var objDom = new XMLDoc(testXML, xmlError)
    var domTree = objDom.docNode; // this gives you a reference to the ROOTNODE Node
    var domElement = domTree.getElements("TAG5")[0];
    var nodeText = domElement.getUnderlyingXMLText();
    var newOption;
    if (nodeText == "<TAG5>tag5content</TAG5>") {
        newOption = getTestSuccessOption("underlyingXMLFunctionsTestTwo --- Success");
        insertOptionElement(newOption);
    }
    else {
        newOption = getTestFailureOption("underlyingXMLFunctionsTestTwo --- Failure");
        insertOptionElement(newOption);
    }

} // end function underlyingXMLFunctionsTestTwo()

function xmlError(e) {
    /*****************************************************************************
    function: xmlError

    author: djoham@yahoo.com

    description:
        this will be the function that is called by the XML
        parser if an error is generated

    *****************************************************************************/
    testErrorCalling = e;

} // end function xmlError


