<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: inc.fmCM_Results_XMFN.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: any copied FileMaker objects
	
	Functions (named templates) to create a filemaker analysis.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2016
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
		<!-- -->
		<!-- Select the containing CustomFunction if an object is not itself selected -->
		<xsl:for-each select="ancestor-or-self::CustomFunction">
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
							<xsl:value-of select="'Function'"/>
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
							<xsl:value-of select="'-'"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="ObjectParent" select="'-'"/>
				<xsl:with-param name="ObjectPath">
					<xsl:choose>
						<xsl:when test="$ObjectPath">
							<xsl:value-of select="$ObjectPath"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'-'"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
