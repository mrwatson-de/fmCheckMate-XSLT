<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_TidyImportRecords-Remove Gaps.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Removes all non-imported fields, so that FileMaker reinserts them *at the end of the import list* when pasted back into the database.

	===== CHANGES HISTORY =====
	2017-01-17 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:key name="UnmappedFields" match="//Field[@map='DoNotImport' and @name!='']" use="count(preceding-sibling::Field[@name!=''])"/>
	<xsl:variable name="UnmappedField">
		<xsl:for-each select="Field[@map='DoNotImport' and @name!='']">
			<xsl:sort select="Field/@name"/>
			<!-- -->
		</xsl:for-each>
	</xsl:variable>
	
	<!-- ===== TEMPLATES ===== -->
	<!-- remove unmapped field reference -->
	<xsl:template match="Field[@map='DoNotImport']">
		<xsl:variable name="id" select="key(UnmappedFields,position())"/>
		
		<Field map="DoNotImport" id="0" name=""/>
	</xsl:template>
</xsl:stylesheet>
