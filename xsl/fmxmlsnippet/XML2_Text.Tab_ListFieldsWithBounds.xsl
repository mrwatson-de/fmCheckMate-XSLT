<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XML2_Text.Tab_ListFieldsWithBounds.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: fmp12 layout objects
	
	Lists object tree details
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2017
	2017-08-18 MrW: V1
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fn.toString.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.GetAbsoluteBounds.xsl"/>
	<!-- ===== KEYS ===== -->
	<xsl:key name="ObjectParent" match="Object/ancestor::Object[1]" use="."/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- -->
	<xsl:variable name="char" select="'- '"/>
	<xsl:variable name="char1" select="concat($char,$char,$char,$char)"/>
	<xsl:variable name="char2" select="concat($char1,$char1,$char1,$char1)"/>
	<xsl:variable name="char3" select="concat($char2,$char2,$char2,$char2)"/>
	<xsl:variable name="char4" select="concat($char3,$char3,$char3,$char2)"/>
	<!-- ===== TEMPLATES ===== -->
	<!--
	 ! Main
	 !-->
	<xsl:template match="/">
		<!-- Headings -->
		<xsl:value-of select="'Table'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Field'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'BoundsLeft'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'BoundsTop'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'BoundsRight'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'BoundsBottom'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'BoundsWidth'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'BoundsHeight'"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="'-'"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:apply-templates select="//Layout"/>
		<xsl:apply-templates select="//Object"/>
	</xsl:template>
	<!-- 
	 ! Layout
	 ! -->
	<!--xsl:template match="Layout">
		<xsl:value-of select="'Layout Snippet Bounds'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="concat(@enclosingRectLeft - 0,$delimiter,@enclosingRectTop - 0,$delimiter,$delimiter,@enclosingRectRight - @enclosingRectLeft,$delimiter,@enclosingRectBottom - @enclosingRectTop,$delimiter,@enclosingRectRight - 0,$delimiter,@enclosingRectBottom - 0,$delimiter)"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template-->
	<!--
	 ! Output Field info
	 !-->
	<xsl:template match="Object[@type='Field']">
		<xsl:value-of select="FieldObj/DDRInfo/Field/@table"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="FieldObj/DDRInfo/Field/@name"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:apply-templates select="Bounds" mode="LeftTopRightBottomWidthHeight"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!--  -->
	<xsl:template match="Bounds" mode="LeftTopRightBottomWidthHeight">
		<xsl:value-of select="concat(@left - 0,$delimiter,@top - 0,$delimiter,@right - 0,$delimiter,@bottom - 0,$delimiter,@right - @left,$delimiter,@bottom - @top)"/>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
