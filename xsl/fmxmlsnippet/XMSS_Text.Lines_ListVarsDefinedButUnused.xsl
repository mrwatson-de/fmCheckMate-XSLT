<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSS_Text.Lines_ListVarsDefinedButUnused.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or scriptsteps
	
	Returns all variables defined by Set Variable script step, but which are not referenced
	
	===== CHANGES HISTORY =====
	2019-02-27 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<!-- PARAMETERS -->
	<!-- pShow = unused / used / all -->
	<xsl:param name="pShow" select="'unused'"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="'&#9;'"/>
	<xsl:variable name="newrecord" select="'&#10;'"/>
	<!-- ===== TEMPLATES ===== -->
	<xsl:template match="/">
		<!--		<xsl:variable name="result">-->
		<xsl:for-each select="//Step[@id = '141' and @enable = 'True']">
			<xsl:sort select="string-length(Name)" order="descending"/>
			<!--  -->
			<xsl:variable name="varName" select="Name/text()"/>
			<xsl:variable name="used">
				<xsl:for-each select="//Calculation[contains(text(), $varName)]">
					<xsl:value-of select="$varName"/>
					<xsl:value-of select="' used in line '"/>
					<xsl:value-of select="1 + count(preceding::Step/@enable)"/>
					<xsl:value-of select="$newrecord"/>
				</xsl:for-each>
			</xsl:variable>
			<xsl:if test="$pShow='all' or (($pShow='unused') = ($used = ''))">
				<!-- UNUSED! -->
				<xsl:value-of select="$varName"/>
				<xsl:value-of select="' declared in line '"/>
				<xsl:value-of select="1 + count(preceding::Step/@enable)"/>
				<xsl:value-of select="$newrecord"/>
				<xsl:value-of select="$used"/>
				
			</xsl:if>
		</xsl:for-each>
		<!--</xsl:variable>-->
		<!-- OUTPUT with no trailing return -->
		<!--		<xsl:value-of select="substring($result,1,string-length($result)-string-length($newrecord))"/>-->
	</xsl:template>


	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
