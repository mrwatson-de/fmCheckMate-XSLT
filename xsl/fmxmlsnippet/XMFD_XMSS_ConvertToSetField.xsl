<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMFD_XMSS_ConvertToSetField.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied fields or tables

	Converts fields to set field script steps, using the calculation, AutoEnter or "".

	===== KNOWN ISSUES =====
	- XSLT Parameters are not yet implemented in fmCheckMate
	- Calculation is often broken, because...
	- ... the xslt function is not able to parse the calulation to add the table:: prefix to field references.

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2015-02-14 MrW: Version 1.1 Use table name from the calculation context
	2014-06-25 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== PARAMETER ===== -->
	<xsl:param name="table"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Match the root -->
	<xsl:template match="/">
		<fmxmlsnippet type="FMObjectList">
			<xsl:apply-templates select="*/*"/>
		</fmxmlsnippet>
	</xsl:template>
	<!-- Match all Fields definitions -->
	<xsl:template match="//Field[not(ancestor::Field)]">
		<Step enable="True" id="76">
			<xsl:variable name="id" select="@id"/>
			<xsl:variable name="name" select="@name"/>
			<xsl:variable name="tableName">
				<xsl:choose>
					<xsl:when test="../../BaseTable">
						<xsl:value-of select="../../BaseTable/@name"/>
					</xsl:when>
					<xsl:when test="$table != ''">
						<xsl:value-of select="$table"/>
					</xsl:when>
					<xsl:when test="@fieldType='Normal' and AutoEnter/@calculation='True'">
						<xsl:value-of select="AutoEnter/Calculation/@table"/>
					</xsl:when>
					<xsl:when test="@fieldType='Calculated'">
						<xsl:value-of select="Calculation/@table"/>
					</xsl:when>
					<xsl:when test="AutoEnter/@lookup='True'">
						<xsl:value-of select="AutoEnter/Lookup/Table/@name"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$table"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<!-- -->
			<Calculation>
				<xsl:choose>
					<xsl:when test="@fieldType='Normal' and AutoEnter/@calculation='True'">
						<xsl:if test="$tableName != AutoEnter/Calculation/@table">
							<xsl:value-of select="'/*'"/>
							<xsl:value-of select="AutoEnter/Calculation/@table"/>
							<xsl:value-of select="'::*/'"/>
						</xsl:if>
						<xsl:value-of select="AutoEnter/Calculation"/>
					</xsl:when>
					<xsl:when test="@fieldType='Calculated'">
						<xsl:if test="$tableName != Calculation/@table">
							<xsl:value-of select="'/*'"/>
							<xsl:value-of select="Calculation/@table"/>
							<xsl:value-of select="'::*/'"/>
						</xsl:if>
						<xsl:value-of select="Calculation"/>
					</xsl:when>
					<xsl:when test="AutoEnter/@lookup='True'">
						<xsl:value-of select="AutoEnter/Lookup/Field/@table"/>
						<xsl:value-of select="'::'"/>
						<xsl:value-of select="AutoEnter/Lookup/Field/@name"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$QUOT"/>
						<xsl:value-of select="$QUOT"/>
					</xsl:otherwise>
				</xsl:choose>
			</Calculation>
			<Field table="{$tableName}" id="{$id}" name="{$name}"/>
		</Step>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
