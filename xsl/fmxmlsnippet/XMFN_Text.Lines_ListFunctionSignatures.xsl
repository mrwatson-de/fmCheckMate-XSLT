<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMFN_Text.Lines_ListFunctionSignatures.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied Custom Function definitions
	
	Lists all Custom Function signatures, each in a single line
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
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
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
