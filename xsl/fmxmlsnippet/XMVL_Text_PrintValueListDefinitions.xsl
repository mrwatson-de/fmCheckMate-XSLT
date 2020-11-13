<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMVL_Text_PrintValueListDefinitions.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied value lists

	Prints value list definitions.

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2017-05-29 MrW: Version 0.2
	2016-10-02 MrW: Version 0.1
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.Substitute.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="delimiter2" select="': '"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Match all ValueList definitions -->
	<xsl:template match="/fmxmlsnippet">
		<xsl:apply-templates select="*"/>
	</xsl:template>
	<xsl:template match="ValueList">
		<xsl:value-of select="'Value List'"/>
		<xsl:value-of select="' '"/>
		<xsl:value-of select="$QUOT"/>
		<xsl:value-of select="@name"/>
		<xsl:value-of select="$QUOT"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:choose>
			<xsl:when test="Source[@value='Field']">
				<!-- Field 1 -->
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="'Field 1'"/>
				<xsl:value-of select="$delimiter2"/>
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
				<xsl:value-of select="$newrecord"/>
				<!-- Field 2 -->
				<xsl:if test="SecondaryField">
					<xsl:value-of select="$delimiter"/>
					<xsl:value-of select="'Field 2'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:if test="SecondaryField/Field/@table!=PrimaryField/Field/@table">
						<xsl:value-of select="SecondaryField/Field/@table"/>
						<xsl:value-of select="'::'"/>
					</xsl:if>
					<xsl:value-of select="SecondaryField/Field/@name"/>
					<xsl:value-of select="$newrecord"/>
				</xsl:if>
				<xsl:if test="ShowRelated/@value='True'">
					<xsl:value-of select="$delimiter"/>
					<xsl:value-of select="'From'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:value-of select="ShowRelated/Table/@name"/>
					<xsl:value-of select="'::'"/>
					<xsl:value-of select="$newrecord"/>
				</xsl:if>
			</xsl:when>
			<xsl:when test="Source[@value='External']">
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="'Value List'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:value-of select="$QUOT"/>
				<xsl:value-of select="External/ValueList/@name"/>
				<xsl:value-of select="$QUOT"/>
				<xsl:value-of select="$newrecord"/>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="'Source File'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:value-of select="$QUOT"/>
				<xsl:value-of select="External/FileReference/@name"/>
				<xsl:value-of select="$QUOT"/>
				<xsl:value-of select="$newrecord"/>
			</xsl:when>
			<xsl:when test="Source[@value='Custom']">
				<xsl:value-of select="$delimiter"/>
				<xsl:call-template name="fn.Substitute">
					<xsl:with-param name="text" select="CustomValues/Text"/>
					<xsl:with-param name="searchString" select="$CR"/>
					<xsl:with-param name="replaceString" select="concat($newrecord,$delimiter)"/>
				</xsl:call-template>
				<xsl:value-of select="$newrecord"/>
			</xsl:when>
		</xsl:choose>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
