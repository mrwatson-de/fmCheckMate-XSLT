<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMFD_XMFD_ChangeAllFieldsToBareFields.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied field or table definitions
	
	Converts all fields to Normal fields without AutoEnter, Validation etc.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2018
	2020-04-02 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- For each field output a minimal field-definition  -->
	<xsl:template match="Field">
		<xsl:copy select=".">
			<xsl:attribute name="id">
				<xsl:value-of select="@id"/>
			</xsl:attribute>
			<xsl:attribute name="name">
				<xsl:value-of select="@name"/>
			</xsl:attribute>
			<xsl:attribute name="dataType">
				<xsl:value-of select="@dataType"/>
			</xsl:attribute>
			<xsl:attribute name="fieldType">
				<xsl:value-of select="'Normal'"/>
			</xsl:attribute>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
