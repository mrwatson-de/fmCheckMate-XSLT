<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_FixPerformScriptByNameColonBug.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied filemaker script or script step objects

	Prefixes a double colon ("::") to PSBN calls in order to fix the bug caused by calling scripts with a colon in the name
	
	See https://community.filemaker.com/message/800635
	
		===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2018-10-01 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="FILE_SCRIPT_SEPARATOR"><xsl:text>"::"</xsl:text></xsl:variable>
	<!-- ===== TEMPLATES ===== -->
	<!-- Prefix double colon on script name -->
	<xsl:template match="Step[@id='1']/Calculated/Calculation/text()[not( contains(.,'::'))]">
		<xsl:value-of select="concat($FILE_SCRIPT_SEPARATOR,' &amp; ', .)"/>
	</xsl:template>

</xsl:stylesheet>
