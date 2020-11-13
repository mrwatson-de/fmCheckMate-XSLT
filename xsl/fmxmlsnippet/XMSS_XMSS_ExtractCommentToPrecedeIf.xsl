<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_ExtractCommentToPrecedeIf.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	The steps
	
		If [condition /* Comment */]
	
	are converted to
	
		If [condition]
			#Comment
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2014-10-09 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- if with a comment -->
	<xsl:template match="Step[(@id='68' or @id='125') and contains(Calculation/text(),'/*')]">
		<xsl:variable name="enable" select="@enable"/>
		<xsl:variable name="id" select="@id"/>
		<xsl:variable name="commentText" select="normalize-space(substring-before(substring-after(Calculation,'/*'),'*/'))"/>
		<xsl:variable name="calculation" select="substring-before(Calculation,'/*')"/>
		<!--  -->
		<Step enable="{$enable}" id="89">
			<Text>
				<xsl:value-of select="$commentText"/>
			</Text>
		</Step>
		<Step enable="{$enable}" id="{$id}">
			<Calculation>
				<xsl:value-of select="$calculation"/>
			</Calculation>
		</Step>
	</xsl:template>
</xsl:stylesheet>
