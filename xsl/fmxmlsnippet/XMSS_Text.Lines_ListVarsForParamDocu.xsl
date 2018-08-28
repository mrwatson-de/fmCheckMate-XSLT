<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_Text.Lines_ListVarsForParamDocu.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps - the Set-Var steps which define the script parameters
	
	Produces the documentation template for the script parameters.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2011-2016
	2013-12-23 MrW: Version 1.0.1 Removed unnecessary and broken include
	2011-01-21 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Set Var Script step-->
	<xsl:template match="/">
		<xsl:for-each select="//Step[@id='141' and @enable='True']">
			<xsl:text>  </xsl:text>
			<xsl:value-of select="normalize-space(substring-before(substring-after(Value/Calculation/text(),'('), ')'))"/>
			<xsl:value-of select="1+count(preceding-sibling::Step)"/>
			<xsl:text>. </xsl:text>
			<xsl:value-of select="Name"/>
			<xsl:text> - </xsl:text>
			<xsl:choose>
				<xsl:when test="substring-after(Name,'$$')!=''">
					<xsl:value-of select="substring-after(Name,'$$')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring-after(Name,'$')"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:value-of select="$newrecord"/>
		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
