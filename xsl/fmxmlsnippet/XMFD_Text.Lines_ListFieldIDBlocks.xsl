<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMFD_Text.Lines_ListFieldIDBlocks.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied field or table definitions
	
	Lists the fields in creation order FIXME.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2014-06-25 MrW: Version 0.1
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
		<xsl:apply-templates select="//Field[not(ancestor::Field)]">
			<xsl:sort select="@id" data-type="number"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="Field">
		<xsl:variable name="idp1" select="number(@id)+1"/>
		<xsl:variable name="idm1" select="number(@id)-1"/>
		<xsl:variable name="idm2" select="number(@id)-2"/>
		<xsl:variable name="start" select="not(../Field[@id=$idm1])"/>
		<xsl:variable name="end" select="not(../Field[@id=$idp1])"/>
		<xsl:if test="$start">
			<xsl:if test="position()&gt;1">
				<xsl:value-of select="'---'"/>
				<xsl:value-of select="$newrecord"/>
			</xsl:if>
			<xsl:value-of select="@id"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:value-of select="@name"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:if>
		<xsl:if test="not($start) and $end">
			<xsl:if test="../Field[@id=$idm2]">
				<xsl:value-of select="':'"/>
				<xsl:value-of select="$newrecord"/>
			</xsl:if>
			<xsl:value-of select="@id"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:value-of select="@name"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
