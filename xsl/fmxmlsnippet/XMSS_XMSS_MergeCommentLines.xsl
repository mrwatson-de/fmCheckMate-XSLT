<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_MergeCommentLines.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps - with comments
	
	Merges all comments into the first comment line, separating them with an EOL.
	
	@see XMSS_XMSS_ExplodeCommentLines.xsl for the inverse function
	
	Relevance of this XSLT:
	
	   XML less than 2 comments         => 0%
	   XML has at least two comments    => 50%
	   XML has no active steps          => +25%
	   XML has no steps                 => +25%

	@XsltRelevanceXpath="
	  1  * number(         count( //Step[@id=89] )&gt;1       ) * (
	  50 +
	  25 * number(not(not( //Step[@id!=89 and @enable='True'] ))) +
	  25 * number(not(not( //Step[@id!=89]                    )))
	  )
	"
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2016-10-11 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- 89 = Comment-->
	<xsl:template match="//Step[@id='89']">
		<xsl:if test="not(preceding-sibling::Step[@id='89'])">
			<!-- FIRST comment in a script -->
			<Step enable="True" id="89" name="comment">
				<Text>
					<!-- Comment 1 -->
					<xsl:value-of select="Text/text()"/>
					<!-- Comment 2..n -->
					<xsl:for-each select="following-sibling::Step[@id='89']">
						<!-- -->
						<xsl:value-of select="'&#13;'"/>
						<xsl:value-of select="Text/text()"/>
					</xsl:for-each>
				</Text>
			</Step>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
