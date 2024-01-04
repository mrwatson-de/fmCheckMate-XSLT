<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_FixVariableNames.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied filemaker script or script step objects

	Fixes variable names, so that they work with MBS/fmSyntaxColorizer variable name checking.

	Spaces are replaced with underscores.
	
	Note: Only variables that are defined with the Set Variable script step are corrected!
	
		===== CHANGES HISTORY =====
	2014-11-12 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.Substitute.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:key name="Variables" match="//Step[@id='141' and contains(Name,' ')]" use="'each'"/>
	<xsl:variable name="VariableNameSubstitutions">
		<xsl:for-each select="key('Variables','each')">
			<xsl:sort select="string-length(Name)" order="descending" data-type="number"/>
			<!-- -->
			<xsl:value-of select="Name"/>
			<xsl:value-of select="'|'"/>
			<xsl:value-of select="translate(Name,' ','_')"/>
			<xsl:value-of select="'|'"/>
		</xsl:for-each>
	</xsl:variable>
	
	<!-- ===== TEMPLATES ===== -->
	<!-- Rename variable -->
	<xsl:template match="Step[@id='141']/Name/text()[contains(.,' ')]">
		<xsl:value-of select="translate(.,' ','_')"/>
	</xsl:template>
	<!-- Rename variable references -->
	<xsl:template match="Calculation/text()">
		<xsl:call-template name="fn.SubstituteMultiple">
			<xsl:with-param name="text" select="."/>
			<xsl:with-param name="substitutions" select="$VariableNameSubstitutions"/>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
