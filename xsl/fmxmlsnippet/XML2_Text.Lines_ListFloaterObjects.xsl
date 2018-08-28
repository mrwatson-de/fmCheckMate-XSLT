<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" xmlns:str="http://exslt.org/strings" extension-element-prefixes="str date" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XML2_Text.Lines_ListFloaterObjects.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	Returns a list of all objects that are 'floating' over or hidden behind their containers. 
	(Container = tab, portal or slider. Popovers are not included, as it 
	is quite natural for objects to lie behind them.)
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2016
	2014-07-07 MrW: Version 0.9
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.GetAbsoluteBounds.xsl"/>
	<!--xsl:include href="../../../fmCheckMate/xsl/_inc/XML2_fn.toString.xsl"/-->
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- List floatingobjects
	 !
	 ! The condition is that an object at level T may not have coordinates 
	 ! inside another container-object at level T.
	 ! 
	 !-->
	<xsl:template match="Object[@type='Portal' or @type='SlideControl' or @type='TabControl']">
		<xsl:variable name="left" select="number(Bounds/@left)"/>
		<xsl:variable name="top" select="number(Bounds/@top)"/>
		<xsl:variable name="right" select="number(Bounds/@right)"/>
		<xsl:variable name="bottom" select="number(Bounds/@bottom)"/>
		<xsl:variable name="container">
			<xsl:apply-templates select="." mode="toString"/>
		</xsl:variable>
		<xsl:variable name="floaters">
			<xsl:for-each select="preceding-sibling::Object">
				<xsl:choose>
					<xsl:when test="number(Bounds/@left) &gt;= $left and number(Bounds/@top) &gt;= $top and number(Bounds/@right) &lt;= $right and number(Bounds/@bottom) &lt;= $bottom">
						<xsl:value-of select="'LAYOUT ERROR: '"/>
						<xsl:apply-templates select="." mode="toString"/>
						<xsl:value-of select="' IS HIDDEN BEHIND '"/>
						<xsl:value-of select="$container"/>
						<xsl:value-of select="$newrecord"/>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
			<xsl:for-each select="following-sibling::Object">
				<xsl:choose>
					<xsl:when test="number(Bounds/@left) &gt;= $left and number(Bounds/@top) &gt;= $top and number(Bounds/@right) &lt;= $right and number(Bounds/@bottom) &lt;= $bottom">
						<xsl:value-of select="'LAYOUT ERROR: '"/>
						<xsl:apply-templates select="." mode="toString"/>
						<xsl:value-of select="' IS FLOATING IN FRONT OF '"/>
						<xsl:value-of select="$container"/>
						<xsl:value-of select="$newrecord"/>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</xsl:variable>
		<!-- -->
		<xsl:if test="$floaters != ''">
			<xsl:value-of select="$floaters"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:if>
		<xsl:apply-templates select="*"/>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
	
	<xsl:template match="Object" mode="toString">
		<!-- -->
		<xsl:choose>
			<xsl:when test="@type='Portal'">
				<xsl:value-of select="@type"/>
				<xsl:value-of select="' '"/>
				<xsl:value-of select="$APOS"/>
				<xsl:value-of select="//TableAliasKey"/>
				<xsl:value-of select="$APOS"/>
			</xsl:when>
			<xsl:when test="@type='SlideControl'">
				<xsl:value-of select="@type"/>
			</xsl:when>
			<xsl:when test="@type='TabControl'">
				<xsl:value-of select="@type"/>
				<xsl:value-of select="' '"/>
				<xsl:value-of select="$APOS"/>
				<!-- fmp11 TabPanel with static name: -->
				<xsl:value-of select="TabControlObj/TabPanelObj/TextObj/CharacterStyleVector/Style/Data"/>
				<!-- fmp12 TabPanel with calculated name: -->
				<xsl:value-of select="TabControlObj/Object[@type='TabPanel']/TitleCalc/Calculation"/>
				<xsl:value-of select="$APOS"/>
			</xsl:when>
			<xsl:when test="@type='Field'">
				<xsl:value-of select="@type"/>
				<xsl:value-of select="' '"/>
				<xsl:value-of select="$APOS"/>
				<xsl:value-of select="FieldObj/Name"/>
				<xsl:value-of select="$APOS"/>
			</xsl:when>
			<xsl:when test="@type='Text'">
				<xsl:value-of select="@type"/>
				<xsl:value-of select="' '"/>
				<xsl:value-of select="$APOS"/>
				<xsl:value-of select="TextObj/CharacterStyleVector/Style/Data"/>
				<xsl:value-of select="$APOS"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="@type"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="' '"/>
		<xsl:apply-templates match="Bounds" mode="toString"/>
	</xsl:template>
	<!-- Bounds.toString -->
	<xsl:template match="Bounds" mode="toString">
		<xsl:apply-templates select="." mode="GetAbsoluteBoundsAsNumber"/>
	</xsl:template>
	<!-- ===== IGNORE TEXT ===== -->
	<xsl:template match="text()" mode="toString"/>
	<xsl:template match="/ | *" mode="toString"/>
	
</xsl:stylesheet>
