<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_ConvertIfToElseIf.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	If ( condition ) steps are converted to Else If ( condition )
	
	===== CHANGES HISTORY =====
	2023-09-18 MrW: Version 1.0.1 Documentation corrected
	2013-09-09 MrW: Clone templates centralized in _inc/inc.Clone.xsl
	2012-10-18 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Convert if to else if -->
	<xsl:template match="Step[@id='68']">
		<xsl:variable name="enable" select="@enable"/>
		<!--  -->
		<Step enable="{$enable}" id="125" name="">
			<xsl:copy-of select="Calculation"/>
		</Step>
	</xsl:template>
</xsl:stylesheet>
