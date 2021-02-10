<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
   <xsl:output method="text" encoding="utf-8"/>
   <xsl:strip-space elements="*"/>
   <xsl:import href="import.xsl"/>
   <xsl:template match="versie">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <versie>1.0.8</versie>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-02-09</xsl:with-param>
         <xsl:with-param name="type">vervang</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="publicatiedatum">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <publicatiedatum>2021-02-09</publicatiedatum>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-02-09</xsl:with-param>
         <xsl:with-param name="type">vervang</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="//waardelijst[label='activiteitengroep']/waarden">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <waarde>
               <label>landinrichtingsactiviteit</label>
               <definitie>Waarde voor attribuut groep bij het object Activiteit voor het vastleggen van een gebied waar regels gelden over de landinrichtingsactiviteit: activiteit die gevolgen heeft of kan hebben voor de uitvoering van een inrichtingsprogramma als bedoeld in artikel 3.14a Ow.</definitie>
               <bron>http://standaarden.omgevingswet.overheid.nl/id/bron/Staatsblad2016156</bron>
               <symboolcode id="vag410">vag410</symboolcode>
            </waarde>
            <waarde>
               <label>toegangsactiviteit</label>
               <definitie>Waarde voor attribuut groep bij het object Activiteit voor het vastleggen van een gebied waar regels gelden over activiteiten waarvoor op grond van een toegangsbeperkingsbesluit in een Natura 2000-gebied een gehele of gedeeltelijke beperking of verbod geldt dan wel die van een beperking of verbod zijn uitgezonderd.</definitie>
               <symboolcode id="vag402">vag402</symboolcode>
            </waarde>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-02-09</xsl:with-param>
         <xsl:with-param name="type">voegtoe</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="//waardelijst[label='eenheid']/waarden">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <waarde>
               <label>nog toe te voegen</label>
               <definitie>Waarde voor attribuut eenheid voor de gegevensgroep Normwaarde bij de objecten Omgevingswaarde en Omgevingsnorm die gebruikt kan worden wanneer een bevoegd gezag een eigen waarde wil gebruiken.</definitie>
               <toelichting>Deze waarde is toegevoegd om, zolang de DSO-systemen nog niet met uitbreidbare waardelijsten kunnen omgaan, duidelijk te kunnen maken dat het de bedoeling is een eigen waarde te gebruiken. (NB: Het bevoegd gezag kan een mail sturen aan omgevingswet@geonovum.nl met het verzoek om de betreffende waarde aan de waardelijst toe te voegen).</toelichting>
            </waarde>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-02-09</xsl:with-param>
         <xsl:with-param name="type">voegtoe</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="//waardelijst[label='type norm']/waarden">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <waarde>
               <label>nog toe te voegen</label>
               <definitie>Waarde voor attribuut type bij de objecten Omgevingsnorm en Omgevingswaarde die gebruikt kan worden wanneer een bevoegd gezag een eigen waarde wil gebruiken.</definitie>
               <toelichting>Deze waarde is toegevoegd om, zolang de DSO-systemen nog niet met uitbreidbare waardelijsten kunnen omgaan, duidelijk te kunnen maken dat het de bedoeling is een eigen waarde te gebruiken. (NB: Het bevoegd gezag kan een mail sturen aan omgevingswet@geonovum.nl met het verzoek om de betreffende waarde aan de waardelijst toe te voegen).</toelichting>
            </waarde>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-02-09</xsl:with-param>
         <xsl:with-param name="type">voegtoe</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="//waardelijst[label='natuurgroep']/waarden">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <waarde>
               <label>habitatrichtlijngebied</label>
               <definitie>Waarde voor attribuut groep bij het Gebiedsaanwijzingtype Natuur voor het aanwijzen van een gebied als Natura 2000-gebied ter uitvoering van de habitatrichtlijn.</definitie>
               <bron>http://standaarden.omgevingswet.overheid.nl/id/bron/Staatsblad2016156</bron>
               <symboolcode id="vgst114">vgst114</symboolcode>
            </waarde>
            <waarde>
               <label>vogelrichtlijngebied</label>
               <definitie>Waarde voor attribuut groep bij het Gebiedsaanwijzingtype Natuur voor het aanwijzen van een gebied als Natura 2000-gebied ter uitvoering van de vogelrichtlijn.</definitie>
               <bron>http://standaarden.omgevingswet.overheid.nl/id/bron/Staatsblad2016156</bron>
               <symboolcode id="vgst123">vgst123</symboolcode>
            </waarde>
            <waarde>
               <label>toegangsbeperkingsgebied</label>
               <definitie>Waarde voor attribuut groep bij het Gebiedsaanwijzingtype Natuur voor het bij toegangsbeperkingsbesluit aanwijzen van een gebied waar regels gelden over de beperking of het verbod van de toegang tot een Natura 2000-gebied.</definitie>
               <bron>http://standaarden.omgevingswet.overheid.nl/id/bron/Staatsblad2016156</bron>
               <symboolcode id="vgst002">vgst002</symboolcode>
            </waarde>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-02-09</xsl:with-param>
         <xsl:with-param name="type">voegtoe</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="//waardelijst[term='Thema']/waarden/waarde[term='CultureelErfgoed']/definitie">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <definitie>Kenmerk dat aangeeft dat de regels of het beleid gericht zijn op bescherming van cultureel erfgoed.</definitie>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-02-09</xsl:with-param>
         <xsl:with-param name="type">vervang</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="//waardelijst[term='Thema']/waarden/waarde[term='ExterneVeiligheid']/definitie">
      <xsl:param name="mode"/>
      <xsl:call-template name="doe_mutatie">
         <xsl:with-param name="mode" select="$mode"/>
         <xsl:with-param name="mutatie">
            <definitie>Kenmerk dat aangeeft dat de regels of het beleid gericht zijn op het waarborgen van  de externe veiligheid.</definitie>
         </xsl:with-param>
         <xsl:with-param name="datum">2021-02-09</xsl:with-param>
         <xsl:with-param name="type">vervang</xsl:with-param>
      </xsl:call-template>
   </xsl:template>
</xsl:stylesheet>
