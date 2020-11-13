<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_SwapSetFieldAndSetVar.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps - with SetVar X = Field Y or Set Field Y = Var X
	
	Converts Set Var X = Field Y into Set Field Y = Var X and vice-versa.

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2017-08-13 MrW: Removed dependency on german language
	2013-09-09 MrW: Clone templates centralized in _inc/inc.Clone.xsl
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!--
	 ! Convert Set Variable to Set Field
	 !-->
	<xsl:template match="//Step[@id='141']">
		<!-- convert to Set Field step -->
		<xsl:variable name="enable" select="@enable"/>
		<xsl:variable name="varName" select="Name"/>
		<xsl:variable name="fieldIdDummy" select="0"/>
		<xsl:variable name="fieldRepetitionDummy" select="0"/>
		<!-- From the calculation, e.g. "Table::Field[Repetition] // Comment" extract Table, Fied and repetition -->
		<xsl:variable name="valueCalculation" select="Value/Calculation/text()"/>
		<xsl:variable name="fieldFullname" select="normalize-space(substring-before(concat(substring-before(concat($valueCalculation,'//'),'//'),'/*'),'/*'))"/>
		<xsl:variable name="fieldTableName" select="substring-before(concat($fieldFullname,'['),'[')"/>
		<xsl:variable name="fieldTable" select="substring-before($fieldTableName,'::')"/>
		<xsl:variable name="fieldName" select="substring-after($fieldTableName,'::')"/>
		<xsl:variable name="fieldRepetitionArray" select="substring-after($fieldFullname,$fieldTableName)"/>
		<xsl:variable name="fieldRepetitionCalculation" select="substring-before(substring-after($fieldRepetitionArray,'['),']')"/>
		<xsl:variable name="repetitionCalculation">
			<xsl:choose>
				<xsl:when test="$fieldRepetitionCalculation">
					<xsl:value-of select="$fieldRepetitionCalculation"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>1</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!--
		 ! Output Set Field
		 !-->
		<Step enable="{$enable}" id="76">
			<Calculation>
				<xsl:value-of select="$varName"/>
			</Calculation>
			<Field table="{$fieldTable}" id="{$fieldIdDummy}" repetition="{$fieldRepetitionDummy}" name="{$fieldName}"/>
			<Repetition>
				<Calculation>
					<xsl:value-of select="$repetitionCalculation"/>
				</Calculation>
			</Repetition>
		</Step>
	</xsl:template>
	<!--
	 ! Convert Set Field to Set Variable
	 !-->
	<xsl:template match="//Step[@id='76']">
		<!-- convert to Set Variable step -->
		<xsl:variable name="enable" select="@enable"/>
		<xsl:variable name="varNameFromCalculation" select="normalize-space(substring-before(concat(substring-before(concat(Calculation/text(),'//'),'//'),'/*'),'/*'))"/>
		<xsl:variable name="varName">
			<xsl:choose>
				<xsl:when test="substring($varNameFromCalculation,1,1)='$'">
					<xsl:value-of select="$varNameFromCalculation"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>$VARIABLENAME</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="fieldTable" select="Field/@table"/>
		<xsl:variable name="fieldName" select="Field/@name"/>
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
		<!--
		 ! Output Set Variable
		 !-->
		<Step enable="{$enable}" id="141">
			<Value>
				<Calculation>
					<xsl:value-of select="$fieldTable"/>
					<xsl:text>::</xsl:text>
					<xsl:value-of select="$fieldName"/>
					<xsl:value-of select="$repetitionArray"/>
				</Calculation>
			</Value>
			<Repetition>
				<Calculation>
					<xsl:text>1</xsl:text>
				</Calculation>
			</Repetition>
			<Name>
				<xsl:copy-of select="$varName"/>
			</Name>
		</Step>
	</xsl:template>
</xsl:stylesheet>
