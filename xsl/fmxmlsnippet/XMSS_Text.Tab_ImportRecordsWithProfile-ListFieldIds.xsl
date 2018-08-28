<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_Text.Tab_ImportRecordsWithProfile-ListFieldIds.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or scriptsteps
	
	Returns a list of scripts / steps where there are gaps.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2016
	2014-07-14 MrW: At last!
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!--xsl:template match="Script[contains(@name,'#ImpLastOrder#') and Step/Profile]"-->
	<xsl:template match="Script/Step[Profile/List/InputField]">
		<xsl:value-of select="ancestor::Script/@name"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="position()"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="Profile/@table"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:for-each select="Profile/List/InputField">
			<xsl:value-of select="@id"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
