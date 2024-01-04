<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XML2_XML2_PrepareForDiffBetweenDeployments.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied fmp12 layout objects
	
	Processes the XML so that layout elements can be compared (diffed) for functionality.
	
	1. LayoutObject keys are removed
	2. All ids are removed

	===== CHANGES HISTORY =====
	2018-06-19 MrW v1.0

	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Ignore differences in internal ids (remove all id attributes)-->
	<xsl:template match="@id"/>
	<!-- Ignore tabbing order (remove all key attributes)-->
	<xsl:template match="@key"/>
</xsl:stylesheet>
