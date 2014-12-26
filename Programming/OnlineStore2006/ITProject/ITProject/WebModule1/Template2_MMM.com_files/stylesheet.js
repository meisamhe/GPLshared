sPlatForm = "PC";
sBrowserType = "EXP";
if (navigator.appName.indexOf("Netscape")!=-1) {
	sBrowserType = "NET";
	sBrowserVersion = navigator.appVersion.substring(0,navigator.appVersion.indexOf(" "));
} else {
	sBrowserVersion = navigator.appVersion.substring(navigator.appVersion.indexOf("MSIE")+5);
	sBrowserVersion = sBrowserVersion.substring(0,sBrowserVersion.indexOf(";"));
}
if (navigator.appVersion.indexOf("Mac")!=-1) { sPlatForm = "MAC"; }
if ((sBrowserType == "NET") & (sBrowserVersion >= 5)) { sPlatForm = "PC"; sBrowserType = "EXP"; }
document.write('<LINK REL="StyleSheet" HREF="/system/css/stylesheet_' + sPlatForm + sBrowserType + '.css" TYPE="text/css">');

