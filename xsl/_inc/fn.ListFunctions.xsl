<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xalan="http://xml.apache.org/xalan" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: _inc/fn.ListFunctions.xsl

	XML-Source: any.xml
	XML-Grammar: any
	XML-Content: any

	Functions for processing lists.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2011-2016
	2013-09-05 MrW: Template ScriptStepParameterList refactored upwards.
	  :
	2011-01-13 MrW: Version 1
	-->
	<!-- ===== TEMPLATES ===== -->
	<!-- 
	 ! fn.OutputDelimitedList function 
	 !
	 !   UNDER CONSTRUCTION
	 !   Places the given delimiter between the elements of the list.
	 !-->
	<xsl:template name="fn.OutputDelimitedList">
		<xsl:param name="pList"/>
		<xsl:param name="pListDelimiter" select="'; '"/>
		<xsl:param name="pListFinalDelimiter" select="$pListDelimiter"/>
		<!---->
		<xsl:for-each select="xalan:nodeset($pList)/text()">
			<xsl:if test="position()&gt;1">
				<xsl:value-of select="$pListDelimiter"/>
			</xsl:if>
			<xsl:value-of select="."/>
		</xsl:for-each>
	</xsl:template>
	<!-- 
	 ! fn.RemoveFinalDelimiterFromTextList function 
	 !
	 !   Removes the final delimiter from the list, if any.
	 !-->
	<xsl:template name="fn.RemoveFinalDelimiterFromTextList">
		<xsl:param name="pTextList"/>
		<xsl:param name="pDelimiter"/>
		<!---->
		<xsl:choose>
			<xsl:when test="substring($pTextList, string-length($pTextList)-string-length($pDelimiter)+1)=$pDelimiter">
				<xsl:value-of select="substring($pTextList, 1, string-length($pTextList)-string-length($pDelimiter))"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$pTextList"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
