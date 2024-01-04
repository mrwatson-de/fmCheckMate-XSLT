<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_SortExportFieldsByName.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied script-steps
	
	ExportEntries in ExportRecords script steps are sorted by field name.
	
	===== CHANGES HISTORY =====
	2011-04-16 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<!-- ===== TEMPLATES ===== -->
	<!-- Main templat-->
	<xsl:template match="ExportEntries">
		<xsl:copy>
			<xsl:for-each select="ExportEntry">
				<xsl:sort select="concat(Field/@table,Field/@name)"/>
				<xsl:copy-of select="."/>
			</xsl:for-each>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
