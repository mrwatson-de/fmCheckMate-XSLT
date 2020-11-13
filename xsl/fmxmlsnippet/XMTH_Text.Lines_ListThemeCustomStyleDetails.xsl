<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" version="1.0" exclude-result-prefixes="exsl">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMTH_Text.Lines_ListThemeCustomStyleDetails.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: one or more FileMaker Themes
	
	Lists the details of the FileMaker Theme and custom styles (for a human to read).
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2016-10-04 MrW: Version 1.1 - output styles only sorted
	2014-05-29 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.cssText.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="concat(': ',$TAB)"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<xsl:variable name="indent" select="$TAB"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/fmxmlsnippet/Theme">
		<xsl:value-of select="concat('Theme ',$QUOT,@name,$QUOT)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="concat($indent,'Id',$delimiter,@id)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="concat($indent,'InternalName',$delimiter,@internalName)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="concat($indent,'Platform',$delimiter,@platform)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="concat($indent,'Group',$delimiter,@group)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="concat($indent,'Locale',$delimiter,@locale)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="concat($indent,'Type',$delimiter,@type)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="concat($indent,'Version',$delimiter,@version)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:apply-templates select="metadata"/>
		<xsl:apply-templates select="CSS"/>
		<xsl:value-of select="concat('END Theme ',$QUOT,@name,$QUOT)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- metadata -->
	<xsl:template match="metadata">
		<xsl:apply-templates select="*"/>
	</xsl:template>
	<!-- layoutbilder -->
	<xsl:template match="layoutbuilder">
		<xsl:value-of select="'Layout metrics'"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="$newrecord"/>
		<!-- -->
		<xsl:value-of select="concat($indent,'Base Font Size',$delimiter,kBaseFontSize)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="concat($indent,'Vertical Field Spacing',$delimiter,kVerticalFieldSpacing)"/>
		<xsl:value-of select="$newrecord"/>
		<!-- -->
		<xsl:value-of select="concat($indent,'Part Padding Left',$delimiter,kPartPaddingLeft)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="concat($indent,'Part Padding Right',$delimiter,kPartPaddingRight)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="$newrecord"/>
		<!-- -->
		<xsl:value-of select="concat($indent,'First Part Padding Top',$delimiter,kFirstPartPaddingTop)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="concat($indent,'Last Part Padding Bottom',$delimiter,kLastPartPaddingBottom)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="$newrecord"/>
		<!-- -->
		<xsl:value-of select="concat($indent,'Title Header Min Size',$delimiter,kTitleHeaderMinSize)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="$newrecord"/>
		<!-- -->
		<xsl:value-of select="concat($indent,'Header Min Size',$delimiter,kHeaderMinSize)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="$newrecord"/>
		<!-- -->
		<xsl:value-of select="concat($indent,'Leading Part Padding Top',$delimiter,kLeadingPartPaddingTop)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="concat($indent,'Leading Part Padding Bottom',$delimiter,kLeadingPartPaddingBottom)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="$newrecord"/>
		<!-- -->
		<xsl:value-of select="concat($indent,'Report Break Field Indent',$delimiter,kReportBreakFieldIndent)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="concat($indent,'Summary Part Min Size',$delimiter,kSummaryPartMinSize)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="$newrecord"/>
		<!-- -->
		<xsl:value-of select="concat($indent,'Body Part Padding Top',$delimiter,kBodyPartPaddingTop)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="concat($indent,'Body Part Padding Bottom',$delimiter,kBodyPartPaddingBottom)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="concat($indent,'Body Min Size',$delimiter,kBodyMinSize)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="$newrecord"/>
		<!-- -->
		<xsl:value-of select="concat($indent,'Trailing Part Padding Top',$delimiter,kTrailingPartPaddingTop)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="concat($indent,'Trailing Part Padding Bottom',$delimiter,kTrailingPartPaddingBottom)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="$newrecord"/>
		<!-- -->
		<xsl:value-of select="concat($indent,'Footer Min Size',$delimiter,kFooterMinSize)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="$newrecord"/>
		<!-- -->
		<xsl:value-of select="concat($indent,'Title Footer Min Size',$delimiter,kTitleFooterMinSize)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- charting -->
	<xsl:template match="charting">
		<xsl:value-of select="'Charting'"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="concat($indent,'Colorscheme',$delimiter,colorScheme)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- namedstyles -->
	<xsl:template match="namedstyles">
		<xsl:value-of select="concat('Named styles:',$newrecord)"/>
		<xsl:value-of select="$newrecord"/>
		<!-- -->
		<!-- List styles alphabetically-->
		<xsl:for-each select="*">
			<xsl:sort select="name()"/>
			<xsl:value-of select="concat($indent,name(),$delimiter,text(),$newrecord)"/>
		</xsl:for-each>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- CSS -->
	<xsl:template match="CSS">
		<xsl:value-of select="'CSS - marked up and sorted:'"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:call-template name="fn.cssText.sort">
			<xsl:with-param name="css" select="text()"/>
			<xsl:with-param name="filterRulesContaining" select="'FM-'">
				
			</xsl:with-param>
			
		</xsl:call-template>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!--  -->
	<xsl:template match="Rule" mode="css">
		<xsl:value-of select="Name"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="Value"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
