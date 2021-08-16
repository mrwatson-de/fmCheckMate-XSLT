<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2021 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMAA_Text.Tab_ListNamesWhichAreTooLong.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied filemaker objects

	Lists all names which are too long (> 100 charcaters)
	
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2021
	2021-02-25 MrW: 
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== PARAMS ===== -->
	<xsl:param name="NameLengthMax" select="100"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- report long names -->
	
	<xsl:template match="/">
		<xsl:value-of select="'Object'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Original Long Name'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="concat('Cropped to ',$NameLengthMax,' chars')"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="'-'"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="*[@name]">
		<xsl:if test="string-length(@name) > 10">
			<xsl:value-of select="name(.)"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:value-of select="@name"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:value-of select="substring(@name,1,$NameLengthMax)"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:if>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
