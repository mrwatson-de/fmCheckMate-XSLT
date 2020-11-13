<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:date="http://exslt.org/dates-and-times"
	extension-element-prefixes="date"
	version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: fn.DateFunctions.xsl

	XML-Source: any.xml
	XML-Grammar: any
	XML-Content: any

	Functions. Substitute

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2011-01-13 MrW: Version 1.0
	-->
	<!-- ===== TEMPLATES ===== -->
	<!-- 
	 ! fn.CurrentDate function 
	 !
	 !   Returns the date.
	 !-->
	<xsl:template name="fn.CurrentDate">
		<xsl:value-of select="substring-before(date:date-time(), 'T')"/>
	</xsl:template>
	<!-- 
	 ! fn.CurrentTime function 
	 !
	 !   Returns the time.
	 !-->
	<xsl:template name="fn.CurrentTime">
		<xsl:value-of select="substring-after(date:date-time(), 'T')"/>
	</xsl:template>
	<!-- 
	 ! fn.CurrentTimestamp function 
	 !
	 !   Returns the date and time.
	 !-->
	<xsl:template name="fn.CurrentTimestamp">
		<xsl:value-of select="concat(substring-before(date:date-time(), 'T'),' ',substring-after(date:date-time(), 'T'))"/>
	</xsl:template>
</xsl:stylesheet>
