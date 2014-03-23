/*******************************************************************************
FILE: RegExpValidate.js

DESCRIPTION: This file contains a library of validation functions
  using javascript regular expressions.  Library also contains functions that re-
  format fields for display or for storage.
  

  VALIDATION FUNCTIONS:
  
  validateEmail - checks format of email address
    validateUSPhone - checks format of US phone number
    validateNumeric - checks for valid numeric value
  validateInteger - checks for valid integer value
    validateNotEmpty - checks for blank form field
  validateUSZip - checks for valid US zip code
  validateUSDate - checks for valid date in US format
  validateValue - checks a string against supplied pattern
  
  FORMAT FUNCTIONS:
  
  rightTrim - removes trailing spaces from a string
  leftTrim - removes leading spaces from a string
  trimAll - removes leading and trailing spaces from a string
  removeCurrency - removes currency formatting characters (), $ 
  addCurrency - inserts currency formatting characters
  removeCommas - removes comma separators from a number
  addCommas - adds comma separators to a number
  removeCharacters - removes characters from a string that match passed pattern
  
  
AUTHOR: Karen Gayda

DATE: 03/24/2000
*******************************************************************************/
function validateVariant (variantType, variantLength, wildTypeAllele, allele, wildTypeAA, aa)
{
	errorString = ""


		
	if (trimAll (allele).length >0)
	{
		if (trimAll (allele).length != parseInt (variantLength))
			errorString = errorString + 'Mutant allele must be the length specified by associated variant length\n'
		if (!validateValue (allele.toUpperCase(),"^[ACTG]+$"))
			errorString = errorString + 'Mutant allele can only contain the characters A,C,T or G\n'
	}
	if (trimAll (wildTypeAllele).length >0)
	{
		if (!validateValue (wildTypeAllele.toUpperCase(),"^[ACTG]+$"))
			errorString = errorString + 'Wild Type allele can only contain the characters A,C,T or G\n'
	}
		
	if (variantType == "MUTATION")
	{
		if (parseInt (variantLength) != 1  && variantLength.toUpperCase () != "UNKNOWN")
			errorString = errorString + 'Variant Length must equal 1 or UNKNOWN when Variant Type is Mutation\n'
	}
	else
	{
		if ( trimAll (variantLength).toUpperCase() != "UNKNOWN" && (!validateInteger(variantLength) || parseInt(variantLength)<1))
			errorString = errorString + 'Variant Length must be an Integer greater than 0 OR be set to UNKNOWN\n'
	}

	if (variantType != "INSERTION" && variantType != "WILD TYPE" && trimAll(wildTypeAllele).length > 0 && trimAll(allele).length > 0)
	{
		if (wildTypeAllele.toUpperCase() == allele.toUpperCase())
			errorString = errorString + 'Mutant allele must be different from Wild Type allele\n'
	}
	if (variantType != "INSERTION" && variantType == "WILD TYPE" && trimAll(wildTypeAllele).length > 0 && trimAll(allele).length > 0)
	{
		if (wildTypeAllele.toUpperCase() != allele.toUpperCase())
			errorString = errorString + 'Mutant allele must be the same as the Wild Type allele\n'
	}
	if (trimAll (wildTypeAA).length > 0)
	{
		if (!validateValue (wildTypeAA.toUpperCase(),"^[ACDEFGHIKLMNPQRSTVWXY]+$"))
			errorString = errorString + 'Wild Type AA can only contain the characters[ACDEFGHIKLMNPQRSTVWXY]\n'
	}

	if (trimAll (aa).length > 0)
	{
		if (!validateValue (aa.toUpperCase(),"^[ACDEFGHIKLMNPQRSTVWXY]+$"))
			errorString = errorString + 'AA can only contain the characters [ACDEFGHIKLMNPQRSTVWXY]\n'
	}
	return errorString;
}


function validateEmail( strValue) {
/************************************************
DESCRIPTION: Validates that a string contains a 
  valid email pattern. 
  
 PARAMETERS:
   strValue - String to be tested for validity
   
RETURNS:
   True if valid, otherwise false.
   
REMARKS: Accounts for email with country appended
  does not validate that email contains valid URL
  type (.com, .gov, etc.) or valid country suffix.
*************************************************/
var objRegExp  = /(^[a-z]([a-z_\.]*)@([a-z_\.]*)([.][a-z]{3})$)|(^[a-z]([a-z_\.]*)@([a-z_\.]*)(\.[a-z]{3})(\.[a-z]{2})*$)/i;
 
  //check for valid email
  return objRegExp.test(strValue);
}

function validateUSPhone( strValue ) {
/************************************************
DESCRIPTION: Validates that a string contains valid
  US phone pattern. 
  Ex. (999) 999-9999 or (999)999-9999
  
PARAMETERS:
   strValue - String to be tested for validity
   
RETURNS:
   True if valid, otherwise false.
*************************************************/
  var objRegExp  = /^\([1-9]\d{2}\)\s?\d{3}\-\d{4}$/;
 
  //check for valid us phone with or without space between 
  //area code
  return objRegExp.test(strValue); 
}

function  validateNumeric( strValue ) {
/******************************************************************************
DESCRIPTION: Validates that a string contains only valid numbers.

PARAMETERS:
   strValue - String to be tested for validity
   
RETURNS:
   True if valid, otherwise false.
******************************************************************************/
  var objRegExp  =  /(^-?\d\d*\.\d*$)|(^-?\d\d*$)|(^-?\.\d\d*$)/; 
 
  //check for numeric characters 
  return objRegExp.test(strValue);
}

function validateInteger( strValue ) {
/************************************************
DESCRIPTION: Validates that a string contains only 
    valid integer number.
    
PARAMETERS:
   strValue - String to be tested for validity
   
RETURNS:
   True if valid, otherwise false.
******************************************************************************/
  var objRegExp  = /(^-?\d\d*$)/;
 
  //check for integer characters
  return objRegExp.test(strValue);
}

function validateNotEmpty( strValue ) {
/************************************************
DESCRIPTION: Validates that a string is not all
  blank (whitespace) characters.
    
PARAMETERS:
   strValue - String to be tested for validity
   
RETURNS:
   True if valid, otherwise false.
*************************************************/
   var strTemp = strValue;
   strTemp = trimAll(strTemp);
   if(strTemp.length > 0){
     return true;
   }  
   return false;
}

function validateUSZip( strValue ) {
/************************************************
DESCRIPTION: Validates that a string a United
  States zip code in 5 digit format or zip+4
  format. 99999 or 99999-9999
    
PARAMETERS:
   strValue - String to be tested for validity
   
RETURNS:
   True if valid, otherwise false.

*************************************************/
var objRegExp  = /(^\d{5}$)|(^\d{5}-\d{4}$)/;
 
  //check for valid US Zipcode
  return objRegExp.test(strValue);
}

function validateUSDate( strValue ) {
/************************************************
DESCRIPTION: Validates that a string contains only 
    valid dates with 2 digit month, 2 digit day, 
    4 digit year. Date separator can be ., -, or /.
    Uses combination of regular expressions and 
    string parsing to validate date.
    Ex. mm/dd/yyyy 
    
PARAMETERS:
   strValue - String to be tested for validity
   
RETURNS:
   True if valid, otherwise false.
   
REMARKS:
   Avoids some of the limitations of the Date.parse()
   method such as the date separator character.
*************************************************/
  var objRegExp = /^\d{1,2}(\/)\d{1,2}\1\d{4}$/
 
  //check to see if in correct format
  if(!objRegExp.test(strValue))
    return false; //doesn't match pattern, bad date
  else{
    var strSeparator = strValue.substring(2,3) //find date separator
    var arrayDate = strValue.split(strSeparator); //split date into month, day, year
    //create a lookup for months not equal to Feb.
    var arrayLookup = { '01' : 31,'03' : 31, '04' : 30,'05' : 31,'06' : 30,'07' : 31,
                        '08' : 31,'09' : 30,'10' : 31,'11' : 30,'12' : 31}
    var intDay = parseInt(arrayDate[1]); 

    //check if month value and day value agree
    if(arrayLookup[arrayDate[0]] != null) {
      if(intDay <= arrayLookup[arrayDate[0]] && intDay != 0)
        return true; //found in lookup table, good date
    }
    
    //check for February
    var intYear = parseInt(arrayDate[2]);
    var intMonth = parseInt(arrayDate[0]);

    if (intMonth > 12 || intMonth < 1)
	return false;

    if( ((intYear % 4 == 0 && intDay <= 29) || (intYear % 4 != 0 && intDay <=28)) && intDay !=0)
      return true; //Feb. had valid number of days
  }
  return false; //any other values, bad date
}

function compareUSDates( strValue1, strValue2 ) {
/************************************************
DESCRIPTION: Compares two dates and returns:

	0 if they are the same
	-1 if date1 < date2
	1 if date1 > date2

	-2 if one of the dates is formatted incorrectly

	Dates MUST be of the format MM/DD/YYYY and it
	is expected that date validation has already
	been performed previously by a validateUSDate() 
	function call
    
   
REMARKS:
   Avoids some of the limitations of the Date.parse()
   method such as the date separator character.
*************************************************/

   if (!validateUSDate (strValue1))
	return -2;

   if (!validateUSDate (strValue2))
	return -2;

   if (strValue1 == strValue2)
	return 0;

   var arrayDate1 = strValue1.split("/"); //split date into month, day, year
   var arrayDate2 = strValue2.split("/"); //split date into month, day, year
  
   var intMonth1 = parseInt(arrayDate1[0]);
   var intDay1 = parseInt(arrayDate1[1]); 
   var intYear1 = parseInt(arrayDate1[2]);

   var intMonth2 = parseInt(arrayDate2[0]);
   var intDay2 = parseInt(arrayDate2[1]); 
   var intYear2 = parseInt(arrayDate2[2]);

   if (intYear1 < intYear2)
	return -1;

   if (intYear1 > intYear2)
	return 1;

   if (intMonth1 < intMonth2)
	return -1;

   if (intMonth1 > intMonth2)
	return 1;


   if (intDay1 < intDay2)
	return -1;

   return 1;

}


function validateValue( strValue, strMatchPattern ) {
/************************************************
DESCRIPTION: Validates that a string a matches
  a valid regular expression value.
    
PARAMETERS:
   strValue - String to be tested for validity
   strMatchPattern - String containing a valid
      regular expression match pattern.
      
RETURNS:
   True if valid, otherwise false.
*************************************************/
var objRegExp = new RegExp( strMatchPattern);
 
 //check if string matches pattern
 return objRegExp.test(strValue);
}


function rightTrim( strValue ) {
/************************************************
DESCRIPTION: Trims trailing whitespace chars.
    
PARAMETERS:
   strValue - String to be trimmed.  
      
RETURNS:
   Source string with right whitespaces removed.
*************************************************/
var objRegExp = /^([\w\W]*)(\b\s*)$/;
 
      if(objRegExp.test(strValue)) {
       //remove trailing a whitespace characters
       strValue = strValue.replace(objRegExp, '$1');
    }
  return strValue;
}

function leftTrim( strValue ) {
/************************************************
DESCRIPTION: Trims leading whitespace chars.
    
PARAMETERS:
   strValue - String to be trimmed
   
RETURNS:
   Source string with left whitespaces removed.
*************************************************/
var objRegExp = /^(\s*)(\b[\w\W]*)$/;
 
      if(objRegExp.test(strValue)) {
       //remove leading a whitespace characters
       strValue = strValue.replace(objRegExp, '$2');
    }
  return strValue;
}

function trimAll( strValue ) {
/************************************************
DESCRIPTION: Removes leading and trailing spaces.

PARAMETERS: Source string from which spaces will
  be removed;

RETURNS: Source string with whitespaces removed.
*************************************************/ 
 var objRegExp = /^(\s*)$/;

    //check for all spaces
    if(objRegExp.test(strValue)) {
       strValue = strValue.replace(objRegExp, '');
       if( strValue.length == 0)
          return strValue;
    }
    
   //check for leading & trailing spaces
   objRegExp = /^(\s*)([\W\w]*)(\b\s*$)/;
   if(objRegExp.test(strValue)) {
       //remove leading and trailing whitespace characters
       strValue = strValue.replace(objRegExp, '$2');
    }
  return strValue;
}

function removeCurrency( strValue ) {
/************************************************
DESCRIPTION: Removes currency formatting from 
  source string.
  
PARAMETERS: 
  strValue - Source string from which currency formatting
     will be removed;

RETURNS: Source string with commas removed.
*************************************************/
  var objRegExp = /\(/;
  var strMinus = '';
 
  //check if negative
  if(objRegExp.test(strValue)){
    strMinus = '-';
  }
  
  objRegExp = /\)|\(|[,]/g;
  strValue = strValue.replace(objRegExp,'');
  if(strValue.indexOf('$') >= 0){
    strValue = strValue.substring(1, strValue.length);
  }
  return strMinus + strValue;
}

function addCurrency( strValue ) {
/************************************************
DESCRIPTION: Formats a number as currency.

PARAMETERS: 
  strValue - Source string to be formatted

REMARKS: Assumes number passed is a valid 
  numeric value in the rounded to 2 decimal 
  places.  If not, returns original value.
*************************************************/
  var objRegExp = /-?[0-9]+\.[0-9]{2}$/;
   
    if( objRegExp.test(strValue)) {
      objRegExp.compile('^-');
      strValue = addCommas(strValue);
      if (objRegExp.test(strValue)){
        strValue = '(' + strValue.replace(objRegExp,'') + ')';
      }
      return '$' + strValue;
    }
    else
      return strValue;
}

function removeCommas( strValue ) {
/************************************************
DESCRIPTION: Removes commas from source string.

PARAMETERS: 
  strValue - Source string from which commas will 
    be removed;

RETURNS: Source string with commas removed.
*************************************************/
  var objRegExp = /,/g; //search for commas globally
 
  //replace all matches with empty strings
  return strValue.replace(objRegExp,'');
}

function addCommas( strValue ) {
/************************************************
DESCRIPTION: Inserts commas into numeric string.

PARAMETERS: 
  strValue - source string containing commas.
  
RETURNS: String modified with comma grouping if
  source was all numeric, otherwise source is 
  returned.
  
REMARKS: Used with integers or numbers with
  2 or less decimal places.
*************************************************/
  var objRegExp  = new RegExp('(-?[0-9]+)([0-9]{3})'); 

    //check for match to search criteria
    while(objRegExp.test(strValue)) {
       //replace original string with first group match, 
       //a comma, then second group match
       strValue = strValue.replace(objRegExp, '$1,$2');
    }
  return strValue;
}

function removeCharacters( strValue, strMatchPattern ) {
/************************************************
DESCRIPTION: Removes characters from a source string
  based upon matches of the supplied pattern.

PARAMETERS: 
  strValue - source string containing number.
  
RETURNS: String modified with characters
  matching search pattern removed
  
USAGE:  strNoSpaces = removeCharacters( ' sfdf  dfd', 
                                '\s*')
*************************************************/
 var objRegExp =  new RegExp( strMatchPattern, 'gi' );
 
 //replace passed pattern matches with blanks
  return strValue.replace(objRegExp,'');
}