<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: inc.XMSC_fmCM_AnalyseScripts.xsl
	
	Convenience include file which includes all function analysis include files
	(and defines the required delimiter and newrecord variables).
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2019-05-27 MrW: Version 1.0
	-->
	<!-- ===== INCLUDES ===== -->
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.clone.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.GetXpath.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.fmCM_Results_XMSC.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XMSC_fn.toString.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XMSS_fn.toString.xsl"/>
	<!--
	 ! Individual analyses in alphabetical order
	 !-->
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XMSC_fmCM_ReportFIXMEs.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XMSC_fmCM_ReportBrokenScriptCall.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XMSC_fmCM_ReportBrokenFieldReferences.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XMSC_fmCM_ReportBrokenCalculationCommentedOut.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XMSC_fmCM_ReportBadScriptNames.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XMSC_fmCM_ReportOverloadedScriptNames.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
</xsl:stylesheet>
