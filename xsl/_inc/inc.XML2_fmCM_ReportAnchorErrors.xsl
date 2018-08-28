<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: inc.XML2_fmCM_ReportAnchorErrors.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	Include file in a layout analysis to report anchor errors.
	
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
	<xsl:template name="XML2_fmCM_ReportAnchorErrors">
		<xsl:param name="ErrorLevel" select="$K_FMCM_WARNING"/>
		<!-- -->
		<xsl:variable name="Event" select="'Problem Anchor'"/>
		<xsl:variable name="Result">
			<xsl:variable name="bitDontAnchorLeft" select="268435456"/>
			<xsl:variable name="bitDontAnchorTop" select="536870912"/>
			<xsl:variable name="bitAnchorRight" select="1073741824"/>
			<xsl:variable name="bitAnchorBottom" select="2147483648"/>
			<!-- -->
			<!-- HOW TO REPORT ANCHORTING
			<xsl:for-each select="//Object">
			<xsl:call-template name="fmCM.Results.writeResultForCurrentNode">
				<xsl:with-param name="ErrorLevel" select="$K_FMCM_WARNING"/>
				<xsl:with-param name="Event" select="'Anchors'"/>
				<xsl:with-param name="Result">
					<xsl:apply-templates select="." mode="toString"/>
					<xsl:value-of select="' '"/>
					<xsl:value-of select="@flags"/>
					<xsl:value-of select="'='"/>
					<xsl:if test="(floor(@flags div $bitDontAnchorLeft) mod 2)=0">
						<xsl:value-of select="'&lt;'"/>
					</xsl:if>
					<xsl:if test="(floor(@flags div $bitDontAnchorTop) mod 2)=0">
						<xsl:value-of select="'^'"/>
					</xsl:if>
					<xsl:if test="(floor(@flags div $bitAnchorBottom) mod 2)=1">
						<xsl:value-of select="'v'"/>
					</xsl:if>
					<xsl:if test="(floor(@flags div $bitAnchorRight) mod 2)=1">
						<xsl:value-of select="'>'"/>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:for-each-->
			<!--- find horizontal crashes -->
			<!--- find objects ANCHORED LEFT -->
			<xsl:for-each select="//Object[(floor(@flags div $bitDontAnchorLeft) mod 2)=0]">
				<xsl:variable name="left" select="number(Bounds/@left)"/>
				<xsl:variable name="top" select="number(Bounds/@top)"/>
				<xsl:variable name="right" select="number(Bounds/@right)"/>
				<xsl:variable name="bottom" select="number(Bounds/@bottom)"/>
				<xsl:variable name="refObject">
					<xsl:apply-templates select="." mode="toString"/>
				</xsl:variable>
				<!--- find the RIGHTMOST object to its left which is ANCHORED RIGHT -->
				<xsl:for-each select="../Object[(floor(@flags div $bitAnchorRight) mod 2)=1 and number(Bounds/@right) &lt;= $left and number(Bounds/@top) &lt; $bottom and number(Bounds/@bottom) &gt; $top]">
					<xsl:sort select="Bounds/@right" order="ascending" data-type="number" lang="language-code"/>
					<xsl:if test="position()=1">
						<xsl:call-template name="fmCM.Results.writeResultForCurrentNode">
							<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
							<xsl:with-param name="Event" select="$Event"/>
							<xsl:with-param name="Result">
								<xsl:apply-templates select="." mode="toString"/>
								<xsl:value-of select="' crashes right into '"/>
								<xsl:value-of select="$refObject"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:for-each>
			</xsl:for-each>
			<!--- find vertical crashes -->
			<!--- find objects ANCHORED TOP -->
			<xsl:for-each select="//Object[(floor(@flags div $bitDontAnchorTop) mod 2)=0]">
				<xsl:variable name="left" select="number(Bounds/@left)"/>
				<xsl:variable name="top" select="number(Bounds/@top)"/>
				<xsl:variable name="right" select="number(Bounds/@right)"/>
				<xsl:variable name="bottom" select="number(Bounds/@bottom)"/>
				<xsl:variable name="refObject">
					<xsl:apply-templates select="." mode="toString"/>
				</xsl:variable>
				<!--- find the BOTTOMMOST object above it which is ANCHORED BOTTOM -->
				<xsl:for-each select="../Object[(floor(@flags div $bitAnchorBottom) mod 2)=1 and number(Bounds/@bottom) &lt;= $top and number(Bounds/@left) &lt; $right and number(Bounds/@right) &gt; $left]">
					<xsl:sort select="Bounds/@bottom" order="descending" data-type="number" lang="language-code"/>
					<!--xsl:if test="position()=1"-->
					<xsl:call-template name="fmCM.Results.writeResultForCurrentNode">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
						<xsl:with-param name="Event" select="$Event"/>
						<xsl:with-param name="Result">
							<xsl:apply-templates select="." mode="toString"/>
							<xsl:value-of select="' crashes down into '"/>
							<xsl:value-of select="$refObject"/>
						</xsl:with-param>
					</xsl:call-template>
					<!--/xsl:if-->
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
