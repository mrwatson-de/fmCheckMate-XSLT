<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMFD_Text.Lines_ListFieldsWithSerialNumbers.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied field or table definitions
	
	Lists all Fields that have autoenter=serialnumber
	
	===== CHANGES HISTORY =====
	2016-12-21 MrW: renamed as *N*umbers.
	2011-11-01 MrW: renamed as 'List' function.
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
	<!-- Fields with serials -->
	<xsl:template match="//Field[AutoEnter/Serial]">
		<xsl:if test="../@name"><xsl:value-of select="../@name"/>::</xsl:if><xsl:value-of select="@name"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:text>=+ </xsl:text>
		<xsl:value-of select="AutoEnter/Serial/@nextValue"/>
		<xsl:if test="AutoEnter/Serial/@increment!=1">
			<xsl:value-of select="$delimiter"/>
			<xsl:text>(+</xsl:text>
			<xsl:value-of select="AutoEnter/Serial/@increment"/>
			<xsl:text>)</xsl:text>
		</xsl:if>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
