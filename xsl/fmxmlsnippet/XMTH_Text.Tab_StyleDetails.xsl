<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" version="1.0" exclude-result-prefixes="exsl">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMTH_Text.Tab_StyleDetails.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: one or more FileMaker Themes
	
	Outputs style details .... WORK IN PROGRESS
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2016-10-04 MrW: Version 1.1 - output styles only sorted
	2014-05-29 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.cssText.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<xsl:variable name="indent" select="$TAB"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/fmxmlsnippet">
		<!-- Output column headings -->
		<xsl:value-of select="'Theme'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Style'"/>
		<xsl:value-of select="$newrecord"/>
		<!-- '-' indicates the first row is a heading row -->
		<xsl:value-of select="'-'"/>
		<xsl:value-of select="$newrecord"/>
		<!-- Output tabulated data -->
		<xsl:for-each select="Theme">
			<xsl:sort select="@name"/>
			<!-- -->
			<xsl:variable name="$ThemeName" select="@name"/>
			<!-- -->
			<!-- List styles alphabetically-->
			<xsl:for-each select="namedstyle/*">
				<xsl:sort select="text()"/>
				<!-- -->
				<xsl:variable name="$StyleName" select="text()"/>
				<!-- -->
				<xsl:value-of select="$ThemeName"/>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="$StyleName"/>
				<xsl:value-of select="$newrecord"/>
				<!-- -->
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
