<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_RemoveOldStuffAndReplaceWithSetFieldEtc.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Replaces old Field-handling with Set Field.

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2019-10-02 MrW: Version 0.2 Removed German step name
	2011-12-13 MrW: Version 0.1
	2011-09-30 MrW: inc/constants.xsl
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- 13: Systemdatum einfügen -->
	<xsl:template match="//Step[@id='13' and Field and SelectAll/@state='True']">
		<!-- convert to Set Field step -->
		<xsl:variable name="enable" select="@enable"/>
		<xsl:variable name="repetitionCalculation" select="Repetition/Calculation"/>
		<!--  -->
		<Step enable="{$enable}" id="76">
			<Calculation>
				<xsl:text>Get( CurrentDate )</xsl:text>
			</Calculation>
			<xsl:copy-of select="Field"/>
			<xsl:if test="$repetitionCalculation">
				<Repetition>
					<Calculation>
						<xsl:value-of select="$repetitionCalculation"/>
					</Calculation>
				</Repetition>
			</xsl:if>
		</Step>
	</xsl:template>
	<!-- 14: Systemuhrzeit einfügen -->
	<xsl:template match="//Step[@id='14' and Field and SelectAll/@state='True']">
		<!-- convert to Set Field step -->
		<xsl:variable name="enable" select="@enable"/>
		<xsl:variable name="repetitionCalculation" select="Repetition/Calculation"/>
		<!--  -->
		<Step enable="{$enable}" id="76">
			<Calculation>
				<xsl:text>Get( CurrentTime )</xsl:text>
			</Calculation>
			<xsl:copy-of select="Field"/>
			<xsl:if test="$repetitionCalculation">
				<Repetition>
					<Calculation>
						<xsl:value-of select="$repetitionCalculation"/>
					</Calculation>
				</Repetition>
			</xsl:if>
		</Step>
	</xsl:template>
	<!-- 60: Benutzernamen einfügen -->
	<xsl:template match="//Step[@id='60' and Field and SelectAll/@state='True']">
		<!-- convert to Set Field step -->
		<xsl:variable name="enable" select="@enable"/>
		<xsl:variable name="repetitionCalculation" select="Repetition/Calculation"/>
		<!--  -->
		<Step enable="{$enable}" id="76">
			<Calculation>
				<xsl:text>Get( UserName )</xsl:text>
			</Calculation>
			<xsl:copy-of select="Field"/>
			<xsl:if test="$repetitionCalculation">
				<Repetition>
					<Calculation>
						<xsl:value-of select="$repetitionCalculation"/>
					</Calculation>
				</Repetition>
			</xsl:if>
		</Step>
	</xsl:template>
	
	<!-- 49: Löschen -->
	<xsl:template match="//Step[@id='49' and Field and SelectAll/@state='True']">
		<!-- convert to Set Field step -->
		<xsl:variable name="enable" select="@enable"/>
		<xsl:variable name="repetitionCalculation" select="Repetition/Calculation"/>
		<!--  -->
		<Step enable="{$enable}" id="76">
			<Calculation>
				<xsl:text>""</xsl:text>
			</Calculation>
			<xsl:copy-of select="Field"/>
			<xsl:if test="$repetitionCalculation">
				<Repetition>
					<Calculation>
						<xsl:value-of select="$repetitionCalculation"/>
					</Calculation>
				</Repetition>
			</xsl:if>
		</Step>
	</xsl:template>
	<!-- 77: Berechneten Wert einfügen -->
	<xsl:template match="//Step[@id='77' and Field and SelectAll/@state='True']">
		<!-- convert to Set Field step -->
		<xsl:variable name="enable" select="@enable"/>
		<xsl:variable name="repetitionCalculation" select="Repetition/Calculation"/>
		<!--  -->
		<Step enable="{$enable}" id="76">
			<Calculation>
				<xsl:text>""</xsl:text>
			</Calculation>
			<xsl:copy-of select="Field"/>
			<xsl:copy-of select="Calculation"/>
			<xsl:if test="$repetitionCalculation">
				<Repetition>
					<Calculation>
						<xsl:value-of select="$repetitionCalculation"/>
					</Calculation>
				</Repetition>
			</xsl:if>
		</Step>
	</xsl:template>
	<!-- 61: Text einfügen FIXME -->
	<xsl:template match="//Step[@id='61' and Field and SelectAll/@state='True']">
		<!-- convert to Set Field step -->
		<xsl:variable name="enable" select="@enable"/>
		<xsl:variable name="repetitionCalculation" select="Repetition/Calculation"/>
		<!--  -->
		<Step enable="{$enable}" id="76">
			<Calculation>
				<xsl:call-template name="TextToCalculation">
					<xsl:with-param name="pText" select="Text/text()"/>
				</xsl:call-template>
			</Calculation>
			<xsl:copy-of select="Field"/>
			<xsl:if test="$repetitionCalculation">
				<Repetition>
					<Calculation>
						<xsl:value-of select="$repetitionCalculation"/>
					</Calculation>
				</Repetition>
			</xsl:if>
		</Step>
	</xsl:template>
	<!-- TextToCalculation -->
	<xsl:template name="TextToCalculation">
		<xsl:param name="text"/>
		<!-- FIXME - in the current version quotes are simply converted to apostophes so that it doesn't fall over... -->
		<xsl:value-of select="translate($text,$QUOT,$APOS)"/>
	</xsl:template>
</xsl:stylesheet>
