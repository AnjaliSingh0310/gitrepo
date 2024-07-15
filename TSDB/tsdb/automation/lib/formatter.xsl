<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
  <html>
  <head>
    <style type="text/css">
	td { word-wrap: break-word;max-width:600px; }
    </style>
  </head>
  <body>
  <h2>TSDB Automation Report</h2>
  <table border="2" style="border-collapse : collapse;">
    <tr bgcolor="#9acd32">
      <th>Testsuite</th>
      <th>TotalTests</th>
      <th>Passed</th>
      <th>Failed</th>
      <th>Skipped</th>
      <th>TotalTime</th>
    </tr>
    <xsl:for-each select="testsuites/testsuite">
    <tr>
	    <td><xsl:value-of select="@name"/></td>
	    <td><xsl:value-of select="@tests"/></td>
	    <td><xsl:value-of select="count(testcase[not(failure) and not(skipped)])"/></td>
	    <td><xsl:value-of select="@failures"/></td>
	    <td><xsl:value-of select="@skipped"/></td>
	    <td><xsl:value-of select="@time"/>s</td>
    </tr>
    </xsl:for-each>
  </table>
  <br></br>
  <xsl:for-each select="testsuites/testsuite">
  <table border="2" style="border-collapse : collapse;">
    <tr bgcolor="#9acd32">
	    <th colspan="4" style="text-align: center;"><xsl:value-of select="@name"/></th>
    </tr>
    <tr>
	 <th>TestCase</th>
	 <th>Status</th>
	 <th>FailReason</th>
         <th>Time</th>
    </tr>
    <xsl:for-each select="testcase">
     <tr>
	     <td><xsl:value-of select="@name"/></td>
	     <td style="word-wrap: break-word;max-width:60px;">
		<xsl:choose>
                   <xsl:when test="failure">Fail</xsl:when>
                   <xsl:when test="skipped">Skip</xsl:when>
                   <xsl:otherwise>Pass</xsl:otherwise>
                </xsl:choose>
	     </td>
	     <td style="word-wrap: break-word;max-width:300px;">
		<xsl:choose>
                   <xsl:when test="failure"><xsl:value-of select="failure"/></xsl:when>
                   <xsl:when test="skipped"></xsl:when>
		   <xsl:otherwise></xsl:otherwise>
                </xsl:choose>
	     </td>
	     <td style="word-wrap: break-word;max-width:60px;">
		<xsl:value-of select="@time"/>
	     </td>

     </tr>
     </xsl:for-each>
	      <tr>
              <td colspan="3">
                Total Test Cases: <xsl:value-of select="count(testcase)"/>
              </td>
            </tr>
  </table>
  <br></br>
  </xsl:for-each>
  </body>
  </html>
</xsl:template>
</xsl:stylesheet>
