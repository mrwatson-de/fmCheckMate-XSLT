<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMMI_XMMI_SelectMenuItemsContainingString.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied Menus / MenuItems
	
	Returns just the CustomMenuItems containing the string.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2019
	2019-11-19 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== PARAMS ===== -->
	<xsl:param name="search" select="'G_SY_DynArray'"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Remove custom functions containing the string  -->
	<xsl:template match="CustomMenuItem">
		<xsl:if test="contains(.,$search)">
			<!-- KEEP -->
			<xsl:copy-of select="."/>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
