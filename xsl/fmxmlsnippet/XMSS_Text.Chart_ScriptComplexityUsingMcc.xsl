<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_Text.Tab_ScriptComplexityUsingMcc.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps

	Counts the scripts and script steps.

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2011-09-30 MrW: inc/constants.xsl
	2011-08-10 MrW: Version 0.9
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.StepIDs.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/">
		<xsl:for-each select="//Script[not(ancestor::Script) and Step]">
			<xsl:sort select="number(count(Step) &gt; 0) + count(Step[@id=$ID_IF or @id=$ID_ELSE_IF])" order="descending" data-type="number"/>
			<!-- -->
			<xsl:variable name="StepCount" select="count(Step)"/>
			<xsl:variable name="IfCount" select="count(Step[@id=$ID_IF or @id=$ID_ELSE_IF])"/>
			<xsl:variable name="CyclomaticComplexity" select="count(//Script)"/>
			<!-- -->
			<xsl:value-of select="@name"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:value-of select="number($StepCount &gt; 0) + $IfCount"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
