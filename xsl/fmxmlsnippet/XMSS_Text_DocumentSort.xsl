<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_Text_DocumentSort.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps - with Sort Records script steps
	
	Produces a documentation comment.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2011-2016
	2011-12-06 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Sort Script step-->
	<xsl:template match="/">
		<xsl:for-each select="//Step[@id='39' and SortList/@value='True']">
			<xsl:value-of select="'Sort: '"/>
			<xsl:for-each select="SortList[@value='True']/Sort/PrimaryField/Field">
				<xsl:value-of select="concat(@table,'::',@name)"/>
				<xsl:if test="not(position() = last())">
					<xsl:value-of select="', '"/>
				</xsl:if>
			</xsl:for-each>
			<xsl:if test="not(position() = last())">
				<xsl:value-of select="$newrecord"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
