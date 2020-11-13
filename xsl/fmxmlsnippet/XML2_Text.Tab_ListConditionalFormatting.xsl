<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XML2_Text.Tab_ListConditionalFormatting.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	Lists all Objects and their Conditional Formatting calculations
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2019-09-07 MrW: Version 1.0 Improved output to show Bounds correctly and added column headers; Standardised the file name (List…) and improved comments
	2011-09-30 MrW: inc/constants.xsl
	2011-08-10 MrW: Version 0.9
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.GetAbsoluteBounds.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.Substitute.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/">
		<xsl:value-of select="'Type'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Name'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Bounds'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Calc'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'CSS'"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="'-'"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:for-each select="//Object/ConditionalFormatting/Item/Condition/Calculation">
			<xsl:for-each select="ancestor::Object[1]">
				<xsl:value-of select="@type"/>
				<xsl:value-of select="$delimiter"/>
				<xsl:if test="@name">
				<xsl:value-of select="$QUOT"/>
				<xsl:value-of select="@name"/>
				<xsl:value-of select="$QUOT"/>
				</xsl:if>
				<xsl:if test="FieldObj/Name">
					<xsl:value-of select="' '"/>
					<xsl:value-of select="FieldObj/Name"/>
				</xsl:if>
				<xsl:value-of select="$delimiter"/>
				<xsl:call-template name="fn.GetAbsBoundsOfCurrentNodeAsNumber"/>
				<xsl:value-of select="$delimiter"/>
			</xsl:for-each>
			<xsl:value-of select="translate(.,$CRLF,'  ')"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:value-of select="translate(ancestor::Item/Format/Styles/LocalCSS,concat($CRLF,$TAB),'   ')"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:for-each>
	</xsl:template>

	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
