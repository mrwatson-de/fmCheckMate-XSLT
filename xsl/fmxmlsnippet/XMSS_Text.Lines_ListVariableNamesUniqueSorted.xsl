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
	2026-07-08 @mrwatson-de: 12 years later
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== KEYS ===== -->
	<xsl:key name="variables" match="Step[@id='141' and @enable='True']" use="Name"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main list 	all 141. Set Variable -->
	<xsl:template match="/">
		<xsl:for-each select="//Step[@id='141' and @enable='True'][generate-id() = generate-id(key('variables', Name)[1])]">
			<xsl:sort select="Name"/>
			<xsl:value-of select="Name"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:for-each>
	</xsl:template>
	
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
	
</xsl:stylesheet>
