<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: xsl_xsl_SetParameters.xsl

	XML-Source: any.xsl
	XML-Grammar: xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	XML-Content: any xslt stylesheet
	
	Replaces global xsl:param tags within the stylesheet.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2016
	2016-10-05 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<xsl:param name="PARAMNAME" select="'default'"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Replace each global parameter with its value -->
	<xsl:template match="/*/xsl:param[@name='PARAMNAME']">
		<!-- copy the param element -->
		<xsl:element name="param" namespace="xsl">
			<!-- add all but the select attribute -->
			<xsl:apply-templates select="@*[name()!='select']"/>
			<!-- add the parameter value -->
			<xsl:text disable-output-escaping="yes"><![CDATA[PARAMVALUE]]></xsl:text>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
