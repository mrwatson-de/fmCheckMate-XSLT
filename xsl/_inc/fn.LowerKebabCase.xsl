<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: fn.LowerKebabCase.xsl

	XML-Source: any.xml
	XML-Grammar: any
	XML-Content: any

	fn.LowerKebabCase function converts the text to lower-kebab-case.

	===== CHANGES HISTORY =====
	2025-10-11 MrW: Version 1.0
	-->
	<!-- ===== TEMPLATES ===== -->
	<!-- 
	 ! fn.LowerKebabCase function 
	 !
	 ! converts the text to lower-kebab-case.
	 !-->
	<xsl:template name="fn.LowerKebabCase">
		<xsl:param name="text"/>
		<!-- -->
		<xsl:value-of select="translate($text,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ','abcdefghijklmnopqrstuvwxyz-')"/>
	</xsl:template>
</xsl:stylesheet>