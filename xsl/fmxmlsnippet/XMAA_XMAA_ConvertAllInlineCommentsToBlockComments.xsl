<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMAA_XMAA_ConvertAllInlineCommentsToBlockComments.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: any copied objects
	
	Converts all 
	
		<Calculation>inline line //comment¶line 2</Calculation>
	
	to
	
		<Calculation>inline line /* comment */¶line 2</Calculation>
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2017-10-18 MrW: Version 1.1 - bug fixed
	2014-10-10 MrW: Version 1.0 - parsing calculations is tricky - but possible!!!
	2014-10-09 MrW: Version 0.1
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Match a calculation text with an inline comment -->
	<xsl:template match="Calculation/text()[contains(.,'//')]">
		<xsl:call-template name="parse.Calculation.convertInlineCommentsToBlockComments">
			<xsl:with-param name="calculation" select="."/>
		</xsl:call-template>
	</xsl:template>
	<!-- ===== NAMED TEMPLATES ===== -->
	<!-- parse.Calculation.convertInlineCommentsToBlockComments -->
	<xsl:template name="parse.Calculation.convertInlineCommentsToBlockComments">
		<xsl:param name="calculation"/>
		<!-- -->
		<xsl:variable name="posInlineComment" select="string-length(substring-before($calculation,'//'))+number(contains($calculation,'//'))"/>
		<xsl:variable name="posQuote" select="string-length(substring-before($calculation,$QUOT))+number(contains($calculation,$QUOT))"/>
		<xsl:variable name="posBlockComment" select="string-length(substring-before($calculation,'/*'))+number(contains($calculation,'/*'))"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="$posInlineComment=0">
				<!-- finished -->
				<xsl:value-of select="$calculation"/>
			</xsl:when>
			<xsl:when test="($posQuote!=0 and $posQuote &lt; $posInlineComment) or ($posBlockComment!=0 and $posBlockComment &lt; $posInlineComment)">
				<!-- a string or block comment comes first -->
				<xsl:variable name="len">
					<xsl:choose>
						<xsl:when test="$posQuote=0 or ($posQuote!=0 and $posBlockComment!=0 and $posBlockComment &lt; $posQuote)">
							<!-- skip Block Comment -->
							<xsl:value-of select="string-length(substring-before($calculation,'*/')) + 2"/>
						</xsl:when>
						<xsl:otherwise>
							<!-- skip string -->
							<xsl:call-template name="parse.Calculation.String.GetPositionOfClosingQuote">
								<xsl:with-param name="stringCalculation" select="substring($calculation,$posQuote+1)"/>
								<xsl:with-param name="len" select="$posQuote"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<!-- output + recurse -->
				<xsl:value-of select="substring($calculation,1,$len)"/>
				<xsl:call-template name="parse.Calculation.convertInlineCommentsToBlockComments">
					<xsl:with-param name="calculation" select="substring($calculation,$len+1)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<!-- convert... -->
				<xsl:value-of select="concat(substring-before($calculation,'//'),'/* ')"/>
				<xsl:variable name="rest" select="substring-after($calculation,'//')"/>
				<xsl:choose>
					<xsl:when test="not(contains($rest,$LF))">
						<!-- ..last one -->
						<xsl:value-of select="concat($rest,' */')"/>
					</xsl:when>
					<xsl:otherwise>
						<!-- ...and recurse -->
						<xsl:value-of select="concat(substring-before($rest,$LF),' */',$LF)"/>
						<xsl:call-template name="parse.Calculation.convertInlineCommentsToBlockComments">
							<xsl:with-param name="calculation" select="substring-after($rest,$LF)"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- parse.Calculation.String.GetPositionOfClosingQuote -->
	<xsl:template name="parse.Calculation.String.GetPositionOfClosingQuote">
		<xsl:param name="stringCalculation"/>
		<xsl:param name="len"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="not(contains($stringCalculation,$QUOT))">
				<!-- string not closed (syntax error) -->
				<xsl:value-of select="$len + string-length($stringCalculation) + 1"/>
			</xsl:when>
			<xsl:when test="not(contains(substring-before($stringCalculation,$QUOT),'\'))">
				<!-- simple string -->
				<xsl:value-of select="$len + string-length(substring-before($stringCalculation,$QUOT)) + 1"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- string with escape char - recurse ignoring the escape and the following character-->
				<xsl:variable name="posBackslash" select="1+string-length(substring-before($stringCalculation,'\'))"/>
				<xsl:call-template name="parse.Calculation.String.GetPositionOfClosingQuote">
					<xsl:with-param name="stringCalculation" select="substring($stringCalculation,$posBackslash+2)"/>
					<xsl:with-param name="len" select="$len + $posBackslash+1"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
