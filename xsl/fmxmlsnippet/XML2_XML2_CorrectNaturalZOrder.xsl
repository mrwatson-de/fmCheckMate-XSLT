<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!--
	===== AUTHOR =====
	
	(c) 2024 @mrwatson-de
	
	===== PURPOSE =====
	
	XSL-File: XML2_XML2_CorrectNaturalZOrder.xsl
	
	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	Orders objects naturally from back to front with top-left at the back and bottom-right at the front.

	===== CHANGES HISTORY =====
	2019-02-16 MrW: Version 0.1
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Output objects in the Layout ordered by top and left -->
	<xsl:template match="/*/Layout">
		<xsl:copy>
			<xsl:apply-templates select="@*" />
			<!--  -->
			<xsl:for-each select="Object">
				<xsl:sort select="number(Bounds/@top) * 1000000 + number(Bounds/@left)" data-type="number" />
				<xsl:apply-templates select="." />
			</xsl:for-each>
		</xsl:copy>
	</xsl:template>
	<!-- match and copy every node...and continue processing recursively -->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
