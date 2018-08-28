<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xalan="http://xml.apache.org/xalan" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: _inc/fn.BaseFunctions.xsl

	XML-Source: any.xml
	XML-Grammar: any
	XML-Content: any

	Functions for processing bases (base 16 and bits).
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2011-2016
	2013-05-16 MrW: Version 1.0
	-->
	<!-- ===== TEMPLATES ===== -->
	<!-- Bit
	 ! Tests the bit in the value
	 !-->
	<xsl:template name="Bit">
		<xsl:param name="inVal"/>
		<xsl:param name="inBit"/>
		<xsl:choose>
			<xsl:when test="(($inVal mod ($inBit*2)) - ($inVal mod ($inBit))) &gt; 0">
				<xsl:value-of select="'true'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'false'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
