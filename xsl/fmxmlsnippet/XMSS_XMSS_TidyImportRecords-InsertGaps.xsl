<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_TidyImportRecords-InsertGaps.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Inserts gaps by moving all non-imported fields to the end of the import list.

	===== CHANGES HISTORY =====
	2017-01-18 MrW: Version 1.1 Sort the fields at the end!
	2017-01-17 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Modify the Import Records > TargetFields element -->
	<xsl:template match="Step[@id='35']/TargetFields">
		<xsl:copy>
			<!-- Go remove unmapped fields -->
			<xsl:apply-templates select="*"/>
			<!-- 
			 ! Then add the removed fields at the end ... -->
			<xsl:for-each select="Field[@map='DoNotImport' and @name!='']">
				<!-- ... SORTED! -->
				<xsl:sort select="@name"/>
				<!-- -->
				<xsl:copy-of select="."/>
			</xsl:for-each>
		</xsl:copy>
	</xsl:template>
	<!-- Remove unmapped field reference, but only if it is acting as placeholder -->
	<xsl:template match="Field[@map='DoNotImport']">
		<!-- i.e. only IFF there is a mapped field following it -->
		<xsl:if test="following-sibling::Field[@map='Import']">
			<Field map="DoNotImport" id="0" name=""/>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
