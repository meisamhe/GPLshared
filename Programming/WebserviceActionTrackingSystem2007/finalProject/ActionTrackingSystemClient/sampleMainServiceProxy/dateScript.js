/******************************************************************************
' Filename:       dateScript.js
' Author:         Hooman Behmanesh
' E-Mail:					hoomb@web.de (please mention persianPopupCalendar in subject)
' Project:        Persian Popup Calendar
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
' 25.09.2006    Hooman Behmanesh  	Fix the wrong date issue
' 28.09.2006    Hooman Behmanesh		Fix the Weekday bug
'
*******************************************************************************/

var dkSolar = 0;
var dkGregorian = 1;

function IsLeapYear(DateKind, Year)
{
	if (DateKind == dkSolar)
		return ((((Year + 38) * 31) % 128) <= 30);
	else
		return (((Year % 4) == 0) && (((Year % 100) != 0) || ((Year % 400) == 0)));
}

function GregorianToSolar(gYear, gMonth, gDay) {
	  if (gDay == 0 && gMonth == 0 && gYear == 0)	{
				dDate = new Date();
	
				gDay = dDate.getDate();
				gMonth = dDate.getMonth() + 1;
				gYear = dDate.getFullYear();
	  }

	gYear = (gYear== 0) ? 2000 : gYear;
	(gYear<1000) ? (gYear += 2000) : true;
	gYear -= ( (gMonth < 3) || ((gMonth == 3) && (gDay < 21)) ) ? 622 : 621;
	switch (gMonth) { 
		case 1: (gDay<21)? (gMonth=10, gDay+=10):(gMonth=11, gDay-=20); break; 
		case 2: (gDay<20)? (gMonth=11, gDay+=11):(gMonth=12, gDay-=19); break; 
		case 3: (gDay<21)? (gMonth=12, gDay+=9):(gMonth=1, gDay-=20); break; 
		case 4: (gDay<21)? (gMonth=1, gDay+=11):(gMonth=2, gDay-=20); break; 
		case 5: 
		case 6: (gDay<22)? (gMonth-=3, gDay+=10):(gMonth-=2, gDay-=21); break; 
		case 7: 
		case 8: 
		case 9: (gDay<23)? (gMonth-=3, gDay+=9):(gMonth-=2, gDay-=22); break; 
		case 10:(gDay<23)? (gMonth=7, gDay+=8):(gMonth=8, gDay-=22); break; 
		case 11: 
		case 12:(gDay<22)? (gMonth-=3, gDay+=9):(gMonth-=2, gDay-=21); break; 
		default: break; 
	}

		this.gYear = gYear;
		this.gMonth = gMonth - 1;
		this.gDay = gDay;

		this.getDate  = function () { return this.gDay; };
		this.getMonth = function () { return this.gMonth; };
		this.getYear  = function () { return this.gYear; };
		this.getFullYear = function () { return this.gYear; };
}

function SolarToGregorian(sYear, sMonth, sDay) {

    if (sDay == 0 && sMonth == 0 && sYear == 0) {
			dDate = new Date();

			return dDate;
    }

    //'******************* Leap year
    if (sYear == 1378) {
        if (sMonth == 12 && sDay == 10)
            { sYear = 2000; sMonth = 2; sDay = 29; return; }

        if (sMonth == 12 && sDay > 10)
            sDay --;
    }
    else
    	if (sYear == 1379) {
        sDay --;

        if (sDay == 0) {
            sMonth --;
            if (sMonth > 0 && sMonth < 7) sDay = 31;
            if (sMonth > 6) sDay = 30;
            if (sMonth == 0){
                sDay = 29;
                sMonth = 12;
                sYear --;
            }
        }
    }
    //'*******************

    if (sMonth < 10 || (sMonth == 10 && sDay < 11))
        sYear += 621;
    else
        sYear += 622;

    switch (sMonth) {
        case 1: (sDay < 12) ? (sMonth = 3, sDay += 20) : (sMonth = 4, sDay -= 11); break;
        case 2: (sDay < 11) ? (sMonth = 4, sDay += 20) : (sMonth = 5, sDay -= 10); break;
        case 3: (sDay < 11) ? (sMonth = 5, sDay += 21) : (sMonth = 6, sDay -= 10); break;
        case 4: (sDay < 10) ? (sMonth = 6, sDay += 21) : (sMonth = 7, sDay -= 9);  break;
        case 5:
        case 6:
        case 8: (sDay < 10) ? (sMonth += 2, sDay += 22) : (sMonth += 3, sDay -= 9); break;
        case 7: (sDay < 9) ? (sMonth = 9, sDay += 22) : (sMonth = 10, sDay -= 8); break;
        case 9: (sDay < 10) ? (sMonth = 11, sDay += 21) : (sMonth = 12, sDay -= 9); break;
        case 10: (sDay < 11) ? (sMonth = 12, sDay += 21) : (sMonth = 1, sDay -= 10); break;
        case 11: (sDay < 12) ? (sMonth = 1, sDay += 20) : (sMonth = 2, sDay -= 11); break;
        case 12: (sDay < 10) ? (sMonth = 2, sDay += 19) : (sMonth = 3, sDay -= 9); break;
    }

		var retDate = new Date(sYear, sMonth - 1, sDay);

		return retDate;
}
