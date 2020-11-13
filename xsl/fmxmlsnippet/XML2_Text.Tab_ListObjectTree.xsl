<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XML2_Text.Tab_ListObjectTree.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: fmp12 layout objects
	
	Lists object tree details
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2011-12-28 MrW: 
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
		<xsl:value-of select="'Layout Objects'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'(left, top)'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'width x height'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'(right, bottom)'"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="'-'"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:apply-templates select="//Layout"/>
		<xsl:apply-templates select="//Object"/>
	</xsl:template>
	<!-- 
	 ! Layout
	 ! -->
	<xsl:template match="Layout">
		<xsl:value-of select="'Layout Snippet Bounds'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="concat('(',@enclosingRectLeft - 0,',',@enclosingRectTop - 0,')',$delimiter,@enclosingRectRight - @enclosingRectLeft,' x ',@enclosingRectBottom - @enclosingRectTop,$delimiter,'(',@enclosingRectRight - 0,',',@enclosingRectBottom - 0,')')"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!--
	 ! Output object info
	 !-->
	<xsl:template match="Object">
		<xsl:call-template name="indent"/>
		<!--xsl:apply-templates select="." mode="toString"/-->
		<xsl:call-template name="getDescriptionOfCurrentNode"/>
		<!--xsl:value-of select="concat('Object ', @type)"/>
		<xsl:choose>
			<xsl:when test="@type='Field'">
				<xsl:value-of select="' '"/>
				<xsl:value-of select="$QUOT"/>
				<xsl:value-of select="FieldObj/Name"/>
				<xsl:value-of select="$QUOT"/>
			</xsl:when>
			<xsl:when test="@type='Text'">
				<xsl:variable name="text" select="TextObj/ParagraphStyleVector/Style/Data"/>
				<xsl:value-of select="' '"/>
				<xsl:value-of select="$QUOT"/>
				<xsl:value-of select="translate(substring($text,1,30),$TAB,' ')"/>
				<xsl:value-of select="$QUOT"/>
				<xsl:choose>
					<xsl:when test="$text='' or $text=' '">
						<xsl:value-of select="' EMPTY BACKGROUND?'"/>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="@type='ExternalObject'">
				<xsl:value-of select="concat(' (',ExternalObj/@typeID,')')"/>
			</xsl:when>
			<xsl:otherwise>
				
			</xsl:otherwise>
		</xsl:choose-->
		<!--xsl:apply-templates select="GroupButtonObj/Step"/-->
		<xsl:value-of select="$delimiter"/>
		<xsl:apply-templates select="Bounds" mode="explicit"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- Step -->
	<!--xsl:template match="Step">
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:call-template name="indent"/>
		<xsl:value-of select="concat('=&gt; ',@name,' ', Script/@name,' (', Calculation,')')"/>
	</xsl:template-->
	<!--  -->
	<xsl:template match="Bounds" mode="explicit">
		<xsl:choose>
			<xsl:when test="../../../GroupButtonObj and @top + @left = 0">
				<xsl:value-of select="concat($delimiter,$delimiter)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat('(',@left - 0,',',@top - 0,')',$delimiter,@right - @left,' x ',@bottom - @top,$delimiter,'(',@right - 0,',',@bottom - 0,')')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- indent -->
	<xsl:template name="indent">
		<xsl:variable name="n" select="count(ancestor::Object)"/>
		<!-- -->
		<xsl:value-of select="substring($char4,1,$n * string-length($char))"/>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
