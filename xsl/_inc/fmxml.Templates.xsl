<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" xmlns:str="http://exslt.org/strings" extension-element-prefixes="str date" version="1.0">
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: fmxml.Templates.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: fmxmlsnippet
	
	Various templates for processing FileMaker xmlsnippet xml.
	
	===== CHANGES HISTORY =====
	2011-02-02 MrW: Version 1.0
	-->
	<!-- =========================== -->
	<!-- ===== FIELD TEMPLATES ===== -->
	<!-- =========================== -->
	<!-- Output field reference Tablename::Fieldname-->
	<xsl:template name="getFieldReference">
		<xsl:value-of select="@table"/>
		<xsl:text>::</xsl:text>
		<xsl:value-of select="@name"/>
	</xsl:template>
	<!-- ================================ -->
	<!-- ===== SCRIPTSTEP TEMPLATES ===== -->
	<!-- ================================ -->
	<!-- Script reference -->
	<!--xsl:call-template name="getStepScriptReference" select="Step"/-->
	<xsl:template name="getStepScriptReference">
		<xsl:value-of select="concat('Perform Script [',$QUOT,@name,$QUOT)"/>
		<xsl:if test="FileReference">
			<xsl:value-of select="concat(' from file: ',$QUOT,FileReference/@name,$QUOT)"/>
		</xsl:if>
		<xsl:if test="Calculation/text()">
			<xsl:value-of select="concat('; Parameter: ',translate(Calculation,$TABCRLF,'  '))"/>
		</xsl:if>
		<xsl:value-of select="']'"/>
	</xsl:template>
	<!-- =================================== -->
	<!-- ===== LAYOUT OBJECT TEMPLATES ===== -->
	<!-- =================================== -->
	<!-- Layout Enclosing Rect -->
	<!--xsl:call-template name="getLayoutEnclosingRectAsWordList" select="Layout"/-->
	<xsl:template name="getLayoutEnclosingRectAsWordList">
		<xsl:value-of select="str:replace(normalize-space(concat(@enclosingRectLeft,' ',@enclosingRectTop,' ',@enclosingRectRight,' ',@enclosingRectBottom)),'.000000','')"/>
	</xsl:template>
	<!-- Layout Object Bounds -->
	<!--xsl:call-template name="getBoundsAsWordList" select="Bounds"/-->
	<xsl:template name="getBoundsAsWordList">
		<xsl:value-of select="str:replace(normalize-space(concat(@left,' ',@top,' ',@right,' ',@bottom)),'.000000','')"/>
	</xsl:template>
	<!--xsl:value-of select="str:replace(normalize-space(concat('( ',@left,' ; ',@top,' ; ',@right,' ; ',@bottom,' )')),'.000000','')"/>			<xsl:call-template name="str:replace">
		<xsl:with-param name="string" select="concat('(',@left,';',@top,';',@right,';',@bottom,')')"/>
		<xsl:with-param name="search" select="'.000000'"/>
		<xsl:with-param name="replace" select="''"/>
	</xsl:call-template>
	<xsl:call-template name="SubstituteString">
		<xsl:with-param name="string" select="concat('(',@left,';',@top,';',@right,';',@bottom,')')"/>
		<xsl:with-param name="search" select="'.000000'"/>
		<xsl:with-param name="replace" select="''"/>
	</xsl:call-template-->
</xsl:stylesheet>
