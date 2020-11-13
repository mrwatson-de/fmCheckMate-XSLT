<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMFD_XMFD_SelectFieldsWithpPrefixpSuffix.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied fields or tables

	Selects fields which begin with the suffix and end with the prefix.

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2012-09-06 MrW: Version 1.0 Rewritten as Select function with XML output
	2011-09-30 MrW: inc/constants.xsl
	2011-08-10 MrW: Version 0.9
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== PARAMS ===== -->
	<xsl:param name="pPrefix"/>
	<xsl:param name="pSuffix"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="SuffixLength" select="string-length($pSuffix)"/>
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Remove all Fields that don't match the parameters -->
	<!-- Main -->
	<xsl:template match="/">
		pPrefix:<xsl:value-of select="$pPrefix"/>
		pSuffix:<xsl:value-of select="$pSuffix"/>
	</xsl:template>
	<xsl:template match="//Field[not(ancestor::Field)]">
		<xsl:value-of select="$pPrefix"/>
		<xsl:if test="starts-with(@name,$pPrefix) and ($pSuffix='' or substring(@name,string-length(@name)-$SuffixLength+1)=$pSuffix)">
				a<xsl:copy-of select="."/>
			</xsl:if>
	</xsl:template>
</xsl:stylesheet>
