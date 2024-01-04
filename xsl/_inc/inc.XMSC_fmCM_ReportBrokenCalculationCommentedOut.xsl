<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: inc.XMSC_fmCM_ReportBrokenCalculationCommentedOut.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied script objects
	
	Include file in a script analysis to report broken commented out calculations.
	
	===== CHANGES HISTORY =====
	2015-11-23 MrW: Version 1.1 Refactored as include file
	2015-09-12 MrW: Version 1.0
	-->
	<!-- ===== NEEDS ===== -->
	<!--
		<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
		<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.GetXpath.xsl"/>
		<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.fmCM_Results_XMSC.xsl"/>
	-->
	<!-- ===== TEMPLATES ===== -->
	<!-- XMSC_fmCM_ReportBrokenCalculationCommentedOut -->
	<xsl:template name="XMSC_fmCM_ReportBrokenCalculationCommentedOut">
		<xsl:param name="ErrorLevel" select="$K_FMCM_ERROR"/>
		<!-- -->
		<xsl:variable name="Event" select="'Broken Calculation /*Commented Out*/'"/>
		<xsl:variable name="Result">
			<xsl:for-each
				select="//Step[not(not(.//Calculation[substring(text(), 1, 2) = '/*' and substring(text(), string-length(.) - 1) = '*/']))]">
				<xsl:variable name="occurenceCount"
					select="count(.//Calculation[substring(text(), 1, 2) = '/*' and substring(text(), string-length(.) - 1) = '*/'])"/>
				<!-- -->
				<xsl:call-template name="fmCM.Results.writeResultForCurrentNode">
					<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					<xsl:with-param name="Event" select="$Event"/>
					<xsl:with-param name="Result">
						<xsl:choose>
							<xsl:when test="$occurenceCount = 1">
								<xsl:value-of select="'Calculation'"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($occurenceCount, ' calculations')"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:value-of select="' commented out in '"/>
						<xsl:apply-templates select="." mode="toString"/>
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
