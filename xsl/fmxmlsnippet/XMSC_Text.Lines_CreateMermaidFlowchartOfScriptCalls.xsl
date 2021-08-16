<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSC_Text.Lines_CreateMermaidFlowchartOfScriptCalls.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts
	
	Creates a mermaid flowchart text
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 20121
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="ind" select="'    '"/>
	<xsl:variable name="eol">
	<xsl:text>
	</xsl:text>
	</xsl:variable>

	<xsl:param name="graphDrection" select="'LR'"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- 
	 !
	 ! Main
	 !
	 ! -->
	<xsl:template match="/">
		<xsl:value-of select="concat('```mermaid',$eol)"/>
		<xsl:value-of select="concat('graph ',$graphDrection,$eol)"/>
		<xsl:apply-templates select="descendant::Script"/>
		<xsl:value-of select="concat('```',$eol)"/>
	</xsl:template>

	<!--
	 !
	 ! Script
	 !
	 !-->
	<xsl:template match="Script">
		
		<xsl:choose>
			<xsl:when test="@name='-'">
				<!--
				 !
				 ! ignore Script Seperator
				 !
				 !-->
			</xsl:when>
			<xsl:when test="@name=' '">
				<!--
				 !
				 ! ignore Script Spacer
				 !
				 !-->
			</xsl:when>
			<xsl:otherwise>
				<!--
				 !
				 ! Script
				 !
				 !-->
				<xsl:variable name="subgraph" select="substring( 'subgraph ',9999)"/>
				<!-- -->
				<xsl:variable name="scriptId"   select="concat('script',@id)"/>
				<xsl:variable name="scriptName" select="concat('&quot;',translate(@name,'&quot;',''),'&quot;')"/>
				<!-- -->
				<xsl:value-of select="concat($ind,$subgraph,$scriptId,'[[',$scriptName,']]',$eol)"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates select="Step"/>
	</xsl:template>


	<!-- Step -->
	<xsl:template match="Step[contains(@name,'Perform Script')]">
		<xsl:variable name="script1Id"   select="concat('script',ancestor::Script/@id)"/>
		<xsl:variable name="script2Id"   select="concat('script',Script/@id)"/>
		<!-- -->
		<xsl:variable name="script1Name" select="@name"/>
		<xsl:variable name="script2Name" select="Script/@name"/>
		<!-- -->
		<xsl:value-of select="concat($ind,$script1Id,'-->',$script2Id,$eol)"/>
	</xsl:template>
	
	<xsl:template match="text()"/>
</xsl:stylesheet>
