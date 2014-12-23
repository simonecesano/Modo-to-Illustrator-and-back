<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="xml" indent="yes"/>
  <xsl:variable name="count">1</xsl:variable>
  <xsl:template match="/">
    <parts><xsl:apply-templates select="//ColorWay//ColorPartList/Color/TargetPart" /></parts>
  </xsl:template>
  <xsl:template match="//ColorWay//ColorPartList/Color/TargetPart">
    <part>
      <id><xsl:value-of select="position()"/></id>
      <part_name><xsl:value-of select="@name" /></part_name>
      <part_id><xsl:value-of select="@id" /></part_id>
      <color><xsl:value-of select="../@id" /></color>
      <color_name><xsl:value-of select="../@name" /></color_name>
    </part>
  </xsl:template>
</xsl:stylesheet>
