<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML><HEAD><TITLE>ActionTrackingSystem | Sign-In</TITLE>

<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.io.*" %>
<% request.setCharacterEncoding("UTF-8"); %> 
<META http-equiv=expires content="Wed, 26 Feb 1997 08:21:57 GMT">
<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<META content="Country Select!" name=Description>
<META content=country name=Keywords>
<META content=INDEX,NOFOLLOW name=ROBOTS>
<META http-equiv=Content-Script-Type content=text/javascript><LINK 
href="/favicon.ico" type=image/x-icon rel="shortcut icon"><LINK 
href="ActionTrackingSystem_files/regular-layout.css" type=text/css 
rel=stylesheet><LINK href="ActionTrackingSystem_files/global.css" 
type=text/css rel=stylesheet><LINK 
href="ActionTrackingSystem_files/global-left-nav.css" type=text/css 
rel=stylesheet><LINK href="ActionTrackingSystem_files/membership.css" 
type=text/css rel=stylesheet><LINK 
href="ActionTrackingSystem_files/bottom_nav_lrg.css" type=text/css 
rel=stylesheet>
<SCRIPT language=JavaScript src="ActionTrackingSystem_files/bb.js" 
type=text/JavaScript></SCRIPT>

<SCRIPT language=JavaScript 
src="ActionTrackingSystem_files/cookies.js" 
type=text/JavaScript></SCRIPT>

<SCRIPT language=JavaScript type=text/JavaScript>
        /***********************
        * setupPage
        *************************/
        function setupPage()
        {
            showSection(1);
            //unhide box
            MM_findObj("registerInfo", document).style.display="block";
            setFooterEmailTextToLongVersion();
        }

        var defaultText = "With this optional service, you enter your credit card information once and never retype it again. "
             defaultText +="We will store this information on our secure server for only you to access with your username and password. "
             defaultText +="Your privacy and security are 100% guaranteed. ";

        function showSection( number )
        {
            //get the div
            var destinationDiv = MM_findObj("registerInfo", document);
            var text = "";

            for(i=1; i <= 4; i++ )
            {

                pviiClassNew( MM_findObj("section" + i, document) ,'sectionCold');
            }

            if( number == 1)
            {
                text = defaultText;
            }
            if( number == 2)
            {
                text = "Enter the name and addresses of your loved ones once - and only once! Edit them at anytime using your username and password. This is your personal storage area - we will not use the names of these people in anyway whatsoever.";

            }
            if( number == 3)
            {
                text = "Look back at previous orders to see order information like item size and price, date, shipping address, etc. This is only possible when you register with us.";
            }
            if( number == 4)
            {
                text = "Our registered members are important to us. We occasionally run special offers for registered members only - you wouldn't want to miss out!";
            }
            pviiClassNew( MM_findObj("section" + number, document) ,'sectionHot');
            destinationDiv.innerHTML = text;
        }

        function browserInfo(){
            // browser info check for registration
            reg_browser = navigator.appName;
            reg_version = navigator.appVersion;
            reg_os = navigator.platform;
            var cookieEnabled=(navigator.cookieEnabled)? true : false
            //if not IE4+ nor NS6+
            if (typeof navigator.cookieEnabled=="undefined" && !cookieEnabled){
            document.cookie="testcookie"
            cookieEnabled=(document.cookie=="testcookie")? true : false
            document.cookie="" //erase dummy value
            }

            if (cookieEnabled) //if cookies are enabled on client's browser
            {
                window.location = "UMRegisterBBCustomer.process?RestartFlow=t&Merchant_Id=1&Search_Country=United+States&xbrowser_val=" + reg_browser + "&xcookie_val=" + "1";
            }
            else{
                window.location = "UMRegisterBBCustomer.process?RestartFlow=t&Merchant_Id=1&Search_Country=United+States&xbrowser_val=" + reg_browser + "&xcookie_val=" + "0";
            }
        }


        var User = readCookie('BB_User')  // read the user cookie


        function upperCaseUsername() {
            document.LoginForm.logonUsername.value = document.LoginForm.logonUsernameTemp.value.toUpperCase();
            saveCookie('BB_User',document.LoginForm.logonUsername.value,360);
        }

    </SCRIPT>

<STYLE type=text/css>
#leftContent {
	BORDER-RIGHT: #d5ae65 1px solid; PADDING-RIGHT: 15px; PADDING-LEFT: 5px; PADDING-BOTTOM: 0px; WIDTH: 250px; PADDING-TOP: 0px
}
#rightContent {
	PADDING-RIGHT: 0px; PADDING-LEFT: 15px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px
}
#input {
	WIDTH: 130px
}
.fieldLabel {
	PADDING-RIGHT: 5px
}
#signinBox TD {
	PADDING-TOP: 8px
}
.sectionCold {
	FONT-WEIGHT: bold; COLOR: #2a3960; TEXT-DECORATION: none
}
.sectionHot {
	FONT-WEIGHT: bold; COLOR: #d5ae65; TEXT-DECORATION: none
}
#register #sections TD {
	PADDING-TOP: 10px
}
.fieldLabel1 {
	PADDING-RIGHT: 5px
}
.style2 {
	PADDING-RIGHT: 5px;
	color: #2A3960;
	font-weight: bold;
}
</STYLE>

<META content="MSHTML 6.00.6000.16544" name=GENERATOR></HEAD>
<Script Language="JavaScript" Src="dateScript.js"></Script>
<Script Language="JavaScript" Src="persianPopupCalendar.js"></Script>  


<BODY onload=setupPage() style="text-align: center">
<p>
  <% if (session.getAttribute("TYPE") == null )
    response.sendRedirect("ActionTrackingSystem.jsp");
	else if (((String)session.getAttribute("TYPE")).compareTo("manager")!=0 &&((String)session.getAttribute("TYPE")).compareTo("employee")!=0)
	response.sendRedirect("ActionTrackingSystem.jsp");
%>
    <A name=top></A>
    <STYLE type=text/css>
  #topNavLrg {
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; WIDTH: 748px; PADDING-TOP: 0px; HEIGHT: 49px; TEXT-ALIGN: center
}
#bbLogo {
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FLOAT: left; PADDING-BOTTOM: 0px; MARGIN: 0px; WIDTH: 256px; PADDING-TOP: 0px
}
#topNav {
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FLOAT: right; PADDING-BOTTOM: 0px; MARGIN: 0px; WIDTH: 492px; PADDING-TOP: 0px
}
#topNavSearch {
	FLOAT: right; MARGIN: 0px; WIDTH: 215px; COLOR: #fff; PADDING-TOP: 6px
}
#topNavSearch A {
	FONT-SIZE: 10px; COLOR: #fff; TEXT-DECORATION: none
}
#topNavSearch A:hover {
	COLOR: #d5ae65; TEXT-DECORATION: none
}
#topNavSearch INPUT {
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; MARGIN-BOTTOM: 10px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px
}
#topNavBanner {
	FLOAT: left; WIDTH: 277px; COLOR: #fff; TEXT-ALIGN: center
}
.navAlt {
	COLOR: #d5ae65
}
#mainnavLrg {
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 10px; MARGIN: 0px; OVERFLOW: hidden; WIDTH: 716px; PADDING-TOP: 10px; HEIGHT: 10px
}
#mainnavLrg UL {
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px; LIST-STYLE-TYPE: none
}
#mainnavLrg LI {
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FLOAT: left; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px
}
#mainnavLrg A {
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FLOAT: left; PADDING-BOTTOM: 0px; OVERFLOW: hidden; TEXT-TRANSFORM: uppercase; COLOR: #fff; PADDING-TOP: 10px; HEIGHT: 0px! important; TEXT-DECORATION: none
}
#mainnavLrg A:hover {
	BACKGROUND-POSITION: 0px -12px
}
#mainnavLrg LI.active {
	BACKGROUND-POSITION: 0px -12px
}
#mainnavLrg LI A.active {
	BACKGROUND-POSITION: 0px -12px
}
#mainnavLrg LI A.active:hover {
	BACKGROUND-POSITION: 0px -12px
}
#men A {
	BACKGROUND: url(/Content/Nav/Images/topnav/topnav_lrg_men.gif) no-repeat left top; MARGIN-LEFT: 6px; WIDTH: 31px; MARGIN-RIGHT: 23px
}
#women A {
	BACKGROUND: url(/Content/Nav/Images/topnav/topnav_lrg_women.gif) no-repeat left top; WIDTH: 54px; MARGIN-RIGHT: 25px
}
#boys A {
	BACKGROUND: url(/Content/Nav/Images/topnav/topnav_lrg_boys.gif) no-repeat left top; WIDTH: 32px; MARGIN-RIGHT: 25px
}
#countryclub A {
	BACKGROUND: url(/Content/Nav/Images/topnav/topnav_lrg_countryclub.gif) no-repeat left top; WIDTH: 101px; MARGIN-RIGHT: 25px
}
#blackfleece A {
	BACKGROUND: url(/Content/Nav/Images/topnav/topnav_lrg_blackfleece.gif) no-repeat left top; WIDTH: 92px; MARGIN-RIGHT: 24px
}
#holiday A {
	BACKGROUND: url(/Content/Nav/Images/topnav/topnav_lrg_holiday.gif) no-repeat left top; WIDTH: 60px; MARGIN-RIGHT: 23px
}
#brooksbuys A {
	BACKGROUND: url(/Content/Nav/Images/topnav/topnav_lrg_brooksbuys.gif) no-repeat left top; WIDTH: 90px; MARGIN-RIGHT: 25px
}
#giftcard A {
	BACKGROUND: url(/Content/Nav/Images/topnav/topnav_lrg_giftcard.gif) no-repeat left top; WIDTH: 70px
}
  </STYLE>
  
    <SCRIPT type=text/javascript>
<!-- 
function addQuot() {
	if (document.SearchForm.q.value != "") {
		document.SearchForm.submit();
		return true;
	} else {
		alert("Please fill-in the search box");
		document.SearchForm.q.focus();
		return false;
	}
}
//  -->
  </SCRIPT>
    <A name=top></A>
</p>
<DIV id=topNavLrg>
<DIV id=bbLogo>
  <p><A href="http://www.brooksbrothers.com/" name=&amp;lid=Logo></A></p>
  </DIV>
<DIV id=topNav>
<DIV id=topNavBanner style="WIDTH: 265px; TEXT-ALIGN: center">
  <p><A 
onclick="centerPopUp(this.href, 'home', 400, 400, 'auto'); return false;" 
href="https://www.brooksbrothers.com/content/home/compshipping_winter07.html" 
name=&amp;lid=TopNav_Shipping_Caveats_11222007></A></p>
  <p><A href="http://www.brooksbrothers.com/" name=&amp;lid=Logo></A></p>
</DIV>
</DIV>
<p><BR 
style="CLEAR: both; LINE-HEIGHT: 0; HEIGHT: 0px">
</p>

</DIV>
<table>
<tr><td><p><A href="http://www.brooksbrothers.com/" name=&amp;lid=Logo><IMG 
height=80 alt="ActionTrackingSystem" 
src="ActionTrackingSystem_files/logo.gif" width=323 
border=0></A></p>
<p>&nbsp; </p></td></tr>
</table>
<DIV id=mainContentBorder align=center style="width: 719px; height: 710px">
  <DIV id=div style="width:1000" >
     <TABLE cellSpacing=0 cellPadding=0>
    <TBODY>
      <TR>
        <TD width="37"><a href="SecondPage.jsp"><img src="home1.gif" name="home" width="30" height="34" border="0"></a></TD>
		<TD width="39" name="latestCompleted"><a href="latestCompleted.jsp"><img src="latestCompleted.jpg" width="31" height="32" border="0"></a></TD>
        <TD width="31"><span class="currentPage"><a href="DA.jsp"><img src="new1.gif" name="newActivity" width="30" height="34" border="0"></a></span></TD>
        <TD width="32" name="All Employee Activity view "><a href="EA.jsp"><img src="employees2.gif" width="32" height="36" border="0"></a></TD>
        <TD width="40" name="Special Employee Activity View"><a href="SE.jsp"><img src="employee1.gif" width="40" height="40" border="0"></a> </TD>
      <TD width="31" name="change Password"><a href="changePassword.jsp"><img src="changePassword.gif" width="32" height="35" border="0"></a></TD>
	    <TD width="782" name="Log Page View"><a href="Log.jsp"><img src="log.gif" width="39" height="41" border="0"></a></TD>
        <TD width="39"><A 
href="ActionTrackingSystem.jsp"><img src="logout.gif"></A> </TD>
      </TR>
    </TBODY>
  </TABLE>
  </DIV>
  <DIV 
style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px; HEIGHT: 5px ;width:200">
	<IMG 
style="BACKGROUND-COLOR: #d5ae65" height=5 alt="" 
src="ActionTrackingSystem_files/spacer.gif" width=577 border=0></DIV>
<DIV id=mainContent style="width: 579px; height: 686px">
<DIV id=breadCrumb style="MARGIN-TOP: 8px;width: 257px; height:18px">
<TABLE cellSpacing=0 cellPadding=0>
  <TBODY>
  <TR>
  <td></td>
    <TD><A href="https://www.brooksbrothers.com/"></A></TD>
    <TD>&nbsp;</TD>
    </TR></TBODY></TABLE>
</DIV>
<DIV id=mainContentMiddleBorder style="width:592px; height:589px">
<DIV id=mainBody style="width:546px; height:643px">
<!-- THIS PART IS FOR LINE-->
<TABLE style="WIDTH: 287px" cellSpacing=0 cellPadding=0 border=0>
  <TBODY>
  <TR vAlign=top>
    <TD id=leftContent width="563"><!-- ########### LEFT CONTENT ################# -->
      <DIV class=outlineBox id=signinBox 
      style="MARGIN-TOP: 15px; TEXT-ALIGN: center;width:524px; height:475px" >       <p>
	  <jsp:useBean id="sampleMainServiceProxyid" scope="session" class="com.actionTracking.MainServiceProxy" />
	  <% 		 try{
	%>
      
        <p align="left" class="style2">Logs:</p>
		  <TABLE cellSpacing=0 cellPadding=0 border=0>
        <TBODY>
        <TR>
          <TD style="PADDING-TOP: 0px"><IMG height=1 alt=" " 
            src="ActionTrackingSystem_files/spacer(1).gif" width=1></TD>
          <TD style="COLOR: #2a3960; PADDING-TOP: 0px"></TD></TR></TBODY></TABLE>
     <TABLE width="475" height="80" border=1 cellPadding=0 cellSpacing=0 bordercolorlight="#FFFFFF">
        <TBODY>
          <TR>
            <TD width="145" height="24" class="style2">
			<p style="text-align: center">ActivityTitle</TD>
            <TD width="66" class="style2"><div align="center">Date </div></TD>
            <TD width="125">
			<p class="style2" style="text-align: center">ChangeType </TD>
            <TD width="72"><p style="text-align: center"><span class="style2">Changer</span></TD>
            <TD width="104" class="style2">oldValue</TD>
            </TR>
		  
          <tr>
            <TD height="56" class="style2">s</TD>
            <TD style="text-align: center" class="style2">&nbsp;</TD>
            <TD style="text-align: center" class="style2">  s  </TD>      
            <TD style="text-align: center" class="style2"> s </TD>        
            <TD style="text-align: center"class="style2">s </TD>         
          </tr>
        </TBODY>
      </TABLE> 
      <p align="right">&nbsp;</p>
      <p align="left" class="style2">Select Log for view: </p>
      
        <div align="center">
          <TABLE width="346" height="170" border=1 cellPadding=0 cellSpacing=0 bordercolorlight="#FFFFFF">
              <TBODY>
        
                <tr>
                  <TD width="110" height="56" class="style2">Kind of Log: </TD>
                  <TD width="230" style="text-align: center"><div align="left">
                      <select name="log">
                        <option value="1">AvoidedChangeOneEmployee</option>
						<option value="2">StateAvoidedChangeAllEmployee</option>
						<option value="3">RemovedActivityReport</option>
					  	<option value="4">ReferenceChangeReport</option>
						<option value="5">DeadLineChangeOfActivity</option>
						<option value="6">AllChangeOfActivity</option>
                      </select>
                    </div>                  </tr>
                <tr>
        
                  <TD height="56" class="style2">Activity : </TD>
                  <TD style="text-align: center"><div align="left">
				      <%

 String type_101id= (String) session.getAttribute("TYPE");
        java.lang.String type_101idTemp  = type_101id;	
        String date_102id="99999999" ;
        long date_102idTemp  = Long.parseLong(date_102id);
        String user_103id=(String)  session .getAttribute("USER");
        java.lang.String user_103idTemp  = user_103id;
        com.actionTracking.Activity[] uncompletedActivityUntilDate =  sampleMainServiceProxyid.uncompletedActivityUntilDateOfsubsidary(date_102idTemp,user_103idTemp);
%>
          <%
java.util.List listreturnp279;
if(uncompletedActivityUntilDate == null){
	listreturnp279=null;
}else{
    listreturnp279= java.util.Arrays.asList(uncompletedActivityUntilDate);
}%>
 <select name="activity">
<%
for(int i=0; i<listreturnp279.size();i++){
	com.actionTracking.Activity activity = (com.actionTracking.Activity)listreturnp279.get(i);	
%>
                     
                        <option  value="<%=activity.getActivityId()%>"><%=activity.getName()%></option>
<%}
%>
                      </select>
                    </div>
                  </tr>
                <tr>
                  <TD height="56" class="style2">Person:</TD>
                  <TD style="text-align: center">                
                    <div align="left">
                      <select name="person">
					  <%{
					  String type_164id=  "manager";
        java.lang.String type_164idTemp  = type_164id;
        String user_165id=  (String) session.getAttribute("USER");
        java.lang.String user_165idTemp  = user_165id;
        com.actionTracking.Person[] getSubsidaryPersonel580mtemp = sampleMainServiceProxyid.getSubsidaryPersonel("manager",user_165idTemp);
if(uncompletedActivityUntilDate == null){
	listreturnp279=null;
}else{
    listreturnp279= java.util.Arrays.asList(getSubsidaryPersonel580mtemp);
}

for(int i=0; i<listreturnp279.size();i++){
	com.actionTracking.Person person = (com.actionTracking.Person)listreturnp279.get(i);	
%>
                        <option  value="<%=person.getUser()%>"><%=person.getName()+"_"+person.getFamily()+"("+person.getDepartment()+"_"+person.getLocation()+")"%></option>
<%}
}
%>
		           </select>
                    </div>
                  </tr>

              </TBODY>
                  </TABLE>
        </div>
        <div align="center"></div>
        <p align="left" class="style2">&nbsp;</p>
      </DIV>
      <!-- ########### LEFT CONTENT ################# --></TD>
    <td></td></TR></TBODY></TABLE>
<p style="text-align: center">
</DIV>
<p style="text-align: center">
 &nbsp;&nbsp;&nbsp;&nbsp;

</p>

</DIV><!-- JOIN ActionTrackingSystem EMAIL LIST -->
<DIV id=joinandFooter style="MARGIN-BOTTOM: 15px"></DIV>
</DIV><p></p>
</DIV>
<p>
<!-- HitBox Enterprise by Mulenga-->
<SCRIPT language=JavaScript 
src="ActionTrackingSystem_files/hbx_strip.js" 
type=text/JavaScript></SCRIPT>
<!--WEBSIDESTORY CODE HBX2.0 (Universal)--><!--COPYRIGHT 1997-2005 WEBSIDESTORY,INC. ALL RIGHTS RESERVED. U.S.PATENT No. 6,393,479B1. MORE INFO:http://websidestory.com/privacy-->
<SCRIPT language=javascript>
var _hbEC=0,_hbE=new Array;function _hbEvent(a,b){b=_hbE[_hbEC++]=new Object();b._N=a;b._C=0;return b;}
var hbx=_hbEvent("pv");hbx.vpc="HBX0200u";hbx.gn="c.brooksbrothers.com";

//BEGIN EDITABLE SECTION
//CONFIGURATION VARIABLES
hbx.acct="DM510321KBNV93EN3";//ACCOUNT NUMBER(S)
hbx.pn=hbxStrip("sign+in");//PAGE NAME(S)
hbx.mlc=hbxStrip("members");//MULTI-LEVEL CONTENT CATEGORY
hbx.pndef="title";//DEFAULT PAGE NAME
hbx.ctdef="full";//DEFAULT CONTENT CATEGORY

//OPTIONAL PAGE VARIABLES
//ACTION SETTINGS
hbx.fv="99999999999999999999";//FORM VALIDATION MINIMUM ELEMENTS OR SUBMIT FUNCTION NAME
hbx.lt="auto";//LINK TRACKING
hbx.dlf="n";//DOWNLOAD FILTER
hbx.dft="n";//DOWNLOAD FILE NAMING
hbx.elf="n";//EXIT LINK FILTER

//SEGMENTS AND FUNNELS
hbx.seg="";//VISITOR SEGMENTATION
hbx.fnl="";//FUNNELS

//CAMPAIGNS
hbx.cmp="";//CAMPAIGN ID
hbx.cmpn="";//CAMPAIGN ID IN QUERY
hbx.dcmp="";//DYNAMIC CAMPAIGN ID
hbx.dcmpn="";//DYNAMIC CAMPAIGN ID IN QUERY
hbx.dcmpe="";//DYNAMIC CAMPAIGN EXPIRATION
hbx.dcmpre="";//DYNAMIC CAMPAIGN RESPONSE EXPIRATION
hbx.hra="";//RESPONSE ATTRIBUTE
hbx.hqsr="";//RESPONSE ATTRIBUTE IN REFERRAL QUERY
hbx.hqsp="";//RESPONSE ATTRIBUTE IN QUERY
hbx.hlt="";//LEAD TRACKING
hbx.hla="";//LEAD ATTRIBUTE
hbx.gp="";//CAMPAIGN GOAL
hbx.gpn="";//CAMPAIGN GOAL IN QUERY
hbx.hcn="";//CONVERSION ATTRIBUTE
hbx.hcv="";//CONVERSION VALUE
hbx.cp="null";//LEGACY CAMPAIGN
hbx.cpd="";//CAMPAIGN DOMAIN

//CUSTOM VARIABLES
hbx.ci="";//CUSTOMER ID
hbx.hc1="";//CUSTOM 1
hbx.hc2="";//CUSTOM 2
hbx.hc3="";//CUSTOM 3
hbx.hc4="";//CUSTOM 4
hbx.hrf="";//CUSTOM REFERRER
hbx.pec="";//ERROR CODES

//INSERT CUSTOM EVENTS

//END EDITABLE SECTION

//REQUIRED SECTION. CHANGE "YOURSERVER" TO VALID LOCATION ON YOUR WEB SERVER (HTTPS IF FROM SECURE SERVER)
</SCRIPT>

<SCRIPT language=javascript1.1 
src="ActionTrackingSystem_files/hbx.js"></SCRIPT>
<!--END WEBSIDESTORY CODE--><!-- END HitBox Enterprise -->


<%}catch(Exception e){
			 out.print(e);
	 }%>
</p>
</BODY></HTML>