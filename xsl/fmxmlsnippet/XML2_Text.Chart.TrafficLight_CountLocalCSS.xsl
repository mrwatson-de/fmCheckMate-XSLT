<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" extension-element-prefixes="exsl" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XML2_Text.Chart.TrafficLight_CountLocalCSS.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: fmp12 layout objects
	
	Counts the number of objects with Local CSS.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2016-11-16 MrW: Version 2.0 Adapted for traffic-light chart output
	2015-04-29 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- -->
	<xsl:variable name="countObjects" select="count(//Object)"/>
	<xsl:variable name="countFMStyle" select="count(//CustomStyles[not(contains(.,'FM-'))])"/>
	<xsl:variable name="countCustomStyle" select="count(//CustomStyles[contains(.,'FM-')])"/>
	<xsl:variable name="countDefaultStyle" select="$countObjects - $countCustomStyle - $countFMStyle"/>
	<!-- -->
	<xsl:variable name="countLocalCSS" select="count(//LocalCSS[not(ancestor::ConditionalFormatting)])"/>
	<xsl:variable name="countFMStyleLocalCSS" select="count(//CustomStyles[not(contains(.,'FM-')) and following-sibling::LocalCSS])"/>
	<xsl:variable name="countCustomStyleLocalCSS" select="count(//CustomStyles[contains(.,'FM-') and following-sibling::LocalCSS])"/>
	<xsl:variable name="countDefaultStyleLocalCSS" select="$countLocalCSS - $countFMStyleLocalCSS - $countCustomStyleLocalCSS"/>
	<!-- -->
	<xsl:variable name="countFMStyleNoLocalCSS" select="$countFMStyle - $countFMStyleLocalCSS"/>
	<xsl:variable name="countCustomStyleNoLocalCSS" select="$countCustomStyle - $countCustomStyleLocalCSS"/>
	<xsl:variable name="countDefaultStyleNoLocalCSS" select="$countDefaultStyle - $countDefaultStyleLocalCSS"/>
	<!-- -->
	<!-- ===== TEMPLATES ===== -->
	<!--  -->
	<xsl:template match="/">
		<xsl:value-of select="'Style+Formatting'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Default-Style'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'FM-Style'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Custom-Style'"/>
		<xsl:value-of select="$newrecord"/>
		<!-- 
		<xsl:value-of select="'Objects'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="''"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="''"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="''"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="$countObjects"/>
		<xsl:value-of select="$newrecord"/>
		-->
		<xsl:value-of select="'Style Use'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="$countDefaultStyle"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="$countFMStyle"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="$countCustomStyle"/>
		<xsl:value-of select="$newrecord"/>
		<!-- -->
		<xsl:value-of select="'Pure Style'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="$countDefaultStyleNoLocalCSS"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="$countFMStyleNoLocalCSS"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="$countCustomStyleNoLocalCSS"/>
		<xsl:value-of select="$newrecord"/>
		<!-- -->
		<xsl:value-of select="'LocalCSS'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="$countDefaultStyleLocalCSS"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="$countFMStyleLocalCSS"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="$countCustomStyleLocalCSS"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
