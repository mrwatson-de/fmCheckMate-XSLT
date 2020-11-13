<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_ExplodeReplaceFieldContentsToLoop.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Converts Replace Field Contents X = Y into Set Field X = Y and surrounds the code with a loop over the found records.
	
	
	FIXME
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2013-09-09 MrW: Clone templates centralized in _inc/inc.Clone.xsl
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/fmxmlsnippet">
		<fmxmlsnippet type="FMObjectList">
			<Step enable="True" id="68" name="">
				<Calculation><![CDATA[Get( FoundCount ) > 0]]></Calculation>
			</Step>
			<Step enable="True" id="16" name="">
				<NoInteract state="False"/>
				<RowPageLocation value="First"/>
			</Step>
			<Step enable="True" id="71" name=""/>
			<Step enable="True" id="89" name=""/>
			<!-- Convert replace fields -->
			<xsl:apply-templates/>
			<Step enable="True" id="75" name="">
				<NoInteract state="True"/>
				<Option state="True"/>
			</Step>
			<Step enable="True" id="89" name=""/>
			<Step enable="True" id="16" name="">
				<NoInteract state="False"/>
				<Exit state="True"/>
				<RowPageLocation value="Next"/>
			</Step>
			<Step enable="True" id="73" name=""/>
			<Step enable="True" id="70" name=""/>
		</fmxmlsnippet>
	</xsl:template>
	<!-- Script step 91. Replace Field Contents-->
	<xsl:template match="//Step[@id='91']">
		<!-- convert to Set Field step -->
		<xsl:variable name="enable" select="@enable"/>
		<!--  -->
		<Step enable="{$enable}" id="76" name="">
			<xsl:copy-of select="Calculation"/>
			<xsl:copy-of select="Field"/>
			<xsl:copy-of select="Repetition"/>
		</Step>
	</xsl:template>
</xsl:stylesheet>
