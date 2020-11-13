<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" xmlns:str="http://exslt.org/strings" extension-element-prefixes="str date" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: inc.XML2_CommonTemplates.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	Common templates for layout transformations.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2015-04-27 MrW: Bounds more efficient
	2014-09-13 MrW: Bounds
	-->
	<!-- ===== NEEDS ===== -->
	<!--xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/-->
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XMSS_Text_PrintSteps.xsl"/>
	<!--
	 !===== inc.XMSS_Text.Lines_ListIndented INTERFACE PARAMETERS =====
	 !-->
	<!-- The following parameters MUST be implemented in the including XSLT. -->
	<!--
	<xsl:param name="pShowLineNumbers" select="'True'"/>
	<xsl:param name="pShowScriptIDs" select="'True'"/>
	<xsl:param name="pIndentGroups" select="'False'"/>
	<xsl:param name="pIndentScripts" select="'False'"/>
	<xsl:param name="pIndentScriptSteps" select="'True'"/>
	...
	-->
	<!--
	 !===== inc.XMSS_Text.List VARIABLES =====
	 !-->
	<!-- 
	 ! delimiter    = THIS DELIMITER IS UNUSED
	 ! delimiter1   = Start of the parameter list
	 ! delimiter2   = Delimiter between names and values
	 ! delimiter3   = Delimiter between parameter list items
	 ! delimiter4   = End of the parameter list
	 ! newrecord    = End of line character(s)
	 !
	 ! pIndentString = The text to use for each indent level (""=none)
	 ! pIndentLevel  = The basis indent level
	 !-->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="delimiter1" select="' ['"/>
	<xsl:variable name="delimiter2" select="': '"/>
	<xsl:variable name="delimiter3" select="'; '"/>
	<xsl:variable name="delimiter4" select="']'"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!--
	 !===== inc.XMSS_Text.List TEMPLATES =====
	 !-->
	<!--
	 ! ScriptGroups
	 !-->
	<!-- ScriptGroupSTART -->
	<xsl:template name="ScriptGroupSTART"/>
	<xsl:template name="ScriptGroupEND"/>
	<xsl:template name="ScriptStepSTART"/>
	<xsl:template name="ScriptStepEND"/>
	<xsl:template name="ScriptStepSTARTEND"/>
	<xsl:template name="ScriptStepParameterList"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Bounds -->
	<xsl:template match="Bounds" mode="getRelativeLeftTopRightBottom">
		<xsl:value-of select="normalize-space(concat(number(@left),' ',number(@top),' ',number(@right),' ',number(@bottom)))"/>
	</xsl:template>
	<!-- Get Object Path -->
	<xsl:template match="Object" mode="getObjectPath">
		<xsl:apply-templates select="../../Object" mode="getObjectPath"/>
		<xsl:choose>
			<xsl:when test="@type='Text'">
				<xsl:value-of select="'T'"/>
			</xsl:when>
			<xsl:when test="@type='Field'">
				<xsl:value-of select="'F'"/>
			</xsl:when>
			<xsl:when test="@type='Button'">
				<xsl:value-of select="'B'"/>
			</xsl:when>
			<xsl:when test="@type='Portal'">
				<xsl:value-of select="':'"/>
			</xsl:when>
			<xsl:when test="@type='GroupButton'">
				<xsl:value-of select="'{'"/>
			</xsl:when>
			<xsl:when test="@type='PopoverButton'">
				<xsl:value-of select="'['"/>
			</xsl:when>
			<xsl:when test="@type='Popover'">
				<xsl:value-of select="']'"/>
			</xsl:when>
			<xsl:when test="@type='SlideControl'">
				<xsl:value-of select="'•'"/>
			</xsl:when>
			<xsl:when test="@type='SlidePanel'">
				<xsl:value-of select="'&gt;'"/>
			</xsl:when>
			<xsl:when test="@type='TabControl'">
				<xsl:value-of select="'|'"/>
			</xsl:when>
			<xsl:when test="@type='TabPanel'">
				<xsl:value-of select="'&gt;'"/>
			</xsl:when>
			<xsl:when test="@type='Graphic'">
				<xsl:value-of select="'G'"/>
			</xsl:when>
			<xsl:when test="@type='Line'">
				<xsl:value-of select="'/'"/>
			</xsl:when>
			<xsl:when test="@type='Rect'">
				<xsl:value-of select="'R'"/>
			</xsl:when>
			<xsl:when test="@type='RRect'">
				<xsl:value-of select="'R'"/>
			</xsl:when>
			<xsl:when test="@type='Oval'">
				<xsl:value-of select="'O'"/>
			</xsl:when>
			<xsl:when test="@type='ExternalObject'">
				<xsl:value-of select="'X'"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- Get Object Name -->
	<xsl:template match="Object" mode="getObjectName">
		<xsl:choose>
			<xsl:when test="@name">
				<xsl:value-of select="concat($APOS,@name,$APOS)"/>
			</xsl:when>
			<xsl:when test="GroupButtonObj/Object[@type='Text']/@name">
				<!-- Button names are on the contained *text* object -->
				<xsl:value-of select="concat($APOS,GroupButtonObj/Object[@type='Text']/@name,$APOS)"/>
			</xsl:when>
		</xsl:choose>
		<xsl:value-of select="str:replace(normalize-space(concat(@left,' ',@top,' ',@right,' ',@bottom)),'.0000000','')"/>
	</xsl:template>
	<!-- Get Object Type -->
	<xsl:template match="Object" mode="getObjectType">
		<!-- Object Type -->
		<xsl:value-of select="@type"/>
		<xsl:if test="ExternalObj/@typeID">
			<xsl:value-of select="concat(' (',ExternalObj/@typeID,')')"/>
		</xsl:if>
	</xsl:template>
	<!-- Get Object Reference -->
	<xsl:template match="Object" mode="getObjectReference">
		<xsl:choose>
			<!--xsl:when test="TabControlObj/TabPanelObj/TextObj/ParagraphStyleVector/Style/Data">
				<xsl:value-of select="concat('|',translate(TabControlObj/TabPanelObj/TextObj/ParagraphStyleVector/Style/Data,$TABCRLF,'  '),'|')"/>
			</xsl:when-->
			<xsl:when test="PortalObj/TableAliasKey">
				<xsl:value-of select="concat(PortalObj/TableAliasKey,'::')"/>
			</xsl:when>
			<xsl:when test="FieldObj/Name">
				<xsl:value-of select="FieldObj/Name"/>
			</xsl:when>
			<xsl:when test="GroupButtonObj/Object/TextObj/ParagraphStyleVector/Style/Data">
				<xsl:value-of select="concat('[',translate(GroupButtonObj/Object/TextObj/ParagraphStyleVector/Style/Data,$TABCRLF,'  '),']')"/>
			</xsl:when>
			<xsl:when test="TextObj/ParagraphStyleVector/Style/Data">
				<xsl:variable name="text" select="translate(TextObj/ParagraphStyleVector/Style/Data,$TABCRLF,'  ')"/>
				<xsl:variable name="textMaxLen" select="29"/>
				<xsl:value-of select="$QUOT"/>
				<xsl:choose>
					<xsl:when test="string-length($text)&gt;$textMaxLen">
						<xsl:value-of select="concat(substring($text,1,$textMaxLen - 1),'…')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$text"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="$QUOT"/>
			</xsl:when>
			<xsl:when test="GroupButtonObj">
				<xsl:value-of select="concat('Group containing ',count(.//Object),' Objects')"/>
			</xsl:when>
			<xsl:when test="@type='TabPanel'">
				<xsl:value-of select="concat('=',translate(TitleCalc/Calculation,$TABCRLF,'  '))"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- Object -->
	<xsl:template match="Step" mode="">
		<xsl:value-of select="'Action:'"/>
		<xsl:choose>
			<xsl:when test="Script/@name">
				<xsl:value-of select="concat('Perform Script [',$QUOT,Script/@name,$QUOT)"/>
				<xsl:if test="FileReference">
					<xsl:value-of select="concat(' from file: ',$QUOT,FileReference/@name,$QUOT)"/>
				</xsl:if>
				<xsl:if test="Calculation/text()">
					<xsl:value-of select="concat('; Parameter: ',translate(Calculation,$CRLF,' '))"/>
				</xsl:if>
				<xsl:value-of select="']'"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- -->
	<xsl:template match="Object" mode="getDelimitedDescriptionLine">
		<!-- Bounds -->
		<xsl:apply-templates select="Bounds" mode="getRelativeLeftTopRightBottom"/>
		<xsl:value-of select="$delimiter"/>
		<!-- Object Path -->
		<xsl:apply-templates select="ancestor-or-self::Object" mode="getObjectPath"/>
		<xsl:value-of select="$delimiter"/>
		<!-- Object Name -->
		<xsl:apply-templates select="." mode="getObjectName"/>
		<xsl:value-of select="$delimiter"/>
		<!-- Object Type -->
		<xsl:apply-templates select="." mode="getObjectType"/>
		<xsl:value-of select="$delimiter"/>
		<!-- Object -->
		<xsl:apply-templates select="." mode="getObjectReference"/>
		<xsl:value-of select="$delimiter"/>
		<!-- Action -->
		<xsl:apply-templates select="GroupButtonObj/Step | ButtonObj/Step"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
</xsl:stylesheet>
