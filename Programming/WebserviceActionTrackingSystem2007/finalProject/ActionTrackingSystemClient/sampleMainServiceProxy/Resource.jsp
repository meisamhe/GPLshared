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
<DIV id=mainContentBorder align=center style="width: 718px; height: 568px">
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
<DIV id=mainContent style="width: 707px; height: 520px">
<DIV id=breadCrumb style="MARGIN-TOP: 8px;width: 257px; height:18px">
<TABLE cellSpacing=0 cellPadding=0>
  <TBODY>
  <TR>
  <td></td>
    <TD><A href="https://www.brooksbrothers.com/"></A></TD>
    <TD>&nbsp;</TD>
    </TR></TBODY></TABLE>
</DIV>
<DIV id=mainContentMiddleBorder style="width:592px; height:462px">
<DIV id=mainBody style="width:494px; height:412px">
<!-- THIS PART IS FOR LINE-->
<TABLE style="WIDTH: 287px" cellSpacing=0 cellPadding=0 border=0>
  <TBODY>
  <TR vAlign=top>
    <TD id=leftContent width="563"><!-- ########### LEFT CONTENT ################# -->
      <span class="sectionCold">Resource</span>
      
	  
      <DIV class=outlineBox id=signinBox 
      style="MARGIN-TOP: 15px; TEXT-ALIGN: center;width:524px; height:341px" >       <p>
	  <jsp:useBean id="sampleMainServiceProxyid" scope="session" class="com.actionTracking.MainServiceProxy" />
	  <% 		 try{
	  String activityIdStr="";
	  long activityID =0;
	  	 String person="";
		 String user="";
		 String type="";
		 String requestType="";
		 int listLength=0;
 if(request.getParameter("person")!=null){	  
	  activityIdStr=request.getParameter("activityID");
	  activityID = Long.parseLong(activityIdStr);
	  person=request.getParameter("person");
	  user=person.substring(0, person.indexOf('_'));
	  type=person.substring(person.indexOf('_')+1,person.length());
	  requestType=request.getParameter("requestType");
	  listLength=0;
}else if(request.getParameter("requestType").equals("addResource")){
		 
	  activityIdStr=(String)session.getAttribute("TEMPACTIVITYID");
	  activityID = Long.parseLong(activityIdStr);
	  person=(String)session.getAttribute("TEMPPERSON");
	  user=person.substring(0, person.indexOf('_'));
	  type=person.substring(person.indexOf('_')+1,person.length());
	        String activityID_63id=  activityIdStr;
        long activityID_63idTemp  = Long.parseLong(activityID_63id);
        String type_64id= type;
        java.lang.String type_64idTemp  = type_64id;
		
		String resource=(String)request.getParameter("resource");
        String resourceName_65id=  resource.substring(0, resource.indexOf('_'));
        java.lang.String resourceName_65idTemp  = resourceName_65id;
        String resourcePlace_66id=  resource.substring(resource.indexOf('_')+1,resource.length());
        java.lang.String resourcePlace_66idTemp  = resourcePlace_66id;
        String resourceQuantity_67id=  request.getParameter("quantity");
        long resourceQuantity_67idTemp  = Long.parseLong(resourceQuantity_67id);
        String assignedUser_68id= user;
        java.lang.String assignedUser_68idTemp  = assignedUser_68id;
        java.lang.String addResourceToActivity183mtemp = sampleMainServiceProxyid.addResourceToActivity(activityID_63idTemp,type_64idTemp,resourceName_65idTemp,resourcePlace_66idTemp,resourceQuantity_67idTemp,assignedUser_68idTemp);
if(addResourceToActivity183mtemp == null){
%>
<%=addResourceToActivity183mtemp %>
<%
}else{
        String tempResultreturnp184 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(addResourceToActivity183mtemp));
        %>
        <%= tempResultreturnp184 %>
        <%
}
		%>
        <%

	 }else if (request.getParameter("requestType").equals("changeResource")){
		activityIdStr=(String)session.getAttribute("TEMPACTIVITYID");
		activityID = Long.parseLong(activityIdStr);
		person=(String)session.getAttribute("TEMPPERSON");
		user=person.substring(0, person.indexOf('_'));
		type=person.substring(person.indexOf('_')+1,person.length());	
		String activityID_78id=  activityIdStr;
        long activityID_78idTemp  = Long.parseLong(activityID_78id);
        String type_79id=  type;
        java.lang.String type_79idTemp  = type_79id;	
        String resourceName_80id=  request.getParameter("name");
        java.lang.String resourceName_80idTemp  = resourceName_80id;
        String resourcePlace_81id=  request.getParameter("place");
        java.lang.String resourcePlace_81idTemp  = resourcePlace_81id;
        String resourceQuantity_82id=  request.getParameter("newQuantity");
        long resourceQuantity_82idTemp  = Long.parseLong(resourceQuantity_82id);
        String assignedUser_83id=  user;
        java.lang.String assignedUser_83idTemp  = assignedUser_83id;
        java.lang.String changeResourceQuantityOfActivity222mtemp = sampleMainServiceProxyid.changeResourceQuantityOfActivity(activityID_78idTemp,type_79idTemp,resourceName_80idTemp,resourcePlace_81idTemp,resourceQuantity_82idTemp,assignedUser_83idTemp);
if(changeResourceQuantityOfActivity222mtemp == null){
%>
<%=changeResourceQuantityOfActivity222mtemp %>
<%
}else{
        String tempResultreturnp223 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(changeResourceQuantityOfActivity222mtemp));
        %>
        <%= tempResultreturnp223 %>
        <%
}
	 }
		 
%>
		  <p align="left" class="style2">activity Resource: </p>
		<TABLE cellSpacing=0 cellPadding=0 border=0>
        <TBODY>
        <TR>
          <TD style="PADDING-TOP: 0px"><IMG height=1 alt=" " 
            src="ActionTrackingSystem_files/spacer(1).gif" width=1></TD>
          <TD style="COLOR: #2a3960; PADDING-TOP: 0px"></TD></TR></TBODY></TABLE>
     <TABLE width="456" height="82" border=1 cellPadding=0 cellSpacing=0 bordercolorlight="#FFFFFF">
        <TBODY>
          <TR>
            <TD width="178" height="24" class="style2">
			<p style="text-align: center">Name</TD>
            <TD width="162">
			<p style="text-align: center"><span class="style2">Place</span></TD>
            <TD width="45"><p style="text-align: center"><span class="style2">Quantity</span></TD>
            <TD width="61" class="style2">Submit</TD>
            </TR>
		  
		  <%
		 String user_127id=  user;
        java.lang.String user_127idTemp  = user_127id;
        String type_128id= type;
        java.lang.String type_128idTemp  = type_128id;
        com.actionTracking.Resource[] viewResourceOfActivity425mtemp = sampleMainServiceProxyid.viewResourceOfActivity(user_127idTemp,type_128idTemp,activityID);

java.util.List listreturnp405;
if(viewResourceOfActivity425mtemp == null){
listreturnp405=null;

}else{
        listreturnp405= java.util.Arrays.asList(viewResourceOfActivity425mtemp);
}
if (listreturnp405!=null){
listLength=listreturnp405.size();
try{
for(int i=0; i<listreturnp405.size();i++){
	com.actionTracking.Resource resource = (com.actionTracking.Resource)listreturnp405.get(i);
		  %>
          <tr><%
if (request.getParameter("person")!=null){
session.setAttribute("TEMPPERSON",request.getParameter("person"));
session.setAttribute("TEMPACTIVITYID",request.getParameter("activityID"));
}
%>       <FORM name=changeResource action=Resource.jsp method=post >     <TD height="56" class="style2"><div align="center"><%=resource.getName()%></div></TD>
            <TD style="text-align: center"><%=resource.getPlace()%>
            <TD style="text-align: center"><input typ="text" size=1 name="place" value="<%=resource.getPlace()%>" style="visibility:hidden">
              <input type="text" size=2 value="<%=resource.getQuantity()%>" name=newQuantity>
              <span class="style2">
              <input typ="text" size=1 name="name" value="<%=resource.getName()%>" style="visibility:hidden">
              </span>
            <TD style="text-align: center"> <input typ="text" size=1 name="requestType" value="changeResource" style="visibility:hidden">
              <input name="submit" type="submit" value="change" size=2  >       </form>     </tr>
		<%}
		}catch(Exception e){
			out.print("<td>"+e+"</td>");
		}
		}
		%>
         
        </TBODY>
      </TABLE> 
      <p>&nbsp;</p>
      <p align="left" class="style2">Add New Resource:
      <p align="left" class="style2">
      
      <div align="center"></div>
      <TABLE width="456" height="44" border=1 cellPadding=0 cellSpacing=0 bordercolorlight="#FFFFFF"> 
        <tr>
		  <FORM name=addResource  
      action=Resource.jsp method=post >
            <TD height="42"><p><span class="style2">Resources:</span>
                <select name=resource width=80>
			<%try{
        com.actionTracking.Resource[] viewResourceOfOrganization424mtemp = sampleMainServiceProxyid.viewResourceOfOrganization();
if(viewResourceOfOrganization424mtemp == null){
%>
<%=viewResourceOfOrganization424mtemp %>
<%
}else{
        java.util.List listreturnp425= java.util.Arrays.asList(viewResourceOfOrganization424mtemp);
        
		for (int i=0; i<listreturnp425.size();i++){
			com.actionTracking.Resource p=(com.actionTracking.Resource)listreturnp425.get(i);
		%>
              <option value="<%=p.getName()+"_"+p.getPlace()%>">
			  <%=p.getName()+"_"+
			 p.getPlace()+"("+p.getQuantity()+")"%></option>
              <%	}
	}
%>
          </select>
	<%	  }catch(Exception e){
out.print(e);
e.printStackTrace();
}
		%>
            </p>              </TD>
            <TD><p style="text-align: center"><span class="style2">Quantitiy:</span> 
                <input type="text" size=2 value="0" name=quantity><IMG height=1 alt=" " 
            src="ActionTrackingSystem_files/spacer(1).gif" width=1>
<!--input type=text name=requestType size=1 style="visibility:hidden" value="addReport"-->
<!--input type="text" name=person size=1 style="visibility:hidden" value="<%//=request.getParameter("person")%>"-->
<!--input type="text" name=activityID size=1 style="visibility:hidden" value="<%//=request.getParameter("activityID")%>"-->
</TD>

            <TD colspan="2"><div align="center">
                <input typ="text" size=1 name="requestType" value="addResource" style="visibility:hidden"><INPUT style="MARGIN: 0px 0px 10px; WIDTH: 67px; HEIGHT: 18px" 
            type=image 
            src="ActionTrackingSystem_files/button-submit.gif" 
            name=PlaceOrder VALUE="Send File">
              </div>
                <DIV><A 
           ></A></DIV></TD>
            </FORM>
          </tr></table></p>
      </DIV><!-- ########### LEFT CONTENT ################# --></TD>
    <td></td></TR></TBODY></TABLE>
<p style="text-align: center">
</DIV>
<p style="text-align: center">
 &nbsp;&nbsp;&nbsp;&nbsp;

</p>

</DIV><!-- JOIN ActionTrackingSystem EMAIL LIST -->
<DIV id=joinandFooter style="MARGIN-BOTTOM: 15px"></DIV><!-- END OF JOIN ActionTrackingSystem EMAIL LIST -->
</DIV>
</DIV>
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
</BODY></HTML>