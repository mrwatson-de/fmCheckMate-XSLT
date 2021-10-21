<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2021 MrWatson, russell@mrwatson.de All Rights Reserved. ===== PURPOSE =====

	===== PURPOSE =====
	
	XSL-File: fn.Quote.xsl

	XML-Source: any.xml
	XML-Grammar: any
	XML-Content: any

	Quote function as in FileMaker.

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2021

	2021-10-21 MrW: Version 1.2.1 Improved Comment
	2021-09-02 MrW: Version 1.2 Fixed fn.Unquote to unquote strings as FileMaker (¶->EOL)
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
	 !
	 !-->
	<xsl:template name="fn.Unquote">
		<xsl:param name="text"/>
		<!---->
		<!-- Remove outer quotes and unescape inner string via recursion -->
		<xsl:call-template name="fn.UnquoteRecurse">
			<xsl:with-param name="text" select="substring($text,2,string-length($text)-2)"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="fn.UnquoteRecurse">
		<xsl:param name="text"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="not(contains($text,'\\'))">
				<!-- Output text, converting ¶ to EOL on the way -->
				<xsl:call-template name="fn.UnquoteExpandEOL">
					<xsl:with-param name="text" select="$text"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="remaining" select="substring-after($text,'\\')"/>
				<xsl:variable name="char1" select="substring($remaining,1,1)"/>
				<!-- -->
				<!-- Output everything before the backslash, converting ¶ to EOL on the way -->
				<xsl:call-template name="fn.UnquoteExpandEOL">
					<xsl:with-param name="text" select="substring-before($text,'\\')"/>
				</xsl:call-template>
				<xsl:choose>
					<xsl:when test="contains('&quot;¶\\',$char1)">
						<!-- Output the escaped character... -->
						<xsl:value-of select="$char1"/>
						<!-- ...and recurse, skipping the escaped character -->
						<xsl:call-template name="fn.UnquoteRecurse">
							<xsl:with-param name="text" select="substring($remaining,2)"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<!-- Output the literal backslash... -->
						<xsl:value-of select="'\\'"/>
						<!-- ...and recurse over the rest of the text -->
						<xsl:call-template name="fn.UnquoteRecurse">
							<xsl:with-param name="text" select="$remaining"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="fn.UnquoteExpandEOL">
		<xsl:param name="text"/>
		<!-- -->
		<xsl:value-of select="translate($text,'¶','&#13;')"/>
		<!-- FIXME - WHAT IS THE CORRECT EOL CHARACTER ? -->
		<xsl:choose>
			<xsl:when test="1=1">
				<!-- IGNORE THIS WHOLE CHOOSE BIT -->
			</xsl:when>
			<xsl:when test="not(contains($text,'¶'))">
				<!-- Output text as is -->
				<xsl:value-of select="$text"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- Output everything before the ¶ -->
				<xsl:value-of select="concat(substring-before($text,'¶'),'&#13;&#10;')"/>
				<!-- ...and recurse -->
				<xsl:call-template name="fn.UnquoteExpandEOL">
					<xsl:with-param name="text" select="substring-after($text,'¶')"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
