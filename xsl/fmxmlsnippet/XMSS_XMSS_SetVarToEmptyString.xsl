<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2014 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_SetVarToEmptyString.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps - with SetVar X = Field Y
	
	Converts SetVar X = Field Y into Set Var Y = Field Y.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2011-2014
	2015-07-11 RW: 
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Set Variable -->
	<xsl:template match="//Step[@id='141']/Value/Calculation">
		<xsl:copy>
			<xsl:value-of select="concat($QUOT,$QUOT)"/>
		</xsl:copy>
	</xsl:template>
	<!-- Set Field -->
	<xsl:template match="//Step[@id='76']/Calculation">
		<xsl:copy>
			<xsl:value-of select="concat($QUOT,$QUOT)"/>
		</xsl:copy>
	</xsl:template>
	<!-- Set Field by Name-->
	<xsl:template match="//Step[@id='147']/Result/Calculation">
		<xsl:copy>
			<xsl:value-of select="concat($QUOT,$QUOT)"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
