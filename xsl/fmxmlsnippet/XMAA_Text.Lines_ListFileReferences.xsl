<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMAA_Text.Lines_ListFileReferences.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: any FileMaker Clipboard content
	
	Returns a list of all referenced files.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2015-05-28 MrW: Version 1.0 - only FM Fles
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<xsl:key name="fileReferences-by-name" match="//FileReference" use="@name"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Field -->
	<xsl:template match="/">
		<xsl:for-each select="//FileReference[count(. | key('fileReferences-by-name', @name)[1]) = 1]">
			<xsl:sort select="@name"/>
			<!-- -->
			<xsl:if test="position()&gt;1">
				<xsl:value-of select="$newrecord"/>
			</xsl:if>
			<xsl:value-of select="@name"/>
		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
