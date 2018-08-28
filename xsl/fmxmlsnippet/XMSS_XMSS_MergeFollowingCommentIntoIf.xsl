<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_MergeFollowingCommentIntoIf.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	The steps
	
		If [condition]
			#Comment
	
	are converted to
	
		If [condition /* Comment */]
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2016
	2014-10-09 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- if with a following non-empty comment -->
	<xsl:template match="Step[(@id='68' or @id='125') and following-sibling::Step[1][@id='89' and Text/text()!='']]">
		<xsl:variable name="enable" select="@enable"/>
		<xsl:variable name="id" select="@id"/>
		<xsl:variable name="commentText" select="following-sibling::*[1][@id='89']/Text/text()"/>
		<!--  -->
		<Step enable="{$enable}" id="{$id}">
			<Calculation>
				<xsl:value-of select="concat(Calculation, ' /* ',$commentText,' */')"/>
			</Calculation>
		</Step>
	</xsl:template>
	<!-- non-empty comment following an if => REMOVE! -->
	<xsl:template match="Step[@id='89' and Text/text()!='' and preceding-sibling::Step[1][@id='68' or @id='125']]"/>
</xsl:stylesheet>
