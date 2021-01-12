<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
   <xsl:output method="text" encoding="utf-8"/>
   <xsl:strip-space elements="*"/>
   <xsl:import href="import.xsl"/>
   <xsl:template match="versie" priority="3">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <versie>1.1.2</versie>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-03-01</xsl:with-param>
         <xsl:with-param name="type">vervang</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="publicatiedatum" priority="2">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <publicatiedatum>2021-03-01</publicatiedatum>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-03-01</xsl:with-param>
         <xsl:with-param name="type">vervang</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="//waarde[label='aansluitactiviteit']/definitie" priority="1">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <definitie>[nieuwste definitie]</definitie>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-03-01</xsl:with-param>
         <xsl:with-param name="type">vervang</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
</xsl:stylesheet>
