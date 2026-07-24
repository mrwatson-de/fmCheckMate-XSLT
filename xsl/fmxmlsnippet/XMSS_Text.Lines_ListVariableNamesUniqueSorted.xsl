<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSS_Text.Lines_ListVariableNamesUniqueSorted.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or scriptsteps
	
	Returns a unique, sorted list of names of all set variables.
	
	===== CHANGES HISTORY =====
	2026-07-08 @mrwatson-de: v1.1 Another 1/2 hour later: also find variables defined by being targetted **and** more efficient.
	2026-07-08 @mrwatson-de: v1.0 12 years later: unique and sorted
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== KEYS ===== -->
	<xsl:key name="variables" match="Step[@id='141' and @enable='True']/Name | Field[starts-with(., '$')]" use="."/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="variables" select="//Step[@id='141' and @enable='True']/Name | //Field[starts-with(., '$')]"/>
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main list 	all 141. Set Variable -->
	<xsl:template match="/">
		<xsl:for-each select="$variables[generate-id() = generate-id(key('variables', .)[1])]">
			<xsl:sort select="."/>
			<xsl:value-of select="."/>
			<xsl:value-of select="$newrecord"/>
		</xsl:for-each>
	</xsl:template>
	
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
	
</xsl:stylesheet>
