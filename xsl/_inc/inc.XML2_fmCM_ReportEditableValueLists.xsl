<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: inc.XML2_fmCM_ReportEditableValueLists.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	Include file in a layout analysis to report value lists which are editable.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2015-11-23 MrW: Version 1.1 Refactored as include file
	2015-09-12 MrW: Version 1.0
	-->
	<!-- ===== NEEDS ===== -->
	<!--
		<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
		<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fn.toString.xsl"/>
		<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.GetAbsoluteBounds.xsl"/>
		<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.GetXpath.xsl"/>
		<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.fmCM_Results.xsl"/>
	-->
	<xsl:variable name="valDisplayTypeEditBox" select="0"/>
	<xsl:variable name="valDisplayTypeDropDownList" select="1"/>
	<xsl:variable name="valDisplayTypePopUpMenu" select="2"/>
	<xsl:variable name="valDisplayTypeCheckboxSet" select="3"/>
	<xsl:variable name="valDisplayTypeRadioButtonSet" select="4"/>
	<xsl:variable name="valDisplayTypeCalendarPopup" select="6"/>
	<!-- ===== TEMPLATES ===== -->
	<xsl:template name="XML2_fmCM_ReportEditableValueLists">
		<xsl:param name="ErrorLevel" select="$K_FMCM_WARNING"/>
		<!-- -->
		<xsl:variable name="Event" select="'Editable Value List'"/>
		<xsl:variable name="Result">
			<xsl:for-each select="//Object[(FieldObj/@flags mod (2*8))&gt;=8 and contains('1234',FieldObj/@displayType)]">
				<xsl:call-template name="fmCM.Results.writeResultForCurrentNode">
					<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					<xsl:with-param name="Event" select="$Event"/>
					<xsl:with-param name="Result">
						<xsl:apply-templates select="." mode="toString"/>
						<xsl:value-of select="' has an editable value list named '"/>
						<xsl:value-of select="$QUOT"/>
						<xsl:value-of select="FieldObj/DDRInfo/ValueList/@name"/>
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
