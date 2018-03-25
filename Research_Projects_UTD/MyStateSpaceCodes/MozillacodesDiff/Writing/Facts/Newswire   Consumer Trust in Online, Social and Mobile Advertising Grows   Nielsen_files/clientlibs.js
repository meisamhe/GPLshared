 function addLoadEvent(func) { 
      var oldonload = window.onload; 
      if (typeof window.onload != 'function') { 
        window.onload = func; 
      } else { 
        window.onload = function() { 
          if (oldonload) { 
            oldonload(); 
          } 
          func(); 
        } 
      } 
     }

function dowrap(mystring, mycutchars,howmanychars){
            // Here we do the actual word wrap
            // Set the NUMBER OF CHARS TO WORD WRAP HERE
            //var howmanychars=15; // hard limit for wordwrap
            var margin=7; // look within this many chars of the word wrap
            if(mycutchars == undefined){
                var spacerchar="<br/>"; // you could also just make this " "; - cut by putting a space in
            } else {
                spacerchar=mycutchars;
            }
            var myreturnstring;
            var mycutlocation=howmanychars;
            var usecutchar=true;
            if(mystring.length>howmanychars){
                // try to cut about howmanychars off the beginning. Then call this function with the rest
                 
                // If we're going to be clever, let's see if we can find a preferred cutting character within n chars of the spacerchar
                // preferred cutting chars: "/" and "-"
                //if(mystring.charAt(howmanychars) == '/' || mystring.charAt(howmanychars) == '-'){

                // Find a / or a - within n chars, or just cut it straight.
                for(var count=howmanychars-margin;count<howmanychars;count++){
                    if(mystring.charAt(count) == '/' || mystring.charAt(count)== '-'){
                        mycutlocation= count;
                        usecutchar=true;
                    }
                    if(mystring.charAt(count)==' ' || mystring.charAt(count)== ','){
                        mycutlocation= count;
                        usecutchar=false;
                    }
                }
                if(usecutchar){ 
                    myreturnstring= mystring.substr(0, mycutlocation+1)+ spacerchar;
                } else {
                    myreturnstring= mystring.substr(0, mycutlocation+1);

                }
                myreturnstring= myreturnstring + dowrap(mystring.substr(mycutlocation+1,mystring.length), spacerchar);

                
                
            } else {
                myreturnstring=mystring;
            }

            return myreturnstring;
        }

function getElementsByClass( searchClass, domNode, tagName) {
    if (domNode == null) domNode = document;
    if (tagName == null) tagName = '*';
    var el = new Array();
    var tags = domNode.getElementsByTagName(tagName);
    var tcl = " "+searchClass+" ";
    for(i=0,j=0; i<tags.length; i++) {
        var test = " " + tags[i].className + " ";
        if (test.indexOf(tcl) != -1)
            el[j++] = tags[i];
    }
    return el;
}
function getQuerystring(key, default_)
     {
         if (default_==null) default_=""; 
           key = key.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
          var regex = new RegExp("[\\?&]"+key+"=([^&#]*)");
          var qs = regex.exec(window.location.href);
         if(qs == null)
             return default_;
         else
            return qs[1];
      }
