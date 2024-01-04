<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMFN_fmCM_AnalyseFunctions.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied custom functions
	
	Performs an analysis and creates an FMPXMLRESULT data set to import into fmCheckMate.
	
	===== CHANGES HISTORY =====
	2018-05-17 MrW: Version 2.0 Renamed to clearer verb + noun, and corrected analysis of duplicated functions
	2016-03-13 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<!-- Include standard reports-->
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XMFN_fmCM_FunctionAnalysis.xsl"/>
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
					<xsl:call-template name="XMFN_fmCM_ReportFIXMEs">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<xsl:call-template name="XMFN_fmCM_ReportBrokenCalculationCommentedOut">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<xsl:call-template name="XMFN_fmCM_ReportBrokenCalculationFunctionMissing">
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
					<!-- -->
					<xsl:call-template name="XMFN_fmCM_ReportCopiedFunctionNames">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
				</xsl:if>
				<!--
				 ! 
				 ! 
				 ! OFF
				 ! 
				 ! 
				 !-->
				<xsl:if test="false()">
					<xsl:variable name="ErrorLevel" select="$K_FMCM_WARNING"/>
					<!-- -->
					<!-- unimportant -->
				</xsl:if>
			</RESULTSET>
		</FMPXMLRESULT>
	</xsl:template>
</xsl:stylesheet>
