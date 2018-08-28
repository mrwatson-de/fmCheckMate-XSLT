<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XML2_XML2_UseSavedScriptStepOnButton.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied fmp12 layout objects
	
	Returns .....FIXME......

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2016

	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Case 1: The object is a grouped button => just replace its Step -->
	<xsl:template match="Object[@type='GroupButton']/GroupButtonObj/Step">
		<xsl:copy-of select="document('../../../fmCheckMate/fmxmlsnippet.xml')//Step[1]"/>
	</xsl:template>
	<!-- Case 2: Normal object => Add a grouped button to it -->
	<xsl:template match="Object[not(@type = 'GroupButton') and not(ancestor::Object/@type = 'GroupButton')]">
		<xsl:variable name="top" select="number(Bounds/@top)"/>
		<xsl:variable name="bottom" select="number(Bounds/@bottom)"/>
		<xsl:variable name="left" select="number(Bounds/@left)"/>
		<xsl:variable name="right" select="number(Bounds/@right)"/>
		<xsl:variable name="height" select="concat($bottom - $top,'.0000000')"/>
		<xsl:variable name="width" select="concat($right - $left,'.0000000')"/>
		<!-- -->
		<Object type="GroupButton" key="61" LabelKey="0" flags="65536" rotation="0">
			<xsl:copy-of select="Bounds"/>
			<GroupButtonObj numOfObjs="1">
				<xsl:copy-of select="document('../../../fmCheckMate/fmxmlsnippet.xml')//Step[1]"/>
				<Styles/>
				<xsl:copy>
					<xsl:apply-templates select="@*"/>
					<Bounds top="0.0000000" left="0.0000000" bottom="{$height}" right="{$width}"/>
					<xsl:apply-templates select="node()[name() != 'Bounds']"/>
				</xsl:copy>
			</GroupButtonObj>
		</Object>
	</xsl:template>
</xsl:stylesheet>
