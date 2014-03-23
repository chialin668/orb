
//
// for srcElement
//
function getSrcElement()
{
   var tgt = this.target;
   while (tgt.nodeType != 1)
     tgt = tgt.parentNode;
   return tgt;
}

if (isNS)
	Event.prototype.__defineGetter__('srcElement', getSrcElement);

function clickHandler(e)
{


   el = e.srcElement;

	el.className = "123";

   alert('className = ' + el.className)
   alert('name = ' + el.name)
   alert('id = ' + el.id);
   //...
}
