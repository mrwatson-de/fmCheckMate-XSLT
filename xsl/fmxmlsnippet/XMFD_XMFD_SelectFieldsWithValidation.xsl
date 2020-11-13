<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====
	
	XSL-File: XMFD_XMFD_SelectFieldsWithValidation.xsl
	
	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied field or table definitions
	
	Selects all Fields that have validation 
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2013-09-09 MrW: Clone templates centralized in _inc/inc.Clone.xsl
	2011-11-01 MrW: Corrected to return xml output
	2011-08-10 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Remove all Fields with NO validation FIXME!FIXME!FIXME!FIXME!FIXME!FIXME!FIXME!FIXME!FIXME! -->
	<xsl:template match="Field[Validation/@maxLength!='True' and    Validation/@valuelist!='True' and    Validation/@calculation!='True' and    Validation/NotEmpty/@value!='True' and    Validation/Unique/@value!='True' and    Validation/Existing/@value!='True' and    Validation/NotEmpty/@value!='True']"/>
	<!-- and    not(exists(Validation/Range)) and    not(exists(Validation/StrictDataType))-->
</xsl:stylesheet>
