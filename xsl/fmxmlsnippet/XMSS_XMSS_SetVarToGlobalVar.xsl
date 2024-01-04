<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_SetVarToGlobalVar.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps - with Set Var
	
	Converts SetVar $X = <Whatever> into Set Var $X = $$X.
	
	===== CHANGES HISTORY =====
	2016-10-12 RW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Set Variable -->
	<xsl:template match="//Step[@id='141']/Value/Calculation">
		<xsl:copy>
			<xsl:value-of select="concat('$',ancestor::Step/Name)"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
