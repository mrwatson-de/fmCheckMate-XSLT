<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: inc.XML2_fmCM_ReportBrokenCalculationCommentedOut.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	Include file in a layout analysis to report broken commented out calculations.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2016
	2015-11-23 MrW: Version 1.1 Refactored as include file
	2015-09-12 MrW: Version 1.0
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
	<xsl:template name="XML2_fmCM_ReportBrokenCalculationCommentedOut">
		<xsl:param name="ErrorLevel" select="$K_FMCM_ERROR"/>
		<!-- -->
		<xsl:variable name="Event" select="'Broken Calculation /*Commented Out*/'"/>
		<xsl:variable name="Result">
			<xsl:for-each select="//Calculation[substring(.,1,2)='/*' and substring(.,string-length(.) - 1)='*/']">
				<xsl:variable name="ParentElementName" select="name(parent::*)"/>
				<!-- -->
				<xsl:call-template name="fmCM.Results.writeResultForCurrentNode">
					<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					<xsl:with-param name="Event" select="$Event"/>
					<xsl:with-param name="Result">
						<xsl:apply-templates select="ancestor::Object[1]|ancestor::CustomFunction" mode="toString"/>
						<xsl:value-of select="concat(' has a ',$QUOT,$ParentElementName,$QUOT,' calculation commented out: ')"/>
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
