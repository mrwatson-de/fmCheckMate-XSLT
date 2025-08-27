<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMFN_XMFN_SortFuctionsByName.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied custom functions
	
	Sort the Custom Functions into creation order whilst ignoring folders
	
	===== CHANGES HISTORY =====
	2025-08-15 @mrwatson-de: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== PARAMS ===== -->
	<!-- ===== TEMPLATES ===== -->
	<!-- Sort custom functions into creation order  -->
	<xsl:template match="/">
		<xsl:for-each select="//CustomFunction">
			<xsl:sort select="@name"/>
			<xsl:copy-of select="."/>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
