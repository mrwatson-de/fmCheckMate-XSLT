<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" version="1.0" exclude-result-prefixes="exsl">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMTH_Text.xml_ThemeWithMarkedUpCSS.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: one or more FileMaker Themes
	
	Outputs the Theme tag and the marked up CSS of the FileMaker Theme - for debugging / transformation tests.
	
	===== CHANGES HISTORY =====
	2021-10-21 MrW: Version 1.2 - filename corrected
	2016-10-04 MrW: Version 1.1 - output styles only sorted
	2014-05-29 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.cssText.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/fmxmlsnippet/Theme">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates select="CSS"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="CSS">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<!-- Markup the css -->
			<xsl:call-template name="fn.cssText.markup.CSS-Rules">
				<xsl:with-param name="css" select="text()"/>
			</xsl:call-template>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
