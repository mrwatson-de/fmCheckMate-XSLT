<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====
	
	XSL-File: XMFD_Text.Lines_ListFieldDeadWood.xsl
	
	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied field or table definitions
	
	Lists all the 'dead wood' in Field definitions
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2011-2016
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
	<!-- Main -->
	<xsl:template match="/">
		<xsl:apply-templates select="//Field"/>
	</xsl:template>
	<!--
	 !
	 !
	 ! AutoEnter
	 !
	 !
	 !-->
	<!-- Summary fields -->
	<xsl:template match="Field[@fieldType='Summary']/AutoEnter">
		<xsl:if test="ancestor::BaseTable/@name">
			<xsl:value-of select="ancestor::BaseTable/@name"/>
			<xsl:text>::</xsl:text>
		</xsl:if>
		<xsl:value-of select="ancestor::Field/@name"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Summary AutoEnter must be removed'"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- Calculation fields -->
	<xsl:template match="Field[@fieldType='Calculation']/AutoEnter">
		<xsl:if test="ancestor::BaseTable/@name">
			<xsl:value-of select="ancestor::BaseTable/@name"/>
			<xsl:text>::</xsl:text>
		</xsl:if>
		<xsl:value-of select="ancestor::Field/@name"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Calculation AutoEnter must be removed'"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- Inactive Data -->
	<xsl:template match="Field[@fieldType='Normal']/AutoEnter[@constant='False']/ConstantData/text()">
		<xsl:if test="ancestor::BaseTable/@name">
			<xsl:value-of select="ancestor::BaseTable/@name"/>
			<xsl:text>::</xsl:text>
		</xsl:if>
		<xsl:value-of select="ancestor::Field/@name"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Inactive Data Constant must be removed'"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- Inactive Lookup -->
	<xsl:template match="Field[@fieldType='Normal']/AutoEnter[@lookup='False']/Lookup">
		<xsl:if test="ancestor::BaseTable/@name">
			<xsl:value-of select="ancestor::BaseTable/@name"/>
			<xsl:text>::</xsl:text>
		</xsl:if>
		<xsl:value-of select="ancestor::Field/@name"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Inactive Lookup must be removed'"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- Inactive Calculation -->
	<xsl:template match="Field[@fieldType='Normal']/AutoEnter[@calculation='False']/Calculation">
		<xsl:if test="ancestor::BaseTable/@name">
			<xsl:value-of select="ancestor::BaseTable/@name"/>
			<xsl:text>::</xsl:text>
		</xsl:if>
		<xsl:value-of select="ancestor::Field/@name"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Inactive Calculation must be removed'"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!--
	 !
	 !
	 ! Validation
	 !
	 !
	 !-->
	<!-- Validation ErrorMessage-->
	<xsl:template match="Field/Validation[@message='False']/ErrorMessage">
		<xsl:if test="ancestor::BaseTable/@name">
			<xsl:value-of select="ancestor::BaseTable/@name"/>
			<xsl:text>::</xsl:text>
		</xsl:if>
		<xsl:value-of select="ancestor::Field/@name"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Validation Message must be removed'"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- Validation MaxDataLength -->
	<xsl:template match="Field/Validation[@maxLength='False']/MaxDataLength">
		<xsl:if test="ancestor::BaseTable/@name">
			<xsl:value-of select="ancestor::BaseTable/@name"/>
			<xsl:text>::</xsl:text>
		</xsl:if>
		<xsl:value-of select="ancestor::Field/@name"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Validation MaxDataLength must be removed'"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- Validation ValueList -->
	<xsl:template match="Field/Validation[@valuelist='False']/ValueList">
		<xsl:if test="ancestor::BaseTable/@name">
			<xsl:value-of select="ancestor::BaseTable/@name"/>
			<xsl:text>::</xsl:text>
		</xsl:if>
		<xsl:value-of select="ancestor::Field/@name"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Validation ValueList must be removed'"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- Validation Calculation -->
	<xsl:template match="Field/Validation[@calculation='False']/Calculation">
		<xsl:if test="ancestor::BaseTable/@name">
			<xsl:value-of select="ancestor::BaseTable/@name"/>
			<xsl:text>::</xsl:text>
		</xsl:if>
		<xsl:value-of select="ancestor::Field/@name"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Validation Calculation must be removed'"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
