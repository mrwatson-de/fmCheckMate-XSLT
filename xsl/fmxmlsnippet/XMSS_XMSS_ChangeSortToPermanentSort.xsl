<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_ChangeSortToPermanentSort.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied script-steps
	
	Enables the Sort dialog "Keep Sort Order" Option.
	
	===== CHANGES HISTORY =====
	2019-10-09 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Sort Records -->
	<xsl:template match="Step[@id=39]/SortList/@Maintain[.='False']">
		<xsl:attribute name="Maintain">
			<xsl:value-of select="'True'"/>
		</xsl:attribute>
	</xsl:template>
</xsl:stylesheet>
