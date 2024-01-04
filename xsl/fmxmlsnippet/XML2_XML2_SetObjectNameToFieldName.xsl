<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XML2_XML2_SetObjectNameToFieldName.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied fmp12 layout objects
	
	Sets the name of the field object to the name of the field (without the table name)

	===== CHANGES HISTORY =====
	20150417 MrW v1
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- remove LocalCSS tag -->
	<xsl:template match="Object[@type='Field']/@name">
		<xsl:attribute name="name"><xsl:value-of select="../FieldObj/Name/text()"/></xsl:attribute>
	</xsl:template>
</xsl:stylesheet>
