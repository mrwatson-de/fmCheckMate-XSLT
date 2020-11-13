<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: inc.XML2_fmCM_ReportObjectsFloatingOverContainers.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	Include file in a layout analysis to report objects floating over containers.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
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
	<!-- XML2_fmCM_ReportObjectsFloatingOverContainers
	 !
	 ! The condition is that an object at level T may not have 
	 ! coordinates inside another container-object at level T.
	 ! 
	 !-->
	<xsl:template name="XML2_fmCM_ReportObjectsFloatingOverContainers">
		<xsl:param name="ErrorLevel" select="$K_FMCM_WARNING"/>
		<!-- -->
		<xsl:variable name="Event" select="'Floating Object (Over Container)'"/>
		<xsl:variable name="Result">
			<xsl:for-each select="//Object[@type='Portal' or @type='SlideControl' or @type='TabControl']">
				<xsl:variable name="left" select="number(Bounds/@left)"/>
				<xsl:variable name="top" select="number(Bounds/@top)"/>
				<xsl:variable name="right" select="number(Bounds/@right)"/>
				<xsl:variable name="bottom" select="number(Bounds/@bottom)"/>
				<xsl:variable name="container">
					<xsl:apply-templates select="." mode="toString"/>
				</xsl:variable>
				<xsl:for-each select="following-sibling::Object">
					<xsl:if test="number(Bounds/@left) &gt;= $left and number(Bounds/@top) &gt;= $top and number(Bounds/@right) &lt;= $right and number(Bounds/@bottom) &lt;= $bottom">
						<xsl:call-template name="fmCM.Results.writeResultForCurrentNode">
							<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
							<xsl:with-param name="Event" select="$Event"/>
							<xsl:with-param name="Result">
								<xsl:apply-templates select="." mode="toString"/>
								<xsl:value-of select="' is FLOATING IN FRONT OF container '"/>
								<xsl:value-of select="$container"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:for-each>
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
