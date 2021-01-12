<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" version="1.0" indent="yes" encoding="utf-8"/>
  <xsl:strip-space elements="*"/>

  <xsl:param name="base.dir" select="string('file:/C:/Werkbestanden/Geonovum/mutatie')"/>
  <xsl:param name="mutaties" select="collection(concat($base.dir,'/input?select=*.xml'))/mutaties"/>

  <xsl:template match="root">
    <xsl:element name="xsl:stylesheet">
      <xsl:namespace name="xsl" select="string('http://www.w3.org/1999/XSL/Transform')"/>
      <xsl:attribute name="version" select="string('2.0')"/>
      <xsl:element name="xsl:output">
        <xsl:attribute name="method" select="string('text')"/>
        <xsl:attribute name="encoding" select="string('utf-8')"/>
      </xsl:element>
      <xsl:element name="xsl:strip-space">
        <xsl:attribute name="elements" select="string('*')"/>
      </xsl:element>
      <xsl:element name="xsl:import">
        <xsl:attribute name="href" select="string('import.xsl')"/>
      </xsl:element>
      <xsl:for-each select="$mutaties/mutatie[@xpath][@type]">
        <!-- attribuut xpath en type zijn verplicht -->
        <xsl:element name="xsl:template">
          <xsl:attribute name="match" select="@xpath"/>
          <xsl:attribute name="priority" select="count(.|./following-sibling::mutatie[@xpath][@type])"/>
          <xsl:element name="xsl:param">
            <xsl:attribute name="name" select="string('mode')"/>
          </xsl:element>
          <xsl:element name="xsl:call-template">
            <xsl:attribute name="name" select="string('doe_mutatie')"/>
            <xsl:element name="xsl:with-param">
              <xsl:attribute name="name" select="string('mode')"/>
              <xsl:attribute name="select" select="string('$mode')"/>
            </xsl:element>
            <xsl:element name="xsl:with-param">
              <xsl:attribute name="name" select="string('mutatie')"/>
              <xsl:copy-of select="./node()"/>
            </xsl:element>
            <xsl:element name="xsl:with-param">
              <xsl:attribute name="name" select="string('datum')"/>
              <xsl:value-of select="$mutaties/@datum"/>
            </xsl:element>
            <xsl:element name="xsl:with-param">
              <xsl:attribute name="name" select="string('type')"/>
              <xsl:value-of select="@type"/>
            </xsl:element>
          </xsl:element>
        </xsl:element>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>