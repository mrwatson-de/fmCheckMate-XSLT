<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: fn.SubstringFunctions.xsl

	XML-Source: any.xml
	XML-Grammar: any
	XML-Content: any

	Functions for processing sub-strings.

	===== CHANGES HISTORY =====
	2013-11-15 MrW SubstringFunctions sepearated from StringFunctions
	2013-06-25 MrW Added fn.Filter
	2011-01-13 MrW: Version 1.0
	-->
	<!-- ===== TEMPLATES ===== -->
	<!-- 
	 ! fn.substring-before-first function 
	 !
	 !   Returns everything before the first occurrence of searchString in the text (or the entire text)
	 !-->
	<xsl:template name="fn.substring-before-first">
		<xsl:param name="text"/>
		<xsl:param name="searchString"/>
		<xsl:value-of select="substring-before(concat($text,$searchString),$searchString)"/>
	</xsl:template>
	<!-- 
	 ! fn.substring-before-first-Multiple-QnD function 
	 !
	 !   Returns everything before the first occurrence in the text of any of the values in the searchValues
	 !   (or the entire text)
	 !   Use the PIPE character ("|") to delimit multiple searchStrings.
	 !
	 !   QnD = Quick and dirty solution, which assumes the search terms don't 'overlap'. E.g. 
	 !         If $text = 'Who owns the browner cow?' and $searchString='owner|brown'
	 !         this function will return 'Who owns the br' instead of 'Who owns the '
	 !-->
	<xsl:template name="fn.substring-before-first-Multiple-QnD">
		<xsl:param name="text"/>
		<xsl:param name="searchValues"/>
		<xsl:choose>
			<xsl:when test="$searchValues=''">
				<xsl:value-of select="$text"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="fn.substring-before-first-Multiple-QnD_recurse">
					<xsl:with-param name="text">
						<xsl:value-of select="$text"/>
					</xsl:with-param>
					<xsl:with-param name="searchValues">
						<xsl:choose>
							<xsl:when test="substring($searchValues,string-length($searchValues))='|'">
								<xsl:value-of select="$searchValues"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($searchValues,'|')"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="fn.substring-before-first-Multiple-QnD_recurse">
		<xsl:param name="text"/>
		<xsl:param name="searchValues"/>
		<xsl:variable name="thisSearchString" select="substring-before($searchValues,'|')"/>
		<!-- 
		<xsl:value-of select="'        DEBUG: '"/>
		<xsl:value-of select="'fn.substring-before-first-Multiple-QnD_recurse('"/>
		<xsl:value-of select="'´'"/>
		<xsl:value-of select="$text"/>
		<xsl:value-of select="'´'"/>
		<xsl:value-of select="';'"/>
		<xsl:value-of select="'´'"/>
		<xsl:value-of select="$searchValues"/>
		<xsl:value-of select="'´'"/>
		<xsl:value-of select="')'"/>
		<xsl:value-of select="', $thisSearchString=´'"/>
		<xsl:value-of select="$thisSearchString"/>
		<xsl:value-of select="'´'"/>
		<xsl:value-of select="$newrecord"/>
		-->
		
		<xsl:choose>
			<xsl:when test="$searchValues=''">
				<xsl:value-of select="$text"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- recurse whilst shortening -->
				<xsl:call-template name="fn.substring-before-first-Multiple-QnD_recurse">
					<xsl:with-param name="text">
						<xsl:choose>
							<xsl:when test="$thisSearchString!='' and contains($text,$thisSearchString)">
								<xsl:value-of select="substring-before(concat($text,$thisSearchString),$thisSearchString)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$text"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="searchValues" select="substring-after($searchValues,'|')"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- 
	 ! fn.substring-after-first function 
	 !
	 !   Returns everything following the first occurrence of searchString in the text (or the entire text)
	 !-->
	<xsl:template name="fn.substring-after-first">
		<xsl:param name="text"/>
		<xsl:param name="searchString"/>
		<xsl:choose>
			<xsl:when test="contains($text, $searchString)">
				<xsl:value-of select="substring-after($text, $searchString)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- 
	 ! fn.substring-after-last function 
	 !
	 !   Returns everything following the last occurrence of searchString in the text (or the entire text)
	 !-->
	<xsl:template name="fn.substring-after-last">
		<xsl:param name="text"/>
		<xsl:param name="searchString"/>
		<xsl:choose>
			<xsl:when test="$searchString!='' and contains($text, $searchString)">
				<xsl:call-template name="fn.substring-after-last">
					<xsl:with-param name="text" select="substring-after($text, $searchString)"/>
					<xsl:with-param name="searchString" select="$searchString"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- 
	 ! fn.Filter( text ; chars ) function 
	 !
	 !   Returns the text only using the chars ~ like the FileMaker function of the same name
	 !-->
	<xsl:template name="fn.Filter">
		<xsl:param name="text"/>
		<xsl:param name="chars"/>
		<!--  -->
		<xsl:value-of select="translate($text,translate($text,$chars,''),'')"/>
	</xsl:template>
</xsl:stylesheet>
