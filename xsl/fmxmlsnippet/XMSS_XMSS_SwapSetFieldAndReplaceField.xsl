<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_SwapSetFieldAndReplaceField.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Converts Replace Field Contents X = Y into Set Field X = Y and vice-versa.

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020	
	2013-09-09 MrW: Clone templates centralized in _inc/inc.Clone.xsl
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Script step 91. Replace Field Contents-->
	<xsl:template match="//Step[@id='91']">
		<!-- convert to Set Field step -->
		<xsl:variable name="enable" select="@enable"/>
		<!--  -->
		<Step enable="{$enable}" id="76">
			<xsl:copy-of select="Calculation"/>
			<xsl:copy-of select="Field"/>
			<xsl:copy-of select="Repetition"/>
		</Step>
	</xsl:template>
	<!-- Script step 76 Set Field -->
	<xsl:template match="//Step[@id='76']">
		<!-- convert to Replace Field Contents step -->
		<xsl:variable name="enable" select="@enable"/>
		<!--  -->
		<Step enable="{$enable}" id="91" name="">
			<NoInteract state="True"/>
			<With value="Calculation"/>
			<xsl:copy-of select="Calculation"/>
			<SerialNumbers UpdateEntryOptions="False" UseEntryOptions="True"/>
			<xsl:copy-of select="Field"/>
			<xsl:copy-of select="Repetition"/>
		</Step>
	</xsl:template>
</xsl:stylesheet>
