<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMAA_Text.Lines_ListfmCheckMateWarnings.xsl
	
	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: table or field definitions, or scripts (or layouts with buttons)
	
	Outputs warnings for each object that may not be pasted correctly (fields with bad calculation contexts, and import script steps).
	
	FIXME:
	IMPORTANT: THE FUNCTION WORKS ON TWO ASSUMPTION:
	1) (if you copy whole tables) EACH BASETABLE HAS A PTO OF EXACTLY THE SAME NAME.
	2) (if you copy just fields) PTOs BEGIN WITH '_'

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2013-09-16 MrW: Version 1.0
	-->
	
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Script step 35. Import records -->
	<xsl:template match="//Step[not(ancestor::Step) and @id='35']">
		<xsl:value-of select="'fmCheckMate warning:'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'script:'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="parent::Script/@name"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'contains an import script step.'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Please check and correct the field mapping option after pasting.'"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- All table fields with calculations with different context -->
	<xsl:template match="//Table/Field[parent::Table/@name!='' and ((@fieldType='Calculated' and not(Calculation/@table=../@name)) or (@fieldType='Normal' and AutoEnter/@calculation='True' and not(AutoEnter/Calculation/@table=../@name)))]">
		<xsl:call-template name="outputFieldCalculationContextWarning"/>
	</xsl:template>
	<!-- All fields with calculations context not beginning with an underscore-->
	<xsl:template match="//Field[(@fieldType='Calculated' and substring(Calculation/@table,1,1)!='_') or (@fieldType='Normal' and AutoEnter/@calculation='True' and substring(AutoEnter/Calculation/@table,1,1)!='_')]">
		<xsl:call-template name="outputFieldCalculationContextWarning"/>
	</xsl:template>
	<!-- outputFieldCalculationContextWarning -->
	<xsl:template name="outputFieldCalculationContextWarning">
		<xsl:value-of select="'fmCheckMate warning:'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'field:'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:if test="../@name!=''">
			<xsl:value-of select="concat(../@name,'::')"/>
		</xsl:if>
		<xsl:value-of select="@name"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'has unusual calculation context: '"/>
		<xsl:choose>
			<xsl:when test="@fieldType='Calculated'">
				<xsl:value-of select="Calculation/@table"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="AutoEnter/Calculation/@table"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Please check and correct the calculation context after pasting.'"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
