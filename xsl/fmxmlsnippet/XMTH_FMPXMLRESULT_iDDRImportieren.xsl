<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMTH_FMPXMLRESULT_iDDRImportieren.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied FileMaker theme
	
	For importing the iDDR Theme file.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2016-02-21 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<!-- ===== TEMPLATES ===== -->
	<xsl:template match="/">
		<FMPXMLRESULT xmlns="http://www.filemaker.com/fmpxmlresult">
			<ERRORCODE>0</ERRORCODE>
			<PRODUCT BUILD="07-18-2011" NAME="FileMaker" VERSION="ProAdvanced 11.0v4"/>
			<DATABASE DATEFORMAT="D.m.yyyy" TIMEFORMAT="k:mm:ss " LAYOUT="" NAME="fmCheckMate.fmp12" RECORDS="0"/>
			<METADATA>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="ThemeInternalID" TYPE="TEXT"/>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="ThemeName" TYPE="TEXT"/>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="StyleInternalID" TYPE="TEXT"/>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="StyleName" TYPE="TEXT"/>
			</METADATA>
			<RESULTSET FOUND="0">
				<xsl:apply-templates select="*"/>
			</RESULTSET>
		</FMPXMLRESULT>
	</xsl:template>
	<xsl:template match="Theme">
		<xsl:variable name="ThemeIinternalID" select="@internalName"/>
		<xsl:variable name="ThemeName" select="@name"/>
		<!-- -->
		<ROW>
			<!-- Column: ThemeInternalID -->
			<COL>
				<DATA>
					<xsl:value-of select="$ThemeIinternalID"/>
				</DATA>
			</COL>
			<!-- Column: ThemeName -->
			<COL>
				<DATA>
					<xsl:value-of select="$ThemeName"/>
				</DATA>
			</COL>
			<!-- Column: StyleIntrenalID -->
			<COL>
				<DATA>
					<xsl:value-of select="''"/>
				</DATA>
			</COL>
			<!-- Column: StyleName -->
			<COL>
				<DATA>
					<xsl:value-of select="''"/>
				</DATA>
			</COL>
		</ROW>
		<xsl:for-each select="metadata/namedstyles/*">
			<xsl:sort select="text()"/>
			<!-- -->
			<ROW>
				<!-- Column: ThemeInternalID -->
				<COL>
					<DATA>
						<xsl:value-of select="$ThemeIinternalID"/>
					</DATA>
				</COL>
				<!-- Column: ThemeName -->
				<COL>
					<DATA>
						<xsl:value-of select="$ThemeName"/>
					</DATA>
				</COL>
				<!-- Column: StyleIntrenalID -->
				<COL>
					<DATA>
						<xsl:value-of select="name(.)"/>
					</DATA>
				</COL>
				<!-- Column: StyleName -->
				<COL>
					<DATA>
						<xsl:value-of select="text()"/>
					</DATA>
				</COL>
			</ROW>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
