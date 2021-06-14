<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
   <xsl:output method="text" encoding="utf-8"/>
   <xsl:strip-space elements="*"/>
   <xsl:import href="import.xsl"/>
   <xsl:template match="waardelijsten/versie">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <versie>2.0.0-rc</versie>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-06-15</xsl:with-param>
         <xsl:with-param name="type">vervang</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="waardelijsten/publicatiedatum">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <publicatiedatum>2021-06-15</publicatiedatum>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-06-15</xsl:with-param>
         <xsl:with-param name="type">vervang</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="waardelijsten/waardelijst[uri='http://standaarden.omgevingswet.overheid.nl/id/waardelijst/Natuurgroep']/waarden/waarde[uri='http://standaarden.omgevingswet.overheid.nl/natuur/id/concept/Habitatrichtlijngebied']/symboolcode">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <symboolcode id="vsgt114">vsgt114</symboolcode>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-06-15</xsl:with-param>
         <xsl:with-param name="type">vervang</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="waardelijsten/waardelijst[uri='http://standaarden.omgevingswet.overheid.nl/id/waardelijst/Natuurgroep']/waarden/waarde[uri='http://standaarden.omgevingswet.overheid.nl/natuur/id/concept/Toegangsbeperkingsgebied']/symboolcode">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <symboolcode id="vsgt002">vsgt002</symboolcode>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-06-15</xsl:with-param>
         <xsl:with-param name="type">vervang</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="waardelijsten/waardelijst[uri='http://standaarden.omgevingswet.overheid.nl/id/waardelijst/Natuurgroep']/waarden/waarde[uri='http://standaarden.omgevingswet.overheid.nl/natuur/id/concept/Vogelrichtlijngebied']/symboolcode">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <symboolcode id="vsgt123">vsgt123</symboolcode>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-06-15</xsl:with-param>
         <xsl:with-param name="type">vervang</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="waardelijsten/waardelijst[uri='http://standaarden.omgevingswet.overheid.nl/id/waardelijst/Omgevingsnormgroep']/waarden">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <waarde>
               <label>maatvoering gebruik</label>
               <definitie>Waarde voor attribuut groep bij het object Omgevingsnorm voor het vaststellen, geometrisch begrenzen en per locatie waarden vastleggen van een omgevingsnorm voor de maatvoering van (planologisch) gebruik.</definitie>
               <symboolcode id="vog014">vog014</symboolcode>
            </waarde>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-06-15</xsl:with-param>
         <xsl:with-param name="type">voegtoe</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="waardelijsten/waardelijst[uri='http://standaarden.omgevingswet.overheid.nl/id/waardelijst/Thema']/type">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <type>limitatief</type>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-06-15</xsl:with-param>
         <xsl:with-param name="type">vervang</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="waardelijsten/waardelijst[uri='http://standaarden.omgevingswet.overheid.nl/id/waardelijst/Thema']/waarden/waarde[toelichting='Deze waarde niet gebruiken.']">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie"/>
         <xsl:with-param name="datum">2021-06-15</xsl:with-param>
         <xsl:with-param name="type">verwijder</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="waardelijsten/waardelijst[uri='http://standaarden.omgevingswet.overheid.nl/id/waardelijst/Thema']/waarden/waarde[geldigheid/startdatum='2021-06-10']">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie"/>
         <xsl:with-param name="datum">2021-06-15</xsl:with-param>
         <xsl:with-param name="type">verwijder</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="waardelijsten/waardelijst[uri='http://standaarden.omgevingswet.overheid.nl/id/waardelijst/Thema']/waarden/waarde[toelichting='Deze waarde kan gebruikt worden.']/toelichting">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <toelichting/>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-06-15</xsl:with-param>
         <xsl:with-param name="type">vervang</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="waardelijsten/waardelijst[uri='http://standaarden.omgevingswet.overheid.nl/id/waardelijst/Thema']/waarden/waarde[toelichting='Deze waarde kan gebruikt worden.']/domein">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <domein>http://standaarden.omgevingswet.overheid.nl/id/conceptscheme/Thema</domein>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-06-15</xsl:with-param>
         <xsl:with-param name="type">vervang</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="waardelijsten/waardelijst[uri='http://standaarden.omgevingswet.overheid.nl/id/waardelijst/Thema']/waarden/waarde[uri='http://standaarden.omgevingswet.overheid.nl/gezondheid/id/concept/Gezondheid']/definitie">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <definitie>Kenmerk dat aangeeft dat de regels of het beleid gericht zijn op het waarborgen van de gezondheidsaspecten van de leefomgeving.</definitie>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-06-15</xsl:with-param>
         <xsl:with-param name="type">vervang</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="waardelijsten/waardelijst[uri='http://standaarden.omgevingswet.overheid.nl/id/waardelijst/Thema']/domeinen/domein">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie"/>
         <xsl:with-param name="datum">2021-06-15</xsl:with-param>
         <xsl:with-param name="type">verwijder</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="waardelijsten/waardelijst[uri='http://standaarden.omgevingswet.overheid.nl/id/waardelijst/Thema']/domeinen">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <domein>
               <label>thema</label>
               <term>Thema</term>
               <uri>http://standaarden.omgevingswet.overheid.nl/id/conceptscheme/Thema</uri>
               <omschrijving>De aanduiding van het aspect van de fysieke leefomgeving waar de regel of de beleidstekst over gaat.</omschrijving>
            </domein>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-06-15</xsl:with-param>
         <xsl:with-param name="type">voegtoe</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="waardelijsten/waardelijst[uri='http://standaarden.omgevingswet.overheid.nl/id/waardelijst/Thema']//bron[uri='http://standaarden.omgevingswet.overheid.nl/id/bibliographicresource/Staatsblad2018290']">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie"/>
         <xsl:with-param name="datum">2021-06-15</xsl:with-param>
         <xsl:with-param name="type">verwijder</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="waardelijsten/waardelijst[uri='http://standaarden.omgevingswet.overheid.nl/id/waardelijst/Thema']//bron[uri='http://standaarden.omgevingswet.overheid.nl/id/bibliographicresource/Staatsblad2018291']">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie"/>
         <xsl:with-param name="datum">2021-06-15</xsl:with-param>
         <xsl:with-param name="type">verwijder</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="waardelijsten/waardelijst[uri='http://standaarden.omgevingswet.overheid.nl/id/waardelijst/Eenheid']//domein[uri='http://standaarden.omgevingswet.overheid.nl/id/conceptscheme/Eenheid']/omschrijving">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <omschrijving>Begrippen die eenheden aanduiden waarin een kwantitatieve waarde wordt uitgedrukt.</omschrijving>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-06-15</xsl:with-param>
         <xsl:with-param name="type">vervang</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="waardelijsten/waardelijst[uri='http://standaarden.omgevingswet.overheid.nl/id/waardelijst/Functiegroep']//domein[uri='http://standaarden.omgevingswet.overheid.nl/id/conceptscheme/Functie']/omschrijving">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <omschrijving>Begrippen gerelateerd aan de toedeling van functies aan locaties.</omschrijving>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-06-15</xsl:with-param>
         <xsl:with-param name="type">vervang</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="waardelijsten/waardelijst[uri='http://standaarden.omgevingswet.overheid.nl/id/waardelijst/Landschapgroep']//domein[uri='http://standaarden.omgevingswet.overheid.nl/id/conceptscheme/Landschap']/omschrijving">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <omschrijving>Begrippen gerelateerd aan het inhoudelijke (thematische/sectorale) domein van landschap.</omschrijving>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-06-15</xsl:with-param>
         <xsl:with-param name="type">vervang</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="waardelijsten/waardelijst[uri='http://standaarden.omgevingswet.overheid.nl/id/waardelijst/Luchtgroep']//domein[uri='http://standaarden.omgevingswet.overheid.nl/id/conceptscheme/Lucht']/omschrijving">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <omschrijving>Begrippen gerelateerd aan het inhoudelijke (thematische/sectorale) domein van lucht.</omschrijving>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-06-15</xsl:with-param>
         <xsl:with-param name="type">vervang</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="waardelijsten/waardelijst[uri='http://standaarden.omgevingswet.overheid.nl/id/waardelijst/Omgevingsnormgroep']//domein[uri='http://standaarden.omgevingswet.overheid.nl/id/conceptscheme/Omgevingsnorm']/omschrijving">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <omschrijving>Begrippen die een kwalitatieve of kwantitatieve normering voor aspecten van de fysieke leefomgeving aanduiden, die geen omgevingswaarde is.</omschrijving>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-06-15</xsl:with-param>
         <xsl:with-param name="type">vervang</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="waardelijsten/waardelijst[uri='http://standaarden.omgevingswet.overheid.nl/id/waardelijst/Omgevingswaardegroep']//domein[uri='http://standaarden.omgevingswet.overheid.nl/id/conceptscheme/Omgevingswaarde']/omschrijving">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <omschrijving>Begrippen die een kwalitatieve of kwantitatieve normering van omgevingswaarden aanduiden.</omschrijving>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-06-15</xsl:with-param>
         <xsl:with-param name="type">vervang</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="waardelijsten/waardelijst[uri='http://standaarden.omgevingswet.overheid.nl/id/waardelijst/Activiteitregelkwalificatie']//domein[uri='http://standaarden.omgevingswet.overheid.nl/id/conceptscheme/Activiteitregelkwalificatie']/omschrijving">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <omschrijving>Begrippen die een kwalificatie geven van regels over activiteiten.</omschrijving>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-06-15</xsl:with-param>
         <xsl:with-param name="type">vervang</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="waardelijsten/waardelijst[uri='http://standaarden.omgevingswet.overheid.nl/id/waardelijst/Adressaat']//domein[uri='http://standaarden.omgevingswet.overheid.nl/id/conceptscheme/Adressaat']/omschrijving">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <omschrijving>Begrippen die het type bestuurslaag of organisatie aanduiden.</omschrijving>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-06-15</xsl:with-param>
         <xsl:with-param name="type">vervang</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="waardelijsten/waardelijst[uri='http://standaarden.omgevingswet.overheid.nl/id/waardelijst/Beperkingengebiedgroep']//domein[uri='http://standaarden.omgevingswet.overheid.nl/id/conceptscheme/Beperkingengebied']/omschrijving">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <omschrijving>Begrippen gerelateerd aan het inhoudelijke (thematische/sectorale) domein van beperkingengebieden.</omschrijving>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-06-15</xsl:with-param>
         <xsl:with-param name="type">vervang</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
</xsl:stylesheet>
