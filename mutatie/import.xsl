<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions">
  <xsl:output method="text" version="1.0"/>
  <xsl:strip-space elements="*"/>

  <xsl:param name="base.dir" select="string('file:/C:/Werkbestanden/Geonovum/mutatie')"/>
  <xsl:param name="waardelijsten" select="collection(concat($base.dir,'/input?select=*.xml'))/waardelijsten"/>

  <xsl:template match="root">
    <xsl:result-document href="{concat($base.dir,'/temp/stap_0.xml')}" method="xml" encoding="utf-8" indent="yes">
      <xsl:apply-templates select="$waardelijsten">
        <xsl:with-param name="mode" select="string('stap_0')"/>
      </xsl:apply-templates>
    </xsl:result-document>
    <xsl:result-document href="{concat($base.dir,'/temp/stap_1.xml')}" method="xml" encoding="utf-8" indent="yes">
      <xsl:apply-templates select="$waardelijsten">
        <xsl:with-param name="mode" select="string('stap_1')"/>
      </xsl:apply-templates>
    </xsl:result-document>
  </xsl:template>

  <!-- algemeen -->

  <xsl:template match="element()">
    <xsl:param name="mode"/>
    <xsl:copy>
      <xsl:apply-templates select="@*|node()">
        <xsl:with-param name="mode" select="$mode"/>
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@*">
    <xsl:copy-of select="."/>
  </xsl:template>

  <xsl:template match="text()">
    <xsl:copy-of select="."/>
  </xsl:template>

  <!-- routines -->

  <xsl:template name="doe_mutatie">
    <xsl:param name="mode"/>
    <xsl:param name="mutatie"/>
    <xsl:param name="datum"/>
    <xsl:param name="type"/>
    <xsl:choose>
      <xsl:when test="$mode='stap_0'">
        <xsl:choose>
          <xsl:when test="$type='verwijder'">
            <xsl:processing-instruction name="{$type}" select="$datum"/>
            <xsl:copy-of select="."/>
          </xsl:when>
          <xsl:when test="$type='vervang'">
            <xsl:processing-instruction name="{$type}" select="$datum"/>
            <xsl:copy-of select="."/>
          </xsl:when>
          <xsl:when test="$type='voegtoe'">
            <xsl:copy-of select="."/>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$mode='stap_1'">
        <xsl:choose>
          <xsl:when test="$type='verwijder'">
            <!-- doe niets -->
          </xsl:when>
          <xsl:when test="$type='vervang'">
            <xsl:processing-instruction name="{$type}" select="$datum"/>
            <xsl:copy-of select="$mutatie/element()"/>
          </xsl:when>
          <xsl:when test="$type='voegtoe'">
            <xsl:copy>
              <xsl:for-each select="$mutatie/element()">
                <xsl:processing-instruction name="{$type}" select="$datum"/>
                <xsl:copy-of select="."/>
              </xsl:for-each>
              <xsl:copy-of select="node()"/>
            </xsl:copy>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>