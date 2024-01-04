<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_DisableEnable.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied script-steps
	
	Disables (or re-enables) all script steps (useful if you don't have access to FileMaker Pro Advanced).
	
	===== CHANGES HISTORY =====
	2013-05-06 MrW: Version 1.0
	2013-09-09 MrW: Clone templates centralized in _inc/inc.Clone.xsl
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="enable">
		<xsl:choose>
			<xsl:when test="count(//Step[not(ancestor::Step) and @enable='False'])=count(//Step[not(ancestor::Step)])">
				<xsl:value-of select="'True'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'False'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<!-- ===== TEMPLATES ===== -->
	<!-- Disable or re-enable every script step-->
	<xsl:template match="Step[not(ancestor::Step)]/@enable">
		<xsl:attribute name="enable">
			<xsl:value-of select="$enable"/>
		</xsl:attribute>
	</xsl:template>
</xsl:stylesheet>
