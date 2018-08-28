<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2018 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMFN_Text.HTML_AnalyseFunctions.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied Custom Function definitions
	
	Lists all Custom Function that appear to have been commented out OR to be duplicates
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2018
	2018-05-17 MrW: Version 1.0
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
		<xsl:variable name="results">
			<xsl:for-each select="//CustomFunction">
				<xsl:if
					test="not(ancestor::CustomFunction) and (substring(Calculation, 1, 2) = '/*') and (substring(Calculation, string-length(Calculation) - 1) = '*/')">
					<xsl:value-of select="@name"/>
					<xsl:value-of select="$delimiter"/>
					<xsl:value-of select="'/* Error */'"/>
					<xsl:value-of select="$newrecord"/>
				</xsl:if>
				<xsl:if
					test="not(ancestor::CustomFunction) and contains(' 2 3 4 5 6', substring(@name, string-length(@name) - 1))">
					<xsl:value-of select="@name"/>
					<xsl:value-of select="$delimiter"/>
					<xsl:value-of select="'Duplicate!?'"/>
					<xsl:value-of select="$newrecord"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<!-- Results with column titles -->
		<xsl:value-of select="'Function'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Status'"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="'-'"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:choose>
			<xsl:when test="$results != ''">
				<xsl:value-of select="$results"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'All'"/>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="'OK'"/>
				<xsl:value-of select="$newrecord"/>

			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
