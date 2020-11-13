<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" version="1.0" exclude-result-prefixes="exsl">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: fn.cssText2.xsl

	XML-Source: any.xml
	XML-Grammar: any
	XML-Content: any

	More functions for processing CSS text.

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2019-09-16 MrW: Version 1.0
	-->
	<!--
	 ! List each CSS-element in the given CSS, with attributes indented
	 ! -->
	<xsl:template name="List-CSS">
		<xsl:param name="css"/>
		<xsl:param name="indent"/>
		<!--  -->
		<xsl:call-template name="List-CSS-normalized">
			<!-- normalise space and add a space at the beginning so that selection also works for the first element -->
			<xsl:with-param name="css" select="normalize-space(concat(' ',$css))"/>
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:call-template>
	</xsl:template>
	<!--
	 ! List each CSS-element in the given CSS, with attributes indented
	 !-->
	<xsl:template name="List-CSS-normalized">
		<xsl:param name="css" select="''"/>
		<xsl:param name="indent"/>
		<!--  -->
		<xsl:variable name="cssElement1" select="concat(substring-before($css,'}'),'}')"/>
		<xsl:variable name="name" select="normalize-space(substring-before($cssElement1,'{'))"/>
		<xsl:variable name="value" select="concat(' ', normalize-space(substring-before(substring-after($cssElement1,'{'),'}')))"/>
		<xsl:variable name="rest" select="substring-after($css,'}')"/>
		<!--  -->
		<!-- output item 1-->
		<xsl:if test="$name!='}'">
			<xsl:value-of select="$indent"/>
			<xsl:value-of select="$name"/>
			<xsl:value-of select="':'"/>
			<xsl:value-of select="'&#10;'"/>
			<xsl:call-template name="List-CSS-Attributes-normalized">
				<xsl:with-param name="cssAttributes" select="$value"/>
				<xsl:with-param name="indent" select="$indent"/>
			</xsl:call-template>
		</xsl:if>
		<!-- recurse -->
		<xsl:if test="string-length($rest)&gt;2">
			<xsl:call-template name="List-CSS-normalized">
				<xsl:with-param name="css" select="$rest"/>
				<xsl:with-param name="indent" select="$indent"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<!--
	 ! List each CSS-attribute on a line: "	name: value;"
	 !-->
	<xsl:template name="List-CSS-Attributes-normalized">
		<xsl:param name="cssAttributes" select="''"/>
		<xsl:param name="indent" select="''"/>
		<!--  -->
		<xsl:variable name="cssAttribute1" select="concat(substring-before($cssAttributes,';'),';')"/>
		<xsl:variable name="name" select="normalize-space(substring-before($cssAttribute1,':'))"/>
		<xsl:variable name="value" select="normalize-space(substring-before(substring-after($cssAttribute1,':'),';'))"/>
		<xsl:variable name="rest" select="substring-after($cssAttributes,';')"/>
		<!--  -->
		<!-- output attribute 1-->
		<xsl:value-of select="$indent"/>
		<xsl:value-of select="'&#9;'"/>
		<xsl:value-of select="$name"/>
		<xsl:value-of select="': '"/>
		<xsl:value-of select="$value"/>
		<xsl:value-of select="';'"/>
		<xsl:value-of select="'&#10;'"/>
		<!-- recurse -->
		<xsl:if test="string-length($rest)&gt;2">
			<xsl:call-template name="List-CSS-Attributes-normalized">
				<xsl:with-param name="cssAttributes" select="$rest"/>
				<xsl:with-param name="indent" select="$indent"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
