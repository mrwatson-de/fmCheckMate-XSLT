<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMAA_Text.List_MissingNames.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: any FileMaker Clipboard content
	
	Creates a list of all objects with missing @name s (except for empty Layout references in Go to Calculated Layout)
	
	===== CHANGES HISTORY =====
	2021-02-22 MrW: Version 0.1 
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
		<xsl:for-each select="//@name[.='' and parent::*/sibling::LayoutDestination/@value!='LayoutNumberByCalc']">
			<xsl:value-of select="parent::*/parent::*/@name"/>
			<xsl:if test="position() != last()">
				<xsl:value-of select="$newrecord"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
