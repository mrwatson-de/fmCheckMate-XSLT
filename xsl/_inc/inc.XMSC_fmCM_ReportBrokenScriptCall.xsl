<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: inc.XMSC_fmCM_ReportFIXMEs.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts
	
	Include file in a function analysis to report occurrences of the word FIXME.
	
	===== CHANGES HISTORY =====
	2019-05-27 MrW: Version 1.0
	-->
	<!-- ===== NEEDS ===== -->
	<!--
		<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
		<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.GetXpath.xsl"/>
		<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.fmCM_Results_XMSC.xsl"/>
	-->
	<!-- ===== TEMPLATES ===== -->
	<xsl:template name="XMSC_fmCM_ReportBrokenScriptCall">
		<xsl:param name="ErrorLevel" select="$K_FMCM_ERROR"/>
		<!-- -->
		<xsl:variable name="Event" select="'Broken Script Call'"/>
		<xsl:variable name="Result">
			<xsl:for-each select="//Step//Script[substring(@name,1,1)='&lt;' and substring(@name,string-length(@name))='&gt;']">
				<xsl:call-template name="fmCM.Results.writeResultForCurrentNode">
					<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					<xsl:with-param name="Event" select="$Event"/>
					<xsl:with-param name="Result">
						<xsl:apply-templates select="ancestor::Step[1]" mode="toString"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:variable>
		<!-- -->
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
