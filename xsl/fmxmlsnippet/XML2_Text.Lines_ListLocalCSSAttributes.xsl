<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2014 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XML2_Text.Lines_ListLocalCSSAttributes.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: fmp12 layout objects
	
	Lists Objects and their CSS properties.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2011-2014
	2011-12-28 MrW: 
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!--  -->
	<xsl:template match="/">
		<xsl:for-each select="//LocalCSS">
			<xsl:apply-templates select="."/>
		</xsl:for-each>
	</xsl:template>
	
	<!-- Convert GroupButton objects to button objects
	 !
	 ! GROB (CSS-noch dynamisch zu generieren)
	 !-->
	<xsl:template match="LocalCSS">
		<xsl:apply-templates select="ancestor::Object"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:call-template name="List-CSS">
			<xsl:with-param name="css" select="//LocalCSS"/>
		</xsl:call-template>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!--  -->
	<!-- List each CSS-element in the given CSS, with attributes indented -->
	<xsl:template name="List-CSS">
		<xsl:param name="css"/>
		<!--  -->
		<xsl:call-template name="List-CSS-normalized">
			<!-- normalise space and add a space at the beginning so that selection also works for the first element -->
			<xsl:with-param name="css" select="normalize-space(concat(' ',$css))"/>
		</xsl:call-template>
	</xsl:template>
	<!-- List each CSS-element in the given CSS, with attributes indented -->
	<xsl:template name="List-CSS-normalized">
		<xsl:param name="css" select="''"/>
		<!--  -->
		<xsl:variable name="cssElement1" select="concat(substring-before($css,'}'),'}')"/>
		<xsl:variable name="name" select="normalize-space(substring-before($cssElement1,'{'))"/>
		<xsl:variable name="value" select="concat(' ', normalize-space(substring-before(substring-after($cssElement1,'{'),'}')))"/>
		<xsl:variable name="rest" select="substring-after($css,'}')"/>
		<!--  -->
		<!-- output item 1-->
		<xsl:if test="$name!='}'">
			<xsl:value-of select="$name"/>
			<xsl:value-of select="':'"/>
			<xsl:value-of select="$newrecord"/>
			<xsl:call-template name="List-CSS-Attributes-normalized">
				<xsl:with-param name="cssAttributes" select="$value"/>
			</xsl:call-template>
		</xsl:if>
		<!-- recurse -->
		<xsl:if test="string-length($rest)&gt;2">
			<xsl:call-template name="List-CSS-normalized">
				<xsl:with-param name="css" select="$rest"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<!-- List each CSS-attribute on a line: "	name: value;" -->
	<xsl:template name="List-CSS-Attributes-normalized">
		<xsl:param name="cssAttributes" select="''"/>
		<!--  -->
		<xsl:variable name="cssAttribute1" select="concat(substring-before($cssAttributes,';'),';')"/>
		<xsl:variable name="name" select="normalize-space(substring-before($cssAttribute1,':'))"/>
		<xsl:variable name="value" select="normalize-space(substring-before(substring-after($cssAttribute1,':'),';'))"/>
		<xsl:variable name="rest" select="substring-after($cssAttributes,';')"/>
		<!--  -->
		<!-- output attribute 1-->
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="$name"/>
		<xsl:value-of select="': '"/>
		<xsl:value-of select="$value"/>
		<xsl:value-of select="';'"/>
		<xsl:value-of select="$newrecord"/>
		<!-- recurse -->
		<xsl:if test="string-length($rest)&gt;2">
			<xsl:call-template name="List-CSS-Attributes-normalized">
				<xsl:with-param name="cssAttributes" select="$rest"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<!-- Output object info-->
	<xsl:template match="Object">
		<xsl:value-of select="concat('Object ', @type)"/>
		<xsl:apply-templates select="Bounds"/>
	</xsl:template>
	
	<!--  -->
	<xsl:template match="Bounds">
		<xsl:value-of select="concat('(',@left,',',@top,';',@right,',',@bottom,';',@right - @left,'x',@bottom - @top,')')"/>
	</xsl:template>
	
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
