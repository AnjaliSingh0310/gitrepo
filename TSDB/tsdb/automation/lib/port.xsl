<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/Server">
<xsl:value-of select="Service/Connector[2]/@port"/>
</xsl:template>
</xsl:stylesheet>
