<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XML2_Text.Lines_ListLocalCSSAttributes.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: fmp12 layout objects
	
	Lists Objects and their CSS properties.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2019-09-16 MrW: Version 1.1 - Made to work with FMDT, inc. Local CSS for Layout-Part, plus CSS-functions refactored into external include file 
	2011-12-28 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.cssText2.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!--  -->
	<xsl:template match="/">
		<xsl:for-each select="//LocalCSS/ancestor::*[name()='Object' or name()='LayoutObject' or name()='Part'][1]">
			<xsl:apply-templates select="ancestor::Layout[1]"/>
			<xsl:value-of select="' &gt; '"/>
			<xsl:apply-templates select="."/>
			<xsl:value-of select="$newrecord"/>
			<!--	Main formatting		-->
			<xsl:apply-templates select=".//LocalCSS[not(ancestor::ConditionalFormatting)]"/>
			<!--	Conditional formatting		-->
			<xsl:for-each select="ConditionalFormatting/Item[//LocalCSS]">
				<xsl:apply-templates select="Condition"/>
				<xsl:apply-templates select="Format/Styles/LocalCSS"/>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>
	
	<!-- 
	 !
	 ! CSS-noch dynamisch zu generieren
		
		
		
		/fmxmlsnippet/Layout[1]/Object[1]/ConditionalFormatting[1]/Item[1]/Format[1]/Styles[1]/LocalCSS[1]
		
	 !-->
	<xsl:template match="LocalCSS">
		<xsl:call-template name="List-CSS">
			<xsl:with-param name="css" select="//LocalCSS"/>
			<xsl:with-param name="indent" select="'&#9;'"/>
		</xsl:call-template>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>

	<!-- Output Layout info-->
	<xsl:template match="Layout">
		<xsl:value-of select="concat('Layout ', @name)"/>
	</xsl:template>
	
	<!-- Output Object info-->
	<xsl:template match="Object">
		<xsl:value-of select="concat('Object ', @type)"/>
		<xsl:apply-templates select="Bounds"/>
	</xsl:template>
	
	<!-- Output FMDT LayoutObject info-->
	<xsl:template match="LayoutObject">
		<xsl:value-of select="concat('Object ', @type)"/>
		<xsl:apply-templates select="Bounds"/>
	</xsl:template>
	
	<!-- Output FMDT Part info-->
	<xsl:template match="Part">
		<xsl:value-of select="concat('Part ', @type, ' top ', Definition/@absolute, ' size ', Definition/@size)"/>
	</xsl:template>
	
	<!-- Output Condition-->
	<xsl:template match="Condition">
		<xsl:value-of select="$TAB"/>
		<xsl:value-of select="' &gt; '"/>
		<xsl:value-of select="concat('Condition = ', translate(Calculation, $CRLF, ''))"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	
	<!--  -->
	<xsl:template match="Bounds">
		<xsl:value-of select="concat('(',@left,',',@top,';',@right,',',@bottom,';',@right - @left,'x',@bottom - @top,')')"/>
	</xsl:template>
	
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
