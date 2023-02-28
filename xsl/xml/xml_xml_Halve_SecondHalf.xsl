<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2023 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: xml_xml_Halve_FirstHalf.xsl

	XML-Source: any
	XML-Grammar: any
	XML-Content: any
	
	Keep the second half of the XML.
	
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2023
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
		<xsl:if test="$pos+$pos &gt; $count+1">
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