<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML><HEAD><TITLE>ActionTrackingSystem | Sign-In</TITLE>

<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page contentType="text/html;charset=utf-8" %>
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
<% if (session.getAttribute("TYPE") == null )
    response.sendRedirect("ActionTrackingSystem.jsp");
	else if (((String)session.getAttribute("TYPE")).compareTo("manager")!=0 &&((String)session.getAttribute("TYPE")).compareTo("employee")!=0)
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
<DIV id=mainContentMiddleBorder style="width:517px; height:462px">
<DIV id=mainBody style="width:494px; height:412px">
<!-- THIS PART IS FOR LINE-->
<TABLE style="WIDTH: 287px" cellSpacing=0 cellPadding=0 border=0>
  <TBODY>
  <TR vAlign=top>
    <TD id=leftContent width="266"><!-- ########### LEFT CONTENT ################# -->
      <span class="sectionCold">Result:</span>
	  <jsp:useBean id="sampleMainServiceProxyid" scope="session" class="com.actionTracking.MainServiceProxy" />
	  
      <DIV class=outlineBox id=signinBox 
      style="MARGIN-TOP: 15px; TEXT-ALIGN: center;width:445px; height:345px" >       <p><%
	  String personType=(String)session.getAttribute("TYPE");
	 if (personType.equals("manager")){
 	String requestType=(String)request.getParameter("requestType");
	if (requestType.equals("defineActivity")){
	  try{
	  Date d = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		java.util.Date date = new java.util.Date();
		String tempDate=dateFormat.format(date);
		String iMiladiYear_160id=  tempDate.subSequence(0, 4)+"";
        int iMiladiYear_160idTemp  = Integer.parseInt(iMiladiYear_160id);
        String iMiladiMonth_161id=  tempDate.subSequence(4, 6)+"";
        int iMiladiMonth_161idTemp  = Integer.parseInt(iMiladiMonth_161id);
        String iMiladiDay_162id=  tempDate.subSequence(6, 8)+"";
        int iMiladiDay_162idTemp  = Integer.parseInt(iMiladiDay_162id);
		com.actionTracking.ShamsiDate miladiToShamsi480mtemp = sampleMainServiceProxyid.miladiToShamsi(iMiladiYear_160idTemp,iMiladiMonth_161idTemp,iMiladiDay_162idTemp);	
        tempDate=Integer.toString(miladiToShamsi480mtemp.getIYear()*10000+
		miladiToShamsi480mtemp.getIMonth()*100+
		miladiToShamsi480mtemp.getIDay() ) ;	
		String name_42id=  request.getParameter("name");
        java.lang.String name_42idTemp  = name_42id;
        String description_43id=  request.getParameter("description");
        java.lang.String description_43idTemp  = description_43id;
		String deadline= request.getParameter("deadline");
        String deadline_44id= deadline.substring(0,4)+deadline.substring(5,7)+deadline.substring(8,10);
        long deadline_44idTemp  = Long.parseLong(deadline_44id);
        String initializedDate_45id=  tempDate;
        long initializedDate_45idTemp  = Long.parseLong(initializedDate_45id);
		String employee=(String) request.getParameter("employee");
        String personUser_46id= employee.substring(0, employee.indexOf('@'));
        java.lang.String personUser_46idTemp  = personUser_46id;
        String personType_47id=  employee.substring(employee.indexOf('@')+1,employee.length());
        java.lang.String personType_47idTemp  = personType_47id;
        String assignedByUser_48id=  (String) session.getAttribute("USER");
        java.lang.String assignedByUser_48idTemp  = assignedByUser_48id;
        String upperActivityID_49id=  request.getParameter("pActivity");
        long upperActivityID_49idTemp  = Long.parseLong(upperActivityID_49id);
        java.lang.String defineActivity129mtemp = sampleMainServiceProxyid.defineActivity(name_42idTemp,description_43idTemp,deadline_44idTemp,initializedDate_45idTemp,personUser_46idTemp,personType_47idTemp,assignedByUser_48idTemp,upperActivityID_49idTemp);
		
	//	out.print(name_42idTemp+" "+description_43idTemp+" "+deadline_44idTemp+" "+initializedDate_45idTemp+" "+personUser_46idTemp+" "+personType_47idTemp+" "+assignedByUser_48idTemp+" "+upperActivityName_49idTemp);
if(defineActivity129mtemp == null){
%>
<%=defineActivity129mtemp %>
<%
}else{
        String tempResultreturnp130 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(defineActivity129mtemp));
        %>
        <%= tempResultreturnp130 %>
        <%
}
}catch(Exception e){
	out.print(e);
}
}
}
 %>
 <%
 try{
 if (personType.equals("employee") || personType.equals("manager") ){
 	String requestType=(String)request.getParameter("requestType");
	if (requestType.equals("updateState")){
	int i=0;
	while (request.getParameter("state"+i)==null)
			i++;
		 String activityID_1id=  request.getParameter("activityID"+i);
        long activityID_1idTemp  = Long.parseLong(activityID_1id);
        String personType_2id=  (String)session.getAttribute("TYPE");
        java.lang.String personType_2idTemp  = personType_2id;
        String state_3id=  request.getParameter("state"+i);
        long state_3idTemp  = Long.parseLong(state_3id);
        String personUser_4id=  (String)session.getAttribute("USER");
		Date d = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		java.util.Date date = new java.util.Date();
		String tempDate=dateFormat.format(date);
		String iMiladiYear_160id=  tempDate.subSequence(0, 4)+"";
        int iMiladiYear_160idTemp  = Integer.parseInt(iMiladiYear_160id);
        String iMiladiMonth_161id=  tempDate.subSequence(4, 6)+"";
        int iMiladiMonth_161idTemp  = Integer.parseInt(iMiladiMonth_161id);
        String iMiladiDay_162id=  tempDate.subSequence(6, 8)+"";
        int iMiladiDay_162idTemp  = Integer.parseInt(iMiladiDay_162id);
		com.actionTracking.ShamsiDate miladiToShamsi480mtemp = sampleMainServiceProxyid.miladiToShamsi(iMiladiYear_160idTemp,iMiladiMonth_161idTemp,iMiladiDay_162idTemp);	
        tempDate=Integer.toString(miladiToShamsi480mtemp.getIYear()*10000+
		miladiToShamsi480mtemp.getIMonth()*100+
		miladiToShamsi480mtemp.getIDay() ) ;	
		
        java.lang.String personUser_4idTemp  = personUser_4id;
        String date_5id= tempDate;
        long date_5idTemp  = Long.parseLong(date_5id);
		java.lang.String changeState20mtemp = sampleMainServiceProxyid.changeState(activityID_1idTemp,personType_2idTemp,state_3idTemp,personUser_4idTemp,date_5idTemp);
		if(changeState20mtemp == null){
		%>
		<%=changeState20mtemp %>
		<%
		}else{
        String tempResultreturnp21 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(changeState20mtemp));
        %>
        <%= tempResultreturnp21 %>
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
//extend deadline or reassign activity
if (requestType.equals("updateActivityManager")){
	int i=0;
	while (request.getParameter("deadLine"+i)==null && request.getParameter("assignTo"+i)==null)
			i++;
		long activityID_1id=  Long.parseLong(request.getParameter("activityID"+i));

		Date d = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		java.util.Date date = new java.util.Date();
		String tempDate=dateFormat.format(date);
		String iMiladiYear_160id=  tempDate.subSequence(0, 4)+"";
        int iMiladiYear_160idTemp  = Integer.parseInt(iMiladiYear_160id);
        String iMiladiMonth_161id=  tempDate.subSequence(4, 6)+"";
        int iMiladiMonth_161idTemp  = Integer.parseInt(iMiladiMonth_161id);
        String iMiladiDay_162id=  tempDate.subSequence(6, 8)+"";
        int iMiladiDay_162idTemp  = Integer.parseInt(iMiladiDay_162id);
		com.actionTracking.ShamsiDate miladiToShamsi480mtemp = sampleMainServiceProxyid.miladiToShamsi(iMiladiYear_160idTemp,iMiladiMonth_161idTemp,iMiladiDay_162idTemp);	
        tempDate=Integer.toString(miladiToShamsi480mtemp.getIYear()*10000+
		miladiToShamsi480mtemp.getIMonth()*100+
		miladiToShamsi480mtemp.getIDay() ) ;	
		
        java.lang.String personUser_4idTemp  =  (String)session.getAttribute("USER");
        String date_5id= tempDate;
        long date_5idTemp  = Long.parseLong(date_5id);
		java.lang.String changeState20mtemp ;
if (request.getParameter("assignedTo"+i).equals(request.getParameter("assignedPerson"+i))){
		long activityID_52id=  activityID_1id;
        long activityID_52idTemp  = activityID_52id;
		String assignedPerson=request.getParameter("assignedPerson"+i);
        String type_53id=  assignedPerson.substring(assignedPerson.indexOf('_')+1,assignedPerson.length());
        java.lang.String type_53idTemp  = type_53id;
		String deadline= request.getParameter("deadLine"+i);
        String deadline_54id=  deadline.substring(0,4)+deadline.substring(5,7)+deadline.substring(8,10);
        long deadline_54idTemp  = Long.parseLong(deadline_54id);
        String assignedUser_55id=  assignedPerson.substring(0, assignedPerson.indexOf('_'));
        java.lang.String assignedUser_55idTemp  = assignedUser_55id;
        String date_56id=  tempDate;
        long date_56idTemp  = Long.parseLong(date_56id);
        String changerUser_57id=  (String)session.getAttribute("USER");
        java.lang.String changerUser_57idTemp  = changerUser_57id;
        changeState20mtemp = sampleMainServiceProxyid.extendDeadline(activityID_52idTemp,type_53idTemp,deadline_54idTemp,assignedUser_55idTemp,date_56idTemp,changerUser_57idTemp);
		out.print("Deadline Extension done Successfuly");

		}else{
		 long activityID_6id= activityID_1id;
        long activityID_6idTemp  = activityID_6id;
        String changerUser_7id=  (String)session.getAttribute("USER");
        java.lang.String changerUser_7idTemp  = changerUser_7id;
		String assignedPerson=request.getParameter("assignedPerson"+i);
        String firstPersonUser_8id=   assignedPerson.substring(0, assignedPerson.indexOf('_'));
        java.lang.String firstPersonUser_8idTemp  = firstPersonUser_8id;
        String firstPersonType_9id= assignedPerson.substring(assignedPerson.indexOf('_')+1,assignedPerson.length());
        java.lang.String firstPersonType_9idTemp  = firstPersonType_9id;
		String secondPerson=request.getParameter("assignedTo"+i);
        String secondPersonUser_10id=  secondPerson.substring(0, secondPerson.indexOf('_'));
        java.lang.String secondPersonUser_10idTemp  = secondPersonUser_10id;
        String secondPersonType_11id=  secondPerson.substring(secondPerson.indexOf('_')+1,secondPerson.length());
        java.lang.String secondPersonType_11idTemp  = secondPersonType_11id;
        String date_12id=  tempDate;
        long date_12idTemp  = Long.parseLong(date_12id);
        changeState20mtemp = sampleMainServiceProxyid.reassign(activityID_6idTemp,changerUser_7idTemp,firstPersonUser_8idTemp,firstPersonType_9idTemp,secondPersonUser_10idTemp,secondPersonType_11idTemp,date_12idTemp);
		out.print("reAssignment Done successfuly");
	}
}
 }	
 }catch(Exception e){
 	out.print(e);
 }
 %>
        <TABLE cellSpacing=0 cellPadding=0 border=0>
        <TBODY>
        <TR>
          <TD style="PADDING-TOP: 0px"><IMG height=1 alt=" " 
            src="ActionTrackingSystem_files/spacer(1).gif" width=1></TD>
          <TD style="COLOR: #2a3960; PADDING-TOP: 0px"></TD></TR></TBODY></TABLE>
      </DIV>
      </FORM><!-- ########### LEFT CONTENT ################# --></TD>
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

<Script Language="JavaScript">
addCalendar("calFirstDate", "Select Date", "deadline", "");
</script>
</BODY></HTML>