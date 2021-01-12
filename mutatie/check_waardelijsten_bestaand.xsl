<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions">
  <xsl:output method="xml" version="1.0" indent="yes" encoding="utf-8"/>
  <xsl:strip-space elements="*"/>

  <xsl:template match="/">
    <xsl:apply-templates select="waardelijsten"/>
  </xsl:template>

  <xsl:template match="waarde">
    <xsl:variable name="id_bron" select="bron/text()"/>
    <xsl:variable name="id_domein" select="domein/text()"/>
    <xsl:variable name="test_bron" select="ancestor::waardelijst/bronnen/bron[uri=$id_bron]/(preceding-sibling::node()[1][self::processing-instruction()]|descendant::processing-instruction())"/>
    <xsl:variable name="test_domein" select="ancestor::waardelijst/domeinen/domein[uri=$id_domein]/(preceding-sibling::node()[1][self::processing-instruction()]|descendant::processing-instruction())"/>
    <xsl:variable name="test_waarde" select="preceding-sibling::node()[1][self::processing-instruction()]|descendant::processing-instruction()"/>
    <xsl:variable name="einddatum" select="fn:distinct-values(($test_bron,$test_domein,$test_waarde))"/>
    <xsl:element name="{name()}">
      <xsl:for-each select="element()">
        <xsl:choose>
          <xsl:when test="($einddatum castable as xs:date) and self::geldigheid">
            <xsl:element name="{name()}">
              <xsl:apply-templates select="startdatum"/>
              <xsl:element name="einddatum">
                <xsl:value-of select="$einddatum"/>
              </xsl:element>
            </xsl:element>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="."/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

  <!-- algemeen -->

  <xsl:template match="element()">
    <xsl:element name="{name()}">
      <xsl:apply-templates select="@*|node()"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="@*">
    <xsl:copy-of select="."/>
  </xsl:template>

  <xsl:template match="text()">
    <xsl:copy-of select="."/>
  </xsl:template>

  <xsl:template match="comment()|processing-instruction()">
    <!-- wis comment en processing-instruction -->
  </xsl:template>

</xsl:stylesheet>