<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2022 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XML2_XML2_CorrectZ-Order.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied fmp12 layout objects
	
	Corrects the z-order based on the position Left -> Right & Top->Bottom

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2022
	20220204 MrW v0.1
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Sort all ojects on the same level -->
	<xsl:template match="*[Object/Bounds]">
		<!-- Copy the container & attributes -->
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<!-- Copy non-Object children (e.g. PopoverButtonObj Streams) -->
			<xsl:apply-templates select="*[not(self::Object)]"/>
			<!-- Copy Object children SORTED by y and x -->
			<xsl:for-each select="Object">
				<xsl:sort select="number(Bounds/@top)" data-type="number"/>
				<xsl:sort select="number(Bounds/@left)" data-type="number"/>
				<xsl:apply-templates select="."/>
			</xsl:for-each>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
