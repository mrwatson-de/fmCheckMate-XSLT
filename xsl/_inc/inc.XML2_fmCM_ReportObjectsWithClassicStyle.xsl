<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: inc.XML2_fmCM_ReportObjectsWithClassicStyle.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	Include file to report objects which have classic style.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2016-01-22 MrW: Version 1.0
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
	<!-- XML2_fmCM_ReportObjectsFloatingOverContainers
	 !
	 !-->
	<xsl:template name="XML2_fmCM_ReportObjectsWithClassicStyle">
		<xsl:param name="ErrorLevel" select="$K_FMCM_WARNING"/>
		<!-- -->
		<xsl:variable name="Event" select="'Object with classic style'"/>
		<xsl:variable name="Result">
			<xsl:for-each select="//Object[*/Styles/ThemeName='com.filemaker.theme.classic']">
						<xsl:call-template name="fmCM.Results.writeResultForCurrentNode">
							<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
							<xsl:with-param name="Event" select="$Event"/>
							<xsl:with-param name="Result">
								<xsl:apply-templates select="." mode="toString"/>
								<xsl:value-of select="' has classic style'"/>
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
