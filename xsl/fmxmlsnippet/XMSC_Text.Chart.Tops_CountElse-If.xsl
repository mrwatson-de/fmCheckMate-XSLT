<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSC_Text.Chart.Tops_CountElse-If.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps

	Counts the number of Else+If steps in scripts

	===== CHANGES HISTORY =====
	2016-12-28 MrW: Version 1.0
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
		<xsl:for-each select="//Script[not(ancestor::Step)]">
			<xsl:sort select="count(Step[@id='69' and (following-sibling::Step)[1]/@id='68'])" order="descending" data-type="number"/>
			<!-- -->
			<xsl:value-of select="@name"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:value-of select="count(Step[@id='69' and (following-sibling::Step)[1]/@id='68'])"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
