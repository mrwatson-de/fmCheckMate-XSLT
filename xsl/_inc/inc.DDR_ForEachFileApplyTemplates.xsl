<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: inc.DDR_ForEachFileApplyTemplates.xsl

	XML-Source: Summary.xml
	XML-Grammar: FMPReport
	XML-Content: DDR Summary (Database Definition Report)
	
	Include this XSLT inc file into your XSLT to apply the XSLT on a DDR Summary file.
	
	===== CHANGES HISTORY =====
	2017-03-31 MrW: Version 1.0 Using document(@link) :-)
	-->
	<!-- ===== TEMPLATES ===== -->
	<!-- If we are transforming a Summary file apply templates to each linked file -->
	<xsl:template match="/FMPReport[@type='Summary']">
		<xsl:for-each select="document(File/@link)">
			<xsl:apply-templates/>
		</xsl:for-each>
	</xsl:template>
	<!--xsl:template match="FMPReport[@type='Summary']">
		<xsl:apply-templates match="document(File/@link)"/>
	</xsl:template-->
</xsl:stylesheet>
