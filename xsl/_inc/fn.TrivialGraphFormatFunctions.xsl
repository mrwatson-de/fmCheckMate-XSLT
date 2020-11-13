<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: fn.TrivialGraphFormatFunctions.xsl

	XML-Source: any.xml
	XML-Grammar: any
	XML-Content: any
	
	Functions for creating tgf graphs.
	
	The returned Xpath may be used to reference the node in the current or future XSLT session.
	(The generate-id() function is only valid for the current XSLT session)
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2015-09-11 MrW Version 1.0
	-->
	<!-- ===== NEEDS ===== -->
	<!--nothing-->
	<!-- ===== TEMPLATES ===== -->
	<!-- tgf.Node -->
	<xsl:template name="tgf.Node">
		<xsl:param name="name"/>
		<xsl:param name="id"/>
		<!-- -->
		<xsl:value-of select="$id"/>
		<xsl:value-of select="' '"/>
		<xsl:value-of select="$id"/>
		<xsl:value-of select="'&#x0D;'"/>
	</xsl:template>
</xsl:stylesheet>
