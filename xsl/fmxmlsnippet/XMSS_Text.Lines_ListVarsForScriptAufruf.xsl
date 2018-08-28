<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_Text.Lines_ListVarsForScriptAufruf.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps - the Set-Var steps which define the script parameters
	
	Produces a commented FileMaker calculation for use in the ScriptParameter when calling the Script.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2011-2016
	2011-09-30 MrW: inc/constants.xsl
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../FMPReport/ToHTML/English.lproj/Strings.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!--xsl:variable name="scriptParameterDelimiter" select="¶"/-->
	<xsl:variable name="scriptParameterDelimiter" select="$PIPE"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Set Var Script step-->
	<xsl:template match="/">
		<xsl:for-each select="//Step[@id='141']">
			<xsl:value-of select="Name"/>
			<xsl:value-of select="concat(' &amp; ',$QUOT,$scriptParameterDelimiter,$QUOT,' &amp; /* ')"/>
			<xsl:value-of select="normalize-space(substring-before(substring-after(Value/Calculation/text(),'('), ')'))"/>
			<xsl:value-of select="1+count(preceding-sibling::Step[@id='141'])"/>
			<xsl:value-of select="'. '"/>
			<xsl:value-of select="Name"/>
			<xsl:value-of select="' */'"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:for-each>
		<xsl:text><![CDATA[""]]></xsl:text>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
