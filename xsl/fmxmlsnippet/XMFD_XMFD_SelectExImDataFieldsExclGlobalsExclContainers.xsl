<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2021 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMFD_XMFD_SelectExImDataFieldsExclGlobalsExclContainers.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied field or table definitions
	
	Selects all normal (i.e. non-calculation and non-summary), non-global, non-container fields,
	that is, the ones that you usually want to export and/or import stored data in non-fmp format.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2021
	2021-08-15 MrW: Version 1.0 At last a function with a clear name :-) - almost exactly 10 years after making the (unclearly named/documented) original functions
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Remove all non-normal fields  -->
	<xsl:template match="Field[@fieldType!='Normal' or @global='True' or @dataType='Container']"/>
</xsl:stylesheet>
