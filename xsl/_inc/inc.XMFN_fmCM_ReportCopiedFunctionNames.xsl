<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2018 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: inc.XMFN_fmCM_ReportCopiedFunctionNames.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	Include file in a function analysis to report copied/duplicated function names.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2018
	2018-05-17 MrW: Version 2.0 Corrected analysis to find duplicated functions
	2016-03-13 MrW: Version 1.0
	-->
	<!-- ===== NEEDS ===== -->
	<!--
		<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
		<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.GetXpath.xsl"/>
		<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.fmCM_Results_XMFN.xsl"/>
	-->
	<!-- ===== TEMPLATES ===== -->
	<xsl:template name="XMFN_fmCM_ReportCopiedFunctionNames">
		<xsl:param name="ErrorLevel" select="$K_FMCM_WARNING"/>
		<!-- -->
		<xsl:variable name="Event" select="'Copied Function Name'"/>
		<xsl:variable name="Result">
			<xsl:for-each select="//CustomFunction[substring(@name,string-length(@name)-4)=' Copy' or
				substring(@name,string-length(@name)-5)=' Kopie' or
				contains(' 2 3 4 5 6 7 8 9',substring(@name,string-length(@name)-1))]">
				<xsl:call-template name="fmCM.Results.writeResultForCurrentNode">
					<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					<xsl:with-param name="Event" select="$Event"/>
					<xsl:with-param name="Result">
						<xsl:apply-templates select="ancestor::CustomFunction[1]" mode="toString"/>
						<xsl:value-of select="' name is '"/>
						<xsl:value-of select="$QUOT"/>
						<xsl:value-of select="@name"/>
						<xsl:value-of select="$QUOT"/>
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
