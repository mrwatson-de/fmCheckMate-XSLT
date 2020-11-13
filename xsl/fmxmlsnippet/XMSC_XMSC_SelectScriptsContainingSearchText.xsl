<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSC_XMSC_SelectScriptsContainingSearchText.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts
	
	Returns just scripts containing the searchText
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2013-09-09 MrW: Clone templates centralized in _inc/inc.Clone.xsl
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== PARAMS ===== -->
	<xsl:param name="pSearchText" select="'2013-06-26 RW: '"/>
	<!--xsl:variable name="pSearchText" select="'2013-06-26 RW: '"/-->
	<!-- ===== TEMPLATES ===== -->
	<!-- Remove all Scripts containing the search text  -->
	<xsl:template match="//*[not(contains(.,$pSearchText))]"/>
</xsl:stylesheet>
