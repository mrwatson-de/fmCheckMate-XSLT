<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: inc.fmCM_Results_XMSC.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: any copied scripts
	
	
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2019-05-27 MrW: Version 0.1
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
		<DATABASE DATEFORMAT="D.m.yyyy" TIMEFORMAT="k:mm:ss " LAYOUT="" NAME="fmCheckMate.fmp12"
			RECORDS="0"/>
		<METADATA>
			<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="ErrorLevel" TYPE="NUMBER"/>
			<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Event" TYPE="TEXT"/>
			<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Result" TYPE="TEXT"/>

			<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="ScriptDescription" TYPE="TEXT"/>
			<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="ScriptXpath" TYPE="TEXT"/>
			<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="ScriptType" TYPE="TEXT"/>
			<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="ScriptName" TYPE="TEXT"/>
			<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="ScriptPath" TYPE="TEXT"/>
			<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="ScriptParent" TYPE="TEXT"/>
			<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="ScriptStepPos" TYPE="TEXT"/>
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
	 ! 					<xsl:with-param name="Result" select="''Script X is broken."/>
	 ! 				</xsl:call-template>
	 ! 		</xsl:template>
	 !
	 ! and here is a typical example of reporting
	 !
	 ! 		<xsl:call-template name="fmCM.Results.writeResult">
	 ! 			<xsl:with-param name="ErrorLevel" select="2"/>
	 ! 			<xsl:with-param name="Result">
	 ! 				<xsl:value-of select="'Floating Script: '"/>
	 ! 				<xsl:apply-templates select="." mode="toString"/>
	 ! 				<xsl:value-of select="' is FLOATING IN FRONT OF container '"/>
	 ! 				<xsl:value-of select="$container"/>
	 ! 			</xsl:with-param>
	 ! 			<xsl:with-param name="ScriptType" select="@type"/>
	 ! 			<xsl:with-param name="ScriptPosition">
	 ! 				<xsl:call-templates name="fn.GetAbsBoundsOfCurrentNodeAsNumber"/>
	 ! 			</xsl:with-param>
	 ! 			<xsl:with-param name="ScriptXpath">
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
		<!-- Human readable description of the Script in question -->
		<xsl:param name="ScriptDescription" select="''"/>
		<!--
		 ! ScriptXpath:
		 !   Xpath to the Script in the XML - OR -
		 !   if a NODE is passed, the Xpath to the Script is calculated automatically
		 !-->
		<xsl:param name="ScriptXpath" select="''"/>
		<!-- ... -->
		<xsl:param name="ScriptType" select="''"/>
		<xsl:param name="ScriptName" select="''"/>
		<xsl:param name="ScriptPosition" select="''"/>
		<xsl:param name="ScriptParent" select="''"/>
		<xsl:param name="ScriptPath" select="''"/>
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
			<!-- Column: ScriptDescription -->
			<COL>
				<DATA>
					<xsl:value-of select="$ScriptDescription"/>
				</DATA>
			</COL>
			<!-- Column: ScriptXpath -->
			<COL>
				<DATA>
					<xsl:value-of select="$ScriptXpath"/>
				</DATA>
			</COL>
			<!-- Column: ScriptType -->
			<COL>
				<DATA>
					<xsl:value-of select="$ScriptType"/>
				</DATA>
			</COL>
			<!-- Column: ScriptName -->
			<COL>
				<DATA>
					<xsl:value-of select="$ScriptName"/>
				</DATA>
			</COL>
			<!-- Column: ScriptPosition -->
			<COL>
				<DATA>
					<xsl:value-of select="$ScriptPosition"/>
				</DATA>
			</COL>
			<!-- Column: ScriptParent -->
			<COL>
				<DATA>
					<xsl:value-of select="$ScriptParent"/>
				</DATA>
			</COL>
			<!-- Column: ScriptPath -->
			<COL>
				<DATA>
					<xsl:value-of select="$ScriptPath"/>
				</DATA>
			</COL>
		</ROW>
	</xsl:template>
	<xsl:template name="fmCM.Results.writeResultForCurrentNode">
		<xsl:param name="ErrorLevel"/>
		<xsl:param name="Event" select="''"/>
		<xsl:param name="Result" select="''"/>
		<xsl:param name="ScriptDescription" select="''"/>
		<xsl:param name="ScriptXpath" select="''"/>
		<xsl:param name="ScriptType" select="''"/>
		<xsl:param name="ScriptName" select="''"/>
		<xsl:param name="ScriptPosition" select="''"/>
		<xsl:param name="ScriptParent" select="''"/>
		<xsl:param name="ScriptPath" select="''"/>
		<!-- -->
		<!-- Select the containing Script/Group if the Script is not itself selected -->

		<xsl:call-template name="fmCM.Results.writeResult">
			<xsl:with-param name="ErrorLevel" select="$ErrorLevel"/>
			<xsl:with-param name="Event" select="$Event"/>
			<xsl:with-param name="Result" select="$Result"/>
			<xsl:with-param name="ScriptDescription" select="$ScriptDescription"/>
			<xsl:with-param name="ScriptXpath">
				<xsl:choose>
					<xsl:when test="$ScriptXpath">
						<xsl:value-of select="$ScriptXpath"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="fn.getXpath">
							<xsl:with-param name="node" select="."/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="ScriptType">
				<xsl:choose>
					<xsl:when test="$ScriptType">
						<xsl:value-of select="$ScriptType"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'Script'"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="ScriptName">
				<xsl:choose>
					<xsl:when test="$ScriptName">
						<xsl:value-of select="$ScriptName"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="@name"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="ScriptPosition">
				<xsl:choose>
					<xsl:when test="$ScriptPosition">
						<xsl:value-of select="$ScriptPosition"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'-'"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="ScriptParent" select="ancestor::Group[1]/@name"/>
			<xsl:with-param name="ScriptPath">
				<xsl:choose>
					<xsl:when test="$ScriptPath">
						<xsl:value-of select="$ScriptPath"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'-'"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>

	</xsl:template>
</xsl:stylesheet>
