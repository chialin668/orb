var isNS = 0;
var isIE = 0;

var browserType = ((navigator.appName) + (parseInt(navigator.appVersion)));

if (browserType == "Netscape4") 
	{isNS = 1;}
else if (browserType == "Netscape5") 
	{isNS = 1;}
else if (browserType == "Netscape6") 
	{isNS = 1;}
else if (browserType == "Microsoft Internet Explorer4") 
	{isIE = 1;}
else if (browserType == "Microsoft Internet Explorer5") 
	{isIE = 1;}
else if (browserType == "Microsoft Internet Explorer6") 
	{isIE = 1;}


//	alert(browserType);
	
var docObj;
var styleObj;
var topVal;

docObj = (isNS) ? 'document' : 'document.all';
styleObj = (isNS) ? '' : '.style';
	