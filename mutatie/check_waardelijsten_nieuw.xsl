<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:my="http://www.eigen.nl">
  <xsl:output method="xml" version="1.0" indent="yes" encoding="utf-8"/>
  <xsl:strip-space elements="*"/>

  <!-- deze xslt bouwt de waardelijsten opnieuw op zodat de integriteit van de bestanden gegarandeerd is -->

  <xsl:template match="/">
    <xsl:apply-templates select="waardelijsten"/>
  </xsl:template>

  <xsl:template match='waardelijsten'>
    <xsl:element name="{name()}">
      <xsl:apply-templates select="@*"/>
      <xsl:element name="versie">
        <xsl:apply-templates select="(./versie[1]/node(),'onbekend')[1]"/>
      </xsl:element>
      <xsl:element name="publicatiedatum">
        <xsl:apply-templates select="(./publicatiedatum[1]/node(),'onbekend')[1]"/>
      </xsl:element>
      <xsl:for-each select="waardelijst">
        <xsl:sort select="(./label[1],'onbekend')[1]"/>
        <xsl:apply-templates select="."/>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

  <xsl:template match='waardelijst'>
    <xsl:variable name="startdatum" select="fn:distinct-values(preceding-sibling::node()[1][self::processing-instruction()]|descendant::processing-instruction())"/>
    <xsl:choose>
      <xsl:when test="$startdatum castable as xs:date">
        <xsl:variable name="label" select="lower-case((./label[1]/node(),'onbekend')[1])"/>
        <xsl:variable name="term" select="my:check_string($label)"/>
        <xsl:variable name="uri" select="fn:string-join(('http:','','standaarden.omgevingswet.overheid.nl','id','waardelijst',$term),'/')"/>
        <xsl:element name="{name()}">
          <xsl:element name="label">
            <xsl:apply-templates select="$label"/>
          </xsl:element>
          <xsl:element name="term">
            <xsl:apply-templates select="$term"/>
          </xsl:element>
          <xsl:element name="uri">
            <xsl:apply-templates select="$uri"/>
          </xsl:element>
          <xsl:element name="type">
            <xsl:apply-templates select="(./type[1]/node(),'onbekend')[1]"/>
          </xsl:element>
          <xsl:element name="omschrijving">
            <xsl:apply-templates select="(./omschrijving[1]/node(),'')[1]"/>
          </xsl:element>
          <xsl:element name="toelichting">
            <xsl:apply-templates select="(./toelichting[1]/node(),'')[1]"/>
          </xsl:element>
          <xsl:element name="waarden">
            <!-- bij de nieuwe opzet van thema kan dit veel eenvoudiger -->
            <xsl:for-each-group select="./waarden/waarde" group-by="if (contains((./label[1]/node(),'onbekend')[1],'_')) then my:check_string(fn:tokenize(lower-case(./label[1]/node()),'_')[1]) else string(fn:tokenize(specialisatie,'/')[last()])">
              <xsl:sort select="current-grouping-key()"/>
              <xsl:for-each select="current-group()">
                <xsl:sort select="lower-case((./label[1],'onbekend')[1])"/>
                <xsl:apply-templates select=".">
                  <xsl:with-param name="specialisatie" select="current-grouping-key()"/>
                </xsl:apply-templates>
              </xsl:for-each>
            </xsl:for-each-group>
          </xsl:element>
          <xsl:element name="domeinen">
            <xsl:for-each select="./domeinen/domein">
              <xsl:sort select="lower-case((./label[1],'onbekend')[1])"/>
              <xsl:apply-templates select="."/>
            </xsl:for-each>
          </xsl:element>
          <xsl:if test="./bronnen">
            <xsl:element name="bronnen">
              <xsl:for-each select="./bronnen/bron">
                <xsl:sort select="(./titel[1],'Onbekend')[1]"/>
                <xsl:apply-templates select="."/>
              </xsl:for-each>
            </xsl:element>
          </xsl:if>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="waarde">
    <xsl:param name="specialisatie"/>
    <xsl:variable name="id_bron" select="bron/text()"/>
    <xsl:variable name="id_domein" select="domein/text()"/>
    <xsl:variable name="test_bron" select="ancestor::waardelijst/bronnen/bron[./uri=$id_bron]/(preceding-sibling::node()[1][self::processing-instruction()]|descendant::processing-instruction())"/>
    <xsl:variable name="test_domein" select="ancestor::waardelijst/domeinen/domein[./uri=$id_domein]/(preceding-sibling::node()[1][self::processing-instruction()]|descendant::processing-instruction())"/>
    <xsl:variable name="test_waarde" select="preceding-sibling::node()[1][self::processing-instruction()]|descendant::processing-instruction()"/>
    <xsl:variable name="startdatum" select="fn:distinct-values(($test_bron,$test_domein,$test_waarde))"/>
    <xsl:choose>
      <xsl:when test="$startdatum castable as xs:date">
        <xsl:element name="{name()}">
          <xsl:variable name="label" select="lower-case((fn:tokenize(./label[1]/node(),'_')[last()],'onbekend')[1])"/>
          <xsl:variable name="term" select="concat($specialisatie,my:check_string($label))"/>
          <xsl:variable name="domein">
            <xsl:choose>
              <xsl:when test="$specialisatie ne ''">
                <xsl:value-of select="$specialisatie"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="fn:tokenize((ancestor::waardelijst/term[1],'Onbekend')[1],'engroep|groep')[1]"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="uri" select="fn:string-join(('http:','','standaarden.omgevingswet.overheid.nl',lower-case($domein),'id','concept',$term),'/')"/>
          <xsl:element name="label">
            <xsl:apply-templates select="$label"/>
          </xsl:element>
          <xsl:element name="term">
            <xsl:apply-templates select="$term"/>
          </xsl:element>
          <xsl:element name="uri">
            <xsl:apply-templates select="$uri"/>
          </xsl:element>
          <xsl:element name="definitie">
            <xsl:apply-templates select="(./definitie[1]/node(),'')[1]"/>
          </xsl:element>
          <xsl:element name="toelichting">
            <xsl:apply-templates select="(./toelichting[1]/node(),'')[1]"/>
          </xsl:element>
          <xsl:element name="bron">
            <xsl:apply-templates select="(./bron[1]/node(),'')[1]"/>
          </xsl:element>
          <xsl:element name="domein">
            <xsl:apply-templates select="fn:string-join(('http:','','standaarden.omgevingswet.overheid.nl','id','conceptscheme',$domein),'/')"/>
          </xsl:element>
          <xsl:element name="specialisatie">
            <xsl:if test="$specialisatie ne ''">
              <xsl:value-of select="fn:string-join(('http:','','standaarden.omgevingswet.overheid.nl',lower-case($domein),'id','concept',$domein),'/')"/>
            </xsl:if>
          </xsl:element>
          <xsl:element name="symboolcode">
            <xsl:attribute name="id" select="(./symboolcode[1]/node(),'')[1]"/>
            <xsl:apply-templates select="(./symboolcode[1]/node(),'')[1]"/>
          </xsl:element>
          <xsl:element name="geldigheid">
            <xsl:element name="startdatum">
              <xsl:value-of select="$startdatum"/>
            </xsl:element>
            <xsl:element name="einddatum"/>
          </xsl:element>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="domeinen/domein">
    <xsl:variable name="startdatum" select="fn:distinct-values(preceding-sibling::node()[1][self::processing-instruction()]|descendant::processing-instruction())"/>
    <xsl:choose>
      <xsl:when test="$startdatum castable as xs:date">
        <xsl:element name="{name()}">
          <xsl:variable name="label" select="lower-case((./label[1]/node(),'onbekend')[1])"/>
          <xsl:variable name="term" select="my:check_string($label)"/>
          <xsl:variable name="uri" select="fn:string-join(('http:','','standaarden.omgevingswet.overheid.nl','id','conceptscheme',$term),'/')"/>
          <xsl:element name="label">
            <xsl:apply-templates select="$label"/>
          </xsl:element>
          <xsl:element name="term">
            <xsl:apply-templates select="$term"/>
          </xsl:element>
          <xsl:element name="uri">
            <xsl:apply-templates select="$uri"/>
          </xsl:element>
          <xsl:element name="omschrijving">
            <xsl:apply-templates select="(./omschrijving[1]/node(),'')[1]"/>
          </xsl:element>
          <xsl:element name="toelichting">
            <xsl:apply-templates select="(./toelichting[1]/node(),'')[1]"/>
          </xsl:element>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="bronnen/bron">
    <xsl:variable name="startdatum" select="fn:distinct-values(preceding-sibling::node()[1][self::processing-instruction()]|descendant::processing-instruction())"/>
    <xsl:choose>
      <xsl:when test="$startdatum castable as xs:date">
        <xsl:element name="{name()}">
          <xsl:variable name="titel" select="(./titel[1]/node(),'Onbekend')[1]"/>
          <xsl:variable name="term" select="my:check_string(lower-case($titel))"/>
          <xsl:variable name="uri" select="fn:string-join(('http:','','standaarden.omgevingswet.overheid.nl','id','bibliographicresource',$term),'/')"/>
          <xsl:element name="titel">
            <xsl:apply-templates select="$titel"/>
          </xsl:element>
          <xsl:element name="term">
            <xsl:apply-templates select="$term"/>
          </xsl:element>
          <xsl:element name="uri">
            <xsl:apply-templates select="$uri"/>
          </xsl:element>
          <xsl:element name="omschrijving">
            <xsl:apply-templates select="(./omschrijving[1]/node(),'')[1]"/>
          </xsl:element>
          <xsl:element name="href">
            <xsl:apply-templates select="(./href[1]/node(),'')[1]"/>
          </xsl:element>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
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

  <!-- routines -->

  <xsl:function name="my:check_string">
    <xsl:param name="string"/>
    <xsl:variable name="result">
      <xsl:for-each select="tokenize(translate(lower-case($string),' ''.-_()','       '),'\s+')">
        <xsl:variable name="codepoints" select="fn:string-to-codepoints(concat(upper-case(substring(.,1,1)),substring(.,2)))"/>
        <xsl:variable name="check_string">
          <xsl:for-each select="$codepoints">
            <xsl:choose>
              <xsl:when test="(. ge 48) and (. le 57)">
                <!-- cijfers -->
                <node><xsl:value-of select="."/></node>
              </xsl:when>
              <xsl:when test="((. ge 65) and (. le 90)) or ((. ge 97) and (. le 122))">
                <!-- letters -->
                <node><xsl:value-of select="."/></node>
              </xsl:when>
              <xsl:when test="(. ge 224) and (. le 230)">
                <!-- a -->
                <node><xsl:value-of select="97"/></node>
              </xsl:when>
              <xsl:when test="(. eq 231)">
                <!-- c -->
                <node><xsl:value-of select="99"/></node>
              </xsl:when>
              <xsl:when test="(. ge 232) and (. le 235)">
                <!-- e -->
                <node><xsl:value-of select="101"/></node>
              </xsl:when>
              <xsl:when test="(. ge 236) and (. le 239)">
                <!-- i -->
                <node><xsl:value-of select="105"/></node>
              </xsl:when>
              <xsl:when test="(. eq 241)">
                <!-- n -->
                <node><xsl:value-of select="110"/></node>
              </xsl:when>
              <xsl:when test="(. ge 242) and (. le 246)">
                <!-- o -->
                <node><xsl:value-of select="111"/></node>
              </xsl:when>
              <xsl:when test="(. ge 249) and (. le 252)">
                <!-- u -->
                <node><xsl:value-of select="117"/></node>
              </xsl:when>
              <xsl:when test="(. eq 253) or (. eq 255)">
                <!-- y -->
                <node><xsl:value-of select="121"/></node>
              </xsl:when>
              <xsl:when test="(. ge 192) and (. le 198)">
                <!-- A -->
                <node><xsl:value-of select="65"/></node>
              </xsl:when>
              <xsl:when test="(. eq 199)">
                <!-- C -->
                <node><xsl:value-of select="67"/></node>
              </xsl:when>
              <xsl:when test="(. ge 200) and (. le 203)">
                <!-- E -->
                <node><xsl:value-of select="69"/></node>
              </xsl:when>
              <xsl:when test="(. ge 204) and (. le 207)">
                <!-- I -->
                <node><xsl:value-of select="73"/></node>
              </xsl:when>
              <xsl:when test="(. eq 209)">
                <!-- N -->
                <node><xsl:value-of select="78"/></node>
              </xsl:when>
              <xsl:when test="(. ge 210) and (. le 214)">
                <!-- O -->
                <node><xsl:value-of select="79"/></node>
              </xsl:when>
              <xsl:when test="(.ge 217) and (. le 220)">
                <!-- U -->
                <node><xsl:value-of select="85"/></node>
              </xsl:when>
              <xsl:when test="(. eq 221)">
                <!-- Y -->
                <node><xsl:value-of select="89"/></node>
              </xsl:when>
              <xsl:otherwise>
                <node><xsl:value-of select="95"/></node>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="fn:codepoints-to-string($check_string/node[(. ne '95') or following::node[. ne '95']])"/>
      </xsl:for-each>
    </xsl:variable>
    <xsl:value-of select="$result"/>
  </xsl:function>

</xsl:stylesheet>