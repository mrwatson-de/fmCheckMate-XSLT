<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: FPSL_FPSL_ReplaceSortList.xsl

	XML-Source: any.fmpsl
	XML-Grammar: FPSL
	XML-Content: FileMaker snapshot link XML file
	
	Replaces the SortList
	
	===== CHANGES HISTORY =====
	2023-08-18 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== PARAMS ===== -->
	<xsl:param name="pNewSortOrder">
		<SortList Maintain="True" value="True">
			<Sort type="Descending">
				<PrimaryField>
					<Field tableId="1065089" table="_fmSort" id="6" name="Games"/>
				</PrimaryField>
			</Sort>
			<Sort type="Ascending">
				<PrimaryField>
					<Field tableId="1065089" table="_fmSort" id="5" name="Team"/>
				</PrimaryField>
			</Sort>
			<Sort type="Descending">
				<PrimaryField>
					<Field tableId="1065089" table="_fmSort" id="2" name="Score"/>
				</PrimaryField>
			</Sort>
		</SortList>
	</xsl:param>
	<!-- ===== TEMPLATES ===== -->
	<!-- remove the existing SortList -->
	<xsl:template match="SortList"/>
	<!-- add SortList -->
	<xsl:template match="Mode">
		<xsl:copy-of select="."/>
		<xsl:copy-of select="$pNewSortOrder"/>
	</xsl:template>
</xsl:stylesheet>
