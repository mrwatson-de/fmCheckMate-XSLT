<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2018 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XML2_XML2_OverwriteButtonStepsFromIddr.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied fmp12 layout objects
	
	Overwrites any button steps in the layout objects with the successive steps
	stored in the iDDR file (xml/iDDR/XMSS_fmxmlsnippet.xml)

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2018
	2018-10-25 MrW Version 1.0
	
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<!-- ===== PARAMETER ===== -->
	<xsl:param name="removeStep" select="true()"/>
	<!-- ===== TEMPLATES ===== -->
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!--<xsl:template match="*[count(node())=0]">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
		</xsl:copy>
	</xsl:template>
	<!-\- match and copy every node...and continue processing recursively -\->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>-->
	
	<!-- Replace the nth Step in the layout objects with the nth step in the iDDR-->
	<xsl:template match="Step" priority="1">
		<xsl:variable name="pos" select="1+count(preceding::Step)"/>
		<xsl:choose>
			<xsl:when test="document('../../../fmCheckMate/xml/iDDR/XMSS_fmxmlsnippet.xml')//Step[$pos]">
				<!-- Replace with the nth step, if it exists-->
				<xsl:copy-of select="document('../../../fmCheckMate/xml/iDDR/XMSS_fmxmlsnippet.xml')//Step[$pos]"/>
			</xsl:when>
			<xsl:when test="$removeStep">
				<!-- Remove step -->
			</xsl:when>
			<xsl:otherwise>
				<!-- leave as is -->
				<xsl:copy-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
</xsl:stylesheet>
