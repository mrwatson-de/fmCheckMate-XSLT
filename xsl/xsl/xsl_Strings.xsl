<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: xsl_Strings.xsl

	XML-Source: any.xsl
	XML-Grammar: xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	XML-Content: any xslt stylesheet
	
	Convert a FileMaker DDR Strings.xsl file into an s-Template.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2011-02-09 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/">
		
	</xsl:template>
	<xsl:template match="//xsl:variable">
		<xsl:variable name="varName" select="@name"/>
		<xsl:element name="when" namespace="xsl">
			<xsl:attribute name="test">
				
			</xsl:attribute>
		</xsl:element>
		<xsl:element name="">
			
		</xsl:element>
		<xsl:text>&gt;xsl:value-of select="{$str}"/&lt;</xsl:text>
	</xsl:template>
	<!--  -->
	<xsl:template name="s">
		<xsl:param name="str" select="''"/>
		<!--  -->
		<xsl:choose><xsl:when test="$str='Rect'"><xsl:value-of select="$valRect"/></xsl:when>
			 :
		</xsl:choose>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
