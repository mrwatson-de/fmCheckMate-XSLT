<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_SortScriptSteps.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied script-steps
	
	Sorts the script steps.
	
	===== CHANGES HISTORY =====
	2011-04-16 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="indent" select="//Step[1]/preceding-sibling::text()"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main templat-->
	<xsl:template match="/fmxmlsnippet">
		<xsl:copy>
			<xsl:attribute name="type">
				<xsl:value-of select="@type"/>
			</xsl:attribute>
			<xsl:for-each select="Step">
				<xsl:sort select="concat(@name,Comment,Name,Field/@table,Field/@name,Field/@repetition,Repetition)"/>
				<xsl:value-of select="$indent"/>
				<xsl:copy-of select="."/>
			</xsl:for-each>
			<xsl:value-of select="$RETURN"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
