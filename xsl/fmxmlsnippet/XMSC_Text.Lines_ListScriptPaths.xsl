<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSC_Text.Lines_ListScriptPaths.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts
	
	List the path to each script in the form MainGroup/SubGroup/.../Scriptname.
	
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
	<!-- Script -->
	<xsl:template match="/*">
		<xsl:call-template name="ScriptPaths" select="*">
			<xsl:with-param name="basePath" select="''"/>
		</xsl:call-template>
	</xsl:template>
	<!-- Script Paths -->
	<xsl:template name="ScriptPaths">
		<xsl:param name="basePath"/>
		<!---->
		<xsl:for-each select="*">
			<xsl:choose>
				<xsl:when test="name() = 'Script'">
					<xsl:value-of select="concat($basePath, @name)"/>
					<xsl:value-of select="$newrecord"/>
				</xsl:when>
				<xsl:when test="name() = 'Group'">
					<xsl:value-of select="concat($basePath, @name, '/')"/>
					<xsl:value-of select="$newrecord"/>
					<xsl:call-template name="ScriptPaths">
						<xsl:with-param name="basePath" select="concat($basePath, @name, '/')"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>huh?</xsl:text>
					<xsl:value-of select="$newrecord"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
