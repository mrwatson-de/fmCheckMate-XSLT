<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMFD_XMFD_SelectFieldsForXmlImport.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied field or table definitions
	
	Selects only fields which can be imported per XML, or in other words,
	it removes all calculated, summary and container fields.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2016-12-19 MrW: Version 1.1 Name changed for easier XSLT tree search
	2013-09-09 MrW: Clone templates centralized in _inc/inc.Clone.xsl
	2013-05-15 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Remove all calculated, summary and container fields  -->
	<xsl:template match="//Field[not(ancestor::Field) and (@fieldType='Calculated' or @fieldType='Summary' or @dataType='Binary')]"/>
</xsl:stylesheet>
