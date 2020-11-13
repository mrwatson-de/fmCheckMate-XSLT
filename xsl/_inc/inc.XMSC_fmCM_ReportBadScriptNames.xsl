<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: inc.XMSC_fmCM_ReportBadScriptNames.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts
	
	Include file in a function analysis to report bad script names.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2019-05-27 MrW: Version 1.0
	-->
	<!-- ===== NEEDS ===== -->
	<!--
		<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
		<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.GetXpath.xsl"/>
		<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.fmCM_Results_XMSC.xsl"/>
	-->
	<!-- ===== TEMPLATES ===== -->
	<xsl:template name="XMSC_fmCM_ReportScriptNamesWithWhiteSpaceAtEnd">
		<xsl:param name="ErrorLevel" select="$K_FMCM_WARNING"/>
		<!-- -->
		<xsl:variable name="Event" select="'Script Name ends in white space'"/>
		<xsl:variable name="Result">
			<xsl:for-each select="//Script[translate(substring(@name,string-length(@name)),'	',' ')=' ']">
				<xsl:call-template name="fmCM.Results.writeResultForCurrentNode">
					<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					<xsl:with-param name="Event" select="$Event"/>
					<xsl:with-param name="Result">
						<xsl:apply-templates select="ancestor::Script[1]" mode="toString"/>
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
	<!--  -->
	<xsl:template name="XMSC_fmCM_ReportScriptsVisibleInMenu">
		<xsl:param name="ErrorLevel" select="$K_FMCM_WARNING"/>
		<!-- -->
		<xsl:variable name="Event" select="'Script is visible in Menu'"/>
		<xsl:variable name="Result">
			<xsl:for-each select="//*[(name()='Group' or name()='Script') and @includeInMenu='True']">
				<xsl:call-template name="fmCM.Results.writeResultForCurrentNode">
					<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					<xsl:with-param name="Event" select="$Event"/>
					<xsl:with-param name="Result">
						<!-- xsl:apply-templates select="ancestor-or-self::Script" mode="toString"/-->
						
						<xsl:value-of select="name()"/>
						<xsl:value-of select="' '"/>
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
