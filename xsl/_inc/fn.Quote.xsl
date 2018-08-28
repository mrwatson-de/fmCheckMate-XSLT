<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: fn.Quote.xsl

	XML-Source: any.xml
	XML-Grammar: any
	XML-Content: any

	Quote function as in FileMaker.

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2011-2016
	2013-05-10 MrW: Version 1.1 Corrected
	2011-06-08 MrW: Version 1.0
	-->
	<!-- ===== TEMPLATES ===== -->
	<!-- 
	 ! fn.Quote function 
	 !-->
	<xsl:template name="fn.Quote">
		<xsl:param name="text"/>
		<!---->
		<xsl:text>&quot;</xsl:text>
		<xsl:call-template name="fn.Substitute">
			<xsl:with-param name="text">
				<xsl:call-template name="fn.Substitute">
					<xsl:with-param name="text">
						<xsl:call-template name="fn.Substitute">
							<xsl:with-param name="text" select="$text"/>
							<xsl:with-param name="searchString" select="'\\'"/>
							<xsl:with-param name="replaceString" select="'\\\\'"/>
						</xsl:call-template>
					</xsl:with-param>
					<xsl:with-param name="searchString" select="$QUOT"/>
					<xsl:with-param name="replaceString" select="concat('\\',$QUOT)"/>
				</xsl:call-template>
			</xsl:with-param>
			<xsl:with-param name="searchString" select="'¶'"/>
			<xsl:with-param name="replaceString" select="'\¶'"/>
		</xsl:call-template>
		<xsl:text>&quot;</xsl:text>
	</xsl:template>
	<!-- 
	 ! fn.Unquote function
	 ! Similar to the FileMaker evaluate function but only for quoted text string, returning the unquoted string.
	 !-->
	<xsl:template name="fn.Unquote">
		<xsl:param name="text"/>
		<!---->
		<xsl:variable name="textInhalt" select="substring($text,1,string-length($text)-2)"/>
		<xsl:text>&quot;</xsl:text>
		<xsl:call-template name="fn.Substitute">
			<xsl:with-param name="text">
				<xsl:call-template name="fn.Substitute">
					<xsl:with-param name="text" select="$text"/>
					<xsl:with-param name="searchString" select="concat('\\',$QUOT)"/>
					<xsl:with-param name="replaceString" select="$QUOT"/>
				</xsl:call-template>
			</xsl:with-param>
			<xsl:with-param name="searchString" select="'\\'"/>
			<xsl:with-param name="replaceString" select="'\\\\'"/>
		</xsl:call-template>
		<xsl:text>&quot;</xsl:text>
	</xsl:template>
</xsl:stylesheet>
