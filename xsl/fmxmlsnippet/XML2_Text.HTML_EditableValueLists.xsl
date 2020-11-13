<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: FMPReport_ListEditableValueLists.xsl

	XML-Source: FMPReportFile.xml
	XML-Grammar: FMPReport
	XML-Content: DDR (Database Definition Report)
	
	Returns all LayoutFields that have editable value lists
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2011-09-30 MrW: inc/constants.xsl
	2011-08-10 MrW: Version 0.9
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.Substitute.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="'&lt;/td&gt;&lt;td&gt;'"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/">
		<!--DOCTYPE html-->
		<html>
			<head>
				<meta http-equiv="Content-type" content="text/html; charset=utf-8"/>
				<title>Page Title</title>
			</head>
			<body>
				<table border="1" cellspacing="0" cellpadding="5">
					<tr>
						<th>
							<xsl:value-of select="'Value list'"/>
						</th>
						<th>
							<xsl:value-of select="'Field'"/>
						</th>
						<th>
							<xsl:value-of select="'Bounds (y1 x1 y2 x2)'"/>
						</th>
					</tr>
					<xsl:for-each select="//FieldObj[(@flags mod (2*8))&gt;=8]">
						<xsl:sort select="ValueList"/>
						<tr>
							<td>
								<xsl:value-of select="ValueList"/>
							</td>
							<td>
								<xsl:apply-templates select="DDRInfo/Field"/>
							</td>
							<td>
								<xsl:apply-templates select="preceding-sibling::Bounds"/>
								<xsl:value-of select="$newrecord"/>
							</td>
						</tr>
					</xsl:for-each>
				</table>
			</body>
		</html>
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
