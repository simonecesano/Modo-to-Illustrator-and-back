<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns="http://www.w3.org/1999/xhtml">
  <xsl:output method="text" indent="no"/>
  <xsl:variable name="count">1</xsl:variable>
  <xsl:template match="/">
    <html>
      <table>
	<xsl:apply-templates select="//ColorWay//ColorPartList/Color/TargetPart">
	  <xsl:sort select="number(@id)" data-type="number"/>
	</xsl:apply-templates>
      </table>
    </html>
  </xsl:template>
  <xsl:template match="//ColorWay//ColorPartList/Color/TargetPart">
    <xsl:value-of select="position()"/><xsl:text>&#x9;</xsl:text>
    <xsl:value-of select="@id" /><xsl:text>&#x9;</xsl:text>
    <xsl:value-of select="@name" /><xsl:text>&#x9;</xsl:text>
    <xsl:value-of select="../@id" /><xsl:text>&#x9;</xsl:text>
    <xsl:value-of select="../@name" /><xsl:text>&#x9;</xsl:text>
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>
</xsl:stylesheet>
