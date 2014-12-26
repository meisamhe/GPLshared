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
          <td><img src="images/your_logo_middle.gif" width="154" height="44"></td>
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
          <td height="44"><img src="images/neon_top_nav.gif" width="596" height="19"></a><a href="index.php
			"><br>
            <img src="images/HW1.gif" width="96" height="24"><a href="index2.php
			"><img src="images/HW2.gif" width="96" height="24" border="0"></a><a href="index3.php
			"><img src="images/link3_off.gif" width="96" height="24" border="0"></a><a href="index4.php"><img src="images/link4_off.gif" width="96" height="24" border="0"></a><a href="index5.php"><img src="images/link5_on.gif" width="96" height="24" border="0"></a><a href="index6.php"><img src="images/link6_off.gif" width="96" height="24" border="0"></a>          </td>
        </tr>
        <tr>
          <td height="45">
            <table width="596" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="65%" align="right"><b><font face="Verdana, Arial, Helvetica, sans-serif" color="#003399">Welcome 
                  to yourcompany.com!</font></b></td>
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
      <?
$ns="http://localhost/nusoap"; 
$server = new soap_server(); 
$server->configureWSDL ('CanadaTaxCalculator',$ns); 
$server->wsdl->schemaTargetNamespace = $ns; 
$server->register('CalculateOntarioTax', array('amount' => 'xsd:string'), array('return' => 'xsd:string'), $ns); 
function CalculateOntarioTax($amount){ $taxcalc=$amount*.15; 
   return new soapval('return','string',$taxcalc);
 } 
$server->service ($HTTP_RAW_POST_DATA); ?> 

    </td>
    <td align="center" valign="middle"><img src="images/building.gif" width="345" height="230" border="1"></td>
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
                        1</a> - <a href="index2.htm">link 2</a> - <a href="index3.htm">link 
                        3</a> - <font color="#000000">link 4</font> - <a href="index5.htm">link 
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


