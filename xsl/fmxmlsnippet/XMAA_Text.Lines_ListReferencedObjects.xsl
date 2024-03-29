<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMAA_Text.Lines_ListReferencedObjects.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: any FileMaker Clipboard content
	
	Returns a list of all referenced objects.
	
	===== CHANGES HISTORY =====
	2013-09-13 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XMAA_Text.Lines_ListReferencedObjects.xsl"/>
	<!-- ===== PARAMETERS ===== -->
	<xsl:param name="withHeadings" select="'False'"/>
	<xsl:param name="withCustomFunctions" select="'False'"/>
</xsl:stylesheet>
