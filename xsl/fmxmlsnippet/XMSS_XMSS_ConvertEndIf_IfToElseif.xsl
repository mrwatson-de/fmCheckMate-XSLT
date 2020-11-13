<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_ConvertEndIf_IfToElseif.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Replaces 
	    End (if)
	    If ( condition ) steps are converted to Else If ( condition ), 
	with
	    Else if ( condition ) steps are converted to If ( condition ).
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2014-08-29 MrW: Corrected the bug
	2013-09-09 MrW: Clone templates centralized in _inc/inc.Clone.xsl
	2012-06-11 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Remove an End (if)  if followed by an if-->
	<xsl:template match="//Step[@id='70' and following-sibling::Step/@id='68']"/>
	
	<!-- Convert if (if preceded by an End (if)) to Else if-->
	<xsl:template match="//Step[@id='68' and preceding-sibling::Step/@id='70']">
		<xsl:variable name="enable" select="@enable"/>
		<!--  -->
		<Step enable="{$enable}" id="125" name="">
			<xsl:copy-of select="Calculation"/>
		</Step>
	</xsl:template>
</xsl:stylesheet>
