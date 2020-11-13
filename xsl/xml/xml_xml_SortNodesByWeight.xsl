<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:math="http://exslt.org/math" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" extension-element-prefixes="math" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: xml_xml_SortNodesByWeight.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: any
	
	Sorts the nodes by weight, where weight = Count of nodes contained + Length of all data
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2014-06-25 MrW: Version 1.0.1 Comment corrected
	2011-08-10 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- copy node sorting contents-->
	<xsl:template match="*">
		<!-- node -->
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<!--
			 ! sort nodes
			 !-->
			<xsl:apply-templates select="*|text()">
				<xsl:sort select="count(@*) + count(descendant::*) + string-length(.)" order="descending" data-type="number"/>
				<!-- -->
			</xsl:apply-templates>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
