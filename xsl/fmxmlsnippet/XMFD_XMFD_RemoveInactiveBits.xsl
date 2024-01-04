<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMFD_XMFD_RemoveInactiveBits.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied field or table definitions
	
	Removes all the bits of field definitions that are not active.
	
	===== CHANGES HISTORY =====
	2013-09-09 MrW: Clone templates centralized in _inc/inc.Clone.xsl
	2012-08-16 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Remove unused Comment blocks -->
	<xsl:template match="//Field/Comment[not(text())]"/>
	<!-- Remove unused AutoEnter blocks -->
	<xsl:template match="//Field/AutoEnter[@constant!='True' and @furigana!='True' and @lookup!='True' and @calculation!='True']"/>
	<!-- Remove unused (AutoEnter) Calculation  -->
	<xsl:template match="//Calculation[../@calculation!='True']"/>
	<!-- Remove unused (AutoEnter) Lookup  -->
	<xsl:template match="//Lookup[../@lookup!='True']"/>
	<!-- Remove unused (AutoEnter) ConstantData  -->
	<xsl:template match="//ConstantData[../@constant!='True']"/>
	<!-- Remove unused Validation blocks -->
	<xsl:template match="//Field/Validation[@maxLength!='True' and @valuelist!='True' and @calculation!='True' and NotEmpty/@value!='True' and Unique/@value!='True' and Existing/@value!='True' and NotEmpty/@value!='True'and not(Range) and not(StrictDataType)]"/>
	<!-- Remove unused Validation NotEmpty -->
	<xsl:template match="//Field/Validation/NotEmpty[@value!='True']"/>
	<!-- Remove unused Validation Unique -->
	<xsl:template match="//Field/Validation/Unique[@value!='True']"/>
	<!-- Remove unused Validation Existing -->
	<xsl:template match="//Field/Validation/Existing[@value!='True']"/>
	<!-- Remove unused Validation ValueList -->
	<xsl:template match="//Field/Validation/ValueList[../@valuelist!='True']"/>
	<!-- Remove unused Validation StrictValidation -->
	<xsl:template match="//Field/Validation/StrictValidation[@value!='True']"/>
</xsl:stylesheet>
