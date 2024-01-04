<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSC_Text.Lines_ListScriptsWithBadVariableNames.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied filemaker scripts

	Lists all scripts containing variables with spaces in their name.

	Note: Only variables that are defined with the Set Variable script step are corrected!
	
		===== CHANGES HISTORY =====
	2014-11-12 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== PARAMS ===== -->
	<xsl:param name="pSearchText"/>
	<!--xsl:variable name="pSearchText" select="'2013-06-26 RW: '"/-->
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- List all Scripts containing bad variable names  -->
	<xsl:template match="/">
			<xsl:for-each select="//Script/Step[@id='141' and contains(Name,' ')]">
				<xsl:value-of select="../@name"/>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="Name"/>
				<xsl:value-of select="$newrecord"/>
			</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
