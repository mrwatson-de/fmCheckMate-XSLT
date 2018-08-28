<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSC_Text.Chart.Scatter_ScriptCallStatistics.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts
	
	Lists how often a script is called.

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2016
	2014-07-15 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Script step 141. Variable setzen -->
	<!-- Main -->
	<xsl:template match="/">
		<!-- Output column headings -->
		<xsl:value-of select="'Script'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Called by'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Calls'"/>
		<xsl:value-of select="$newrecord"/>
		<!-- '-' indicates the first row is a heading row -->
		<xsl:value-of select="'-'"/>
		<xsl:value-of select="$newrecord"/>
		<!-- Output tabulated data -->
		<xsl:for-each select="//Script[not(ancestor::Step)]">
			<xsl:value-of select="@name"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:value-of select="count(//Step[@id='1' and @enable='True']/Script[@id=current()/@id and not(FileReference)])"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:value-of select="count(Step[@id='1' and @enable='True'])"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
