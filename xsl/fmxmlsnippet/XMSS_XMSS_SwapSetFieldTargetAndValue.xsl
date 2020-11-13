<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_SwapSetFieldTargetAndValue.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Converts Set X = Y into Set Y = X, where X and Y can be a single field or variable.
 	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2018-05-02 MrW: Corrected repetition 
	2013-09-09 MrW: Clone templates centralized in _inc/inc.Clone.xsl
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<!-- ===== TEMPLATES ===== -->
	<!--
	 ! Script step 76 - Set Field X = Table::Field Y
	-->
	<xsl:template match="//Step[@id='76' and contains(Calculation,'::')]">
		<!-- Swap target and value -->
		<xsl:variable name="enable" select="@enable"/>
		<xsl:variable name="tablename" select="substring-before(Calculation,'::')"/>
		<xsl:variable name="fieldname" select="substring-after(Calculation,'::')"/>
		<!--  -->
		<Step enable="{$enable}" id="76" name="">
			<Calculation>
				<xsl:value-of select="concat(Field/@table,'::',Field/@name)"/>
			</Calculation>
			<Field table="{$tablename}" name="{$fieldname}"/>
		</Step>
	</xsl:template>
	<!--
	 ! Script step 76 - Set Field X = $VarY
	-->
	<xsl:template match="//Step[@id='76' and substring(normalize-space(Calculation),1)='$']">
		<!-- Swap target and value -->
		<xsl:variable name="enable" select="@enable"/>
		<xsl:variable name="varName" select="substring-before(concat(normalize-space(Calculation),'['),'[')"/>
		<xsl:variable name="varRepetition" select="substring-before(substring-after(concat(Calculation,'[1]'),'['),']')"/>
		<xsl:variable name="fieldArrayRepetition">
			<xsl:choose>
				<xsl:when test="number(Field/@repetition)&gt;1">
					<xsl:value-of select="concat('[',Field/@repetition,']')"/>
				</xsl:when>
				<xsl:when test="Field/@repetition='0' and Repetition/Calculation != '' and Repetition/Calculation != '1'">
					<xsl:value-of select="concat('[',Repetition/Calculation,']')"/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<!--  -->
		<Step enable="{$enable}" id="141" name="">
			<Value>
				<Calculation>
					<xsl:value-of select="concat(Field/@table,'::',Field/@name,$fieldArrayRepetition)"/>
				</Calculation>
			</Value>
			<Repetition>
				<Calculation>
					<xsl:value-of select="$varRepetition"/>
				</Calculation>
			</Repetition>
			<Name>
				<xsl:value-of select="$varName"/>
			</Name>
		</Step>
	</xsl:template>
	<!--
	 ! Script step 141 - Set Variable $VarX = Table::Field Y
	-->
	<xsl:template match="//Step[@id='141' and contains(Value/Calculation,'::')]">
		<!-- Swap target and value -->
		<xsl:variable name="enable" select="@enable"/>
		<xsl:variable name="tablename" select="normalize-space(substring-before(Value/Calculation,'::'))"/>
		<xsl:variable name="fieldname" select="normalize-space(substring-before(concat(substring-after(Value/Calculation,'::'),'['),'['))"/>
		<xsl:variable name="repetition" select="normalize-space(substring-before(concat(substring-after(Value/Calculation,'['),'['),'['))"/>
		<!--  -->
		<Step enable="{$enable}" id="76" name="">
			<Calculation>
				<xsl:value-of select="Name"/>
			</Calculation>
			<Field table="{$tablename}" name="{$fieldname}"/>
		</Step>
	</xsl:template>
	<!--
	 ! Script step  141 - Set Variable $VarX = $VarY
	-->
	<xsl:template match="//Step[@id='141' and contains(Value/Calculation,'$')]">
		<!-- Swap target and value -->
		<xsl:variable name="enable" select="@enable"/>
		<!--  -->
		<Step enable="{$enable}" id="141" name="">
			<Value>
				<Calculation>
					<xsl:value-of select="Name"/>
					<xsl:if test="Repetition/Calculation != '1'">
						<xsl:value-of select="concat('[',Repetition/Calculation,']')"/>
					</xsl:if>
				</Calculation>
			</Value>
			<Repetition>
				<Calculation>
					<xsl:value-of select="substring-before(substring-after(concat(Value/Calculation,'[1]'),'['),']')"/>
				</Calculation>
			</Repetition>
			<Name>
				<xsl:value-of select="substring-before(concat(Value/Calculation,'['),'[')"/>
			</Name>
		</Step>
	</xsl:template>
</xsl:stylesheet>
