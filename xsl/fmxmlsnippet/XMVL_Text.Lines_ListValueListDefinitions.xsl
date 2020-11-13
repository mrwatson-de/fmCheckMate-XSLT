<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMVL_Text.Lines_ListValueListDefinitions.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied value lists

	Lists value list definitions, each in a single line.

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2017-05-29 MrW: Version 1.0
	2016-10-02 MrW: Version 0.1
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Match all ValueList definitions -->
	<xsl:template match="/fmxmlsnippet/ValueList">
		<xsl:value-of select="@name"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="Source/@value"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:choose>
			<xsl:when test="Source[@value='Field']">
				<xsl:if test="PrimaryField/@show='False'">
					<xsl:value-of select="'('"/>
				</xsl:if>
				<xsl:if test="PrimaryField/@sort='True'">
					
				</xsl:if>
				<xsl:value-of select="PrimaryField/Field/@table"/>
				<xsl:value-of select="'::'"/>
				<xsl:value-of select="PrimaryField/Field/@name"/>
				<xsl:if test="PrimaryField/@show='False'">
					<xsl:value-of select="')'"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="SecondaryField">
					<xsl:value-of select="', '"/>
					<xsl:if test="SecondaryField/Field/@table!=PrimaryField/Field/@table">
						<xsl:value-of select="SecondaryField/Field/@table"/>
						<xsl:value-of select="'::'"/>
					</xsl:if>
					<xsl:value-of select="SecondaryField/Field/@name"/>
				</xsl:if>
				<xsl:if test="ShowRelated/@value='True'">
					<xsl:value-of select="' from related table '"/>
				</xsl:if>
				<xsl:value-of select="ShowRelated/Table/@name"/>
			</xsl:when>
			<xsl:when test="Source[@value='External']">
				<xsl:value-of select="'List: '"/>
				<xsl:value-of select="External/ValueList/@name"/>
				<xsl:value-of select="', File: '"/>
				<xsl:value-of select="External/FileReference/@name"/>
			</xsl:when>
			<xsl:when test="Source[@value='Custom']">
				<xsl:value-of select="translate(CustomValues/Text,$CRLF,$TAB)"/>
			</xsl:when>
		</xsl:choose>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
