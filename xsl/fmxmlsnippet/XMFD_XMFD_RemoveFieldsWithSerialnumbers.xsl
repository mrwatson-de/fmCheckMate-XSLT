<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====
	
	XSL-File: XMFD_XMFD_RemoveFieldsWithSerialnumbers.xsl
	
	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied field or table definitions
	
	Removes all Fields that have serial numbers
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2018-05-11 MrW: Renamed the file to mirror the function -> REMOVE!
	2013-09-09 MrW: Clone templates centralized in _inc/inc.Clone.xsl
	2013-05-15 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Remove all fields with serial numbers -->
	<xsl:template match="Field[AutoEnter/Serial]"/>

</xsl:stylesheet>
