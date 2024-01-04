<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====
	
	XSL-File: XMFD_XMFD_SelectFieldsWithValidation.xsl
	
	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied field or table definitions
	
	Selects all Fields that have auto enter 
	
	===== CHANGES HISTORY =====
	2013-09-09 MrW: Clone templates centralized in _inc/inc.Clone.xsl
	2011-11-01 MrW: Corrected to return xml output
	2011-08-10 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Remove all Fields with NO validation -->
	<xsl:template match="Field[AutoEnter/@value!='ModificationDate' and
		                   AutoEnter/@value!='ModificationTime' and
		                   AutoEnter/@value!='ModificationTimeStamp' and
		                   AutoEnter/@value!='ModificationName' and
		                   AutoEnter/@value!='ModificationAccountName' and
		                   AutoEnter/@value!='CreationDate' and
		                   AutoEnter/@value!='CreationTime' and
		                   AutoEnter/@value!='CreationTimeStamp' and
		                   AutoEnter/@value!='CreationName' and
		                   AutoEnter/@value!='CreationAccountName' and
		                   AutoEnter/Serial and
		                   AutoEnter/@lookup!='True' and
		                   AutoEnter/@constant!='True' and
		                   AutoEnter/@calculation!='True']"/>
</xsl:stylesheet>
