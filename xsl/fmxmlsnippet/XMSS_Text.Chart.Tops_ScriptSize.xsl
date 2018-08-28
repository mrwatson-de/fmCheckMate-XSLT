<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_Text.Chart.Tops_ScriptSize.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps

	Counts the steps in a script.

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2011-2016
	2011-09-30 MrW: inc/constants.xsl
	2011-08-10 MrW: Version 0.9
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Count -->
	<!-- Main -->
	<xsl:template match="/">
		<xsl:for-each select="//Script[not(ancestor::Script) and Step]">
			<xsl:sort select="count(Step)" order="descending" data-type="number"/>
			<!-- -->
			<xsl:variable name="StepCount" select="count(Step)"/>
			<!-- -->
			<xsl:value-of select="@name"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:value-of select="$StepCount"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
