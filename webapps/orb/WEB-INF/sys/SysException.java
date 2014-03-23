package com.orb.sys;

/**
*   08-10-1998  chialin chou    initial revision
*/


/**
*   if there is an error, sql generator should throw this exception
***********************************************************************/
public class SysException extends java.lang.Exception {

   /**
    * construct the exception message
    * @message the error message
    **/
    public SysException(String message) {
        super(message);

    }

}