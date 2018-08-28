<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_Text_CountScriptsAndSteps.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps

	Counts the scripts and script steps.

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
	<xsl:template match="/*">
		<xsl:variable name="StepCount" select="count(//Step)"/>
		<xsl:variable name="ScriptRefsCount" select="count(//Script)"/>
		<xsl:variable name="ScriptCount" select="count(//Script[not(ancestor::Step)])"/>
		<xsl:variable name="ScriptCallsCount" select="$ScriptRefsCount - $ScriptCount"/>
		<xsl:value-of select="$ScriptCount"/><xsl:text> Scripts and </xsl:text>
		<xsl:value-of select="$StepCount"/><xsl:text> Steps</xsl:text>
		<xsl:if test="$ScriptCallsCount>0">
		<xsl:text> (inc. </xsl:text><xsl:value-of select="$ScriptCallsCount"/><xsl:text> Perform Script Steps)</xsl:text>
		</xsl:if>
	</xsl:template>

	<!-- ignore all other text -->
	<xsl:template match="text()"/>
		
</xsl:stylesheet>
