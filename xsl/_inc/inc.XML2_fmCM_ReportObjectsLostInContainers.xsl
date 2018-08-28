<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: inc.XML2_fmCM_ReportObjectsLostInContainers.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	Include file in a layout analysis to report objects which have been lost inside of other container objects (portals, etc.).
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2016
	2016-10-10 MrW: Version 1.4 Now finds lost objects in TabPanels and SlidePanels (previously it had incorrectly looked in TabControls and SlideControls)
	2016-02-19 MrW: Version 1.3 Now also detects objects hidden above and to the left of the container
	2016-01-14 MrW: Version 1.2 Objects hidden behind a portal scroll bar are also considered lost
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
	<!-- XML2_fmCM_ReportObjectsLostInContainers -->
	<xsl:template name="XML2_fmCM_ReportObjectsLostInContainers">
		<xsl:param name="ErrorLevel" select="$K_FMCM_WARNING"/>
		<!-- -->
		<xsl:variable name="Event" select="'Lost Object (In Container)'"/>
		<xsl:variable name="Result">
			<xsl:for-each select="//Object[@type='Portal' or @type='SlidePanel' or @type='TabPanel']">
				<!-- Show scroll bar on portal = 0x0001 -->
				<xsl:variable name="scrollBarVisible" select="@type='Portal' and (PortalObj/@portalFlags mod (2*1))&gt;=1 and not(PortalObj/@scrollBarVisibility=1)"/>
				<xsl:variable name="left" select="number(Bounds/@left)"/>
				<xsl:variable name="top" select="number(Bounds/@top)"/>
				<xsl:variable name="right" select="number(Bounds/@right)"/>
				<xsl:variable name="bottom" select="number(Bounds/@bottom)"/>
				<xsl:variable name="width">
					<xsl:choose>
						<xsl:when test="$scrollBarVisible">
							<!-- Objects behind the scroll bar are also lost -->
							<xsl:value-of select="$right - $left -19"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$right - $left"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="height" select="$bottom - $top"/>
				<xsl:variable name="container">
					<xsl:apply-templates select="." mode="toString"/>
				</xsl:variable>
				<xsl:for-each select="*/Object">
					<xsl:variable name="North" select="number(Bounds/@bottom) &lt;= 0"/>
					<xsl:variable name="South" select="number(Bounds/@top) &gt;= $height"/>
					<xsl:variable name="East" select="number(Bounds/@left) &gt;= $width"/>
					<xsl:variable name="West" select="number(Bounds/@right) &lt;= 0"/>
					<xsl:choose>
						<xsl:when test="$North or $South or $East or $West">
							<!-- Lost object -->
							<xsl:call-template name="fmCM.Results.writeResultForCurrentNode">
								<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
								<xsl:with-param name="Event" select="$Event"/>
								<xsl:with-param name="Result">
									<xsl:apply-templates select="." mode="toString"/>
									<xsl:value-of select="' is lost inside container '"/>
									<xsl:value-of select="$container"/>
									<xsl:value-of select="'. It is out of view to the '"/>
									<xsl:if test="$North">
										<xsl:value-of select="'N'"/>
									</xsl:if>
									<xsl:if test="$South">
										<xsl:value-of select="'S'"/>
									</xsl:if>
									<xsl:if test="$East">
										<xsl:value-of select="'E'"/>
									</xsl:if>
									<xsl:if test="$West">
										<xsl:value-of select="'W'"/>
									</xsl:if>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="false()">
							<!-- debug -->
							<xsl:call-template name="fmCM.Results.writeResultForCurrentNode">
								<xsl:with-param name="ErrorLevel" select="$K_FMCM_DEBUG"/>
								<xsl:with-param name="Event" select="concat('NOT ',$Event)"/>
								<xsl:with-param name="Result">
									<xsl:apply-templates select="." mode="toString"/>
									<xsl:value-of select="', rel. left='"/>
									<xsl:value-of select="number(Bounds/@left)"/>
									<xsl:value-of select="' is NOT lost inside container '"/>
									<xsl:value-of select="$container"/>
									<xsl:value-of select="', width='"/>
									<xsl:value-of select="$width"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
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
