<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMFD_XMFD_ModifyFieldsStripToBareFields.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied field or table definitions
	
	Returns just the Normal fields without AutoEnter or Validation information. Calculation, Summary and global fields are removed.
	
	===== CHANGES HISTORY =====
	2015-06-01 MrW: Version 1.0.1 renamed to be more consistent
	2013-09-09 MrW: Clone templates centralized in _inc/inc.Clone.xsl
	2011-08-10 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Remove Calculated and Summary fields  -->
	<xsl:template match="Field[@fieldType='Calculated']|Field[@fieldType='Summary']"/>
	<!-- Remove Global fields  -->
	<xsl:template match="Field[Storage/@global='True']"/>
	<!-- From remaining "Normal" fields remove automatic -->
	<xsl:template match="AutoEnter|Validation"/>
</xsl:stylesheet>
