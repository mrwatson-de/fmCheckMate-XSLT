<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: inc.fmCM_Results.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: any copied FileMaker objects
	
	Functions (named templates) to create a filemaker analysis.
	
	===== CHANGES HISTORY =====
	2016-01-25 MrW: Version 1.0.2 Corrected reference of Style info for ButtonBars
	2015-11-17 MrW: Version 1.0.1 Corrected reference of Style info
	2015-09-12 MrW: Version 1.0
	-->
	<!-- ===== NEEDS ===== -->
	<!-- fn.getXpath.xsl
	 !-->
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="K_FMCM_ERROR" select="1"/>
	<xsl:variable name="K_FMCM_WARNING" select="2"/>
	<xsl:variable name="K_FMCM_OK" select="3"/>
	<xsl:variable name="K_FMCM_INFO" select="4"/>
	<xsl:variable name="K_FMCM_DEBUG" select="5"/>
	<!-- ===== NAMED TEMPLATES ===== -->
	<!--
	 ! fmCM.Results.writeHeader
	 ! 
	 ! Writes the header part of the FMPXMLRESULT XML
	 ! 
	 ! Here is an example of how to call this template.
	 ! 
	 ! 		<xsl:template match="/">
	 ! 			<FMPXMLRESULT xmlns="http://www.filemaker.com/fmpxmlresult">
	 ! 				<xsl:call-template name="fmCM.Results.writeHeader"/>
	 ! 				<RESULTSET FOUND="0">
	 ! 					<xsl:apply-templates select="*"/>
	 ! 				</RESULTSET>
	 ! 			</FMPXMLRESULT>
	 ! 		</xsl:template>
	 ! 
	 !-->
	<xsl:template name="fmCM.Results.writeHeader">
		<ERRORCODE>0</ERRORCODE>
		<PRODUCT BUILD="07-18-2011" NAME="FileMaker" VERSION="ProAdvanced 11.0v4"/>
		<DATABASE DATEFORMAT="D.m.yyyy" TIMEFORMAT="k:mm:ss " LAYOUT="" NAME="fmCheckMate.fmp12" RECORDS="0"/>
		<METADATA>
			<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="ErrorLevel" TYPE="NUMBER"/>
			<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Event" TYPE="TEXT"/>
			<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Result" TYPE="TEXT"/>
			
			<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="ObjectDescription" TYPE="TEXT"/>
			<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="ObjectXpath" TYPE="TEXT"/>
			<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="ObjectType" TYPE="TEXT"/>
			<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="ObjectName" TYPE="TEXT"/>
			<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="ObjectPosition" TYPE="TEXT"/>
			<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="ObjectParent" TYPE="TEXT"/>
			<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="ObjectPath" TYPE="TEXT"/>
			<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="ObjectStyleID" TYPE="TEXT"/>
			<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="ObjectStyleName" TYPE="TEXT"/>
			<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="ObjectThemeID" TYPE="TEXT"/>
			<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="ObjectThemeName" TYPE="TEXT"/>
			<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="ObjectLocalCSS" TYPE="TEXT"/>
			<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="ObjectFullCSS" TYPE="TEXT"/>
			<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="ObjectSVGHexData" TYPE="TEXT"/>
			
			<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="SnippetPosition" TYPE="TEXT"/>
			<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="LayoutName" TYPE="TEXT"/>
		</METADATA>
	</xsl:template>
	<!-- 
	 ! fmCM.Results.writeResult
	 ! 
	 ! Writes a result row to the FMPXMLRESULT XML.
	 ! The only required parameter is Result, 
	 ! You only need to supply the parameters you want to write.
	 ! If not specified the ErrorLevel defaults to 4=Information
	 !
	 ! 
	 ! Here is an example of how to call this template.
	 ! 
	 ! 		<xsl:template match="some problem element">
	 ! 				<xsl:call-template name="fmCM.Results.writeResult">
	 ! 					<xsl:with-param name="ErrorLevel" select="1"/>
	 ! 					<xsl:with-param name="Result" select="''Object X is broken."/>
	 ! 				</xsl:call-template>
	 ! 		</xsl:template>
	 !
	 ! and here is a typical example of reporting
	 !
	 ! 		<xsl:call-template name="fmCM.Results.writeResult">
	 ! 			<xsl:with-param name="ErrorLevel" select="2"/>
	 ! 			<xsl:with-param name="Result">
	 ! 				<xsl:value-of select="'Floating object: '"/>
	 ! 				<xsl:apply-templates select="." mode="toString"/>
	 ! 				<xsl:value-of select="' is FLOATING IN FRONT OF container '"/>
	 ! 				<xsl:value-of select="$container"/>
	 ! 			</xsl:with-param>
	 ! 			<xsl:with-param name="ObjectType" select="@type"/>
	 ! 			<xsl:with-param name="ObjectPosition">
	 ! 				<xsl:call-templates name="fn.GetAbsBoundsOfCurrentNodeAsNumber"/>
	 ! 			</xsl:with-param>
	 ! 			<xsl:with-param name="ObjectXpath">
	 ! 				<xsl:call-template name="fn.getXpath">
	 ! 					<xsl:with-param name="node" select="."/>
	 ! 				</xsl:call-template>
	 ! 			</xsl:with-param>
	 ! 		</xsl:call-template>
	 !	 !-->
	<xsl:template name="fmCM.Results.writeResult">
		<!-- ErrorLevel: 1=Error/2=Warning/3=OK/4=Info/5=Debug -->
		<xsl:param name="ErrorLevel" select="4"/>
		<!-- Event: Short title -->
		<xsl:param name="Event" select="''"/>
		<!-- Human readable description of the result - REQUIRED -->
		<xsl:param name="Result" select="''"/>
		<!-- Human readable description of the object in question -->
		<xsl:param name="ObjectDescription" select="''"/>
		<!--
		 ! ObjectXpath:
		 !   Xpath to the object in the XML - OR -
		 !   if a NODE is passed, the Xpath to the object is calculated automatically
		 !-->
		<xsl:param name="ObjectXpath" select="''"/>
		<!-- ... -->
		<xsl:param name="ObjectType" select="''"/>
		<xsl:param name="ObjectName" select="''"/>
		<xsl:param name="ObjectPosition" select="''"/>
		<xsl:param name="ObjectParent" select="''"/>
		<xsl:param name="ObjectPath" select="''"/>
		<xsl:param name="ObjectStyleID" select="''"/>
		<xsl:param name="ObjectStyleName" select="''"/>
		<xsl:param name="ObjectThemeID" select="''"/>
		<xsl:param name="ObjectThemeName" select="''"/>
		<xsl:param name="ObjectLocalCSS" select="''"/>
		<xsl:param name="ObjectFullCSS" select="''"/>
		<xsl:param name="ObjectSVGHexData" select="''"/>
		<xsl:param name="SnippetPosition" select="''"/>
		<xsl:param name="LayoutName" select="''"/>
		<!-- -->
		<ROW>
			<!-- Column: ErrorLevel -->
			<COL>
				<DATA>
					<xsl:value-of select="$ErrorLevel"/>
				</DATA>
			</COL>
			<!-- Column: Event -->
			<COL>
				<DATA>
					<xsl:value-of select="$Event"/>
				</DATA>
			</COL>
			<!-- Column: Result -->
			<COL>
				<DATA>
					<xsl:value-of select="$Result"/>
				</DATA>
			</COL>
			<!-- Column: ObjectDescription -->
			<COL>
				<DATA>
					<xsl:value-of select="$ObjectDescription"/>
				</DATA>
			</COL>
			<!-- Column: ObjectXpath -->
			<COL>
				<DATA>
					<xsl:value-of select="$ObjectXpath"/>
				</DATA>
			</COL>
			<!-- Column: ObjectType -->
			<COL>
				<DATA>
					<xsl:value-of select="$ObjectType"/>
				</DATA>
			</COL>
			<!-- Column: ObjectName -->
			<COL>
				<DATA>
					<xsl:value-of select="$ObjectName"/>
				</DATA>
			</COL>
			<!-- Column: ObjectPosition -->
			<COL>
				<DATA>
					<xsl:value-of select="$ObjectPosition"/>
				</DATA>
			</COL>
			<!-- Column: ObjectParent -->
			<COL>
				<DATA>
					<xsl:value-of select="$ObjectParent"/>
				</DATA>
			</COL>
			<!-- Column: ObjectPath -->
			<COL>
				<DATA>
					<xsl:value-of select="$ObjectPath"/>
				</DATA>
			</COL>
			<!-- Column: ObjectStyleID -->
			<COL>
				<DATA>
					<xsl:value-of select="$ObjectStyleID"/>
				</DATA>
			</COL>
			<!-- Column: ObjectStyleName -->
			<COL>
				<DATA>
					<xsl:value-of select="$ObjectStyleName"/>
				</DATA>
			</COL>
			<!-- Column: ObjectThemeID -->
			<COL>
				<DATA>
					<xsl:value-of select="$ObjectThemeID"/>
				</DATA>
			</COL>
			<!-- Column: ObjectThemeName -->
			<COL>
				<DATA>
					<xsl:value-of select="$ObjectThemeName"/>
				</DATA>
			</COL>
			<!-- Column: ObjectLocalCSS -->
			<COL>
				<DATA>
					<xsl:value-of select="$ObjectLocalCSS"/>
				</DATA>
			</COL>
			<!-- Column: ObjectFullCSS -->
			<COL>
				<DATA>
					<xsl:value-of select="$ObjectFullCSS"/>
				</DATA>
			</COL>
			<!-- Column: ObjectSVGHexData -->
			<COL>
				<DATA>
					<xsl:value-of select="$ObjectSVGHexData"/>
				</DATA>
			</COL>
			<!-- Column: SnippetPosition -->
			<COL>
				<DATA>
					<xsl:value-of select="$SnippetPosition"/>
				</DATA>
			</COL>
			<!-- Column: LayoutName -->
			<COL>
				<DATA>
					<xsl:value-of select="$LayoutName"/>
				</DATA>
			</COL>
		</ROW>
	</xsl:template>
	<xsl:template name="fmCM.Results.writeResultForCurrentNode">
		<xsl:param name="ErrorLevel"/>
		<xsl:param name="Event" select="''"/>
		<xsl:param name="Result" select="''"/>
		<xsl:param name="ObjectDescription" select="''"/>
		<xsl:param name="ObjectXpath" select="''"/>
		<xsl:param name="ObjectType" select="''"/>
		<xsl:param name="ObjectName" select="''"/>
		<xsl:param name="ObjectPosition" select="''"/>
		<xsl:param name="ObjectParent" select="''"/>
		<xsl:param name="ObjectPath" select="''"/>
		<xsl:param name="ObjectStyleID" select="''"/>
		<xsl:param name="ObjectStyleName" select="''"/>
		<xsl:param name="ObjectThemeID" select="''"/>
		<xsl:param name="ObjectThemeName" select="''"/>
		<xsl:param name="ObjectLocalCSS" select="''"/>
		<xsl:param name="ObjectFullCSS" select="''"/>
		<xsl:param name="ObjectSVGHexData" select="''"/>
		<xsl:param name="SnippetPosition" select="''"/>
		<xsl:param name="LayoutName" select="''"/>
		<!-- -->
		<!-- Select the containing Object if an object is not itself selected -->
		<xsl:for-each select="ancestor-or-self::Object[1]">
			<xsl:call-template name="fmCM.Results.writeResult">
				<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
				<xsl:with-param name="Event" select="$Event"/>
				<xsl:with-param name="Result" select="$Result"/>
				<xsl:with-param name="ObjectDescription" select="$ObjectDescription"/>
				<xsl:with-param name="ObjectXpath">
					<xsl:choose>
						<xsl:when test="$ObjectXpath">
							<xsl:value-of select="$ObjectXpath"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="fn.getXpath">
								<xsl:with-param name="node" select="."/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="ObjectType">
					<xsl:choose>
						<xsl:when test="$ObjectType">
							<xsl:value-of select="$ObjectType"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="@type"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="ObjectName">
					<xsl:choose>
						<xsl:when test="$ObjectName">
							<xsl:value-of select="$ObjectName"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="@name"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="ObjectPosition">
					<xsl:choose>
						<xsl:when test="$ObjectPosition">
							<xsl:value-of select="$ObjectPosition"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="fn.GetAbsBoundsOfCurrentNodeAsNumber"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="ObjectParent" select="$ObjectParent"/>
				<xsl:with-param name="ObjectPath">
					<xsl:choose>
						<xsl:when test="$ObjectPath">
							<xsl:value-of select="$ObjectPath"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="getPathDescriptionOfCurrentNode"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="ObjectStyleID">
					<xsl:choose>
						<xsl:when test="$ObjectStyleID">
							<xsl:value-of select="$ObjectStyleID"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="(*/Styles/CustomStyles/Name)[1]"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="ObjectStyleName" select="$ObjectStyleName"/>
				<xsl:with-param name="ObjectThemeID" select="$ObjectThemeID"/>
				<xsl:with-param name="ObjectThemeName" select="$ObjectThemeName"/>
				<xsl:with-param name="ObjectLocalCSS">
					<xsl:choose>
						<xsl:when test="$ObjectLocalCSS">
							<xsl:value-of select="$ObjectLocalCSS"/>
						</xsl:when>
						<xsl:when test="Styles/LocalCSS">
							<xsl:value-of select="Styles/LocalCSS"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="(*/Styles/LocalCSS)[1]"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="ObjectFullCSS">
					<xsl:choose>
						<xsl:when test="$ObjectFullCSS">
							<xsl:value-of select="$ObjectFullCSS"/>
						</xsl:when>
						<xsl:when test="Styles/FullCSS">
							<xsl:value-of select="Styles/FullCSS"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="(*/Styles//FullCSS)[1]"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="ObjectSVGHexData">
					<xsl:choose>
						<xsl:when test="$ObjectSVGHexData">
							<xsl:value-of select="$ObjectSVGHexData"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="*/Stream[Type='SVG ']/HexData"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="SnippetPosition">
					<xsl:choose>
						<xsl:when test="$SnippetPosition">
							<xsl:value-of select="$SnippetPosition"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:for-each select="ancestor::Layout">
								<xsl:call-template name="fn.GetAbsBoundsOfCurrentNodeAsNumber"/>
							</xsl:for-each>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="LayoutName">
					<xsl:choose>
						<xsl:when test="$LayoutName">
							<!-- Manual layout name -->
							<xsl:value-of select="$LayoutName"/>
						</xsl:when>
						<xsl:otherwise>
							<!-- DDR Layout name -->
							<xsl:value-of select="ancestor::Layout/@name"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
