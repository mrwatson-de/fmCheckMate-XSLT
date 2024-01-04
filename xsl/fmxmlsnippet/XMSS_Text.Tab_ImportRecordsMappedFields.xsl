<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSS_Text.Tab_ImportRecordsMappedFields.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or scriptsteps
	
	Returns a list of the positions of mapped fields in Import Records script steps (for diffing).
	
	===== CHANGES HISTORY =====
	2014-07-14 MrW: At last!
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
		<xsl:value-of select="'Script'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Import #'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Map Pos'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Map'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Field'"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:apply-templates select="//Step/TargetFields/Field">
			<xsl:sort select="ancestor::Script/@id" data-type="number"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="Step/TargetFields/Field[@map!='DoNotImport']">
		<xsl:value-of select="ancestor::Script/@id"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="1 + count(ancestor::Step/preceding-sibling::Step[@id='35'])"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="1 + count(preceding-sibling::Field)"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:choose>
			<xsl:when test="@map='Import'">
				<xsl:value-of select="'=&gt;'"/>
			</xsl:when>
			<xsl:when test="@map='DoNotImport'">
				<xsl:value-of select="':'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="@map"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="@name"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
