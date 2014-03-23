////////////////////////////////////
// Mode definition
////////////////////////////////////
var MOD_SELECT 			= "select";
var MOD_TABLE 			= "table";
var MOD_RELATIONSHIP 	= "relationship";
var MOD_ONE2ONE			= "MOD_ONE2ONE";
var MOD_ONE2MANY		= "MOD_ONE2MANY";
var MOD_MANY2MANY		= "MOD_MANY2MANY";


var NEW_TABLE 			= "New_Table";


////////////////////////////////////
//	some symbles
////////////////////////////////////
var PRIMARY_EKY_MARK	= "p";
var FOREIGN_EKY_MARK	= "f";
var EMPTY_STRING		= "-";
var NULLABLE_MARK		= "y";
var CHECK_MARK			= "x";


////////////////////////////////////
// for db objects
////////////////////////////////////
var CL_DB_TABLE 		= "CL_DB_TABLE";
var CL_DB_RELATION		= "CL_DB_RELATION";
var CL_DB_INDEX			= "CL_DB_INDEX";
var CL_DB_VALIDATE		= "CL_DB_VALIDATE";
var CL_DB_DEFAULT		= "CL_DB_DEFAULT";

var CL_HTML_TABLE		= "CL_HTML_TABLE";


////////////////////////////////////
// for columns
////////////////////////////////////
var CL_PRIMARY_KEY		= "CL_PRIMARY_KEY";
var CL_COLUMN_NAME		= "CL_COLUMN_NAME";
var CL_DATA_TYPE		= "CL_DATA_TYPE";
var CL_DATA_LENGTH		= "CL_DATA_LENGTH";
var CL_NULLABLE			= "CL_NULLABLE";
var CL_VALIDATE			= "CL_VALIDATE";
var CL_DEFAULT			= "CL_DEFAULT";


var CL_CHECK_MARK		= "CL_CHECK_MARK";
var CL_UNIQUE_MARK		= "CL_UNIQUE_MARK";

var CL_CHECKBOX			= "checkBox";
var CL_TEXT_INPUT		= "CL_TEXT_INPUT";
var CL_SELECT 			= "CL_SELECT";
var CL_TEXT_INPUT	 	= "CL_TEXT_INPUT";
var CL_TB_COMMAND		= "CL_COMMAND_TEXT";			// table command buttons
var CL_TB_COMMAND_TEXT	= "CL_COMMAND_TEXT";
var CL_IN_COMMAND		= "CL_COMMAND_TEXT";


var CL_CO_COMMAND		= "co_Command";			// column command buttons
var CL_CO_COMMAND_TEXT	= "CL_COMMAND_TEXT";


var CL_MODE_CONTROL 	= "modeCtl";


////////////////////////////////////
// Tags
////////////////////////////////////
var TAG_EDIT			= "<Edit>";
var TAG_NEW 			= "<New>";
var TG_HTML_TB			= "HTML_TABLE_"; 
var TG_TB_TR			= "TB_TR_";
var TG_NEW_INDEX		= "<New Index>";

// for objects id and name
var TAG_DEFAULT 		= "Default";
var TAG_VALIDATE		= "Validate";



var RANDOM_STR			= "+";

////////////////////////////////////
// Colors
////////////////////////////////////
var COLOR_READ_ONLY		= "#EEEEEE";
var COLOR_READ_WRITE 	= "#FFFFFF";
var COLOR_OBJ_DEFAULT	= "#442222"; 
var COLOR_OBJ_CHOSEN	= "activecaption"; 
var COLOR_COL_DEFAULT	= "#EEEEEE";
var COLOR_COL_CHOSEN	= "#DDCCEE";

var COLOR_TABLE_DIV		= "captiontext";
var COLOR_INDEX_DIV		= "#33EE99";
var COLOR_DEFAULT_DIV	= "#EEBB66";
var COLOR_VALIDATE_DIV	= "gray";

////////////////////////////////////
// global variable
////////////////////////////////////
var sysModeField 		= "select";  //default mode

////////////////////////////////////
// for select
////////////////////////////////////
var chosenTableName			= null;
var chosenColumn		= null;
var choosenIndex		= null;


////////////////////////////////////
// for relatioship
////////////////////////////////////
var srcTableName 		= null;
var destTableName 		= null;


////////////////////////////////////
//	regular expression patterns
////////////////////////////////////
var PATTERN_VALID_NAME 		= /^[a-zA-Z_]{1,}[0-9]{0,}$/;		// first char should be non-numbers
var PATTERN_EMPTY_STRING	= /^[-]{0,1}$/;
var PATTERN_NUMBER_ONLY 	= /^\d+$/;
var PATTERN_DATA_LENGTH		= /^[0-9]{1,4}[,]{0,}[0-9]{0,}$/;


