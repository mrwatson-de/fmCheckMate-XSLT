<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_Text_CountImportExportRecordFields.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps

	Counts the number of fields in an import/export

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2011-2016
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
	<!-- Count Export-->
	<xsl:template match="Step[@id='36']">
		<xsl:value-of select="@name"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="count(ExportEntries/ExportEntry)"/>
		<xsl:value-of select="' export fields'"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<xsl:template match="Step[@id='35']">
		<xsl:value-of select="@name"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:if test="TargetFields/Field[@map='Match']">
			<xsl:value-of select="count(TargetFields/Field[@map='Match'])"/>
			<xsl:value-of select="' match + '"/>
		</xsl:if>
		<xsl:value-of select="count(TargetFields/Field[@map='Import'])"/>
		<xsl:value-of select="' import fields / '"/>
		<xsl:value-of select="count(TargetFields/Field[following-sibling::Field[@map='Import']])+1"/>
		<xsl:value-of select="' columns'"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
