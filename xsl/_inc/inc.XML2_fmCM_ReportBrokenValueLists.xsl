<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: inc.XML2_fmCM_ReportBrokenValueLists.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	Include file in a layout analysis to report (active) broken value lists.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2016-01-15 MrW: Version 1.4 Corrected to NOT find missing value lists on non-fields
	2016-01-15 MrW: Version 1.3 Corrected to find both missing and deleted value lists
	2016-01-04 MrW: Version 1.1 Corrected to check only inactive value lists
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
	<!-- ===== TEMPLATES ===== -->
	<xsl:template name="XML2_fmCM_ReportBrokenValueLists">
		<xsl:param name="ErrorLevel" select="$K_FMCM_ERROR"/>
		<!-- -->
		<xsl:variable name="Event" select="'Broken Value List &lt;Missing&gt;'"/>
		<!-- Analysis -->
		<xsl:variable name="Result">
			<xsl:for-each select="//Object[FieldObj/@displayType&gt;=1 and FieldObj/@displayType&lt;=4 and (FieldObj/DDRInfo/ValueList/@name='' or not(FieldObj/DDRInfo/ValueList))]">
				<xsl:call-template name="fmCM.Results.writeResultForCurrentNode">
					<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
					<xsl:with-param name="Event" select="$Event"/>
					<xsl:with-param name="Result">
						<xsl:apply-templates select="." mode="toString"/>
						<xsl:choose>
							<xsl:when test="FieldObj/DDRInfo/ValueList/@name=''">
								<xsl:value-of select="concat(' - value list has been deleted {id:',FieldObj/DDRInfo/ValueList/@id,'}.')"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="' - value list is &lt;missing&gt;'"/>
							</xsl:otherwise>
						</xsl:choose>
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
