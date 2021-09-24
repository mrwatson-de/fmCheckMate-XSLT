<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. ===== PURPOSE =====

	XSL-File: XMSS_XMSS_ConvertSetFieldToInsertText.xsl.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps - with Set Field X =  Some string
	
	Converts
	 
		Set Field [ X ; "Some string" ]
	
	to
		Insert Text [ X ; Some string ] ===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2014-07-04 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.Quote.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.Substitute.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Set Field-->
	<xsl:template match="//Step[@id='76']">
		<!-- Replace calculation -->
		<xsl:variable name="enable" select="@enable"/>
		<!-- -->
		<!--
		FROM this:

		<Step enable="True" id="76" name="Set Field">
			<Calculation><![CDATA["Hi, I'm Russell, what's your name?¶"]]></Calculation>
<Field table="_fmTextMultiplier" id="1" name="Text"/>
</Step>

		TO this:
			
				
		-->
		<Step enable="{$enable}" id="61">
			<SelectAll state="True"/>
			<Text>
				<xsl:call-template name="fn.Unquote">
<xsl:with-param name="text" select="Calculation/text()"/>
</xsl:call-template>
			</Text>
			<xsl:copy-of select="Field"/>
		</Step>
	</xsl:template>

</xsl:stylesheet>
