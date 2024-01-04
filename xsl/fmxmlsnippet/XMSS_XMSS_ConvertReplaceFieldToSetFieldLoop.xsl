<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_ConvertReplaceFieldToSetFieldLoop.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Converts script step Replace Field Contents X = Y into Set Field X = Y and adds a record loop.

	===== CHANGES HISTORY =====
	2014-06-06 MrW: Added commit and surrounding if
	2014-06-03 MrW: Created in a session at dotfmp[X]Berlin, http://www.dotfmp.com
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Script step 76 Set Field -->
	<xsl:template match="fmxmlsnippet">
		<fmxmlsnippet type="FMObjectList">
			<!-- If[Get( FoundCount ) > 0] -->
			<Step enable="True" id="68">
				<Calculation><![CDATA[Get( FoundCount ) > 0]]></Calculation>
			</Step>
			<!-- Go to first Record -->
			<Step enable="True" id="16">
				<NoInteract state="False"/>
				<RowPageLocation value="First"/>
			</Step>
			<!-- Loop -->
			<Step enable="True" id="71"/>
			<!-- -->
			<xsl:apply-templates select="*"/>
			<!-- -->
			<!-- Commit Record -->
			<Step enable="True" id="75">
				<NoInteract state="True"/>
				<Option state="False"/>
			</Step>
			<!-- Go to next Record -->
			<Step enable="True" id="16">
				<NoInteract state="False"/>
				<Exit state="True"/>
				<RowPageLocation value="Next"/>
			</Step>
			<!-- End Loop -->
			<Step enable="True" id="73"/>
			<!-- End If -->
			<Step enable="True" id="70"/>
		</fmxmlsnippet>
	</xsl:template>
	<!-- Script step 91. Replace Field Contents-->
	<xsl:template match="//Step[@id='91']">
		<!-- convert to Set Field step -->
		<xsl:variable name="enable" select="@enable"/>
		<!--  -->
		<Step enable="{$enable}" id="76">
			<xsl:copy-of select="Calculation"/>
			<xsl:copy-of select="Field"/>
			<xsl:copy-of select="Repetition"/>
		</Step>
	</xsl:template>
</xsl:stylesheet>
