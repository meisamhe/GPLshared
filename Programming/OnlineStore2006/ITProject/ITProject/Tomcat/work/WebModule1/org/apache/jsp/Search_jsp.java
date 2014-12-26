package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public final class Search_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static java.util.Vector _jspx_dependants;

  public java.util.List getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    JspFactory _jspxFactory = null;
    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      _jspxFactory = JspFactory.getDefaultFactory();
      response.setContentType("text/html; charset=windows-1256");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("ï»؟\r\n");
      out.write("<html><head>    <title>Search</title>\r\n");
      out.write("\r\n");
      out.write("\t<meta name=\"description\" content=\"Visit the online bookshop of MMM\">\r\n");
      out.write("\t<meta name=\"keywords\" content=\"bookshop, bookstore, author, buy books online, book shop, book store, Australia, self help, computers, Australian, books online\">\r\n");
      out.write("\t<meta name=\"robots\" content=\"index, follow\">\r\n");
      out.write("\t<script language=\"javascript\" src=\"Template2_MMM.com_files/stylesheet.js\" type=\"\"></script><link rel=\"StyleSheet\" href=\"Template2_MMM.com_files/stylesheet_PCEXP.css\" type=\"text/css\">\r\n");
      out.write("\t<script language=\"javascript\" src=\"Template2_MMM.com_files/functions.js\" type=\"\"></script>\r\n");
      out.write("\t<style type=\"text/css\">\r\n");
      out.write("<!--\r\n");
      out.write(".style1 {font-size: 12pt}\r\n");
      out.write(".style2 {\r\n");
      out.write("\tfont-size: 14pt;\r\n");
      out.write("\tcolor: #FFFFFF;\r\n");
      out.write("}\r\n");
      out.write(".style4 {color: #000033}\r\n");
      out.write(".style5 {\r\n");
      out.write("\tcolor: #000066;\r\n");
      out.write("\tfont-weight: bold;\r\n");
      out.write("\tfont-size: 12pt;\r\n");
      out.write("}\r\n");
      out.write(".style6 {\r\n");
      out.write("\ttext-align: right;\r\n");
      out.write("}\r\n");
      out.write("-->\r\n");
      out.write("    </style>\r\n");
      out.write("\t</head>\r\n");
      out.write("  \r\n");
      out.write("  \r\n");
      out.write("  \r\n");
      out.write("  \r\n");
      out.write("  ");
      jdbcMySql.MySqlConnector MySqlObj = null;
      synchronized (session) {
        MySqlObj = (jdbcMySql.MySqlConnector) _jspx_page_context.getAttribute("MySqlObj", PageContext.SESSION_SCOPE);
        if (MySqlObj == null){
          MySqlObj = new jdbcMySql.MySqlConnector();
          _jspx_page_context.setAttribute("MySqlObj", MySqlObj, PageContext.SESSION_SCOPE);
        }
      }
      out.write("\r\n");
      out.write("  ");
      org.apache.jasper.runtime.JspRuntimeLibrary.introspect(_jspx_page_context.findAttribute("MySqlObj"), request);
      out.write("\r\n");
      out.write("\t<body   alink=\"#00563b\" bgcolor=\"#eeeeee\" link=\"#00a651\"   text=\"#999999\" vlink=\"#00563b\">\r\n");
      out.write("\t");

    if (request.getParameter("StuffTable") != null && request.getParameter("StuffID") != null) {
      String StuffTable;
      String StuffID;
      StuffTable = request.getParameter("StuffTable").toLowerCase();
      StuffID = request.getParameter("StuffID").toLowerCase();
      try {
        Connection con = MySqlObj.getDbConnection("mani", "mbh", "3306", "localhost", "3m");
        ResultSet rslt = MySqlObj.runSqlQuery("select * from " + StuffTable + " where ID=" + StuffID, con);
        if (rslt.next()) {
          ArrayList al;
          al = (ArrayList) session.getAttribute("basket");
          al.add(new String[] {StuffTable, StuffID, String.valueOf(1)});
        }
        else { //end if (rslt.next())
          out.println("Stuff is not correct.");
        }
      }
      catch (SQLException e) { //end try
        e.printStackTrace();
      }
      catch (Exception ex) {
        ex.printStackTrace();
      }
    } //end if
    if (request.getParameter("DeleteID") != null) {
      String DeleteID;
      DeleteID = request.getParameter("DeleteID").toLowerCase();
      ArrayList al;
      al = (ArrayList) session.getAttribute("basket");
      al.remove(Integer.parseInt(DeleteID));
    }
  
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!-- HEADER //-->\r\n");
      out.write("<a name=\"top\"></a>\r\n");
      out.write("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"770\">\r\n");
      out.write("<tbody><tr>\r\n");
      out.write("<td bgcolor=\"#00563b\" valign=\"top\" width=\"391\"><a href=\"http://www.angusrobertson.com.au/\" target=\"_top\" onMouseOver=\"window.status=''; return true\" onMouseOut=\"window.status=''; return true\"><img src=\"Template2_MMM.com_files/main01.jpg\" alt=\"Angus &amp; Robertson Book Shop\" border=\"0\" height=\"69\" width=\"391\"></a></td>\r\n");
      out.write("<td align=\"right\" bgcolor=\"#ffffff\" valign=\"top\" width=\"379\">\r\n");
      out.write("\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("\t<tbody><tr>\r\n");
      out.write("\t<td colspan=\"2\" valign=\"top\"><div align=\"right\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"7\" width=\"1\"><br>\r\n");
      out.write("\t    <a href=\"javascript:launchthawte()\" onMouseOver=\"window.status='View SSL Certificate Info'; return true\" onMouseOut=\"window.status=''; return true\">Security by MMM Team &nbsp;&nbsp;<img src=\"Template2_MMM.com_files/header_ssl.gif\" alt=\"View SSL Certificate Info\" align=\"middle\" border=\"0\" height=\"18\" hspace=\"0\" vspace=\"0\" width=\"17\"></a></div></td>\r\n");
      out.write("\t<td valign=\"bottom\" width=\"18\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"18\"></td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t<td valign=\"bottom\">\r\n");
      out.write("\t\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("\t\t<tbody><tr>\r\n");
      out.write("\t\t<td valign=\"bottom\"><a href=\"Cart.jsp\" target=\"_top\" onMouseOver=\"window.status='View Cart'; return true\" onMouseOut=\"window.status=''; return true\"><img src=\"Template2_MMM.com_files/header_viewcart.gif\" alt=\"View Cart\" align=\"middle\" border=\"0\" height=\"12\" width=\"57\"></a></td>\r\n");
      out.write("\t\t<td><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"3\"></td>\r\n");
      out.write("\r\n");
      out.write("\t\t<td valign=\"bottom\">\r\n");
      out.write("\r\n");
      out.write("\t\t<img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"40\">\t\t</td>\r\n");
      out.write("\t\t<td><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"3\"></td>\r\n");
      out.write("\t\t<td valign=\"bottom\"><a href=\"http://www.angusrobertson.com.au/checkout/viewcart.asp\" target=\"_top\" onMouseOver=\"window.status='View Cart'; return true\" onMouseOut=\"window.status=''; return true\"><img src=\"Template2_MMM.com_files/header_cart.gif\" alt=\" Items\" align=\"bottom\" border=\"0\" height=\"20\" width=\"23\"></a></td>\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\t\t</tbody></table>\t</td>\r\n");
      out.write("\t<td align=\"right\" valign=\"bottom\"><a href=\"Credit.jsp\" target=\"_top\" onMouseOver=\"window.status='My Account'; return true\" onMouseOut=\"window.status=''; return true\"><img src=\"Template2_MMM.com_files/header_myaccount.gif\" alt=\"My Account\" border=\"0\" height=\"12\" width=\"67\"></a></td>\r\n");
      out.write("\t<td></td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t</tbody></table></td>\r\n");
      out.write("</tr>\r\n");
      out.write("</tbody></table>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!-- END HEADER //-->\r\n");
      out.write("<!-- NAV //-->\r\n");
      out.write("<table width=\"582\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("<tbody><tr bgcolor=\"#ffffff\" valign=\"middle\"><td colspan=\"12\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td></tr>\r\n");
      out.write("<tr bgcolor=\"#00563b\" valign=\"middle\">\r\n");
      out.write("<td width=\"5\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"5\"></td>\r\n");
      out.write("<td width=\"45\"><a href=\"Home.jsp\" target=\"_top\" onMouseOver=\"document.header_nav_home.src='/images/header_nav_home_o.gif'; window.status='Home'; return true\" onMouseOut=\"window.status=''; return true\"><img src=\"Template2_MMM.com_files/header_nav_home_o.gif\" alt=\"Home\" name=\"header_nav_home\" border=\"0\" height=\"25\" width=\"39\"></a></td>\r\n");
      out.write("<td width=\"1\"><a href=\"http://www.angusrobertson.com.au/products/newreleases.asp\" target=\"_top\" onMouseOver=\"document.header_nav_newreleases.src='/images/header_nav_newreleases_o.gif'; window.status='New releases'; return true\" onMouseOut=\"document.header_nav_newreleases.src='/images/header_nav_newreleases.gif'; window.status=''; return true\"></a></td>\r\n");
      out.write("<td width=\"66\" class=\"titlebig whitelhs style1\"><a href=\"Search.jsp\" target=\"_top\" class=\"style2\" onMouseOver=\"window.status='View Cart'; return true\" onMouseOut=\"window.status=''; return true\"><span class=\"titlebig whitelhs style1\">Search </span> </a></td>\r\n");
      out.write("<td width=\"47\"><span class=\"titlebig whitelhs style1\"> <a href=\"Cart.jsp\" target=\"_top\" onMouseOver=\"window.status='View Cart'; return true\" onMouseOut=\"window.status=''; return true\"><span class=\"titlebig whitelhs style1\">Cart </span> </a></td>\r\n");
      out.write("<td width=\"62\"><span class=\"titlebig whitelhs style1\"> <a href=\"Credit.jsp\" target=\"_top\" onMouseOver=\"window.status='View Cart'; return true\" onMouseOut=\"window.status=''; return true\"><span class=\"titlebig whitelhs style1\">credit </span></a></td>\r\n");
      out.write("<td width=\"50\"><a href=\"Login.jsp\" target=\"_top\" onMouseOver=\"window.status='View Cart'; return true\" onMouseOut=\"window.status=''; return true\">\r\n");
      out.write("<span class=\"titlebig whitelhs style1\">log in </span>\r\n");
      out.write("</a></td>\r\n");
      out.write("<td width=\"78\"><a href=\"Signup.jsp\" target=\"_top\" onMouseOver=\"window.status='View Cart'; return true\" onMouseOut=\"window.status=''; return true\"><span class=\"titlebig whitelhs style1\">edit info </span></a></td>\r\n");
      out.write("<td width=\"98\"><a href=\"Contactus.jsp\" target=\"_top\" onMouseOver=\"window.status='View Cart'; return true\" onMouseOut=\"window.status=''; return true\"><span class=\"titlebig whitelhs style1\">contact us </span></a></td>\r\n");
      out.write("<td width=\"61\"><a href=\"History.jsp\" target=\"_top\" onMouseOver=\"window.status='View Cart'; return true\" onMouseOut=\"window.status=''; return true\"><span class=\"titlebig whitelhs style1\" >History</span></a></td>\r\n");
      out.write("<td width=\"41\">&nbsp;</td>\r\n");
      out.write("<td width=\"28\">&nbsp;</td>\r\n");
      out.write("</tr>\r\n");
      out.write("<tr bgcolor=\"#ffffff\" valign=\"middle\"><td colspan=\"12\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td></tr>\r\n");
      out.write("<tr bgcolor=\"#00563b\" valign=\"middle\"><td colspan=\"12\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td></tr>\r\n");
      out.write("</tbody></table>\r\n");
      out.write("<img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"5\">\r\n");
      out.write("<!-- END NAV//-->\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"780\">\r\n");
      out.write("<tbody><tr>\r\n");
      out.write("<td bgcolor=\"#ffffff\" valign=\"top\" width=\"144\">\r\n");
      out.write("\r\n");
      out.write("\t<!-- LEFT HAND SIDE //-->\r\n");
      out.write("\t<script language=\"javascript\" type=\"\">\r\n");
      out.write("\t<!--\r\n");
      out.write("\tfunction Form_ValidatorLHSSubmit(SubmitType) {\r\n");
      out.write("\t\ttheForm = document.lhsform;\r\n");
      out.write("\t\tif (Form_ValidatorLHS(theForm, SubmitType)) {\r\n");
      out.write("\t\t\ttheForm.submit();\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("\tfunction Form_ValidatorLHS(theForm, SubmitType) {\r\n");
      out.write("\t\tif (SubmitType.toLowerCase() == \"search\") {\r\n");
      out.write("\t\t\ttheForm.action = \"/search/results.asp\"\r\n");
      out.write("\t\t\t// Validation script for field 'searchbycriteria' (Search Term)\r\n");
      out.write("if (theForm.searchbycriteria.value == \"\")\r\n");
      out.write("{\r\n");
      out.write("\talert(\"Please enter a value for the \\\"Search Term\\\" field.\");\r\n");
      out.write("   theForm.searchbycriteria.focus();\r\n");
      out.write("   return (false);\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("\t\tif (theForm.searchbycriteria.value.length < 1)\r\n");
      out.write("  \t{\r\n");
      out.write("     \talert(\"Please enter at least 1 characters in the \\\"Search Term\\\" field.\");\r\n");
      out.write("     \ttheForm.searchbycriteria.focus();\r\n");
      out.write("     \treturn (false);\r\n");
      out.write("  \t}\r\n");
      out.write("\r\n");
      out.write("  \tif (theForm.searchbycriteria.value.length > 200)\r\n");
      out.write("  \t{\r\n");
      out.write("     \talert(\"Please enter at most 200 characters in the \\\"Search Term\\\" field.\");\r\n");
      out.write("     \ttheForm.searchbycriteria.focus();\r\n");
      out.write("     \treturn (false);\r\n");
      out.write("  \t}\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t} else {\r\n");
      out.write("\t\t\ttheForm.action = \"/myaccount/login.asp\"\r\n");
      out.write("\t\t\t  // Email field validation\r\n");
      out.write("// Validation script for field 'email' (subscribing)\r\n");
      out.write("if (theForm.email.value == \"\")\r\n");
      out.write("{\r\n");
      out.write("\talert(\"Please enter a value for the \\\"subscribing\\\" field.\");\r\n");
      out.write("   theForm.email.focus();\r\n");
      out.write("   return (false);\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("\t\tif (theForm.email.value.length < 1)\r\n");
      out.write("  \t{\r\n");
      out.write("     \talert(\"Please enter at least 1 characters in the \\\"subscribing\\\" field.\");\r\n");
      out.write("     \ttheForm.email.focus();\r\n");
      out.write("     \treturn (false);\r\n");
      out.write("  \t}\r\n");
      out.write("\r\n");
      out.write("  \tif (theForm.email.value.length > 150)\r\n");
      out.write("  \t{\r\n");
      out.write("     \talert(\"Please enter at most 150 characters in the \\\"subscribing\\\" field.\");\r\n");
      out.write("     \ttheForm.email.focus();\r\n");
      out.write("     \treturn (false);\r\n");
      out.write("  \t}\r\n");
      out.write("\r\n");
      out.write("  if (theForm.email.value.indexOf(\"@\",1) == -1)\r\n");
      out.write("  {\r\n");
      out.write("    alert(\"Not a valid e-mail address for subscribing.\");\r\n");
      out.write("    theForm.email.focus();\r\n");
      out.write("    return (false);\r\n");
      out.write("  }\r\n");
      out.write("\r\n");
      out.write("  if (theForm.email.value.indexOf(\".\",theForm.email.value.indexOf(\"@\")+1) == -1)\r\n");
      out.write("  {\r\n");
      out.write("    alert(\"Not a valid e-mail address for subscribing.\");\r\n");
      out.write("    theForm.email.focus();\r\n");
      out.write("    return (false);\r\n");
      out.write("  }\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\treturn true;\r\n");
      out.write("\t}\r\n");
      out.write("\t//-->\r\n");
      out.write("\t</script>\r\n");
      out.write("\t<form method=\"get\" action=\"/search/results.asp\">\r\n");
      out.write("\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"144\">\r\n");
      out.write("\t<tbody><tr>\r\n");
      out.write("\t<td valign=\"top\" width=\"9\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"9\"></td>\r\n");
      out.write("\t<td colspan=\"2\" valign=\"top\" width=\"126\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"18\" width=\"1\"></td>\r\n");
      out.write("\t<td valign=\"top\" width=\"9\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"9\"></td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t<td></td>\r\n");
      out.write("\t<td colspan=\"2\" valign=\"top\"><img src=\"Template2_MMM.com_files/left_search.gif\" alt=\"Search\" border=\"0\" height=\"17\" width=\"47\"><br>                    <form action=\"Search.jsp\" method=\"post\" >\r\n");
      out.write("                      <input name=\"key\" value=\"\" class=\"lhstext126\" size=\"12\" type=\"text\">\r\n");
      out.write("                    \t</form></td>\r\n");
      out.write("\t<td></td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t<td></td>\r\n");
      out.write("\t<td valign=\"top\" class=\"style6\">\r\n");
      out.write("                    \t<input name=\"Submit2\" type=\"submit\" value=\"Search\"></td>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr><td colspan=\"4\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"8\" width=\"1\"></td></tr>\r\n");
      out.write("\t<tr><td colspan=\"4\" bgcolor=\"#cccccc\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td></tr>\r\n");
      out.write("\r\n");
      out.write("  </tbody></table>\r\n");
      out.write("\t</form>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t<table bgcolor=\"#00563b\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"144\">\r\n");
      out.write("\t<tbody><tr>\r\n");
      out.write("\t<td valign=\"top\" width=\"9\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"9\"></td>\r\n");
      out.write("\t<td valign=\"top\" width=\"135\"><span class=\"titlebig whitelhs style1\">Product</span></td>\r\n");
      out.write("\t<td><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t<td><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n");
      out.write("\t<td class=\"whitelhs\" valign=\"top\">\r\n");
      out.write("\t-  <a href=\"http://www.angusrobertson.com.au/products/top100.asp\" class=\"whitelhs\">CD</a><br>\r\n");
      out.write("\t-  <a href=\"http://www.angusrobertson.com.au/products/bestsellers.asp\" class=\"whitelhs\">Book</a><br>\r\n");
      out.write("\t-  <a href=\"http://www.angusrobertson.com.au/products/GuaranteedGreatReads.asp\" class=\"whitelhs\">Stationary</a><br>\r\n");
      out.write("\t<br>\r\n");
      out.write("\t<br><a href=\"http://www.angusrobertson.com.au/products/categories.asp\" class=\"whitelhs\">View All Categories</a></td>\r\n");
      out.write("\t<td><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t<td colspan=\"3\" valign=\"top\"><img src=\"Template2_MMM.com_files/left_fade.gif\" alt=\"\" border=\"0\" height=\"250\" width=\"144\"></td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t</tbody></table>\r\n");
      out.write("\t<!-- END LEFT HAND SIDE //-->\r\n");
      out.write("\r\n");
      out.write("</td>\r\n");
      out.write("<td bgcolor=\"#999999\" valign=\"top\" width=\"1\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n");
      out.write("<td valign=\"top\" width=\"10\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"10\"></td>\r\n");
      out.write("<td valign=\"top\" width=\"625\">\r\n");
      out.write("<!-- MAIN CONTENT //-->\r\n");
      out.write("<img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"18\" width=\"1\"><br>\r\n");
      out.write("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"625\">\r\n");
      out.write("<tbody><tr>\r\n");
      out.write("<td valign=\"top\">\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("\t<tbody><tr><td colspan=\"3\" bgcolor=\"#cccccc\" valign=\"top\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"260\"></td></tr>\r\n");
      out.write("<!--\t<tr>\r\n");
      out.write("\t<td valign=\"top\" bgcolor=\"#CCCCCC\" colspan=\"1\"><img src=\"images/gap.gif\" width=\"1\" height=\"1\" alt=\"\" border=\"0\"></td>\r\n");
      out.write("\t<td align=\"center\" valign=\"top\" bgcolor=\"#FFFFFF\" width=\"100%\">\r\n");
      out.write("\t\t<table cellspacing=\"9\" width=\"100%\"><tr>\r\n");
      out.write("\t\t\t<td valign=\"top\" bgcolor=\"#00563B\" colspan=\"2\"><img src=\"images/gap.gif\" width=\"4\" height=\"1\" alt=\"\" border=\"0\"><img src=\"images/title_octcat.gif\" height=\"25\" alt=\"MMM November Catalogue\" border=\"0\"></td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t</table>\r\n");
      out.write("\t</td>\r\n");
      out.write("\t<td valign=\"top\" bgcolor=\"#CCCCCC\"><img src=\"images/gap.gif\" width=\"1\" height=\"1\" alt=\"\" border=\"0\"></td>\r\n");
      out.write("\t</tr>-->\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t<td bgcolor=\"#cccccc\" valign=\"top\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n");
      out.write("\t<td align=\"center\" bgcolor=\"#ffffff\" valign=\"top\"><a href=\"http://top100.angusrobertson.com.au/\" target=\"_blank\"><img src=\"Template2_MMM.com_files/kirkdale_bookshop_01.jpg\" border=\"0\" height=\"178\" hspace=\"4\" vspace=\"4\" width=\"200\" alt=\"\"></a></td>\r\n");
      out.write("\t<td bgcolor=\"#cccccc\" valign=\"top\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr><td colspan=\"3\" bgcolor=\"#cccccc\" valign=\"top\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td></tr>\r\n");
      out.write("\t</tbody></table>\r\n");
      out.write("<!--\r\n");
      out.write("\t<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\r\n");
      out.write("\t<tr><td valign=\"top\" colspan=\"3\" bgcolor=\"#CCCCCC\"><img src=\"images/gap.gif\" width=\"260\" height=\"1\" alt=\"\" border=\"0\"></td></tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t<td valign=\"top\" bgcolor=\"#CCCCCC\"><img src=\"images/gap.gif\" width=\"1\" height=\"1\" alt=\"\" border=\"0\"></td>\r\n");
      out.write("\t<td valign=\"top\" bgcolor=\"#FFFFFF\"><a href=\"#\"><img src=\"images/arjan.gif\" width=\"250\" height=\"198\" alt=\"Angus & Robertson Online\" border=\"0\" hspace=\"4\" vspace=\"4\"></a></td>\r\n");
      out.write("\t<td valign=\"top\" bgcolor=\"#FFFFFF\"><a href=\"#\"><img src=\"images/random1.jpg\" width=\"250\" height=\"215\" alt=\"Angus & Robertson Online\" border=\"0\" hspace=\"4\" vspace=\"4\"></a></td>-->\r\n");
      out.write("<!--\t<td valign=\"top\" bgcolor=\"#FFFFFF\"><a href=\"http://www.booksalive.com.au/\" target=\"blank\"><img src=\"images/books-alive.gif\" width=\"250\" height=\"198\" alt=\"Kids' Top 50\" border=\"0\" hspace=\"4\" vspace=\"4\"></a></td>\r\n");
      out.write("\t<td valign=\"top\" bgcolor=\"#CCCCCC\"><img src=\"images/gap.gif\" width=\"1\" height=\"1\" alt=\"\" border=\"0\"></td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t<tr><td valign=\"top\" colspan=\"3\" bgcolor=\"#CCCCCC\"><img src=\"images/gap.gif\" width=\"1\" height=\"1\" alt=\"\" border=\"0\"></td></tr>\r\n");
      out.write("\t</table>\r\n");
      out.write("-->\r\n");
      out.write("\r\n");
      out.write("</td>\r\n");
      out.write("<td valign=\"top\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"10\"></td>\r\n");
      out.write("<td valign=\"top\">\r\n");
      out.write("\r\n");
      out.write("\t\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("\t<tbody><tr><td colspan=\"3\" bgcolor=\"#cccccc\" valign=\"top\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"356\"></td></tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t<td bgcolor=\"#cccccc\" valign=\"top\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n");
      out.write("\t\t<td align=\"center\" bgcolor=\"#ffffff\" valign=\"top\" width=\"100%\"><a href=\"http://www.angusrobertson.com.au/products/harrypotter.asp\"><img src=\"Template2_MMM.com_files/n-cdshop.gif\"  alt=\"A&amp;R Win! Promotion\" border=\"0\" height=\"177\" hspace=\"4\" vspace=\"4\" width=\"211\"></a></td>\r\n");
      out.write("\t\t<!--<td align=\"center\" valign=\"top\" bgcolor=\"#FFFFFF\" width=\"100%\"><img src=\"images/Big-Book-Sale1.gif\" width=\"345\" height=\"198\" alt=\"MMM Big Book Sale\" border=\"0\" hspace=\"4\" vspace=\"4\"></a></td>-->\r\n");
      out.write("\t<td bgcolor=\"#cccccc\" valign=\"top\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr><td colspan=\"3\" bgcolor=\"#cccccc\" valign=\"top\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"356\"></td></tr>\r\n");
      out.write("\t</tbody></table>\r\n");
      out.write("</td>\r\n");
      out.write("</tr>\r\n");
      out.write("</tbody></table>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"9\" width=\"1\">\r\n");
      out.write("\r\n");
      out.write("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"625\">\r\n");
      out.write("<tbody><tr bgcolor=\"#cccccc\">\r\n");
      out.write("<td valign=\"top\" width=\"1\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n");
      out.write("<td valign=\"top\" width=\"6\">&nbsp;</td>\r\n");
      out.write("<td valign=\"top\" width=\"1\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n");
      out.write("<td valign=\"top\" width=\"616\">&nbsp;</td>\r\n");
      out.write("<td valign=\"top\" width=\"1\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n");
      out.write("</tr>\r\n");
      out.write("\r\n");
      out.write("<tr bgcolor=\"#cccccc\">\r\n");
      out.write("<td valign=\"top\" width=\"1\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n");
      out.write("<td bgcolor=\"#ffffff\" valign=\"top\" width=\"6\"><span class=\"style4\"></span></td>\r\n");
      out.write("<td valign=\"top\" width=\"1\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" width=\"1\" height=\"1\" border=\"0\"></td>\r\n");
      out.write("<td bgcolor=\"#ffffff\" valign=\"top\" width=\"616\"><p class=\"style5\">      Please insert your query\r\n");
      out.write("    </p>\r\n");
      out.write("    <form action=\"Search.jsp\" method=\"get\" class=\"style4\">\r\n");
      out.write("      <input name=\"searchString\" type=\"text\" style=\"width: 310px\"/>\r\n");
      out.write("      <input name=\"Submit1\" type=\"submit\" value=\"Search\"/>\r\n");
      out.write("    </form>\r\n");
      out.write("    <span class=\"style4\">\r\n");
      out.write("    ");

    if (request.getParameter("searchString") != null) {
      String key;
      key = (String) request.getParameter("searchString");
      try {
        Connection con = MySqlObj.getDbConnection("mani", "mbh", "3306", "localhost", "3m");
        //Select from Books
        String sql = "select * from books where name like '%" + key + "%' or writer like '%";
        sql += key + "%' or publisher like '%" + key + "%' or description like '%" + key + "%'";
        ResultSet rslt = MySqlObj.runSqlQuery(sql, con);
        System.out.println(sql);
        while (rslt.next()) {
          out.println("<br>" + "Name: " + rslt.getString("NAME") + "<br>");
          out.println("WRITER: " + rslt.getString("WRITER") + "<br>");
          out.println("PUBLISHER: " + rslt.getString("PUBLISHER") + "<br>");
          out.println("EDITION: " + String.valueOf(rslt.getInt("EDITION")) + "<br>");
          out.println("PRICE: " + String.valueOf(rslt.getDouble("PRICE")) + "<br>");
          out.println("<a href=\"buyBasket.jsp?StuffTable=books" + "&StuffID=" + rslt.getString("ID") + "\">Add To Basket</a>");
        }
        //Select from CDs
        sql = "select * from cds where name like '%" + key + "%' or title like '%";
        sql += key + "%' or publisher like '%" + key + "%' or description like '%" + key + "%'";
        rslt.close();
        rslt = MySqlObj.runSqlQuery(sql, con);
        System.out.println(sql);
        while (rslt.next()) {
          out.println("<br>" + "TITLE: " + rslt.getString("TITLE") + "<br>");
          out.println("NAME: " + rslt.getString("NAME") + "<br>");
          out.println("PUBLISHER: " + rslt.getString("PUBLISHER") + "<br>");
          out.println("PRICE: " + String.valueOf(rslt.getDouble("PRICE")) + "<br>");
          out.println("<a href=\"buyBasket.jsp?StuffTable=cds" + "&StuffID=" + rslt.getString("ID") + "\">Add To Basket</a>");
        }
        //Select from Stationaries
        sql = "select * from stationaries where name like '%" + key + "%' or manufactured_by like '%";
        sql += key + "%' or description like '%" + key + "%'";
        rslt.close();
        rslt = MySqlObj.runSqlQuery(sql, con);
        System.out.println(sql);
        while (rslt.next()) {
          out.println("NAME: " + rslt.getString("NAME") + "<br>");
          out.println("MANUFACTURED_BY: " + rslt.getString("MANUFACTURED_BY") + "<br>");
          out.println("PRICE: " + String.valueOf(rslt.getDouble("PRICE")) + "<br>");
          out.println("<a href=\"buyBasket.jsp?StuffTable=stationaries" + "&StuffID=" + rslt.getString("ID") + "\">Add To Basket</a>");
        }
        rslt.close();
      }
      catch (Exception ex) {
        System.out.println(ex.getMessage());
      }
    }
    else
      System.out.println("parameter null");
  
      out.write("\r\n");
      out.write("    </span></td>\r\n");
      out.write("<td valign=\"top\" width=\"1\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n");
      out.write("</tr>\r\n");
      out.write("\r\n");
      out.write("<tr bgcolor=\"#cccccc\">\r\n");
      out.write("<td valign=\"top\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n");
      out.write("<td bgcolor=\"#ffffff\" valign=\"top\">&nbsp;</td>\r\n");
      out.write("<td valign=\"top\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n");
      out.write("<td align=\"right\" bgcolor=\"#ffffff\" valign=\"bottom\">&nbsp;</td>\r\n");
      out.write("<td valign=\"bottom\"><img src=\"Template2_MMM.com_files/gapEEEEEE.gif\" alt=\"\" border=\"0\" height=\"26\" width=\"1\"></td>\r\n");
      out.write("</tr>\r\n");
      out.write("<tr bgcolor=\"#cccccc\"><td colspan=\"5\" align=\"right\" valign=\"top\"><img src=\"Template2_MMM.com_files/gapEEEEEE.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"13\"></td></tr>\r\n");
      out.write("</tbody></table>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<br><br>\r\n");
      out.write("<!-- END MAIN CONTENT //-->\r\n");
      out.write("</td>\r\n");
      out.write("</tr>\r\n");
      out.write("</tbody><!-- FOOTER //-->\r\n");
      out.write("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"780\">\r\n");
      out.write("<tbody><tr valign=\"top\"><td colspan=\"4\" bgcolor=\"#ffffff\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td></tr>\r\n");
      out.write("\r\n");
      out.write("<tr bgcolor=\"#00563b\" valign=\"middle\">\r\n");
      out.write("<td width=\"14\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"17\" width=\"14\"></td>\r\n");
      out.write("<td class=\"white\" width=\"376\">آ© Copyright MMM 2007</td>\r\n");
      out.write("<td align=\"right\" width=\"376\"><a href=\"javascript:privacypolicy()\" class=\"footer\">Privacy Policy</a><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"15\"><a href=\"javascript:termsofuse()\" class=\"footer\">Terms of Use</a></td>\r\n");
      out.write("<td width=\"14\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"14\"></td>\r\n");
      out.write("</tr>\r\n");
      out.write("\r\n");
      out.write("<tr valign=\"top\"><td colspan=\"4\" bgcolor=\"#00563b\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td></tr>\r\n");
      out.write("<tr valign=\"top\"><td colspan=\"4\" bgcolor=\"#ffffff\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td></tr>\r\n");
      out.write("<tr valign=\"top\"><td colspan=\"4\" bgcolor=\"#00563b\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td></tr>\r\n");
      out.write("<tr valign=\"top\"><td colspan=\"4\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"2\" width=\"1\"></td></tr>\r\n");
      out.write("\r\n");
      out.write("<tr valign=\"top\">\r\n");
      out.write("<td></td>\r\n");
      out.write("<td class=\"grey666666\">WWW.MMM.COM</td>\r\n");
      out.write("<td class=\"grey666666\" align=\"right\">Site designed by <a href=\"http://www.spin.com.au/\" target=\"_blank\" class=\"darkgreen\">MMM</a></td>\r\n");
      out.write("<td></td>\r\n");
      out.write("</tr>\r\n");
      out.write("\r\n");
      out.write("</tbody></table>\r\n");
      out.write("<!-- EOF -->\r\n");
      out.write("</body></html>\r\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
      }
    } finally {
      if (_jspxFactory != null) _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
