package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.io.*;

public final class StuffInformation_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("ï»؟\r\n<html><head><title>StuffInformation</title>\r\n\r\n\r\n\r\n\t<meta name=\"description\" content=\"Visit the online bookshop of MMM\">\r\n\t<meta name=\"keywords\" content=\"bookshop, bookstore, author, buy books online, book shop, book store, Australia, self help, computers, Australian, books online\">\r\n\t<meta name=\"robots\" content=\"index, follow\">\r\n\t<script language=\"javascript\" src=\"Template2_MMM.com_files/stylesheet.js\" type=\"\"></script><link rel=\"StyleSheet\" href=\"Template2_MMM.com_files/stylesheet_PCEXP.css\" type=\"text/css\">\r\n\t<script language=\"javascript\" src=\"Template2_MMM.com_files/functions.js\" type=\"\"></script>\r\n\t<style type=\"text/css\">\r\n<!--\r\n.style1 {font-size: 12pt}\r\n.style2 {\r\n\tfont-size: 14pt;\r\n\tcolor: #FFFFFF;\r\n}\r\n.style3 {\r\n\ttext-align: right;\r\n}\r\n-->\r\n    </style>\r\n\t</head>\r\n\t\r\n  \r\n  \r\n  \r\n  ");
      jdbcMySql.MySqlConnector MySqlObj = null;
      synchronized (_jspx_page_context) {
        MySqlObj = (jdbcMySql.MySqlConnector) _jspx_page_context.getAttribute("MySqlObj", PageContext.PAGE_SCOPE);
        if (MySqlObj == null){
          MySqlObj = new jdbcMySql.MySqlConnector();
          _jspx_page_context.setAttribute("MySqlObj", MySqlObj, PageContext.PAGE_SCOPE);
        }
      }
      out.write("\r\n  ");
      org.apache.jasper.runtime.JspRuntimeLibrary.introspect(_jspx_page_context.findAttribute("MySqlObj"), request);
      out.write("\r\n  <body   alink=\"#00563b\" bgcolor=\"#eeeeee\" link=\"#00a651\"   text=\"#999999\" vlink=\"#00563b\">\r\n\r\n<!-- HEADER //-->\r\n<a name=\"top\"></a>\r\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"770\">\r\n<tbody><tr>\r\n<td bgcolor=\"#00563b\" valign=\"top\" width=\"391\"><a href=\"http://www.angusrobertson.com.au/\" target=\"_top\" onMouseOver=\"window.status=''; return true\" onMouseOut=\"window.status=''; return true\"><img src=\"Template2_MMM.com_files/main01.jpg\" alt=\"Angus &amp; Robertson Book Shop\" border=\"0\" height=\"69\" width=\"391\"></a></td>\r\n<td align=\"right\" bgcolor=\"#ffffff\" valign=\"top\" width=\"379\">\r\n\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n\t<tbody><tr>\r\n\t<td colspan=\"2\" valign=\"top\"><div align=\"right\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"7\" width=\"1\"><br>\r\n\t    <a href=\"javascript:launchthawte()\" onMouseOver=\"window.status='View SSL Certificate Info'; return true\" onMouseOut=\"window.status=''; return true\">Security by MMM Team &nbsp;&nbsp;<img src=\"Template2_MMM.com_files/header_ssl.gif\" alt=\"View SSL Certificate Info\" align=\"middle\" border=\"0\" height=\"18\" hspace=\"0\" vspace=\"0\" width=\"17\"></a></div></td>\r\n");
      out.write("\t<td valign=\"bottom\" width=\"18\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"18\"></td>\r\n\t</tr>\r\n\t<tr>\r\n\t<td valign=\"bottom\">\r\n\t\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n\t\t<tbody><tr>\r\n\t\t<td valign=\"bottom\"><a href=\"Cart.jsp\" target=\"_top\" onMouseOver=\"window.status='View Cart'; return true\" onMouseOut=\"window.status=''; return true\"><img src=\"Template2_MMM.com_files/header_viewcart.gif\" alt=\"View Cart\" align=\"middle\" border=\"0\" height=\"12\" width=\"57\"></a></td>\r\n\t\t<td><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"3\"></td>\r\n\r\n\t\t<td valign=\"bottom\">\r\n\r\n\t\t<img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"40\">\t\t</td>\r\n\t\t<td><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"3\"></td>\r\n\t\t<td valign=\"bottom\"><a href=\"http://www.angusrobertson.com.au/checkout/viewcart.asp\" target=\"_top\" onMouseOver=\"window.status='View Cart'; return true\" onMouseOut=\"window.status=''; return true\"><img src=\"Template2_MMM.com_files/header_cart.gif\" alt=\" Items\" align=\"bottom\" border=\"0\" height=\"20\" width=\"23\"></a></td>\r\n");
      out.write("\t\t</tr>\r\n\t\t</tbody></table>\t</td>\r\n\t<td align=\"right\" valign=\"bottom\"><a href=\"Credit.jsp\" target=\"_top\" onMouseOver=\"window.status='My Account'; return true\" onMouseOut=\"window.status=''; return true\"><img src=\"Template2_MMM.com_files/header_myaccount.gif\" alt=\"My Account\" border=\"0\" height=\"12\" width=\"67\"></a></td>\r\n\t<td></td>\r\n\t</tr>\r\n\t</tbody></table></td>\r\n</tr>\r\n</tbody></table>\r\n\r\n\r\n\r\n<!-- END HEADER //-->\r\n<!-- NAV //-->\r\n<table width=\"582\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n<tbody><tr bgcolor=\"#ffffff\" valign=\"middle\"><td colspan=\"12\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td></tr>\r\n<tr bgcolor=\"#00563b\" valign=\"middle\">\r\n<td width=\"5\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"5\"></td>\r\n<td width=\"45\"><a href=\"Home.jsp\" target=\"_top\" onMouseOver=\"document.header_nav_home.src='/images/header_nav_home_o.gif'; window.status='Home'; return true\" onMouseOut=\"window.status=''; return true\"><img src=\"Template2_MMM.com_files/header_nav_home_o.gif\" alt=\"Home\" name=\"header_nav_home\" border=\"0\" height=\"25\" width=\"39\"></a></td>\r\n");
      out.write("<td width=\"1\"><a href=\"http://www.angusrobertson.com.au/products/newreleases.asp\" target=\"_top\" onMouseOver=\"document.header_nav_newreleases.src='/images/header_nav_newreleases_o.gif'; window.status='New releases'; return true\" onMouseOut=\"document.header_nav_newreleases.src='/images/header_nav_newreleases.gif'; window.status=''; return true\"></a></td>\r\n<td width=\"66\" class=\"titlebig whitelhs style1\"><a href=\"Search.jsp\" target=\"_top\" class=\"style2\" onMouseOver=\"window.status='View Cart'; return true\" onMouseOut=\"window.status=''; return true\"><span class=\"titlebig whitelhs style1\">Search </span> </a></td>\r\n<td width=\"47\"><span class=\"titlebig whitelhs style1\"> <a href=\"Cart.jsp\" target=\"_top\" onMouseOver=\"window.status='View Cart'; return true\" onMouseOut=\"window.status=''; return true\"><span class=\"titlebig whitelhs style1\">Cart </span> </a></td>\r\n<td width=\"62\"><span class=\"titlebig whitelhs style1\"> <a href=\"Credit.jsp\" target=\"_top\" onMouseOver=\"window.status='View Cart'; return true\" onMouseOut=\"window.status=''; return true\"><span class=\"titlebig whitelhs style1\">credit </span></a></td>\r\n");
      out.write("<td width=\"50\"><a href=\"Login.jsp\" target=\"_top\" onMouseOver=\"window.status='View Cart'; return true\" onMouseOut=\"window.status=''; return true\">\r\n<span class=\"titlebig whitelhs style1\">log in </span>\r\n</a></td>\r\n<td width=\"78\"><a href=\"Signup.jsp\" target=\"_top\" onMouseOver=\"window.status='View Cart'; return true\" onMouseOut=\"window.status=''; return true\"><span class=\"titlebig whitelhs style1\">edit info </span></a></td>\r\n<td width=\"98\"><a href=\"Contactus.jsp\" target=\"_top\" onMouseOver=\"window.status='View Cart'; return true\" onMouseOut=\"window.status=''; return true\"><span class=\"titlebig whitelhs style1\">contact us </span></a></td>\r\n<td width=\"61\"><a href=\"History.jsp\" target=\"_top\" onMouseOver=\"window.status='View Cart'; return true\" onMouseOut=\"window.status=''; return true\"><span class=\"titlebig whitelhs style1\" >History</span></a></td>\r\n<td width=\"41\">&nbsp;</td>\r\n<td width=\"28\">&nbsp;</td>\r\n</tr>\r\n<tr bgcolor=\"#ffffff\" valign=\"middle\"><td colspan=\"12\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td></tr>\r\n");
      out.write("<tr bgcolor=\"#00563b\" valign=\"middle\"><td colspan=\"12\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td></tr>\r\n</tbody></table>\r\n<img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"5\">\r\n<!-- END NAV//-->\r\n\r\n\r\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"780\">\r\n<tbody><tr>\r\n<td bgcolor=\"#ffffff\" valign=\"top\" width=\"144\">\r\n\r\n\t<!-- LEFT HAND SIDE //-->\r\n\t<script language=\"javascript\" type=\"\">\r\n\t<!--\r\n\tfunction Form_ValidatorLHSSubmit(SubmitType) {\r\n\t\ttheForm = document.lhsform;\r\n\t\tif (Form_ValidatorLHS(theForm, SubmitType)) {\r\n\t\t\ttheForm.submit();\r\n\t\t}\r\n\t}\r\n\r\n\tfunction Form_ValidatorLHS(theForm, SubmitType) {\r\n\t\tif (SubmitType.toLowerCase() == \"search\") {\r\n\t\t\ttheForm.action = \"/search/results.asp\"\r\n\t\t\t// Validation script for field 'searchbycriteria' (Search Term)\r\nif (theForm.searchbycriteria.value == \"\")\r\n{\r\n\talert(\"Please enter a value for the \\\"Search Term\\\" field.\");\r\n   theForm.searchbycriteria.focus();\r\n   return (false);\r\n}\r\n\r\n\t\tif (theForm.searchbycriteria.value.length < 1)\r\n");
      out.write("  \t{\r\n     \talert(\"Please enter at least 1 characters in the \\\"Search Term\\\" field.\");\r\n     \ttheForm.searchbycriteria.focus();\r\n     \treturn (false);\r\n  \t}\r\n\r\n  \tif (theForm.searchbycriteria.value.length > 200)\r\n  \t{\r\n     \talert(\"Please enter at most 200 characters in the \\\"Search Term\\\" field.\");\r\n     \ttheForm.searchbycriteria.focus();\r\n     \treturn (false);\r\n  \t}\r\n\r\n\r\n\t\t} else {\r\n\t\t\ttheForm.action = \"/myaccount/login.asp\"\r\n\t\t\t  // Email field validation\r\n// Validation script for field 'email' (subscribing)\r\nif (theForm.email.value == \"\")\r\n{\r\n\talert(\"Please enter a value for the \\\"subscribing\\\" field.\");\r\n   theForm.email.focus();\r\n   return (false);\r\n}\r\n\r\n\t\tif (theForm.email.value.length < 1)\r\n  \t{\r\n     \talert(\"Please enter at least 1 characters in the \\\"subscribing\\\" field.\");\r\n     \ttheForm.email.focus();\r\n     \treturn (false);\r\n  \t}\r\n\r\n  \tif (theForm.email.value.length > 150)\r\n  \t{\r\n     \talert(\"Please enter at most 150 characters in the \\\"subscribing\\\" field.\");\r\n     \ttheForm.email.focus();\r\n     \treturn (false);\r\n");
      out.write("  \t}\r\n\r\n  if (theForm.email.value.indexOf(\"@\",1) == -1)\r\n  {\r\n    alert(\"Not a valid e-mail address for subscribing.\");\r\n    theForm.email.focus();\r\n    return (false);\r\n  }\r\n\r\n  if (theForm.email.value.indexOf(\".\",theForm.email.value.indexOf(\"@\")+1) == -1)\r\n  {\r\n    alert(\"Not a valid e-mail address for subscribing.\");\r\n    theForm.email.focus();\r\n    return (false);\r\n  }\r\n\r\n\r\n\t\t}\r\n\t\treturn true;\r\n\t}\r\n\t//-->\r\n\t</script>\r\n\t<form method=\"get\" action=\"/search/results.asp\">\r\n\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"144\">\r\n\t<tbody><tr>\r\n\t<td valign=\"top\" width=\"9\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"9\"></td>\r\n\t<td colspan=\"2\" valign=\"top\" width=\"126\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"18\" width=\"1\"></td>\r\n\t<td valign=\"top\" width=\"9\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"9\"></td>\r\n\t</tr>\r\n\t<tr>\r\n\t<td></td>\r\n\t<td colspan=\"2\" valign=\"top\"><img src=\"Template2_MMM.com_files/left_search.gif\" alt=\"Search\" border=\"0\" height=\"17\" width=\"47\"><br>                    <form action=\"Search.jsp\" method=\"post\" >\r\n");
      out.write("                      <input name=\"key\" value=\"\" class=\"lhstext126\" size=\"12\" type=\"text\">\r\n                    \t</form></td>\r\n\t<td></td>\r\n\t</tr>\r\n\t<tr>\r\n\t<td></td>\r\n\t<td valign=\"top\" class=\"style3\">\r\n                    \t<input name=\"Submit1\" type=\"submit\" value=\"Search\"></td>\r\n\r\n\r\n\r\n\t</tr>\r\n\t<tr><td colspan=\"4\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"8\" width=\"1\"></td></tr>\r\n\t<tr><td colspan=\"4\" bgcolor=\"#cccccc\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td></tr>\r\n\r\n  </tbody></table>\r\n\t</form>\r\n\r\n\r\n\t<table bgcolor=\"#00563b\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"144\">\r\n\t<tbody><tr>\r\n\t<td valign=\"top\" width=\"9\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"9\"></td>\r\n\t<td valign=\"top\" width=\"135\"><span class=\"titlebig whitelhs style1\">Product</span></td>\r\n\t<td><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n\t</tr>\r\n\t<tr>\r\n\t<td><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n");
      out.write("\t<td class=\"whitelhs\" valign=\"top\">\r\n\t-  <a href=\"http://www.angusrobertson.com.au/products/top100.asp\" class=\"whitelhs\">CD</a><br>\r\n\t-  <a href=\"http://www.angusrobertson.com.au/products/bestsellers.asp\" class=\"whitelhs\">Book</a><br>\r\n\t-  <a href=\"http://www.angusrobertson.com.au/products/GuaranteedGreatReads.asp\" class=\"whitelhs\">Stationary</a><br>\r\n\t<br>\r\n\t<br><a href=\"http://www.angusrobertson.com.au/products/categories.asp\" class=\"whitelhs\">View All Categories</a></td>\r\n\t<td><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n\t</tr>\r\n\t<tr>\r\n\t<td colspan=\"3\" valign=\"top\"><img src=\"Template2_MMM.com_files/left_fade.gif\" alt=\"\" border=\"0\" height=\"250\" width=\"144\"></td>\r\n\t</tr>\r\n\t</tbody></table>\r\n\t<!-- END LEFT HAND SIDE //-->\r\n\r\n</td>\r\n<td bgcolor=\"#999999\" valign=\"top\" width=\"1\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n<td valign=\"top\" width=\"10\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"10\"></td>\r\n");
      out.write("<td valign=\"top\" width=\"625\">\r\n<!-- MAIN CONTENT //-->\r\n<img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"18\" width=\"1\"><br>\r\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"625\">\r\n<tbody><tr>\r\n<td valign=\"top\">\r\n\r\n\r\n\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n\t<tbody><tr><td colspan=\"3\" bgcolor=\"#cccccc\" valign=\"top\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"260\"></td></tr>\r\n<!--\t<tr>\r\n\t<td valign=\"top\" bgcolor=\"#CCCCCC\" colspan=\"1\"><img src=\"images/gap.gif\" width=\"1\" height=\"1\" alt=\"\" border=\"0\"></td>\r\n\t<td align=\"center\" valign=\"top\" bgcolor=\"#FFFFFF\" width=\"100%\">\r\n\t\t<table cellspacing=\"9\" width=\"100%\"><tr>\r\n\t\t\t<td valign=\"top\" bgcolor=\"#00563B\" colspan=\"2\"><img src=\"images/gap.gif\" width=\"4\" height=\"1\" alt=\"\" border=\"0\"><img src=\"images/title_octcat.gif\" height=\"25\" alt=\"MMM November Catalogue\" border=\"0\"></td>\r\n\t\t\t</tr>\r\n\t\t</table>\r\n\t</td>\r\n\t<td valign=\"top\" bgcolor=\"#CCCCCC\"><img src=\"images/gap.gif\" width=\"1\" height=\"1\" alt=\"\" border=\"0\"></td>\r\n");
      out.write("\t</tr>-->\r\n\t<tr>\r\n\t<td bgcolor=\"#cccccc\" valign=\"top\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n\t<td align=\"center\" bgcolor=\"#ffffff\" valign=\"top\"><a href=\"http://top100.angusrobertson.com.au/\" target=\"_blank\"><img src=\"Template2_MMM.com_files/kirkdale_bookshop_01.jpg\" border=\"0\" height=\"178\" hspace=\"4\" vspace=\"4\" width=\"200\" alt=\"\"></a></td>\r\n\t<td bgcolor=\"#cccccc\" valign=\"top\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n\t</tr>\r\n\t<tr><td colspan=\"3\" bgcolor=\"#cccccc\" valign=\"top\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td></tr>\r\n\t</tbody></table>\r\n<!--\r\n\t<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\r\n\t<tr><td valign=\"top\" colspan=\"3\" bgcolor=\"#CCCCCC\"><img src=\"images/gap.gif\" width=\"260\" height=\"1\" alt=\"\" border=\"0\"></td></tr>\r\n\t<tr>\r\n\t<td valign=\"top\" bgcolor=\"#CCCCCC\"><img src=\"images/gap.gif\" width=\"1\" height=\"1\" alt=\"\" border=\"0\"></td>\r\n\t<td valign=\"top\" bgcolor=\"#FFFFFF\"><a href=\"#\"><img src=\"images/arjan.gif\" width=\"250\" height=\"198\" alt=\"Angus & Robertson Online\" border=\"0\" hspace=\"4\" vspace=\"4\"></a></td>\r\n");
      out.write("\t<td valign=\"top\" bgcolor=\"#FFFFFF\"><a href=\"#\"><img src=\"images/random1.jpg\" width=\"250\" height=\"215\" alt=\"Angus & Robertson Online\" border=\"0\" hspace=\"4\" vspace=\"4\"></a></td>-->\r\n<!--\t<td valign=\"top\" bgcolor=\"#FFFFFF\"><a href=\"http://www.booksalive.com.au/\" target=\"blank\"><img src=\"images/books-alive.gif\" width=\"250\" height=\"198\" alt=\"Kids' Top 50\" border=\"0\" hspace=\"4\" vspace=\"4\"></a></td>\r\n\t<td valign=\"top\" bgcolor=\"#CCCCCC\"><img src=\"images/gap.gif\" width=\"1\" height=\"1\" alt=\"\" border=\"0\"></td>\r\n\t</tr>\r\n\r\n\r\n\t<tr><td valign=\"top\" colspan=\"3\" bgcolor=\"#CCCCCC\"><img src=\"images/gap.gif\" width=\"1\" height=\"1\" alt=\"\" border=\"0\"></td></tr>\r\n\t</table>\r\n-->\r\n\r\n</td>\r\n<td valign=\"top\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"10\"></td>\r\n<td valign=\"top\">\r\n\r\n\t\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n\t<tbody><tr><td colspan=\"3\" bgcolor=\"#cccccc\" valign=\"top\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"356\"></td></tr>\r\n\t<tr>\r\n\t<td bgcolor=\"#cccccc\" valign=\"top\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n");
      out.write("\t\t<td align=\"center\" bgcolor=\"#ffffff\" valign=\"top\" width=\"100%\"><a href=\"http://www.angusrobertson.com.au/products/harrypotter.asp\"><img src=\"Template2_MMM.com_files/n-cdshop.gif\"  alt=\"A&amp;R Win! Promotion\" border=\"0\" height=\"177\" hspace=\"4\" vspace=\"4\" width=\"211\"></a></td>\r\n\t\t<!--<td align=\"center\" valign=\"top\" bgcolor=\"#FFFFFF\" width=\"100%\"><img src=\"images/Big-Book-Sale1.gif\" width=\"345\" height=\"198\" alt=\"MMM Big Book Sale\" border=\"0\" hspace=\"4\" vspace=\"4\"></a></td>-->\r\n\t<td bgcolor=\"#cccccc\" valign=\"top\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n\t</tr>\r\n\t<tr><td colspan=\"3\" bgcolor=\"#cccccc\" valign=\"top\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"356\"></td></tr>\r\n\t</tbody></table>\r\n</td>\r\n</tr>\r\n</tbody></table>\r\n\r\n\r\n\r\n\r\n\r\n<img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"9\" width=\"1\">\r\n\r\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"625\">\r\n<tbody><tr bgcolor=\"#cccccc\">\r\n<td valign=\"top\" width=\"1\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n");
      out.write("<td valign=\"top\" width=\"6\">&nbsp;</td>\r\n<td valign=\"top\" width=\"1\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n<td valign=\"top\" width=\"616\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"358\"></td>\r\n<td valign=\"top\" width=\"1\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n</tr>\r\n\r\n<tr bgcolor=\"#cccccc\">\r\n<td valign=\"top\" width=\"1\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n<td bgcolor=\"#ffffff\" valign=\"top\" width=\"6\">&nbsp;</td>\r\n<td valign=\"top\" width=\"1\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n<td bgcolor=\"#ffffff\" valign=\"top\" width=\"616\">\r\n\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"9\" width=\"613\">\r\n\t<tbody><tr>\r\n\t<td colspan=\"2\" bgcolor=\"#00563b\" valign=\"top\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"4\">\r\n\r\n        <span class=\"titlebig whitelhs\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"4\">product detail view </span>\r\n");
      out.write("\t</tr>\r\n\t<tr>\r\n\t<td colspan=\"2\" valign=\"top\"><strong>New Books </strong></td>\r\n\t</tr>\r\n\r\n\r\n\r\n\t<tr>\r\n\t<td width=\"103\" valign=\"top\">\r\n\t\t<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n\t\t<tbody><tr>\r\n\t\t<td bgcolor=\"#cccccc\" valign=\"top\"><a href=\"http://www.angusrobertson.com.au/products/detailed.asp?bookid=9780340826621\">");

    if (request.getParameter("StuffTable") != null && request.getParameter("StuffID") != null) {
      String StuffTable;
      String StuffID;
      StuffTable = request.getParameter("StuffTable").toLowerCase();
      StuffID = request.getParameter("StuffID").toLowerCase();
      try {
        Connection con = MySqlObj.getDbConnection("mani", "mbh", "3306", "localhost", "3m");
        ResultSet rslt = MySqlObj.runSqlQuery("select * from " + StuffTable + " where ID=" + StuffID, con);
        if (rslt.next()) {
          FileOutputStream os = new FileOutputStream("/" + StuffTable + StuffID + ".jpg");
          os.write(rslt.getBytes("PICTURE"));
          os.close();
  
      out.write("\r\n    <img alt=\"salam\" src=\"");
      out.print( "/" + StuffTable + StuffID + ".jpg" );
      out.write("\"></a></td>\r\n\t\t</tr>\r\n\t\t</tbody></table>\t</td>\r\n\t<td width=\"483\" valign=\"top\">\r\n\t\t<a href=\"http://www.angusrobertson.com.au/products/detailed.asp?bookid=9780340826621\" class=\"title\"></a>\r\n\t\t<br>\r\n  ");

    switch (StuffTable.charAt(0)) {
    case 'b': //books
      out.println("<br>" + "Name: " + rslt.getString("NAME") + "<br>");
      out.println("WRITER: " + rslt.getString("WRITER") + "<br>");
      out.println("PUBLISHER: " + rslt.getString("PUBLISHER") + "<br>");
      out.println("EDITION: " + String.valueOf(rslt.getInt("EDITION")) + "<br>");
      out.println("PUBLISHED_YEAR: " + String.valueOf(rslt.getInt("PUBLISHED_YEAR")) + "<br>");
      out.println("ISBN: " + rslt.getString("ISBN") + "<br>");
      out.println("PRICE: " + String.valueOf(rslt.getDouble("PRICE")) + "<br>");
      out.println("DESCRIPTION: " + rslt.getString("DESCRIPTION") + "<br>");
      out.println("<a href=\"buyBasket.jsp?StuffTable=" + StuffTable + "&StuffID=" + StuffID + "\">Add To Basket</a>");
      break;
    case 'c': //CDs
      out.println("<br>" + "TITLE: " + rslt.getString("TITLE") + "<br>");
      out.println("NAME: " + rslt.getString("NAME") + "<br>");
      out.println("PUBLISHER: " + rslt.getString("PUBLISHER") + "<br>");
      out.println("SERIAL_NUMBER: " + rslt.getString("SERIAL_NUMBER") + "<br>");
      out.println("PRICE: " + String.valueOf(rslt.getDouble("PRICE")) + "<br>");
      out.println("DESCRIPTION: " + rslt.getString("DESCRIPTION") + "<br>");
      out.println("<a href=\"buyBasket.jsp?StuffTable=" + StuffTable + "&StuffID=" + StuffID + "\">Add To Basket</a>");
      break;
    case 's': //stationaries
//      out.println("<br>" + "TITLE: " + rslt.getString("TITLE") + "<br>");
      out.println("NAME: " + rslt.getString("NAME") + "<br>");
      out.println("MANUFACTURED_BY: " + rslt.getString("MANUFACTURED_BY") + "<br>");
      out.println("PRICE: " + String.valueOf(rslt.getDouble("PRICE")) + "<br>");
      out.println("DESCRIPTION: " + rslt.getString("DESCRIPTION") + "<br>");
      out.println("<a href=\"buyBasket.jsp?StuffTable=" + StuffTable + "&StuffID=" + StuffID + "\">Add To Basket</a>");
      break;
    default:
    } //end switch
  
      out.write("\r\n  ");

    } else { //end if (rslt.next())
      out.println("Stuff is not correct.");
    }
    } catch (SQLException e) { //end try
      e.printStackTrace();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
    } //end if
  
      out.write("</td>\r\n\t</tr>\r\n\t</tbody></table></td>\r\n<td valign=\"top\" width=\"1\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n</tr>\r\n\r\n<tr bgcolor=\"#cccccc\">\r\n<td valign=\"top\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n<td bgcolor=\"#ffffff\" valign=\"top\">&nbsp;</td>\r\n<td valign=\"top\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td>\r\n<td align=\"right\" bgcolor=\"#ffffff\" valign=\"bottom\"><img src=\"Template2_MMM.com_files/pagecurl.gif\" alt=\"\" border=\"0\" height=\"27\" width=\"22\"></td>\r\n<td valign=\"bottom\"><img src=\"Template2_MMM.com_files/gapEEEEEE.gif\" alt=\"\" border=\"0\" height=\"26\" width=\"1\"></td>\r\n</tr>\r\n<tr bgcolor=\"#cccccc\"><td colspan=\"5\" align=\"right\" valign=\"top\"><img src=\"Template2_MMM.com_files/gapEEEEEE.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"13\"></td></tr>\r\n</tbody></table>\r\n\r\n\r\n<br><br>\r\n<!-- END MAIN CONTENT //-->\r\n</td>\r\n</tr>\r\n</tbody><!-- FOOTER //-->\r\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"780\">\r\n");
      out.write("<tbody><tr valign=\"top\"><td colspan=\"4\" bgcolor=\"#ffffff\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td></tr>\r\n\r\n<tr bgcolor=\"#00563b\" valign=\"middle\">\r\n<td width=\"14\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"17\" width=\"14\"></td>\r\n<td class=\"white\" width=\"376\">آ© Copyright MMM 2007</td>\r\n<td align=\"right\" width=\"376\"><a href=\"javascript:privacypolicy()\" class=\"footer\">Privacy Policy</a><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"15\"><a href=\"javascript:termsofuse()\" class=\"footer\">Terms of Use</a></td>\r\n<td width=\"14\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"14\"></td>\r\n</tr>\r\n\r\n<tr valign=\"top\"><td colspan=\"4\" bgcolor=\"#00563b\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td></tr>\r\n<tr valign=\"top\"><td colspan=\"4\" bgcolor=\"#ffffff\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td></tr>\r\n<tr valign=\"top\"><td colspan=\"4\" bgcolor=\"#00563b\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\"></td></tr>\r\n");
      out.write("<tr valign=\"top\"><td colspan=\"4\"><img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"2\" width=\"1\"></td></tr>\r\n\r\n<tr valign=\"top\">\r\n<td></td>\r\n<td class=\"grey666666\">WWW.MMM.COM</td>\r\n<td class=\"grey666666\" align=\"right\">Site designed by <a href=\"http://www.spin.com.au/\" target=\"_blank\" class=\"darkgreen\">MMM</a></td>\r\n<td></td>\r\n</tr>\r\n\r\n</tbody></table>\r\n<!-- EOF -->\r\n</body></html>\r\n");
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
