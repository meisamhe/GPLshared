var expDays = 30;
var exp = new Date();
exp.setTime(exp.getTime() + (expDays*24*60*60*1000));
//To get cookie value
function getCookieVal (offset) {
var endstr = document.cookie.indexOf (";", offset);
if (endstr == -1)
endstr = document.cookie.length;
return unescape(document.cookie.substring(offset, endstr));
}

// To get Cookie given the name
function GetCookie (name) {
var arg = name + "=";
var alen = arg.length;
var clen = document.cookie.length;
var i = 0;
while (i < clen) {
var j = i + alen;
if (document.cookie.substring(i, j) == arg)
return getCookieVal (j);
i = document.cookie.indexOf(" ", i) + 1;
if (i == 0) break;
}
return null;
}

// Set the value passed for the cookie against the cookie name

function SetCookieValue (name, value) {
        var argv = SetCookie.arguments;
        var argc = SetCookie.arguments.length;
        var expires = exp;// Changed for DOT-136
        var path = (argc > 3) ? argv[3] : null;
        var domain = (argc > 4) ? argv[4] : null;
        var secure = (argc > 5) ? argv[5] : false;
        document.cookie = name + "=" + escape (value) +
        ((expires == null) ? "" : ("; expires=" + expires.toGMTString())) +
        ((path == null) ? "" : ("; path=" + path)) +
        ((domain == null) ? "" : ("; domain=" + domain)) +
        ((secure == true) ? "; secure" : "");
        
}

//Check to Set cookie here
function SetCookie (name, value) {
    if(name=="mainPage" || name=="selectedHorzNav")
    {
        SetCookieValue(name,value);
    }
    else
    {
        var boolCookie=document.getElementById("checkbox").checked;
        if(boolCookie)
            {               
                SetCookieValue(name,value);
                close_splash();
            }
    }
}
// delete the cookie that has been set
function DeleteCookie (name) {
        var exp = new Date();
        exp.setTime (exp.getTime() - 1);
        var cval = GetCookie (name);
        document.cookie = name + "=" + cval + "; expires=" + exp.toGMTString();
        
}