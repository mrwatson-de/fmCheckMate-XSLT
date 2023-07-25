<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_AddGetAsNumberToExitLoopIf.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Protects faulty Exit Loop variable comparisons by ensuring variables are compared as number.
	
	Exit Loop If [ $var < $var ] steps are converted to Exit Loop If [ GetAsNumber( $var ) < GetAsNumber( $var ) ]
	
	
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2023
	2023-07-25 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.MatchAndTrim.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Match (the calculation text of) Exit Loop If containing at least one variable but no unequal sign ('<>')   -->
	<xsl:template match="Step[@id='72']/Calculation/text()[contains(.,'$') and not( contains(.,'&lt;&gt;') )]">
		<!-- Check for a relevant comparison operator -->
		<xsl:variable name="comparison">
			<xsl:call-template name="getFirstMatchAndSurroundingWhiteSpace">
				<xsl:with-param name="pText" select="."/>
				<xsl:with-param name="pSearchTerms" select="'&gt;=|&gt;|&lt;=|&lt;|≥|≤'"/>
			</xsl:call-template>
		</xsl:variable>
		<!--  -->
		<xsl:choose>
			<xsl:when test="$comparison = ''">

				<!-- Leave the calculation unchanged if no comparison operator present -->
				<xsl:value-of select="."/>
				
			</xsl:when>
			<xsl:otherwise>

				<!-- Otherwise insert the GetAsNumber functions -->
				<xsl:value-of select="concat('GetAsNumber ( ',substring-before( ., $comparison ),' )')"/>
				<xsl:value-of select="$comparison"/>
				<xsl:value-of select="concat('GetAsNumber ( ',substring-after( ., $comparison ),' )')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
