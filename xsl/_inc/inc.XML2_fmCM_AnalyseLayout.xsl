<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: inc.XML2_fmCM_AnalyseLayout.xsl
	
	Convenience include file which includes all layout analysis include files
	(and defines the required delimiter and newrecord variables).
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2017-05-26 MrW: Version 1.2 Added Group-of-one analysis
	2015-11-30 MrW: Version 1.1 Added various analyses
	2015-11-23 MrW: Version 1.0
	-->
	<!-- ===== INCLUDES ===== -->
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.clone.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fn.toString.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.GetAbsoluteBounds.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.GetXpath.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.fmCM_Results.xsl"/>
	<!--
	 ! Individual analyses in alphabetical order
	 !-->
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fmCM_ReportAnchorErrors.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fmCM_ReportBrokenCalculationCommentedOut.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fmCM_ReportBrokenCalculationFunctionMissing.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fmCM_ReportBrokenCalculationFieldOrTableMissing.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fmCM_ReportBrokenCalculationQuoted.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fmCM_ReportBrokenFieldRepetitionOutOfRange.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fmCM_ReportBrokenFields.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fmCM_ReportBrokenInactiveValueLists.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fmCM_ReportBrokenScriptCall.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fmCM_ReportBrokenValueLists.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fmCM_ReportButtonActionMissing.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fmCM_ReportCopiedObjectNames.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fmCM_ReportEditableValueLists.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fmCM_ReportReferencesToExternalFiles.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fmCM_ReportFIXMEs.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fmCM_ReportGroupOfOne.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fmCM_ReportLocalCSS.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fmCM_ReportObjectsFloatingOverContainers.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fmCM_ReportObjectsHiddenBehindContainers.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fmCM_ReportObjectsLostInContainers.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fmCM_ReportObjectsWithClassicStyle.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fmCM_ReportPopoverInPopover.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fmCM_ReportReferencesToZzz.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fmCM_ReportQuotedObjectNames.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fmCM_ReportTabsWithTooManyPanelNames.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fmCM_ReportTabsWithMultipleStyles.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
</xsl:stylesheet>
