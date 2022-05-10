<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XML2_XML2_ConvertButtonbarsToButtons.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied fmp12 layout objects
	
	Converts a button bar to just the buttons.

	- Button position is retained
	  - Although Buttonbar line width is not yet taken into account
	- Buttonbar label calculations are (mostly) converted to button text.
		- Supported:
			- "String" is converted to String
			- Table::Field is converted to <<Table::Field>> (and is connected to the field // = TextObj flags+=8)
		- Breaks:
			- Anything more complicated
	- Button style
		- Not looked at it yet

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2022
	2022-05-10 MrW: Version 0.1
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text "/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.BaseFunctions.xsl"/>
		<!-- ===== TEMPLATES ===== -->
	<!-- Remove the button bar stuff and just render the buttons -->
	<xsl:template match="Object[@type='ButtonBar']">
		<!-- -->
			<xsl:apply-templates select="ButtonBarObj/Object[@type='Button']"/>
	</xsl:template>

	<!-- Move Button Bounds by ButtonBar Bounds -->
	<xsl:template match="Object[@type='ButtonBar']/ButtonBarObj/Object[@type='Button']/Bounds">
		<xsl:variable name="marginWidth" select="1"/>
		<xsl:variable name="left" select="number(ancestor::Object[@type='ButtonBar']/Bounds/@left)"/>
		<xsl:variable name="top" select="number(ancestor::Object[@type='ButtonBar']/Bounds/@top)"/>
		<xsl:copy>
			<xsl:attribute name="left"> <xsl:value-of select="number(@left) + $left - $marginWidth"/></xsl:attribute>
			<xsl:attribute name="top"> <xsl:value-of select="number(@top) + $top - $marginWidth"/></xsl:attribute>
			<xsl:attribute name="right"> <xsl:value-of select="number(@right) + $left +  $marginWidth"/></xsl:attribute>
			<xsl:attribute name="bottom"> <xsl:value-of select="number(@bottom) + $top + $marginWidth"/></xsl:attribute>
		</xsl:copy>
	</xsl:template>

	<!-- Move Label Calculation to Text Data -->
	<xsl:template match="ButtonBarObj/Object/TextObj/*/Style/Data">
		<!-- FIXME -->
		<xsl:copy>
			<xsl:variable name="calc" select="(ancestor::Object[@type='Button'])[1]/LabelCalc/Calculation/text()"/>
			<xsl:call-template name="evaluate">
				<xsl:with-param name="calc" select="$calc"/>
			</xsl:call-template>
		</xsl:copy>
	</xsl:template>

	<!-- Remove Label Calculation -->
	<xsl:template match="LabelCalc"/>

	<!-- activate <<placeholder>> -->
	<xsl:template match="ButtonBarObj/Object[@type='Button']/TextObj">
		<xsl:copy>
			<xsl:apply-templates select="@*[name() != 'flags']"/>
			<xsl:attribute name="flags">
				<xsl:call-template name="fn.BitwiseOr">
					<xsl:with-param name="value1" select="number(@flags)"/>
					<xsl:with-param name="value2" select="8"/>
				</xsl:call-template>
			</xsl:attribute>
			<xsl:apply-templates select="*"/>
		</xsl:copy>
	</xsl:template>


	<xsl:template name="evaluate">
		<xsl:param name="calc"/>
		<!-- -->
		<xsl:variable name="len" select="string-length($calc)"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="$len &gt; 1 and substring($calc,1,1)='&quot;' and substring($calc,$len,1)='&quot;'">
				<xsl:value-of select="substring($calc,2,$len - 2)"/>
			</xsl:when>
			<xsl:when test="contains($calc,'::')">
				<xsl:value-of select="concat('&lt;&lt;',$calc,'&gt;&gt;')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$calc"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
