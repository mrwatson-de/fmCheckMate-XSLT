<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xalan="http://xml.apache.org/xalan" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: _inc/fn.BaseFunctions.xsl

	XML-Source: any.xml
	XML-Grammar: any
	XML-Content: any

	Functions for processing bases (base 16 and bits).
	
	===== CHANGES HISTORY =====
	2022-05-10 MrW: Version 1.1.1 Added parameter checking to fn.BitwiseOr
	2022-05-10 MrW: Version 1.1 Added fn.BitwiseOr, fn.BitwiseAnd, fn.BitwiseXor
	2013-05-16 MrW: Version 1.0

	-->
	<!-- ===== TEMPLATES ===== -->
	<!-- fn.BitwiseOr
	 ! Performs a bitwise OR on number1 and number2
	 !-->
	<xsl:template name="fn.BitwiseOr">
		<xsl:param name="number1"/>
		<xsl:param name="number2"/>
		<xsl:param name="bit" select="1"/>
		<!-- -->
		<xsl:variable name="bit0">
			<xsl:choose>
				<xsl:when test="$bit &lt; 1">
					<xsl:value-of select="1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="floor($bit)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="string(number($number1))='NaN'">
				<xsl:value-of select="'ERROR: number1 is NaN'"/>
			</xsl:when>
			<xsl:when test="string(number($number2))='NaN'">
				<xsl:value-of select="'ERROR: number2 is NaN'"/>
			</xsl:when>
			<xsl:when test="string(number($bit))='NaN'">
				<xsl:value-of select="'ERROR: bit is NaN'"/>
			</xsl:when>
			<xsl:when test="$bit0 &gt; $number1 and $bit0 &gt; $number2">
				<xsl:value-of select="$number1"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="bit1" select="floor($number1 div $bit0) mod 2"/>
				<xsl:variable name="bit2" select="floor($number2 div $bit0) mod 2"/>
				<xsl:value-of select="concat($number1,'#',$number2,'#',$bit0,':',$bit1,'|',$bit2,'…')"/>
				<xsl:call-template name="fn.BitwiseOr">
					<xsl:with-param name="number1" select="$number1 + number($bit1=0 and $bit2=1) * $bit0"/>
					<xsl:with-param name="number2" select="$number2"/>
					<xsl:with-param name="bit" select="$bit0 * 2"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- fn.BitwiseAnd
	 ! Performs a bitwise AND on number1 and number2
	 !-->
	<xsl:template name="fn.BitwiseAnd">
		<xsl:param name="number1"/>
		<xsl:param name="number2"/>
		<xsl:param name="bit" select="1"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="$bit &gt; $number1 and $bit &gt; $number2">
				<xsl:value-of select="$number1"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="bit1" select="floor($number1 div $bit) mod 2"/>
				<xsl:variable name="bit2" select="floor($number2 div $bit) mod 2"/>
				<xsl:call-template name="fn.BitwiseAnd">
					<xsl:with-param name="number1" select="$number1 - number($bit1=1 and $bit2=0) * $bit"/>
					<xsl:with-param name="number2" select="$number2"/>
					<xsl:with-param name="bit" select="$bit * 2"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- fn.BitwiseXor
	 ! Performs a bitwise XOR on number1 and number2
	 !-->
	<xsl:template name="fn.BitwiseXor">
		<xsl:param name="number1"/>
		<xsl:param name="number2"/>
		<xsl:param name="bit" select="1"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="$bit &gt; $number1 and $bit &gt; $number2">
				<xsl:value-of select="$number1"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="bit1" select="floor($number1 div $bit) mod 2"/>
				<xsl:variable name="bit2" select="floor($number2 div $bit) mod 2"/>
				<xsl:call-template name="fn.BitwiseXor">
					<xsl:with-param name="number1" select="$number1 +(number($bit1=0 and $bit2=0) - number($bit1=1 and $bit2=1)) * $bit"/>
					<xsl:with-param name="number2" select="$number2"/>
					<xsl:with-param name="bit" select="$bit * 2"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
