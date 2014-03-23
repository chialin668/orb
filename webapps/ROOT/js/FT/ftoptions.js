//************************************************************
//Folder Tree options. These option can be changed by the user.
// Full details may be found in the documention.
//************************************************************
//**********************
// General
//**********************
var styleSheetFile = "ftstyle.css"		// Default file for style sheet
var noFrame = false				// indicates whether menu is within frame
var cascade = false				// indicate whether cascading menus are used
var inTable = false				// Indicates whether menu is contained in table
var inForm = false				// Indicates whether menu is contained in form
var checkBox = false				// Indicates whether check box appears or not.
var menuFrame = "menufrm"			// Default frame for menu
var baseFrame = "basefrm"			// Default frame for base
var defTargetFrame = 0				// Default target frame
var defLinkType = 0				// Default link type
var commonLink = ""				// Default  common link string
var topGap = 8					// Gap at top of menu in pixels
var leftGap = 8					// Gap at left of menu in pixels
var useTextLinks = 0				// Use text as link or not
var collapseOnSelect = false			// Menu collapses when menu selected - only valid with noFrame
var modalClick = false				// Whether modal or not
var initialMode = 1				// Initial open mode
var treeLines = 1				// Use (+/-) signs or not
var mouseOverPMMode = 0				// Events for mouse over (+/-) signs
var mouseOverIconMode = 0			// Events for mouse over icons
var clickIconMode = 0				// Events for clicking folder icons
var menuHeader = ""				// Header HTML
var menuFooter = ""				// Footer HTML
var folderIconSpace = 8				// blank space after folder icons
var documentIconSpace = 8			// blank space after document icons
var noWrap = true				// Do not wrap menu items if true
var noDocs = false				// Do not show items if true
var noTopFolder = false				// Do not show top folder node if true
var ftFolder = ""				// Default folder for scripts, html files and java applet
var bodyOption = "bgcolor = 'white'"	        // Default options for within <BODY> tag
var menuBackColor = "lightgrey"		        // Background color for cascading frameless menus		
var menuBackColorOver = "darkblue"		// Background highlight color for cascading frameless menus		
var menuTextColor = "black"		        // Background color for cascading frameless menus		
var menuTextColorOver = "white"		        // Background highlight color for cascading frameless menus		
var menuBorderStyle = "outset"			// Border style for cascading frameless menus
var menuBorderColor = ""			// Border style for cascading frameless menus
var menuWidth = 150				// Menu width for cascading frameless menus
var menuHeight = 22				// Menu height for cascading frameless menus
var textWidth = 100				// Text width for cascading frameless menus
var horizontal = false				// Horizontal or vertical cascading frameless menus
var rightToLeft = false				// Right to left tree menus
//**********************
// Images
//**********************
var iconFolder = "" 				// Default folder/directory for the images. This is a relative URL path.
var topOpenFolderIcon = "/js/FT/ftfo.gif" 		// Icon file for open top folder
var topClosedFolderIcon = "/js/FT/ftfc.gif" 		// Icon file for closed top folder
var openFolderIcon = "/js/FT/ftfo.gif" 		// Icon file for other open folders
var closedFolderIcon = "/js/FT/ftfc.gif" 		// Icon file for other closed folders
var documentIcon = "/js/FT/ftd.gif" 			// Icon file for documents
var topOpenFolderIconOver = "/js/FT/ftfc.gif" 		// Icon file for open top folder, mouse over	
var topClosedFolderIconOver = "/js/FT/ftfo.gif" 	// Icon file for closed top folder, mouse over
var openFolderIconOver = "/js/FT/ftfc.gif" 		// Icon file for other open folders, mouse over
var closedFolderIconOver = "/js/FT/ftfo.gif" 		// Icon file for other closed folders, mouse over
var documentIconOver = "/js/FT/ftdo.gif" 		// Icon file for documents, mouse over
var backImage = ""				// Background image for cascading menus
var backImageOver = ""				// Background image for cascading menus, mouse over
var hSpacerIcon = "/js/FT/ftspacer.gif"		//icon file for spacer for top horizontal menus
var arrIcon = "/js/FT/ftarrow.gif"			//icon file for arrow for cascading menus
//**********************
// Fonts
//**********************
var defFolderFont = "<font>"			// Default folder font
var defDocFont = "" 				// Default document font
levelDefFont[0] = ""				// Default level 0 font
levelDefFont[1] = "" 				// Default level 1 font
levelDefFont[2] = "" 				// Default level 2 font



