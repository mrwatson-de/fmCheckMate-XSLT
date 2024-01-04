<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: inc.XMFD_Text.tgf_FieldDependenciesGraph.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied field or table definitions
	
	include file defines how node and edge are rendered in tgf
	

	===== CHANGES HISTORY =====
	2017-01-17 MrW v0.1
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<!-- renderFieldNode -->
	<xsl:template name="renderFieldNode">
		<xsl:value-of select="'F'"/>
		<xsl:value-of select="@id"/>
		<xsl:value-of select="' '"/>
		<xsl:call-template name="FieldGraphNodeName"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- renderEdgeFIXME -->
	<xsl:template name="renderEdgeFIXME">
		<xsl:value-of select="'FIXME'"/>
	</xsl:template>
</xsl:stylesheet>
