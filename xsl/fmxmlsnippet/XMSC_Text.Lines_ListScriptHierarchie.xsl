<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSC_Text.Lines_ListScriptHierarchie.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied FileMaker scripts
	
	Outputs the script list using indentation to show the hierarchie.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2011-09-30 MrW: inc/constants.xsl
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<xsl:variable name="indentString" select="'    '"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Script -->
	<xsl:template match="/*">
		<xsl:call-template name="ScriptHierarchie" select="*">
			<xsl:with-param name="indent" select="''"/>
		</xsl:call-template>
	</xsl:template>
	<!-- Script Hierarchy -->
	<xsl:template name="ScriptHierarchie">
		<xsl:param name="indent"/>
		<!---->
		<xsl:for-each select="*">
			<xsl:variable name="name" select="name()"/>
			<xsl:choose>
				<xsl:when test="name() = 'Script'">
					<xsl:value-of select="concat($indent, @name)"/>
					<xsl:value-of select="$newrecord"/>
				</xsl:when>
				<xsl:when test="name() = 'Group'">
					<xsl:value-of select="concat($indent, @name, '/')"/>
					<xsl:value-of select="$newrecord"/>
					<xsl:call-template name="ScriptHierarchie">
						<xsl:with-param name="indent" select="concat($indent,$indentString)"/>
					</xsl:call-template>
				</xsl:when>
				<!-- otherwise ignorieren -->
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
