<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XML2_Text.Tab_EditableValueLists.xsl

	XML-Source: FMPReportFile.xml
	XML-Grammar: FMPReport
	XML-Content: DDR (Database Definition Report)
	
	Returns all LayoutFields that have editable value lists
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2011-2016
	2016-12-19 MrW: Changed to simpler tabulated output
	2011-09-30 MrW: inc/constants.xsl
	2011-08-10 MrW: Version 0.9
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.Substitute.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/">
		<!-- -->
		<!-- Output column headings -->
		<xsl:value-of select="'Value list'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Field'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Bounds (y1 x1 y2 x2)'"/>
		<xsl:value-of select="$newrecord"/>
		<!-- '-' indicates the first row is a heading row -->
		<xsl:value-of select="'-'"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:for-each select="//FieldObj[(@flags mod (2*8))&gt;=8]">
			<xsl:sort select="ValueList"/>
			<!-- -->
			<xsl:value-of select="ValueList"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:apply-templates select="DDRInfo/Field"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:apply-templates select="preceding-sibling::Bounds"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:for-each>
	</xsl:template>
	<!-- ===== FUNCTIONS/NAMED TEMPLATES ===== -->
	<!-- Field -->
	<xsl:template name="Field_FullNameOrId" match="Field">
		<!--xsl:value-of select="name()"/-->
		<xsl:param name="currentContextTable" select="''"/>
		<xsl:choose>
			<xsl:when test="@table=$currentContextTable">
				<!-- don't show table when it's the same as the current context -->
			</xsl:when>
			<xsl:when test="@table">
				<xsl:value-of select="@table"/>
				<xsl:value-of select="'::'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'&lt;table missing&gt;'"/>
				<xsl:value-of select="'::'"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="@name">
				<xsl:value-of select="@name"/>
			</xsl:when>
			<xsl:when test="@id">
				<xsl:value-of select="concat('{',@id,'}')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'&lt;field missing&gt;'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Bounds -->
	<xsl:template name="Bounds" match="Bounds">
		<xsl:call-template name="fn.Substitute">
			<xsl:with-param name="text" select="concat(@top, ' ', @left, ' ', @bottom, ' ', @right)"/>
			<xsl:with-param name="searchString" select="'.000000'"/>
			<xsl:with-param name="replaceString" select="''"/>
		</xsl:call-template>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
