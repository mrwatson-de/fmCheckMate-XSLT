<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: fn.NumberFunctions.xsl

	XML-Source: any.xml
	XML-Grammar: any
	XML-Content: any

	Functions for processing numbers.

	===== CHANGES HISTORY =====
	2013-06-24 MrW First number function: fn.GetAsNumber
	-->
	<!-- ===== TEMPLATES ===== -->
	<!-- 
	 ! fn.GetAsNumber( text ) function 
	 !
	 !   Returns the text as number ~ like the FileMaker function of the same name
	 !-->
	<xsl:template name="fn.GetAsNumber">
		<xsl:param name="text"/>
		<!--  -->
		<xsl:variable name="number" select="translate($text,translate($text,'0123456789.',''),'')"/>
		<xsl:variable name="digits" select="translate($number,'.','')"/>
		<!--  -->
		<xsl:choose>
			<xsl:when test="$digits=''">
				<!-- no digits ... = 0 -->
				<xsl:value-of select="0"/>
			</xsl:when>
			<xsl:when test="contains(substring-after($number,'.'),'.')">
				<!-- numbers with multiple dots -->
				<xsl:value-of select="number(concat(substring-before($number,'.'),'.',translate(substring-after($number,'.'),'.','')))"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- number with at most one dot -->
				<xsl:value-of select="number($number)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	 ! fn.HexNN( nr )
	 ! 
	 !   Returns two hexadecimal digits representing the number 
	 !-->
	<xsl:template name="fn.HexNN">
		<xsl:param name="nr"/>
		<!--  -->
		<xsl:variable name="hi" select="floor($nr div 16 mod 16)"/>
		<xsl:variable name="lo" select="floor($nr mod 16)"/>
		<!--  -->
		<xsl:value-of select="substring('0123456789ABCDEF',1+$hi,1)"/>
		<xsl:value-of select="substring('0123456789ABCDEF',1+$lo,1)"/>
	</xsl:template>
	<!--
	 ! fn.0x( hex )
	 ! 
	 !   Converts the hex to decimal.
	 !   Returns the decimal number represented by the hex string.
	 !-->
	<xsl:template name="fn.0x">
		<xsl:param name="hex"/>
		<!--  -->
		<xsl:variable name="restValue">
			<xsl:choose>
				<xsl:when test="string-length($hex)&gt;1">
					<xsl:call-template name="fn.0x">
						<xsl:with-param name="hex" select="substring($hex,1,string-length($hex)-1)"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="$restValue * 16 + string-length(substring-before('0123456789ABCDEF',substring($hex,string-length($hex))))"/>
	</xsl:template>
</xsl:stylesheet>
