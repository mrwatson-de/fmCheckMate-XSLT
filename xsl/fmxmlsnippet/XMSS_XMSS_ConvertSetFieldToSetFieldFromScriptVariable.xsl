<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_ConvertSetFieldToSetFieldFromScriptVariable.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps - with Set Field X = Calc
	
	Converts Set Field X = Calc to Set Field X = $X

	===== CHANGES HISTORY =====
	2026-02-17 @mrwatson-de Version 1.2 Refactored $varName and add Set Var
	2026-02-14 @mrwatson-de Version 1.1 Remove dots from names
	2014-07-04 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== PARAMETER ===== -->
	<xsl:param name="varType" select="'$'"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Set Field / Set Field by Name / Insert Calculated Result -->
	<xsl:template match="Step[@id='76' or @id='147' or @id='77']">
		<!-- Replace calculation -->
		<xsl:variable name="enable" select="@enable"/>
		<xsl:variable name="id" select="@id"/>
		<xsl:variable name="fieldTable" select="Field/@table"/>
		<xsl:variable name="fieldName" select="Field/@name"/>
		<xsl:variable name="fieldNameCalculation" select="TargetName/Calculation"/>
		<!-- Get the name of the field to base the variable name on -->
		<xsl:variable name="varNameBasis">
			<xsl:choose>
				<xsl:when test="$fieldName">
					<xsl:value-of select="$fieldName"/>
				</xsl:when>
				<xsl:when test="contains($fieldNameCalculation,'::')">
					<xsl:value-of select="substring-before(substring-after($fieldNameCalculation,'::'),'&quot;')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'set_field'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- Convert field name to variable name -->
		<xsl:variable name="varName" select="concat($varType,translate($varNameBasis,' .','_'))"/>
		<!-- -->
		<!-- Set Var = Calculation -->
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
				<xsl:value-of select="$varName"/>
			</Name>
		</Step>
		<!-- Reconstruct the step -->
		<Step enable="{$enable}" id="{$id}">
			<!-- -->
			<xsl:choose>
				<xsl:when test="$id='77'">
					<!-- Set Field by Name - Replace result-calculation with $varName -->
					<Result>
						<Calculation>
							<xsl:value-of select="$varName"/>
						</Calculation>
					</Result>
					<!-- Clone the rest -->
					<xsl:copy-of select="*[not(self::Result)]"/>
				</xsl:when>
				<xsl:otherwise>
					<!-- Set Field / Insert Calculated Result - Replace calculation with $varName -->
					<Calculation>
						<xsl:value-of select="$varName"/>
					</Calculation>
					<!-- Clone the rest -->
					<xsl:copy-of select="*[not(self::Calculation)]"/>
				</xsl:otherwise>
			</xsl:choose>
		</Step>
	</xsl:template>
</xsl:stylesheet>
