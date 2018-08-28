<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XML2_Text.Lines_ListFieldNamesAndMergeFieldsSorted.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	Returns a sorted list of all field and merge field names.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2016
	2014-08-26 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<xsl:template match="/">
		<xsl:variable name="result">
			<xsl:apply-templates/>
		</xsl:variable>
		<!-- FIXME a sort value list functrion is required here! -->
		<xsl:value-of select="'FIXME: This XSLT cannot yet sort the result string'"/>
		<xsl:value-of select="$newrecord"/>
		
		<xsl:value-of select="$result"/>
	</xsl:template>
	<!-- Field Object Names -->
	<xsl:template match="Object/FieldObj">
		<xsl:value-of select="Name"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- Text with Merge text field(s) -->
	<xsl:template match="TextObj/ParagraphStyleVector/Style/Data[contains(.,'&lt;&lt;')]">
		<xsl:call-template name="ExtractFieldNamesFromLayoutText">
			<xsl:with-param name="text" select="text()"/>
			<xsl:with-param name="fieldNames" select="''"/>
		</xsl:call-template>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
	<!-- ===== NAMED TEMPLATES ===== -->
	<!-- ExtractFieldNamesFromLayoutText -->
	<xsl:template name="ExtractFieldNamesFromLayoutText">
		<xsl:param name="text"/>
		<xsl:param name="fieldNames"/>
		<!-- -->
		<xsl:variable name="nextBit" select="substring-after($text,'&lt;&lt;')"/>
		<xsl:variable name="fieldName" select="substring-before($nextBit,'&gt;&gt;')"/>
		<xsl:variable name="rest" select="substring-after($nextBit,'&gt;&gt;')"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="not(contains($nextBit,'&gt;&gt;'))">
				<!-- finished -->
				<xsl:value-of select="$fieldNames"/>
			</xsl:when>
			<xsl:when test="$fieldName!='' and not(contains($fieldName,'$$'))">
				<!-- add field -->
				<xsl:call-template name="ExtractFieldNamesFromLayoutText">
					<xsl:with-param name="text" select="$rest"/>
					<xsl:with-param name="fieldNames" select="concat($fieldNames,$fieldName,$newrecord)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<!-- recurse adding no field -->
				<xsl:call-template name="ExtractFieldNamesFromLayoutText">
					<xsl:with-param name="text" select="$rest"/>
					<xsl:with-param name="fieldNames" select="$fieldNames"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
