<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMTH_fmCM_AnalyseTheme.xsl 

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied themes
	
	Analyses themes and prepares an FMPXMLRESULT for import into fmCheckMate.
	
	===== CHANGES HISTORY =====
	2018-09-28 MrW: Version 1.1.1 Added dot to the allowed style name characters.
	2016-09-20 MrW: Version 1.1 Added test for undesirable or mulitple white space in name 
	2015-09-12 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.fmCM_Results.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.GetAbsoluteBounds.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.GetXPath.xsl"/>
	<!--FileMaker seems to have a problem with these functions -->
	<!--xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fn.toString.xsl"/-->
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!--
	 ! Main
	 !-->
	<xsl:template match="/">
		<FMPXMLRESULT xmlns="http://www.filemaker.com/fmpxmlresult">
			<xsl:call-template name="fmCM.Results.writeHeader"/>
			<RESULTSET FOUND="0">
				<!-- errors -->
				<xsl:call-template name="XMTH_fmCM_ReportBadStyleNames"/>
			</RESULTSET>
		</FMPXMLRESULT>
	</xsl:template>
	<!-- - - - - - - - - - - - 
	 !
	 ! ERRORS
	 !
	 ! - - - - - - - - - - - -->
	<!-- XMTH_fmCM_ReportBadStyleNames -->
	<xsl:template name="XMTH_fmCM_ReportBadStyleNames">
		<!-- Var -->
		<xsl:variable name="allowedStyleNameChars" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890 _-#/()•.'"/>
		<!-- Title -->
		<xsl:call-template name="fmCM.Results.writeResult">
			<xsl:with-param name="ErrorLevel" select="$K_FMCM_INFO"/>
			<xsl:with-param name="Event" select="'Analysis'"/>
			<xsl:with-param name="Result" select="'Bad Style Names'"/>
		</xsl:call-template>
		<!-- Analysis -->
		<xsl:for-each select="/fmxmlsnippet/Theme/metadata/namedstyles/*[translate(text(),$allowedStyleNameChars,'')!='' or normalize-space(text())!=text()]">
			<xsl:sort select="text()"/>
			<xsl:call-template name="fmCM.Results.writeResult">
				<xsl:with-param name="ErrorLevel" select="$K_FMCM_ERROR"/>
				<xsl:with-param name="Event" select="'Bad Style Name'"/>
				<xsl:with-param name="Result">
					<xsl:value-of select="concat('Style ',$APOS,text(),$APOS)"/>
					<xsl:if test="translate(text(),$allowedStyleNameChars,'')!=''">
						<xsl:value-of select="' has undesirable characters in its name'"/>
					</xsl:if>
					<xsl:if test="normalize-space(text())!=text()">
						<xsl:value-of select="' has undesirable or mulitple white space in its name'"/>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
