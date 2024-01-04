<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" xmlns:str="http://exslt.org/strings" extension-element-prefixes="str date" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: inc.XML2_Text.SVG_RenderBounds.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	RenderBounds function for layout objects to generate SVG
	
	FIXME
	
	
	
	===== CHANGES HISTORY =====
	2015-04-27 MrW v0.1
	-->
	<!-- ===== NEEDS ===== -->
	<!-- ===== TEMPLATES WITH MODES ===== -->
	<!--
	 ! Object.toString
	 ! Writes the name and position of an object
	 !-->
	<xsl:template match="Object" mode="RenderBounds">
		<xsl:call-template name="getDescriptionOfCurrentNode"/>
		<xsl:value-of select="' '"/>
		<xsl:call-template name="fn.GetAbsBoundsOfCurrentNodeAsNumber"/>
	</xsl:template>
+
</xsl:stylesheet>
