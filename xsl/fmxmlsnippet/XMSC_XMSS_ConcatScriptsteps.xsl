<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSC_XMSS_ConcatScriptsteps.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts
	
	Returns just the contents of the scripts as Scriptsteps
	
	===== CHANGES HISTORY =====
	2013-09-09 MrW: Clone templates centralized in _inc/inc.Clone.xsl
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Remove all Script elements  -->
	<xsl:template match="//Script[not(ancestor::Step)]">
		<xsl:apply-templates select="*"/>
	</xsl:template>
</xsl:stylesheet>
