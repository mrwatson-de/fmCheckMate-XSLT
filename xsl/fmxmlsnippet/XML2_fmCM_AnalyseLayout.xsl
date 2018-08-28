<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XML2_fmCM_AnalyseLayout.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	Performs an analysis and creates an FMPXMLRESULT data set to import into fmCheckMate.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2017
	2018-06-04 MrW: Version 1.1 Added check for broken field + table references
	2017-03-19 MrW: Version 1.0.1 Fixed include bug which had crept in.
	2015-09-12 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<!-- Include standard reports-->
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fmCM_AnalyseLayout.xsl"/>
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
					<xsl:call-template name="XML2_fmCM_ReportFIXMEs">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<xsl:call-template name="XML2_fmCM_ReportBrokenFields">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<xsl:call-template name="XML2_fmCM_ReportBrokenFieldRepetitionOutOfRange">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<xsl:call-template name="XML2_fmCM_ReportBrokenValueLists">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<xsl:call-template name="XML2_fmCM_ReportBrokenCalculationCommentedOut">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<xsl:call-template name="XML2_fmCM_ReportBrokenCalculationFunctionMissing">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<xsl:call-template name="XML2_fmCM_ReportBrokenCalculationFieldOrTableMissing">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<xsl:call-template name="XML2_fmCM_ReportBrokenCalculationQuoted">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<xsl:call-template name="XML2_fmCM_ReportBrokenScriptCall">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<xsl:call-template name="XML2_fmCM_ReportPopoverInPopover">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<xsl:call-template name="XML2_fmCM_ReportTabsWithMultipleStyles">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<xsl:call-template name="XML2_fmCM_ReportQuotedObjectNames">
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
					<xsl:call-template name="XML2_fmCM_ReportAnchorErrors">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<xsl:call-template name="XML2_fmCM_ReportObjectsLostInContainers">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<xsl:call-template name="XML2_fmCM_ReportObjectsFloatingOverContainers">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<xsl:call-template name="XML2_fmCM_ReportObjectsHiddenBehindContainers">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<xsl:call-template name="XML2_fmCM_ReportCopiedObjectNames">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<!-- -->
					<xsl:call-template name="XML2_fmCM_ReportButtonActionMissing">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<xsl:call-template name="XML2_fmCM_ReportGroupOfOne">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<xsl:call-template name="XML2_fmCM_ReportReferencesToExternalFiles">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<xsl:call-template name="XML2_fmCM_ReportReferencesToZzz">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<!-- Question of Style -->
					<xsl:call-template name="XML2_fmCM_ReportTabsWithTooManyPanelNames">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<xsl:call-template name="XML2_fmCM_ReportObjectsWithClassicStyle">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<xsl:call-template name="XML2_fmCM_ReportLocalCSS">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<!-- unimportant -->
					<xsl:call-template name="XML2_fmCM_ReportEditableValueLists">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
					<!-- problems behind the scenes -->
					<xsl:call-template name="XML2_fmCM_ReportBrokenInactiveValueLists">
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
					<xsl:call-template name="XML2_fmCM_ReportEditableValueLists">
						<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					</xsl:call-template>
				</xsl:if>
			</RESULTSET>
		</FMPXMLRESULT>
	</xsl:template>
</xsl:stylesheet>
