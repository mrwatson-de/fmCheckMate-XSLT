<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: xml_Text.Lines_ListXpathsToElements.xsl

	XML-Source: any.xml
	XML-Grammar: any
	XML-Content: any
	
	Emits a list of Xpath expressions.
	
	===== CHANGES HISTORY =====
	2011-02-09 MrW Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	 <xsl:template match="/">
		<xsl:call-template name="node" select=".">
			<xsl:with-param name="path" select="''"/>
		</xsl:call-template>
	</xsl:template>
	<!-- "node" -->
	 <xsl:template name="node">
		<xsl:param name="path" />
		<!---->
		<!-- Show path to the element -->
		<xsl:value-of select="$path" />
		<xsl:value-of select="$newrecord"/>
		<!-- Repeat for all child elements -->
		<xsl:for-each select="*">
			<xsl:call-template name="node" select=".">
				<xsl:with-param name="path" select="concat($path,'/',name())"/>
			</xsl:call-template>
		</xsl:for-each>
	 </xsl:template>

	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
