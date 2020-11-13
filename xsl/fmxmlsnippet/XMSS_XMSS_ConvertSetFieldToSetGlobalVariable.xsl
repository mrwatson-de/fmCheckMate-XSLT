<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_ConvertSetFieldToSetGlobalVariable.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps - with Set Field X = Calc
	
	Converts Set Field X = Calc to Set Variable $$X = Calc

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2014-07-04 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== PARAMETER ===== -->
	<xsl:param name="varType" select="'$$'"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Set Field-->
	<xsl:template match="//Step[@id='76']">
		<!-- convert to Set Variable step -->
		<xsl:variable name="enable" select="@enable"/>
		<xsl:variable name="fieldTable" select="Field/@table"/>
		<xsl:variable name="fieldName" select="Field/@name"/>
		<!-- -->
		<xsl:variable name="repetitionArray">
			<xsl:choose>
				<xsl:when test="Repetition/Calculation">
					<xsl:text>[</xsl:text>
					<xsl:value-of select="Repetition/Calculation"/>
					<xsl:text>]</xsl:text>
				</xsl:when>
				<xsl:when test="Field/@repetition&gt;1">
					<xsl:text>[</xsl:text>
					<xsl:value-of select="Field/@repetition"/>
					<xsl:text>]</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<Step enable="{$enable}" id="141">
			<Value>
				<xsl:copy-of select="Calculation"/>
			</Value>
			<Repetition>
				<Calculation>
					<xsl:choose>
						<xsl:when test="Repetition/Calculation">
							<!-- calculated repetition -->
							<xsl:value-of select="Repetition/Calculation"/>
						</xsl:when>
						<xsl:when test="Field/@repetition">
							<!-- simple repetition -->
							<xsl:value-of select="Field/@repetition"/>
						</xsl:when>
						<xsl:otherwise>
							<!-- default repetition -->
							<xsl:value-of select="1"/>
						</xsl:otherwise>
					</xsl:choose>
				</Calculation>
			</Repetition>
			<Name>
				<xsl:value-of select="concat($varType,translate($fieldName,' ','_'))"/>
			</Name>
		</Step>
	</xsl:template>
</xsl:stylesheet>
