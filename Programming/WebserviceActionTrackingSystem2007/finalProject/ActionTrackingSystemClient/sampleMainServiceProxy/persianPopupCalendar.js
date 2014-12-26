
/******************************************************************************
' Filename:       persianPopupCalendar.js
' Author:         Hooman Behmanesh
' E-Mail:					hoomb@web.de (please mention persianPopupCalendar in subject)
' Project:        Persian Popup Calendar
' Version:				1.5
' =============================================================================
' Copyright (c) 2006, Hooman Behmanesh. All rights reserved.
'
' Permission is hereby granted, free of charge, to any person obtaining a copy
' of this script and associated files, to deal in the Software without restriction
' including without limitation the rights.
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Script, and to permit persons to whom the Software is
' furnished to do so, subject to the following conditions:
'
' The above copyright notice and this permission notice shall be included in
' all copies or substantial portions of the Scripts:
'
' THE SCRIPT IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
' SOFTWARE.
'
' =============================================================================
'	Thanks to:
' - Xin Yang (http://www.yxscripts.com) for his earlier version of "Popup Calendar(Window)"
' which I have used as base kernel of this script.
' - Mehdi Vojoudi (http://www.vojoudi.com) for his Solar Date Conversion algorithms
' =============================================================================
'
' I will really appreciate if you send me any changed, fixed bugs or
' extended version of this Script by you to help to extend the script.
' Also I will have the pleasure to receive any reported bug and suggestions.
'
' You can use following fields to record your name to prove your
' Development participate in Persian Popup Calendar Script project.
'
' =============================================================================
' Date          Person							Description
' ----------    ----------------		---------------------------------
' 30.03.2006    Hooman Behmanesh  	Initial Version
' 31.03.2006    Hooman Behmanesh		Fix a bug in Return of Current date
' 20.04.2006    Hooman Behmanesh		Major Change, Design as DIV instead of Window
' 25.09.2006    Hooman Behmanesh		Fix the IFrame position, also FireFox compatibility.
' 28.09.2006    Hooman Behmanesh		Fix the Weekday bug
' 09.03.2007    Hooman Behmanesh		Added 2 new features : 
'																								- Flat (without autohide) Calendar
'																								- Disable weekends
' 16.07.2007    Hooman Behmanesh		Added 3 new features : 
'																								- Use the calendar without specifying a Form
'																								- Specifying special days
'																								- Mark weekend days with red
'
*******************************************************************************/

var fontFace="Tahoma";
var fontSize=11;

var titleWidth=90;
var titleMode=1;
var dayWidth=12;
var dayDigits=1;

var titleColor="#CCCC99";
var daysColor="#EEBB89";
var bodyColor="#FFFFCC";
var dayColor="#FFFF99";
var currentDayColor="#FFCC99";
var footColor="#CCCC99";
var borderColor="#333333";

var titleFontColor = "#333333";
var daysFontColor = "#333333";
var dayFontColor = "#333333";
var freeDayFontColor = "#ff0000";
var currentDayFontColor = "#ffffff";
var footFontColor = "#333333";

var specialDayBackColor = "#E9967A";

var calFormat = "yyyy/mm/dd";

var weekDay = 0;
var dayCorrection = 4;

var flat = false;

var disableWeekend = true;

var specialDates = new Array();
// ------

// codes
var calWidth=200, calHeight=200, calOffsetX=0, calOffsetY=0;
var calWin=null;
var winX=0, winY=0;
var cal="cal";
var cals=new Array();
var currentCal=null;

var yxMonths=new Array("فروردین", "اردیبهشت", "خرداد", "تیر", "مرداد", "شهریور", "مهر", "آبان", "آذر", "دی", "بهمن", "اسفند");
var yxDays=new Array("شنبه","یکشنبه","دوشنبه", "سه شنبه", "چهارشنبه", "پنجشنبه", "جمعه","شنبه");
var yxLinks=new Array("[پاک کردن]", "[بستن]");

var nav=navigator.userAgent.toLowerCase();
var isOpera=(nav.indexOf("opera")!=-1)?true:false;
var isOpera5=(nav.indexOf("opera 5")!=-1 || nav.indexOf("opera/5")!=-1)?true:false;
var isOpera6=(isOpera && parseInt(navigator.appVersion)>=6)?true:false;
var isN6=(nav.indexOf("gecko")!=-1);
var isN4=(document.layers)?true:false;
var isMac=(nav.indexOf("mac")!=-1);
var isIE=(document.all && !isOpera && (!isMac || navigator.appVersion.indexOf("MSIE 4")==-1))?true:false;

if (isN4) {
  fontSize+=2;
}

var span2="</span>";

function showCalendar() {
    currentCal.calIFrameContainer.style.visibility = 'visible';
  	currentCal.calDivContainer.style.visibility = 'visible';
}

function hideCalendar() {
    if (! currentCal.flat) {
	    currentCal.calIFrameContainer.style.visibility = 'hidden';
	  	currentCal.calDivContainer.style.visibility = 'hidden';
  	}
}

function hideAllCalendars() {
   for (var i = 0; i < cals.length; i ++) {
    if (! cals[i].flat) {
	    cals[i].calIFrameContainer.style.visibility = 'hidden';
	  	cals[i].calDivContainer.style.visibility = 'hidden';
  	}
	}
}

function span1(tag) {
  return "<span class='"+tag+"'>";
}

function spanx(tag, color) {
  return "."+tag+" { font-family:"+fontFace+"; font-size:"+fontSize+"px; color:"+color+"; }\n";
}

function a1(tag) {
  return "<a class='"+tag+"' href=";
}

function ax(tag, color) {
  return "."+tag+" { text-decoration:none; color:"+color+"; }\n";
}

function calOBJ(name, title, field, form) {
  this.name = name;
  this.title = title;
  this.field = field;
  this.formName = form;
  this.form = null;
  this.flat = flat;
  this.fieldObject = document.getElementById(field);
  
	var tmpIframe = document.createElement("IFRAME");
	tmpIframe.id = 'frm' + name;
	tmpIframe.name = 'frm' + name;
	tmpIframe.style.visibility = 'hidden';
  tmpIframe.style.position = 'absolute';
  tmpIframe.style.top = 0;
  tmpIframe.style.left = 0;
  tmpIframe.width = 0;
  tmpIframe.height = 0;
  tmpIframe.style.border = 'none';
  tmpIframe.style.zIndex = 10000;
  document.body.appendChild(tmpIframe);

	var tmpContainer = document.createElement("DIV");
	tmpContainer.id = 'div' + name;
	tmpContainer.name = 'div' + name;
	tmpContainer.style.visibility = 'hidden';
  tmpContainer.style.position = 'absolute';
  tmpContainer.style.top = 0;
  tmpContainer.style.left = 0;
  tmpContainer.width = 0;
  tmpContainer.height = 0;
  tmpContainer.style.border = 'none';
  tmpContainer.style.zIndex = 10001;
  tmpContainer.innerHTML = 'Hooman Behmanesh';
  document.body.appendChild(tmpContainer);
  
  this.calIFrameContainer = tmpIframe;
  this.calDivContainer = tmpContainer;
}

// Find positioning
function getOffset(obj, dim) {
  var oLeft, oTop, oWidth, oHeight;
  
  if(dim == "left")
  {     
    oLeft = obj.offsetLeft;  
    while(obj.offsetParent!=null) 
    {    
      oParent = obj.offsetParent;
      oLeft += oParent.offsetLeft;
      obj = oParent;
    }
    return oLeft;
  }
  else if(dim=="top")
  {
    oTop = obj.offsetTop;
    while(obj.offsetParent!=null) 
    {
      oParent = obj.offsetParent;
      oTop += oParent.offsetTop;
      obj = oParent;
    }
    return oTop;
  }
  else if(dim=="width")
  {
    oWidth = obj.offsetWidth;
    return oWidth;
  }  
  else if(dim=="height")
  {
    oHeight = obj.offsetHeight;
    return oHeight;
  }    
  else
  {
    alert("Error: invalid offset dimension '" + dim + "' in getOffset()");
    return false;
  }
}

function setFont(font, size) {
  if (font != "") {
    fontFace=font;
  }
  if (size > 0) {
    fontSize=size;

    if (isN4) {
      fontSize+=2;
    }
  }
}

function setWidth(tWidth, tMode, dWidth, dDigits) {
  if (tWidth > 0) {
    titleWidth=tWidth;
  }
  if (tMode == 1 || tMode == 2) {
    titleMode=tMode;
  }
  if (dWidth > 0) {
    dayWidth=dWidth;
  }
  if (dDigits > 0) {
    dayDigits=dDigits;
  }
}

function setColor(tColor, dsColor, bColor, dColor, cdColor, fColor, bdColor) {
  if (tColor != "") {
    titleColor=tColor;
  }
  if (dsColor != "") {
    daysColor=dsColor;
  }
  if (bColor != "") {
    bodyColor=bColor;
  }
  if (dColor != "") {
    dayColor=dColor;
  }
  if (cdColor != "") {
    currentDayColor=cdColor;
  }
  if (fColor != "") {
    footColor=fColor;
  }
  if (bdColor != "") {
    borderColor=bdColor;
  }
}

function setFontColor(tColorFont, dsColorFont, dColorFont, cdColorFont, fColorFont) {
  if (tColorFont != "") {
    titleFontColor=tColorFont;
  }
  if (dsColorFont != "") {
    daysFontColor=dsColorFont;
  }
  if (dColorFont != "") {
    dayFontColor=dColorFont;
  }
  if (cdColorFont != "") {
    currentDayFontColor=cdColorFont;
  }
  if (fColorFont != "") {
    footFontColor=fColorFont;
  }
}

function setFormat(format) {
  calFormat = format;
}

function setFlat(flatStatus) {
	flat = flatStatus;
}

function setSize(width, height, ox, oy) {
  if (width > 0) {
    calWidth=width;
  }
  if (height > 0) {
    calHeight=height;
  }

  calOffsetX=ox;
  calOffsetY=oy;
}

function setWeekDay(wDay) {
  if (wDay == 0 || wDay == 1) {
    weekDay = wDay;
  }
}

function setMonthNames(janName, febName, marName, aprName, mayName, junName, julName, augName, sepName, octName, novName, decName) {
  if (janName != "") {
    yxMonths[0] = janName;
  }
  if (febName != "") {
    yxMonths[1] = febName;
  }
  if (marName != "") {
    yxMonths[2] = marName;
  }
  if (aprName != "") {
    yxMonths[3] = aprName;
  }
  if (mayName != "") {
    yxMonths[4] = mayName;
  }
  if (junName != "") {
    yxMonths[5] = junName;
  }
  if (julName != "") {
    yxMonths[6] = julName;
  }
  if (augName != "") {
    yxMonths[7] = augName;
  }
  if (sepName != "") {
    yxMonths[8] = sepName;
  }
  if (octName != "") {
    yxMonths[9] = octName;
  }
  if (novName != "") {
    yxMonths[10] = novName;
  }
  if (decName != "") {
    yxMonths[11] = decName;
  }
}

function setDayNames(sunName, monName, tueName, wedName, thuName, friName, satName) {
  if (sunName != "") {
    yxDays[0] = sunName;
    yxDays[7] = sunName;
  }
  if (monName != "") {
    yxDays[1] = monName;
  }
  if (tueName != "") {
    yxDays[2] = tueName;
  }
  if (wedName != "") {
    yxDays[3] = wedName;
  }
  if (thuName != "") {
    yxDays[4] = thuName;
  }
  if (friName != "") {
    yxDays[5] = friName;
  }
  if (satName != "") {
    yxDays[6] = satName;
  }
}

function setLinkNames(closeLink, clearLink) {
  if (closeLink != "") {
    yxLinks[0] = closeLink;
  }
  if (clearLink != "") {
    yxLinks[1] = clearLink;
  }
}

function addCalendar(name, title, field, form) {
  cals[cals.length] = new calOBJ(name, title, field, form);
  
  if (flat)
  		showCal(name);
}

function findCalendar(name) {
  for (var i = 0; i < cals.length; i++) {
    if (cals[i].name == name) {
      if (cals[i].form == null) {
        if (cals[i].formName == "") {
          if (document.forms[0]) {
            cals[i].form = document.forms[0];
          }
        }
        else if (document.forms[cals[i].formName]) {
          cals[i].form = document.forms[cals[i].formName];
        }
      }

      return cals[i];
    }
  }

  return null;
}

function getDayName(y,m,d) {
  var wd=new Date(y,m,d);
  return yxDays[wd.getDay()].substring(0,3);
}

function getMonthFromName(m3) {
  for (var i = 0; i < yxMonths.length; i++) {
    if (yxMonths[i].toLowerCase().substring(0,3) == m3.toLowerCase()) {
      return i;
    }
  }

  return 0;
}

function getFormat() {
  var calF = calFormat;

  calF = calF.replace(/\\/g, '\\\\');
  calF = calF.replace(/\//g, '\\\/');
  calF = calF.replace(/\[/g, '\\\[');
  calF = calF.replace(/\]/g, '\\\]');
  calF = calF.replace(/\(/g, '\\\(');
  calF = calF.replace(/\)/g, '\\\)');
  calF = calF.replace(/\{/g, '\\\{');
  calF = calF.replace(/\}/g, '\\\}');
  calF = calF.replace(/\</g, '\\\<');
  calF = calF.replace(/\>/g, '\\\>');
  calF = calF.replace(/\|/g, '\\\|');
  calF = calF.replace(/\*/g, '\\\*');
  calF = calF.replace(/\?/g, '\\\?');
  calF = calF.replace(/\+/g, '\\\+');
  calF = calF.replace(/\^/g, '\\\^');
  calF = calF.replace(/\$/g, '\\\$');

  calF = calF.replace(/dd/i, '\\d\\d');
  calF = calF.replace(/mm/i, '\\d\\d');
  calF = calF.replace(/yyyy/i, '\\d\\d\\d\\d');
  calF = calF.replace(/day/i, '\\w\\w\\w');
  calF = calF.replace(/mon/i, '\\w\\w\\w');

  return new RegExp(calF);
}

function getDateNumbers(date) {
  var y, m, d;

  var yIdx = calFormat.search(/yyyy/i);
  var mIdx = calFormat.search(/mm/i);
  var m3Idx = calFormat.search(/mon/i);
  var dIdx = calFormat.search(/dd/i);

  y=date.substring(yIdx,yIdx+4)-0;
  if (mIdx != -1) {
    m=date.substring(mIdx,mIdx+2)-1;
  }
  else {
    var m = getMonthFromName(date.substring(m3Idx,m3Idx+3));
  }
  d=date.substring(dIdx,dIdx+2)-0;
  return new Array(y,m,d);
}

function getLeftIE(x,m) {
  var dx=0;
  if (x.tagName=="TD"){
    dx=x.offsetLeft;
  }
  else if (x.tagName=="TABLE") {
    dx=x.offsetLeft;
    if (m) { dx+=(x.cellPadding!=""?parseInt(x.cellPadding):2); m=false; }
  }
  return dx+(x.parentElement.tagName=="BODY"?0:getLeftIE(x.parentElement,m));
}
function getTopIE(x,m) {
  var dy=0;
  if (x.tagName=="TR"){
    dy=x.offsetTop;
  }
  else if (x.tagName=="TABLE") {
    dy=x.offsetTop;
    if (m) { dy+=(x.cellPadding!=""?parseInt(x.cellPadding):2); m=false; }
  }
  return dy+(x.parentElement.tagName=="BODY"?0:getTopIE(x.parentElement,m));
}

function getLeftN4(l) { return l.pageX; }
function getTopN4(l) { return l.pageY; }

function getLeftN6(l) { return l.offsetLeft; }
function getTopN6(l) { return l.offsetTop; }

function lastDay(d) {
  var yy=d.getFullYear(), mm=d.getMonth() + 1;

  if (mm >= 1 && mm <= 6) return 31;
  if (mm >= 7 && mm <= 11) return 30;
  if (mm == 12)
  	if (IsLeapYear(dkSolar, yy)) return 30;
  	else return 29;
}

function DateDemo(y, m, d)
{
  var d, day, x, s = "Today is: ";
  d = new Date(y, m, d);
  day = d.getDay();
  s += (d.getFullYear() + "/" + (12 - d.getMonth()) + "/" + d.getDate() + " ");
  return(s += x[day]);
}

function firstDay(d) {
  var yy=d.getFullYear(), mm=d.getMonth() + 1;
  var fd=SolarToGregorian(yy, mm, 1);

  var dd = fd.getDay() - 3;
  
  return dd;
}

function getDateMonth(d) {
  var yy=d.getFullYear(), mm=d.getMonth() + 1;
  var fd=SolarToGregorian(yy, mm, 1);
  var dm = fd.getMonth() - 1;
  
  if (dm <= 0)
  	dm += 12;

  return dm;
}

function dayDisplay(i) {
  if (dayDigits == 0) {
    return yxDays[i];
  }
  else {
    return yxDays[i].substring(0,dayDigits);
  }
}

function calTitle(d) {
  var yy=d.getFullYear(), mm=yxMonths[d.getMonth()];
  var s;

  if (titleMode == 2) {
    s="<tr align='center' bgcolor='"+titleColor+"'><td colspan='7'>\n<table dir='rtl' cellpadding='0' cellspacing='0' border='0'><tr align='center' valign='middle'><td align='right'>"+span1("title")+"<b>"+a1("titlea")+"'javascript: moveYear(-10)'>&nbsp;&#171;</a>&nbsp;"+a1("titlea")+"'javascript:moveYear(-1)'>&#139;&nbsp;</a></b>"+span2+"</td><td width='"+titleWidth+"'><b>"+span1("title")+getFarsiNumber(yy)+span2+"</b></td><td align='left'>"+span1("title")+"<b>"+a1("titlea")+"'javascript:moveYear(1)'>&nbsp;&#155;</a>&nbsp;"+a1("titlea")+"'javascript:moveYear(10)'>&#187;&nbsp;</a></b>"+span2+"</td></tr><tr align='center' valign='middle'><td align='right'>"+span1("title")+"<b>"+a1("titlea")+"'javascript:prepMonth("+d.getMonth()+")'>&nbsp;&#139;&nbsp;</a></b>"+span2+"</td><td width='"+titleWidth+"'><b>"+span1("title")+mm+span2+"</b></td><td align='left'>"+span1("title")+"<b>"+a1("titlea")+"'javascript:nextMonth("+d.getMonth()+")'>&nbsp;&#155;&nbsp;</a></b>"+span2+"</td></tr></table>\n</td></tr><tr align='center' bgcolor='"+daysColor+"'>";
  }
  else {
    s="<tr align='center' bgcolor='"+titleColor+"'><td colspan='7'>\n<table dir='rtl' cellpadding='0' cellspacing='0' border='0'><tr align='center' valign='middle'><td>"+span1("title")+"<b>"+a1("titlea")+"'javascript:moveYear(-1)'>&nbsp;&#171;</a>&nbsp;"+a1("titlea")+"'javascript:prepMonth("+d.getMonth()+")'>&#139;&nbsp;</a></b>"+span2+"</td><td width='"+titleWidth+"'><nobr><b>"+span1("title")+mm+" "+getFarsiNumber(yy)+span2+"</b></nobr></td><td>"+span1("title")+"<b>"+a1("titlea")+"'javascript:nextMonth("+d.getMonth()+")'>&nbsp;&#155;</a>&nbsp;"+a1("titlea")+"'javascript:moveYear(1)'>&#187;&nbsp;</a></b>"+span2+"</td></tr></table>\n</td></tr><tr align='center' bgcolor='"+daysColor+"'>";
  }

  for (var i = weekDay; i < weekDay + 7; i ++) {
    s+="<td width='"+dayWidth+"'>"+span1("days")+dayDisplay(i)+span2+"</td>";
  }

  s+="</tr>";

  return s;
}

function calHeader() {
  return "<table dir='rtl' align='left' border='0' bgcolor='"+borderColor+"' cellspacing='0' cellpadding='1'><tr><td>\n<style type='text/css'>\n"+spanx("title",titleFontColor)+spanx("days",daysFontColor)+spanx("foot",footColor)+spanx("day",dayFontColor)+spanx("currentDay",currentDayFontColor)+spanx("freeDay",freeDayFontColor)+ax("titlea",titleFontColor)+ax("daya",dayFontColor)+ax("currenta",currentDayFontColor)+ax("foota",footFontColor)+ax("freeDay",freeDayFontColor)+"</style>\n<table dir='rtl' cellspacing='1' cellpadding='3' border='0'>";
}

function calFooterClick(d) {
	var cd = new GregorianToSolar(0, 0, 0);

	cM = cd.getMonth();
	cY = cd.getFullYear();

	pickDate(d);
}

function calFooter() {
	var s = '';
	var cd = new GregorianToSolar(0, 0, 0);

	var mm=yxMonths[cd.getMonth()];

	s += 'امروز: ';
	s += getFarsiNumber(cd.getDate()) + '&nbsp;';
	s += mm + '&nbsp;';
	s += getFarsiNumber(cd.getFullYear());

  return "<tr bgcolor='"+footColor+"'><td colspan='7' align='center'>"+span1("foot")+"<b>"+a1("foota")+"'javascript: calFooterClick("+cd.getDate()+")'>"+s+"</a></b>"+span2+"</td></tr></table>\n</td></tr></table>\n";
}

function calBody(d,day) {
  var s="", dayCount=1, fd=firstDay(d), ld=lastDay(d);
  var sm=getDateMonth(d);
	var arrCal = new Array(6);
	var i, j, k;
	var blnRowHasValue = false;
	var fontColor = dayFontColor;
	
  if (weekDay > 0 && fd == 0) {
    fd = 7;
  }
  
  for (i = 0; i < 6; i++) {
    s = "<tr align='center' bgcolor='"+bodyColor+"'>";
		for (j = 0; j < 7; j ++)
        s += "<td>"+span1("day")+"&nbsp;"+span2+"</td>";
    s += "</tr>";

    arrCal[i] = s;
	}

  k = 0;
  for (i = 0; i < 6; i++) {
    blnRowHasValue = false;
    s = "<tr align='center' bgcolor='"+bodyColor+"'>";
    for (j = weekDay - dayCorrection; j < weekDay + 7 - dayCorrection; j++) {
      if (i * 7 + j < fd || dayCount > ld) {
        s += "<td>"+span1("day")+"&nbsp;"+span2+"</td>";
      }
      else {
      	blnRowHasValue = true;
        var bgColor=dayColor;
        var fgTag="day";
        var fgTagA="daya";
        var fgTitle="";
        var fgSelectable=true;
        if (dayCount==day) {
          bgColor=currentDayColor;
          fgTag="currentDay";
          fgTagA="currenta";
        }
        
				for (sdi = 0; sdi < specialDates.length; sdi ++)
				{
					if ((specialDates[sdi]["specialDay"] == dayCount) && (specialDates[sdi]["specialMonth"] == sm))
					{
          bgColor=specialDayBackColor;
		      fgTag="day";
		      fgTagA="daya";
		      fgTitle=specialDates[sdi]["specialText"];
		      fgSelectable=specialDates[sdi]["dateSelectable"];
		      break;
					}	
				}
				
        if (((j == (weekDay + 6 - dayCorrection)) && (disableWeekend)) || (fgSelectable == false))
        {	
		      fgTag="freeDay";
		      fgTagA="freeDay";
        	s += "<td bgcolor='"+bgColor+"' title='"+fgTitle+"'>"+span1(fgTag)+ getFarsiNumber(dayCount++) + span2 + "</td>";
        }
        else
        {
        	if (j == (weekDay + 6 - dayCorrection))
	        {
			      fgTag="freeDay";
			      fgTagA="freeDay";
	        }
        	else
	        {
			      fgTag="day";
			      fgTagA="daya";
	        }
	        s += "<td bgcolor='"+bgColor+"' title='"+fgTitle+"'>"+span1(fgTag)+a1(fgTagA)+"'javascript: pickDate("+dayCount+")'>"+ getFarsiNumber(dayCount++) + "</a>"+span2+"</td>";
	      }
      }
    }
    s += "</tr>";

    if (blnRowHasValue)
    	arrCal[k ++] = s;
  }

  s = '';
  for (i = 0; i < 6; i++) {
    s += arrCal[i];
	}

  return s;
}

function moveYear(dy) {
  cY+=dy;
  var nd=new Date(cY,cM,1);
  changeCal(nd);
}

function prepMonth(m) {
  cM=m-1;
  if (cM<0) { cM=11; cY--; }
  var nd=new Date(cY,cM,1);
  changeCal(nd);
}

function nextMonth(m) {
  cM=m+1;
  if (cM>11) { cM=0; cY++;}
  var nd=new Date(cY,cM,1);
  changeCal(nd);
}

function changeCal(d) {
  var dd = 0;

  if (currentCal != null) {
    var calRE = getFormat();

    if (currentCal.fieldObject.value!="" && calRE.test(currentCal.fieldObject.value)) {
      var cd = getDateNumbers(currentCal.fieldObject.value);
      if (cd[0] == d.getFullYear() && cd[1] == d.getMonth()) {
        dd=cd[2];
      }
    }
    else {
      var cd = new GregorianToSolar(0,0,0);
      if (cd.getFullYear() == d.getFullYear() && cd.getMonth() == d.getMonth()) {
        dd=cd.getDate();
      }
    }
  }

  var calendar=calHeader()+calTitle(d)+calBody(d,dd)+calFooter();

	currentCal.calDivContainer.innerHTML = calendar;
}

function markClick(e) {
  if (isIE || isOpera6) {
    winX=event.screenX;
    winY=event.screenY;
  }
  else if (isN4 || isN6) {
    winX=e.screenX;
    winY=e.screenY;

    document.routeEvent(e);
  }

  if (isN4 || isN6) {
    document.routeEvent(e);
  }
  else {
    event.cancelBubble=false;
  }

  return true;
}

function getCalendarDivWidth (){
	var tableWidth = "" + currentCal.calDivContainer.getElementsByTagName("table").item(0).offsetWidth;
	if(tableWidth.indexOf('px') > -1){
			return parseInt(tableWidth.substring(0, tableWidth.infexOf('px')));
	} else {
			return tableWidth;
	}
}

function getCalendarDivHight (){
	var tableHeight = "" + currentCal.calDivContainer.getElementsByTagName("table").item(0).offsetHeight;
	if(tableHeight.indexOf('px') > -1){
			return parseInt(tableHeight.substring(0, tableHeight.infexOf('px')));
	} else {
			return tableHeight;
	}
}

function showCal(name) {
  var lastCal=currentCal;
  var d, hasCal=false;
	
  currentCal = findCalendar(name);
  
	if (currentCal != null)
		if (currentCal.calDivContainer.style.visibility == 'visible')
			{ hideCalendar(); return; }

	hideAllCalendars();
	
  if (currentCal != null && currentCal.fieldObject) {
    var calRE = getFormat();

    if (currentCal.fieldObject.value!="" && calRE.test(currentCal.fieldObject.value)) {
      var cd = getDateNumbers(currentCal.fieldObject.value);
      d = new Date(cd[0], cd[1], cd[2]);

      cY=cd[0];
      cM=cd[1];
      dd=cd[2];
    }
    else {
      d = new GregorianToSolar(0, 0, 0);

    	cY=d.getFullYear();
      cM=d.getMonth();
      dd=d.getDate();
    }

    var calendar=calHeader()+calTitle(d)+calBody(d,dd)+calFooter();
    var tempFieldObject = document.getElementsByName(currentCal.field)[0];
    
  	var fieldPosX = getOffset(tempFieldObject, "left");
  	var fieldPosY = getOffset(tempFieldObject, "top");
  	var fieldPosW = getOffset(tempFieldObject, "width");
  	var fieldPosH = getOffset(tempFieldObject, "height");
    
    currentCal.calIFrameContainer.style.left = fieldPosX;
    currentCal.calIFrameContainer.style.top = fieldPosY + fieldPosH;

    currentCal.calIFrameContainer.style.border = 'none';

    currentCal.calDivContainer.style.left = fieldPosX;
    currentCal.calDivContainer.style.top = fieldPosY + fieldPosH;

		currentCal.calDivContainer.innerHTML = calendar;
		
		currentCal.calIFrameContainer.width = parseInt(getCalendarDivWidth(), 10);
    currentCal.calIFrameContainer.height = parseInt(getCalendarDivHight(), 10);

    currentCal.calIFrameContainer.style.visibility = 'visible';
    currentCal.calDivContainer.style.visibility = 'visible';
  }
  else {
    if (currentCal == null) {
      window.status = "Calendar ["+name+"] not found.";
    }
    else if (!currentCal.fieldObject) {
      window.status = "Field ["+currentCal.field+"] not found.";
    }

    if (lastCal != null) {
      currentCal = lastCal;
    }
  }
}

function get2Digits(n) {
  return ((n<10)?"0":"")+n;
}

function clearDate() {
  currentCal.fieldObject.value="";
  hideCalendar();
}

function pickDate(d) {
  hideCalendar();

  var dDate=calFormat;
  dDate = dDate.replace(/yyyy/i, cY);
  dDate = dDate.replace(/mm/i, get2Digits(cM+1));
  dDate = dDate.replace(/MON/, yxMonths[cM].substring(0,3).toUpperCase());
  dDate = dDate.replace(/Mon/i, yxMonths[cM].substring(0,3));
  dDate = dDate.replace(/dd/i, get2Digits(d));
  dDate = dDate.replace(/DAY/, getDayName(cY,cM,d).toUpperCase());
  dDate = dDate.replace(/day/i, getDayName(cY,cM,d));

  var gd = new Date();
  currentCal.fieldObject.value= dDate + ' ' + get2Digits(gd.getHours()) + ':' + get2Digits(gd.getMinutes()) + ':' + get2Digits(gd.getSeconds());
  // IE5/Mac needs focus to show the value, weird.
  currentCal.fieldObject.focus();
}
// ------

// user functions
function checkDate(name) {
  var thisCal = findCalendar(name);

  if (thisCal != null && thisCal.fieldObject) {
    var calRE = getFormat();

    if (calRE.test(thisCal.fieldObject.value)) {
      return 0;
    }
    else {
      return 1;
    }
  }
  else {
    return 2;
  }
}

function getCurrentDate() {
  var dDate=calFormat, d = new GregorianToSolar(0, 0, 0);
  dDate = dDate.replace(/yyyy/i, d.getFullYear());
  dDate = dDate.replace(/mm/i, get2Digits(d.getMonth()+1));
  dDate = dDate.replace(/dd/i, get2Digits(d.getDate()));

  return dDate;
}

function compareDates(date1, date2) {
  var calRE = getFormat();
  var d1, d2;

  if (calRE.test(date1)) {
    d1 = getNumbers(date1);
  }
  else {
    d1 = getNumbers(getCurrentDate());
  }

  if (calRE.test(date2)) {
    d2 = getNumbers(date2);
  }
  else {
    d2 = getNumbers(getCurrentDate());
  }

  var dStr1 = d1[0] + "" + d1[1] + "" + d1[2];
  var dStr2 = d2[0] + "" + d2[1] + "" + d2[2];

  if (dStr1 == dStr2) {
    return 0;
  }
  else if (dStr1 > dStr2) {
    return 1;
  }
  else {
    return -1;
  }
}

function getFarsiNumber(num){
	var res = '';
	var sNum = num.toString(10);

	for (i = 0; i < sNum.length; i ++)
		res += ('&#' + (sNum.charCodeAt(i) + 1728) + ';');

	return res;
}

function getNumbers(date) {
  var calRE = getFormat();
  var y, m, d;

  if (calRE.test(date)) {
    var yIdx = calFormat.search(/yyyy/i);
    var mIdx = calFormat.search(/mm/i);
    var m3Idx = calFormat.search(/mon/i);
    var dIdx = calFormat.search(/dd/i);

    y=date.substring(yIdx,yIdx+4);
    if (mIdx != -1) {
      m=date.substring(mIdx,mIdx+2);
    }
    else {
      var mm=getMonthFromName(date.substring(m3Idx,m3Idx+3))+1;
      m=(mm<10)?("0"+mm):(""+mm);
    }
    d=date.substring(dIdx,dIdx+2);

    return new Array(y,m,d);
  }
  else {
    return new Array("", "", "");
  }
}

function addSpecialDate(specialDay, specialMonth, specialText, dateSelectable)
{
	var lastItem = specialDates.length;
	
	specialDates[lastItem] = new Object();

	specialDates[lastItem]["specialDay"] = specialDay;
	specialDates[lastItem]["specialMonth"] = specialMonth;
	specialDates[lastItem]["specialText"] = specialText;
	specialDates[lastItem]["dateSelectable"] = dateSelectable;
}

function convertToHtml(mainString)
{
	var convertedString = "";
	for (var i = 0; i < mainString.length; i ++)
		if (mainString.charCodeAt(i) >= 1522)
			convertedString += "&#" + mainString.charCodeAt(i) + ";";
		else
			convertedString += mainString.charAt(i);
			
	return convertedString;
}

// ------

if (isN4 || isN6) {
  document.captureEvents(Event.CLICK);
}
document.onclick=markClick;
