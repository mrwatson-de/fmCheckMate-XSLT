<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: fn.StringFunctions.xsl

	XML-Source: any.xml
	XML-Grammar: any
	XML-Content: any

	Functions for processing strings.

	===== CHANGES HISTORY =====
	2013-12-09 MrW Quickfix for problem in fmCheckMate "Load XSLT" function
	2013-06-25 MrW Added fn.Filter
	2011-01-13 MrW: Version 1.0
	-->
	<!-- ===== INCLUDES ===== -->
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.Substitute.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.Quote.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.SubstringFunctions.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.PathFunctions.xsl"/>
</xsl:stylesheet>
