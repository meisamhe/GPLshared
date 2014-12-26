<HTML>
<%@page contentType="text/html;charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<HEAD>
<TITLE>Description</TITLE>
</HEAD>

<BODY>

<CENTER>
<H1>Description:</H1>
<%=request.getParameter("description")%>
</CENTER>
<P>
<CENTER>
<FORM>
<INPUT type="button" value="Close Window" onClick="window.close()">
</FORM>
</CENTER>

</BODY>
</HTML>