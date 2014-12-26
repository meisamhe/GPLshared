<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML><HEAD><TITLE>ActionTrackingSystem | Sign-In</TITLE>
<META http-equiv=expires content="Wed, 26 Feb 1997 08:21:57 GMT">
<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<META content="Country Select!" name=Description>
<META content=country name=Keywords>
<META content=INDEX,NOFOLLOW name=ROBOTS>
<META http-equiv=Content-Script-Type content=text/javascript><LINK 
href="/favicon.ico" type=image/x-icon rel="shortcut icon"><LINK 
href="ActionTrackingSystem_files/regular-layout1.css" type=text/css 
rel=stylesheet><LINK href="ActionTrackingSystem_files/global1.css" 
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
.style3 {PADDING-RIGHT: 5px; color: #2A3960; font-weight: bold; font-size: 18; }
.style5 {font-size: 18; }
.style6 {color: #FFFFFF}
</STYLE>

<META content="MSHTML 6.00.6000.16544" name=GENERATOR></HEAD>
<BODY onload=setupPage()>
<% if (session.getAttribute("TYPE") == null )
    response.sendRedirect("ActionTrackingSystem.jsp");
	else if (((String)session.getAttribute("TYPE")).compareTo("HR")!=0)
	response.sendRedirect("ActionTrackingSystem.jsp");
	%>
<A name=top></A>
<STYLE type=text/css>#topNavLrg {
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
<CENTER>
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
<p align="right"><span class="sectionHot style6"><a href="ActionTrackingSystem.jsp"></a></span><BR 
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
<DIV id=mainContentBorder align=center>
  <table width="430">
    <tbody>
      <tr>
        <td width="39"><a href="changePasswordHR.jsp"><img src="changePassword.gif" width="32" height="35" border="0"></a></td>
        <td width="355"><div align="right"><a href="ActionTrackingSystem.jsp"><img src="logout.gif"></a></div></td>
      </tr>
    </tbody>
  </table>
  </p>
<DIV 
style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px; HEIGHT: 5px ;width:200"><IMG 
style="BACKGROUND-COLOR: #d5ae65" height=5 alt="" 
src="ActionTrackingSystem_files/spacer.gif" width=404 border=0></DIV>
<DIV id=mainContent style="width: 452px; height: 400px">
<DIV id=breadCrumb style="MARGIN-TOP: 8px;width: 200px">
<TABLE cellSpacing=0 cellPadding=0>
  <TBODY>
  <TR>
    <TD><A href="https://www.brooksbrothers.com/"></A></TD>
    <TD>&nbsp;</TD>
    </TR></TBODY></TABLE>
</DIV>
<DIV id=mainContentMiddleBorder style="width:200">
<DIV id=mainBody style="width:200">
<!-- THIS PART IS FOR LINE-->
<TABLE style="WIDTH: 288px" cellSpacing=0 cellPadding=0 border=0>
  <TBODY>
  <TR vAlign=top>
    <TD id=leftContent><!-- ########### LEFT CONTENT ################# -->
      <span class="style2">Definitions:</span>
      <FORM name=LoginForm onsubmit=javascript:upperCaseUsername(); 
      action=FirstPage.jsp method=post>
	  
      <DIV class=outlineBox id=signinBox 
      style="MARGIN-TOP: 15px; TEXT-ALIGN: center">
      <TABLE cellSpacing=0 cellPadding=0 border=0>
        <TBODY>
        <TR>
          <TD style="PADDING-TOP: 0px"><IMG height=1 alt=" " 
            src="ActionTrackingSystem_files/spacer(1).gif" width=1></TD>
          <TD style="COLOR: #2a3960; PADDING-TOP: 0px"></TD></TR>
        <TR>
          <TD class="style3"><a href="DND.jsp">Define New Department </a></TD>
          <TD>&nbsp;</TD>
        </TR>
        <TR>
          <TD class="style2"><a href="DNM.jsp" class="style5">Define New Manager </a></TD>
          <TD>&nbsp;</TD>
        </TR>
        <TR>
          <TD class="style2"><a href="DNE.jsp" class="style5">Define New Employee </a></TD>
          <TD>&nbsp;</TD>
        </TR> <TR>
          <TD class="style2"><a href="RE.jsp" class="style5">ReplaceEmployee</a></TD>
          <TD>&nbsp;</TD>
        </TR>
        <TR>
          <TD class="style2"><a href="RM.jsp" class="style5">ReplaceManager</a></TD>
          <TD>&nbsp;</TD>
        </TR><TR>
          <TD class="style2"><a href="DE.jsp" class="style5">DeleteEmployee</a></TD>
          <TD>&nbsp;</TD>
        </TR>
        </TBODY></TABLE>
      </DIV></FORM><!-- ########### LEFT CONTENT ################# --></TD>
    </TR></TBODY></TABLE>
</DIV></DIV><!-- JOIN ActionTrackingSystem EMAIL LIST -->
<DIV id=joinandFooter style="MARGIN-BOTTOM: 15px"></DIV>
<!-- END OF JOIN ActionTrackingSystem EMAIL LIST -->
<span class="style6">
<jsp:useBean id="sampleMainServiceProxyid" scope="session" class="com.actionTracking.MainServiceProxy" />	
<%
String requestType=request.getParameter("requestType");
try{
if (requestType!=null){
if (requestType.equals("newDepartment")){
		String name_19id=  request.getParameter("name");
        java.lang.String name_19idTemp  = name_19id;
        String location_20id=  request.getParameter("location");
        java.lang.String location_20idTemp  = location_20id;
		String upperDepartment=request.getParameter("upperDepartment");
        String upperDepartmentName_21id= upperDepartment.substring(0, upperDepartment.indexOf('_')) ;
        java.lang.String upperDepartmentName_21idTemp  = upperDepartmentName_21id;
        String upperDepartmentLocation_22id= upperDepartment.substring(upperDepartment.indexOf('_')+1,
		upperDepartment.length());
        java.lang.String upperDepartmentLocation_22idTemp  = upperDepartmentLocation_22id;
        java.lang.String defineDepartment68mtemp = sampleMainServiceProxyid.defineDepartment(name_19idTemp,location_20idTemp,				        upperDepartmentName_21idTemp,upperDepartmentLocation_22idTemp);
		if(defineDepartment68mtemp == null){
%>
	<%=defineDepartment68mtemp %>
<%
		}else{
        String tempResultreturnp69 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(defineDepartment68mtemp));
        %>
        <%= tempResultreturnp69 %>
        <%
		}
		}else if (requestType.equals("newManager")){
			String name_23id=  request.getParameter("name");
        java.lang.String name_23idTemp  = name_23id;
        String family_24id=  request.getParameter("family");
        java.lang.String family_24idTemp  = family_24id;
        String user_25id=  request.getParameter("user");
        java.lang.String user_25idTemp  = user_25id;
        String password_26id=  request.getParameter("password");
        java.lang.String password_26idTemp  = password_26id;
		String department=request.getParameter("department");
        String department_29id=department.substring(0, department.indexOf('_'));
        java.lang.String department_29idTemp  = department_29id;
        String location_30id=  department.substring(department.indexOf('_')+1,department.length());
        java.lang.String location_30idTemp  = location_30id;
        java.lang.String defineManager79mtemp = sampleMainServiceProxyid.defineManager(name_23idTemp,family_24idTemp,user_25idTemp,	password_26idTemp,department_29idTemp,location_30idTemp);
if(defineManager79mtemp == null){
%>
<%=defineManager79mtemp %>
<%
		}else{
        String tempResultreturnp80 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(defineManager79mtemp));
        %>
        <%= tempResultreturnp80 %>
        <%
		}
}if (requestType.equals("newEmployee")){
		String name_13id=  request.getParameter("name");
        java.lang.String name_13idTemp  = name_13id;
        String family_14id=  request.getParameter("family");
        java.lang.String family_14idTemp  = family_14id;
        String user_15id=  request.getParameter("user");
        java.lang.String user_15idTemp  = user_15id;
        String password_16id=  request.getParameter("password");
        java.lang.String password_16idTemp  = password_16id;
		String department=request.getParameter("department");
        String department_17id= department.substring(0, department.indexOf('_'));
        java.lang.String department_17idTemp  = department_17id;
        String location_18id=  department.substring(department.indexOf('_')+1,department.length());
        java.lang.String location_18idTemp  = location_18id;
        java.lang.String defineEmployee53mtemp = sampleMainServiceProxyid.defineEmployee(name_13idTemp,family_14idTemp,user_15idTemp,	        password_16idTemp,department_17idTemp,location_18idTemp);
	if(defineEmployee53mtemp == null){
	%>
	<%=defineEmployee53mtemp %>
	<%
	}else{
        String tempResultreturnp54 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(defineEmployee53mtemp));
        %>
        <%= tempResultreturnp54 %>
        <%
		}
}else if (requestType.equals("replaceEmployee")){
		String user_31id=  request.getParameter("oldEmployee");
        java.lang.String user_31idTemp  = user_31id;
        String secondName_32id=  request.getParameter("name");
        java.lang.String secondName_32idTemp  = secondName_32id;
        String secondFamily_33id=  request.getParameter("family");
        java.lang.String secondFamily_33idTemp  = secondFamily_33id;
        String secondUser_34id=  request.getParameter("user");
        java.lang.String secondUser_34idTemp  = secondUser_34id;
        String secondPassword_35id=  request.getParameter("password");
        java.lang.String secondPassword_35idTemp  = secondPassword_35id;
        java.lang.String replaceEmployee98mtemp = sampleMainServiceProxyid.replaceEmployee(user_31idTemp,secondName_32idTemp, 	 	        secondFamily_33idTemp,secondUser_34idTemp,secondPassword_35idTemp);
	if(replaceEmployee98mtemp == null){
	%>
	<%=replaceEmployee98mtemp %>
	<%
    	}else{
        String tempResultreturnp99 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(replaceEmployee98mtemp));
        %>
        <%= tempResultreturnp99 %>
        <%
}
		}else
if (requestType.equals("replaceManager")){
		  String user_37id=  request.getParameter("oldEmployee");
        java.lang.String user_37idTemp  = user_37id;
        String secondName_38id=  request.getParameter("name");
        java.lang.String secondName_38idTemp  = secondName_38id;
        String secondFamily_39id=  request.getParameter("family");
        java.lang.String secondFamily_39idTemp  = secondFamily_39id;
        String secondUser_40id=  request.getParameter("user");
        java.lang.String secondUser_40idTemp  = secondUser_40id;
        String secondPassword_41id=  request.getParameter("password");
        java.lang.String secondPassword_41idTemp  = secondPassword_41id;
        java.lang.String replaceManager116mtemp = sampleMainServiceProxyid.replaceManager(user_37idTemp,secondName_38idTemp,secondFamily_39idTemp,secondUser_40idTemp,secondPassword_41idTemp);
if(replaceManager116mtemp == null){
%>
<%=replaceManager116mtemp %>
<%
}else{
        String tempResultreturnp117 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(replaceManager116mtemp));
        %>
        <%= tempResultreturnp117 %>
        <%
}
		}else if (requestType.equals("deleteEmployee")){
			String user_36id=  request.getParameter("oldEmployee");
        java.lang.String user_36idTemp  = user_36id;
        java.lang.String deleteEmployee111mtemp = sampleMainServiceProxyid.deleteEmployee(user_36idTemp);
if(deleteEmployee111mtemp == null){
%>
<%=deleteEmployee111mtemp %>
<%
}else{
        String tempResultreturnp112 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(deleteEmployee111mtemp));
        %>
        <%= tempResultreturnp112 %>
        <%
}
		}
if (requestType.equals("changePassword")){
        String user_160id=  (String)session.getAttribute("USER");
        java.lang.String user_160idTemp  = user_160id;
        String oldPassword_161id=  request.getParameter("oldPassword");
        java.lang.String oldPassword_161idTemp  = oldPassword_161id;
        String type_162id= (String)session.getAttribute("TYPE");
        java.lang.String type_162idTemp  = type_162id;
        String newPassword_163id=  request.getParameter("password");
        java.lang.String newPassword_163idTemp  = newPassword_163id;
        java.lang.String changePassowrd566mtemp = sampleMainServiceProxyid.changePassowrd(user_160idTemp,oldPassword_161idTemp,type_162idTemp,newPassword_163idTemp);
if(changePassowrd566mtemp == null){
%>
<%=changePassowrd566mtemp %>
<%
}else{
        String tempResultreturnp567 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(changePassowrd566mtemp));
        %>
        <%= tempResultreturnp567 %>
        <%
}
}
}
	}catch(Exception e){
	out.print(e);
	}
%>
</span></DIV>
</DIV>
</CENTER><!-- HitBox Enterprise by Mulenga-->
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
<!--END WEBSIDESTORY CODE--><!-- END HitBox Enterprise --></BODY></HTML>
