// =========================================================================
//
// xmlIO.js - api for the xmlIO functions
//
// =========================================================================
//
// Copyright (C) 2002 - David Joham (djoham@yahoo.com)
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

//NOTE: This code was inspired by the book JavaScript Unleashed by R. Allen Wyke, Richard Wagner


function xmlIODeleteData(dataName) {
    /********************************************************************************
    Function: xmlIODeleteData

    Author: djoham@yahoo.com

    Description:
        Deletes the data from the cookie stream
    ********************************************************************************/
    //in order to ensure that the xmlIOGetData doesn't confuse this name with another,
    //the save routine wraped the name with high ascii characters. We must do the same
    dataName = String.fromCharCode(171) + dataName + String.fromCharCode(187);

    //expire by setting to date in past
    var expDate = new Date("January 01, 1980").toGMTString();
    document.cookie = dataName + "=;expires=" + expDate;


} // end function xmlIODeleteData

function xmlIOGetData(dataName){
    /********************************************************************************
    Function: xmlIOGetData

    Author: djoham@yahoo.com

    Description:
        retrieves the data from the cookie (if the data is there)
    ********************************************************************************/

    //in order to ensure that the xmlIOGetData doesn't confuse this name with another,
    //the save routine wraped the name with high ascii characters. We must do the same
    dataName = String.fromCharCode(171) + dataName + String.fromCharCode(187);

    var myCookie = " " + document.cookie + ";";
    var cookieName = " " + dataName;
    var cookieStart = myCookie.indexOf(cookieName);
    var cookieEnd;
    if (cookieStart != -1){
        cookieStart += cookieName.length;
        cookieEnd = myCookie.indexOf(";", cookieStart);
    }

    var retVal = unescape(myCookie.substring((cookieStart+1), cookieEnd));
    return retVal;

}  // end function xmlIOGetData


function xmlIOSaveData(dataName, dataValue, expireDate){
    /********************************************************************************
    Function: xmlIOSaveData

    Author: djoham@yahoo.com

    Description:
        Saves the data to the cookie.

    expireDate is optional. If passed in, it must be a valid JavaScript
    Date object. If not passed in, the cookie will expire on Jan 1st
    10 years from when the function was called.
    ********************************************************************************/

    //first delete any dataName that exists that might also have this same name. Otherwise, the operation will fail
    //xmlIODeleteData(dataName);

    var expireDateGMT; // cookies need GMT values for their expiration date

    //check if expireDate has been passed in
    if (expireDate == null) {
        var x = new Date();  //today
        var z = x.getFullYear() + 10;  //plus 10 years
        var y = new Date("January 01, " + z);  // on Jan1
        expireDateGMT = y.toGMTString();
    }
    else {
        expireDateGMT = expireDate.toGMTString();
    }

    //in order to ensure that the xmlIOGetData doesn't confuse this name with another, wrap the name with high ascii characters
    dataName = String.fromCharCode(171) + dataName + String.fromCharCode(187);

    //set the cookie
    document.cookie = dataName + "=" + escape(dataValue) + " ;expires=" + expireDateGMT;

}  // end function xmlIOSaveData


