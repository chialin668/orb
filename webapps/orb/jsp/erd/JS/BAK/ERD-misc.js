function fnChangeText(data){
   var oTextNode = document.createTextNode(data);
   var oReplaceNode = oItem1.firstChild.replaceNode(oTextNode);
}


function setSysMode(sysMode) {
    var field = document.getElementById("sysModeField");
    field.value = sysMode;
    sysModeField = sysMode;
}
