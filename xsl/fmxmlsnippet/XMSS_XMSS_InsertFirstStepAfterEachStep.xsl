<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_InsertFirstStepAfterEachStep.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps - with comments
	
	Takes the first script step and inserts it after every (non-comment) script step.

	Thanks to HOnza Kadoulka for the inspiration.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2017
	2017-10-12 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- match a non-comment step -->
	<xsl:template match="Step[@id!='89' and position()!=1]">
		<!-- expand -->
		<xsl:copy-of select="."/>
		<xsl:copy-of select="//Step[@id!='89'][1]"/>
	</xsl:template>
	<!-- text (copyAndExpandPlaceholders)-->
	<xsl:template match="text()" mode="copyAndExpandPlaceholders">
		<xsl:call-template name="Subsitute">
			<xsl:with-param name="text" select="."/>
			<xsl:with-param name="searchText" select="'{{count(preceding::Step)}}'"/>
			<xsl:with-param name="replaceText" select="count(preceding::Step)"/>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
