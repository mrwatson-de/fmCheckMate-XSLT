<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XML2_Text.Tab_PrintScripts.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied Layout Objects

	Lists script steps in a layout (Buttons and Triggers)
	
	===== CHANGES HISTORY =====
	2017-08-14 MrW: Version 1.0.1 Improved formatting: Larger indent and step reference with an arrow
	2017-07-27 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:include href="XMSS_Text.Lines_Print.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fn.toString.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.GetAbsoluteBounds.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.GetXpath.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="arrow_right" select="'&#x2192; '"/>
	<xsl:variable name="INDENT_STRING_QUD" select="'- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -'"/>
	<!-- Main -->
	<xsl:template match="/">
		<xsl:value-of select="'Where'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'What'"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="'-'"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:for-each select="//Object[descendant::Script|descendant::Step]|//Script|//Step">
			<xsl:choose>
				<xsl:when test="name()='Object'">
					
					<xsl:call-template name="fn.GetAbsBoundsOfCurrentNodeAsNumber"/>
					<xsl:value-of select="$delimiter"/>
					<xsl:value-of select="substring($INDENT_STRING_QUD,1,2*count(ancestor::Object))"/>
					<xsl:call-template name="getDescriptionOfCurrentNode"/>
					<xsl:value-of select="$newrecord"/>
				</xsl:when>
				<xsl:when test="ancestor::Trigger/@event">
					<xsl:value-of select="$arrow_right"/>
					<xsl:value-of select="'TRIGGER '"/>
					<xsl:value-of select="ancestor::Trigger/@event"/>
					<xsl:value-of select="$delimiter"/>
					<!-- print script/step -->
					<xsl:value-of select="$arrow_right"/>
					<xsl:apply-templates select="."/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$arrow_right"/>
					<xsl:value-of select="'ACTION '"/>
					<xsl:value-of select="name()"/>
					<xsl:value-of select="' '"/>
					<xsl:value-of select="$delimiter"/>
					<!-- print script/step -->
					<xsl:value-of select="$arrow_right"/>
					<xsl:apply-templates select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
