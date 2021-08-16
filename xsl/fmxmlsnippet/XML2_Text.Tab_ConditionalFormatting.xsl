<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XML2_Text.Tab_ConditionalFormatting.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	Returns all LayoutFields that have editable value lists
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2011-2016
	2011-09-30 MrW: inc/constants.xsl
	2011-08-10 MrW: Version 0.9
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.GetAbsoluteBounds.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.Substitute.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="'&lt;/td&gt;&lt;td&gt;'"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/">
		<xsl:for-each select="//Object/ConditionalFormatting/Item/Condition/Calculation">
			<xsl:value-of select="concat(
				ancestor::Object/@type,$TAB,
				ancestor::Object/FieldObj/Name,$TAB,
				ancestor::Object/Bounds,$TAB,
				translate(ancestor::Item/Format/Styles/LocalCSS,concat($CRLF,$TAB),'   '),$TAB,
				translate(.,$CRLF,'  '))"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:for-each>
	</xsl:template>

	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
