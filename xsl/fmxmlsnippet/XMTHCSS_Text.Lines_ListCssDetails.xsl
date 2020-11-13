<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMTHCSS_Text.Lines_ListCssDetails.xsl

	XML-Source: output from XMTH_XML_ThemeWithMarkesUpCSS.xsl
	XML-Grammar: MrWs CSS Markup Grammar
	XML-Content: one or more FileMaker Themes
	
	Lists the Theme names and their internal names.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2016-10-10 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/fmxmlsnippet/Theme">
		<xsl:value-of select="@name"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="@internalName"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:apply-templates select="*"/>
	</xsl:template>
	<!-- CSS-Rules -->
	<!--xsl:template match="//CSS-Rules/CSS-Rule[CSS-Selector/FmState='normal']">
		<xsl:value-of select="'ObjectType'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="CSS-Selector/FmObjectType"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="'State'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="CSS-Selector/FmState"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="CSS-Properties"/>
	</xsl:template-->
	<!-- Default CSS-Rules -->
	<!--xsl:template match="//CSS-Rules/CSS-Rule[not(CSS-Selector/FmStyleId) and CSS-Properties/CSS-Property = ./following-sibling::*/CSS-Properties/CSS-Property]"-->
	<xsl:template match="//CSS-Rules/CSS-Rule[not(CSS-Selector/FmStyleId)]">
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="'[Default]'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'ObjectType'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="CSS-Selector/FmObjectType"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="'State'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="CSS-Selector/FmState"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="CSS-Properties"/>
		<!-- -->
		<xsl:variable name="current" select="."/>
		<xsl:for-each select="$var">
			<xsl:sort select="$var" order="descending" case-order="upperlower-first" data-type="number" lang="language-code"/>
			
		</xsl:for-each>
		
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
