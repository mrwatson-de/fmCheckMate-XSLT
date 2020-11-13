<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_InsertFirstStepAfterEachStep.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps - with comments
	
	Takes the first script block and inserts it after every (non-comment) script step.

	Thanks to HOnza Kadoulka for the inspiration.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2017-10-12 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	
	<!-- ===== Vars ===== -->
	<xsl:variable name="countLinesInFirstBlock" select="'FIXME'"/>
	
	<!-- ===== TEMPLATES ===== -->
	
	<!-- match a non-comment step -->
	<xsl:template match="Step[@id!='89']">
		<xsl:if test="position()&gt;$countLinesInFirstBlock">
			<!-- expand -->
			<xsl:copy-of select="."/>
			<xsl:copy-of select="//Step[@id!='89'][1]"/>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
