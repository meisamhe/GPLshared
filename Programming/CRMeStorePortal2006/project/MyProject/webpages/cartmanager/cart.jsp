<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title> Cart </title>
</head>
<style type="text/css">
<!--
body { 
	
	background-position: top ;
	background-repeat: no-repeat;
	border:#CCCCCC;
		 
}
-->
</style>

<body >

<table cellpadding="0" cellspacing="0" width="700" border="2" align="center">
  <tr>
    <td background="/MyProject/webpages/images/home.gif" width="700" height="500" valign="top">
	
	<table border="3"   cellpadding="5" cellspacing="5" width="700" >
		<tr>
			<td align="right">
			<form>
				Search the product you want :
				<input type="text" name="search" width="30" /><input type="button"  value=" Go " />
			</form>
		  	</td>
		</tr>
		
		<tr>
			<td>
				list of products
			</td>
		</tr>
		<tr>
			<td>
				<form method="post" action="">
				<input type="submit" value="Check Out" />
				<input type="reset" value="Discard" />
				</form>
			</td>
		</tr>
		
	</table>	
	</td>
  </tr>
</table>
	



</body>
</html>
