<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XML2_fmCM_LayoutAnalysis-BrokenValueLists.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	An XSLT Template to import an fmxmlsnippet into fmCheckMate.
	Please adjust this template as necessary.
	
	===== CHANGES HISTORY =====
	2015-09-12 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<!-- Include standard reports-->
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fmCM_LayoutAnalysis.xsl"/>
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
					<xsl:call-template name="XML2_fmCM_ReportBrokenValueLists">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
				</xsl:if>
			</RESULTSET>
		</FMPXMLRESULT>
	</xsl:template>
</xsl:stylesheet>
