<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:template match="/">
  <html>
   <head>
    <title>XQuery Output</title>
   </head>
   <body>
    <table border="3">
    <tr><td>Name</td><td>Address</td></tr>
     <xsl:for-each select="//employee">
      <tr>
       <td><xsl:value-of select="./NAME"/></td>
       <td><xsl:value-of select="./ADDRESS"/></td>
      </tr>
     </xsl:for-each>
    </table>
   </body>
  </html>
 </xsl:template>
</xsl:stylesheet>