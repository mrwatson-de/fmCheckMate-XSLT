<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMFN_XMFN_SortFunctionsTreeByCreationOrder.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied custom functions
	
	Sort the Custom Function Tree into creation order recursively.
	
	===== CHANGES HISTORY =====
	2026-05-21 @mrwatson-de: Version 1.1 renamed and updated to support FM22 Folders
	2026-05-21 @mrwatson-de: Version 1.0.1 Typo in file name
	2025-08-15 @mrwatson-de: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== PARAMS ===== -->
	<!-- ===== TEMPLATES ===== -->
	<!-- Output group and sort contents into creation order recursively -->
	<xsl:template match="fmxmlsnippet | Group">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates select="CustomFunction | Group">
				<xsl:sort select="@id" data-type="number"/>
			</xsl:apply-templates>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
