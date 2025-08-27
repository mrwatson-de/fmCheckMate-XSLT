<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSS_Text.Lines_ListScriptStepIDBlocks.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied Script or table definitions
	
	Lists blocks of script step IDs.
	
	Basically this function is just for MrWatson to make sure that all step IDs are present in the fmSyntaxColorizer `All script steps sorted by ID` script.
	
	Outputs something like this:
	
	```
	1	Perform Script
	:
	109	Edit User Dictionary
	---
	111	Open URL
	:
	203	Execute FileMaker Data API
	---
	205	Open Transaction
	:
	228	<unknown>
	```
	
	And lo' and behold - step 110 and step 204 are missing!
	
	===== CHANGES HISTORY =====
	2025-10-27 MrW: Version 1.0
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
		<xsl:apply-templates select="//Step[not(ancestor::Step)]">
			<xsl:sort select="@id" data-type="number"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="Step">
			<xsl:variable name="idp1" select="number(@id)+1"/>
			<xsl:variable name="idm1" select="number(@id)-1"/>
			<xsl:variable name="idm2" select="number(@id)-2"/>
			<xsl:variable name="start" select="not(../Step[@id=$idm1])"/>
			<xsl:variable name="end" select="not(../Step[@id=$idp1])"/>
			<!-- -->
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
				<xsl:if test="../Step[@id=$idm2]">
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
