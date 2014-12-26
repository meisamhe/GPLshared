<%@page contentType="text/html;charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<HTML>
<HEAD>
<TITLE>Result</TITLE>
</HEAD>
<BODY>
<H1>Result</H1>

<jsp:useBean id="sampleMainServiceProxyid" scope="session" class="com.actionTracking.MainServiceProxy" />
<%
if (request.getParameter("endpoint") != null && request.getParameter("endpoint").length() > 0)
sampleMainServiceProxyid.setEndpoint(request.getParameter("endpoint"));
%>

<%
String method = request.getParameter("method");
int methodID = 0;
if (method == null) methodID = -1;

if(methodID != -1) methodID = Integer.parseInt(method);
boolean gotMethod = false;

try {
switch (methodID){ 
case 2:
        gotMethod = true;
        java.lang.String getEndpoint2mtemp = sampleMainServiceProxyid.getEndpoint();
if(getEndpoint2mtemp == null){
%>
<%=getEndpoint2mtemp %>
<%
}else{
        String tempResultreturnp3 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(getEndpoint2mtemp));
        %>
        <%= tempResultreturnp3 %>
        <%
}
break;
case 5:
        gotMethod = true;
        String endpoint_0id=  request.getParameter("endpoint8");
        java.lang.String endpoint_0idTemp  = endpoint_0id;
        sampleMainServiceProxyid.setEndpoint(endpoint_0idTemp);
break;
case 10:
        gotMethod = true;
        com.actionTracking.MainService getMainService10mtemp = sampleMainServiceProxyid.getMainService();
if(getMainService10mtemp == null){
%>
<%=getMainService10mtemp %>
<%
}else{
%>
<TABLE>
<TR>
<TD COLSPAN="3" ALIGN="LEFT">returnp:</TD>
</TABLE>
<%
}
break;
case 17:
        gotMethod = true;
        java.lang.String[] getLocation17mtemp = sampleMainServiceProxyid.getLocation();
if(getLocation17mtemp == null){
%>
<%=getLocation17mtemp %>
<%
}else{
        java.util.List listreturnp18= java.util.Arrays.asList(getLocation17mtemp);
        String tempreturnp18 = listreturnp18.toString();
        %>
        <%=tempreturnp18%>
        <%
}
break;
case 20:
        gotMethod = true;
        String activityID_1id=  request.getParameter("activityID23");
        long activityID_1idTemp  = Long.parseLong(activityID_1id);
        String personType_2id=  request.getParameter("personType25");
        java.lang.String personType_2idTemp  = personType_2id;
        String state_3id=  request.getParameter("state27");
        long state_3idTemp  = Long.parseLong(state_3id);
        String personUser_4id=  request.getParameter("personUser29");
        java.lang.String personUser_4idTemp  = personUser_4id;
        String date_5id=  request.getParameter("date31");
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
break;
case 33:
        gotMethod = true;
        String activityID_6id=  request.getParameter("activityID36");
        long activityID_6idTemp  = Long.parseLong(activityID_6id);
        java.lang.String getActivity33mtemp = sampleMainServiceProxyid.getActivity(activityID_6idTemp);
if(getActivity33mtemp == null){
%>
<%=getActivity33mtemp %>
<%
}else{
        String tempResultreturnp34 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(getActivity33mtemp));
        %>
        <%= tempResultreturnp34 %>
        <%
}
break;
case 38:
        gotMethod = true;
        int[] intArray38mtemp = sampleMainServiceProxyid.intArray();
if(intArray38mtemp == null){
%>
<%=intArray38mtemp %>
<%
}else{
        String tempreturnp39 = "[";        for(int ireturnp39=0;ireturnp39< intArray38mtemp.length;ireturnp39++){
            tempreturnp39 = tempreturnp39 + intArray38mtemp[ireturnp39] + ",";
        }
        int lengthreturnp39 = tempreturnp39.length();
        tempreturnp39 = tempreturnp39.substring(0,(lengthreturnp39 - 1)) + "]";
        %>
        <%=tempreturnp39%>
        <%
}
break;
case 41:
        gotMethod = true;
        String activityID_7id=  request.getParameter("activityID44");
        long activityID_7idTemp  = Long.parseLong(activityID_7id);
        String changerUser_8id=  request.getParameter("changerUser46");
        java.lang.String changerUser_8idTemp  = changerUser_8id;
        String firstPersonUser_9id=  request.getParameter("firstPersonUser48");
        java.lang.String firstPersonUser_9idTemp  = firstPersonUser_9id;
        String firstPersonType_10id=  request.getParameter("firstPersonType50");
        java.lang.String firstPersonType_10idTemp  = firstPersonType_10id;
        String secondPersonUser_11id=  request.getParameter("secondPersonUser52");
        java.lang.String secondPersonUser_11idTemp  = secondPersonUser_11id;
        String secondPersonType_12id=  request.getParameter("secondPersonType54");
        java.lang.String secondPersonType_12idTemp  = secondPersonType_12id;
        String date_13id=  request.getParameter("date56");
        long date_13idTemp  = Long.parseLong(date_13id);
        java.lang.String reassign41mtemp = sampleMainServiceProxyid.reassign(activityID_7idTemp,changerUser_8idTemp,firstPersonUser_9idTemp,firstPersonType_10idTemp,secondPersonUser_11idTemp,secondPersonType_12idTemp,date_13idTemp);
if(reassign41mtemp == null){
%>
<%=reassign41mtemp %>
<%
}else{
        String tempResultreturnp42 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(reassign41mtemp));
        %>
        <%= tempResultreturnp42 %>
        <%
}
break;
case 58:
        gotMethod = true;
        String name_14id=  request.getParameter("name61");
        java.lang.String name_14idTemp  = name_14id;
        String family_15id=  request.getParameter("family63");
        java.lang.String family_15idTemp  = family_15id;
        String user_16id=  request.getParameter("user65");
        java.lang.String user_16idTemp  = user_16id;
        String password_17id=  request.getParameter("password67");
        java.lang.String password_17idTemp  = password_17id;
        String department_18id=  request.getParameter("department69");
        java.lang.String department_18idTemp  = department_18id;
        String location_19id=  request.getParameter("location71");
        java.lang.String location_19idTemp  = location_19id;
        java.lang.String defineEmployee58mtemp = sampleMainServiceProxyid.defineEmployee(name_14idTemp,family_15idTemp,user_16idTemp,password_17idTemp,department_18idTemp,location_19idTemp);
if(defineEmployee58mtemp == null){
%>
<%=defineEmployee58mtemp %>
<%
}else{
        String tempResultreturnp59 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(defineEmployee58mtemp));
        %>
        <%= tempResultreturnp59 %>
        <%
}
break;
case 73:
        gotMethod = true;
        String name_20id=  request.getParameter("name76");
        java.lang.String name_20idTemp  = name_20id;
        String location_21id=  request.getParameter("location78");
        java.lang.String location_21idTemp  = location_21id;
        String upperDepartmentName_22id=  request.getParameter("upperDepartmentName80");
        java.lang.String upperDepartmentName_22idTemp  = upperDepartmentName_22id;
        String upperDepartmentLocation_23id=  request.getParameter("upperDepartmentLocation82");
        java.lang.String upperDepartmentLocation_23idTemp  = upperDepartmentLocation_23id;
        java.lang.String defineDepartment73mtemp = sampleMainServiceProxyid.defineDepartment(name_20idTemp,location_21idTemp,upperDepartmentName_22idTemp,upperDepartmentLocation_23idTemp);
if(defineDepartment73mtemp == null){
%>
<%=defineDepartment73mtemp %>
<%
}else{
        String tempResultreturnp74 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(defineDepartment73mtemp));
        %>
        <%= tempResultreturnp74 %>
        <%
}
break;
case 84:
        gotMethod = true;
        String name_24id=  request.getParameter("name87");
        java.lang.String name_24idTemp  = name_24id;
        String family_25id=  request.getParameter("family89");
        java.lang.String family_25idTemp  = family_25id;
        String user_26id=  request.getParameter("user91");
        java.lang.String user_26idTemp  = user_26id;
        String password_27id=  request.getParameter("password93");
        java.lang.String password_27idTemp  = password_27id;
        String department_28id=  request.getParameter("department95");
        java.lang.String department_28idTemp  = department_28id;
        String location_29id=  request.getParameter("location97");
        java.lang.String location_29idTemp  = location_29id;
        java.lang.String defineManager84mtemp = sampleMainServiceProxyid.defineManager(name_24idTemp,family_25idTemp,user_26idTemp,password_27idTemp,department_28idTemp,location_29idTemp);
if(defineManager84mtemp == null){
%>
<%=defineManager84mtemp %>
<%
}else{
        String tempResultreturnp85 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(defineManager84mtemp));
        %>
        <%= tempResultreturnp85 %>
        <%
}
break;
case 99:
        gotMethod = true;
        String user_30id=  request.getParameter("user102");
        java.lang.String user_30idTemp  = user_30id;
        String secondName_31id=  request.getParameter("secondName104");
        java.lang.String secondName_31idTemp  = secondName_31id;
        String secondFamily_32id=  request.getParameter("secondFamily106");
        java.lang.String secondFamily_32idTemp  = secondFamily_32id;
        String secondUser_33id=  request.getParameter("secondUser108");
        java.lang.String secondUser_33idTemp  = secondUser_33id;
        String secondPassword_34id=  request.getParameter("secondPassword110");
        java.lang.String secondPassword_34idTemp  = secondPassword_34id;
        java.lang.String replaceEmployee99mtemp = sampleMainServiceProxyid.replaceEmployee(user_30idTemp,secondName_31idTemp,secondFamily_32idTemp,secondUser_33idTemp,secondPassword_34idTemp);
if(replaceEmployee99mtemp == null){
%>
<%=replaceEmployee99mtemp %>
<%
}else{
        String tempResultreturnp100 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(replaceEmployee99mtemp));
        %>
        <%= tempResultreturnp100 %>
        <%
}
break;
case 112:
        gotMethod = true;
        String user_35id=  request.getParameter("user115");
        java.lang.String user_35idTemp  = user_35id;
        java.lang.String deleteEmployee112mtemp = sampleMainServiceProxyid.deleteEmployee(user_35idTemp);
if(deleteEmployee112mtemp == null){
%>
<%=deleteEmployee112mtemp %>
<%
}else{
        String tempResultreturnp113 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(deleteEmployee112mtemp));
        %>
        <%= tempResultreturnp113 %>
        <%
}
break;
case 117:
        gotMethod = true;
        String user_36id=  request.getParameter("user120");
        java.lang.String user_36idTemp  = user_36id;
        String secondName_37id=  request.getParameter("secondName122");
        java.lang.String secondName_37idTemp  = secondName_37id;
        String secondFamily_38id=  request.getParameter("secondFamily124");
        java.lang.String secondFamily_38idTemp  = secondFamily_38id;
        String secondUser_39id=  request.getParameter("secondUser126");
        java.lang.String secondUser_39idTemp  = secondUser_39id;
        String secondPassword_40id=  request.getParameter("secondPassword128");
        java.lang.String secondPassword_40idTemp  = secondPassword_40id;
        java.lang.String replaceManager117mtemp = sampleMainServiceProxyid.replaceManager(user_36idTemp,secondName_37idTemp,secondFamily_38idTemp,secondUser_39idTemp,secondPassword_40idTemp);
if(replaceManager117mtemp == null){
%>
<%=replaceManager117mtemp %>
<%
}else{
        String tempResultreturnp118 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(replaceManager117mtemp));
        %>
        <%= tempResultreturnp118 %>
        <%
}
break;
case 130:
        gotMethod = true;
        String name_41id=  request.getParameter("name133");
        java.lang.String name_41idTemp  = name_41id;
        String description_42id=  request.getParameter("description135");
        java.lang.String description_42idTemp  = description_42id;
        String deadline_43id=  request.getParameter("deadline137");
        long deadline_43idTemp  = Long.parseLong(deadline_43id);
        String initializedDate_44id=  request.getParameter("initializedDate139");
        long initializedDate_44idTemp  = Long.parseLong(initializedDate_44id);
        String personUser_45id=  request.getParameter("personUser141");
        java.lang.String personUser_45idTemp  = personUser_45id;
        String personType_46id=  request.getParameter("personType143");
        java.lang.String personType_46idTemp  = personType_46id;
        String assignedByUser_47id=  request.getParameter("assignedByUser145");
        java.lang.String assignedByUser_47idTemp  = assignedByUser_47id;
        String upperActivityID_48id=  request.getParameter("upperActivityID147");
        long upperActivityID_48idTemp  = Long.parseLong(upperActivityID_48id);
        java.lang.String defineActivity130mtemp = sampleMainServiceProxyid.defineActivity(name_41idTemp,description_42idTemp,deadline_43idTemp,initializedDate_44idTemp,personUser_45idTemp,personType_46idTemp,assignedByUser_47idTemp,upperActivityID_48idTemp);
if(defineActivity130mtemp == null){
%>
<%=defineActivity130mtemp %>
<%
}else{
        String tempResultreturnp131 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(defineActivity130mtemp));
        %>
        <%= tempResultreturnp131 %>
        <%
}
break;
case 149:
        gotMethod = true;
        String activityID_49id=  request.getParameter("activityID152");
        long activityID_49idTemp  = Long.parseLong(activityID_49id);
        String personType_50id=  request.getParameter("personType154");
        java.lang.String personType_50idTemp  = personType_50id;
        String description_51id=  request.getParameter("description156");
        java.lang.String description_51idTemp  = description_51id;
        String personUser_52id=  request.getParameter("personUser158");
        java.lang.String personUser_52idTemp  = personUser_52id;
        java.lang.String preciseDescription149mtemp = sampleMainServiceProxyid.preciseDescription(activityID_49idTemp,personType_50idTemp,description_51idTemp,personUser_52idTemp);
if(preciseDescription149mtemp == null){
%>
<%=preciseDescription149mtemp %>
<%
}else{
        String tempResultreturnp150 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(preciseDescription149mtemp));
        %>
        <%= tempResultreturnp150 %>
        <%
}
break;
case 160:
        gotMethod = true;
        String activityID_53id=  request.getParameter("activityID163");
        long activityID_53idTemp  = Long.parseLong(activityID_53id);
        String type_54id=  request.getParameter("type165");
        java.lang.String type_54idTemp  = type_54id;
        String deadline_55id=  request.getParameter("deadline167");
        long deadline_55idTemp  = Long.parseLong(deadline_55id);
        String assignedUser_56id=  request.getParameter("assignedUser169");
        java.lang.String assignedUser_56idTemp  = assignedUser_56id;
        String date_57id=  request.getParameter("date171");
        long date_57idTemp  = Long.parseLong(date_57id);
        String changerUser_58id=  request.getParameter("changerUser173");
        java.lang.String changerUser_58idTemp  = changerUser_58id;
        java.lang.String extendDeadline160mtemp = sampleMainServiceProxyid.extendDeadline(activityID_53idTemp,type_54idTemp,deadline_55idTemp,assignedUser_56idTemp,date_57idTemp,changerUser_58idTemp);
if(extendDeadline160mtemp == null){
%>
<%=extendDeadline160mtemp %>
<%
}else{
        String tempResultreturnp161 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(extendDeadline160mtemp));
        %>
        <%= tempResultreturnp161 %>
        <%
}
break;
case 175:
        gotMethod = true;
        String activityID_59id=  request.getParameter("activityID178");
        long activityID_59idTemp  = Long.parseLong(activityID_59id);
        String personType_60id=  request.getParameter("personType180");
        java.lang.String personType_60idTemp  = personType_60id;
        String personUser_61id=  request.getParameter("personUser182");
        java.lang.String personUser_61idTemp  = personUser_61id;
        String changerUser_62id=  request.getParameter("changerUser184");
        java.lang.String changerUser_62idTemp  = changerUser_62id;
        String date_63id=  request.getParameter("date186");
        long date_63idTemp  = Long.parseLong(date_63id);
        java.lang.String unActivateActivity175mtemp = sampleMainServiceProxyid.unActivateActivity(activityID_59idTemp,personType_60idTemp,personUser_61idTemp,changerUser_62idTemp,date_63idTemp);
if(unActivateActivity175mtemp == null){
%>
<%=unActivateActivity175mtemp %>
<%
}else{
        String tempResultreturnp176 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(unActivateActivity175mtemp));
        %>
        <%= tempResultreturnp176 %>
        <%
}
break;
case 188:
        gotMethod = true;
        String activityID_64id=  request.getParameter("activityID191");
        long activityID_64idTemp  = Long.parseLong(activityID_64id);
        String type_65id=  request.getParameter("type193");
        java.lang.String type_65idTemp  = type_65id;
        String resourceName_66id=  request.getParameter("resourceName195");
        java.lang.String resourceName_66idTemp  = resourceName_66id;
        String resourcePlace_67id=  request.getParameter("resourcePlace197");
        java.lang.String resourcePlace_67idTemp  = resourcePlace_67id;
        String resourceQuantity_68id=  request.getParameter("resourceQuantity199");
        long resourceQuantity_68idTemp  = Long.parseLong(resourceQuantity_68id);
        String assignedUser_69id=  request.getParameter("assignedUser201");
        java.lang.String assignedUser_69idTemp  = assignedUser_69id;
        java.lang.String addResourceToActivity188mtemp = sampleMainServiceProxyid.addResourceToActivity(activityID_64idTemp,type_65idTemp,resourceName_66idTemp,resourcePlace_67idTemp,resourceQuantity_68idTemp,assignedUser_69idTemp);
if(addResourceToActivity188mtemp == null){
%>
<%=addResourceToActivity188mtemp %>
<%
}else{
        String tempResultreturnp189 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(addResourceToActivity188mtemp));
        %>
        <%= tempResultreturnp189 %>
        <%
}
break;
case 203:
        gotMethod = true;
        String name_70id=  request.getParameter("name206");
        java.lang.String name_70idTemp  = name_70id;
        String place_71id=  request.getParameter("place208");
        java.lang.String place_71idTemp  = place_71id;
        String inHand_72id=  request.getParameter("inHand210");
        int inHand_72idTemp  = Integer.parseInt(inHand_72id);
        java.lang.String defineResourceForOrganization203mtemp = sampleMainServiceProxyid.defineResourceForOrganization(name_70idTemp,place_71idTemp,inHand_72idTemp);
if(defineResourceForOrganization203mtemp == null){
%>
<%=defineResourceForOrganization203mtemp %>
<%
}else{
        String tempResultreturnp204 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(defineResourceForOrganization203mtemp));
        %>
        <%= tempResultreturnp204 %>
        <%
}
break;
case 212:
        gotMethod = true;
        String activityID_73id=  request.getParameter("activityID215");
        long activityID_73idTemp  = Long.parseLong(activityID_73id);
        String type_74id=  request.getParameter("type217");
        java.lang.String type_74idTemp  = type_74id;
        String title_75id=  request.getParameter("title219");
        java.lang.String title_75idTemp  = title_75id;
        String reportpath_76id=  request.getParameter("reportpath221");
        java.lang.String reportpath_76idTemp  = reportpath_76id;
        String assignedUser_77id=  request.getParameter("assignedUser223");
        java.lang.String assignedUser_77idTemp  = assignedUser_77id;
        String date_78id=  request.getParameter("date225");
        long date_78idTemp  = Long.parseLong(date_78id);
        java.lang.String addReportToActivity212mtemp = sampleMainServiceProxyid.addReportToActivity(activityID_73idTemp,type_74idTemp,title_75idTemp,reportpath_76idTemp,assignedUser_77idTemp,date_78idTemp);
if(addReportToActivity212mtemp == null){
%>
<%=addReportToActivity212mtemp %>
<%
}else{
        String tempResultreturnp213 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(addReportToActivity212mtemp));
        %>
        <%= tempResultreturnp213 %>
        <%
}
break;
case 227:
        gotMethod = true;
        String activityID_79id=  request.getParameter("activityID230");
        long activityID_79idTemp  = Long.parseLong(activityID_79id);
        String type_80id=  request.getParameter("type232");
        java.lang.String type_80idTemp  = type_80id;
        String resourceName_81id=  request.getParameter("resourceName234");
        java.lang.String resourceName_81idTemp  = resourceName_81id;
        String resourcePlace_82id=  request.getParameter("resourcePlace236");
        java.lang.String resourcePlace_82idTemp  = resourcePlace_82id;
        String resourceQuantity_83id=  request.getParameter("resourceQuantity238");
        long resourceQuantity_83idTemp  = Long.parseLong(resourceQuantity_83id);
        String assignedUser_84id=  request.getParameter("assignedUser240");
        java.lang.String assignedUser_84idTemp  = assignedUser_84id;
        java.lang.String changeResourceQuantityOfActivity227mtemp = sampleMainServiceProxyid.changeResourceQuantityOfActivity(activityID_79idTemp,type_80idTemp,resourceName_81idTemp,resourcePlace_82idTemp,resourceQuantity_83idTemp,assignedUser_84idTemp);
if(changeResourceQuantityOfActivity227mtemp == null){
%>
<%=changeResourceQuantityOfActivity227mtemp %>
<%
}else{
        String tempResultreturnp228 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(changeResourceQuantityOfActivity227mtemp));
        %>
        <%= tempResultreturnp228 %>
        <%
}
break;
case 242:
        gotMethod = true;
        String name_85id=  request.getParameter("name245");
        java.lang.String name_85idTemp  = name_85id;
        String place_86id=  request.getParameter("place247");
        java.lang.String place_86idTemp  = place_86id;
        String inHand_87id=  request.getParameter("inHand249");
        long inHand_87idTemp  = Long.parseLong(inHand_87id);
        java.lang.String changeResourceQuantityOfOrganization242mtemp = sampleMainServiceProxyid.changeResourceQuantityOfOrganization(name_85idTemp,place_86idTemp,inHand_87idTemp);
if(changeResourceQuantityOfOrganization242mtemp == null){
%>
<%=changeResourceQuantityOfOrganization242mtemp %>
<%
}else{
        String tempResultreturnp243 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(changeResourceQuantityOfOrganization242mtemp));
        %>
        <%= tempResultreturnp243 %>
        <%
}
break;
case 251:
        gotMethod = true;
        String type_88id=  request.getParameter("type254");
        java.lang.String type_88idTemp  = type_88id;
        String date_89id=  request.getParameter("date256");
        long date_89idTemp  = Long.parseLong(date_89id);
        String user_90id=  request.getParameter("user258");
        java.lang.String user_90idTemp  = user_90id;
        com.actionTracking.Activity[] uncompletedActivityUntilDateOfSpecialPerson251mtemp = sampleMainServiceProxyid.uncompletedActivityUntilDateOfSpecialPerson(type_88idTemp,date_89idTemp,user_90idTemp);
if(uncompletedActivityUntilDateOfSpecialPerson251mtemp == null){
%>
<%=uncompletedActivityUntilDateOfSpecialPerson251mtemp %>
<%
}else{
        java.util.List listreturnp252= java.util.Arrays.asList(uncompletedActivityUntilDateOfSpecialPerson251mtemp);
        String tempreturnp252 = listreturnp252.toString();
        %>
        <%=tempreturnp252%>
        <%
}
break;
case 260:
        gotMethod = true;
        String type_91id=  request.getParameter("type311");
        java.lang.String type_91idTemp  = type_91id;
        String date_92id=  request.getParameter("date313");
        long date_92idTemp  = Long.parseLong(date_92id);
        String user_93id=  request.getParameter("user315");
        java.lang.String user_93idTemp  = user_93id;
        com.actionTracking.Activity uncompleted260mtemp = sampleMainServiceProxyid.uncompleted(type_91idTemp,date_92idTemp,user_93idTemp);
if(uncompleted260mtemp == null){
%>
<%=uncompleted260mtemp %>
<%
}else{
%>
<TABLE>
<TR>
<TD COLSPAN="3" ALIGN="LEFT">returnp:</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD COLSPAN="2" ALIGN="LEFT">employeeID:</TD>
<TD>
<%
if(uncompleted260mtemp != null){
%>
<%=uncompleted260mtemp.getEmployeeID()
%><%}%>
</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD COLSPAN="2" ALIGN="LEFT">state:</TD>
<TD>
<%
if(uncompleted260mtemp != null){
%>
<%=uncompleted260mtemp.getState()
%><%}%>
</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD COLSPAN="2" ALIGN="LEFT">name:</TD>
<TD>
<%
if(uncompleted260mtemp != null){
java.lang.String typename267 = uncompleted260mtemp.getName();
        String tempResultname267 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(typename267));
        %>
        <%= tempResultname267 %>
        <%
}%>
</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD COLSPAN="2" ALIGN="LEFT">lastUpdate:</TD>
<TD>
<%
if(uncompleted260mtemp != null){
%>
<%=uncompleted260mtemp.getLastUpdate()
%><%}%>
</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD COLSPAN="2" ALIGN="LEFT">activityId:</TD>
<TD>
<%
if(uncompleted260mtemp != null){
%>
<%=uncompleted260mtemp.getActivityId()
%><%}%>
</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD COLSPAN="2" ALIGN="LEFT">assignedBy:</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD WIDTH="5%"></TD>
<TD COLSPAN="1" ALIGN="LEFT">location:</TD>
<TD>
<%
if(uncompleted260mtemp != null){
com.actionTracking.Person tebece0=uncompleted260mtemp.getAssignedBy();
if(tebece0 != null){
java.lang.String typelocation275 = tebece0.getLocation();
        String tempResultlocation275 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(typelocation275));
        %>
        <%= tempResultlocation275 %>
        <%
}}%>
</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD WIDTH="5%"></TD>
<TD COLSPAN="1" ALIGN="LEFT">user:</TD>
<TD>
<%
if(uncompleted260mtemp != null){
com.actionTracking.Person tebece0=uncompleted260mtemp.getAssignedBy();
if(tebece0 != null){
java.lang.String typeuser277 = tebece0.getUser();
        String tempResultuser277 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(typeuser277));
        %>
        <%= tempResultuser277 %>
        <%
}}%>
</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD WIDTH="5%"></TD>
<TD COLSPAN="1" ALIGN="LEFT">name:</TD>
<TD>
<%
if(uncompleted260mtemp != null){
com.actionTracking.Person tebece0=uncompleted260mtemp.getAssignedBy();
if(tebece0 != null){
java.lang.String typename279 = tebece0.getName();
        String tempResultname279 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(typename279));
        %>
        <%= tempResultname279 %>
        <%
}}%>
</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD WIDTH="5%"></TD>
<TD COLSPAN="1" ALIGN="LEFT">department:</TD>
<TD>
<%
if(uncompleted260mtemp != null){
com.actionTracking.Person tebece0=uncompleted260mtemp.getAssignedBy();
if(tebece0 != null){
java.lang.String typedepartment281 = tebece0.getDepartment();
        String tempResultdepartment281 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(typedepartment281));
        %>
        <%= tempResultdepartment281 %>
        <%
}}%>
</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD WIDTH="5%"></TD>
<TD COLSPAN="1" ALIGN="LEFT">type:</TD>
<TD>
<%
if(uncompleted260mtemp != null){
com.actionTracking.Person tebece0=uncompleted260mtemp.getAssignedBy();
if(tebece0 != null){
java.lang.String typetype283 = tebece0.getType();
        String tempResulttype283 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(typetype283));
        %>
        <%= tempResulttype283 %>
        <%
}}%>
</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD WIDTH="5%"></TD>
<TD COLSPAN="1" ALIGN="LEFT">family:</TD>
<TD>
<%
if(uncompleted260mtemp != null){
com.actionTracking.Person tebece0=uncompleted260mtemp.getAssignedBy();
if(tebece0 != null){
java.lang.String typefamily285 = tebece0.getFamily();
        String tempResultfamily285 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(typefamily285));
        %>
        <%= tempResultfamily285 %>
        <%
}}%>
</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD COLSPAN="2" ALIGN="LEFT">initializedDate:</TD>
<TD>
<%
if(uncompleted260mtemp != null){
%>
<%=uncompleted260mtemp.getInitializedDate()
%><%}%>
</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD COLSPAN="2" ALIGN="LEFT">upperActivity:</TD>
<TD>
<%
if(uncompleted260mtemp != null){
%>
<%=uncompleted260mtemp.getUpperActivity()
%><%}%>
</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD COLSPAN="2" ALIGN="LEFT">type:</TD>
<TD>
<%
if(uncompleted260mtemp != null){
java.lang.String typetype291 = uncompleted260mtemp.getType();
        String tempResulttype291 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(typetype291));
        %>
        <%= tempResulttype291 %>
        <%
}%>
</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD COLSPAN="2" ALIGN="LEFT">employee:</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD WIDTH="5%"></TD>
<TD COLSPAN="1" ALIGN="LEFT">location:</TD>
<TD>
<%
if(uncompleted260mtemp != null){
com.actionTracking.Person tebece0=uncompleted260mtemp.getEmployee();
if(tebece0 != null){
java.lang.String typelocation295 = tebece0.getLocation();
        String tempResultlocation295 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(typelocation295));
        %>
        <%= tempResultlocation295 %>
        <%
}}%>
</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD WIDTH="5%"></TD>
<TD COLSPAN="1" ALIGN="LEFT">user:</TD>
<TD>
<%
if(uncompleted260mtemp != null){
com.actionTracking.Person tebece0=uncompleted260mtemp.getEmployee();
if(tebece0 != null){
java.lang.String typeuser297 = tebece0.getUser();
        String tempResultuser297 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(typeuser297));
        %>
        <%= tempResultuser297 %>
        <%
}}%>
</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD WIDTH="5%"></TD>
<TD COLSPAN="1" ALIGN="LEFT">name:</TD>
<TD>
<%
if(uncompleted260mtemp != null){
com.actionTracking.Person tebece0=uncompleted260mtemp.getEmployee();
if(tebece0 != null){
java.lang.String typename299 = tebece0.getName();
        String tempResultname299 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(typename299));
        %>
        <%= tempResultname299 %>
        <%
}}%>
</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD WIDTH="5%"></TD>
<TD COLSPAN="1" ALIGN="LEFT">department:</TD>
<TD>
<%
if(uncompleted260mtemp != null){
com.actionTracking.Person tebece0=uncompleted260mtemp.getEmployee();
if(tebece0 != null){
java.lang.String typedepartment301 = tebece0.getDepartment();
        String tempResultdepartment301 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(typedepartment301));
        %>
        <%= tempResultdepartment301 %>
        <%
}}%>
</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD WIDTH="5%"></TD>
<TD COLSPAN="1" ALIGN="LEFT">type:</TD>
<TD>
<%
if(uncompleted260mtemp != null){
com.actionTracking.Person tebece0=uncompleted260mtemp.getEmployee();
if(tebece0 != null){
java.lang.String typetype303 = tebece0.getType();
        String tempResulttype303 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(typetype303));
        %>
        <%= tempResulttype303 %>
        <%
}}%>
</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD WIDTH="5%"></TD>
<TD COLSPAN="1" ALIGN="LEFT">family:</TD>
<TD>
<%
if(uncompleted260mtemp != null){
com.actionTracking.Person tebece0=uncompleted260mtemp.getEmployee();
if(tebece0 != null){
java.lang.String typefamily305 = tebece0.getFamily();
        String tempResultfamily305 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(typefamily305));
        %>
        <%= tempResultfamily305 %>
        <%
}}%>
</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD COLSPAN="2" ALIGN="LEFT">description:</TD>
<TD>
<%
if(uncompleted260mtemp != null){
java.lang.String typedescription307 = uncompleted260mtemp.getDescription();
        String tempResultdescription307 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(typedescription307));
        %>
        <%= tempResultdescription307 %>
        <%
}%>
</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD COLSPAN="2" ALIGN="LEFT">deadline:</TD>
<TD>
<%
if(uncompleted260mtemp != null){
%>
<%=uncompleted260mtemp.getDeadline()
%><%}%>
</TD>
</TABLE>
<%
}
break;
case 317:
        gotMethod = true;
        String date_94id=  request.getParameter("date320");
        long date_94idTemp  = Long.parseLong(date_94id);
        String user_95id=  request.getParameter("user322");
        java.lang.String user_95idTemp  = user_95id;
        com.actionTracking.Activity[] uncompletedActivityUntilDateOfsubsidary317mtemp = sampleMainServiceProxyid.uncompletedActivityUntilDateOfsubsidary(date_94idTemp,user_95idTemp);
if(uncompletedActivityUntilDateOfsubsidary317mtemp == null){
%>
<%=uncompletedActivityUntilDateOfsubsidary317mtemp %>
<%
}else{
        java.util.List listreturnp318= java.util.Arrays.asList(uncompletedActivityUntilDateOfsubsidary317mtemp);
        String tempreturnp318 = listreturnp318.toString();
        %>
        <%=tempreturnp318%>
        <%
}
break;
case 324:
        gotMethod = true;
        String user_96id=  request.getParameter("user327");
        java.lang.String user_96idTemp  = user_96id;
        String type_97id=  request.getParameter("type329");
        java.lang.String type_97idTemp  = type_97id;
        String firstDate_98id=  request.getParameter("firstDate331");
        long firstDate_98idTemp  = Long.parseLong(firstDate_98id);
        String lastDate_99id=  request.getParameter("lastDate333");
        long lastDate_99idTemp  = Long.parseLong(lastDate_99id);
        com.actionTracking.Activity[] completedActivityBetweenDatesEmployee324mtemp = sampleMainServiceProxyid.completedActivityBetweenDatesEmployee(user_96idTemp,type_97idTemp,firstDate_98idTemp,lastDate_99idTemp);
if(completedActivityBetweenDatesEmployee324mtemp == null){
%>
<%=completedActivityBetweenDatesEmployee324mtemp %>
<%
}else{
        java.util.List listreturnp325= java.util.Arrays.asList(completedActivityBetweenDatesEmployee324mtemp);
        String tempreturnp325 = listreturnp325.toString();
        %>
        <%=tempreturnp325%>
        <%
}
break;
case 335:
        gotMethod = true;
        String user_100id=  request.getParameter("user338");
        java.lang.String user_100idTemp  = user_100id;
        String firstDate_101id=  request.getParameter("firstDate340");
        long firstDate_101idTemp  = Long.parseLong(firstDate_101id);
        String lastDate_102id=  request.getParameter("lastDate342");
        long lastDate_102idTemp  = Long.parseLong(lastDate_102id);
        com.actionTracking.Activity[] completedActivityBetweenDatesSubsidary335mtemp = sampleMainServiceProxyid.completedActivityBetweenDatesSubsidary(user_100idTemp,firstDate_101idTemp,lastDate_102idTemp);
if(completedActivityBetweenDatesSubsidary335mtemp == null){
%>
<%=completedActivityBetweenDatesSubsidary335mtemp %>
<%
}else{
        java.util.List listreturnp336= java.util.Arrays.asList(completedActivityBetweenDatesSubsidary335mtemp);
        String tempreturnp336 = listreturnp336.toString();
        %>
        <%=tempreturnp336%>
        <%
}
break;
case 344:
        gotMethod = true;
        String user_103id=  request.getParameter("user347");
        java.lang.String user_103idTemp  = user_103id;
        String type_104id=  request.getParameter("type349");
        java.lang.String type_104idTemp  = type_104id;
        String firstDate_105id=  request.getParameter("firstDate351");
        long firstDate_105idTemp  = Long.parseLong(firstDate_105id);
        String lastDate_106id=  request.getParameter("lastDate353");
        long lastDate_106idTemp  = Long.parseLong(lastDate_106id);
        com.actionTracking.Activity[] unCompletedActivityBetweenDatesEmployee344mtemp = sampleMainServiceProxyid.unCompletedActivityBetweenDatesEmployee(user_103idTemp,type_104idTemp,firstDate_105idTemp,lastDate_106idTemp);
if(unCompletedActivityBetweenDatesEmployee344mtemp == null){
%>
<%=unCompletedActivityBetweenDatesEmployee344mtemp %>
<%
}else{
        java.util.List listreturnp345= java.util.Arrays.asList(unCompletedActivityBetweenDatesEmployee344mtemp);
        String tempreturnp345 = listreturnp345.toString();
        %>
        <%=tempreturnp345%>
        <%
}
break;
case 355:
        gotMethod = true;
        String user_107id=  request.getParameter("user358");
        java.lang.String user_107idTemp  = user_107id;
        String firstDate_108id=  request.getParameter("firstDate360");
        long firstDate_108idTemp  = Long.parseLong(firstDate_108id);
        String lastDate_109id=  request.getParameter("lastDate362");
        long lastDate_109idTemp  = Long.parseLong(lastDate_109id);
        com.actionTracking.Activity[] unCompletedActivityBetweenDatesSubsidary355mtemp = sampleMainServiceProxyid.unCompletedActivityBetweenDatesSubsidary(user_107idTemp,firstDate_108idTemp,lastDate_109idTemp);
if(unCompletedActivityBetweenDatesSubsidary355mtemp == null){
%>
<%=unCompletedActivityBetweenDatesSubsidary355mtemp %>
<%
}else{
        java.util.List listreturnp356= java.util.Arrays.asList(unCompletedActivityBetweenDatesSubsidary355mtemp);
        String tempreturnp356 = listreturnp356.toString();
        %>
        <%=tempreturnp356%>
        <%
}
break;
case 364:
        gotMethod = true;
        String user_110id=  request.getParameter("user367");
        java.lang.String user_110idTemp  = user_110id;
        String type_111id=  request.getParameter("type369");
        java.lang.String type_111idTemp  = type_111id;
        String firstDate_112id=  request.getParameter("firstDate371");
        long firstDate_112idTemp  = Long.parseLong(firstDate_112id);
        String lastDate_113id=  request.getParameter("lastDate373");
        long lastDate_113idTemp  = Long.parseLong(lastDate_113id);
        com.actionTracking.Activity[] allActivityBetweenDatesEmployee364mtemp = sampleMainServiceProxyid.allActivityBetweenDatesEmployee(user_110idTemp,type_111idTemp,firstDate_112idTemp,lastDate_113idTemp);
if(allActivityBetweenDatesEmployee364mtemp == null){
%>
<%=allActivityBetweenDatesEmployee364mtemp %>
<%
}else{
        java.util.List listreturnp365= java.util.Arrays.asList(allActivityBetweenDatesEmployee364mtemp);
        String tempreturnp365 = listreturnp365.toString();
        %>
        <%=tempreturnp365%>
        <%
}
break;
case 375:
        gotMethod = true;
        String user_114id=  request.getParameter("user378");
        java.lang.String user_114idTemp  = user_114id;
        String firstDate_115id=  request.getParameter("firstDate380");
        long firstDate_115idTemp  = Long.parseLong(firstDate_115id);
        String lastDate_116id=  request.getParameter("lastDate382");
        long lastDate_116idTemp  = Long.parseLong(lastDate_116id);
        com.actionTracking.Activity[] allActivityBetweenDatesSubsidary375mtemp = sampleMainServiceProxyid.allActivityBetweenDatesSubsidary(user_114idTemp,firstDate_115idTemp,lastDate_116idTemp);
if(allActivityBetweenDatesSubsidary375mtemp == null){
%>
<%=allActivityBetweenDatesSubsidary375mtemp %>
<%
}else{
        java.util.List listreturnp376= java.util.Arrays.asList(allActivityBetweenDatesSubsidary375mtemp);
        String tempreturnp376 = listreturnp376.toString();
        %>
        <%=tempreturnp376%>
        <%
}
break;
case 384:
        gotMethod = true;
        String type_117id=  request.getParameter("type387");
        java.lang.String type_117idTemp  = type_117id;
        com.actionTracking.Person[] getPersonel384mtemp = sampleMainServiceProxyid.getPersonel(type_117idTemp);
if(getPersonel384mtemp == null){
%>
<%=getPersonel384mtemp %>
<%
}else{
        java.util.List listreturnp385= java.util.Arrays.asList(getPersonel384mtemp);
        String tempreturnp385 = listreturnp385.toString();
        %>
        <%=tempreturnp385%>
        <%
}
break;
case 389:
        gotMethod = true;
        com.actionTracking.Department[] getDepartments389mtemp = sampleMainServiceProxyid.getDepartments();
if(getDepartments389mtemp == null){
%>
<%=getDepartments389mtemp %>
<%
}else{
        java.util.List listreturnp390= java.util.Arrays.asList(getDepartments389mtemp);
        String tempreturnp390 = listreturnp390.toString();
        %>
        <%=tempreturnp390%>
        <%
}
break;
case 392:
        gotMethod = true;
        String type_118id=  request.getParameter("type395");
        java.lang.String type_118idTemp  = type_118id;
        String name_119id=  request.getParameter("name397");
        java.lang.String name_119idTemp  = name_119id;
        com.actionTracking.Person[] getPersonelWithName392mtemp = sampleMainServiceProxyid.getPersonelWithName(type_118idTemp,name_119idTemp);
if(getPersonelWithName392mtemp == null){
%>
<%=getPersonelWithName392mtemp %>
<%
}else{
        java.util.List listreturnp393= java.util.Arrays.asList(getPersonelWithName392mtemp);
        String tempreturnp393 = listreturnp393.toString();
        %>
        <%=tempreturnp393%>
        <%
}
break;
case 399:
        gotMethod = true;
        String name_120id=  request.getParameter("name402");
        java.lang.String name_120idTemp  = name_120id;
        com.actionTracking.Department[] getDepartmentsWithName399mtemp = sampleMainServiceProxyid.getDepartmentsWithName(name_120idTemp);
if(getDepartmentsWithName399mtemp == null){
%>
<%=getDepartmentsWithName399mtemp %>
<%
}else{
        java.util.List listreturnp400= java.util.Arrays.asList(getDepartmentsWithName399mtemp);
        String tempreturnp400 = listreturnp400.toString();
        %>
        <%=tempreturnp400%>
        <%
}
break;
case 404:
        gotMethod = true;
        String name_121id=  request.getParameter("name407");
        java.lang.String name_121idTemp  = name_121id;
        java.lang.String[] getLocationWithName404mtemp = sampleMainServiceProxyid.getLocationWithName(name_121idTemp);
if(getLocationWithName404mtemp == null){
%>
<%=getLocationWithName404mtemp %>
<%
}else{
        java.util.List listreturnp405= java.util.Arrays.asList(getLocationWithName404mtemp);
        String tempreturnp405 = listreturnp405.toString();
        %>
        <%=tempreturnp405%>
        <%
}
break;
case 409:
        gotMethod = true;
        String user_122id=  request.getParameter("user412");
        java.lang.String user_122idTemp  = user_122id;
        String type_123id=  request.getParameter("type414");
        java.lang.String type_123idTemp  = type_123id;
        String activityID_124id=  request.getParameter("activityID416");
        long activityID_124idTemp  = Long.parseLong(activityID_124id);
        com.actionTracking.Report[] viewReportOfActivity409mtemp = sampleMainServiceProxyid.viewReportOfActivity(user_122idTemp,type_123idTemp,activityID_124idTemp);
if(viewReportOfActivity409mtemp == null){
%>
<%=viewReportOfActivity409mtemp %>
<%
}else{
        java.util.List listreturnp410= java.util.Arrays.asList(viewReportOfActivity409mtemp);
        String tempreturnp410 = listreturnp410.toString();
        %>
        <%=tempreturnp410%>
        <%
}
break;
case 418:
        gotMethod = true;
        String user_125id=  request.getParameter("user421");
        java.lang.String user_125idTemp  = user_125id;
        String type_126id=  request.getParameter("type423");
        java.lang.String type_126idTemp  = type_126id;
        String activityID_127id=  request.getParameter("activityID425");
        long activityID_127idTemp  = Long.parseLong(activityID_127id);
        int getReportCountOfActivity418mtemp = sampleMainServiceProxyid.getReportCountOfActivity(user_125idTemp,type_126idTemp,activityID_127idTemp);
        String tempResultreturnp419 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(getReportCountOfActivity418mtemp));
        %>
        <%= tempResultreturnp419 %>
        <%
break;
case 427:
        gotMethod = true;
        com.actionTracking.Resource[] viewResourceOfOrganization427mtemp = sampleMainServiceProxyid.viewResourceOfOrganization();
if(viewResourceOfOrganization427mtemp == null){
%>
<%=viewResourceOfOrganization427mtemp %>
<%
}else{
        java.util.List listreturnp428= java.util.Arrays.asList(viewResourceOfOrganization427mtemp);
        String tempreturnp428 = listreturnp428.toString();
        %>
        <%=tempreturnp428%>
        <%
}
break;
case 430:
        gotMethod = true;
        String user_128id=  request.getParameter("user433");
        java.lang.String user_128idTemp  = user_128id;
        String type_129id=  request.getParameter("type435");
        java.lang.String type_129idTemp  = type_129id;
        String activityID_130id=  request.getParameter("activityID437");
        long activityID_130idTemp  = Long.parseLong(activityID_130id);
        com.actionTracking.Resource[] viewResourceOfActivity430mtemp = sampleMainServiceProxyid.viewResourceOfActivity(user_128idTemp,type_129idTemp,activityID_130idTemp);
if(viewResourceOfActivity430mtemp == null){
%>
<%=viewResourceOfActivity430mtemp %>
<%
}else{
        java.util.List listreturnp431= java.util.Arrays.asList(viewResourceOfActivity430mtemp);
        String tempreturnp431 = listreturnp431.toString();
        %>
        <%=tempreturnp431%>
        <%
}
break;
case 439:
        gotMethod = true;
        String user_131id=  request.getParameter("user442");
        java.lang.String user_131idTemp  = user_131id;
        String password_132id=  request.getParameter("password444");
        java.lang.String password_132idTemp  = password_132id;
        String type_133id=  request.getParameter("type446");
        java.lang.String type_133idTemp  = type_133id;
        int personAuthentication439mtemp = sampleMainServiceProxyid.personAuthentication(user_131idTemp,password_132idTemp,type_133idTemp);
        String tempResultreturnp440 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(personAuthentication439mtemp));
        %>
        <%= tempResultreturnp440 %>
        <%
break;
case 448:
        gotMethod = true;
        java.lang.String hello448mtemp = sampleMainServiceProxyid.hello();
if(hello448mtemp == null){
%>
<%=hello448mtemp %>
<%
}else{
        String tempResultreturnp449 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(hello448mtemp));
        %>
        <%= tempResultreturnp449 %>
        <%
}
break;
case 451:
        gotMethod = true;
        int returnInteger451mtemp = sampleMainServiceProxyid.returnInteger();
        String tempResultreturnp452 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(returnInteger451mtemp));
        %>
        <%= tempResultreturnp452 %>
        <%
break;
case 454:
        gotMethod = true;
        String i_134id=  request.getParameter("i457");
        int i_134idTemp  = Integer.parseInt(i_134id);
        java.lang.String[] intDynamicArray454mtemp = sampleMainServiceProxyid.intDynamicArray(i_134idTemp);
if(intDynamicArray454mtemp == null){
%>
<%=intDynamicArray454mtemp %>
<%
}else{
        java.util.List listreturnp455= java.util.Arrays.asList(intDynamicArray454mtemp);
        String tempreturnp455 = listreturnp455.toString();
        %>
        <%=tempreturnp455%>
        <%
}
break;
case 459:
        gotMethod = true;
        String iMiladiYear_135id=  request.getParameter("iMiladiYear468");
        int iMiladiYear_135idTemp  = Integer.parseInt(iMiladiYear_135id);
        String iMiladiMonth_136id=  request.getParameter("iMiladiMonth470");
        int iMiladiMonth_136idTemp  = Integer.parseInt(iMiladiMonth_136id);
        String iMiladiDay_137id=  request.getParameter("iMiladiDay472");
        int iMiladiDay_137idTemp  = Integer.parseInt(iMiladiDay_137id);
        com.actionTracking.ShamsiDate miladiToShamsi459mtemp = sampleMainServiceProxyid.miladiToShamsi(iMiladiYear_135idTemp,iMiladiMonth_136idTemp,iMiladiDay_137idTemp);
if(miladiToShamsi459mtemp == null){
%>
<%=miladiToShamsi459mtemp %>
<%
}else{
%>
<TABLE>
<TR>
<TD COLSPAN="3" ALIGN="LEFT">returnp:</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD COLSPAN="2" ALIGN="LEFT">iDay:</TD>
<TD>
<%
if(miladiToShamsi459mtemp != null){
%>
<%=miladiToShamsi459mtemp.getIDay()
%><%}%>
</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD COLSPAN="2" ALIGN="LEFT">iYear:</TD>
<TD>
<%
if(miladiToShamsi459mtemp != null){
%>
<%=miladiToShamsi459mtemp.getIYear()
%><%}%>
</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD COLSPAN="2" ALIGN="LEFT">iMonth:</TD>
<TD>
<%
if(miladiToShamsi459mtemp != null){
%>
<%=miladiToShamsi459mtemp.getIMonth()
%><%}%>
</TD>
</TABLE>
<%
}
break;
case 474:
        gotMethod = true;
        String employeeID_138id=  request.getParameter("employeeID489");
        long employeeID_138idTemp  = Long.parseLong(employeeID_138id);
        String type_139id=  request.getParameter("type491");
        java.lang.String type_139idTemp  = type_139id;
        com.actionTracking.Person getPerson474mtemp = sampleMainServiceProxyid.getPerson(employeeID_138idTemp,type_139idTemp);
if(getPerson474mtemp == null){
%>
<%=getPerson474mtemp %>
<%
}else{
%>
<TABLE>
<TR>
<TD COLSPAN="3" ALIGN="LEFT">returnp:</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD COLSPAN="2" ALIGN="LEFT">location:</TD>
<TD>
<%
if(getPerson474mtemp != null){
java.lang.String typelocation477 = getPerson474mtemp.getLocation();
        String tempResultlocation477 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(typelocation477));
        %>
        <%= tempResultlocation477 %>
        <%
}%>
</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD COLSPAN="2" ALIGN="LEFT">user:</TD>
<TD>
<%
if(getPerson474mtemp != null){
java.lang.String typeuser479 = getPerson474mtemp.getUser();
        String tempResultuser479 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(typeuser479));
        %>
        <%= tempResultuser479 %>
        <%
}%>
</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD COLSPAN="2" ALIGN="LEFT">name:</TD>
<TD>
<%
if(getPerson474mtemp != null){
java.lang.String typename481 = getPerson474mtemp.getName();
        String tempResultname481 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(typename481));
        %>
        <%= tempResultname481 %>
        <%
}%>
</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD COLSPAN="2" ALIGN="LEFT">department:</TD>
<TD>
<%
if(getPerson474mtemp != null){
java.lang.String typedepartment483 = getPerson474mtemp.getDepartment();
        String tempResultdepartment483 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(typedepartment483));
        %>
        <%= tempResultdepartment483 %>
        <%
}%>
</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD COLSPAN="2" ALIGN="LEFT">type:</TD>
<TD>
<%
if(getPerson474mtemp != null){
java.lang.String typetype485 = getPerson474mtemp.getType();
        String tempResulttype485 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(typetype485));
        %>
        <%= tempResulttype485 %>
        <%
}%>
</TD>
<TR>
<TD WIDTH="5%"></TD>
<TD COLSPAN="2" ALIGN="LEFT">family:</TD>
<TD>
<%
if(getPerson474mtemp != null){
java.lang.String typefamily487 = getPerson474mtemp.getFamily();
        String tempResultfamily487 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(typefamily487));
        %>
        <%= tempResultfamily487 %>
        <%
}%>
</TD>
</TABLE>
<%
}
break;
case 493:
        gotMethod = true;
        String user_140id=  request.getParameter("user496");
        java.lang.String user_140idTemp  = user_140id;
        com.actionTracking.Resource[] viewUsedResource493mtemp = sampleMainServiceProxyid.viewUsedResource(user_140idTemp);
if(viewUsedResource493mtemp == null){
%>
<%=viewUsedResource493mtemp %>
<%
}else{
        java.util.List listreturnp494= java.util.Arrays.asList(viewUsedResource493mtemp);
        String tempreturnp494 = listreturnp494.toString();
        %>
        <%=tempreturnp494%>
        <%
}
break;
case 498:
        gotMethod = true;
        String user_141id=  request.getParameter("user501");
        java.lang.String user_141idTemp  = user_141id;
        com.actionTracking.Resource[] viewAvailableResource498mtemp = sampleMainServiceProxyid.viewAvailableResource(user_141idTemp);
if(viewAvailableResource498mtemp == null){
%>
<%=viewAvailableResource498mtemp %>
<%
}else{
        java.util.List listreturnp499= java.util.Arrays.asList(viewAvailableResource498mtemp);
        String tempreturnp499 = listreturnp499.toString();
        %>
        <%=tempreturnp499%>
        <%
}
break;
case 503:
        gotMethod = true;
        String activityID_142id=  request.getParameter("activityID506");
        long activityID_142idTemp  = Long.parseLong(activityID_142id);
        String user_143id=  request.getParameter("user508");
        java.lang.String user_143idTemp  = user_143id;
        String type_144id=  request.getParameter("type510");
        java.lang.String type_144idTemp  = type_144id;
        com.actionTracking.Activity[] getSubsidaryActivity503mtemp = sampleMainServiceProxyid.getSubsidaryActivity(activityID_142idTemp,user_143idTemp,type_144idTemp);
if(getSubsidaryActivity503mtemp == null){
%>
<%=getSubsidaryActivity503mtemp %>
<%
}else{
        java.util.List listreturnp504= java.util.Arrays.asList(getSubsidaryActivity503mtemp);
        String tempreturnp504 = listreturnp504.toString();
        %>
        <%=tempreturnp504%>
        <%
}
break;
case 512:
        gotMethod = true;
        String personUser_145id=  request.getParameter("personUser515");
        java.lang.String personUser_145idTemp  = personUser_145id;
        String personType_146id=  request.getParameter("personType517");
        java.lang.String personType_146idTemp  = personType_146id;
        com.actionTracking.ActivityLogItem[] stateAvoidedChangeOneEmployee512mtemp = sampleMainServiceProxyid.stateAvoidedChangeOneEmployee(personUser_145idTemp,personType_146idTemp);
if(stateAvoidedChangeOneEmployee512mtemp == null){
%>
<%=stateAvoidedChangeOneEmployee512mtemp %>
<%
}else{
        java.util.List listreturnp513= java.util.Arrays.asList(stateAvoidedChangeOneEmployee512mtemp);
        String tempreturnp513 = listreturnp513.toString();
        %>
        <%=tempreturnp513%>
        <%
}
break;
case 519:
        gotMethod = true;
        String managerUser_147id=  request.getParameter("managerUser522");
        java.lang.String managerUser_147idTemp  = managerUser_147id;
        com.actionTracking.ActivityLogItem[] stateAvoidedChangeAllEmployee519mtemp = sampleMainServiceProxyid.stateAvoidedChangeAllEmployee(managerUser_147idTemp);
if(stateAvoidedChangeAllEmployee519mtemp == null){
%>
<%=stateAvoidedChangeAllEmployee519mtemp %>
<%
}else{
        java.util.List listreturnp520= java.util.Arrays.asList(stateAvoidedChangeAllEmployee519mtemp);
        String tempreturnp520 = listreturnp520.toString();
        %>
        <%=tempreturnp520%>
        <%
}
break;
case 524:
        gotMethod = true;
        String managerUser_148id=  request.getParameter("managerUser527");
        java.lang.String managerUser_148idTemp  = managerUser_148id;
        com.actionTracking.ActivityLogItem[] removedActivityReport524mtemp = sampleMainServiceProxyid.removedActivityReport(managerUser_148idTemp);
if(removedActivityReport524mtemp == null){
%>
<%=removedActivityReport524mtemp %>
<%
}else{
        java.util.List listreturnp525= java.util.Arrays.asList(removedActivityReport524mtemp);
        String tempreturnp525 = listreturnp525.toString();
        %>
        <%=tempreturnp525%>
        <%
}
break;
case 529:
        gotMethod = true;
        String managerUser_149id=  request.getParameter("managerUser532");
        java.lang.String managerUser_149idTemp  = managerUser_149id;
        com.actionTracking.ActivityLogItem[] refrenceChangeReport529mtemp = sampleMainServiceProxyid.refrenceChangeReport(managerUser_149idTemp);
if(refrenceChangeReport529mtemp == null){
%>
<%=refrenceChangeReport529mtemp %>
<%
}else{
        java.util.List listreturnp530= java.util.Arrays.asList(refrenceChangeReport529mtemp);
        String tempreturnp530 = listreturnp530.toString();
        %>
        <%=tempreturnp530%>
        <%
}
break;
case 534:
        gotMethod = true;
        String activityID_150id=  request.getParameter("activityID537");
        long activityID_150idTemp  = Long.parseLong(activityID_150id);
        com.actionTracking.ActivityLogItem[] deadLineChangeOfActivity534mtemp = sampleMainServiceProxyid.deadLineChangeOfActivity(activityID_150idTemp);
if(deadLineChangeOfActivity534mtemp == null){
%>
<%=deadLineChangeOfActivity534mtemp %>
<%
}else{
        java.util.List listreturnp535= java.util.Arrays.asList(deadLineChangeOfActivity534mtemp);
        String tempreturnp535 = listreturnp535.toString();
        %>
        <%=tempreturnp535%>
        <%
}
break;
case 539:
        gotMethod = true;
        String activityID_151id=  request.getParameter("activityID542");
        long activityID_151idTemp  = Long.parseLong(activityID_151id);
        com.actionTracking.ActivityLogItem[] allChangesOfActivity539mtemp = sampleMainServiceProxyid.allChangesOfActivity(activityID_151idTemp);
if(allChangesOfActivity539mtemp == null){
%>
<%=allChangesOfActivity539mtemp %>
<%
}else{
        java.util.List listreturnp540= java.util.Arrays.asList(allChangesOfActivity539mtemp);
        String tempreturnp540 = listreturnp540.toString();
        %>
        <%=tempreturnp540%>
        <%
}
break;
case 544:
        gotMethod = true;
        String user_152id=  request.getParameter("user547");
        java.lang.String user_152idTemp  = user_152id;
        String password_153id=  request.getParameter("password549");
        java.lang.String password_153idTemp  = password_153id;
        String type_154id=  request.getParameter("type551");
        java.lang.String type_154idTemp  = type_154id;
        java.lang.String defineUser544mtemp = sampleMainServiceProxyid.defineUser(user_152idTemp,password_153idTemp,type_154idTemp);
if(defineUser544mtemp == null){
%>
<%=defineUser544mtemp %>
<%
}else{
        String tempResultreturnp545 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(defineUser544mtemp));
        %>
        <%= tempResultreturnp545 %>
        <%
}
break;
case 553:
        gotMethod = true;
        String user_155id=  request.getParameter("user556");
        java.lang.String user_155idTemp  = user_155id;
        String oldPassword_156id=  request.getParameter("oldPassword558");
        java.lang.String oldPassword_156idTemp  = oldPassword_156id;
        String type_157id=  request.getParameter("type560");
        java.lang.String type_157idTemp  = type_157id;
        String newPassword_158id=  request.getParameter("newPassword562");
        java.lang.String newPassword_158idTemp  = newPassword_158id;
        java.lang.String changePassowrd553mtemp = sampleMainServiceProxyid.changePassowrd(user_155idTemp,oldPassword_156idTemp,type_157idTemp,newPassword_158idTemp);
if(changePassowrd553mtemp == null){
%>
<%=changePassowrd553mtemp %>
<%
}else{
        String tempResultreturnp554 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(changePassowrd553mtemp));
        %>
        <%= tempResultreturnp554 %>
        <%
}
break;
case 564:
        gotMethod = true;
        String type_159id=  request.getParameter("type567");
        java.lang.String type_159idTemp  = type_159id;
        String user_160id=  request.getParameter("user569");
        java.lang.String user_160idTemp  = user_160id;
        String date_161id=  request.getParameter("date571");
        long date_161idTemp  = Long.parseLong(date_161id);
        com.actionTracking.Activity[] completedActivityTodaySubsidary564mtemp = sampleMainServiceProxyid.completedActivityTodaySubsidary(type_159idTemp,user_160idTemp,date_161idTemp);
if(completedActivityTodaySubsidary564mtemp == null){
%>
<%=completedActivityTodaySubsidary564mtemp %>
<%
}else{
        java.util.List listreturnp565= java.util.Arrays.asList(completedActivityTodaySubsidary564mtemp);
        String tempreturnp565 = listreturnp565.toString();
        %>
        <%=tempreturnp565%>
        <%
}
break;
case 573:
        gotMethod = true;
        String type_162id=  request.getParameter("type576");
        java.lang.String type_162idTemp  = type_162id;
        String user_163id=  request.getParameter("user578");
        java.lang.String user_163idTemp  = user_163id;
        com.actionTracking.Person[] getPersonelOfDepartment573mtemp = sampleMainServiceProxyid.getPersonelOfDepartment(type_162idTemp,user_163idTemp);
if(getPersonelOfDepartment573mtemp == null){
%>
<%=getPersonelOfDepartment573mtemp %>
<%
}else{
        java.util.List listreturnp574= java.util.Arrays.asList(getPersonelOfDepartment573mtemp);
        String tempreturnp574 = listreturnp574.toString();
        %>
        <%=tempreturnp574%>
        <%
}
break;
case 580:
        gotMethod = true;
        String type_164id=  request.getParameter("type583");
        java.lang.String type_164idTemp  = type_164id;
        String user_165id=  request.getParameter("user585");
        java.lang.String user_165idTemp  = user_165id;
        com.actionTracking.Person[] getSubsidaryPersonel580mtemp = sampleMainServiceProxyid.getSubsidaryPersonel(type_164idTemp,user_165idTemp);
if(getSubsidaryPersonel580mtemp == null){
%>
<%=getSubsidaryPersonel580mtemp %>
<%
}else{
        java.util.List listreturnp581= java.util.Arrays.asList(getSubsidaryPersonel580mtemp);
        String tempreturnp581 = listreturnp581.toString();
        %>
        <%=tempreturnp581%>
        <%
}
break;
}
} catch (Exception e) { 
%>
exception: <%= e %>
<%
return;
}
if(!gotMethod){
%>
result: N/A
<%
}
%>
</BODY>
</HTML>