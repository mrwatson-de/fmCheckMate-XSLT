<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: fn.PathFunctions.xsl

	XML-Source: any.xml
	XML-Grammar: any
	XML-Content: any

	Functions for processing paths.

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2011-2016
	2013-06-25 MrW Added fn.Filter
	2011-01-13 MrW: Version 1.0
	-->
	<!-- ===== NEEDS ===== -->
	<!--xsl:include href="fn.SubstringFunctions.xsl"/-->
	<!-- ===== TEMPLATES ===== -->
	<!-- 
	 ! fn.filename function 
	 !
	 !   Returns the filename in the path using the given path delimiter
	 !-->
	<xsl:template name="fn.filename">
		<xsl:param name="path"/>
		<xsl:param name="pathDelimiter" select="'/'"/>
		<xsl:call-template name="fn.substring-after-last">
			<xsl:with-param name="text" select="$path"/>
			<xsl:with-param name="searchString" select="$pathDelimiter"/>
		</xsl:call-template>
	</xsl:template>
	<!-- 
	 ! fn.folder-path function 
	 !
	 !   Returns the fn.folder-path part of the path using the given path delimiter
	 !-->
	<xsl:template name="fn.folder-path">
		<xsl:param name="path"/>
		<xsl:param name="pathDelimiter" select="'/'"/>
		<xsl:call-template name="fn.substring-before-first">
			<xsl:with-param name="text" select="$path"/>
			<xsl:with-param name="searchString" select="$pathDelimiter"/>
		</xsl:call-template>
		<xsl:value-of select="$pathDelimiter"/>
	</xsl:template>
</xsl:stylesheet>
