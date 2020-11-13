<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_ConvertNewWindowToPositionWindow.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	New Window steps are converted to Position Window steps and vice versa
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2014-06-25 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Convert New Window to Position Window -->
	<xsl:template match="Step[@id='122']">
		<xsl:variable name="enable" select="@enable"/>
		<!--  -->
		<Step enable="{$enable}" id="119">
			<LimitToWindowsOfCurrentFile state="True"/>
			<Window value="ByName"/>
			<xsl:copy-of select="Name"/>
			<xsl:copy-of select="Height"/>
			<xsl:copy-of select="Width"/>
			<xsl:copy-of select="DistanceFromTop"/>
			<xsl:copy-of select="DistanceFromLeft"/>
		</Step>
	</xsl:template>
	<!-- Convert Position Window to New Window-->
	<xsl:template match="Step[@id='119']">
		<xsl:variable name="enable" select="@enable"/>
		<!--  -->
		<Step enable="{$enable}" id="122">
			<xsl:copy-of select="Name"/>
			<xsl:copy-of select="Height"/>
			<xsl:copy-of select="Width"/>
			<xsl:copy-of select="DistanceFromTop"/>
			<xsl:copy-of select="DistanceFromLeft"/>
		</Step>
	</xsl:template>
</xsl:stylesheet>
