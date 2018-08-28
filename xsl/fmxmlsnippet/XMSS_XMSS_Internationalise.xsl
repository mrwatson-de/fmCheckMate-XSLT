<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_Internationalise.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied filemaker script or script step objects

	Makes an exact copy of everything - except for the NAME of the script step, which is removed.
	
	IMPORTANT: 
	    This xslt DOESN'T change function names used in calculations.
	    It can thus only be used on ENGLISH scripts to create a script that you can paste into a NON-ENGLISH FileMaker 

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2011-2016
	2013-09-09 MrW: Clone templates centralized in _inc/inc.Clone.xsl
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Step name - DON'T COPY -->
	<xsl:template match="//Step/@name"/>
</xsl:stylesheet>
