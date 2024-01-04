<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSC_Text.Lines_ListCallingScripts.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	For each script lists the script which call them.
	
	===== CHANGES HISTORY =====
	2011-09-30 MrW: inc/constants.xsl
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<xsl:variable name="indent" select="'  '"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Script -->
	<xsl:template match="//Script[not(ancestor::Step)]">
		<xsl:variable name="scriptID" select="@id"/>
		<xsl:variable name="scriptName" select="@name"/>
		
		<xsl:for-each select="//Script[not(ancestor::Step)]/Step[@id='1' and @enable='True' and Script/@id=$scriptID]">
			<!--xsl:value-of select="position()"/-->
			<xsl:value-of select="ancestor::Script/@name"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:for-each>
		<xsl:choose>
			<xsl:when test="//Script[not(ancestor::Step)]/Step[@id='1' and @enable='True' and Script/@id=$scriptID]">
				<xsl:value-of select="'=>'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'XX'"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="$indent"/>
		<xsl:text>Script </xsl:text>
		<xsl:value-of select="$scriptName"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
