<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XML2_XML2_ReplicateButtonbarButtonStep1.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied fmp12 layout objects
	
	Replicates button 1's step throughout a button bar, leaving button text etc. as is.

	===== CHANGES HISTORY =====
	2018-10-26 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"
		cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Match any button ('s ButtonObj) in a buttonbar - except the first-->
	<xsl:template match="ButtonBarObj/Object[position() &gt; 1]/ButtonObj">
		<!-- Output the object, adding (or replacing its Step with) the step from button 1 -->
		<xsl:copy>
			<!-- Copy object, attributes and all elements but not the Step-->
			<xsl:apply-templates select="@*|*[name()!='Step']"/>
			<!-- Add the Step from Button 1 -->
			<xsl:copy-of select="../../Object[1]/ButtonObj/Step"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
