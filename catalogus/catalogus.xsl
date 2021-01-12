<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" version="2.0">

  <xsl:character-map name="json">
    <xsl:output-character character="\" string="\\"/>
    <xsl:output-character character="&quot;" string="\&quot;"/>
  </xsl:character-map>

  <xsl:output method="xml" version="1.0" indent="yes" encoding="utf-8" use-character-maps="json"/>
  <xsl:strip-space elements="*"/>

  <xsl:param name="waardelijst.dir" select="string('file:/C:/Werkbestanden/Geonovum/catalogus/waardelijsten')"/>

  <!-- parameter waardelijsten bevat alle gepubliceerde waardelijsten op aflopende volgorde van publicatiedatum -->
  <xsl:param name="waardelijsten">
    <xsl:for-each select="collection(concat($waardelijst.dir,'?select=*.xml'))/waardelijsten">
      <xsl:sort select="xs:date(./publicatiedatum)"/>
      <xsl:element name="versie">
        <xsl:attribute name="index" select="position()"/>
        <xsl:attribute name="nummer" select="./versie"/>
        <xsl:attribute name="publicatie" select="./publicatiedatum"/>
        <xsl:sequence select="./waardelijst"/>
      </xsl:element>
    </xsl:for-each>
  </xsl:param>

  <xsl:template match="/">
    <xsl:element name="root">
      <xsl:call-template name="waardelijstasset"/>
      <xsl:call-template name="bibliographicresource"/>
      <xsl:call-template name="concept"/>
      <xsl:call-template name="conceptscheme"/>
    </xsl:element>
  </xsl:template>

  <!-- maak catalogus:WaardelijstAsset -->

  <xsl:template name="waardelijstasset">
    <!-- alle waardelijsten zijn catalogus:WaardelijstAsset -->
    <xsl:for-each select="$waardelijsten/versie/waardelijst">
      <xsl:variable name="index" select="./parent::versie/@index" as="xs:integer"/>
      <xsl:variable name="term" select="./term"/>
      <xsl:element name="element">
        <xsl:attribute name="type" select="string('catalogus:WaardelijstAsset')"/>
        <xsl:element name="uri">
          <xsl:value-of select="fn:string-join((./uri,$waardelijsten/versie[$index]/@nummer),'_')"/>
        </xsl:element>
        <xsl:element name="naam">
          <xsl:value-of select="./label"/>
        </xsl:element>
        <xsl:element name="titel">
          <xsl:value-of select="./term"/>
        </xsl:element>
        <xsl:element name="beschrijving">
          <xsl:value-of select="./omschrijving"/>
        </xsl:element>
        <xsl:element name="versie">
          <xsl:value-of select="$waardelijsten/versie[$index]/@nummer"/>
        </xsl:element>
        <xsl:element name="versienotities">
          <xsl:value-of select="fn:string-join(('Versie',$waardelijsten/versie[$index]/@nummer),' ')"/>
        </xsl:element>
        <xsl:element name="versieVan">
          <xsl:value-of select="./uri"/>
        </xsl:element>
        <xsl:if test="$waardelijsten/versie[$index - 1]/waardelijst[./term=$term]">
          <xsl:element name="vervangt">
            <xsl:value-of select="fn:string-join((./uri,$waardelijsten/versie[$index - 1]/@nummer),'_')"/>
          </xsl:element>
        </xsl:if>
        <xsl:element name="metadata">
          <xsl:variable name="startdatum">
            <!-- bepaal het eerste voorkomen -->
            <xsl:variable name="lijst">
              <xsl:for-each select=".//waarde/geldigheid/startdatum">
                <xsl:sort select="xs:date(.)"/>
                <xsl:element name="item">
                  <xsl:copy-of select="."/>
                </xsl:element>
              </xsl:for-each>
            </xsl:variable>
            <xsl:value-of select="$lijst/item[1]"/>
          </xsl:variable>
          <xsl:element name="uri">
            <xsl:value-of select="fn:string-join(('http:','','standaarden.omgevingswet.overheid.nl','doc',concat(replace($startdatum,'-',''),'000000'),'waardelijst',fn:string-join((./term,$waardelijsten/versie[$index]/@nummer),'_')),'/')"/>
          </xsl:element>
          <xsl:element name="startdatumGeldigheid">
            <xsl:value-of select="$startdatum"/>
          </xsl:element>
          <xsl:if test="$waardelijsten/versie[$index - 1]/waardelijst[./term=$term]">
            <xsl:element name="revisieVan">
              <xsl:value-of select="fn:string-join(('http:','','standaarden.omgevingswet.overheid.nl','doc',concat(replace($startdatum,'-',''),'000000'),'waardelijst',fn:string-join((./term,$waardelijsten/versie[$index - 1]/@nummer),'_')),'/')"/>
            </xsl:element>
          </xsl:if>
        </xsl:element>
        <xsl:element name="waardes">
          <xsl:for-each select=".//waarde">
            <xsl:element name="element">
              <xsl:element name="uri">
                <xsl:value-of select="./uri"/>
              </xsl:element>
              <xsl:element name="naam">
                <xsl:value-of select="./label"/>
              </xsl:element>
              <xsl:element name="term">
                <xsl:value-of select="./term"/>
              </xsl:element>
              <xsl:element name="definitie">
                <xsl:value-of select="./definitie"/>
              </xsl:element>
              <xsl:element name="uitleg">
                <xsl:value-of select="./toelichting"/>
              </xsl:element>
              <xsl:element name="isSpecialisatieVan">
                <xsl:value-of select="./specialisatie"/>
              </xsl:element>
              <xsl:if test="./bron">
                <xsl:element name="bronnen">
                  <xsl:element name="element">
                    <xsl:value-of select="./bron"/>
                  </xsl:element>
                </xsl:element>
              </xsl:if>
              <xsl:if test="./symboolcode ne ''">
                <xsl:element name="gerelateerd">
                  <xsl:element name="element">
                    <xsl:value-of select="fn:string-join(('http:','','standaarden.omgevingswet.overheid.nl','symboolcode','id','concept',./symboolcode),'/')"/>
                  </xsl:element>
                </xsl:element>
              </xsl:if>
              <xsl:element name="domein">
                <xsl:value-of select="./domein"/>
              </xsl:element>
              <xsl:element name="metadata">
                <xsl:variable name="startdatum" select="./geldigheid/startdatum"/>
                <xsl:variable name="uri" select="fn:tokenize(./uri,'/')"/>
                <xsl:element name="uri">
                  <xsl:value-of select="fn:string-join(('http:','','standaarden.omgevingswet.overheid.nl',$uri[4],'doc',concat(replace($startdatum,'-',''),'000000'),'concept',$uri[7]),'/')"/>
                </xsl:element>
                <xsl:element name="startdatumGeldigheid">
                  <xsl:value-of select="$startdatum"/>
                </xsl:element>
                <xsl:if test="./geldigheid/einddatum ne ''">
                  <xsl:element name="einddatumGeldigheid">
                    <xsl:value-of select="./geldigheid/einddatum"/>
                  </xsl:element>
                </xsl:if>
              </xsl:element>
            </xsl:element>
          </xsl:for-each>
        </xsl:element>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>

  <!-- maak dct:BibliographicResource -->

  <xsl:template name="bibliographicresource">
    <!-- alle bronnen zijn dct:BibliographicResource -->
    <xsl:for-each select="fn:distinct-values($waardelijsten//waarde[./bron ne '']/concat(./bron,'|',./geldigheid/startdatum))">
      <xsl:variable name="uri" select="fn:tokenize(.,'\|')[1]"/>
      <xsl:variable name="startdatum" select="fn:tokenize(.,'\|')[2]"/>
      <xsl:variable name="bron" select="($waardelijsten//waardelijst[//waarde[./bron=$uri][./geldigheid/startdatum=$startdatum]]//bron[./uri=$uri])[last()]"/>
      <xsl:element name="element">
        <xsl:attribute name="type" select="string('dct:BibliographicResource')"/>
        <xsl:element name="uri">
          <xsl:value-of select="$bron/uri"/>
        </xsl:element>
        <xsl:element name="titel">
          <xsl:value-of select="$bron/href"/>
        </xsl:element>
        <xsl:element name="metadata">
          <xsl:element name="uri">
            <xsl:value-of select="fn:string-join(('http:','','standaarden.omgevingswet.overheid.nl','doc',concat(replace($startdatum,'-',''),'000000'),'bron',$bron/term),'/')"/>
          </xsl:element>
          <xsl:element name="startdatumGeldigheid">
            <xsl:value-of select="$startdatum"/>
          </xsl:element>
        </xsl:element>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>

  <!-- maak skos:Concept -->

  <xsl:template name="concept">
    <!-- alle symboolcode zijn skos:Concept -->
    <xsl:for-each select="fn:distinct-values($waardelijsten//symboolcode[. ne ''])">
      <xsl:variable name="symboolcode" select="."/>
      <xsl:element name="element">
        <xsl:attribute name="type" select="string('skos:Concept')"/>
        <xsl:element name="uri">
          <xsl:value-of select="fn:string-join(('http:','','standaarden.omgevingswet.overheid.nl','symboolcode','id','concept',$symboolcode),'/')"/>
        </xsl:element>
        <xsl:element name="naam">
          <xsl:value-of select="$symboolcode"/>
        </xsl:element>
        <xsl:element name="term">
          <xsl:value-of select="$symboolcode"/>
        </xsl:element>
        <xsl:element name="definitie"/>
        <xsl:element name="domein">
          <xsl:value-of select="fn:string-join(('http:','','standaarden.omgevingswet.overheid.nl','id','conceptscheme','Symboolcode'),'/')"/>
        </xsl:element>
        <xsl:element name="metadata">
          <xsl:variable name="startdatum">
            <!-- bepaal het eerste voorkomen -->
            <xsl:variable name="lijst">
              <xsl:for-each select="$waardelijsten//waarde[./symboolcode=$symboolcode]/geldigheid/startdatum">
                <xsl:sort select="xs:date(.)"/>
                <xsl:element name="item">
                  <xsl:copy-of select="."/>
                </xsl:element>
              </xsl:for-each>
            </xsl:variable>
            <xsl:value-of select="$lijst/item[1]"/>
          </xsl:variable>
          <xsl:element name="uri">
            <xsl:value-of select="fn:string-join(('http:','','standaarden.omgevingswet.overheid.nl','symboolcode','doc',concat(replace($startdatum,'-',''),'000000'),'concept',$symboolcode),'/')"/>
          </xsl:element>
          <xsl:element name="startdatumGeldigheid">
            <xsl:value-of select="$startdatum"/>
          </xsl:element>
        </xsl:element>
      </xsl:element>
    </xsl:for-each>
    <!-- alle geversioneerde waarden zijn skos:Concept -->
    <xsl:for-each select="fn:distinct-values($waardelijsten//waarde/concat(./uri,'|',./geldigheid/startdatum))">
      <xsl:variable name="id" select="."/>
      <xsl:variable name="waarde" select="($waardelijsten//waarde[concat(./uri,'|',./geldigheid/startdatum)=$id])[last()]"/>
      <xsl:element name="element">
        <xsl:attribute name="type" select="string('skos:Concept')"/>
        <xsl:element name="uri">
          <xsl:value-of select="$waarde/uri"/>
        </xsl:element>
        <xsl:element name="naam">
          <xsl:value-of select="$waarde/label"/>
        </xsl:element>
        <xsl:element name="term">
          <xsl:value-of select="$waarde/term"/>
        </xsl:element>
        <xsl:element name="definitie">
          <xsl:value-of select="$waarde/definitie"/>
        </xsl:element>
        <xsl:element name="uitleg">
          <xsl:value-of select="$waarde/toelichting"/>
        </xsl:element>
        <xsl:element name="isSpecialisatieVan">
          <xsl:value-of select="$waarde/specialisatie"/>
        </xsl:element>
        <xsl:if test="$waarde/bron">
          <xsl:element name="bronnen">
            <xsl:element name="element">
              <xsl:value-of select="$waarde/bron"/>
            </xsl:element>
          </xsl:element>
        </xsl:if>
        <xsl:if test="$waarde/symboolcode ne ''">
          <xsl:element name="gerelateerd">
            <xsl:element name="element">
              <xsl:value-of select="fn:string-join(('http:','','standaarden.omgevingswet.overheid.nl','symboolcode','id','concept',$waarde/symboolcode),'/')"/>
            </xsl:element>
          </xsl:element>
        </xsl:if>
        <xsl:element name="domein">
          <xsl:value-of select="$waarde/domein"/>
        </xsl:element>
        <xsl:element name="metadata">
          <xsl:variable name="startdatum" select="$waarde/geldigheid/startdatum"/>
          <xsl:variable name="uri" select="fn:tokenize($waarde/uri,'/')"/>
          <xsl:element name="uri">
            <xsl:value-of select="fn:string-join(('http:','','standaarden.omgevingswet.overheid.nl',$uri[4],'doc',concat(replace($startdatum,'-',''),'000000'),'concept',$uri[7]),'/')"/>
          </xsl:element>
          <xsl:element name="startdatumGeldigheid">
            <xsl:value-of select="$startdatum"/>
          </xsl:element>
          <xsl:if test="$waarde/geldigheid/einddatum ne ''">
            <xsl:element name="einddatumGeldigheid">
              <xsl:value-of select="$waarde/geldigheid/einddatum"/>
            </xsl:element>
          </xsl:if>
        </xsl:element>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>

  <!-- maak skos:ConceptScheme -->

  <xsl:template name="conceptscheme">
    <!-- domein voor symboolcode -->
    <xsl:element name="element">
      <xsl:attribute name="type" select="string('skos:ConceptScheme')"/>
      <xsl:element name="uri">
        <xsl:value-of select="fn:string-join(('http:','','standaarden.omgevingswet.overheid.nl','id','conceptscheme','Symboolcode'),'/')"/>
      </xsl:element>
      <xsl:element name="naam">
        <xsl:value-of select="string('symboolcode')"/>
      </xsl:element>
      <xsl:element name="uitleg">
        <xsl:value-of select="string('Symboolcode')"/>
      </xsl:element>
      <xsl:element name="metadata">
        <xsl:variable name="startdatum">
          <!-- bepaal het eerste voorkomen -->
          <xsl:variable name="lijst">
            <xsl:for-each select="$waardelijsten//waarde/geldigheid/startdatum">
              <xsl:sort select="xs:date(.)"/>
              <xsl:element name="item">
                <xsl:copy-of select="."/>
              </xsl:element>
            </xsl:for-each>
          </xsl:variable>
          <xsl:value-of select="$lijst/item[1]"/>
        </xsl:variable>
        <xsl:element name="uri">
          <xsl:value-of select="fn:string-join(('http:','','standaarden.omgevingswet.overheid.nl','doc',concat(replace($startdatum,'-',''),'000000'),'conceptscheme','Symboolcode'),'/')"/>
        </xsl:element>
        <xsl:element name="startdatumGeldigheid">
          <xsl:value-of select="$startdatum"/>
        </xsl:element>
      </xsl:element>
    </xsl:element>
    <!-- alle geversioneerde domeinen zijn skos:ConceptScheme -->
    <xsl:for-each select="fn:distinct-values($waardelijsten//waarde[./domein ne '']/concat(./domein,'|',./geldigheid/startdatum))">
      <xsl:variable name="uri" select="fn:tokenize(.,'\|')[1]"/>
      <xsl:variable name="startdatum" select="fn:tokenize(.,'\|')[2]"/>
      <xsl:variable name="domein" select="($waardelijsten//waardelijst[//waarde[./domein=$uri][./geldigheid/startdatum=$startdatum]]//domein[./uri=$uri])[last()]"/>
      <xsl:element name="element">
        <xsl:attribute name="type" select="string('skos:ConceptScheme')"/>
        <xsl:element name="uri">
          <xsl:value-of select="$domein/uri"/>
        </xsl:element>
        <xsl:element name="naam">
          <xsl:value-of select="$domein/label"/>
        </xsl:element>
        <xsl:element name="uitleg">
          <xsl:value-of select="$domein/omschrijving"/>
        </xsl:element>
        <xsl:element name="metadata">
          <xsl:element name="uri">
            <xsl:value-of select="fn:string-join(('http:','','standaarden.omgevingswet.overheid.nl','doc',concat(replace($startdatum,'-',''),'000000'),'conceptscheme',$domein/term),'/')"/>
          </xsl:element>
          <xsl:element name="startdatumGeldigheid">
            <xsl:value-of select="$startdatum"/>
          </xsl:element>
        </xsl:element>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>