﻿<%@page import="sun.net.smtp.SmtpClient, java.io.*,jdbcMysql.*"%>
<html>
<head>
<title>MMM E-BOOKSTORE E-CDSHOP E-STATIONARY</title>
<meta name="description" content="Visit the online bookshop of MMM">
<meta name="keywords" content="bookshop, bookstore, author, buy books online, book shop, book store, Australia, self help, computers, Australian, books online">
<meta name="robots" content="index, follow">
<script language="javascript" src="Template2_MMM.com_files/stylesheet.js" type=""></script>
<link rel="StyleSheet" href="Template2_MMM.com_files/stylesheet_PCEXP.css" type="text/css">
<script language="javascript" src="Template2_MMM.com_files/functions.js" type=""></script>
<style type="text/css">
  <!--
    .style1 {font-size: 12pt}
    .style2 {
    font-size: 14pt;
    color: #FFFFFF;
    }
    .style3 {
    color: #333333;
    font-size: 12;
    }
    .style5 {font-size: 12; color: #000000; }
  .style6 {
	text-align: right;
}
  -->
</style>
</head>
<body alink="#00563b" bgcolor="#eeeeee" link="#00a651" text="#999999" vlink="#00563b">
  <!-- HEADER //-->
<a name="top"></a>
<table border="0" cellpadding="0" cellspacing="0" width="770">
  <tbody>
    <tr>
      <td bgcolor="#00563b" valign="top" width="391">
        <a href="http://www.angusrobertson.com.au/" target="_top" onMouseOver="window.status=''; return true" onMouseOut="window.status=''; return true">
          <img src="Template2_MMM.com_files/main01.jpg" alt="Angus &amp; Robertson Book Shop" border="0" height="69" width="391">
        </a>
      </td>
      <td align="right" bgcolor="#ffffff" valign="top" width="379">
        <table border="0" cellpadding="0" cellspacing="0">
          <tbody>
            <tr>
              <td colspan="2" valign="top">
                <div align="right">
                  <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="7" width="1">
                  <br>
                  <a href="javascript:launchthawte()" onMouseOver="window.status='View SSL Certificate Info'; return true" onMouseOut="window.status=''; return true">                    Security by MMM Team
                    &nbsp;&nbsp;
                    <img src="Template2_MMM.com_files/header_ssl.gif" alt="View SSL Certificate Info" align="middle" border="0" height="18" hspace="0" vspace="0" width="17">
                  </a>
                </div>
              </td>
              <td valign="bottom" width="18">
                <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="18">
              </td>
            </tr>
            <tr>
              <td valign="bottom">
                <table border="0" cellpadding="0" cellspacing="0">
                  <tbody>
                    <tr>
                      <td valign="bottom">
                        <a href="Cart.jsp" target="_top" onMouseOver="window.status='View Cart'; return true" onMouseOut="window.status=''; return true">
                          <img src="Template2_MMM.com_files/header_viewcart.gif" alt="View Cart" align="middle" border="0" height="12" width="57">
                        </a>
                      </td>
                      <td>
                        <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="3">
                      </td>
                      <td valign="bottom">
                        <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="40">
                      </td>
                      <td>
                        <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="3">
                      </td>
                      <td valign="bottom">
                        <a href="http://www.angusrobertson.com.au/checkout/viewcart.asp" target="_top" onMouseOver="window.status='View Cart'; return true" onMouseOut="window.status=''; return true">
                          <img src="Template2_MMM.com_files/header_cart.gif" alt=" Items" align="bottom" border="0" height="20" width="23">
                        </a>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </td>
              <td align="right" valign="bottom">
                <a href="Credit.jsp" target="_top" onMouseOver="window.status='My Account'; return true" onMouseOut="window.status=''; return true">
                  <img src="Template2_MMM.com_files/header_myaccount.gif" alt="My Account" border="0" height="12" width="67">
                </a>
              </td>
              <td>              </td>
            </tr>
          </tbody>
        </table>
      </td>
    </tr>
  </tbody>
</table>
  <!-- END HEADER //-->
  <!-- NAV //-->
<table width="582" border="0" cellpadding="0" cellspacing="0">
  <tbody>
    <tr bgcolor="#ffffff" valign="middle">
      <td colspan="12">
        <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="1">
      </td>
    </tr>
    <tr bgcolor="#00563b" valign="middle">
      <td width="5">
        <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="5">
      </td>
      <td width="45">
        <a href="Home.jsp" target="_top" onMouseOver="document.header_nav_home.src='/images/header_nav_home_o.gif'; window.status='Home'; return true" onMouseOut="window.status=''; return true">
          <img src="Template2_MMM.com_files/header_nav_home_o.gif" alt="Home" name="header_nav_home" border="0" height="25" width="39">
        </a>
      </td>
      <td width="1">
        <a href="http://www.angusrobertson.com.au/products/newreleases.asp" target="_top" onMouseOver="document.header_nav_newreleases.src='/images/header_nav_newreleases_o.gif'; window.status='New releases'; return true" onMouseOut="document.header_nav_newreleases.src='/images/header_nav_newreleases.gif'; window.status=''; return true">        </a>
      </td>
      <td width="66" class="titlebig whitelhs style1">
        <a href="Search.jsp" target="_top" class="style2" onMouseOver="window.status='View Cart'; return true" onMouseOut="window.status=''; return true">
          <span class="titlebig whitelhs style1">Search </span>
        </a>
      </td>
      <td width="47">
        <span class="titlebig whitelhs style1"> <a href="Cart.jsp" target="_top" onMouseOver="window.status='View Cart'; return true" onMouseOut="window.status=''; return true"><span class="titlebig whitelhs style1">Cart </span> </a>
      </td>
      <td width="62">
        <span class="titlebig whitelhs style1"> <a href="Credit.jsp" target="_top" onMouseOver="window.status='View Cart'; return true" onMouseOut="window.status=''; return true"><span class="titlebig whitelhs style1">credit </span></a>
      </td>
      <td width="50">
        <a href="Login.jsp" target="_top" onMouseOver="window.status='View Cart'; return true" onMouseOut="window.status=''; return true">
          <span class="titlebig whitelhs style1">log in </span>
        </a>
      </td>
      <td width="78">
        <a href="Signup.jsp" target="_top" onMouseOver="window.status='View Cart'; return true" onMouseOut="window.status=''; return true">
          <span class="titlebig whitelhs style1">edit info </span>
        </a>
      </td>
      <td width="98">
        <a href="Contactus.jsp" target="_top" onMouseOver="window.status='View Cart'; return true" onMouseOut="window.status=''; return true">
          <span class="titlebig whitelhs style1">contact us </span>
        </a>
      </td>
      <td width="61">
        <a href="History.jsp" target="_top" onMouseOver="window.status='View Cart'; return true" onMouseOut="window.status=''; return true">
          <span class="titlebig whitelhs style1">History</span>
        </a>
      </td>
      <td width="41">&nbsp;</td>
      <td width="28">&nbsp;</td>
    </tr>
    <tr bgcolor="#ffffff" valign="middle">
      <td colspan="12">
        <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="1">
      </td>
    </tr>
    <tr bgcolor="#00563b" valign="middle">
      <td colspan="12">
        <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="1">
      </td>
    </tr>
  </tbody>
</table>
<img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="5">
  <!-- END NAV//-->
<table border="0" cellpadding="0" cellspacing="0" width="780">
  <tbody>
    <tr>
      <td bgcolor="#ffffff" valign="top" width="144">
        <!-- LEFT HAND SIDE //-->
<script language="javascript" type="">
	<!--
	function Form_ValidatorLHSSubmit(SubmitType) {
		theForm = document.lhsform;
		if (Form_ValidatorLHS(theForm, SubmitType)) {
			theForm.submit();
		}
	}

	function Form_ValidatorLHS(theForm, SubmitType) {
		if (SubmitType.toLowerCase() == "search") {
			theForm.action = "/search/results.asp"
			// Validation script for field 'searchbycriteria' (Search Term)
if (theForm.searchbycriteria.value == "")
{
	alert("Please enter a value for the \"Search Term\" field.");
   theForm.searchbycriteria.focus();
   return (false);
}

		if (theForm.searchbycriteria.value.length < 1)
  	{
     	alert("Please enter at least 1 characters in the \"Search Term\" field.");
     	theForm.searchbycriteria.focus();
     	return (false);
  	}

  	if (theForm.searchbycriteria.value.length > 200)
  	{
     	alert("Please enter at most 200 characters in the \"Search Term\" field.");
     	theForm.searchbycriteria.focus();
     	return (false);
  	}


		} else {
			theForm.action = "/myaccount/login.asp"
			  // Email field validation
// Validation script for field 'email' (subscribing)
if (theForm.email.value == "")
{
	alert("Please enter a value for the \"subscribing\" field.");
   theForm.email.focus();
   return (false);
}

		if (theForm.email.value.length < 1)
  	{
     	alert("Please enter at least 1 characters in the \"subscribing\" field.");
     	theForm.email.focus();
     	return (false);
  	}

  	if (theForm.email.value.length > 150)
  	{
     	alert("Please enter at most 150 characters in the \"subscribing\" field.");
     	theForm.email.focus();
     	return (false);
  	}

  if (theForm.email.value.indexOf("@",1) == -1)
  {
    alert("Not a valid e-mail address for subscribing.");
    theForm.email.focus();
    return (false);
  }

  if (theForm.email.value.indexOf(".",theForm.email.value.indexOf("@")+1) == -1)
  {
    alert("Not a valid e-mail address for subscribing.");
    theForm.email.focus();
    return (false);
  }


		}
		return true;
	}
	//-->
	</script>
        <form method="get" action="/search/results.asp">
        <table border="0" cellpadding="0" cellspacing="0" width="144">
          <tbody>
            <tr>
              <td valign="top" width="9">
                <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="9">
              </td>
              <td colspan="2" valign="top" width="126">
                <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="18" width="1">
              </td>
              <td valign="top" width="9">
                <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="9">
              </td>
            </tr>
            <tr>
              <td>              </td>
              <td colspan="2" valign="top">
                <img src="Template2_MMM.com_files/left_search.gif" alt="Search" border="0" height="17" width="47">
                <br>
                                    <form action="Search.jsp" method="post" >
                      <input name="key" value="" class="lhstext126" size="12" type="text">
                    	</form>
              </td>
              <td>              </td>
            </tr>
            <tr>
              <td>              </td>
              <td valign="top" class="style6">
                    	<input name="Submit1" type="submit" value="Search"></td>

            </tr>
            <tr>
              <td colspan="4">
                <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="8" width="1">
              </td>
            </tr>
            <tr>
              <td colspan="4" bgcolor="#cccccc">
                <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="1">
              </td>
            </tr>
          </tbody>
        </table>
        </form>
        <table bgcolor="#00563b" border="0" cellpadding="0" cellspacing="0" width="144">
          <tbody>
            <tr>
              <td valign="top" width="9">
                <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="9">
              </td>
              <td valign="top" width="135">
                <span class="titlebig whitelhs style1">Product</span>
              </td>
              <td>
                <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="1">
              </td>
            </tr>
            <tr>
              <td>
                <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="1">
              </td>
              <td class="whitelhs" valign="top">                -
                <a href="http://www.angusrobertson.com.au/products/top100.asp" class="whitelhs">CD</a>
                <br>
                -
                <a href="http://www.angusrobertson.com.au/products/bestsellers.asp" class="whitelhs">Book</a>
                <br>
                -
                <a href="http://www.angusrobertson.com.au/products/GuaranteedGreatReads.asp" class="whitelhs">Stationary</a>
                <br>
                <br>
                <br>
                <a href="http://www.angusrobertson.com.au/products/categories.asp" class="whitelhs">View All Categories</a>
              </td>
              <td>
                <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="1">
              </td>
            </tr>
            <tr>
              <td colspan="3" valign="top">
                <img src="Template2_MMM.com_files/left_fade.gif" alt="" border="0" height="250" width="144">
              </td>
            </tr>
          </tbody>
        </table>
        <!-- END LEFT HAND SIDE //-->
      </td>
      <td bgcolor="#999999" valign="top" width="1">
        <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="1">
      </td>
      <td valign="top" width="10">
        <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="10">
      </td>
      <td valign="top" width="625">
        <!-- MAIN CONTENT //-->
        <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="18" width="1">
        <br>
        <table border="0" cellpadding="0" cellspacing="0" width="625">
          <tbody>
            <tr>
              <td valign="top">
                <table border="0" cellpadding="0" cellspacing="0">
                  <tbody>
                    <tr>
                      <td colspan="3" bgcolor="#cccccc" valign="top">
                        <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="260">
                      </td>
                    </tr>
                    <!--
                      <tr>
                      <td valign="top" bgcolor="#CCCCCC" colspan="1"><img src="images/gap.gif" width="1" height="1" alt="" border="0"></td>
                      <td align="center" valign="top" bgcolor="#FFFFFF" width="100%">
                      <table cellspacing="9" width="100%"><tr>
                      <td valign="top" bgcolor="#00563B" colspan="2"><img src="images/gap.gif" width="4" height="1" alt="" border="0"><img src="images/title_octcat.gif" height="25" alt="MMM November Catalogue" border="0"></td>
                      </tr>
                      </table>
                      </td>
                      <td valign="top" bgcolor="#CCCCCC"><img src="images/gap.gif" width="1" height="1" alt="" border="0"></td>
                      </tr>
                    -->
                    <tr>
                      <td bgcolor="#cccccc" valign="top">
                        <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="1">
                      </td>
                      <td align="center" bgcolor="#ffffff" valign="top">
                        <a href="http://top100.angusrobertson.com.au/" target="_blank">
                          <img src="Template2_MMM.com_files/kirkdale_bookshop_01.jpg" border="0" height="178" hspace="4" vspace="4" width="200" alt="">
                        </a>
                      </td>
                      <td bgcolor="#cccccc" valign="top">
                        <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="1">
                      </td>
                    </tr>
                    <tr>
                      <td colspan="3" bgcolor="#cccccc" valign="top">
                        <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="1">
                      </td>
                    </tr>
                  </tbody>
                </table>
                <!--
                  <table cellpadding="0" cellspacing="0" border="0">
                  <tr><td valign="top" colspan="3" bgcolor="#CCCCCC"><img src="images/gap.gif" width="260" height="1" alt="" border="0"></td></tr>
                  <tr>
                  <td valign="top" bgcolor="#CCCCCC"><img src="images/gap.gif" width="1" height="1" alt="" border="0"></td>
                  <td valign="top" bgcolor="#FFFFFF"><a href="#"><img src="images/arjan.gif" width="250" height="198" alt="Angus & Robertson Online" border="0" hspace="4" vspace="4"></a></td>
                  <td valign="top" bgcolor="#FFFFFF"><a href="#"><img src="images/random1.jpg" width="250" height="215" alt="Angus & Robertson Online" border="0" hspace="4" vspace="4"></a></td>
                -->
                <!--
                  <td valign="top" bgcolor="#FFFFFF"><a href="http://www.booksalive.com.au/" target="blank"><img src="images/books-alive.gif" width="250" height="198" alt="Kids' Top 50" border="0" hspace="4" vspace="4"></a></td>
                  <td valign="top" bgcolor="#CCCCCC"><img src="images/gap.gif" width="1" height="1" alt="" border="0"></td>
                  </tr>
                  <tr><td valign="top" colspan="3" bgcolor="#CCCCCC"><img src="images/gap.gif" width="1" height="1" alt="" border="0"></td></tr>
                  </table>
                -->
              </td>
              <td valign="top">
                <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="10">
              </td>
              <td valign="top">
                <table border="0" cellpadding="0" cellspacing="0">
                  <tbody>
                    <tr>
                      <td colspan="3" bgcolor="#cccccc" valign="top">
                        <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="356">
                      </td>
                    </tr>
                    <tr>
                      <td bgcolor="#cccccc" valign="top">
                        <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="1">
                      </td>
                      <td align="center" bgcolor="#ffffff" valign="top" width="100%">
                        <a href="http://www.angusrobertson.com.au/products/harrypotter.asp">
                          <img src="Template2_MMM.com_files/n-cdshop.gif" alt="A&amp;R Win! Promotion" border="0" height="177" hspace="4" vspace="4" width="211">
                        </a>
                      </td>
                      <!--<td align="center" valign="top" bgcolor="#FFFFFF" width="100%"><img src="images/Big-Book-Sale1.gif" width="345" height="198" alt="MMM Big Book Sale" border="0" hspace="4" vspace="4"></a></td>-->
                      <td bgcolor="#cccccc" valign="top">
                        <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="1">
                      </td>
                    </tr>
                    <tr>
                      <td colspan="3" bgcolor="#cccccc" valign="top">
                        <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="356">
                      </td>
                    </tr>
                  </tbody>
                </table>
              </td>
            </tr>
          </tbody>
        </table>
        <div align="center">
          <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="9" width="1">
          <table border="0" cellpadding="0" cellspacing="0" width="559">
            <tbody>
              <tr bgcolor="#cccccc">
                <td valign="top" width="1">
                  <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="1">
                </td>
                <td valign="top" width="550">
                  <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="264">
                </td>
                <td valign="top" width="1">
                  <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="1">
                </td>
                <td valign="top" width="6">&nbsp;</td>
                <td valign="top" width="10">
                  <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="1">
                </td>
              </tr>
              <tr bgcolor="#cccccc">
                <td valign="top" width="1">
                  <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="1">
                </td>
                <td bgcolor="#ffffff" valign="top" width="550">
                  <P>
                    <SPAN class=bodtxthovoff>Please enter your account
            information in the fields below then click the Continue
            button. </SPAN>

                  <P class="style3">
                    <span class="bodtxthovoff">Upon completion of the sign up process you need to
            confirm an activation request e-mail which<BR>  will be
            sent to the e-mail address you enter below.</span>

                  <P class="style3">
                    <SPAN class=bodalert>*</SPAN>
                    Required

                  <FORM action=ThanksSignup.jsp method=post name=form_reg class="style3">
                    <!-- id & password--><!-- T1 -->
                  <TABLE cellSpacing=0 cellPadding=3 width=550 border=1>
                    <TBODY>
                      <TR>
                        <TD bgColor=#006600>
                          <SPAN class=bodtxtboldhovoff>Create Your Own ID &amp; Password</SPAN>
                        </TD>
                      </TR>
                      <TR>
                        <TD>
                          <!-- T2 -->
                          <TABLE cellSpacing=0 cellPadding=3 width="100%" border=0>
                            <TBODY>
                              <TR>
                                <TD align=right width="30%">
                                  <SPAN class=bodtxtboldhovoff>* Account
                                          ID<SUP>+</SUP></SPAN>
                                </TD>
                                <TD width="70%">
                                  <INPUT name=p_user_name maxLength=30>
                                </TD>
                              </TR>
                              <TR>
                                <TD align=right width="30%">
                                  <SPAN class=bodtxtboldhovoff>* Preferred
                                          Password</SPAN>
                                </TD>
                                <TD width="70%">
                                  <INPUT name=p_password type=password maxLength=40>
                                </TD>
                              </TR>
                              <TR>
                                <TD align=right width="30%">
                                  <SPAN class=bodtxtboldhovoff>* Re-type Password</SPAN>
                                </TD>
                                <TD width="70%">
                                  <INPUT name=p_password2 type=password maxLength=40>
                                </TD>
                              </TR>
                              <TR>
                                <TD align=right width="30%">
                                  <SPAN class=bodtxtboldhovoff>* Name </SPAN>
                                </TD>
                                <TD width="70%">
                                  <span class="style5">  <input maxlength=500 size=35 name=p_name>  &nbsp;<A class=bodtxthovoff href="javascript:openSample()"></A></span>
                                </TD>
                              </TR>
                              <TR>
                                <TD align=right width="30%">
                                  <SPAN class=bodtxtboldhovoff>*Last Name </SPAN>
                                </TD>
                                <TD width="70%">
                                  <INPUT name=p_l_name size=35 maxLength=500>
                                </TD>
                              </TR>
                              <TR>
                                <TD class=bodtxt colSpan=2>
                                  <TABLE width="100%">
                                    <TBODY>
                                      <TR>
                                        <TD width=10 vAlign=top class=bodtxtboldhovoff>+</TD>
                                        <TD class=bodtxtsmhovoff>
                                          Valid Characters: A-Z,
                                          0-9, _. Invalid Characters: - ,
                                          &amp;

                                          , #, (),
                                          {}, [], &quot; &quot; and spaces
                                        </TD>
                                      </TR>
                                    </TBODY>
                                  </TABLE>
                                </TD>
                              </TR>
                            </TBODY>
                          </TABLE>
                          <!-- /T2 -->
                        </TD>
                      </TR>
                    </TBODY>
                  </TABLE>
                    <!-- /T1 --><!-- / id & password-->
                  <BR>
                    <!-- personal--><!-- T1 -->
                  <TABLE cellSpacing=0 cellPadding=3 width=550 border=1>
                    <TBODY>
                      <TR>
                        <TD bgColor=#006600>
                          <SPAN class=bodtxtboldhovoff>Personal
                                Information</SPAN>
                        </TD>
                      </TR>
                      <TR>
                        <TD>
                          <!-- T2 -->
                          <TABLE cellSpacing=0 cellPadding=3 width="100%" border=0>
                            <TBODY>
                              <TR>
                                <TD align=right width="30%">
                                  <SPAN class=bodtxtboldhovoff>*Requested Deposit </SPAN>
                                </TD>
                                <TD width="70%">
                                  <INPUT name=p_deposit maxLength=30>
                                </TD>
                              </TR>
                              <TR>
                                <TD align=right>
                                  <SPAN class=bodtxtboldhovoff>Description</SPAN>
                                </TD>
                                <TD>
                                  <INPUT name=p_description size=35 maxLength=260>
                                </TD>
                              </TR>
                              <TR>
                                <TD align=right width="30%">
                                  <SPAN class=bodtxtboldhovoff>* Address</SPAN>
                                </TD>
                                <TD width="70%">
                                  <INPUT name=p_address size=35 maxLength=64>
                                </TD>
                              </TR>
                              <TR>
                                <TD align=right width="30%">
                                  <SPAN class=bodtxtboldhovoff>&nbsp;</SPAN>
                                </TD>
                                <TD width="70%">
                                  <INPUT name=p_address2 size=35 maxLength=64>
                                </TD>
                              </TR>
                              <TR>
                                <TD align=right width="30%">
                                  <SPAN class=bodtxtboldhovoff>* TEL</SPAN>
                                </TD>
                                <TD width="70%">
                                  <INPUT name=p_tel maxLength=50>
                                </TD>
                              </TR>
                              <TR>
                                <TD align=right>
                                  <SPAN class=bodtxtboldhovoff>* email </SPAN>
                                </TD>
                                <TD>
                                  <INPUT name=p_email maxLength=30>
                                </TD>
                              </TR>
                              <TR>
                                <TD align=right width="30%">
                                  <SPAN class=bodtxtboldhovoff>*Gender</SPAN>
                                </TD>
                                <TD width="70%">
                                  <span class="black">  <SELECT name=p_gender class="darkgreen"> <OPTION value="" selected>--Unselected--</OPTION> <OPTION value=m>Male</OPTION> <OPTION value=f>Female</OPTION> <OPTION> </SELECT>  </span>
                                </TD>
                              </TR>
                              <TR>
                                <TD class=bodtxt colSpan=2>
                                  <TABLE width="100%">
                                    <TBODY>
                                      <TR>
                                        <TD width=10 vAlign=top class=bodtxtboldhovoff>+</TD>
                                        <TD class=bodtxtsmhovoff>
                                          To activate your
                                          MMM.com account, you will need to confirm an
                                          activation request e-mail that will be sent to
                                          this address.
</TD>
                                      </TR>
                                    </TBODY>
                                  </TABLE>
                                </TD>
                              </TR>
                            </TBODY>
                          </TABLE>
                          <!-- /T2 -->
                        </TD>
                      </TR>
                    </TBODY>
                  </TABLE>
                  <div align="right">
                    <!-- /T1 -->
                    <!-- / personal-->
                    <input name="Reset" type=reset class="carttotal" onClick="document.location='signup.jsp'" value=Clear>
                    <input name=p_submit2 type=submit class="carttotal" value=Confirm>
                    <img src="Template2_MMM.com_files/pagecurl.gif" alt="" border="0" height="27" width="22">
                  </div>
                  </FORM>
<SCRIPT language=JavaScript type="">
<!--
function openSample() {
  window1=window.open("chooser_sample_questions.jsp",
     "Samples", "width=400,height=400,toolbar=no, directories=no,menubar=no,scrollbars=yes,resizeable=no");
   window1.focus();
}

function SetQuestion(question) {
    document.forms[0].p_sec_question.value=question;
}
-->
</SCRIPT>

              </TR>
            </TBODY>
          </TABLE>
        </div>
        <p align="center">&nbsp;</p>
      </TD>
    </TR>
  </TBODY>
  <TR>
    <TD width=11 bgColor=#ffffff height=18>&nbsp;</TD>
  </TR>
  <td valign="top" width="1">
    <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="1">
  </td>
  <td bgcolor="#ffffff" valign="top" width="358">&nbsp;</td>
  <td valign="top" width="1">
    <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="1">
  </td>
  <tr bgcolor="#cccccc">
    <td valign="top">
      <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="1">
    </td>
    <td bgcolor="#ffffff" valign="top">
      <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="1">
    </td>
    <td valign="top">
      <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="1">
    </td>
    <td align="right" bgcolor="#ffffff" valign="bottom">&nbsp;</td>
    <td valign="bottom">
      <img src="Template2_MMM.com_files/gapEEEEEE.gif" alt="" border="0" height="26" width="1">
    </td>
  </tr>
  <tr bgcolor="#cccccc">
    <td colspan="5" align="right" valign="top">
      <img src="Template2_MMM.com_files/gapEEEEEE.gif" alt="" border="0" height="1" width="13">
      <br>
      <br>
      <!-- END MAIN CONTENT //-->
    </td>
  </tr>
  <!-- FOOTER //-->
  <table border="0" cellpadding="0" cellspacing="0" width="780">
    <tbody>
      <tr valign="top">
        <td colspan="4" bgcolor="#ffffff">
          <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="1">
        </td>
      </tr>
      <tr bgcolor="#00563b" valign="middle">
        <td width="14">
          <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="17" width="14">
        </td>
        <td class="white" width="376">© Copyright MMM 2007</td>
        <td align="right" width="376">
          <a href="javascript:privacypolicy()" class="footer">Privacy Policy</a>
          <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="15">
          <a href="javascript:termsofuse()" class="footer">Terms of Use</a>
        </td>
        <td width="14">
          <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="14">
        </td>
      </tr>
      <tr valign="top">
        <td colspan="4" bgcolor="#00563b">
          <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="1">
        </td>
      </tr>
      <tr valign="top">
        <td colspan="4" bgcolor="#ffffff">
          <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="1">
        </td>
      </tr>
      <tr valign="top">
        <td colspan="4" bgcolor="#00563b">
          <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="1" width="1">
        </td>
      </tr>
      <tr valign="top">
        <td colspan="4">
          <img src="Template2_MMM.com_files/gap.gif" alt="" border="0" height="2" width="1">
        </td>
      </tr>
      <tr valign="top">
        <td>        </td>
        <td class="grey666666">WWW.MMM.COM</td>
        <td class="grey666666" align="right">          Site designed by
          <a href="http://www.spin.com.au/" target="_blank" class="darkgreen">MMM</a>
        </td>
        <td>        </td>
      </tr>
    </tbody>
  </table>
  <!-- EOF -->

</body>
</html>
