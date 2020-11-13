<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XML2_XMLO_ConvertLayout_FM12_to_FM11.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied fmp12 layout objects
	
	Returns (some but not all bits of) the layout in fmp11 format

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2013-07-12 MrW: Corrected calculation of Bounds and StyleID (for TabControls & Panels) :-)
	2013-07-11 MrW: Text, fields, shapes, graphics, base line, hair line line width, etc.
	2013-06-25 MrW: With fn.NumberFunctions for conversion of pixels to numbers and rgb% to Hex #RRGGBBAA.
	2013-06-19 MrW: FIXME FIXME FIXME
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.CloneMode.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.NumberFunctions.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XMSS_XMSS_ConvertBetweenFM11Andfmp12.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Convert Root and Layout -->
	<xsl:template match="/fmxmlsnippet/Layout">
		<xsl:variable name="enclosingRectTop" select="normalize-space(@enclosingRectTop)"/>
		<xsl:variable name="enclosingRectLeft" select="normalize-space(@enclosingRectLeft)"/>
		<xsl:variable name="enclosingRectBottom" select="normalize-space(@enclosingRectBottom)"/>
		<xsl:variable name="enclosingRectRight" select="normalize-space(@enclosingRectRight)"/>
		<!--  -->
		<fmxmlsnippet type="LayoutObjectList">
			<Layout enclosingRectTop="{$enclosingRectTop}" enclosingRectLeft="{$enclosingRectLeft}" enclosingRectBottom="{$enclosingRectBottom}" enclosingRectRight="{$enclosingRectRight}">
				<xsl:apply-templates select="*"/>
			</Layout>
		</fmxmlsnippet>
	</xsl:template>
	<!--
	
	Convert GroupButton Objects
	
	fm11:
	<Object type="GroupButton" flags="0" portal="-1" rotation="0">
		<Bounds top=" 35.000000" left=" 16.000000" bottom=" 71.000000" right="592.000000"/>
		<GroupButtonObj numOfObjs="10">
			<…/>
		</GroupButtonObj>
	</Object>

	fmp12:
	<Object type="GroupButton" key="12" LabelKey="0" flags="0" rotation="0">
		<Bounds top="35.0000000" left="16.0000000" bottom="71.0000000" right="592.0000000"/>
		<GroupButtonObj numOfObjs="8">
			<Styles></Styles>
		</GroupButtonObj>
	</Object>
	-->
	<!-- Convert GroupButton objects -->
	<xsl:template match="Object[@type='GroupButton']">
		<!-- Object -->
		<xsl:variable name="type" select="@type"/>
		<xsl:variable name="flags" select="@flags"/>
		<xsl:variable name="portal" select="-1"/>
		<xsl:variable name="rotation" select="@rotation"/>
		<!-- GroupButtonObj -->
		<xsl:variable name="GroupButtonObj.numOfObjs" select="GroupButtonObj/@numOfObjs"/>
		<!--  -->
		<!--  -->
		<!--  -->
		<Object type="{$type}" flags="{$flags}" portal="{$portal}" rotation="{$rotation}">
			<xsl:call-template name="Bounds"/>
			<GroupButtonObj numOfObjs="{$GroupButtonObj.numOfObjs}">
				<xsl:apply-templates select="*"/>
			</GroupButtonObj>
		</Object>
	</xsl:template>
	<!-- Copy Steps (i.e. button action) -->
	<xsl:template match="Step">
		<xsl:copy-of select="."/>
		<!--xsl:apply-templates select="." mode="Clone"/-->
	</xsl:template>
	<!-- Note: Steps are CONVERTED by the included xslt-file -->
	
	<!-- ConditionalFormatting -->
	<xsl:template match="ConditionalFormatting">
		<ConditionalFormatting>
			<xsl:for-each select="Item">
				<xsl:variable name="id" select="@id"/>
				<xsl:variable name="flags" select="@flags"/>
				<Item  id="{$id}" flags="{$flags}">
					<xsl:copy-of select="Condition"/>
					<Format/>
				</Item>
			</xsl:for-each>
		</ConditionalFormatting>
	</xsl:template>
	<!--
	 !
	 !
	 !
	 !
	 !
	 !
	 !
	 !
	 !
	 !
	 !-->
	<!-- Convert TabControl objects
	
	fmp12:
	
	<Object type="TabControl" key="20" LabelKey="0" flags="0" rotation="0">
		<Bounds top="284.0000000" left="157.0000000" bottom="324.0000000" right="460.0000000"/>
		...
	</Object>

	-->
	<xsl:template match="Object[@type='TabControl']">
		<!-- Object -->
		<xsl:variable name="type" select="@type"/>
		<xsl:variable name="flags" select="@flags"/>
		<xsl:variable name="portal" select="-1"/>
		<xsl:variable name="rotation" select="@rotation"/>
		<xsl:variable name="StyleId">
			<xsl:call-template name="GetStyleId"/>
		</xsl:variable>
		<!--  -->
		<xsl:for-each select="TabControlObj/Styles">
			<xsl:call-template name="ObjectStyle">
				<xsl:with-param name="id" select="$StyleId"/>
				<xsl:with-param name="forObject" select="$type"/>
			</xsl:call-template>
		</xsl:for-each>
		<Object type="{$type}" flags="{$flags}" portal="{$portal}" rotation="{$rotation}">
			<xsl:apply-templates select="ConditionalFormatting"/>
			<StyleId>
				<xsl:value-of select="$StyleId"/>
			</StyleId>
			<xsl:call-template name="Bounds"/>
			<xsl:apply-templates select="TabControlObj"/>
		</Object>
	</xsl:template>
	<!-- 
	 ! Convert TabControlObj objects
	 !
	 ! fmp12:
	 !
	<TabControlObj tabHeight="23" visPanelKey="22" defaultVisPanelKey="22" visPanelIndex="0" defaultVisPanelIndex="0" tabWidthModifier="0" tabJustification="1" tabFlagSet="8">
		<ExtendedAttributes fontHeight="12" graphicFormat="0">
			<NumFormat flags="0" charStyle="0" negativeStyle="0" currencySymbol="" thousandsSep="0" decimalPoint="0" negativeColor="#0" decimalDigits="0" trueString="" falseString=""/>
			<DateFormat format="0" charStyle="0" monthStyle="0" dayStyle="0" separator="0">
				<DateElement>0</DateElement>
				<DateElement>0</DateElement>
				<DateElement>0</DateElement>
				<DateElement>0</DateElement>
				<DateElementSep index="0"/>
				<DateElementSep index="1"/>
				<DateElementSep index="2"/>
				<DateElementSep index="3"/>
				<DateElementSep index="4"/>
			</DateFormat>
			<TimeFormat flags="0" charStyle="0" hourStyle="0" minsecStyle="0" separator="0" amString="" pmString="" ampmString=""/>
		</ExtendedAttributes>
		<Styles>
			...
		</Styles>
		<Object type="TabPanel" ...>
			...
		</Object>
	</TabControlObj>
	
	FM7
	
	<TabControlObj tabHeight="23" tabStyle="0" visPanelIndex="0" defaultVisPanelIndex="0" tabWidthModifier="0" tabFlagSet="8">
		<ObjectStyle ...>
		   ...
		</ObjectStyle>
		<TabPanelObj ...>
		   ...
		</TabPanelObj>
	</TabControlObj>
	-->
	<xsl:template match="TabControlObj">
		<xsl:variable name="tabHeight" select="@tabHeight"/>
		<xsl:variable name="visPanelIndex" select="@visPanelIndex"/>
		<xsl:variable name="defaultVisPanelIndex" select="@defaultVisPanelIndex"/>
		<xsl:variable name="tabWidthModifier" select="@tabWidthModifier"/>
		<xsl:variable name="tabFlagSet" select="@tabFlagSet"/>
		<!-- FIXME vvvvvvvvvv -->
		<!-- NUR 12 -->
		<xsl:variable name="visPanelKey" select="@visPanelKey"/>
		<xsl:variable name="defaultVisPanelKey" select="@defaultVisPanelKey"/>
		<xsl:variable name="tabJustification" select="@tabJustification"/>
		<!-- NUR 11 -->
		<xsl:variable name="tabStyle" select="0"/>
		<!-- FIXME ^^^^^^^^^^^ -->
		<!--  -->
		<xsl:for-each select="(Object[@type='TabPanel']/TextObj/Styles)[last()]">
			<xsl:call-template name="DrawStyle"/>
		</xsl:for-each>
		<TabControlObj tabHeight="{$tabHeight}" tabStyle="{$tabStyle}" visPanelIndex="{$visPanelIndex}" defaultVisPanelIndex="{$defaultVisPanelIndex}" tabWidthModifier="{$tabWidthModifier}" tabFlagSet="{$tabFlagSet}">
			<xsl:apply-templates select="Object"/>
		</TabControlObj>
	</xsl:template>
	<!-- Convert TabPanel objects
	
	fmp12:
	
	<Object type="TabPanel" key="22" LabelKey="0" flags="0" rotation="0">
		<Bounds top="0.0000000" left="0.0000000" bottom="40.0000000" right="303.0000000"/>
		<TextObj flags="0">
			<Styles>
			</Styles>
			<CharacterStyleVector>
				<Style>
					<Data>Test</Data>
					<CharacterStyle mask="0">
					</CharacterStyle>
				</Style>
			</CharacterStyleVector>
			<ParagraphStyleVector>
				<Style>
					<Data>Test</Data>
					<ParagraphStyle mask="0">
					</ParagraphStyle>
				</Style>
			</ParagraphStyleVector>
		</TextObj>
		<TabPanelObj tabLeftEdge="0" tabWidth="37" tabPanelFlagSet="0">
			<Object type="Field" ...>
			</Object>
		</TabPanelObj>
	</Object>
	
	fm11

	<ObjectStyle id="1" ...>
		...
	</ObjectStyle>
	<TabPanelObj tabLeftEdge="0" tabWidth="37" tabPanelFlagSet="0" textFlagSet="0" flags="0" portal="-1" rotation="0">
		<StyleId>1</StyleId>
		<Bounds top="158.000000" left="588.000000" bottom="199.000000" right="892.000000"/>
		<DrawStyle linePat="2" lineWidth="1" lineColor="#0" fillPat="2" fillEffect="1" fillColor="#C0C0C000"/>
		<TextObj flags="0">
			<CharacterStyleVector>
				<Style>
					<Data>Test</Data>
					<CharacterStyle mask="32695">
						<Font-family codeSet="Roman" fontId="0">Helvetica</Font-family>
						<Font-size>12</Font-size>
						<Face>0</Face>
						<Color>#000000</Color>
					</CharacterStyle>
				</Style>
			</CharacterStyleVector>
			<ParagraphStyleVector>
				<Style>
					<Data>Test</Data>
					<ParagraphStyle mask="0">
</ParagraphStyle>
				</Style>
			</ParagraphStyleVector>
		</TextObj>
		<ObjectStyle ...>
		   ...
		</ObjectStyle>
		<Object ...>
		</Object>
	</TabPanelObj>
	-->
	<xsl:template match="Object[@type='TabPanel']">
		<!-- in fm11 this element does not exist, thus no output -->
		<xsl:apply-templates select="TabPanelObj"/>
	</xsl:template>
	<!-- Convert TabPanelObj objects
	-->
	<xsl:template match="TabPanelObj">
		<!-- Object -->
		<xsl:variable name="flags" select="../Object/@flags"/>
		<xsl:variable name="portal" select="-1"/>
		<xsl:variable name="rotation" select="../Object/@rotation"/>
		<xsl:variable name="StyleId">
			<xsl:call-template name="GetStyleId"/>
		</xsl:variable>
		<!-- TabPanelObj -->
		<xsl:variable name="tabLeftEdge" select="@tabLeftEdge"/>
		<xsl:variable name="tabWidth" select="@tabWidth"/>
		<xsl:variable name="tabPanelFlagSet" select="@tabPanelFlagSet"/>
		<!-- nur fm11:      textFlagSet
		
		bit flags: 
		—
		0x0002 Left and right bounds should not grow or shrink
		0x0008 Contains at least one variable (merge field)
		0x0010 Has rounded corners
		0x0040 Pre-5.0 buttons (i.e.text obj with old effects).
		-->
		<xsl:variable name="tabPanelIsFixedWidth">
			<xsl:choose>
				<!-- FIXME -->
				<xsl:when test="1">
					<xsl:value-of select="1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="tabPanelContainsVar">
			<xsl:choose>
				<!-- FIXME -->
				<xsl:when test="1">
					<xsl:value-of select="1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="tabPanelHasRoundedCorners">
			<xsl:variable name="fmTabLopLeftRadius">
				<xsl:for-each select="../Object[@type='TabPanel']/TextObj/Styles">
					<xsl:call-template name="GetCSSProperty">
						<xsl:with-param name="property" select="'-fm-tab-top-left-radius'"/>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:variable>
			<xsl:choose>
				<!-- FIXME -->
				<xsl:when test="$fmTabLopLeftRadius='0 0'">
					<xsl:value-of select="0"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="1"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="tabPanelOldOldButtons">
			<xsl:choose>
				<!-- FIXME -->
				<xsl:when test="0">
					<xsl:value-of select="1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="textFlagSet" select="2*$tabPanelIsFixedWidth + 2*$tabPanelContainsVar + 16*$tabPanelHasRoundedCorners + 64*$tabPanelOldOldButtons"/>
		<!--  -->
		<xsl:for-each select="../TextObj/Styles">
			<xsl:call-template name="ObjectStyle">
				<xsl:with-param name="id" select="$StyleId"/>
				<xsl:with-param name="forObject" select="'TabPanelObj'"/>
			</xsl:call-template>
		</xsl:for-each>
		<TabPanelObj tabLeftEdge="{$tabLeftEdge}" tabWidth="{$tabWidth}" tabPanelFlagSet="{$tabPanelFlagSet}" textFlagSet="{$textFlagSet}" flags="{$flags}" portal="{$portal}" rotation="{$rotation}">
			<StyleId>
				<xsl:value-of select="$StyleId"/>
			</StyleId>
			<xsl:for-each select="parent::Object[@type='TabPanel']">
				<xsl:call-template name="Bounds"/>
			</xsl:for-each>
			<xsl:for-each select="../TextObj/Styles">
				<xsl:call-template name="DrawStyle"/>
			</xsl:for-each>
			<!-- Tab panel name-->
			<xsl:for-each select="../TextObj">
				<!-- TextObj -->
				<xsl:variable name="TextObj.flags" select="@flags"/>
				<!--  -->
				<!--  -->
				<TextObj flags="{$TextObj.flags}">
					<!-- Copy the formatted characters and paragraphs as is -->
					<xsl:copy-of select="CharacterStyleVector"/>
					<xsl:copy-of select="ParagraphStyleVector"/>
				</TextObj>
			</xsl:for-each>
			<!-- Tab panel contents-->
			<xsl:apply-templates select="*"/>
		</TabPanelObj>
	</xsl:template>
	<!-- 
	 !
	 !
	 !
	 !
	 !
	 !
	 !
	 !
	 !
	 !
	 !
	 !
	 !
	 !
	 !
	 !
	 !
	 !
	 !
	 !
	 !
	 !
	 !
	 !
	-->
	<!-- 
	 ! Portal
	 ! 
	 ! portalFlags:
	 !
	 ! 0x0001 - Scroll bar
	 ! 0x0002 - Alternating background (NOT in fmp12!!!)
	 ! 0x0004 - Delete
	 ! 0x0008 - Sorted
	 ! 0x0010 - Retain scrollbar position after exit
	 ! 0x0020 - Increase row height instead of number of rows
	 ! 0x0040 - Right-to-left layout of portal elements
	 ! 0x0080 - Filter
	 !-->
	<xsl:template match="Object[@type='Portal']">
		<!-- Object -->
		<xsl:variable name="type" select="@type"/>
		<xsl:variable name="flags" select="@flags"/>
		<xsl:variable name="portal" select="-1"/>
		<xsl:variable name="rotation" select="@rotation"/>
		<!--  -->
		<Object type="{$type}" flags="{$flags}" portal="{$portal}" rotation="{$rotation}">
			<xsl:apply-templates select="ConditionalFormatting"/>
			<xsl:call-template name="Bounds"/>
			<xsl:apply-templates select="PortalObj"/>
		</Object>
		<!--xsl:comment> Portal contents </xsl:comment-->
		<xsl:apply-templates select="PortalObj/Object"/>
	</xsl:template>
	<!-- PortalObj -->
	<xsl:template match="PortalObj">
		<xsl:variable name="hasAltBackground">
			<xsl:call-template name="hasAltBackground"/>
		</xsl:variable>
		<xsl:variable name="portalFlagsOld" select="@portalFlags"/>
		<xsl:variable name="portalFlags" select="number($portalFlagsOld) + 2 * $hasAltBackground"/>
		<xsl:variable name="numOfRows" select="@numOfRows"/>
		<xsl:variable name="initialRow" select="@initialRow"/>
		<!--  -->
		<xsl:for-each select="Styles">
			<xsl:call-template name="DrawStyle"/>
		</xsl:for-each>
		<xsl:for-each select="Styles">
			<xsl:call-template name="AltFillStyle"/>
		</xsl:for-each>
		<PortalObj portalFlags="{$portalFlags}" numOfRows="{$numOfRows}" initialRow="{$initialRow}">
			<xsl:copy-of select="TableAliasKey"/>
			<xsl:copy-of select="SortList"/>
			<xsl:copy-of select="FilterCalc"/>
			<!-- REMOVE ALL CSS STYLES -->
		</PortalObj>
	</xsl:template>
	<!-- IGNORE Portal contents >
	<xsl:template match="PortalObj"/-->
	<!-- identity template >
	<xsl:template match="node() | @*">
	    <xsl:copy>
	        <xsl:apply-templates select="node() | @*"/>
	    </xsl:copy>
	</xsl:template-->
	<!-- Convert Field objects 
	
	FM11:
	
	<Object type="Field" flags="0" portal="-1" rotation="0">
		<StyleId>0</StyleId>
		<Bounds top=" 58.000000" left="102.000000" bottom=" 72.000000" right="355.000000"/>
		<FieldObj numOfReps="1" flags="32" inputMode="0" displayType="0" quickFind="1">
			<Name>_Mandanten::TextField</Name>
			<DDRInfo>
				<Field name="TextField" id="1" repetition="1" maxRepetition="1" table="_Mandanten"/>
			</DDRInfo>
		</FieldObj>
	</Object>




	fmp12:
	
	<Object type="Field" key="2" LabelKey="0" flags="0" rotation="0">
		<Bounds top="58.0000000" left="102.0000000" bottom="72.0000000" right="355.0000000"/>
		<FieldObj numOfReps="1" flags="32" inputMode="0" displayType="0" quickFind="1" pictFormat="5">
			<Name>_Mandanten::TextField</Name>
			<ExtendedAttributes fontHeight="12" graphicFormat="5">
				<NumFormat flags="256" charStyle="0" negativeStyle="0" currencySymbol="€" thousandsSep="46" decimalPoint="44" negativeColor="#DD000000" decimalDigits="2" trueString="Yes" falseString="No"/>
				<DateFormat format="0" charStyle="0" monthStyle="1" dayStyle="1" separator="46">
					<DateElement>3</DateElement>
					<DateElement>1</DateElement>
					<DateElement>6</DateElement>
					<DateElement>13</DateElement>
					<DateElementSep index="0"/>
					<DateElementSep index="1">, </DateElementSep>
					<DateElementSep index="2">. </DateElementSep>
					<DateElementSep index="3"> </DateElementSep>
					<DateElementSep index="4"/>
				</DateFormat>
				<TimeFormat flags="159" charStyle="0" hourStyle="0" minsecStyle="1" separator="58" amString=" vorm." pmString=" nachm." ampmString=""/>
			</ExtendedAttributes>
			<DDRInfo>
				<Field name="TextField" id="1" repetition="1" maxRepetition="1" table="_Mandanten"/>
			</DDRInfo>
		</FieldObj>
	</Object>	
	
	
	
	
	NOTES about the conversion:
	
	NumFormat/@flags in fm11 and fmp12:
	
	Bit flags indicating the following properties:
	0x0001	No formatting
	0x0002	Use separator
	0x0004	Use notation (% or $)
	0x0008	Use fix number of decimal digits
	0x0010	Use percent notation
	0x0020	Display as boolean
	0x0040	Use Kanji Man-Oku style
	0x0080	Use Kanji 10,100,1000,10000 style
	0x0100	Use general format
	0x0400	Notation outside neg. format
	0x0800	Leading currency symbol
	0x1000	Use given negative color
	0x2000	Blank if zero
	
	!-->
	<xsl:template match="Object[@type='Field']">
		<!-- Object -->
		<xsl:variable name="type" select="@type"/>
		<xsl:variable name="flags" select="@flags"/>
		<xsl:variable name="portal" select="-1"/>
		<xsl:variable name="rotation" select="@rotation"/>
		<xsl:variable name="StyleId">
			<xsl:call-template name="GetStyleId"/>
		</xsl:variable>
		<!-- FieldObj -->
		<xsl:variable name="FieldObj.numOfReps" select="FieldObj/@numOfReps"/>
		<xsl:variable name="FieldObj.flags" select="FieldObj/@flags"/>
		<xsl:variable name="FieldObj.inputMode" select="FieldObj/@inputMode"/>
		<xsl:variable name="FieldObj.displayType" select="FieldObj/@displayType"/>
		<xsl:variable name="FieldObj.quickFind" select="FieldObj/@quickFind"/>
		<xsl:variable name="FieldObj.pictFormat" select="FieldObj/@pictFormat"/>
		<xsl:variable name="FieldObj.Name" select="FieldObj/Name"/>
		<!-- DDRInfo -->
		<xsl:variable name="Field.name" select="FieldObj/DDRInfo/Field/@name"/>
		<xsl:variable name="Field.id" select="FieldObj/DDRInfo/Field/@id"/>
		<xsl:variable name="Field.repetition" select="FieldObj/DDRInfo/Field/@repetition"/>
		<xsl:variable name="Field.maxRepetition" select="FieldObj/DDRInfo/Field/@maxRepetition"/>
		<xsl:variable name="Field.table" select="FieldObj/DDRInfo/Field/@table"/>
		<!--  -->
		<!--  -->
		<!--  -->
		<xsl:for-each select="FieldObj/Styles">
			<xsl:call-template name="ObjectStyle">
				<xsl:with-param name="id" select="$StyleId"/>
				<xsl:with-param name="forObject" select="$type"/>
			</xsl:call-template>
		</xsl:for-each>
		<Object type="{$type}" flags="{$flags}" portal="{$portal}" rotation="{$rotation}">
			<xsl:apply-templates select="ConditionalFormatting"/>
			<StyleId>
				<xsl:value-of select="$StyleId"/>
			</StyleId>
			<xsl:call-template name="Bounds"/>
			<FieldObj numOfReps="{$FieldObj.numOfReps}" flags="{$FieldObj.flags}" inputMode="{$FieldObj.inputMode}" displayType="{$FieldObj.displayType}" quickFind="{$FieldObj.quickFind}">
				<Name>
					<xsl:value-of select="$FieldObj.Name"/>
				</Name>
				<!-- REMOVE ALL CSS STYLES -->
				<DDRInfo>
					<Field name="{$Field.name}" id="{$Field.id}" repetition="{$Field.repetition}" maxRepetition="{$Field.maxRepetition}" table="{$Field.table}"/>
				</DDRInfo>
			</FieldObj>
		</Object>
	</xsl:template>
	<!-- Convert Text objects 
	 !
	 !
			<ObjectStyle id="0" fontHeight="12" graphicFormat="5" fieldBorders="15">
				  :
				<TimeFormat flags="159" charStyle="0" hourStyle="0" minsecStyle="1" separator="58" amString=" vorm." pmString=" nachm." ampmString=""/>
			-?	<DrawStyle linePat="2" lineWidth="1" lineColor="#88888800" fillPat="2" fillEffect="0" fillColor="#99FFCC00"/>
				<AltLineStyle linePat="7" lineWidth="1" lineColor="#0"/>
			</ObjectStyle>
			<Object type="Text" flags="0" portal="-1" rotation="0">
				<StyleId>0</StyleId>
				<Bounds top="184.000000" left="576.000000" bottom="218.000000" right="662.000000"/>
			-?	<DrawStyle linePat="1" lineWidth="0" lineColor="#FFFFFF00" fillPat="2" fillEffect="0" fillColor="#FFCC9900"/>
				<TextObj flags="0">
	 !-->
	<xsl:template match="Object[@type='Text']">
		<!-- Object -->
		<xsl:variable name="type" select="@type"/>
		<xsl:variable name="flags" select="@flags"/>
		<xsl:variable name="portal" select="-1"/>
		<xsl:variable name="rotation" select="@rotation"/>
		<xsl:variable name="StyleId">
			<xsl:call-template name="GetStyleId"/>
		</xsl:variable>
		<!-- TextObj -->
		<xsl:variable name="TextObj.flags" select="TextObj/@flags"/>
		<!--  -->
		<!--  -->
		<xsl:for-each select="TextObj/Styles">
			<xsl:call-template name="ObjectStyle">
				<xsl:with-param name="id" select="$StyleId"/>
				<xsl:with-param name="forObject" select="$type"/>
			</xsl:call-template>
		</xsl:for-each>
		<Object type="{$type}" flags="{$flags}" portal="{$portal}" rotation="{$rotation}">
			<xsl:apply-templates select="ConditionalFormatting"/>
			<StyleId>
				<xsl:value-of select="$StyleId"/>
			</StyleId>
			<xsl:call-template name="Bounds"/>
			<!-- REMOVE ALL CSS STYLES -->
			<xsl:for-each select="TextObj/Styles">
				<xsl:call-template name="DrawStyle"/>
			</xsl:for-each>
			<TextObj flags="{$TextObj.flags}">
				<!-- Copy the formatted characters and paragraphs as is -->
				<xsl:copy-of select="TextObj/CharacterStyleVector"/>
				<xsl:copy-of select="TextObj/ParagraphStyleVector"/>
			</TextObj>
		</Object>
	</xsl:template>
	<!-- Shapes
	
	<DrawStyle linePat="2" lineWidth="1" lineColor="#0" fillPat="2" fillEffect="0" fillColor="#FFFFCC00"/>
	
	-->
	<xsl:template match="Object[@type='Line' or @type='Rect' or @type='RRect' or @type='Oval']">
		<!-- Object -->
		<xsl:variable name="type" select="@type"/>
		<xsl:variable name="flags" select="@flags"/>
		<xsl:variable name="portal" select="-1"/>
		<xsl:variable name="rotation" select="@rotation"/>
		<!--  -->
		<Object type="{$type}" flags="{$flags}" portal="{$portal}" rotation="{$rotation}">
			<xsl:call-template name="Bounds"/>
			<!-- REMOVE ALL CSS STYLES -->
			<xsl:apply-templates match="Styles" mode="DrawStyle"/>
		</Object>
	</xsl:template>
	<!-- Graphics -->
	<xsl:template match="Object[@type='Graphic']">
		<!-- Object -->
		<xsl:variable name="type" select="@type"/>
		<xsl:variable name="flags" select="@flags"/>
		<xsl:variable name="portal" select="-1"/>
		<xsl:variable name="rotation" select="@rotation"/>
		<!--  -->
		<xsl:variable name="pictFormat" select="GraphicObj/@pictFormat"/>
		<xsl:variable name="mixColor" select="GraphicObj/@mixColor"/>
		<!--  -->
		<Object type="{$type}" flags="{$flags}" portal="{$portal}" rotation="{$rotation}">
			<xsl:call-template name="Bounds"/>
			<xsl:apply-templates match="Styles" mode="DrawStyle"/>
			<GraphicObj pictFormat="{$pictFormat}" mixColor="{$mixColor}">
				<xsl:copy-of select="GraphicObj/Stream"/>
				<xsl:copy-of select="GraphicObj/Reference"/>
				<!-- REMOVE ALL CSS STYLES -->
			</GraphicObj>
		</Object>
	</xsl:template>
	<!-- "ObjectStyle" 
		 !
		 ! Copies extended attributes to a the preceding ObjectStyle element

		fm11:
		<ObjectStyle id="0" fontHeight="12" graphicFormat="5" fieldBorders="0">
			<CharacterStyle mask="32695">
				<Font-family codeSet="Roman" fontId="0">Helvetica</Font-family>
				<Font-size>12</Font-size>
				<Face>0</Face>
				<Color>#000000</Color>
			</CharacterStyle>
			<ParagraphStyle mask="1983">
	</ParagraphStyle>
			<NumFormat flags="256" charStyle="0" negativeStyle="0" currencySymbol="€" thousandsSep="46" decimalPoint="44" negativeColor="#DD000000" decimalDigits="2" trueString="Ja" falseString="Nein"/>
			<DateFormat format="0" charStyle="0" monthStyle="1" dayStyle="1" separator="46">
				<DateElement>3</DateElement>
				<DateElement>1</DateElement>
				<DateElement>6</DateElement>
				<DateElement>8</DateElement>
				<DateElementSep index="0"/>
				<DateElementSep index="1">, </DateElementSep>
				<DateElementSep index="2">. </DateElementSep>
				<DateElementSep index="3"> </DateElementSep>
				<DateElementSep index="4"/>
			</DateFormat>
			<TimeFormat flags="159" charStyle="0" hourStyle="0" minsecStyle="1" separator="58" amString=" vorm." pmString=" nachm." ampmString=""/>
			<DrawStyle linePat="2" lineWidth="1" lineColor="#0" fillPat="2" fillEffect="0" fillColor="#FFFFCC00"/>
			<AltLineStyle linePat="7" lineWidth="1" lineColor="#0"/>
		</ObjectStyle>
		 !-->
	<xsl:template name="ObjectStyle" match="Styles" mode="ObjectStyle">
		<xsl:param name="id"/>
		<xsl:param name="forObject" select="''"/>
		<!--  -->
		<!-- ExtendedAttributes -->
		<!-- FIXME - where to get all these parameters from? -->
		<xsl:variable name="ObjectStyle.fontHeight" select="../ExtendedAttributes/@fontHeight"/>
		<xsl:variable name="ObjectStyle.graphicFormat" select="../ExtendedAttributes/@graphicFormat"/>
		<!-- @graphicFormat
				 ! 0x0001 Shrink to fit
				 ! 0x0002 Grow to fit
				 ! 0x0004 Maintain proportions
				 ! 0x0008 Left align
				 ! 0x0010 Top align
				 ! 0x0020 Right align
				 ! 0x0080 Bottom align
				 ! 0x0040 Colorize
				 !-->
		<xsl:variable name="ObjectStyle.fieldBorders">
			<!-- @fieldBorders
				 ! 0x0001 Top border
				 ! 0x0002 Left border
				 ! 0x0004 Bottom border
				 ! 0x0008 Right border
				 ! 0x0010 Repeat
				 ! 0x0040 Baseline
				 !-->
			<xsl:variable name="borderTop">
				<xsl:call-template name="GetCSSPropertyAsHasBorder10">
					<xsl:with-param name="property" select="'border-top-style'"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="borderLeft">
				<xsl:call-template name="GetCSSPropertyAsHasBorder10">
					<xsl:with-param name="property" select="'border-left-style'"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="borderBottom">
				<xsl:call-template name="GetCSSPropertyAsHasBorder10">
					<xsl:with-param name="property" select="'border-bottom-style'"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="borderRight">
				<xsl:call-template name="GetCSSPropertyAsHasBorder10">
					<xsl:with-param name="property" select="'border-right-style'"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="borderRepeat">
				<xsl:call-template name="GetCSSPropertyAsHasBorder10">
					<xsl:with-param name="property" select="'border-bottom-style'"/>
					<xsl:with-param name="selector" select="'self .repeat_border'"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="baseline">
				<xsl:call-template name="GetCSSPropertyAsHasBorder10">
					<xsl:with-param name="property" select="'border-bottom-style'"/>
					<xsl:with-param name="selector" select="'self .baseline'"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:value-of select="$borderTop + 2*$borderLeft + 4*$borderBottom + 8*$borderRight + 16*$borderRepeat + 64*$baseline"/>
		</xsl:variable>
		<xsl:variable name="NumFormat.flags" select="../ExtendedAttributes/NumFormat/@flags"/>
		<xsl:variable name="NumFormat.charStyle" select="../ExtendedAttributes/NumFormat/@charStyle"/>
		<xsl:variable name="NumFormat.negativeStyle" select="../ExtendedAttributes/NumFormat/@negativeStyle"/>
		<xsl:variable name="NumFormat.currencySymbol" select="../ExtendedAttributes/NumFormat/@currencySymbol"/>
		<xsl:variable name="NumFormat.thousandsSep" select="../ExtendedAttributes/NumFormat/@thousandsSep"/>
		<xsl:variable name="NumFormat.decimalPoint" select="../ExtendedAttributes/NumFormat/@decimalPoint"/>
		<xsl:variable name="NumFormat.negativeColor" select="../ExtendedAttributes/NumFormat/@negativeColor"/>
		<xsl:variable name="NumFormat.decimalDigits" select="../ExtendedAttributes/NumFormat/@decimalDigits"/>
		<xsl:variable name="NumFormat.trueString" select="../ExtendedAttributes/NumFormat/@trueString"/>
		<xsl:variable name="NumFormat.falseString" select="../ExtendedAttributes/NumFormat/@falseString"/>
		<xsl:variable name="DateFormat.format" select="../ExtendedAttributes/DateFormat/@format"/>
		<xsl:variable name="DateFormat.charStyle" select="../ExtendedAttributes/DateFormat/@charStyle"/>
		<xsl:variable name="DateFormat.monthStyle" select="../ExtendedAttributes/DateFormat/@monthStyle"/>
		<xsl:variable name="DateFormat.dayStyle" select="../ExtendedAttributes/DateFormat/@dayStyle"/>
		<xsl:variable name="DateFormat.separator" select="../ExtendedAttributes/DateFormat/@separator"/>
		<xsl:variable name="DateElement1" select="../ExtendedAttributes/DateFormat/DateElement[1]"/>
		<xsl:variable name="DateElement2" select="../ExtendedAttributes/DateFormat/DateElement[2]"/>
		<xsl:variable name="DateElement3" select="../ExtendedAttributes/DateFormat/DateElement[3]"/>
		<xsl:variable name="DateElement4" select="../ExtendedAttributes/DateFormat/DateElement[4]"/>
		<xsl:variable name="DateElementSep0" select="../ExtendedAttributes/DateFormat/DateElementSep[@index=0]"/>
		<xsl:variable name="DateElementSep1" select="../ExtendedAttributes/DateFormat/DateElementSep[@index=1]"/>
		<xsl:variable name="DateElementSep2" select="../ExtendedAttributes/DateFormat/DateElementSep[@index=2]"/>
		<xsl:variable name="DateElementSep3" select="../ExtendedAttributes/DateFormat/DateElementSep[@index=3]"/>
		<xsl:variable name="DateElementSep4" select="../ExtendedAttributes/DateFormat/DateElementSep[@index=4]"/>
		<xsl:variable name="TimeFormat.flags" select="../ExtendedAttributes/TimeFormat/@flags"/>
		<xsl:variable name="TimeFormat.charStyle" select="../ExtendedAttributes/TimeFormat/@charStyle"/>
		<xsl:variable name="TimeFormat.hourStyle" select="../ExtendedAttributes/TimeFormat/@hourStyle"/>
		<xsl:variable name="TimeFormat.minsecStyle" select="../ExtendedAttributes/TimeFormat/@minsecStyle"/>
		<xsl:variable name="TimeFormat.separator" select="../ExtendedAttributes/TimeFormat/@separator"/>
		<xsl:variable name="TimeFormat.amString" select="../ExtendedAttributes/TimeFormat/@amString"/>
		<xsl:variable name="TimeFormat.pmString" select="../ExtendedAttributes/TimeFormat/@pmString"/>
		<xsl:variable name="TimeFormat.ampmString" select="../ExtendedAttributes/TimeFormat/@ampmString"/>
		<!-- FIXME - if you can! -->
		<xsl:variable name="Char.mask" select="32695"/>
		<xsl:variable name="FontFamilyProp">
			<xsl:call-template name="GetCSSProperty">
				<xsl:with-param name="property" select="'font-family'"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="Char.FontFamily.name" select="substring-before(substring-after($FontFamilyProp,'('),',')"/>
		<xsl:variable name="Char.FontFamily.codeSet.lower" select="substring-before(substring-after($FontFamilyProp,','),')')"/>
		<xsl:variable name="Char.FontFamily.codeSet" select="concat(translate(substring($Char.FontFamily.codeSet.lower,1,1),$LOWERCASE_CHARS,$UPPERCASE_CHARS),substring($Char.FontFamily.codeSet.lower,2))"/>
		<xsl:variable name="Char.FontFamily.id" select="'0'"/>
		<xsl:variable name="Char.FontSize">
			<xsl:call-template name="GetCSSFontSize"/>
		</xsl:variable>
		<!-- FIXME - if you can! 
		20140106 MrW I do not know what the face element does, but passing a 0 here seems to stop conditional formatting working
		-->
		<xsl:variable name="Char.Face" select="'256'"/>
		<xsl:variable name="Char.Color">
			<xsl:call-template name="GetCSSTextColor"/>
		</xsl:variable>
		<!-- FIXME - if you can! -->
		<xsl:variable name="Para.mask" select="ParagraphStyle/@mask"/>
		<xsl:variable name="Para.Justification">
			<xsl:call-template name="GetCSSJustificationAsNumber"/>
		</xsl:variable>
		<!--  -->
		<!--  -->
		<ObjectStyle id="{$id}" fontHeight="{$ObjectStyle.fontHeight}" graphicFormat="{$ObjectStyle.graphicFormat}" fieldBorders="{$ObjectStyle.fieldBorders}">
			<CharacterStyle mask="{$Char.mask}">
				<Font-family codeSet="{$Char.FontFamily.codeSet}" fontId="{$Char.FontFamily.id}">
					<xsl:value-of select="$Char.FontFamily.name"/>
				</Font-family>
				<Font-size>
					<xsl:value-of select="$Char.FontSize"/>
				</Font-size>
				<Face>
					<xsl:value-of select="$Char.Face"/>
				</Face>
				<Color>
					<xsl:value-of select="$Char.Color"/>
				</Color>
			</CharacterStyle>
			<ParagraphStyle mask="{$Para.mask}">
				<xsl:if test="$Para.Justification &gt; 1">
					<Justification>
						<xsl:value-of select="$Para.Justification"/>
					</Justification>
				</xsl:if>
			</ParagraphStyle>
			<NumFormat flags="{$NumFormat.flags}" charStyle="{$NumFormat.charStyle}" negativeStyle="{$NumFormat.negativeStyle}" currencySymbol="{$NumFormat.currencySymbol}" thousandsSep="{$NumFormat.thousandsSep}" decimalPoint="{$NumFormat.decimalPoint}" negativeColor="{$NumFormat.negativeColor}" decimalDigits="{$NumFormat.decimalDigits}" trueString="{$NumFormat.trueString}" falseString="{$NumFormat.falseString}"/>
			<DateFormat format="{$DateFormat.format}" charStyle="{$DateFormat.charStyle}" monthStyle="{$DateFormat.monthStyle}" dayStyle="{$DateFormat.dayStyle}" separator="{$DateFormat.separator}">
				<DateElement>
					<xsl:value-of select="$DateElement1"/>
				</DateElement>
				<DateElement>
					<xsl:value-of select="$DateElement2"/>
				</DateElement>
				<DateElement>
					<xsl:value-of select="$DateElement3"/>
				</DateElement>
				<DateElement>
					<xsl:value-of select="$DateElement4"/>
				</DateElement>
				<DateElementSep index="0">
					<xsl:value-of select="$DateElementSep0"/>
				</DateElementSep>
				<DateElementSep index="1">
					<xsl:value-of select="$DateElementSep1"/>
				</DateElementSep>
				<DateElementSep index="2">
					<xsl:value-of select="$DateElementSep2"/>
				</DateElementSep>
				<DateElementSep index="3">
					<xsl:value-of select="$DateElementSep3"/>
				</DateElementSep>
				<DateElementSep index="4">
					<xsl:value-of select="$DateElementSep4"/>
				</DateElementSep>
			</DateFormat>
			<TimeFormat flags="{$TimeFormat.flags}" charStyle="{$TimeFormat.charStyle}" hourStyle="{$TimeFormat.hourStyle}" minsecStyle="{$TimeFormat.minsecStyle}" separator="{$TimeFormat.separator}" amString="{$TimeFormat.amString}" pmString="{$TimeFormat.pmString}" ampmString="{$TimeFormat.ampmString}"/>
			<xsl:for-each select="../Styles">
				<xsl:call-template name="DrawStyle"/>
			</xsl:for-each>
			<xsl:for-each select="../Styles">
				<xsl:call-template name="AltLineStyle">
					<xsl:with-param name="forObject" select="$forObject"/>
				</xsl:call-template>
			</xsl:for-each>
		</ObjectStyle>
	</xsl:template>
	<xsl:template name="TabControlObjectStyle" match="Styles" mode="ObjectStyle">
		<xsl:param name="id"/>
		<!--  -->
		<!-- ExtendedAttributes -->
		<!-- FIXME - where to get all these parameters from? -->
		<xsl:variable name="ObjectStyle.fontHeight" select="../ExtendedAttributes/@fontHeight"/>
		<xsl:variable name="ObjectStyle.graphicFormat" select="../ExtendedAttributes/@graphicFormat"/>
		<!-- @graphicFormat
				 ! 0x0001 Shrink to fit
				 ! 0x0002 Grow to fit
				 ! 0x0004 Maintain proportions
				 ! 0x0008 Left align
				 ! 0x0010 Top align
				 ! 0x0020 Right align
				 ! 0x0080 Bottom align
				 ! 0x0040 Colorize
				 !-->
		<xsl:variable name="ObjectStyle.fieldBorders">
			<!-- @fieldBorders
				 ! 0x0001 Top border
				 ! 0x0002 Left border
				 ! 0x0004 Bottom border
				 ! 0x0008 Right border
				 ! 0x0010 Repeat
				 ! 0x0040 Baseline
				 !-->
			<xsl:variable name="borderTop">
				<xsl:call-template name="GetCSSPropertyAsHasBorder10">
					<xsl:with-param name="property" select="'border-top-style'"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="borderLeft">
				<xsl:call-template name="GetCSSPropertyAsHasBorder10">
					<xsl:with-param name="property" select="'border-left-style'"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="borderBottom">
				<xsl:call-template name="GetCSSPropertyAsHasBorder10">
					<xsl:with-param name="property" select="'border-bottom-style'"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="borderRight">
				<xsl:call-template name="GetCSSPropertyAsHasBorder10">
					<xsl:with-param name="property" select="'border-right-style'"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="borderRepeat">
				<xsl:call-template name="GetCSSPropertyAsHasBorder10">
					<xsl:with-param name="property" select="'border-bottom-style'"/>
					<xsl:with-param name="selector" select="'self .repeat_border'"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="baseline">
				<xsl:call-template name="GetCSSPropertyAsHasBorder10">
					<xsl:with-param name="property" select="'border-bottom-style'"/>
					<xsl:with-param name="selector" select="'self .baseline'"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:value-of select="$borderTop + 2*$borderLeft + 4*$borderBottom + 8*$borderRight + 16*$borderRepeat + 64*$baseline"/>
		</xsl:variable>
		<xsl:variable name="NumFormat.flags" select="../ExtendedAttributes/NumFormat/@flags"/>
		<xsl:variable name="NumFormat.charStyle" select="../ExtendedAttributes/NumFormat/@charStyle"/>
		<xsl:variable name="NumFormat.negativeStyle" select="../ExtendedAttributes/NumFormat/@negativeStyle"/>
		<xsl:variable name="NumFormat.currencySymbol" select="../ExtendedAttributes/NumFormat/@currencySymbol"/>
		<xsl:variable name="NumFormat.thousandsSep" select="../ExtendedAttributes/NumFormat/@thousandsSep"/>
		<xsl:variable name="NumFormat.decimalPoint" select="../ExtendedAttributes/NumFormat/@decimalPoint"/>
		<xsl:variable name="NumFormat.negativeColor" select="../ExtendedAttributes/NumFormat/@negativeColor"/>
		<xsl:variable name="NumFormat.decimalDigits" select="../ExtendedAttributes/NumFormat/@decimalDigits"/>
		<xsl:variable name="NumFormat.trueString" select="../ExtendedAttributes/NumFormat/@trueString"/>
		<xsl:variable name="NumFormat.falseString" select="../ExtendedAttributes/NumFormat/@falseString"/>
		<xsl:variable name="DateFormat.format" select="../ExtendedAttributes/DateFormat/@format"/>
		<xsl:variable name="DateFormat.charStyle" select="../ExtendedAttributes/DateFormat/@charStyle"/>
		<xsl:variable name="DateFormat.monthStyle" select="../ExtendedAttributes/DateFormat/@monthStyle"/>
		<xsl:variable name="DateFormat.dayStyle" select="../ExtendedAttributes/DateFormat/@dayStyle"/>
		<xsl:variable name="DateFormat.separator" select="../ExtendedAttributes/DateFormat/@separator"/>
		<xsl:variable name="DateElement1" select="../ExtendedAttributes/DateFormat/DateElement[1]"/>
		<xsl:variable name="DateElement2" select="../ExtendedAttributes/DateFormat/DateElement[2]"/>
		<xsl:variable name="DateElement3" select="../ExtendedAttributes/DateFormat/DateElement[3]"/>
		<xsl:variable name="DateElement4" select="../ExtendedAttributes/DateFormat/DateElement[4]"/>
		<xsl:variable name="DateElementSep0" select="../ExtendedAttributes/DateFormat/DateElementSep[@index=0]"/>
		<xsl:variable name="DateElementSep1" select="../ExtendedAttributes/DateFormat/DateElementSep[@index=1]"/>
		<xsl:variable name="DateElementSep2" select="../ExtendedAttributes/DateFormat/DateElementSep[@index=2]"/>
		<xsl:variable name="DateElementSep3" select="../ExtendedAttributes/DateFormat/DateElementSep[@index=3]"/>
		<xsl:variable name="DateElementSep4" select="../ExtendedAttributes/DateFormat/DateElementSep[@index=4]"/>
		<xsl:variable name="TimeFormat.flags" select="../ExtendedAttributes/TimeFormat/@flags"/>
		<xsl:variable name="TimeFormat.charStyle" select="../ExtendedAttributes/TimeFormat/@charStyle"/>
		<xsl:variable name="TimeFormat.hourStyle" select="../ExtendedAttributes/TimeFormat/@hourStyle"/>
		<xsl:variable name="TimeFormat.minsecStyle" select="../ExtendedAttributes/TimeFormat/@minsecStyle"/>
		<xsl:variable name="TimeFormat.separator" select="../ExtendedAttributes/TimeFormat/@separator"/>
		<xsl:variable name="TimeFormat.amString" select="../ExtendedAttributes/TimeFormat/@amString"/>
		<xsl:variable name="TimeFormat.pmString" select="../ExtendedAttributes/TimeFormat/@pmString"/>
		<xsl:variable name="TimeFormat.ampmString" select="../ExtendedAttributes/TimeFormat/@ampmString"/>
		<!-- FIXME - if you can! -->
		<xsl:variable name="Char.mask" select="32695"/>
		<xsl:variable name="FontFamilyProp">
			<xsl:call-template name="GetCSSProperty">
				<xsl:with-param name="property" select="'font-family'"/>
				<xsl:with-param name="selector" select="'self .tab_header'"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="Char.FontFamily.name" select="substring-before(substring-after($FontFamilyProp,'('),',')"/>
		<xsl:variable name="Char.FontFamily.codeSet.lower" select="substring-before(substring-after($FontFamilyProp,','),')')"/>
		<xsl:variable name="Char.FontFamily.codeSet" select="concat(translate(substring($Char.FontFamily.codeSet.lower,1,1),$LOWERCASE_CHARS,$UPPERCASE_CHARS),substring($Char.FontFamily.codeSet.lower,2))"/>
		<xsl:variable name="Char.FontFamily.id" select="'0'"/>
		<xsl:variable name="Char.FontSize">
			<xsl:call-template name="GetCSSPropertyAsNumber">
				<xsl:with-param name="property" select="'font-size'"/>
				<xsl:with-param name="selector" select="'self .tab_header'"/>
			</xsl:call-template>
		</xsl:variable>
		<!-- FIXME - if you can! 
		20140106 MrW I do not know what the face element does, but passing a 0 here seems to stop conditional formatting working
		-->
		<xsl:variable name="Char.Face" select="'256'"/>

		<xsl:variable name="Char.Color">
			<xsl:call-template name="GetCSSPropertyAsRGBColor">
				<xsl:with-param name="property" select="'color'"/>
				<xsl:with-param name="selector" select="'self .tab_header'"/>
				<xsl:with-param name="default" select="'#0'"/>
			</xsl:call-template>
		</xsl:variable>
		<!-- FIXME - if you can! -->
		<xsl:variable name="Para.mask" select="ParagraphStyle/@mask"/>
		<xsl:variable name="Para.Justification">
			<xsl:call-template name="GetCSSJustificationAsNumber"/>
		</xsl:variable>
		<!--  -->
		<!--  -->
		<ObjectStyle id="{$id}" fontHeight="{$ObjectStyle.fontHeight}" graphicFormat="{$ObjectStyle.graphicFormat}" fieldBorders="{$ObjectStyle.fieldBorders}">
			<CharacterStyle mask="{$Char.mask}">
				<Font-family codeSet="{$Char.FontFamily.codeSet}" fontId="{$Char.FontFamily.id}">
					<xsl:value-of select="$Char.FontFamily.name"/>
				</Font-family>
				<Font-size>
					<xsl:value-of select="$Char.FontSize"/>
				</Font-size>
				<Face>
					<xsl:value-of select="$Char.Face"/>
				</Face>
				<Color>
					<xsl:value-of select="$Char.Color"/>
				</Color>
			</CharacterStyle>
			<ParagraphStyle mask="{$Para.mask}">
				<xsl:if test="$Para.Justification &gt; 1">
					<Justification>
						<xsl:value-of select="$Para.Justification"/>
					</Justification>
				</xsl:if>
			</ParagraphStyle>
			<NumFormat flags="{$NumFormat.flags}" charStyle="{$NumFormat.charStyle}" negativeStyle="{$NumFormat.negativeStyle}" currencySymbol="{$NumFormat.currencySymbol}" thousandsSep="{$NumFormat.thousandsSep}" decimalPoint="{$NumFormat.decimalPoint}" negativeColor="{$NumFormat.negativeColor}" decimalDigits="{$NumFormat.decimalDigits}" trueString="{$NumFormat.trueString}" falseString="{$NumFormat.falseString}"/>
			<DateFormat format="{$DateFormat.format}" charStyle="{$DateFormat.charStyle}" monthStyle="{$DateFormat.monthStyle}" dayStyle="{$DateFormat.dayStyle}" separator="{$DateFormat.separator}">
				<DateElement>
					<xsl:value-of select="$DateElement1"/>
				</DateElement>
				<DateElement>
					<xsl:value-of select="$DateElement2"/>
				</DateElement>
				<DateElement>
					<xsl:value-of select="$DateElement3"/>
				</DateElement>
				<DateElement>
					<xsl:value-of select="$DateElement4"/>
				</DateElement>
				<DateElementSep index="0">
					<xsl:value-of select="$DateElementSep0"/>
				</DateElementSep>
				<DateElementSep index="1">
					<xsl:value-of select="$DateElementSep1"/>
				</DateElementSep>
				<DateElementSep index="2">
					<xsl:value-of select="$DateElementSep2"/>
				</DateElementSep>
				<DateElementSep index="3">
					<xsl:value-of select="$DateElementSep3"/>
				</DateElementSep>
				<DateElementSep index="4">
					<xsl:value-of select="$DateElementSep4"/>
				</DateElementSep>
			</DateFormat>
			<TimeFormat flags="{$TimeFormat.flags}" charStyle="{$TimeFormat.charStyle}" hourStyle="{$TimeFormat.hourStyle}" minsecStyle="{$TimeFormat.minsecStyle}" separator="{$TimeFormat.separator}" amString="{$TimeFormat.amString}" pmString="{$TimeFormat.pmString}" ampmString="{$TimeFormat.ampmString}"/>
			<xsl:for-each select="../Styles">
				<xsl:call-template name="DrawStyle"/>
			</xsl:for-each>
			<xsl:for-each select="../Styles">
				<xsl:call-template name="AltLineStyle"/>
			</xsl:for-each>
		</ObjectStyle>
	</xsl:template>
	<!-- Convert Styles to DrawStyle -->
	<xsl:template name="DrawStyle" match="Styles" mode="DrawStyle">
		<!-- style -->
		<xsl:variable name="linePat">
			<xsl:call-template name="GetCSSLinePat"/>
		</xsl:variable>
		<xsl:variable name="lineWidth">
			<xsl:call-template name="GetCSSLineWidth"/>
		</xsl:variable>
		<xsl:variable name="lineColor">
			<xsl:call-template name="GetCSSLineColor"/>
		</xsl:variable>
		<xsl:variable name="fillPat">
			<xsl:call-template name="GetCSSFillPat"/>
		</xsl:variable>
		<xsl:variable name="fillEffect">
			<xsl:call-template name="GetCSSFillEffect"/>
		</xsl:variable>
		<xsl:variable name="fillColor">
			<xsl:call-template name="GetCSSFillColor"/>
		</xsl:variable>
		<!--xsl:value-of select="name(parent::*)"/-->
		<DrawStyle linePat="{$linePat}" lineWidth="{$lineWidth}" lineColor="{$lineColor}" fillPat="{$fillPat}" fillEffect="{$fillEffect}" fillColor="{$fillColor}"/>
	</xsl:template>
	<!-- Convert Styles to AltLineStyle -->
	<xsl:template name="AltLineStyle" match="Styles" mode="AltLineStyle">
		<xsl:param name="forObject" select="''"/>
		<!--  -->
		<xsl:variable name="altActiveProperty">
			<xsl:choose>
				<xsl:when test="$forObject='Field'">
					<!-- Field base line -->
					<xsl:value-of select="'-fm-borders-baseline'"/>
				</xsl:when>
				<xsl:when test="$forObject='Portal'">
					<xsl:value-of select="'-fm-portal-alt-background'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="''"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="selector">
			<xsl:choose>
				<xsl:when test="$forObject='Field'">
					<xsl:value-of select="'self .baseline'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'self'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="whichBorderProperty">
			<xsl:choose>
				<xsl:when test="$forObject='Field'">
					<!-- Field base line settings come from the bottom border -->
					<xsl:value-of select="'border-bottom'"/>
				</xsl:when>
				<xsl:otherwise>
					<!-- otherwise use the top border by default -->
					<xsl:value-of select="'border-top'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="borderStyleProperty" select="concat($whichBorderProperty,'-style')"/>
		<xsl:variable name="borderWidthProperty" select="concat($whichBorderProperty,'-width')"/>
		<xsl:variable name="borderColorProperty" select="concat($whichBorderProperty,'-color')"/>
		<xsl:variable name="borderColorSelector">
			<xsl:choose>
				<xsl:when test="$forObject='Field'">
					<!-- Field base line -->
					<xsl:value-of select="'self .baseline'"/>
				</xsl:when>
				<xsl:when test="$forObject='Portal'">
					<!-- Portal alternate row -->
					<xsl:value-of select="'self .row_alt'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'self .row_alt'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!--  -->
		<!-- style -->
		<xsl:variable name="hasAltLineStyle">
			<xsl:call-template name="GetCSSPropertyAs10">
				<xsl:with-param name="property" select="$altActiveProperty"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="AltLineStyle.linePat">
			<xsl:variable name="lineStyle">
				<xsl:call-template name="GetCSSProperty">
					<xsl:with-param name="property" select="$borderStyleProperty"/>
					<xsl:with-param name="selector" select="$selector"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:choose>
				<xsl:when test="$lineStyle='solid'">
					<xsl:value-of select="2"/>
				</xsl:when>
				<xsl:when test="$lineStyle='dotted'">
					<xsl:value-of select="7"/>
				</xsl:when>
				<xsl:when test="$lineStyle='dashed'">
					<xsl:value-of select="49"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="1"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="AltLineStyle.lineWidth">
			<xsl:call-template name="GetCSSPropertyAsNumber">
				<xsl:with-param name="property" select="$borderWidthProperty"/>
				<xsl:with-param name="selector" select="$selector"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="AltLineStyle.lineColor">
			<xsl:call-template name="GetCSSPropertyAsRGBAColor">
				<xsl:with-param name="property" select="$borderColorProperty"/>
				<xsl:with-param name="selector" select="$borderColorSelector"/>
			</xsl:call-template>
		</xsl:variable>
		<!--  -->
		<AltLineStyle linePat="{$AltLineStyle.linePat}" lineWidth="{$AltLineStyle.lineWidth}" lineColor="{$AltLineStyle.lineColor}"/>
	</xsl:template>
	<!-- Convert Styles to AltFillStyle -->
	<xsl:template name="AltFillStyle" match="Styles" mode="AltFillStyle">
		<!-- style -->
		<xsl:variable name="hasAltBackground">
			<xsl:call-template name="GetCSSPropertyAs10">
				<xsl:with-param name="property" select="'-fm-portal-alt-background'"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="fillPat" select="1+$hasAltBackground"/>
		<xsl:variable name="fillEffect">
			<xsl:call-template name="GetCSSProperty">
				<xsl:with-param name="property" select="'-fm-fill-effect'"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="fillColor">
			<xsl:call-template name="GetCSSPropertyAsRGBAColor">
				<xsl:with-param name="property" select="'background-color'"/>
				<xsl:with-param name="selector" select="'self .row_alt'"/>
			</xsl:call-template>
		</xsl:variable>
		<AltFillStyle fillPat="{$fillPat}" fillEffect="{$fillEffect}" fillColor="{$fillColor}"/>
	</xsl:template>
	<!-- Convert Styles to hasAltBackground Flag-->
	<xsl:template name="hasAltBackground" match="Styles" mode="hasAltBackground">
		<xsl:call-template name="GetCSSPropertyAs10">
			<xsl:with-param name="property" select="'-fm-portal-alt-background'"/>
		</xsl:call-template>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
	<xsl:template match="text()" mode="DrawStyle"/>
	<xsl:template match="text()" mode="AltFillStyle"/>
	<xsl:template match="text()" mode="AltLineStyle"/>
	<xsl:template match="text()" mode="ObjectStyle"/>
	<xsl:template match="text()" mode="hasAltBackground"/>
	<!--
	 !
	 ! ===== NAMED TEMPLATES ===========================================================================
	 !
	 !-->
	<!-- GetStyleId -->
	<xsl:template name="GetStyleId">
		<xsl:variable name="pastObjects" select="count(preceding::Object[@type='Field' or @type='Text' or @type='TabControl' or @type='TabPanel'])"/>
		<xsl:variable name="insideContainers" select="count(ancestor::Object[@type='TabControl' or @type='TabPanel'])"/>
		<xsl:variable name="isTabPanelObj" select="count(self::TabPanelObj)"/>
		<!--  -->
		<xsl:value-of select="$pastObjects + $insideContainers - $isTabPanelObj"/>
	</xsl:template>
	<!-- GetCSSLinePat -->
	<xsl:template name="GetCSSLinePat">
		<xsl:variable name="borderTopStyle">
			<xsl:call-template name="GetCSSProperty">
				<xsl:with-param name="property" select="'border-top-style'"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="borderLeftStyle">
			<xsl:call-template name="GetCSSProperty">
				<xsl:with-param name="property" select="'border-left-style'"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="borderBottomStyle">
			<xsl:call-template name="GetCSSProperty">
				<xsl:with-param name="property" select="'border-bottom-style'"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="borderRightStyle">
			<xsl:call-template name="GetCSSProperty">
				<xsl:with-param name="property" select="'border-right-style'"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="borderRepeatStyle">
			<xsl:call-template name="GetCSSProperty">
				<xsl:with-param name="property" select="'border-bottom-style'"/>
				<xsl:with-param name="selector" select="'self .repeat_border'"/>
			</xsl:call-template>
		</xsl:variable>
		<!--xsl:value-of select="$borderRepeatStyle"/>
		<xsl:value-of select="'/'"/-->
		<xsl:choose>
			<xsl:when test="$borderTopStyle='solid' or $borderLeftStyle='solid' or $borderBottomStyle='solid' or $borderRightStyle='solid' or $borderRepeatStyle='solid'">
				<xsl:value-of select="2"/>
			</xsl:when>
			<xsl:when test="$borderTopStyle='dotted' or $borderLeftStyle='dotted' or $borderBottomStyle='dotted' or $borderRightStyle='dotted' or $borderRepeatStyle='dotted'">
				<xsl:value-of select="7"/>
			</xsl:when>
			<xsl:when test="$borderTopStyle='dashed' or $borderLeftStyle='dashed' or $borderBottomStyle='dashed' or $borderRightStyle='dashed' or $borderRepeatStyle='dashed'">
				<xsl:value-of select="49"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="1"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- GetCSSLineWidth -->
	<xsl:template name="GetCSSLineWidth">
		<xsl:call-template name="GetCSSPropertyAsLineWidth">
			<xsl:with-param name="property" select="'border-top-width'"/>
			<xsl:with-param name="default" select="1"/>
		</xsl:call-template>
	</xsl:template>
	<!-- GetCSSLineColor -->
	<xsl:template name="GetCSSLineColor">
		<xsl:call-template name="GetCSSPropertyAsRGBAColor">
			<xsl:with-param name="property" select="'border-top-color'"/>
			<xsl:with-param name="default" select="'#FFFFFF'"/>
		</xsl:call-template>
	</xsl:template>
	<!-- GetCSSFillPat -->
	<xsl:template name="GetCSSFillPat">
		<xsl:variable name="backgroundColorText">
			<xsl:call-template name="GetCSSProperty">
				<xsl:with-param name="property" select="'background-color'"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="substring($backgroundColorText,string-length($backgroundColorText)-2)=',0)'">
				<xsl:value-of select="1"/>
				<!--xsl:value-of select="substring($backgroundColorText,string-length($backgroundColorText)-2)"/-->
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="2"/>
				<!--xsl:value-of select="substring($backgroundColorText,string-length($backgroundColorText)-2)"/-->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- GetCSSFillEffect -->
	<xsl:template name="GetCSSFillEffect">
		<xsl:variable name="fmFillEffect">
			<xsl:call-template name="GetCSSPropertyAsNumber">
				<xsl:with-param name="property" select="'-fm-fill-effect'"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$fmFillEffect!=''">
				<!-- fm11 CSS attribute available -->
				<xsl:value-of select="$fmFillEffect"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- best guess using fm12 border intensities -->
				<!-- THIS SECTION IS (NICE) JUNK -->
				<xsl:variable name="topColorText">
					<xsl:call-template name="GetCSSProperty">
						<xsl:with-param name="property" select="'border-top-color'"/>
						<xsl:with-param name="default" select="'#0'"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="topIntensity">
					<xsl:call-template name="GetCSSColorIntensity">
						<xsl:with-param name="color" select="$topColorText"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="leftColorText">
					<xsl:call-template name="GetCSSProperty">
						<xsl:with-param name="property" select="'border-left-color'"/>
						<xsl:with-param name="default" select="'#0'"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="leftIntensity">
					<xsl:call-template name="GetCSSColorIntensity">
						<xsl:with-param name="color" select="$leftColorText"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="bottomColorText">
					<xsl:call-template name="GetCSSProperty">
						<xsl:with-param name="property" select="'border-bottom-color'"/>
						<xsl:with-param name="default" select="'#0'"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="bottomIntensity">
					<xsl:call-template name="GetCSSColorIntensity">
						<xsl:with-param name="color" select="$bottomColorText"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$leftIntensity &gt; $topIntensity">
						<!-- embossed -->
						<xsl:value-of select="1"/>
					</xsl:when>
					<xsl:when test="$leftIntensity &lt; $topIntensity">
						<!-- engraved -->
						<xsl:value-of select="2"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="0"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- GetCSSFillColor -->
	<xsl:template name="GetCSSFillColor">
		<xsl:call-template name="GetCSSPropertyAsRGBAColor">
			<xsl:with-param name="property" select="'background-color'"/>
			<xsl:with-param name="default" select="'#FFFFFF00'"/>
		</xsl:call-template>
	</xsl:template>
	<!-- GetCSSTextColor -->
	<xsl:template name="GetCSSTextColor">
		<xsl:call-template name="GetCSSPropertyAsRGBColor">
			<xsl:with-param name="property" select="'color'"/>
			<xsl:with-param name="default" select="'#0'"/>
		</xsl:call-template>
	</xsl:template>
	<!-- GetCSSFontSize -->
	<xsl:template name="GetCSSFontSize">
		<xsl:call-template name="GetCSSPropertyAsNumber">
			<xsl:with-param name="property" select="'font-size'"/>
		</xsl:call-template>
	</xsl:template>
	<!-- GetCSSJustificationAsNumber -->
	<xsl:template name="GetCSSJustificationAsNumber">
		<xsl:variable name="textAlign">
			<xsl:call-template name="GetCSSProperty">
				<xsl:with-param name="property" select="'text-align'"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$textAlign='left'">
				<xsl:value-of select="1"/>
			</xsl:when>
			<xsl:when test="$textAlign='center'">
				<xsl:value-of select="2"/>
			</xsl:when>
			<xsl:when test="$textAlign='right'">
				<xsl:value-of select="3"/>
			</xsl:when>
			<xsl:when test="$textAlign='justify'">
				<xsl:value-of select="4"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--  -->
	<!-- GetCSSPropertyAsLineWidth -->
	<xsl:template name="GetCSSPropertyAsLineWidth">
		<xsl:param name="property"/>
		<xsl:param name="selector" select="'self'"/>
		<xsl:param name="default" select="''"/>
		<!--  -->
		<xsl:variable name="value">
			<xsl:call-template name="GetCSSPropertyAsNumber">
				<xsl:with-param name="property" select="$property"/>
				<xsl:with-param name="selector" select="$selector"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$value='0.25'">
				<!-- Hairline -->
				<xsl:value-of select="-1"/>
			</xsl:when>
			<xsl:when test="$value!=''">
				<xsl:value-of select="$value"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$default"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- GetCSSPropertyAsNumber -->
	<xsl:template name="GetCSSPropertyAsNumber">
		<xsl:param name="property"/>
		<xsl:param name="selector" select="'self'"/>
		<xsl:param name="default" select="''"/>
		<!--  -->
		<xsl:variable name="value">
			<xsl:call-template name="GetCSSProperty">
				<xsl:with-param name="property" select="$property"/>
				<xsl:with-param name="selector" select="$selector"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$value!=''">
				<xsl:call-template name="fn.GetAsNumber">
					<xsl:with-param name="text" select="$value"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$default"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- GetCSSPropertyAs10 -->
	<xsl:template name="GetCSSPropertyAs10">
		<xsl:param name="property"/>
		<xsl:param name="selector" select="'self'"/>
		<xsl:param name="default" select="''"/>
		<!--  -->
		<xsl:variable name="value">
			<xsl:call-template name="GetCSSProperty">
				<xsl:with-param name="property" select="$property"/>
				<xsl:with-param name="selector" select="$selector"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$value='true'">
				<xsl:value-of select="1"/>
			</xsl:when>
			<xsl:when test="$value='false'">
				<xsl:value-of select="0"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="00"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- GetCSSPropertyAsHasBorder10 -->
	<xsl:template name="GetCSSPropertyAsHasBorder10">
		<xsl:param name="property"/>
		<xsl:param name="selector" select="'self'"/>
		<xsl:param name="default" select="''"/>
		<!--  -->
		<xsl:variable name="value">
			<xsl:call-template name="GetCSSProperty">
				<xsl:with-param name="property" select="$property"/>
				<xsl:with-param name="selector" select="$selector"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$value='solid' or $value='dashed' or $value='dotted'">
				<xsl:value-of select="1"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="0"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- GetCSSPropertyAsRGBAColor -->
	<xsl:template name="GetCSSPropertyAsRGBColor">
		<xsl:param name="property"/>
		<xsl:param name="selector" select="'self'"/>
		<xsl:param name="default" select="''"/>
		<!--  -->
		<xsl:variable name="temp">
			<xsl:call-template name="GetCSSPropertyAsRGBAColor">
				<xsl:with-param name="property" select="$property"/>
				<xsl:with-param name="selector" select="$selector"/>
				<xsl:with-param name="default" select="$default"/>
			</xsl:call-template>
		</xsl:variable>
		<!-- Return result without the last two digits -->
		<xsl:value-of select="substring($temp,1,7)"/>
	</xsl:template>
	<xsl:template name="GetCSSPropertyAsRGBAColor">
		<xsl:param name="property"/>
		<xsl:param name="selector" select="'self'"/>
		<xsl:param name="default" select="''"/>
		<!--  -->
		<xsl:variable name="value">
			<xsl:call-template name="GetCSSProperty">
				<xsl:with-param name="property" select="$property"/>
				<xsl:with-param name="selector" select="$selector"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$value!=''">
				<xsl:call-template name="ConvertRGBAFuncToCSSColor">
					<xsl:with-param name="rgbaFunc" select="$value"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$default"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- GetCSSProperty -->
	<xsl:template name="GetCSSProperty">
		<xsl:param name="property"/>
		<xsl:param name="selector" select="'self'"/>
		<!--  -->
		<xsl:variable name="localValue">
			<xsl:call-template name="GetCSSPropertyFromCSS">
				<xsl:with-param name="css" select="LocalCSS"/>
				<xsl:with-param name="selector" select="$selector"/>
				<xsl:with-param name="property" select="$property"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="fullValue">
			<xsl:call-template name="GetCSSPropertyFromCSS">
				<xsl:with-param name="css" select="FullCSS"/>
				<xsl:with-param name="selector" select="$selector"/>
				<xsl:with-param name="property" select="$property"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$localValue!=''">
				<xsl:value-of select="$localValue"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$fullValue"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- GetCSSPropertyFromCSS -->
	<xsl:template name="GetCSSPropertyFromCSS">
		<xsl:param name="css"/>
		<xsl:param name="selector"/>
		<xsl:param name="property"/>
		<!--  -->
		<xsl:variable name="properties" select="concat(';',substring-before(substring-after(substring-after($css,$selector),'{'),'}'),';')"/>
		<xsl:choose>
			<xsl:when test="contains($properties,concat(';',$property,':'))">
				<xsl:value-of select="normalize-space(substring-before(substring-after($properties,concat(';',$property,':')),';'))"/>
			</xsl:when>
			<xsl:when test="contains($properties,concat(' ',$property,':'))">
				<xsl:value-of select="normalize-space(substring-before(substring-after($properties,concat(' ',$property,':')),';'))"/>
			</xsl:when>
			<xsl:when test="contains($properties,concat($TAB,$property,':'))">
				<xsl:value-of select="normalize-space(substring-before(substring-after($properties,concat($TAB,$property,':')),';'))"/>
			</xsl:when>
			<xsl:when test="contains($properties,concat($CR,$property,':'))">
				<xsl:value-of select="normalize-space(substring-before(substring-after($properties,concat($CR,$property,':')),';'))"/>
			</xsl:when>
			<xsl:when test="contains($properties,concat($LF,$property,':'))">
				<xsl:value-of select="normalize-space(substring-before(substring-after($properties,concat($LF,$property,':')),';'))"/>
			</xsl:when>
		</xsl:choose>
		<!-- first solution
		<xsl:variable name="propertiesSearch" select="translate($properties,concat(';',$TAB,$CR,$LF),'    ')"/>
		<xsl:variable name="propertySearch" select="concat(' ' , $property,':')"/>
		<xsl:if test="contains($propertiesSearch,$propertySearch)">
			<xsl:variable name="propertyPos" select="1 + string-length(substring-before($propertiesSearch,$propertySearch)) + string-length($propertySearch)"/>
			<xsl:variable name="propertyValue" select="normalize-space(substring-before(substring($properties,$propertyPos),';'))"/>
			<xsl:value-of select="$propertyValue"/>
			<xsl:value-of select="$TAB"/>
			<xsl:value-of select="'propertySearch: '"/>
			<xsl:value-of select="concat($APOS,$propertySearch,$APOS)"/>
			<xsl:value-of select="$TAB"/>
			<xsl:value-of select="'selector: '"/>
			<xsl:value-of select="$selector"/>
			<xsl:value-of select="$TAB"/>
			<xsl:value-of select="'propertiesSearch: '"/>
			<xsl:value-of select="concat($APOS,$propertiesSearch,$APOS)"/>
			<xsl:value-of select="'///////////////'"/>
			<xsl:value-of select="$css"/>
			<xsl:value-of select="'///////////////'"/>
		</xsl:if>
		-->
	</xsl:template>
	<!-- ConvertRGBAFuncToCSSColor -->
	<xsl:template name="ConvertRGBAFuncToCSSColor">
		<xsl:param name="rgbaFunc"/>
		<!--  -->
		<xsl:variable name="rgba" select="substring-before(substring-after($rgbaFunc,'('),')')"/>
		<xsl:variable name="r" select="substring-before($rgba,',')"/>
		<xsl:variable name="gba" select="substring-after($rgba,',')"/>
		<xsl:variable name="g" select="substring-before($gba,',')"/>
		<xsl:variable name="ba" select="substring-after($gba,',')"/>
		<xsl:variable name="b" select="substring-before($ba,',')"/>
		<xsl:variable name="a" select="substring-after($ba,',')"/>
		<xsl:variable name="rNr" select="number(normalize-space(translate($r,'%',' ')))"/>
		<xsl:variable name="gNr" select="number(normalize-space(translate($g,'%',' ')))"/>
		<xsl:variable name="bNr" select="number(normalize-space(translate($b,'%',' ')))"/>
		<xsl:variable name="aNr" select="number(normalize-space(translate($a,'%',' ')))"/>
		<!--  -->
		<!--xsl:value-of select="concat($r,'.',$g,'.',$b,'.',$a)"/>
		<xsl:value-of select="'/'"/>
		<xsl:value-of select="concat($rNr,'.',$gNr,'.',$bNr,'.',$aNr)"/-->
		<xsl:choose>
			<xsl:when test="$rgba='0%,0%,0%,1'">
				<xsl:value-of select="'#0'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'#'"/>
				<xsl:call-template name="fn.HexNN">
					<xsl:with-param name="nr" select="$rNr * 255 div 100"/>
				</xsl:call-template>
				<xsl:call-template name="fn.HexNN">
					<xsl:with-param name="nr" select="$gNr * 255 div 100"/>
				</xsl:call-template>
				<xsl:call-template name="fn.HexNN">
					<xsl:with-param name="nr" select="$bNr * 255 div 100"/>
				</xsl:call-template>
				<xsl:choose>
					<xsl:when test="$aNr=1">
						<xsl:value-of select="'00'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'FF'"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- GetCSSColorIntensity -->
	<xsl:template name="GetCSSColorIntensity">
		<xsl:param name="color"/>
		<!--  -->
		<xsl:variable name="colorUpper" select="translate($color,'abcdef','ABCDEF')"/>
		<xsl:variable name="colorClean" select="translate($colorUpper,translate($colorUpper,'1234567890ABCDEF',''),'')"/>
		<!--  -->
		<xsl:variable name="r">
			<xsl:call-template name="fn.0x">
				<xsl:with-param name="hex" select="substring($colorClean,1,2)"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="g">
			<xsl:call-template name="fn.0x">
				<xsl:with-param name="hex" select="substring($colorClean,3,2)"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="b">
			<xsl:call-template name="fn.0x">
				<xsl:with-param name="hex" select="substring($colorClean,5,2)"/>
			</xsl:call-template>
		</xsl:variable>
		<!--  -->
		<xsl:value-of select="($r div 255 + $g div 255 + $b div 255) div 3"/>
	</xsl:template>
	<!-- "Bounds" -->
	<xsl:template name="Bounds">
		<!-- Bounds -->
		<xsl:variable name="Bounds.top.rel" select="number(Bounds/@top)"/>
		<xsl:variable name="Bounds.left.rel" select="number(Bounds/@left)"/>
		<xsl:variable name="Bounds.bottom.rel" select="number(Bounds/@bottom)"/>
		<xsl:variable name="Bounds.right.rel" select="number(Bounds/@right)"/>
		<!--  -->
		<xsl:variable name="width" select="$Bounds.right.rel - $Bounds.left.rel"/>
		<xsl:variable name="height" select="$Bounds.bottom.rel - $Bounds.top.rel"/>
		<!--  -->
		<xsl:variable name="top.abs" select="sum(ancestor-or-self::Object[Bounds]/Bounds/@top) + count(ancestor-or-self::PortalObj)"/>
		<xsl:variable name="left.abs" select="sum(ancestor-or-self::Object[Bounds]/Bounds/@left) + count(ancestor-or-self::PortalObj)"/>
		<xsl:variable name="bottom.abs" select="$top.abs + $height"/>
		<xsl:variable name="right.abs" select="$left.abs + $width"/>
		<xsl:variable name="top.abs.text">
			<xsl:call-template name="GetBoundText">
				<xsl:with-param name="bound" select="$top.abs"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="left.abs.text">
			<xsl:call-template name="GetBoundText">
				<xsl:with-param name="bound" select="$left.abs"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="bottom.abs.text">
			<xsl:call-template name="GetBoundText">
				<xsl:with-param name="bound" select="$bottom.abs"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="right.abs.text">
			<xsl:call-template name="GetBoundText">
				<xsl:with-param name="bound" select="$right.abs"/>
			</xsl:call-template>
		</xsl:variable>
		<!--  -->
		<Bounds top="{$top.abs.text}" left="{$left.abs.text}" bottom="{$bottom.abs.text}" right="{$right.abs.text}"/>
	</xsl:template>
	<!-- GetBoundText -->
	<xsl:template name="GetBoundText">
		<xsl:param name="bound"/>
		<!--  -->
		<xsl:if test="$bound &lt; 10">
			<xsl:value-of select="' '"/>
		</xsl:if>
		<xsl:if test="$bound &lt; 100">
			<xsl:value-of select="' '"/>
		</xsl:if>
		<xsl:value-of select="$bound"/>
		<xsl:if test="not(contains($bound,'.'))">
			<xsl:value-of select="'.000000'"/>
		</xsl:if>
	</xsl:template>
	<!-- CSS.Border.Radius -->
	<xsl:template name="CSS.Border.Radius">
		<xsl:param name="radius"/>
		<!--  -->
		<xsl:variable name="RptRpt" select="concat($radius,'pt ',$radius,'pt')"/>
		<!--  -->
		<xsl:value-of select="concat('border-top-right-radius: ',$RptRpt,';&#10;&#9;border-bottom-right-radius: ',$RptRpt,';&#10;&#9;border-bottom-left-radius: ',$RptRpt,';&#10;&#9;border-top-left-radius: ',$RptRpt,';&#10;&#9;',$var,'border-top-right-radius: 5.25pt 5.25pt;&#10;&#9;border-bottom-right-radius: 5.25pt 5.25pt;&#10;&#9;border-bottom-left-radius: 5.25pt 5.25pt;&#10;&#9;border-top-left-radius: 5.25pt 5.25pt;&#10;&#9;')"/>
	</xsl:template>
</xsl:stylesheet>
