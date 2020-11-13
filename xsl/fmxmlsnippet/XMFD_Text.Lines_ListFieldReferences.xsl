<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMFD_Text.Lines_ListFieldReferences.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied fields or tables

	Lists field references

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2011-09-30 MrW: inc/constants.xsl
	2011-08-10 MrW: Version 0.9
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Script step 1. Script ausführen -->
	<xsl:template match="/*">
		<xsl:for-each select="Field[not(ancestor::Field) and contains(///Calculation/text(),@name)]">
			<xsl:variable name="theName" select="@name"/>
			<xsl:variable name="theFieldName">
				<xsl:if test="parent::BaseTable/@name">
					<xsl:value-of select="parent::BaseTable/@name"/>
					<xsl:text>::</xsl:text>
				</xsl:if>
				<xsl:value-of select="@name"/>
			</xsl:variable>
			<xsl:value-of select="$theFieldName"/>
			
			<xsl:for-each select="Field[not(ancestor::Field) and contains(//Calculation/text(),$theName)]">
				<xsl:value-of select="$theFieldName"/>
				<xsl:text>&#9;--&gt;&#9;</xsl:text>
				<xsl:value-of select="ancestor::Field"/>
				<xsl:if test="@table">
					<xsl:value-of select="@table"/>
					<xsl:text>::</xsl:text>
					<xsl:value-of select="@name"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>

</xsl:stylesheet>
