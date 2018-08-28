<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dyn="http://exslt.org/dynamic" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: xsl_Text.Lines_ListParameterValuePairs.xsl

	XML-Source: any.xsl
	XML-Grammar: xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	XML-Content: any xslt stylesheet
	
	Lists the parameters of a stylesheet paramName:paramValue.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2016
	2015-01-16 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<!--xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/-->
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="':'"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<xsl:template match="/xsl:stylesheet">
		<xsl:for-each select="xsl:param">
			<xsl:if test="position() &gt; 1">
				<xsl:value-of select="$newrecord"/>
			</xsl:if>
			<xsl:value-of select="@name"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:choose>
				<xsl:when test="@select">
					<xsl:value-of select="dyn:evaluate(@select)"/>
				</xsl:when>
				<!--xsl:when test="substring(@select,1,1)=$APOS and ">
				</xsl:when-->
				<xsl:otherwise>
					<!-- Just the text content -->
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
