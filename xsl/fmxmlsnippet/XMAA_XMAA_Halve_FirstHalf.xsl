<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMAA_XMAA_Halve_FirstHalf.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet.xml
	XML-Content: copied filemaker objects
	
	Keep the first half of the filemaker objects.
	
	
	===== CHANGES HISTORY =====
	2023-03-27 RW: Version 0.2 Ignore Layout objects' wrapping Layout element
	2023-02-14 RW: Version 0.1 Happy Valentines Day, Alexa!
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no" omit-xml-declaration="no"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="count" select="count( /*/*[not(self::Layout)]|/*/Layout/* )"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Ignore half the elements-->
	<xsl:template match="/*/*[not(self::Layout)]|/*/Layout/*">
		<xsl:variable name="pos" select="1+count(preceding-sibling::*)"/>
		<xsl:if test="2*$pos &lt;= $count+1">
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