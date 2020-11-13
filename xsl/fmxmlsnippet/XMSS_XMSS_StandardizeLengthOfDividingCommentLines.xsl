<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_StandardizeLengthOfDividingCommentLines.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps - with comments
	
	Any divinding comments (comprising ONLY #-characters and at least 10 characters long), are set to the given length.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2017-09-27 MrW: Version 1.0 
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== PARAMETER ===== -->
	<!-- default length = 76, so that WITH comment + space = 76 -->
	<xsl:param name="DividingCommentLength" select="76"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- 89/Comment with #####s -->
	<xsl:template match="Step[@id='89' and contains(Text,'##########') and translate(Text,'#','')='']/Text/text()">
		<!-- Up to 160 -->
		<xsl:value-of select="substring('################################################################################################################################################################',1,$DividingCommentLength)"/>
	</xsl:template>
	<!-- 89/Comment with =====s -->
	<xsl:template match="Step[@id='89' and contains(Text,'==========') and translate(Text,'=','')='']/Text/text()">
		<!-- Up to 160 -->
		<xsl:value-of select="substring('================================================================================================================================================================',1,$DividingCommentLength)"/>
	</xsl:template>
	<!-- 89/Comment with dashes -->
	<xsl:template match="Step[@id='89' and contains(Text,'----------') and translate(Text,'-','')='']/Text/text()">
		<!-- Up to 160 -->
		<xsl:value-of select="substring('----------------------------------------------------------------------------------------------------------------------------------------------------------------',1,$DividingCommentLength)"/>
	</xsl:template>
</xsl:stylesheet>
