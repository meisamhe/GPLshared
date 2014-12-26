package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public final class buyBasket_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("ï»؟\r\n<html>\r\n<head>\r\n<title>buyBasket</title>\r\n<meta name=\"description\" content=\"Visit the online bookshop of MMM\">\r\n<meta name=\"keywords\" content=\"bookshop, bookstore, author, buy books online, book shop, book store, Australia, self help, computers, Australian, books online\">\r\n<meta name=\"robots\" content=\"index, follow\">\r\n<script language=\"javascript\" src=\"Template2_MMM.com_files/stylesheet.js\" type=\"\"></script>\r\n<link rel=\"StyleSheet\" href=\"Template2_MMM.com_files/stylesheet_PCEXP.css\" type=\"text/css\">\r\n<script language=\"javascript\" src=\"Template2_MMM.com_files/functions.js\" type=\"\"></script>\r\n<style type=\"text/css\">\r\n  <!--\r\n    .style1 {font-size: 12pt}\r\n    .style2 {\r\n    font-size: 14pt;\r\n    color: #FFFFFF;\r\n    }\r\n    .style3 {\r\n    color: #FF0000;\r\n    font-size: 14pt;\r\n    }\r\n  .style4 {\r\n\ttext-align: right;\r\n}\r\n  -->\r\n</style>\r\n</head>\r\n\r\n\r\n\r\n\r\n");
      jdbcMySql.MySqlConnector MySqlObj = null;
      synchronized (_jspx_page_context) {
        MySqlObj = (jdbcMySql.MySqlConnector) _jspx_page_context.getAttribute("MySqlObj", PageContext.PAGE_SCOPE);
        if (MySqlObj == null){
          MySqlObj = new jdbcMySql.MySqlConnector();
          _jspx_page_context.setAttribute("MySqlObj", MySqlObj, PageContext.PAGE_SCOPE);
        }
      }
      out.write('\r');
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.introspect(_jspx_page_context.findAttribute("MySqlObj"), request);
      out.write('\r');
      out.write('\n');

  if (session.getAttribute("UserID") == null)
    response.sendRedirect("Login.jsp");

      out.write("\r\n<body alink=\"#00563b\" bgcolor=\"#eeeeee\" link=\"#00a651\" text=\"#999999\" vlink=\"#00563b\">\r\n");

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

      out.write("\r\n  <!-- HEADER //-->\r\n<a name=\"top\"></a>\r\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"770\">\r\n  <tbody>\r\n    <tr>\r\n      <td bgcolor=\"#00563b\" valign=\"top\" width=\"391\">\r\n        <a href=\"http://www.angusrobertson.com.au/\" target=\"_top\" onMouseOver=\"window.status=''; return true\" onMouseOut=\"window.status=''; return true\">\r\n          <img src=\"Template2_MMM.com_files/main01.jpg\" alt=\"Angus &amp; Robertson Book Shop\" border=\"0\" height=\"69\" width=\"391\">\r\n        </a>\r\n      </td>\r\n      <td align=\"right\" bgcolor=\"#ffffff\" valign=\"top\" width=\"379\">\r\n        <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n          <tbody>\r\n            <tr>\r\n              <td colspan=\"2\" valign=\"top\">\r\n                <div align=\"right\">\r\n                  <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"7\" width=\"1\">\r\n                  <br>\r\n                  <a href=\"javascript:launchthawte()\" onMouseOver=\"window.status='View SSL Certificate Info'; return true\" onMouseOut=\"window.status=''; return true\">                    Security by MMM Team\r\n");
      out.write("                    &nbsp;&nbsp;\r\n                    <img src=\"Template2_MMM.com_files/header_ssl.gif\" alt=\"View SSL Certificate Info\" align=\"middle\" border=\"0\" height=\"18\" hspace=\"0\" vspace=\"0\" width=\"17\">\r\n                  </a>\r\n                </div>\r\n              </td>\r\n              <td valign=\"bottom\" width=\"18\">\r\n                <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"18\">\r\n              </td>\r\n            </tr>\r\n            <tr>\r\n              <td valign=\"bottom\">\r\n                <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                  <tbody>\r\n                    <tr>\r\n                      <td valign=\"bottom\">\r\n                        <a href=\"Cart.jsp\" target=\"_top\" onMouseOver=\"window.status='View Cart'; return true\" onMouseOut=\"window.status=''; return true\">\r\n                          <img src=\"Template2_MMM.com_files/header_viewcart.gif\" alt=\"View Cart\" align=\"middle\" border=\"0\" height=\"12\" width=\"57\">\r\n                        </a>\r\n                      </td>\r\n");
      out.write("                      <td>\r\n                        <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"3\">\r\n                      </td>\r\n                      <td valign=\"bottom\">\r\n                        <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"40\">\r\n                      </td>\r\n                      <td>\r\n                        <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"3\">\r\n                      </td>\r\n                      <td valign=\"bottom\">\r\n                        <a href=\"http://www.angusrobertson.com.au/checkout/viewcart.asp\" target=\"_top\" onMouseOver=\"window.status='View Cart'; return true\" onMouseOut=\"window.status=''; return true\">\r\n                          <img src=\"Template2_MMM.com_files/header_cart.gif\" alt=\" Items\" align=\"bottom\" border=\"0\" height=\"20\" width=\"23\">\r\n                        </a>\r\n                      </td>\r\n                    </tr>\r\n                  </tbody>\r\n                </table>\r\n");
      out.write("              </td>\r\n              <td align=\"right\" valign=\"bottom\">\r\n                <a href=\"Credit.jsp\" target=\"_top\" onMouseOver=\"window.status='My Account'; return true\" onMouseOut=\"window.status=''; return true\">\r\n                  <img src=\"Template2_MMM.com_files/header_myaccount.gif\" alt=\"My Account\" border=\"0\" height=\"12\" width=\"67\">\r\n                </a>\r\n              </td>\r\n              <td>              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n      </td>\r\n    </tr>\r\n  </tbody>\r\n</table>\r\n  <!-- END HEADER //-->\r\n  <!-- NAV //-->\r\n<table width=\"582\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n  <tbody>\r\n    <tr bgcolor=\"#ffffff\" valign=\"middle\">\r\n      <td colspan=\"12\">\r\n        <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\">\r\n      </td>\r\n    </tr>\r\n    <tr bgcolor=\"#00563b\" valign=\"middle\">\r\n      <td width=\"5\">\r\n        <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"5\">\r\n      </td>\r\n      <td width=\"45\">\r\n");
      out.write("        <a href=\"Home.jsp\" target=\"_top\" onMouseOver=\"document.header_nav_home.src='/images/header_nav_home_o.gif'; window.status='Home'; return true\" onMouseOut=\"window.status=''; return true\">\r\n          <img src=\"Template2_MMM.com_files/header_nav_home_o.gif\" alt=\"Home\" name=\"header_nav_home\" border=\"0\" height=\"25\" width=\"39\">\r\n        </a>\r\n      </td>\r\n      <td width=\"1\">\r\n        <a href=\"http://www.angusrobertson.com.au/products/newreleases.asp\" target=\"_top\" onMouseOver=\"document.header_nav_newreleases.src='/images/header_nav_newreleases_o.gif'; window.status='New releases'; return true\" onMouseOut=\"document.header_nav_newreleases.src='/images/header_nav_newreleases.gif'; window.status=''; return true\">        </a>\r\n      </td>\r\n      <td width=\"66\" class=\"titlebig whitelhs style1\">\r\n        <a href=\"Search.jsp\" target=\"_top\" class=\"style2\" onMouseOver=\"window.status='View Cart'; return true\" onMouseOut=\"window.status=''; return true\">\r\n          <span class=\"titlebig whitelhs style1\">Search </span>\r\n");
      out.write("        </a>\r\n      </td>\r\n      <td width=\"47\">\r\n        <span class=\"titlebig whitelhs style1\"> <a href=\"Cart.jsp\" target=\"_top\" onMouseOver=\"window.status='View Cart'; return true\" onMouseOut=\"window.status=''; return true\"><span class=\"titlebig whitelhs style1\">Cart </span> </a>\r\n      </td>\r\n      <td width=\"62\">\r\n        <span class=\"titlebig whitelhs style1\"> <a href=\"Credit.jsp\" target=\"_top\" onMouseOver=\"window.status='View Cart'; return true\" onMouseOut=\"window.status=''; return true\"><span class=\"titlebig whitelhs style1\">credit </span></a>\r\n      </td>\r\n      <td width=\"50\">\r\n        <a href=\"Login.jsp\" target=\"_top\" onMouseOver=\"window.status='View Cart'; return true\" onMouseOut=\"window.status=''; return true\">\r\n          <span class=\"titlebig whitelhs style1\">log in </span>\r\n        </a>\r\n      </td>\r\n      <td width=\"78\">\r\n        <a href=\"Signup.jsp\" target=\"_top\" onMouseOver=\"window.status='View Cart'; return true\" onMouseOut=\"window.status=''; return true\">\r\n          <span class=\"titlebig whitelhs style1\">edit info </span>\r\n");
      out.write("        </a>\r\n      </td>\r\n      <td width=\"98\">\r\n        <a href=\"Contactus.jsp\" target=\"_top\" onMouseOver=\"window.status='View Cart'; return true\" onMouseOut=\"window.status=''; return true\">\r\n          <span class=\"titlebig whitelhs style1\">contact us </span>\r\n        </a>\r\n      </td>\r\n      <td width=\"61\">\r\n        <a href=\"History.jsp\" target=\"_top\" onMouseOver=\"window.status='View Cart'; return true\" onMouseOut=\"window.status=''; return true\">\r\n          <span class=\"titlebig whitelhs style1\">History</span>\r\n        </a>\r\n      </td>\r\n      <td width=\"41\">&nbsp;</td>\r\n      <td width=\"28\">&nbsp;</td>\r\n    </tr>\r\n    <tr bgcolor=\"#ffffff\" valign=\"middle\">\r\n      <td colspan=\"12\">\r\n        <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\">\r\n      </td>\r\n    </tr>\r\n    <tr bgcolor=\"#00563b\" valign=\"middle\">\r\n      <td colspan=\"12\">\r\n        <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\">\r\n      </td>\r\n    </tr>\r\n  </tbody>\r\n</table>\r\n<img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"5\">\r\n");
      out.write("  <!-- END NAV//-->\r\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"780\">\r\n  <tbody>\r\n    <tr>\r\n      <td bgcolor=\"#ffffff\" valign=\"top\" width=\"144\">\r\n        <!-- LEFT HAND SIDE //-->\r\n<script language=\"javascript\" type=\"\">\r\n\t<!--\r\n\tfunction Form_ValidatorLHSSubmit(SubmitType) {\r\n\t\ttheForm = document.lhsform;\r\n\t\tif (Form_ValidatorLHS(theForm, SubmitType)) {\r\n\t\t\ttheForm.submit();\r\n\t\t}\r\n\t}\r\n\r\n\tfunction Form_ValidatorLHS(theForm, SubmitType) {\r\n\t\tif (SubmitType.toLowerCase() == \"search\") {\r\n\t\t\ttheForm.action = \"/search/results.asp\"\r\n\t\t\t// Validation script for field 'searchbycriteria' (Search Term)\r\nif (theForm.searchbycriteria.value == \"\")\r\n{\r\n\talert(\"Please enter a value for the \\\"Search Term\\\" field.\");\r\n   theForm.searchbycriteria.focus();\r\n   return (false);\r\n}\r\n\r\n\t\tif (theForm.searchbycriteria.value.length < 1)\r\n  \t{\r\n     \talert(\"Please enter at least 1 characters in the \\\"Search Term\\\" field.\");\r\n     \ttheForm.searchbycriteria.focus();\r\n     \treturn (false);\r\n  \t}\r\n\r\n  \tif (theForm.searchbycriteria.value.length > 200)\r\n");
      out.write("  \t{\r\n     \talert(\"Please enter at most 200 characters in the \\\"Search Term\\\" field.\");\r\n     \ttheForm.searchbycriteria.focus();\r\n     \treturn (false);\r\n  \t}\r\n\r\n\r\n\t\t} else {\r\n\t\t\ttheForm.action = \"/myaccount/login.asp\"\r\n\t\t\t  // Email field validation\r\n// Validation script for field 'email' (subscribing)\r\nif (theForm.email.value == \"\")\r\n{\r\n\talert(\"Please enter a value for the \\\"subscribing\\\" field.\");\r\n   theForm.email.focus();\r\n   return (false);\r\n}\r\n\r\n\t\tif (theForm.email.value.length < 1)\r\n  \t{\r\n     \talert(\"Please enter at least 1 characters in the \\\"subscribing\\\" field.\");\r\n     \ttheForm.email.focus();\r\n     \treturn (false);\r\n  \t}\r\n\r\n  \tif (theForm.email.value.length > 150)\r\n  \t{\r\n     \talert(\"Please enter at most 150 characters in the \\\"subscribing\\\" field.\");\r\n     \ttheForm.email.focus();\r\n     \treturn (false);\r\n  \t}\r\n\r\n  if (theForm.email.value.indexOf(\"@\",1) == -1)\r\n  {\r\n    alert(\"Not a valid e-mail address for subscribing.\");\r\n    theForm.email.focus();\r\n    return (false);\r\n  }\r\n\r\n  if (theForm.email.value.indexOf(\".\",theForm.email.value.indexOf(\"@\")+1) == -1)\r\n");
      out.write("  {\r\n    alert(\"Not a valid e-mail address for subscribing.\");\r\n    theForm.email.focus();\r\n    return (false);\r\n  }\r\n\r\n\r\n\t\t}\r\n\t\treturn true;\r\n\t}\r\n\t//-->\r\n\t</script>\r\n        <form method=\"get\" action=\"/search/results.asp\">\r\n        <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"144\">\r\n          <tbody>\r\n            <tr>\r\n              <td valign=\"top\" width=\"9\">\r\n                <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"9\">\r\n              </td>\r\n              <td colspan=\"2\" valign=\"top\" width=\"126\">\r\n                <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"18\" width=\"1\">\r\n              </td>\r\n              <td valign=\"top\" width=\"9\">\r\n                <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"9\">\r\n              </td>\r\n            </tr>\r\n            <tr>\r\n              <td style=\"height: 35px\">              </td>\r\n              <td colspan=\"2\" valign=\"top\" style=\"height: 35px\">\r\n                <img src=\"Template2_MMM.com_files/left_search.gif\" alt=\"Search\" border=\"0\" height=\"17\" width=\"47\">\r\n");
      out.write("                <br>\r\n                                    <form action=\"Search.jsp\" method=\"post\" >\r\n                      <input name=\"key\" value=\"\" class=\"lhstext126\" size=\"12\" type=\"text\">\r\n                    \t</form>\r\n              </td>\r\n              <td style=\"height: 35px\">              </td>\r\n            </tr>\r\n            <tr>\r\n              <td>              </td>\r\n              <td valign=\"top\" class=\"style4\">\r\n                    \t<input name=\"Submit1\" type=\"submit\" value=\"Search\"></td>              \r\n              \r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"4\">\r\n                <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"8\" width=\"1\">\r\n              </td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"4\" bgcolor=\"#cccccc\">\r\n                <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\">\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        </form>\r\n        <table bgcolor=\"#00563b\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"144\">\r\n");
      out.write("          <tbody>\r\n            <tr>\r\n              <td valign=\"top\" width=\"9\">\r\n                <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"9\">\r\n              </td>\r\n              <td valign=\"top\" width=\"135\">\r\n                <span class=\"titlebig whitelhs style1\">Product</span>\r\n              </td>\r\n              <td>\r\n                <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\">\r\n              </td>\r\n            </tr>\r\n            <tr>\r\n              <td>\r\n                <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\">\r\n              </td>\r\n              <td class=\"whitelhs\" valign=\"top\">                -\r\n                <a href=\"http://www.angusrobertson.com.au/products/top100.asp\" class=\"whitelhs\">CD</a>\r\n                <br>\r\n                -\r\n                <a href=\"http://www.angusrobertson.com.au/products/bestsellers.asp\" class=\"whitelhs\">Book</a>\r\n                <br>\r\n                -\r\n                <a href=\"http://www.angusrobertson.com.au/products/GuaranteedGreatReads.asp\" class=\"whitelhs\">Stationary</a>\r\n");
      out.write("                <br>\r\n                <br>\r\n                <br>\r\n                <a href=\"http://www.angusrobertson.com.au/products/categories.asp\" class=\"whitelhs\">View All Categories</a>\r\n              </td>\r\n              <td>\r\n                <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\">\r\n              </td>\r\n            </tr>\r\n            <tr>\r\n              <td colspan=\"3\" valign=\"top\">\r\n                <img src=\"Template2_MMM.com_files/left_fade.gif\" alt=\"\" border=\"0\" height=\"250\" width=\"144\">\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        <!-- END LEFT HAND SIDE //-->\r\n      </td>\r\n      <td bgcolor=\"#999999\" valign=\"top\" width=\"1\">\r\n        <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\">\r\n      </td>\r\n      <td valign=\"top\" width=\"10\">\r\n        <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"10\">\r\n      </td>\r\n      <td valign=\"top\" width=\"625\">\r\n        <!-- MAIN CONTENT //-->\r\n");
      out.write("        <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"18\" width=\"1\">\r\n        <br>\r\n        <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"625\">\r\n          <tbody>\r\n            <tr>\r\n              <td valign=\"top\">\r\n                <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                  <tbody>\r\n                    <tr>\r\n                      <td colspan=\"3\" bgcolor=\"#cccccc\" valign=\"top\">\r\n                        <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"260\">\r\n                      </td>\r\n                    </tr>\r\n                    <!--\r\n                      <tr>\r\n                      <td valign=\"top\" bgcolor=\"#CCCCCC\" colspan=\"1\"><img src=\"images/gap.gif\" width=\"1\" height=\"1\" alt=\"\" border=\"0\"></td>\r\n                      <td align=\"center\" valign=\"top\" bgcolor=\"#FFFFFF\" width=\"100%\">\r\n                      <table cellspacing=\"9\" width=\"100%\"><tr>\r\n                      <td valign=\"top\" bgcolor=\"#00563B\" colspan=\"2\"><img src=\"images/gap.gif\" width=\"4\" height=\"1\" alt=\"\" border=\"0\"><img src=\"images/title_octcat.gif\" height=\"25\" alt=\"MMM November Catalogue\" border=\"0\"></td>\r\n");
      out.write("                      </tr>\r\n                      </table>\r\n                      </td>\r\n                      <td valign=\"top\" bgcolor=\"#CCCCCC\"><img src=\"images/gap.gif\" width=\"1\" height=\"1\" alt=\"\" border=\"0\"></td>\r\n                      </tr>\r\n                    -->\r\n                    <tr>\r\n                      <td bgcolor=\"#cccccc\" valign=\"top\">\r\n                        <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\">\r\n                      </td>\r\n                      <td align=\"center\" bgcolor=\"#ffffff\" valign=\"top\">\r\n                        <a href=\"http://top100.angusrobertson.com.au/\" target=\"_blank\">\r\n                          <img src=\"Template2_MMM.com_files/kirkdale_bookshop_01.jpg\" border=\"0\" height=\"178\" hspace=\"4\" vspace=\"4\" width=\"200\" alt=\"\">\r\n                        </a>\r\n                      </td>\r\n                      <td bgcolor=\"#cccccc\" valign=\"top\">\r\n                        <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\">\r\n");
      out.write("                      </td>\r\n                    </tr>\r\n                    <tr>\r\n                      <td colspan=\"3\" bgcolor=\"#cccccc\" valign=\"top\">\r\n                        <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\">\r\n                      </td>\r\n                    </tr>\r\n                  </tbody>\r\n                </table>\r\n                <!--\r\n                  <table cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\r\n                  <tr><td valign=\"top\" colspan=\"3\" bgcolor=\"#CCCCCC\"><img src=\"images/gap.gif\" width=\"260\" height=\"1\" alt=\"\" border=\"0\"></td></tr>\r\n                  <tr>\r\n                  <td valign=\"top\" bgcolor=\"#CCCCCC\"><img src=\"images/gap.gif\" width=\"1\" height=\"1\" alt=\"\" border=\"0\"></td>\r\n                  <td valign=\"top\" bgcolor=\"#FFFFFF\"><a href=\"#\"><img src=\"images/arjan.gif\" width=\"250\" height=\"198\" alt=\"Angus & Robertson Online\" border=\"0\" hspace=\"4\" vspace=\"4\"></a></td>\r\n                  <td valign=\"top\" bgcolor=\"#FFFFFF\"><a href=\"#\"><img src=\"images/random1.jpg\" width=\"250\" height=\"215\" alt=\"Angus & Robertson Online\" border=\"0\" hspace=\"4\" vspace=\"4\"></a></td>\r\n");
      out.write("                -->\r\n                <!--\r\n                  <td valign=\"top\" bgcolor=\"#FFFFFF\"><a href=\"http://www.booksalive.com.au/\" target=\"blank\"><img src=\"images/books-alive.gif\" width=\"250\" height=\"198\" alt=\"Kids' Top 50\" border=\"0\" hspace=\"4\" vspace=\"4\"></a></td>\r\n                  <td valign=\"top\" bgcolor=\"#CCCCCC\"><img src=\"images/gap.gif\" width=\"1\" height=\"1\" alt=\"\" border=\"0\"></td>\r\n                  </tr>\r\n                  <tr><td valign=\"top\" colspan=\"3\" bgcolor=\"#CCCCCC\"><img src=\"images/gap.gif\" width=\"1\" height=\"1\" alt=\"\" border=\"0\"></td></tr>\r\n                  </table>\r\n                -->\r\n              </td>\r\n              <td valign=\"top\">\r\n                <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"10\">\r\n              </td>\r\n              <td valign=\"top\">\r\n                <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                  <tbody>\r\n                    <tr>\r\n                      <td colspan=\"3\" bgcolor=\"#cccccc\" valign=\"top\">\r\n                        <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"356\">\r\n");
      out.write("                      </td>\r\n                    </tr>\r\n                    <tr>\r\n                      <td bgcolor=\"#cccccc\" valign=\"top\">\r\n                        <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\">\r\n                      </td>\r\n                      <td align=\"center\" bgcolor=\"#ffffff\" valign=\"top\" width=\"100%\">\r\n                        <a href=\"http://www.angusrobertson.com.au/products/harrypotter.asp\">\r\n                          <img src=\"Template2_MMM.com_files/n-cdshop.gif\" alt=\"A&amp;R Win! Promotion\" border=\"0\" height=\"177\" hspace=\"4\" vspace=\"4\" width=\"211\">\r\n                        </a>\r\n                      </td>\r\n                      <!--<td align=\"center\" valign=\"top\" bgcolor=\"#FFFFFF\" width=\"100%\"><img src=\"images/Big-Book-Sale1.gif\" width=\"345\" height=\"198\" alt=\"MMM Big Book Sale\" border=\"0\" hspace=\"4\" vspace=\"4\"></a></td>-->\r\n                      <td bgcolor=\"#cccccc\" valign=\"top\">\r\n                        <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\">\r\n");
      out.write("                      </td>\r\n                    </tr>\r\n                    <tr>\r\n                      <td colspan=\"3\" bgcolor=\"#cccccc\" valign=\"top\">\r\n                        <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"356\">\r\n                      </td>\r\n                    </tr>\r\n                  </tbody>\r\n                </table>\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"9\" width=\"1\">\r\n        <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"625\">\r\n          <tbody>\r\n            <tr bgcolor=\"#cccccc\">\r\n              <td valign=\"top\" width=\"1\">\r\n                <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\">\r\n              </td>\r\n              <td valign=\"top\" width=\"264\">\r\n                <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"264\">\r\n              </td>\r\n              <td valign=\"top\" width=\"1\">\r\n");
      out.write("                <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\">\r\n              </td>\r\n              <td valign=\"top\" width=\"358\">&nbsp;</td>\r\n              <td valign=\"top\" width=\"1\">\r\n                <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\">\r\n              </td>\r\n            </tr>\r\n            <tr bgcolor=\"#cccccc\">\r\n              <td valign=\"top\" width=\"1\">\r\n                <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\">\r\n              </td>\r\n              <td bgcolor=\"#ffffff\" valign=\"top\" width=\"264\">\r\n                <table border=\"0\" cellpadding=\"0\" cellspacing=\"9\" width=\"615\">\r\n                  <tbody>\r\n                    <tr>\r\n                      <td colspan=\"2\" bgcolor=\"#00563b\" valign=\"top\">\r\n                        <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"4\">\r\n                        <span class=\"style3\">cart</span>\r\n                      </td>\r\n                    </tr>\r\n");
      out.write("                    <tr>\r\n                      <td class=\"green00A651\" valign=\"top\" width=\"420\">\r\n                        <form action=\"buyBasket.jsp\" method=\"POST\">\r\n                        <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n                          <!-- MSTableType=\"layout\" -->\r\n                          <!--each row is one product -->\r\n                        ");

                          ArrayList outAl;
                          outAl = (ArrayList) session.getAttribute("basket");
                          for (int i = 0; i < outAl.size(); i++) {
                        
      out.write("\r\n                          <p>\r\n                          ");
System.out.println(i);                          
      out.write("\r\n                            .\r\n                            ");
      out.write("\r\n                          </p>\r\n                          <tr>\r\n                            <td valign=\"top\" style=\"width: 500px; border-style: solid;border-color: #800000;\">\r\n                            ");

                              String StuffTable;
                              String StuffID;
                              String StuffCount;
                              StuffTable = ((String[]) outAl.get(i))[0].toLowerCase();
                              StuffID = ((String[]) outAl.get(i))[1].toLowerCase();
                              StuffCount = ((String[]) outAl.get(i))[2].toLowerCase();
                              try {
                                Connection con = MySqlObj.getDbConnection("mani", "mbh", "3306", "localhost", "3m");
                                ResultSet rslt = MySqlObj.runSqlQuery("select * from " + StuffTable + " where ID=" + StuffID, con);
                                if (rslt.next()) {
                                  switch (StuffTable.charAt(0)) {
                                  case 'b': //books
                                    out.println("<br>" + "Name: " + rslt.getString("NAME") + "<br>");
                                    out.println("WRITER: " + rslt.getString("WRITER") + "<br>");
                                    out.println("PUBLISHER: " + rslt.getString("PUBLISHER") + "<br>");
                                    out.println("EDITION: " + String.valueOf(rslt.getInt("EDITION")) + "<br>");
                                    out.println("PRICE: " + String.valueOf(rslt.getDouble("PRICE")) + "<br>");
                            
      out.write("\r\n                              <input name=\"");
      out.print("StuffCount"+String .valueOf(i));
      out.write("\" type=\"text\" value=\"");
      out.print(StuffCount);
      out.write("\"/>\r\n                              <br/>\r\n                            ");

                              out.println("<a href=\"buyBasket.jsp?DeleteID=" + String.valueOf(i) + "\">Delete From Basket</a>");
                              break;
                              case 'c': //CDs
                                out.println("<br>" + "TITLE: " + rslt.getString("TITLE") + "<br>");
                                out.println("NAME: " + rslt.getString("NAME") + "<br>");
                                out.println("PUBLISHER: " + rslt.getString("PUBLISHER") + "<br>");
                                out.println("PRICE: " + String.valueOf(rslt.getDouble("PRICE")) + "<br>");
                            
      out.write("\r\n                              <input name=\"");
      out.print("StuffCount"+String .valueOf(i));
      out.write("\" type=\"text\" value=\"");
      out.print(StuffCount);
      out.write("\"/>\r\n                              <br/>\r\n                            ");

                              out.println("<a href=\"buyBasket.jsp?DeleteID=" + String.valueOf(i) + "\">Delete From Basket</a>");
                              break;
                              case 's': //stationaries
//                                out.println("<br>" + "TITLE: " + rslt.getString("TITLE") + "<br>");
                                out.println("NAME: " + rslt.getString("NAME") + "<br>");
                                out.println("MANUFACTURED_BY: " + rslt.getString("MANUFACTURED_BY") + "<br>");
                                out.println("PRICE: " + String.valueOf(rslt.getDouble("PRICE")) + "<br>");
                            
      out.write("\r\n                              <input name=\"");
      out.print("StuffCount"+String .valueOf(i));
      out.write("\" type=\"text\" value=\"");
      out.print(StuffCount);
      out.write("\"/>\r\n                              <br/>\r\n                            ");

                              out.println("<a href=\"buyBasket.jsp?DeleteID=" + String.valueOf(i) + "\">Delete From Basket</a>");
                              break;
                              default:
                              } //end switch
                              } //end if (rslt.next())
                              } catch (SQLException e) { //end try
                                e.printStackTrace();
                              }
                              catch (Exception ex) {
                                ex.printStackTrace();
                              }
                            
      out.write("\r\n                            </td>\r\n                          </tr>\r\n                        ");
}                        
      out.write("\r\n                        </table>\r\n                        </form>\r\n                        <form method=\"post\" action=\"Thanks.htm\"><p align=\"right\"><input type=\"submit\" name=\"Buy\" value= \"Buy\" style=\"width:150px; height:80x\"/></p></form>\r\n                      </td>\r\n                      <td width=\"168\" valign=\"top\">\r\n                        <br>\r\n                        <a href=\"http://www.angusrobertson.com.au/products/detailed.asp?bookid=9780718147716\">                          Read More\r\n                          &gt;\r\n                        </a>\r\n                        &nbsp;&nbsp;&nbsp;&nbsp;\r\n                        <a href=\"http://www.angusrobertson.com.au/checkout/cart.asp?bookid=9780718147716\" class=\"darkgreen\">                          Remove from Cart\r\n                          <img src=\"Template2_MMM.com_files/btn_addtocart_bin.gif\" alt=\"\" align=\"middle\" border=\"0\" height=\"20\" width=\"25\">\r\n                        </a>\r\n                      </td>\r\n                    </tr>\r\n                  </tbody>\r\n");
      out.write("                </table>\r\n              </td>\r\n              <td valign=\"top\" width=\"1\">\r\n                <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\">\r\n              </td>\r\n              <td bgcolor=\"#ffffff\" valign=\"top\" width=\"358\">&nbsp;</td>\r\n              <td valign=\"top\" width=\"1\">\r\n                <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\">\r\n              </td>\r\n            </tr>\r\n            <tr bgcolor=\"#cccccc\">\r\n              <td valign=\"top\">\r\n                <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\">\r\n              </td>\r\n              <td bgcolor=\"#ffffff\" valign=\"top\">\r\n                <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\">\r\n              </td>\r\n              <td valign=\"top\">\r\n                <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\">\r\n              </td>\r\n              <td align=\"right\" bgcolor=\"#ffffff\" valign=\"bottom\">&nbsp;</td>\r\n");
      out.write("              <td valign=\"bottom\">\r\n                <img src=\"Template2_MMM.com_files/gapEEEEEE.gif\" alt=\"\" border=\"0\" height=\"26\" width=\"1\">\r\n              </td>\r\n            </tr>\r\n            <tr bgcolor=\"#cccccc\">\r\n              <td colspan=\"5\" align=\"right\" valign=\"top\">\r\n                <img src=\"Template2_MMM.com_files/gapEEEEEE.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"13\">\r\n              </td>\r\n            </tr>\r\n          </tbody>\r\n        </table>\r\n        <br>\r\n        <br>\r\n        <!-- END MAIN CONTENT //-->\r\n      </td>\r\n    </tr>\r\n  </tbody>\r\n  <!-- FOOTER //-->\r\n  <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"780\">\r\n    <tbody>\r\n      <tr valign=\"top\">\r\n        <td colspan=\"4\" bgcolor=\"#ffffff\">\r\n          <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\">\r\n        </td>\r\n      </tr>\r\n      <tr bgcolor=\"#00563b\" valign=\"middle\">\r\n        <td width=\"14\">\r\n          <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"17\" width=\"14\">\r\n        </td>\r\n");
      out.write("        <td class=\"white\" width=\"376\">آ© Copyright MMM 2007</td>\r\n        <td align=\"right\" width=\"376\">\r\n          <a href=\"javascript:privacypolicy()\" class=\"footer\">Privacy Policy</a>\r\n          <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"15\">\r\n          <a href=\"javascript:termsofuse()\" class=\"footer\">Terms of Use</a>\r\n        </td>\r\n        <td width=\"14\">\r\n          <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"14\">\r\n        </td>\r\n      </tr>\r\n      <tr valign=\"top\">\r\n        <td colspan=\"4\" bgcolor=\"#00563b\">\r\n          <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\">\r\n        </td>\r\n      </tr>\r\n      <tr valign=\"top\">\r\n        <td colspan=\"4\" bgcolor=\"#ffffff\">\r\n          <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\">\r\n        </td>\r\n      </tr>\r\n      <tr valign=\"top\">\r\n        <td colspan=\"4\" bgcolor=\"#00563b\">\r\n          <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"1\" width=\"1\">\r\n");
      out.write("        </td>\r\n      </tr>\r\n      <tr valign=\"top\">\r\n        <td colspan=\"4\">\r\n          <img src=\"Template2_MMM.com_files/gap.gif\" alt=\"\" border=\"0\" height=\"2\" width=\"1\">\r\n        </td>\r\n      </tr>\r\n      <tr valign=\"top\">\r\n        <td>        </td>\r\n        <td class=\"grey666666\">WWW.MMM.COM</td>\r\n        <td class=\"grey666666\" align=\"right\">          Site designed by\r\n          <a href=\"http://www.spin.com.au/\" target=\"_blank\" class=\"darkgreen\">MMM</a>\r\n        </td>\r\n        <td>        </td>\r\n      </tr>\r\n    </tbody>\r\n  </table>\r\n  <!-- EOF -->\r\n\r\n</body>\r\n</html>\r\n");
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
