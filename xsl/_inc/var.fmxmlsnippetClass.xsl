<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: inc/var.fmxmlsnippetTypeClass.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: any FileMaker Clipboard content
	
	Returns the FileMaker Clipboard content type based on the first element of the fmxmlsnippet.
	
	===== CHANGES HISTORY =====
	2017-05-29 MrW: Version 2.4 Added XMVL = ValueLists
	2015-08-28 MrW: Version 2.3 Better recognition of XML2
	2014-05-27 MrW: Version 2.2 Extended to support FileMaker Themes (XMTH)
	2013-09-12 MrW: Version 2.1 Corrects the CustomFunction class to XMFN
	2013-05-10 MrW: Version 2.0 Defines 3 vars $fmxmlsnippetClass, $fmxmlsnippetObject, $fmxmlsnippetObjects
	2011-10-05 MrW: Version 1.0
	-->
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="fmxmlsnippetClass">
		<xsl:choose>
			<xsl:when test="not(/fmxmlsnippet or /dummy)">
				<xsl:value-of select="''"/>
			</xsl:when>
			<xsl:when test="/*/Script  or  /*/Group">
				<xsl:value-of select="'XMSC'"/>
			</xsl:when>
			<xsl:when test="/*/Step">
				<xsl:value-of select="'XMSS'"/>
			</xsl:when>
			<xsl:when test="/*/BaseTable">
				<xsl:value-of select="'XMTB'"/>
			</xsl:when>
			<xsl:when test="/*/Field">
				<xsl:value-of select="'XMFD'"/>
			</xsl:when>
			<xsl:when test="/*/CustomFunction">
				<xsl:value-of select="'XMFN'"/>
			</xsl:when>
			<xsl:when test="/*/Theme">
				<xsl:value-of select="'XMTH'"/>
			</xsl:when>
			<xsl:when test="(/*/Layout or /*/@type='LayoutObjectList')">
				<xsl:choose>
					<xsl:when test="//Object/@LabelKey">
						<xsl:value-of select="'XML2'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'XMLO'"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="/*/ValueList">
				<xsl:value-of select="'XMVL'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="''"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="fmxmlsnippetObject">
		<xsl:choose>
			<xsl:when test="$fmxmlsnippetClass=''">
				<xsl:value-of select="''"/>
			</xsl:when>
			<xsl:when test="$fmxmlsnippetClass='XMSC'">
				<xsl:value-of select="'Script'"/>
			</xsl:when>
			<xsl:when test="$fmxmlsnippetClass='XMSS'">
				<xsl:value-of select="'Scriptstep'"/>
			</xsl:when>
			<xsl:when test="$fmxmlsnippetClass='XMTB'">
				<xsl:value-of select="'Table'"/>
			</xsl:when>
			<xsl:when test="$fmxmlsnippetClass='XMFD'">
				<xsl:value-of select="'Field'"/>
			</xsl:when>
			<xsl:when test="$fmxmlsnippetClass='XMFN'">
				<xsl:value-of select="'CustomFunction'"/>
			</xsl:when>
			<xsl:when test="$fmxmlsnippetClass='XMTH'">
				<xsl:value-of select="'Theme'"/>
			</xsl:when>
			<xsl:when test="$fmxmlsnippetClass='XMLO'">
				<xsl:value-of select="'LayoutObject'"/>
			</xsl:when>
			<xsl:when test="$fmxmlsnippetClass='XML2'">
				<xsl:value-of select="'LayoutObject'"/>
			</xsl:when>
			<xsl:when test="$fmxmlsnippetClass='XMVL'">
				<xsl:value-of select="'ValueList'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="''"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="fmxmlsnippetObjects">
		<xsl:choose>
			<xsl:when test="$fmxmlsnippetClass=''">
				<xsl:value-of select="''"/>
			</xsl:when>
			<xsl:when test="$fmxmlsnippetClass='XMSC'">
				<xsl:value-of select="'Scripts'"/>
			</xsl:when>
			<xsl:when test="$fmxmlsnippetClass='XMSS'">
				<xsl:value-of select="'Scriptsteps'"/>
			</xsl:when>
			<xsl:when test="$fmxmlsnippetClass='XMTB'">
				<xsl:value-of select="'Tables'"/>
			</xsl:when>
			<xsl:when test="$fmxmlsnippetClass='XMFD'">
				<xsl:value-of select="'Fields'"/>
			</xsl:when>
			<xsl:when test="$fmxmlsnippetClass='XMFN'">
				<xsl:value-of select="'CustomFunctions'"/>
			</xsl:when>
			<xsl:when test="$fmxmlsnippetClass='XMTH'">
				<xsl:value-of select="'Themes'"/>
			</xsl:when>
			<xsl:when test="$fmxmlsnippetClass='XMLO'">
				<xsl:value-of select="'LayoutObjects'"/>
			</xsl:when>
			<xsl:when test="$fmxmlsnippetClass='XML2'">
				<xsl:value-of select="'LayoutObjects'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="''"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
</xsl:stylesheet>
