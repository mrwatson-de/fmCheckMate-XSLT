<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" xmlns:math="http://exslt.org/math" xmlns:str="http://exslt.org/strings" extension-element-prefixes="exsl str math" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XML2_Text.Lines_ListExtractSvgHex.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	Extracts all SVG image HexData

	========================
	
	
	===== CHANGES HISTORY =====
	2015-09-16 MrW: Version 0.1
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- Main -->
	<xsl:template match="//Stream[normalize-space(Type/text())='SVG']/HexData">
		<xsl:value-of select="."/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>

	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
