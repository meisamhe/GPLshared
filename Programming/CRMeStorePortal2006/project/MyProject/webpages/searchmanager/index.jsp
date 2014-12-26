<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page import="javax.portlet.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="searchmanager.CatNode" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%@ taglib prefix="vlh"          uri="http://valuelist.sourceforge.net/tags-valuelist" %>
<%@ taglib prefix="c"           uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="portlet"     uri="http://java.sun.com/portlet" %>
<%@ taglib prefix="fmt"         uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<portlet:renderURL var="renderPortlet">
    <portlet:param name="command" value="ShowAddBranchPage"/>
</portlet:renderURL>
<%
	ArrayList path=(ArrayList)request.getAttribute("path");
	ArrayList options=(ArrayList)request.getAttribute("options");
	String tmpTab=".";
	if(path==null)
		path=new ArrayList();
	if(options==null)
		options=new ArrayList();
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>E-Store</title>
<style type="text/css">
<!--
body { 
	
	background-position: top ;
	border:#CCCCCC;
	background-image:url(images/backback.gif);
}
-->
</style>
<body  >
<table cellpadding="0" cellspacing="0" width="700" border="2" align="center">
  <tr>
    <td background="images/topbg.gif" width="700" height="150" ><p align="right"><img src="images/logofilm.gif"/></p> </td>
  </tr>
  <tr>
    <td background="images/back.gif" width="700" height="500" valign="top">
	
	<table border="3"   cellpadding="5" cellspacing="5" width="700" >
		<tr>
			<td align="right">
			<form>
				Search the product you want :
				<input type="text" name="search" width="30" /><input type="image" align="top"  src="images/go-button-help.gif" value=" Go " />
			</form>
		  	</td>
		</tr>
		<tr>
			<td>
                <table border = "0">
                <form method="post" action="${renderPortlet}">
                <%for(int i=path.size()-1;i>=0;i--){%>
                <tr>
                    <td>
                        <%
                            String tmpStr=tmpTab+"  "+( (CatNode)(path.get(i)) ).getName();
                            tmpTab+="...";
                            int intId=( (CatNode)(path.get(i)) ).getIndex();
                            String strId=new Integer(intId).toString();
							String curName=((CatNode)(path.get(i))).getName();
                        %>
						<%if (curName!=null && curName.equals("Musics")){ %>
						<img  align="left" src="/MyProject/webpages/images/sol.gif"/>
						<%}else if (curName!=null && curName.equals("Books")){%>
						<img  align="left" src="/MyProject/webpages/images/book.gif"/>
						<%}else if(curName!=null) 
							curName.equals("Movies");
						%>
						<img  align="left" src=""/>
                        <a href="<portlet:renderURL>
    								<portlet:param name="category_" value="<%=strId%>"/>
								 </portlet:renderURL>"><%=tmpStr%></a>
                    </td>
                </tr>
                <%}%>
                </table>
			  	<select name="category" style="word-spacing:normal ">
			  		<%for(int i=0;i<options.size();i++){%>
				  		<%CatNode curOption=(CatNode)options.get(i);%>
						<option  value="<%=curOption.getIndex()%>" ><%=curOption%></option>
					<%}%>
			  	</select>
			 	<input type="image" align="top" src="images/go-button.gif" value=" Go "/>
           	 </form>
			 
				</td>
			</tr>
		</table>
		<p align="center">
		<input type="image" src="images1/zard.gif" style="border-style:inset " style="border-color:#CCCCCC " border="2" />	
		</p>
	</td>
  </tr>
</table>
</body>
</html>
