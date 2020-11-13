<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_ConvertCustomDialogInputsToVars.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Converts a Show Custom Dialog script step which has input fields into a dialog with variables.
	
	It is surrounded by Set Variable and Set Field steps, so that the resulting code is identical. 
	
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2018-05-13 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"
		cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Show Custom Dialog with Field Inputs…-->
	<xsl:template
		match="//Step[not(ancestor::Step) and @id = '87' and InputFields/InputField/Field/@name!='']">
		<!-- -->
		<xsl:apply-templates select="InputFields/InputField/Field[@name!='']"
			mode="CreateSetVarToFieldStepsForCustomDialog"/>
		<!-- -->
		<xsl:copy>
			<xsl:apply-templates select="* | @*"/>
		</xsl:copy>
		<!-- -->
		<xsl:apply-templates select="InputFields/InputField/Field[@name!='']"
			mode="CreateSetFieldToVarStepsForCustomDialog"/>
	</xsl:template>
	<!-- Remove Field-by-Name and replace with variable reference -->
	<xsl:template match="Step/InputFields/InputField/Field[@name!='']">
		<xsl:variable name="varName">
			<xsl:value-of select="'$'"/>
			<xsl:value-of select="@table"/>
			<xsl:value-of select="'_'"/>
			<xsl:value-of select="@name"/>
		</xsl:variable>
		<!-- -->
		<Field>
			<xsl:value-of select="$varName"/>
		</Field>
	</xsl:template>
	<!-- MODE TEMPLATES-->
	<xsl:template match="Field[@name!='']"
		mode="CreateSetVarToFieldStepsForCustomDialog">
		<xsl:variable name="varName">
			<xsl:value-of select="'$'"/>
			<xsl:value-of select="@table"/>
			<xsl:value-of select="'_'"/>
			<xsl:value-of select="@name"/>
		</xsl:variable>
		<!-- -->
		<Step enable="True" id="141" name="Set Variable">
			<Value>
				<Calculation>
					<xsl:value-of select="@table"/>
					<xsl:value-of select="'::'"/>
					<xsl:value-of select="@name"/>
				</Calculation>
			</Value>
			<Repetition>
				<Calculation><![CDATA[1]]></Calculation>
			</Repetition>
			<Name>
				<xsl:value-of select="$varName"/>
			</Name>
		</Step>
	</xsl:template>

	<xsl:template match="Field[@name!='']" mode="CreateSetFieldToVarStepsForCustomDialog">
		<xsl:variable name="varName">
			<xsl:value-of select="'$'"/>
			<xsl:value-of select="@table"/>
			<xsl:value-of select="'_'"/>
			<xsl:value-of select="@name"/>
		</xsl:variable>
		<!-- -->
		<Step enable="True" id="76" name="Set Field">
			<Calculation>
				<xsl:value-of select="$varName"/>
			</Calculation>
			<xsl:copy-of select="."/>
		</Step>
	</xsl:template>
</xsl:stylesheet>
