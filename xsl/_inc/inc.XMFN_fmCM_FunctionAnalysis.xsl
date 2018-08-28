<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: inc.XMFN_fmCM_FunctionAnalysis.xsl
	
	Convenience include file which includes all function analysis include files
	(and defines the required delimiter and newrecord variables).
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2016
	2016-03-13 MrW: Version 1.0
	-->
	<!-- ===== INCLUDES ===== -->
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.clone.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.GetXpath.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.fmCM_Results_XMFN.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XMFN_fn.toString.xsl"/>
	<!--
	 ! Individual analyses in alphabetical order
	 !-->
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XMFN_fmCM_ReportBrokenCalculationCommentedOut.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XMFN_fmCM_ReportBrokenCalculationFunctionMissing.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XMFN_fmCM_ReportCopiedFunctionNames.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XMFN_fmCM_ReportFIXMEs.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
</xsl:stylesheet>
