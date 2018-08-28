<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMLO_XML2_Convert.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied fp7 (FMP7-11) layout objects
	
	Returns layout in fmp12 format
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2011-2016
	2013-04-30 MrW: Version 0.1:
	 - Converts text objects, fields, shapes, groups. 
	 - Portals and Tabs are converted into groups.
	 - Extended attributes (Inspector 3 Data) are copied.
	 - No style informtion is copied
	 - CSS is inherited from the destination layout.
	2011-12-28 MrW: 
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
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
				<!--xsl:apply-templates select="Object[@type='Text']|Object[@type='Field']"/-->
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

	<!-- Convert GroupButton objects !-->
	<xsl:template match="Object[@type='GroupButton']|Object[@type='Portal']|Object[@type='TabControl']|TabPanelObj">

		<xsl:variable name="flags" select="@flags"/>
		<xsl:variable name="rotation" select="@rotation"/>
		<!-- old fm11 attribute - unused??????: -->
		<xsl:variable name="portal" select="@portal"/>
		<!-- new fmp12 attributes -->
		<xsl:variable name="key" select="'0'"/>
		<xsl:variable name="LabelKey" select="'0'"/>
		<!-- GroupButtonObj -->
		<xsl:variable name="GroupButtonObj.numOfObjs" select="GroupButtonObj/@numOfObjs"/>
		<!--  -->
		<!--  -->
		<!--  -->
		<Object type="GroupButton" key="{$key}" LabelKey="{$LabelKey}" flags="{$flags}" rotation="{$rotation}">
			<xsl:call-template name="Bounds"/>
			<GroupButtonObj numOfObjs="{$GroupButtonObj.numOfObjs}">
				<Styles>
					<!-- STYLES APPEAR TO BE EMPTY HERE IN FMP12 LAYOUT -->
				</Styles>
				<xsl:apply-templates select="*"/>
			</GroupButtonObj>
		</Object>
		
	</xsl:template>
	
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
			<Styles>
				<LocalCSS>...</LocalCSS>
				<FullCSS>...</FullCSS>
				<ThemeName>com.filemaker.theme.classic</ThemeName>
			</Styles>
			<DDRInfo>
				<Field name="TextField" id="1" repetition="1" maxRepetition="1" table="_Mandanten"/>
			</DDRInfo>
		</FieldObj>
	</Object>	
	
	
	
	
	NOTES about the conversion:
	
	NumFormat/@flags in fm11 and fmp12:
	
	Bit flags indicating the following properties:
	No formatting = 0x0001
	Use separator = 0x0002
	Use notation (% or $) = 0x0004
	Use fix number of decimal digits = 0x0008
	Use percent notation = 0x0010
	Display as boolean = 0x0020
	Use Kanji Man-Oku style = 0x0040
	Use Kanji 10,100,1000,10000 style = 0x0080
	Use general format = 0x0100
	Notation outside negative format = 0x0400
	Leading currency symbol = 0x0800
	Use given negative color = 0x1000
	Blank if zero = 0x2000
	
	!-->
	<xsl:template match="Object[@type='Field']">
		<!-- Object -->
		<xsl:variable name="type" select="@type"/>
		<xsl:variable name="flags" select="@flags"/>
		<xsl:variable name="rotation" select="@rotation"/>
		<!-- old fm11 attribute - unused??????: -->
		<xsl:variable name="portal" select="@portal"/>
		<!-- new fmp12 attributes -->
		<xsl:variable name="key" select="'0'"/>
		<xsl:variable name="LabelKey" select="'0'"/>
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
		<Object type="{$type}" key="{$key}" LabelKey="{$LabelKey}" flags="{$flags}" rotation="{$rotation}">
			<xsl:call-template name="Bounds"/>
			<FieldObj numOfReps="{$FieldObj.numOfReps}" flags="{$FieldObj.flags}" inputMode="{$FieldObj.inputMode}" displayType="{$FieldObj.displayType}" quickFind="{$FieldObj.quickFind}" pictFormat="{$FieldObj.pictFormat}">
				<Name><xsl:value-of select="$FieldObj.Name"/></Name>
				<xsl:copy-of select="FieldObj/ValueList"/>
				<xsl:call-template name="ExtendedAttributes"/>
				<!-- INHERIT ALL THEME CSS STYLES FROM FMP12 LAYOUT -->
				<Styles>
					<LocalCSS></LocalCSS>
					<FullCSS></FullCSS>
					<ThemeName></ThemeName>
				</Styles>
				<DDRInfo>
					<Field id="{$Field.id}" repetition="{$Field.repetition}" maxRepetition="{$Field.maxRepetition}" table="{$Field.table}"/>
				</DDRInfo>
			</FieldObj>
		</Object>
		
	</xsl:template>
	
	<!-- Convert Text objects !-->
	<xsl:template match="Object[@type='Text']">
		<xsl:variable name="type" select="@type"/>
		<xsl:variable name="flags" select="@flags"/>
		<xsl:variable name="rotation" select="@rotation"/>
		<xsl:variable name="TextObj.flags" select="TextObj/@flags"/>
		<!-- new fmp12 attributes -->
		<xsl:variable name="key" select="'0'"/>
		<xsl:variable name="LabelKey" select="'0'"/>
		<!--  -->
		<!--  -->
		<!--  -->
		<Object type="{$type}" key="{$key}" LabelKey="{$LabelKey}" flags="{$flags}" rotation="{$rotation}">
			<xsl:call-template name="Bounds"/>
			<TextObj flags="{$TextObj.flags}">
				<xsl:call-template name="ExtendedAttributes"/>
				<!-- INHERIT ALL THEME CSS STYLES FROM FMP12 LAYOUT -->
				<Styles>
					<LocalCSS></LocalCSS>
					<FullCSS></FullCSS>
					<ThemeName></ThemeName>
				</Styles>
				<!-- Copy the formatted characters and paragraphs as is -->
				<xsl:copy-of select="TextObj/CharacterStyleVector"/>
				<xsl:copy-of select="TextObj/ParagraphStyleVector"/>
		
			</TextObj>
		</Object>		
	</xsl:template>
	<!-- Shapes
	
	<DrawStyle linePat="2" lineWidth="1" lineColor="#0" fillPat="2" fillEffect="0" fillColor="#FFFFCC00"/>
	
	-->
	<xsl:template match="Object[@type='Rect' or @type='RRect' or @type='Oval' or @type='Line']">
		<!-- Object -->
		<xsl:variable name="type" select="@type"/>
		<xsl:variable name="flags" select="@flags"/>
		<xsl:variable name="rotation" select="@rotation"/>
		<!-- old fm11 attribute - unused??????: -->
		<xsl:variable name="portal" select="@portal"/>
		<!-- new fmp12 attributes -->
		<xsl:variable name="key" select="'0'"/>
		<xsl:variable name="LabelKey" select="'0'"/>
		<!--  -->
		<Object type="{$type}" key="{$key}" LabelKey="{$LabelKey}" flags="{$flags}" rotation="{$rotation}">
			<xsl:call-template name="Bounds"/>
			<!-- INHERIT (nearly) ALL THEME CSS STYLES FROM FMP12 LAYOUT -->
			<Styles>
				<LocalCSS></LocalCSS>
				<FullCSS><!--
					self&#10;{
					<xsl:call-template name="CSS.BorderRadius">
						<xsl:with-param name="radius" select="'5.25'"/>
					</xsl:call-template>
					}-->
				</FullCSS>
				<ThemeName></ThemeName>
			</Styles>		
		</Object>
	</xsl:template>
	<!--
	 !
	 ! ===== NAMED TEMPLATES ===========================================================================
	 !
	 !-->
	<!-- "Bounds" -->
	<xsl:template name="Bounds">
		<!-- Bounds -->
		<xsl:variable name="Bounds.top.abs" select="number(Bounds/@top)"/>
		<xsl:variable name="Bounds.left.abs" select="number(Bounds/@left)"/>
		<xsl:variable name="Bounds.bottom.abs" select="number(Bounds/@bottom)"/>
		<xsl:variable name="Bounds.right.abs" select="number(Bounds/@right)"/>
		<!-- Calculate the width and height in order to calculate the relative coordinates -->
		<xsl:variable name="Bounds.width" select="$Bounds.right.abs - $Bounds.left.abs"/>
		<xsl:variable name="Bounds.height" select="$Bounds.bottom.abs - $Bounds.top.abs"/>
		<!-- Get the containing objects relative coordinates-->
		<xsl:variable name="Container.top.abs" select="number(ancestor::Object[1]/Bounds/@top)"/>
		<xsl:variable name="Container.left.abs" select="number(ancestor::Object[1]/Bounds/@left)"/>
		<!-- Calculate the relative coordinates-->
		<xsl:variable name="Bounds.top.rel">
			<xsl:call-template name="Calculate.Bounds.rel">
				<xsl:with-param name="absValueInner" select="$Bounds.top.abs"/>
				<xsl:with-param name="absValueOuter" select="ancestor::Object[1]/Bounds/@top"/>
				<!--xsl:with-param name="absValueOuter" select="(ancestor::Object|ancestor::TabPanelObj)[1]/Bounds/@top"/-->
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="Bounds.left.rel">
			<xsl:call-template name="Calculate.Bounds.rel">
				<xsl:with-param name="absValueInner" select="$Bounds.left.abs"/>
				<xsl:with-param name="absValueOuter" select="ancestor::Object[1]/Bounds/@left"/>
				<!--xsl:with-param name="absValueOuter" select="(ancestor::Object|ancestor::TabPanelObj)[1]/Bounds/@left"/-->
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="Bounds.bottom.rel" select="$Bounds.top.rel + $Bounds.height"/>
		<xsl:variable name="Bounds.right.rel" select="$Bounds.left.rel + $Bounds.width"/>
		<!--  -->
		<Bounds top="{$Bounds.top.rel}" left="{$Bounds.left.rel}" bottom="{$Bounds.bottom.rel}" right="{$Bounds.right.rel}"/>
	</xsl:template>
	<!-- "Calculate.Bounds.rel" -->
	<xsl:template name="Calculate.Bounds.rel">
		<xsl:param name="absValueInner" select="0"/>
		<xsl:param name="absValueOuter" select="0"/>
		<!--  -->
		<xsl:choose>
			<xsl:when test="string(number($absValueOuter))='NaN'">
				<xsl:value-of select="$absValueInner"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$absValueInner - $absValueOuter"/>
			</xsl:otherwise>
		</xsl:choose>
		
		
	</xsl:template>
	<!-- "ExtendedAttributes" 
	 !
	 ! Copies extended attributes from the preceding ObjectStyle element
	 !-->
	<xsl:template name="ExtendedAttributes">
		<!-- ExtendedAttributes -->
		<xsl:variable name="ExtendedAttributes.fontHeight" select="preceding-sibling::ObjectStyle[1]/@fontHeight"/>
		<xsl:variable name="ExtendedAttributes.graphicFormat" select="preceding-sibling::ObjectStyle[1]/@graphicFormat"/>
		<xsl:variable name="NumFormat.flags" select="preceding-sibling::ObjectStyle[1]/NumFormat/@flags"/>
		<xsl:variable name="NumFormat.charStyle" select="preceding-sibling::ObjectStyle[1]/NumFormat/@charStyle"/>
		<xsl:variable name="NumFormat.negativeStyle" select="preceding-sibling::ObjectStyle[1]/NumFormat/@negativeStyle"/>
		<xsl:variable name="NumFormat.currencySymbol" select="preceding-sibling::ObjectStyle[1]/NumFormat/@currencySymbol"/>
		<xsl:variable name="NumFormat.thousandsSep" select="preceding-sibling::ObjectStyle[1]/NumFormat/@thousandsSep"/>
		<xsl:variable name="NumFormat.decimalPoint" select="preceding-sibling::ObjectStyle[1]/NumFormat/@decimalPoint"/>
		<xsl:variable name="NumFormat.negativeColor" select="preceding-sibling::ObjectStyle[1]/NumFormat/@negativeColor"/>
		<xsl:variable name="NumFormat.decimalDigits" select="preceding-sibling::ObjectStyle[1]/NumFormat/@decimalDigits"/>
		<xsl:variable name="NumFormat.trueString" select="preceding-sibling::ObjectStyle[1]/NumFormat/@trueString"/>
		<xsl:variable name="NumFormat.falseString" select="preceding-sibling::ObjectStyle[1]/NumFormat/@falseString"/>
		<xsl:variable name="DateFormat.format" select="preceding-sibling::ObjectStyle[1]/DateFormat/@format"/>
		<xsl:variable name="DateFormat.charStyle" select="preceding-sibling::ObjectStyle[1]/DateFormat/@charStyle"/>
		<xsl:variable name="DateFormat.monthStyle" select="preceding-sibling::ObjectStyle[1]/DateFormat/@monthStyle"/>
		<xsl:variable name="DateFormat.dayStyle" select="preceding-sibling::ObjectStyle[1]/DateFormat/@dayStyle"/>
		<xsl:variable name="DateFormat.separator" select="preceding-sibling::ObjectStyle[1]/DateFormat/@separator"/>
		<xsl:variable name="DateElement1" select="preceding-sibling::ObjectStyle[1]/DateFormat/DateElement[1]"/>
		<xsl:variable name="DateElement2" select="preceding-sibling::ObjectStyle[1]/DateFormat/DateElement[2]"/>
		<xsl:variable name="DateElement3" select="preceding-sibling::ObjectStyle[1]/DateFormat/DateElement[3]"/>
		<xsl:variable name="DateElement4" select="preceding-sibling::ObjectStyle[1]/DateFormat/DateElement[4]"/>
		<xsl:variable name="DateElementSep0" select="preceding-sibling::ObjectStyle[1]/DateFormat/DateElementSep[@index=0]"/>
		<xsl:variable name="DateElementSep1" select="preceding-sibling::ObjectStyle[1]/DateFormat/DateElementSep[@index=1]"/>
		<xsl:variable name="DateElementSep2" select="preceding-sibling::ObjectStyle[1]/DateFormat/DateElementSep[@index=2]"/>
		<xsl:variable name="DateElementSep3" select="preceding-sibling::ObjectStyle[1]/DateFormat/DateElementSep[@index=3]"/>
		<xsl:variable name="DateElementSep4" select="preceding-sibling::ObjectStyle[1]/DateFormat/DateElementSep[@index=4]"/>
		<xsl:variable name="TimeFormat.flags" select="preceding-sibling::ObjectStyle[1]/TimeFormat/@flags"/>
		<xsl:variable name="TimeFormat.charStyle" select="preceding-sibling::ObjectStyle[1]/TimeFormat/@charStyle"/>
		<xsl:variable name="TimeFormat.hourStyle" select="preceding-sibling::ObjectStyle[1]/TimeFormat/@hourStyle"/>
		<xsl:variable name="TimeFormat.minsecStyle" select="preceding-sibling::ObjectStyle[1]/TimeFormat/@minsecStyle"/>
		<xsl:variable name="TimeFormat.separator" select="preceding-sibling::ObjectStyle[1]/TimeFormat/@separator"/>
		<xsl:variable name="TimeFormat.amString" select="preceding-sibling::ObjectStyle[1]/TimeFormat/@amString"/>
		<xsl:variable name="TimeFormat.pmString" select="preceding-sibling::ObjectStyle[1]/TimeFormat/@pmString"/>
		<xsl:variable name="TimeFormat.ampmString" select="preceding-sibling::ObjectStyle[1]/TimeFormat/@ampmString"/>
		<!--  -->
		<ExtendedAttributes fontHeight="{$ExtendedAttributes.fontHeight}" graphicFormat="{$ExtendedAttributes.graphicFormat}">
			<NumFormat flags="{$NumFormat.flags}" charStyle="{$NumFormat.charStyle}" negativeStyle="{$NumFormat.negativeStyle}" currencySymbol="{$NumFormat.currencySymbol}" thousandsSep="{$NumFormat.thousandsSep}" decimalPoint="{$NumFormat.decimalPoint}" negativeColor="{$NumFormat.negativeColor}" decimalDigits="{$NumFormat.decimalDigits}" trueString="{$NumFormat.trueString}" falseString="{$NumFormat.falseString}"/>
			<DateFormat format="{$DateFormat.format}" charStyle="{$DateFormat.charStyle}" monthStyle="{$DateFormat.monthStyle}" dayStyle="{$DateFormat.dayStyle}" separator="{$DateFormat.separator}">
				<DateElement><xsl:value-of select="$DateElement1"/></DateElement>
				<DateElement><xsl:value-of select="$DateElement2"/></DateElement>
				<DateElement><xsl:value-of select="$DateElement3"/></DateElement>
				<DateElement><xsl:value-of select="$DateElement4"/></DateElement>
				<DateElementSep index="0"><xsl:value-of select="$DateElementSep0"/></DateElementSep>
				<DateElementSep index="1"><xsl:value-of select="$DateElementSep1"/></DateElementSep>
				<DateElementSep index="2"><xsl:value-of select="$DateElementSep2"/></DateElementSep>
				<DateElementSep index="3"><xsl:value-of select="$DateElementSep3"/></DateElementSep>
				<DateElementSep index="4"><xsl:value-of select="$DateElementSep4"/></DateElementSep>
			</DateFormat>
			<TimeFormat flags="{$TimeFormat.flags}" charStyle="{$TimeFormat.charStyle}" hourStyle="{$TimeFormat.hourStyle}" minsecStyle="{$TimeFormat.minsecStyle}" separator="{$TimeFormat.separator}" amString="{$TimeFormat.amString}" pmString="{$TimeFormat.pmString}" ampmString="{$TimeFormat.ampmString}"/>
		</ExtendedAttributes>
	</xsl:template>
	<!-- CSS.Border.Radius -->
	<xsl:template name="CSS.Border.Radius">
		<xsl:param name="radius"/>
		<!--  -->
		<xsl:variable name="RptRpt" select="concat($radius,'pt ',$radius,'pt')"/>
		<!--  -->
		<xsl:value-of select="concat('border-top-right-radius: ',$RptRpt,';&#10;&#09;border-bottom-right-radius: ',$RptRpt,';&#10;&#09;border-bottom-left-radius: ',$RptRpt,';&#10;&#09;border-top-left-radius: ',$RptRpt,';&#10;&#09;',$var,'border-top-right-radius: 5.25pt 5.25pt;&#10;&#09;border-bottom-right-radius: 5.25pt 5.25pt;&#10;&#09;border-bottom-left-radius: 5.25pt 5.25pt;&#10;&#09;border-top-left-radius: 5.25pt 5.25pt;&#10;&#09;')"/>
	</xsl:template>
	
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
