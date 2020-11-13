<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" version="1.0" exclude-result-prefixes="exsl">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMTH_Text.Lines_ListThemeForDiff.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: one or more FileMaker Themes
	
	Lists the details of the FileMaker Theme (so that Themes can be compared between files).
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2015-04-17 MrW: Version 1.0.1 Added missing return
	2014-05-29 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.cssText.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="': '"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<xsl:variable name="indent" select="$TAB"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/fmxmlsnippet/Theme">
		<xsl:value-of select="concat('Theme ',$QUOT,@name,$QUOT,':',$newrecord)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="concat('Id',$delimiter,@id,$newrecord)"/>
		<xsl:value-of select="concat('InternalName',$delimiter,@internalName,$newrecord)"/>
		<xsl:value-of select="concat('Platform',$delimiter,@platform,$newrecord)"/>
		<xsl:value-of select="concat('Group',$delimiter,@group,$newrecord)"/>
		<xsl:value-of select="concat('Locale',$delimiter,@locale,$newrecord)"/>
		<xsl:value-of select="concat('Type',$delimiter,@type,$newrecord)"/>
		<xsl:value-of select="concat('Version',$delimiter,@version,$newrecord)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:apply-templates select="metadata"/>
		<xsl:apply-templates select="CSS"/>
		<xsl:value-of select="concat('END Theme ',$QUOT,@name,$QUOT,$newrecord)"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- metadata -->
	<xsl:template match="metadata">
		<xsl:apply-templates select="*"/>
	</xsl:template>
	<!-- layoutbilder -->
	<xsl:template match="layoutbuilder">
		<xsl:value-of select="concat('Layout metrics:',$newrecord)"/>
		<xsl:value-of select="$newrecord"/>
		<!-- -->
		<xsl:value-of select="concat('Base Font Size',$delimiter,kBaseFontSize,$newrecord)"/>
		<xsl:value-of select="concat('Vertical Field Spacing',$delimiter,kVerticalFieldSpacing,$newrecord)"/>
		<!-- -->
		<xsl:value-of select="concat('Background Padding Top',$delimiter,kBackgroundPaddingTop,$newrecord)"/>
		<xsl:value-of select="concat('Background Padding Left',$delimiter,kBackgroundPaddingLeft,$newrecord)"/>
		<xsl:value-of select="concat('Background Padding Bottom',$delimiter,kBackgroundPaddingBottom,$newrecord)"/>
		<xsl:value-of select="concat('Background Padding Right',$delimiter,kBackgroundPaddingRight,$newrecord)"/>
		<!-- -->
		<xsl:value-of select="concat('Top Nav Part Min Size',$delimiter,kTopNavPartMinSize,$newrecord)"/>
		<!-- -->
		<xsl:value-of select="concat('Part Padding Left',$delimiter,kPartPaddingLeft,$newrecord)"/>
		<xsl:value-of select="concat('Part Padding Right',$delimiter,kPartPaddingRight,$newrecord)"/>
		<!-- -->
		<xsl:value-of select="concat('First Part Padding Top',$delimiter,kFirstPartPaddingTop,$newrecord)"/>
		<xsl:value-of select="concat('Last Part Padding Bottom',$delimiter,kLastPartPaddingBottom,$newrecord)"/>
		<!-- -->
		<xsl:value-of select="concat('Title Header Min Size',$delimiter,kTitleHeaderMinSize,$newrecord)"/>
		<!-- -->
		<xsl:value-of select="concat('Header Min Size',$delimiter,kHeaderMinSize,$newrecord)"/>
		<!-- -->
		<xsl:value-of select="concat('Leading Part Padding Top',$delimiter,kLeadingPartPaddingTop,$newrecord)"/>
		<xsl:value-of select="concat('Leading Part Padding Bottom',$delimiter,kLeadingPartPaddingBottom,$newrecord)"/>
		<!-- -->
		<xsl:value-of select="concat('Report Break Field Indent',$delimiter,kReportBreakFieldIndent,$newrecord)"/>
		<xsl:value-of select="concat('Summary Part Min Size',$delimiter,kSummaryPartMinSize,$newrecord)"/>
		<!-- -->
		<xsl:value-of select="concat('Body Part Padding Top',$delimiter,kBodyPartPaddingTop,$newrecord)"/>
		<xsl:value-of select="concat('Body Part Padding Bottom',$delimiter,kBodyPartPaddingBottom,$newrecord)"/>
		<xsl:value-of select="concat('Body Min Size',$delimiter,kBodyMinSize,$newrecord)"/>
		<!-- -->
		<xsl:value-of select="concat('Trailing Part Padding Top',$delimiter,kTrailingPartPaddingTop,$newrecord)"/>
		<xsl:value-of select="concat('Trailing Part Padding Bottom',$delimiter,kTrailingPartPaddingBottom,$newrecord)"/>
		<!-- -->
		<xsl:value-of select="concat('Footer Min Size',$delimiter,kFooterMinSize,$newrecord)"/>
		<!-- -->
		<xsl:value-of select="concat('Title Footer Min Size',$delimiter,kTitleFooterMinSize,$newrecord)"/>
		<!-- -->
		<xsl:value-of select="concat('Bottom Nav Part Min Size',$delimiter,kBottomNavPartMinSize,$newrecord)"/>
		<!-- -->
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
			<xsl:value-of select="name()"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:value-of select="text()"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:for-each>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- charting -->
	<xsl:template match="charting">
		<xsl:value-of select="concat('Charting:',$newrecord)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="concat('Colorscheme',$delimiter,colorScheme,$newrecord)"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- colorpalette -->
	<xsl:template match="colorpalette">
		<xsl:value-of select="concat('Color palettes:',$newrecord)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:for-each select="*">
			<xsl:value-of select="concat(name(),': ',.,$newrecord)"/>
		</xsl:for-each>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- CSS -->
	<xsl:template match="CSS">
		<xsl:value-of select="concat('CSS:',$newrecord)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:call-template name="fn.cssText.forDiff">
			<xsl:with-param name="css" select="text()"/>
		</xsl:call-template>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<xsl:template name="fn.cssText.forDiff">
		<!-- Params -->
		<xsl:param name="css"/>
		<!-- -->
		<!-- Markup the css and convert the Result Tree Fragment to 'real' XML node-set -->
		<xsl:variable name="css_Rules_RTF">
			<xsl:call-template name="fn.cssText.markup.CSS-Rules">
				<xsl:with-param name="css" select="$css"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="css_Rules" select="exsl:node-set($css_Rules_RTF)/CSS-Rules"/>
		<!-- -->
		<xsl:for-each select="$css_Rules/CSS-Rule">
			<xsl:sort select="CSS-Selector"/>
			<!-- -->
			<xsl:variable name="selector" select="CSS-Selector"/>
			<!-- -->
			<xsl:for-each select="CSS-DeclarationBlock/CSS-Declaration">
				<xsl:sort select="CSS-Property"/>
				<!-- -->
				<xsl:value-of select="$selector"/>
				<xsl:value-of select="' { '"/>
				<xsl:value-of select="CSS-Property"/>
				<xsl:value-of select="': '"/>
				<xsl:value-of select="CSS-Value"/>
				<xsl:value-of select="' }'"/>
				<xsl:value-of select="$newrecord"/>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
