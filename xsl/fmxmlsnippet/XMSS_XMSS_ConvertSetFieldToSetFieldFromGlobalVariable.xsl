<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_ConvertSetFieldToSetFieldFromGlobalVariable.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps - with Set Field X = Calc
	
	Converts Set Field X = Calc to Set Field X = $$X

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2016
	2014-07-04 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== PARAMETER ===== -->
	<xsl:param name="varType" select="'$$'"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Set Field-->
	<xsl:template match="Step[@id='76']">
		<!-- Replace calculation -->
		<xsl:variable name="enable" select="@enable"/>
		<!-- -->
		<Step enable="{$enable}" id="76">
			<Calculation>
				<xsl:value-of select="concat($varType,translate(Field/@name,' ','_'))"/>
			</Calculation>
			<xsl:copy-of select="Field"/>
			<xsl:copy-of select="Repetition"/>
		</Step>
	</xsl:template>
</xsl:stylesheet>
