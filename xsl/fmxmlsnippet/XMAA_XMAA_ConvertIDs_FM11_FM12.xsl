<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMAA_XMAA_ConvertIDs_FM11_FM12.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: any copied filemaker objects
	
	Converts table, field, script and custom function IDs from filemaker 11 to FileMaker 12.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2013-2016
	2013-09-11 MrW: Version 1.1 With Script Groups
	2013-09-09 MrW: Clone templates centralized in _inc/inc.Clone.xsl
	2013-08-31 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Field IDs -->
	<xsl:template match="Field/@id|Script/@id|Group/@id|CustomFunction/@id">
		<xsl:variable name="id" select="number(.)"/>
		<!--  -->
		<xsl:attribute name="id">
			<xsl:choose>
				<xsl:when test="$id &gt;= 128">
					<!-- change IDs greater than or equal to 128 -->
					<xsl:value-of select="$id - 32768 + 128"/>
				</xsl:when>
				<xsl:otherwise>
					<!-- no change -->
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</xsl:template>
	<!-- Table IDs -->
	<xsl:template match="Table/@id">
		<xsl:variable name="id" select="number(.)"/>
		<!--  -->
		<xsl:attribute name="id">
			<!-- change ALL table IDs by 0xBFBF80 -->
			<xsl:value-of select="$id - 13631489 + 1065089"/>
		</xsl:attribute>
	</xsl:template>
</xsl:stylesheet>
