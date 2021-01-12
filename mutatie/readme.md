# Readme
De mutatie is opgebouwd uit verschillende handelingen:
1. Stel de mutaties samen in mutatie.xml. Dit bestand legt mutaties vast met behulp van een xpath-expressie, een type-aanduiding (wijzig, voegtoe, verwijder) en de aanpassingen in de geselecteerde elementen.
2. Bestand maak_mutatie.xsl converteert bestand mutatie.xml naar doe_mutatie.xsl waarmee de mutaties doorgevoerd kunnen worden in waardelijsten.xml. Bestand doe_mutatie.xsl bestaat uit een flexibel (gegenereerd) deel en een vast deel import.xml.
3. Bestand doe_mutatie.xsl voert twee stappen uit op de geselecteerde elementen:<br/>stap_0.xml: in de bestaande versie worden gemuteerde elementen gemarkeerd met processing-instruction \<?[type] [publicatiedatum]?\>.<br/>stap_1.xml: in een nieuwe versie worden de wijzigingen op de elementen daadwerkelijk uitgevoerd. Gemuteerde elementen worden gemarkeerd met processing-instruction \<?[type] [publicatiedatum]?\>.
4. Bestand stap_0.xml wordt omgezet naar een aangepaste bestaande versie van waardelijsten.xml. De enige aanpassing is, dat de geldigheid/einddatum op publicatiedatum wordt gezet.
5. Bestand stap_1.xml wordt omgezet naar de nieuwe versie van waardelijsten.xml. In stap_1.xml zijn de wijzigingen op de afzonderlijke elementen doorgevoerd. De element-overstijgende handelingen worden doorgevoerd om de integriteit van de bestanden te waarborgen. Wat houdt dit in?
   - Waardelijsten, waarden en domeinen worden gesorteerd op veld label. Eventueel worden dubbele waarden, domeinen samengevoegd.
   - Velden term en titel worden gegenereerd op basis van veld label.
   - Veld uri wordt gegenereerd op basis van domein, term en titel.
   - Van gemuteerde elementen wordt de geldigheid/startdatum van de waarde of het domein op de publicatiedatum gezet.

Het resultaat zijn twee bestanden 'waardelijsten [bestaande versie].xml' en 'waardelijsten [nieuwe versie].xml'. Deze bestanden worden geëxporteerd naar het json-formaat dat 'geharvest' kan worden door de stelselcatalogus. Op deze manier hebben we continu twee versies beschikbaar, maar meer versie is uiteraard mogelijk. Optioneel is het handig om een log-bestand te maken met de wijzigingen.
