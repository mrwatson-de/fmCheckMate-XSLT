<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XML2_Text.Lines_ListObjectNames.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	Returns all Layout Object Names
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2013-11-19 MrW: Umbenannt für XML2
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
	<!-- Objects -->
	<xsl:template match="/">
		<xsl:for-each select="//Object[@name!='']|//TabPanelObj[@name!='']">
			<xsl:sort select="translate(@name,$LOWERCASE_CHARS,$UPPERCASE_CHARS)"/>
			<xsl:value-of select="name()"/>
			<xsl:value-of select="@type"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:if test="@name">
				<xsl:text>"</xsl:text>
				<xsl:value-of select="@name"/>
				<xsl:text>"</xsl:text>
			</xsl:if>
			<xsl:value-of select="$newrecord"/>
		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
