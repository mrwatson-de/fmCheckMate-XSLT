<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_SetFieldToEmpty.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Changes Set Field X = Y to Set Field X = ""
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2015-06-01 MrW: v1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Script step 76 Set Field -->
	<xsl:template match="//Step[@id='76']/Calculation/text()">
			<xsl:value-of select="concat($QUOT,$QUOT)"/>
	</xsl:template>
	<!-- Script step 147 Set Field by Name -->
	<xsl:template match="//Step[@id='147']/Result/Calculation/text()">
			<xsl:value-of select="concat($QUOT,$QUOT)"/>
	</xsl:template>
</xsl:stylesheet>
