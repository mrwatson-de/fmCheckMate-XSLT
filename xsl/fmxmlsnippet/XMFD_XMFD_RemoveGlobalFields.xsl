<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMFD_XMFD_RemoveGlobalFields.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied field or table definitions
	
	Returns just the Global fields (removes all non-Global fields).
	
	===== CHANGES HISTORY =====
	2013-09-09 MrW: Clone templates centralized in _inc/inc.Clone.xsl
	2011-08-10 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Remove all Global fields  -->
	<xsl:template match="Field[Storage/@global='True']"/>
	<!-- otherwise clone the document... -->
</xsl:stylesheet>
