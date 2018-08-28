<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSC_Text.Lines_ListScriptCalls.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Returns just the Perform Script steps. everythig else is removed.
	
	Relevance of this XSLT:
	
	   XML has Perform Script steps  =>  50%

	@XsltRelevanceXpath="
	  50 * number(not(not( Step[@id=1] )))
	"
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2011-2016
	2011-09-30 MrW: inc/constants.xsl
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<xsl:variable name="indent" select="'  '"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Script -->
	<xsl:template match="//Script[not(ancestor::Step)]">
		<xsl:text>Script </xsl:text>
		<xsl:value-of select="@name"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:apply-templates select="Step"/>
	</xsl:template>
	<!-- Script step 1. Script ausführen -->
	<xsl:template match="Step[@id='1' and @enable='True']">
		<xsl:value-of select="$indent"/>
		<xsl:value-of select="'=>'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:if test="FileReference/@name">
			<xsl:value-of select="FileReference/@name"/>
			<xsl:text>#</xsl:text>
		</xsl:if>
		<xsl:value-of select="Script/@name"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="translate(Calculation,$CRLF,' ')"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
