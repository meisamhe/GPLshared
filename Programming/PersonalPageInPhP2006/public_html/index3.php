<html>
<head>
<title>Template 18</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000" link="#003399" vlink="#6699FF" alink="#003399">
<table width="750" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="154">
      <table width="154" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><img src="images/logo_top.gif" width="154" height="48"></td>
        </tr>
        <tr>
          <td><p align="center"> <font color="#00CC66" size="5" face="Times New Roman, Times, serif"><strong>Meisam Hejazinia</strong></font></p></td>
        </tr>
        <tr>
          <td><img src="images/logo_bottom.gif" width="154" height="45"></td>
        </tr>
      </table>
    </td>
    <td height="137" width="596">
      <table width="596" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="48">&nbsp;</td>
        </tr>
        <tr>
          <td height="44"><img src="images/neon_top_nav.gif" width="596" height="19"><a href="index.php
			"><br>
            <img src="images/HW1_on.gif" width="96" height="24"></a><a href="index2.php
			"><img src="images/HW2.gif" width="96" height="24" border="0"></a><a href="index3.php
			"><img src="images/link3_off.gif" width="96" height="24" border="0"></a><a href="index4.php"><img src="images/link4_off.gif" width="96" height="24" border="0"></a><a href="index5.php"><img src="images/link5_off.gif" width="96" height="24" border="0"></a><a href="index6.php"><img src="images/link6_off.gif" width="96" height="24" border="0"></a>          </td>
        </tr>
        <tr>
          <td height="45">
            <table width="596" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="65%" align="right"><b><font face="Verdana, Arial, Helvetica, sans-serif" color="#003399">Welcom to Meisam Hejazinia Website </font></b></td>
                <td>&nbsp;</td>
              </tr>
            </table>
            
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="750" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="50%"> 
      <p>&nbsp;</p>
      <ul>
        <li type=square><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
		<?php print "hello ";
print $enteredusername;
print "  Thank you for signup!";
print <<<_HTML_
<p> Your password is:</p>
_HTML_;
print $password;?>
<?php
// Connect and Select the database
mysql_connect('192.168.128.4:3306',
'8331701', 'kom78');
mysql_select_db('test');
// Now let’s grab a name
$result = mysql_query("SELECT *
FROM catal;");
$blurb = mysql_fetch_array($result) or die(mysql_error());
print("$blurb[0]");
//$age = mysql_fetch_assoc($result);
//echo $age[0];
?>
</font></font> 
      </ul>
    </td
    ><td align="center" valign="middle"><img src="images/building.gif" width="345" height="230" border="1"></td>
  </tr>
  <tr> 
    <td colspan="2"> 
      <table width="750" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td>
            <table width="750" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="154">&nbsp;</td>
                <td>
                  <table width="596" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="69%" align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b><font color="#003399"><a href="index.htm">link 
                        1</a> - <a href="index2.htm">link 2</a> - <font color="#000000">link 
                        3</font> - <a href="index4.htm">link 4</a> - <a href="index5.htm">link 
                        5</a> - <a href="index6.htm">link 6</a></font></b></font></td>
                      <td>&nbsp;</td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      
    </td>
  </tr>
</table>
</body>
</html>


