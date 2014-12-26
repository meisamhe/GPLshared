
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">

<HTML><HEAD><TITLE>ActionTrackingSystem | Sign-In</TITLE>
<script src="sortable.js"></script>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page contentType="text/html;charset=utf-8" %> 

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
.style4 {font-size: 12px}
.style5 {font-size: 14px}
.style6 {
	color: #FFFFFF;
	font-size: 14px;
}
.style7 {font-size: 24px}
.style10 {font-size: 18px}
.style11 {font-size: 16px}
</STYLE>

<META content="MSHTML 6.00.6000.16544" name=GENERATOR></HEAD>
<Script Language="JavaScript" Src="dateScript.js"></Script>
<Script Language="JavaScript" Src="persianPopupCalendar.js"></Script>
<Script Language="JavaScript" Src="specialDates.js"></Script>

<Script Language="JavaScript">
function getClickedElement(evt) {
	evt = evt || window.event;
	var obj = evt.target || evt.srcElement;
	return obj.nodeName;
}

function bodyClick(evt) {
	var nodeName = getClickedElement(evt);
	
	if ((nodeName != 'IMG') && (nodeName != 'A'))
		hideAllCalendars();
}
</Script>
<BODY onload=setupPage()>
<jsp:useBean id="sampleMainServiceProxyid" scope="session" class="com.actionTracking.MainServiceProxy" />
<span style="text-align: center">
<% if (session.getAttribute("TYPE") == null )
    response.sendRedirect("ActionTrackingSystem.jsp");
	else if (((String)session.getAttribute("TYPE")).compareTo("manager")!=0&& ((String)session.getAttribute("TYPE")).compareTo("employee")!=0)
	response.sendRedirect("ActionTrackingSystem.jsp");
	int listLength=0;
	%>
</span><a href="ActionTrackingsystem.jsp" name=&amp;lid=Logo>
<Table><tr><td><img 
height=46 alt="ActionTrackingSystem" 
src="ActionTrackingSystem_files/logo.gif" width=356 
border=0></td><td>

</td></tr>
</Table>
</a><A name=top></A>
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
	PADDING-RIGHT: 100px; PADDING-LEFT: 100px; PADDING-BOTTOM: 10px; MARGIN: 0px; OVERFLOW: hidden; WIDTH: 716px; PADDING-TOP: 10px; HEIGHT: 10px
}
#mainnavLrg UL {
	PADDING-RIGHT: 100px; PADDING-LEFT: 100px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px; LIST-STYLE-TYPE: none
}
#mainnavLrg LI {
	PADDING-RIGHT: 100px; PADDING-LEFT: 100px; FLOAT: left; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px
}
#mainnavLrg A {
	PADDING-RIGHT: 100px; PADDING-LEFT: 100px; FLOAT: left; PADDING-BOTTOM: 0px; OVERFLOW: hidden; TEXT-TRANSFORM: uppercase; COLOR: #fff; PADDING-TOP: 10px; HEIGHT: 0px! important; TEXT-DECORATION: none
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
<DIV id=topNavLrg style="width:1000">
<DIV id=bbLogo style="width:1000"><a href="ActionTrackingsystem.jsp" name=&amp;lid=Logo></a></DIV>
<DIV id=topNav>
<DIV id=topNavBanner style="WIDTH: 265px; TEXT-ALIGN: center"><A 
onclick="centerPopUp(this.href, 'home', 400, 400, 'auto'); return false;" 
href="https://www.brooksbrothers.com/content/home/compshipping_winter07.html" 
name=&amp;lid=TopNav_Shipping_Caveats_11222007></A></DIV>
<DIV id=topNavSearch style="WIDTH: 227px; TEXT-ALIGN: right"><A 
href="ActionTrackingSystem.jsp"></A>&nbsp;&nbsp;&nbsp;<BR>
<TABLE style="PADDING-TOP: 10px" cellSpacing=0 cellPadding=0 align=right 
border=0>
  <TBODY>
  <TR vAlign=top>
    <FORM 
    style="PADDING-RIGHT: 0px; MARGIN-TOP: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px" 
    name=SearchForm onSubmit="return addQuot()" 
    action=ActionTrackingSystem.jsp target=_top 
    encType=x-www-form-encoded><INPUT type=hidden value=0 name=items> 
    <TD vAlign=top>&nbsp;</TD>
    <TD vAlign=top>&nbsp;</TD>
    <TD vAlign=top>&nbsp;</TD>
    </FORM></TR></TBODY></TABLE></DIV></DIV><BR 
style="CLEAR: both; LINE-HEIGHT: 0; HEIGHT: 0px"></DIV>
<DIV id=mainContentBorder align=center  style="width:1033px; height:496px">
  <TABLE cellSpacing=0 cellPadding=0>
    <TBODY>
      <TR>
        <TD width="37"><a href="SecondPage.jsp"><img src="home1.gif" name="home" width="30" height="34" border="0"></a></TD>
		<TD width="39" name="latestCompleted"><a href="latestCompleted.jsp"><img src="latestCompleted.jpg" width="31" height="32" border="0"></a></TD>
        <TD width="31"><span class="currentPage"><a href="DA.jsp"><img src="new1.gif" name="newActivity" width="30" height="34" border="0"></a></span></TD>
        <TD width="32" name="All Employee Activity view "><a href="EA.jsp"><img src="employees2.gif" width="32" height="36" border="0"></a></TD>
        <TD width="40" name="Special Employee Activity View"><a href="SE.jsp"><img src="employee1.gif" width="40" height="40" border="0"></a> </TD>
      <TD width="31" name="change Password">
	  <a href="changePassword.jsp"><img src="changePassword.gif" width="32" height="35" border="0"></a></TD>
	    <TD width="782" name="Log Page View"><a href="Log.jsp"><img src="log.gif" width="39" height="41" border="0"></a></TD>
        <TD width="39"><A 
href="ActionTrackingSystem.jsp"><img src="logout.gif"></A> </TD>
      </TR>
    </TBODY>
  </TABLE>
  <DIV 
style="PADDING-RIGHT: 200px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px; HEIGHT: 39px; width:1179px">
	<IMG 
style="BACKGROUND-COLOR: #d5ae65" height=5 alt="" 
src="ActionTrackingSystem_files/spacer.gif" width=868 border=0 align="left"><p></DIV>
<DIV id=mainContent style="width:1000px; height:328px">
  <DIV id=mainContentMiddleBorder style="width:924px; height:356px">
<DIV id=mainBody>
<%try{%>
<TABLE width="812" height="329" border=0 cellPadding=0 cellSpacing=0 style="WIDTH: 668px">
  <TBODY>
  <TR vAlign=top>
    <TD 
      id=rightContent><!-- ########### RIGHT CONTENT ################# -->
      <DIV style="MARGIN: 15px 0px">
        <p>	</p>
		  <% if (true){%>
		<p><span class="affHeadline style7">Activities That are Not Completed Until Today and passed Deadline:</span> </p>
      </DIV>
	  <table width="815" height="87" border=1 cellpadding=3 cellspacing=0 class="sortable"  id=sections >
        <tbody>
          <tr bgcolor="#999999" class="affHeadline">
            <td width="21"  align="LEFT" bgcolor="#FFFF99" ></td>
            <td width="71"  align="LEFT" bgcolor="#FFFF99" ><div align="center"><span class="style4">ActivityTitle</span></div></td>
            <td width="81"  align="LEFT" bgcolor="#FFFF99"><div align="center"><span class="style4">Progress(%)</span></div></td>
            <td width="73"  align="LEFT" bgcolor="#FFFF99"><div align="center"><span class="style4">Deadline</span></div></td>
            <td width="79"  align="LEFT" bgcolor="#FFFF99" ><div align="center"><span class="style4">InitializedDate</span></div></td>
            <td width="71"  align="LEFT" bgcolor="#FFFF99"><div align="center"><span class="style4">LastUpdate</span></div></td>
            <td width="58"  align="LEFT" bgcolor="#FFFF99">Submit</td>
            <td width="65"  align="LEFT" bgcolor="#FFFF99"><span class="style4">Description</span></td>
            <td width="37"  align="LEFT" bgcolor="#FFFF99">Report</td>
            <td width="53"  align="LEFT" bgcolor="#FFFF99">Resource</td>
            <td width="69"  align="LEFT" bgcolor="#FFFF99">AssignedBy</td>
          </tr>
		  
          <%
		  Date d = new Date();
DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
java.util.Date date = new java.util.Date();
com.actionTracking.Activity[] uncompletedActivityUntilDate;
/*if (type_159id.compareTo("manager")==0){
        String date_107id=  dateFormat.format(date);
        long date_107idTemp  = Long.parseLong(date_107id);
        String user_108id=  (String)session.getAttribute("USER");
        java.lang.String user_108idTemp  = user_108id;
        uncompletedActivityUntilDate = sampleMainServiceProxyid.uncompletedActivityUntilDateOfsubsidary(date_107idTemp,user_108idTemp);
}else{
	    String type_101id=  type_159id;
        java.lang.String type_101idTemp  = type_101id;
        String date_102id=  dateFormat.format(date);
        long date_102idTemp  = Long.parseLong(date_102id);
        String user_103id=(String)  session .getAttribute("USER");
        java.lang.String user_103idTemp  = user_103id;
        uncompletedActivityUntilDate = sampleMainServiceProxyid.uncompletedActivityUntilDateOfSpecialPerson(type_101idTemp,date_102idTemp,user_103idTemp);
}*/

 String type_101id= (String) session.getAttribute("TYPE");
        java.lang.String type_101idTemp  = type_101id;
		String tempDate=dateFormat.format(date);

		String iMiladiYear_160id=  tempDate.subSequence(0, 4)+"";
        int iMiladiYear_160idTemp  = Integer.parseInt(iMiladiYear_160id);
        String iMiladiMonth_161id=  tempDate.subSequence(4, 6)+"";
        int iMiladiMonth_161idTemp  = Integer.parseInt(iMiladiMonth_161id);
        String iMiladiDay_162id=  tempDate.subSequence(6, 8)+"";
        int iMiladiDay_162idTemp  = Integer.parseInt(iMiladiDay_162id);
        com.actionTracking.ShamsiDate miladiToShamsi480mtemp = sampleMainServiceProxyid.miladiToShamsi(iMiladiYear_160idTemp,iMiladiMonth_161idTemp,iMiladiDay_162idTemp);
		
        String date_102id=Integer.toString(miladiToShamsi480mtemp.getIYear()*10000+
		miladiToShamsi480mtemp.getIMonth()*100+
		miladiToShamsi480mtemp.getIDay() ) ;
        long date_102idTemp  = Long.parseLong(date_102id);
        String user_103id=(String)  session .getAttribute("USER");
        java.lang.String user_103idTemp  = user_103id;
        uncompletedActivityUntilDate = sampleMainServiceProxyid.uncompletedActivityUntilDateOfSpecialPerson(type_101idTemp,date_102idTemp,user_103idTemp);
%>
          <%
java.util.List listreturnp279;
if(uncompletedActivityUntilDate == null){
	listreturnp279=null;
}else{
    listreturnp279= java.util.Arrays.asList(uncompletedActivityUntilDate);
}
if (listreturnp279!=null){
listLength=listreturnp279.size();

for(int i=0; i<listreturnp279.size();i++){
	com.actionTracking.Activity activity = (com.actionTracking.Activity)listreturnp279.get(i);	
%>
          <tr>
                <%
if(activity != null){
java.lang.String typename292 = activity.getName();
        String tempResultname292 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(typename292));
        %>
		 <td bgcolor="#FFFFFF" class="border" ><img src="attention_red.png" hight=20 width=20></td>
            <td bgcolor="#0066CC" class="border" ><p align="center" class="style6 style4 style4 style5">
              
				 <%= tempResultname292 %>  
				 <FORM name=changeState
      action=submitActivity.jsp method=post> 
              <input type="text" value="<%=activity.getActivityId()%>" width="33" size="1" name=activityID<%=i%> style="visibility:hidden">
                <%
}%>
            </p></td>
            <td class="border" ><div align="center" class="style5">
                <%
if(activity != null){

        %><table width="42" height="1">
                  <tr><td width="34">
			        <input type="text" value="<%=activity.getState()%>" width="33" size="2" name=state<%=i%>>
			</td></tr>
           </table>
                <%
}%>
            </div></td>
            <td class="border"><div align="center" class="style5">
               <%
if(activity != null){
	long l=activity.getDeadline();
	String s=l/10000+"/"+(l%10000)/100+
	"/"+(l%100);
%><table><tr><td>
          <font size="6">
          <%=s%>
                <%}%>
                </font>
                </td><td>
				<a href="javascript:void(0)" onClick="showCal('calDate<%=i%>'); return false;" hidefocus>
				<font size="6">
				<img name="popcal" width="18" height="20" len="absmiddle" src="calender.jpg" border="0" alt="Select Date"></font></a><font size="6">
				</font></td></tr></table><font size="6">&nbsp;
                 <input type=text name=deadLine<%=i%> style="visibility:hidden" size=1></font></div>			</td>
            <td class="border" ><div align="center" class="style5">
                <%
if(activity != null){
	long l=activity.getInitializedDate();
	String s=l/10000+"/"+(l%10000)/100+
	"/"+(l%100);
%>
             <table><tr><td></td>  <%=s
%><td></td></tr></table> 
                <%}%>
            </div></td>
            <td class="border" ><div align="center" class="style5">
                <%
if(activity != null){
	long l=activity.getLastUpdate();
	String s=l/10000+"/"+(l%10000)/100+
	"/"+(l%100);
%>
                <%=s
%>
                <%}%>
            </div></td>
            <td  >
			 <input type=text style="visibility:hidden" size=1 value="updateState" name=requestType> 
			<input name=button type="submit" title="applyChange" value="change">&nbsp; &nbsp;
			  </form>
			</td>
            <td class="border style5" ><%
if(activity != null){
java.lang.String typedescription298 = activity.getDescription();
        String tempResultdescription298 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(typedescription298));
        %>
                <div align="center">
                  <form method="post" action="Description.jsp" target="_blank">
                    <div id="div" style="display: none;">
                      <input type="text" name=description value="<%=tempResultdescription298%>">
                    </div>
                    <input type="image" name=popcal width="36" height="24"  src="discription.gif" border="0" >
                  </form>
                </div>
              <%}%>
                <div id="div<%=i%>"> </div></td>
            <td  > <div align="center">
              <input type="image" name=popcal width="26" height="24"  src="report.jpg" border="0" >
            </div></td>
            <td  > <div align="center">
              <a href="resource.jsp"> <input name=popcal type="image"  src="resource.jpg" align="middle" width="26" height="24" border="0" ></a>
             
            </div></td>
            <td  ><p align="center">
		<%	 
        com.actionTracking.Person getPerson491mtemp = activity.getAssignedBy();
		out.print(getPerson491mtemp.getName()+" "+getPerson491mtemp.getFamily());
			%>	
			</p>		
			</td>
          </tr>
          <%} %>
          <!-- ########### /REGISTER ROLLOVERS ################# -->
          <!-- ########### /REGISTER ROLLOVERS ################# -->
        <a 
      href="javascript:browserInfo();"></a>
        <!-- ########### PROMO SPACE ################# -->
        <% } 
}
%>
      </table>
	  <!-- ########### /PROMO SPACE ################# -->
      <!-- ########### /RIGHT CONTENT ################# --></TD>
  </TR></TBODY></TABLE><%}catch(Exception e){
  out.print(e);
  }%>
</DIV></DIV><!-- JOIN ActionTrackingSystem EMAIL LIST -->
<DIV id=joinandFooter style="width:1000">&nbsp;<p><BR style="CLEAR: both; LINE-HEIGHT: 0; HEIGHT: 0px">
<p></p></DIV><!-- END OF JOIN ActionTrackingSystem EMAIL LIST --></DIV><p></p></DIV>
<TABLE style="PADDING-TOP: 7px" cellSpacing=0 cellPadding=0 width=748 
align=center border=0>
  <TBODY>
  <TR>
    <TD class=footerLink style="PADDING-LEFT: 0px; MARGIN-LEFT: 0px" align=left 
    width="50%">&nbsp;</TD>
    <TD align=right width="50%">
      <TABLE cellSpacing=0 cellPadding=0 align=right>
        <TBODY>
        <TR>
          <TD width="15" noWrap class=footerLink><A 
            href="ActionTrackingsystem.jspaboutus/contact.tem"></A></TD>
          <TD width="1" vAlign=center noWrap><IMG height=10 alt="" 
            src="ActionTrackingSystem_files/bottom-nav-line-gold.gif" 
            width=1></TD>
          <TD width="15" noWrap class=footerLink><A 
            href="ActionTrackingsystem.jspsitemap/sitemap.tem"></A></TD>
          <TD width="1" vAlign=center noWrap><IMG height=10 alt="" 
            src="ActionTrackingSystem_files/bottom-nav-line-gold.gif" 
            width=1></TD>
          <TD width="15" noWrap class=footerLink>&nbsp;</TD>
          <TD width="1" vAlign=center noWrap><IMG height=10 alt="" 
            src="ActionTrackingSystem_files/bottom-nav-line-gold.gif" 
            width=1></TD>
          <TD width="15" noWrap class=footerLink><A 
            href="ActionTrackingsystem.jspcis/default.tem"></A></TD>
          <TD width="1" vAlign=center noWrap><IMG height=10 alt="" 
            src="ActionTrackingSystem_files/bottom-nav-line-gold.gif" 
            width=1></TD>
          <TD width="62" noWrap class=footerLink><A 
            href="ActionTrackingsystem.jspaffiliates/landing_affiliates.tem"></A></TD>
        </TR></TBODY></TABLE></TD></TR></TBODY></TABLE></CENTER><!-- HitBox Enterprise by Mulenga-->
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
	//setFlat(true);
<%for (int i=0; i<listLength;i++){%>	
	addCalendar("calDate<%=i%>", "Select Date", "deadline<%=i%>", "");
<%}%>
</Script>
</BODY></HTML>