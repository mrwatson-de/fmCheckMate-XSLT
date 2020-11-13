<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XML2_XML2_ApplyConditionalFormatting.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	Applies the frontmost objects Conditional Formatting to all other objects
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2019-02-16 MrW: Version 0.1
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="CondForm" select="//ConditionalFormatting[last()]"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/Object[@type!='ButtonBar' and @type!='GroupButton' and @type!='Portal']">
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
