<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_ExplodeCommentLines.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps - with comments
	
	Any comments with multiple lines will be split into multiple single comment lines.
	
	Now processes CRLF, CR and LF ... Note: but NOT mixed in a comment.
	
	@see XMSS_XMSS_MergeCommentLines.xsl for the inverse function


	Relevance of this XSLT:
	
	   XML has no comments with CR/LF    =>   0%
	   XML has some comments with CR/LF  =>  50%
	   XML no active steps               => +25%
	   XML has no comments without CR/LF => +25%

	@XsltRelevanceXpath="
	  1  * number(not(not( //Step[@id=89 and (contains(Text/text(),'&#13;') or contains(Text/text(),'&#10;'))]   ))) * (
	  50 +
	  25 * number(not(not( //Step[@id=89 and not(contains(Text,'&#13;')) and not(contains(Text/text(),'&#10;'))] ))) +
	  25 * number(not(     //Step[@id!=89 and @enable='True']                                                    ))
	  )
	"
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2016-17
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
		<xsl:variable name="line" select="substring-before($text,$delim)"/>
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
