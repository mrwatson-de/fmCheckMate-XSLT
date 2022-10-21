<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_SwapIfAndElseIf.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	If ( condition ) steps are converted to Else If ( condition ) and vice versa
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2022
	2022-04-23 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Convert if to else if -->
	<xsl:template match="Step[@id='68' or @id='125']">
		<xsl:variable name="enable" select="@enable"/>
		<xsl:variable name="id" select="68 + 125 - @id"/>
		<!--  -->
		<Step enable="{$enable}" id="{$id}" name="">
			<xsl:copy-of select="Calculation"/>
		</Step>
	</xsl:template>
</xsl:stylesheet>
