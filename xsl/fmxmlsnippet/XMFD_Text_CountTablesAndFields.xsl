<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMFD_Text_CountTablesAndFields.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied tables or fields

	Counts the tables and fields.

	===== CHANGES HISTORY =====
	2011-09-30 MrW: inc/constants.xsl
	2011-08-10 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Count -->
	<xsl:template match="/*">
		<xsl:value-of select="count(BaseTable)"/><xsl:text> Tables and </xsl:text>
		<xsl:value-of select="count(//Field[not(ancestor::Field)])"/><xsl:text> Fields</xsl:text>
	</xsl:template>

	<!-- ignore all other text -->
	<xsl:template match="text()"/>
		
</xsl:stylesheet>
