<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_Text.Tab_ImportRecordsProfileFields.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or scriptsteps
	
	Returns a list of the positions of mapped fields in Import Records script steps (for diffing).
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2014-07-14 MrW: At last!
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
		<xsl:value-of select="'Script'"/>
		<xsl:value-of select="$delimiter"/>
		<!--xsl:value-of select="'Step'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'InputField'"/>
		<xsl:value-of select="$delimiter"/-->
		<xsl:value-of select="'id'"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:apply-templates select="//Step/Profile/List/InputField"/>
	</xsl:template>
	<xsl:template match="Step/Profile/List/InputField">
		<xsl:value-of select="ancestor::Script/@name"/>
		<xsl:value-of select="$delimiter"/>
		<!--xsl:value-of select="1 + count(ancestor::Script/previous-sibling::Step)"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="1 + count(previous-sibling::InputField)"/>
		<xsl:value-of select="$delimiter"/-->
		<xsl:value-of select="@id"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
