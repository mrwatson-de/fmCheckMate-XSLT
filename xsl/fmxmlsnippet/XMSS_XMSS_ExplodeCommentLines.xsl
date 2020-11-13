<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_ExplodeCommentLines.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps - with comments
	
	Any comments with multiple lines will be split into multiple single comment lines.
	
	Now processes CRLF, CR and LF ... Note: but NOT mixed in a comment.
	
	@see XMSS_XMSS_MergeCommentLines.xsl for the inverse function

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2020-04-07 MrW: Version 1.1 Corrected a long standing bug which caused the last line to be lost.
	2017-09-08 MrW: Version 1.0 Renamed to frequently used 'Explode' instead of 'Split', extended to deal with CRLF, CR and LF, and added the XSLT Relevance function
	2016-10-11 MrW: Version 0.1
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- 89/Comment with CRLF -->
	<xsl:template match="Step[@id='89' and contains(Text,'&#13;&#10;')]">
		<!-- expand -->
		<xsl:call-template name="CreateSingleLineComments">
			<xsl:with-param name="text" select="Text/text()"/>
			<xsl:with-param name="delim" select="'&#13;&#10;'"/>
		</xsl:call-template>
	</xsl:template>
	<!-- 89/Comment with CR -->
	<xsl:template match="Step[@id='89' and contains(Text,'&#13;')]">
		<!-- expand -->
		<xsl:call-template name="CreateSingleLineComments">
			<xsl:with-param name="text" select="Text/text()"/>
			<xsl:with-param name="delim" select="'&#13;'"/>
		</xsl:call-template>
	</xsl:template>
	<!-- 89/Comment with LF -->
	<xsl:template match="Step[@id='89' and contains(Text,'&#10;')]">
		<!-- expand -->
		<xsl:call-template name="CreateSingleLineComments">
			<xsl:with-param name="text" select="Text/text()"/>
			<xsl:with-param name="delim" select="'&#10;'"/>
		</xsl:call-template>
	</xsl:template>
	<!-- ===== NAMED TEMPLATES ===== -->
	<!-- CreateSingleLineComments -->
	<xsl:template name="CreateSingleLineComments">
		<xsl:param name="text"/>
		<xsl:param name="delim"/>
		<!-- -->
		<xsl:variable name="line">
			<xsl:choose>
				<xsl:when test="not(contains($text,$delim))">
					<xsl:value-of select="$text"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring-before($text,$delim)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="rest" select="substring-after($text,$delim)"/>
		<Step enable="True" id="89" name="comment">
			<Text>
				<xsl:value-of select="$line"/>
			</Text>
		</Step>
		<xsl:if test="$rest">
			<xsl:call-template name="CreateSingleLineComments">
				<xsl:with-param name="text" select="$rest"/>
				<xsl:with-param name="delim" select="$delim"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
