<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_SetFieldIfEmpty.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Wraps each Set Field X = Y in an if statement
	
	If [IsEmpty( Field X )]
	    Set Field X = Y
	End If

        ===== SEE ALSO =====
        
        XMSS_XMSS_SetFieldIfNotAlreadyEqual.xsl
        XMSS_Text_ConvertSetFieldsToPredicateEqual.xsl
        XMSS_Text_ConvertSetFieldsToPredicateExact.xsl
        
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2015-06-29 MrW: v1.1 supports Set Field by Name
	2015-01-22 MrW: v1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XMAA_Text_Field.getReferenceForCalculation.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Script step 76 Set Field -->
	<xsl:template match="//Step[@id='76']">
		<xsl:variable name="enable" select="@enable"/>
		<!--  -->
		<Step enable="{$enable}" id="68">
			<Calculation>
				<xsl:value-of select="'IsEmpty( '"/>
				<xsl:apply-templates select="Field" mode="getReferenceForCalculation"/>
				<xsl:value-of select="' )'"/>
			</Calculation>
		</Step>
		<xsl:copy-of select="."/>
		<Step enable="{$enable}" id="70"/>
	</xsl:template>
	<!-- Script step 147 Set Field by Name -->
	<xsl:template match="//Step[@id='147']">
		<xsl:variable name="enable" select="@enable"/>
		<xsl:variable name="nameCalc" select="TargetName/Calculation/text()"/>
		<!--  -->
		<Step enable="{$enable}" id="68">
			<Calculation>
				<xsl:value-of select="'IsEmpty( '"/>
				<xsl:choose>
					<xsl:when test="normalize-space( substring-before( $nameCalc,'(')) = 'GetFieldName' and substring( $nameCalc , string-length($nameCalc)) = ')'">
						<xsl:variable name="temp" select="substring-after($nameCalc,'(')"/>
						<xsl:value-of select="substring($temp,1,string-length($temp) - 1)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'GetField('"/>
						<xsl:value-of select="TargetName/Calculation/text()"/>
						<xsl:value-of select="')'"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="' )'"/>
			</Calculation>
		</Step>
		<xsl:copy-of select="."/>
		<Step enable="{$enable}" id="70"/>
	</xsl:template>
</xsl:stylesheet>
