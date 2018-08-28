<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMFN_Text.Lines_ListFunctionDefinitions.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied Custom Function definitions
	
	Lists all Custom Functions, each in a single line
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2011-2016
	2013-09-10 MrW: Function renamed in line with XMFD_Text.Lines_ListFieldDefinitions
	2011-09-30 MrW: inc/constants.xsl
	2011-08-10 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- All CustomFunctions -->
	<xsl:template match="//CustomFunction[not(ancestor::CustomFunction)]">
		<xsl:if test="@visible='False'">
			<xsl:text>//</xsl:text>
		</xsl:if>
		<xsl:value-of select="@name"/>
		<xsl:if test="@parameters!=''">
			<xsl:text>( </xsl:text>
			<xsl:value-of select="@parameters"/>
			<xsl:text> )</xsl:text>
		</xsl:if>
		<xsl:if test="Calculation!=''">
			<xsl:value-of select="$delimiter"/>
			<xsl:text>=</xsl:text>
			<xsl:value-of select="$delimiter"/>
			<xsl:value-of select="translate(Calculation,$CRLF,' ')"/>
		</xsl:if>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
