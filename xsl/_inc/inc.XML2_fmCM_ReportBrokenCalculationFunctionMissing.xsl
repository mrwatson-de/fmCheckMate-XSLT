<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: inc.XML2_fmCM_ReportBrokenCalculationFunctionMissing.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	Include file in a layout analysis to report broken calculations with call to a missing function.
	
	===== CHANGES HISTORY =====
	2016-01-04 MrW: Version 1.0
	-->
	<!-- ===== NEEDS ===== -->
	<!--
		<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
		<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fn.toString.xsl"/>
		<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.GetAbsoluteBounds.xsl"/>
		<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.GetXpath.xsl"/>
		<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.fmCM_Results.xsl"/>
	-->
	<!-- ===== TEMPLATES ===== -->
	<!-- XML2_fmCM_ReportBrokenCalculationCommentedOut -->
	<xsl:template name="XML2_fmCM_ReportBrokenCalculationFunctionMissing">
		<xsl:param name="ErrorLevel" select="$K_FMCM_ERROR"/>
		<!-- -->
		<xsl:variable name="Event" select="'Broken Calculation (&lt;Function Missing&gt;)'"/>
		<xsl:variable name="Result">
			<xsl:for-each select="//Calculation[contains(.,'&lt;Function Missing&gt;')]">
				<xsl:variable name="ParentElementName" select="name(parent::*)"/>
				<!-- -->
				<xsl:call-template name="fmCM.Results.writeResultForCurrentNode">
					<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					<xsl:with-param name="Event" select="$Event"/>
					<xsl:with-param name="Result">
						<xsl:apply-templates select="ancestor::Object[1]" mode="toString"/>
						<xsl:value-of select="concat(' has a ',$QUOT,$ParentElementName,$QUOT,' calculation with a &lt;Function Missing&gt;: ')"/>
						<xsl:value-of select="."/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:variable>
		<!-- Output Title -->
		<xsl:call-template name="fmCM.Results.writeResult">
			<xsl:with-param name="ErrorLevel" select="$K_FMCM_INFO"/>
			<xsl:with-param name="Event" select="'Analysis'"/>
			<xsl:with-param name="Result" select="$Event"/>
		</xsl:call-template>
		<!-- Output Results -->
		<xsl:copy-of select="$Result"/>
	</xsl:template>
</xsl:stylesheet>
