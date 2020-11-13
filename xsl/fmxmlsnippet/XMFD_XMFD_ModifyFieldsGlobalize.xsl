<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMFD_XMFD_ModifyFieldsGlobalize.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied field or table definitions
	
	Sets global='True' for each field.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2015-06-01 MrW: Version 1.1 Now it actually works!
	2013-09-09 MrW: Clone templates centralized in _inc/inc.Clone.xsl
	2013-06-05 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- @global -->
	<xsl:template match="Field/Storage/@global[.='False']">
		<xsl:attribute name="global">
			<xsl:value-of select="'True'"/>
		</xsl:attribute>
	</xsl:template>
</xsl:stylesheet>
