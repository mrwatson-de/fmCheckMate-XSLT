<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMTH_Text.Tab_ThemeAndStyleImpostors.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: one or more FileMaker Themes
	
	Lists the theme and (custom) style names and their internal names.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2016
	2016-10-10 MrW: Version 1.2 Changed filename to output as a table
	2015-04-18 MrW: Version 1.1 Themes sorted by name
	2014-05-27 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="indent" select="'Custom-Style: '"/>
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/fmxmlsnippet">
		<xsl:for-each select="Theme">
			<xsl:sort select="@name"/>
			<!-- -->
			<!-- Output column headings -->
			<xsl:value-of select="'Theme'"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:value-of select="@name"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:value-of select="@internalName"/>
			<xsl:value-of select="$newrecord"/>
			<!-- '-' indicates the first row is a heading row -->
			<xsl:value-of select="'-'"/>
			<xsl:value-of select="$newrecord"/>
			<!-- Output tabulated data -->
			<xsl:for-each select="metadata/namedstyles/*[starts-with(name(), 'FM-')]">
				<xsl:sort select="."/>
				<!-- -->
				<xsl:value-of select="'Style'"/>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="."/>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="name()"/>
				<xsl:value-of select="$newrecord"/>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
