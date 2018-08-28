<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMFD_Text.Lines_ListPrimaryFields.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied field or table definitions
	
	Lists all Fields that have autoenter=serialnumber
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2018
	2018-05-11 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Fields with serials -->
	<xsl:template
		match="//Field[AutoEnter/Serial or contains(translate(AutoEnter/Calculation, ' &#13;&#10;', ''), 'Get(UUID') or TagList/@secondary = 'True']">
		<xsl:if test="../@name">
			<xsl:value-of select="../@name"/>
			<xsl:value-of select="'::'"/>
		</xsl:if>
		<xsl:value-of select="@name"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:if test="TagList/@secondary = 'True'">
			<!-- Show tag using an asterisk -->
			<xsl:value-of select="'(*)'"/>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="AutoEnter/Serial">
				<!-- AutoEnter Field -->
				<xsl:value-of select="'+='"/>
				<xsl:value-of select="AutoEnter/Serial/@increment"/>
				<xsl:value-of select="': '"/>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="AutoEnter/Serial/@nextValue"/>
			</xsl:when>
			<xsl:when
				test="contains(translate(AutoEnter/Calculation, ' &#13;&#10;', ''), 'Get(UUID')">
				<!-- UUID Field -->
				<xsl:value-of select="':='"/>
				<xsl:if test="AutoEnter/@overwriteExistingValue = 'True'">
					<xsl:value-of select="'='"/>
				</xsl:if>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="translate(AutoEnter/Calculation, '&#13;&#10;', ' ')"/>
			</xsl:when>
		</xsl:choose>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>

	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
