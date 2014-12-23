<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns="http://www.w3.org/1999/xhtml">
  <xsl:output method="xml" indent="yes"/>
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
    <tr>
      <td><xsl:value-of select="position()"/></td>
      <td><xsl:value-of select="@id" /></td>
      <td><xsl:value-of select="@name" /></td>
      <td><xsl:value-of select="../@id" /></td>
      <td><xsl:value-of select="../@name" /></td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
