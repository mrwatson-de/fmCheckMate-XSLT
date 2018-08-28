<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSC_XMSC_SortScriptsById.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts
	
	Sorts scripts and groups by ID.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2017
	2017-12-04 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main templat-->
	<xsl:template match="/">
		<xsl:copy>
			<xsl:for-each select="//Script[not(ancestor::Step)]|//Group[not(ancestor::Step)]">
				<xsl:sort select="@id" data-type="number"/>
				<!-- -->
				<xsl:choose>
					<xsl:when test="name()='Script'">
						<xsl:copy-of select="."/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:variable name="id" select="@id"/>
						<xsl:variable name="name" select="@name"/>
						
						<Group id="{$id}" name="{$name}"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
