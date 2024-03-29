<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: xml_xml_Halve_FirstHalf.xsl

	XML-Source: any
	XML-Grammar: any
	XML-Content: any
	
	Keep the first half of the XML.
	
	
	===== CHANGES HISTORY =====
	2023-02-14 RW: Version 0.1 Happy Valentines Day, Alexa!
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no" omit-xml-declaration="no"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="count" select="count( /*/* )"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Ignore half the elements-->
	<xsl:template match="/*/*">
		<xsl:variable name="pos" select="1+count(preceding-sibling::*)"/>
		<xsl:if test="$pos+$pos &lt;= $count+1">
			<xsl:copy-of select="."/>
		</xsl:if>
	</xsl:template>
	<!--
	===== CLONE EVERYTHING ELSE =====
	-->
	<!--
		match and copy every node...and continue processing recursively, but
		with a low priority, so that other (normal-priority) templates are applied first
	-->
	<xsl:template match="@*|node()" priority="-9">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>