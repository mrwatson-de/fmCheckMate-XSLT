<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XML2_XML2_StitchButtonsIntoButtonbars.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied fmp12 layout objects
	
	Stitches a button into the underlying buttonbar (replacing the button behind it).
	
	The text and icon of the button are retained.
	
	Conditional formatting and hide calculation of the button are retained *only if present* - otherwise the buttonbar button's values are kept. 

	The button's style is ignored.

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2022
	2022-02-22 MrW: Version 0.1
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Replace a button bar button with the first button in the same level as the button bar floating over it -->
	<xsl:template match="ButtonBarObj/Object[@type='Button']">
		<!-- -->
		
		<xsl:variable name="BBar" select="(ancestor::Object)[1]"/>
		<xsl:variable name="BBarBounds" select="$BBar/Bounds"/>

		<xsl:variable name="top" select="number(Bounds/@top) + number($BBarBounds/@top)"/>
		<xsl:variable name="bottom" select="number(Bounds/@bottom) + number($BBarBounds/@bottom)"/>
		<xsl:variable name="left" select="number(Bounds/@left) + number($BBarBounds/@left)"/>
		<xsl:variable name="right" select="number(Bounds/@right) + number($BBarBounds/@right)"/>

		<xsl:variable name="button" select="($BBar/following-sibling::Object[@type='Button' 
			and  (number(Bounds/@top)  + number(Bounds/@bottom)) div 2 &gt; $top
			and  (number(Bounds/@top)  + number(Bounds/@bottom)) div 2 &lt; $bottom
			and  (number(Bounds/@left) + number(Bounds/@right))  div 2 &gt; $left 
			and  (number(Bounds/@left) + number(Bounds/@right))  div 2 &lt; $right
			])[1]"/>
		<xsl:choose>
			<xsl:when test="$button">
				<xsl:copy>
					<xsl:apply-templates select="@*"/>
					<xsl:choose>
						<xsl:when test="$button/ConditionalFormatting">
							<xsl:copy-of select="$button/ConditionalFormatting"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:copy-of select="ConditionalFormatting"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:apply-templates select="Bounds"/>
					<xsl:apply-templates select="TextObj"/>
					<ButtonObj>
						<xsl:apply-templates select="ButtonObj/@*"/>
						<xsl:copy-of select="$button/ButtonObj/Step"/>
						<xsl:copy-of select="$button/ButtonObj/Stream"/>
					</ButtonObj>
					<LabelCalc>
						<Calculation>
							<xsl:call-template name="GetCalculationFromLayoutText">
								<xsl:with-param name="LayoutText" select="$button/TextObj/ParagraphStyleVector/Style/Data/text()"/>
							</xsl:call-template>
						</Calculation>
					</LabelCalc>
					<xsl:choose>
						<xsl:when test="$button/HideCondition">
							<xsl:copy-of select="$button/HideCondition"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:copy-of select="HideCondition"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:copy>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Remove the merged button (not working yet) -->
	<xsl:template match="Object[@type='Button' and preceding-sibling::Object/@type='ButtonBar']">
		<!-- -->
		
		<xsl:variable name="BBar" select="(preceding-sibling::Object[@type='ButtonBar'])[1]"/>
		<xsl:variable name="BBarBounds" select="$BBar/Bounds"/>

		<xsl:variable name="cx" select="((number(Bounds/@left) + number(Bounds/@right)) div 2) - number($BBarBounds/@left)"/>
		<xsl:variable name="cy" select="((number(Bounds/@top)  + number(Bounds/@bottom)) div 2) - number($BBarBounds/@top)"/>

				
		<xsl:choose>
			<xsl:when test="$BBar/ButtonBarObj/Object[@type='Button']/Bounds[
				number(@top)  &lt;= $cy and $cy &lt;= number(@bottom) and   
				number(@left) &lt;= $cx and $cx &lt;= number(@right)
				]">
				<!-- REMOVE -->
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
	<!-- NAMED TEMPLATES -->
	<xsl:template name="GetCalculationFromLayoutText">
		<xsl:param name="LayoutText"/>
		<!--  -->
		<xsl:variable name="CALC_START_MARKER" select="'&lt;&lt;'"/>
		<xsl:variable name="CALC_END_MARKER" select="'&gt;&gt;'"/>
		<xsl:variable name="GET_START_MARKER" select="'{{'"/>
		<xsl:variable name="GET_END_MARKER" select="'}}'"/>
		<!--  -->
		<xsl:variable name="posCalc" select="number( contains( $LayoutText, $CALC_START_MARKER)) * (1 + string-length( substring-before( $LayoutText, $CALC_START_MARKER)) ) "/>
		<xsl:variable name="posGet" select="number( contains( $LayoutText, $GET_START_MARKER)) * (1 + string-length( substring-before( $LayoutText, $GET_START_MARKER)) ) "/>
	
		<xsl:variable name="found">
			<xsl:choose>
				<xsl:when test="$posCalc &gt; $posGet">
					<xsl:value-of select="'Calc'"/>
				</xsl:when>
				<xsl:when test="$posGet &gt; $posCalc">
					<xsl:value-of select="'Get'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="''"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="pos1">
			<xsl:choose>
				<xsl:when test="$found = 'Calc'">
					<xsl:value-of select="$posCalc"/>
				</xsl:when>
				<xsl:when test="$found = 'Get'">
					<xsl:value-of select="$posGet"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="1 + string-length($LayoutText)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="startMarker" select="substring($LayoutText,$pos1,2)"/>
		<xsl:variable name="endMarker">
			<xsl:choose>
				<xsl:when test="$found = 'Calc'">
					<xsl:value-of select="$CALC_END_MARKER"/>
				</xsl:when>
				<xsl:when test="$found = 'Get'">
					<xsl:value-of select="$GET_END_MARKER"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="''"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<!-- split STRING -->
		<xsl:variable name="startString" select="substring( $LayoutText, $pos1 - 1)"/>
		<xsl:variable name="middleString">
			<xsl:choose>
				<xsl:when test="$found = ''">
					<xsl:value-of select="''"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring-before( substring-after( $LayoutText, $startMarker), $endMarker )"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="restString">
			<xsl:choose>
				<xsl:when test="$found = ''">
					<xsl:value-of select="''"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring-after( substring-after( $LayoutText, $startMarker), $endMarker )"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<!-- OUTPUT -->
		
		<!-- "STRING"[ & ]...-->
		<xsl:if test="$pos1 &gt; 1">
			<xsl:value-of select="concat('&quot;',$startString,'&quot;')"/>
			<xsl:if test="$found != ''">
				<xsl:value-of select="' &amp; '"/>
			</xsl:if>
		</xsl:if>
		
		<!-- Calculation PART -->
		<xsl:choose>
			<xsl:when test="$found = ''">
				<!-- STRING ONLY // FINISHED! -->
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$found = 'Get'">
						<!-- STRING{{PropertyName}} -->
						<xsl:value-of select="concat('Get( ',$middleString,' )')"/>
					</xsl:when>
					<xsl:when test="$found = 'Calc'">
						<!-- STRING<<Calc>> -->
						<xsl:value-of select="$middleString"/>
					</xsl:when>
				</xsl:choose>
				
				<!-- REST -->
				<xsl:if test="$restString !=''">
					<!-- & -->
					<xsl:value-of select="' &amp; '"/>
					<!-- ...RECURSE -->
					<xsl:call-template name="GetCalculationFromLayoutText">
						<xsl:with-param name="LayoutText" select="$restString"/>
					</xsl:call-template>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
