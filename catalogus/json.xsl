<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" version="2.0">

  <xsl:output indent="no" omit-xml-declaration="yes" method="text" encoding="utf-8"/>
  <xsl:strip-space elements="*"/>

  <!-- Parameter tab bepaalt de inspringing in json, parameter level bepaalt de diepte -->
  <xsl:param name="tab"><xsl:text>  </xsl:text></xsl:param>

  <xsl:template match="/">
    <xsl:apply-templates select="node()">
      <xsl:with-param name="level" select="0"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="root|element()[child::element]" priority="10">
    <xsl:param name="level" as="xs:integer"/>
    <xsl:variable name="indent" select="for $index in 1 to $level return $tab"/>
    <!-- element bevat een array -->
    <xsl:value-of select="fn:string-join(($indent,if (self::root|self::element) then '' else concat('&quot;',name(),'&quot;: '),'[&#10;'),'')"/>
    <xsl:apply-templates>
      <xsl:with-param name="level" select="$level+1"/>
    </xsl:apply-templates>
    <xsl:value-of select="fn:string-join(($indent,']',if (following-sibling::element()) then ',' else '','&#10;'),'')"/>
  </xsl:template>

  <xsl:template match="element()[child::element()]">
    <xsl:param name="level" as="xs:integer"/>
    <xsl:variable name="indent" select="for $index in 1 to $level return $tab"/>
    <xsl:value-of select="fn:string-join(($indent,if (self::root|self::element) then '' else concat('&quot;',name(),'&quot;: '),'{&#10;'),'')"/>
    <xsl:apply-templates select="@*|node()">
      <xsl:with-param name="level" select="$level+1"/>
    </xsl:apply-templates>
    <xsl:value-of select="fn:string-join(($indent,'}',if (following-sibling::element()) then ',' else '','&#10;'),'')"/>
  </xsl:template>

  <xsl:template match="element()[child::text()]">
    <xsl:param name="level" as="xs:integer"/>
    <xsl:variable name="indent" select="for $index in 1 to $level return $tab"/>
    <xsl:value-of select="fn:string-join(($indent,if (self::root|self::element) then '' else concat('&quot;',name(),'&quot;: '),'&quot;'),'')"/>
    <xsl:copy-of select="text()"/>
    <xsl:value-of select="fn:string-join(('&quot;',if (following-sibling::element()) then ',' else '','&#10;'),'')"/>
  </xsl:template>

  <xsl:template match="@*">
    <xsl:param name="level" as="xs:integer"/>
    <xsl:variable name="indent" select="for $index in 1 to $level return $tab"/>
    <xsl:value-of select="fn:string-join(($indent,'&quot;@',name(),'&quot;: ','&quot;'),'')"/>
    <xsl:value-of select="."/>
    <xsl:value-of select="fn:string-join(('&quot;,&#10;'),'')"/>
  </xsl:template>

</xsl:stylesheet>