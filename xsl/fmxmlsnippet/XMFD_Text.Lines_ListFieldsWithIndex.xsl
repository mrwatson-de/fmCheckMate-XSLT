<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMFD_Text.Lines_ListFieldsWithIndex.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied fields or tables

	Lists fields which have a minimal index

	===== CHANGES HISTORY =====
	2016-12-21 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Match all Fields definitions -->
	<xsl:template match="//Field[Storage/@index='Minimal' or Storage/@index='All']">
		<xsl:if test="parent::BaseTable/@name">
			<xsl:value-of select="parent::BaseTable/@name"/>
			<xsl:text>::</xsl:text>
		</xsl:if>
		<xsl:value-of select="@name"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>

</xsl:stylesheet>
