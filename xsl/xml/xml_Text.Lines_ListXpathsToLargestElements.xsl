<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2026 @mrwatson-de

	===== PURPOSE =====

	XSL-File: xml_Text.Lines_ListXpathsToSelectElementsByAttributeValue.xsl

	XML-Source: any.xml
	XML-Grammar: any
	XML-Content: any
	
	Emits a list of Xpath expressions in descending order of content size.
	
	===== CHANGES HISTORY =====
	2026-01-19 MrW Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/">
		<report>
			<xsl:for-each select="//*[normalize-space()]">
				<xsl:sort select="string-length(normalize-space(.))" data-type="number" order="descending"/>
				<xsl:value-of select="string-length(normalize-space(.))"/>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="$delimiter"/>
				<xsl:for-each select="ancestor-or-self::*">
					<xsl:value-of select="concat(name(),'[',1+count(preceding-sibling::*[name() = name(current())]),']')"/>
					<xsl:if test="position() != last()">/</xsl:if>
				</xsl:for-each>
				<xsl:value-of select="$newrecord"/>
			</xsl:for-each>
		</report>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
