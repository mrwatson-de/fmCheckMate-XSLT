<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSC_fmCM_AnalyseScripts.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts
	
	Performs an analysis and creates an FMPXMLRESULT data set to import into fmCheckMate.
	
	===== CHANGES HISTORY =====
	2018-06-04 MrW: Version 1.1 Added check for broken field + table references
	2017-03-19 MrW: Version 1.0.1 Fixed include bug which had crept in.
	2015-09-12 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<!-- Include standard reports-->
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XMSC_fmCM_AnalyseScripts.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!--
	 ! Main
	 !-->
	<xsl:template match="/">
		<FMPXMLRESULT xmlns="http://www.filemaker.com/fmpxmlresult">
			<xsl:call-template name="fmCM.Results.writeHeader"/>
			<RESULTSET FOUND="0">
				<!--
				 ! 
				 ! 
				 ! ERRORS
				 ! 
				 ! 
				 !-->
				<xsl:if test="true()">
					<xsl:variable name="ErrorLevel" select="$K_FMCM_ERROR"/>
					<!-- -->
					<xsl:call-template name="XMSC_fmCM_ReportBrokenScriptCall">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<xsl:call-template name="XMSC_fmCM_ReportBrokenFieldReference">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<xsl:call-template name="XMSC_fmCM_ReportBrokenCalculationCommentedOut">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<xsl:call-template name="XMSC_fmCM_ReportFIXMEs">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
				</xsl:if>
				<!--
				 ! 
				 ! 
				 ! WARNINGS
				 ! 
				 ! 
				 !-->
				<xsl:if test="true()">
					<xsl:variable name="ErrorLevel" select="$K_FMCM_WARNING"/>
					<!-- possible errors -->
					<xsl:call-template name="XMSC_fmCM_ReportScriptNamesWithWhiteSpaceAtEnd">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<xsl:call-template name="XMSC_fmCM_ReportScriptsVisibleInMenu">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<!--xsl:call-template name="XMSC_fmCM_ReportOverloadedScriptNames">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template-->
					

				</xsl:if>
			</RESULTSET>
		</FMPXMLRESULT>
	</xsl:template>
</xsl:stylesheet>
