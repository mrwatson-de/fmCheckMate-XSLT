<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: fn.SubstringFunctions.xsl

	XML-Source: any.xml
	XML-Grammar: any
	XML-Content: any

	Functions for tokenizing sub-strings.

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2014-09-25 MrW Added fn.TokenizeString and fn.ItemizeString
	2014-05-28 MrW UNDER CONSTRUCTION
	-->
	<!-- ===== TEMPLATES ===== -->
	<!-- fn.TokenizeString( text, delimiter)
	 ! Splits the string using the delimiter and packs the parts in a <Token> element.
	 !-->
	<xsl:template name="fn.TokenizeString">
		<xsl:param name="text"/>
		<xsl:param name="delimiter"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="contains($text,$delimiter)">
				<Token>
					<xsl:value-of select="substring-before($text,$delimiter)"/>
				</Token>
				<xsl:call-template name="fn.TokenizeString">
					<xsl:with-param name="text" select="substring-after($text,$delimiter)"/>
					<xsl:with-param name="delimiter" select="$delimiter"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<Token>
					<xsl:value-of select="$text"/>
				</Token>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- 
	 ! fn.TokenizeNameValuePair( text ; equalsPattern ; delimiterPattern ) function 
	 !
	 !   Makes sure text has a delimiter at the end then 
	 !   returns <Name>name</Name><Value>value</Value> pairs
	 !-->
	<xsl:template name="fn.TokenizeNameValuePairs">
		<xsl:param name="text"/>
		<xsl:param name="equalsPattern"/>
		<xsl:param name="delimiterPattern"/>
		<!-- Add final delimiter to simplify logic -->
		<xsl:call-template name="fn.TokenizeNameValuePairs2">
			<xsl:with-param name="text" select="concat($text,$delimiterPattern)"/>
			<xsl:with-param name="equalsPattern" select="equalsPattern"/>
			<xsl:with-param name="delimiterPattern" select="delimiterPattern"/>
		</xsl:call-template>
	</xsl:template>
	<!-- 
	 ! fn.TokenizeNameValuePair2( text ; equalsPattern ; delimiterPattern ) function 
	 !
	 !   Returns <Name>name</Name><Value>value</Value> pairs
	 !-->
	<xsl:template name="fn.TokenizeNameValuePairs2">
		<xsl:param name="text"/>
		<xsl:param name="equalsPattern"/>
		<xsl:param name="delimiterPattern"/>
		<!--  -->
		<xsl:choose>
			<xsl:when test="$text=''">
				<!-- finished -->
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="nameValue" select="substring-before($text,$delimiterPattern)"/>
				<xsl:element name="Name">
					<xsl:value-of select="substring-before(concat($nameValue,$equalsPattern),$equalsPattern)"/>
				</xsl:element>
				<xsl:element name="Value">
					<xsl:value-of select="substring-after($nameValue,$equalsPattern)"/>
				</xsl:element>
				<!-- recurse next line -->
				<xsl:call-template name="fn.TokenizeNameValuePairs2">
					<xsl:with-param name="text" select="substring-after($text,$delimiterPattern)"/>
					<xsl:with-param name="equalsPattern" select="equalsPattern"/>
					<xsl:with-param name="delimiterPattern" select="delimiterPattern"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- fn.ItemizeString( text, delimiter)
	 ! Same as fn.TokenizeString except that it uses <Item> elements instead of <Token> elements
	 ! Splits the string using the delimiter and packs the parts in a <Item> element.
	 !-->
	<xsl:template name="fn.ItemizeString">
		<xsl:param name="text"/>
		<xsl:param name="delimiter"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="contains($text,$delimiter)">
				<Item>
					<xsl:value-of select="substring-before($text,$delimiter)"/>
				</Item>
				<xsl:call-template name="fn.ItemizeString">
					<xsl:with-param name="text" select="substring-after($text,$delimiter)"/>
					<xsl:with-param name="delimiter" select="$delimiter"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<Item>
					<xsl:value-of select="$text"/>
				</Item>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
