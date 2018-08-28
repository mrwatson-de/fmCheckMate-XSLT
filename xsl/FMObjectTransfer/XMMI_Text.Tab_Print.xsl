<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2018 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMMI_Text.Tab_Print.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: FMObjectTransfer
	XML-Content: copied Custom Menus

	Lists custom menu sets, cudstom menus, their menu items and their command steps.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2018
	2018-06-14 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:include href="../../../fmCheckMate/xsl/fmxmlsnippet/XMSS_Text.Lines_Print.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_fn.toString.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="indent" select="'&#160;&#160;&#160;&#160;'"/>
	<xsl:variable name="indent2" select="concat($indent, $indent)"/>
	<xsl:variable name="indent3" select="concat($indent, $indent2)"/>
	<xsl:variable name="arrow_right" select="'→ '"/>
	<xsl:variable name="INDENT_STRING_QUD"
		select="'- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -'"/>
	<!-- Main -->
	<xsl:template match="/">
		<xsl:value-of select="'Install'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Custom…'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Name'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Shortcut'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Details'"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="'-'"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:apply-templates select="*[not(self::Step)]"/>
	</xsl:template>
	<xsl:template match="CustomMenuSet">
		<xsl:value-of select="''"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Menu Set'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="@name"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="''"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:for-each select="CustomMenuList/CustomMenuReference">
			<xsl:if test="position() != 1">
				<xsl:value-of select="', '"/>
			</xsl:if>
			<xsl:value-of select="@name"/>
		</xsl:for-each>
		<xsl:value-of select="$newrecord"/>
		<xsl:apply-templates select="*[not(self::Step)]"/>
	</xsl:template>
	<xsl:template match="CustomMenu">
		<!-- Install Calc, if any -->
		<xsl:call-template name="InstallOptions"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="$indent"/>
		<xsl:value-of select="'Menu'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="$indent"/>
		<xsl:value-of select="@name"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:apply-templates select="*[not(self::Step)]"/>

	</xsl:template>
	<xsl:template match="CustomMenuItem[@isSeparatorItem = 'True']">
		<!-- Install Calc, if any -->
		<xsl:call-template name="InstallOptions"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="$indent2"/>
		<xsl:value-of select="'Separator'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="$indent2"/>
		<xsl:value-of select="'-'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:apply-templates select="*[not(self::Step)]"/>
	</xsl:template>
	<xsl:template match="CustomMenuItem[@isSubMenuItem = 'True']">
		<!-- Install Calc, if any -->
		<xsl:call-template name="InstallOptions"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="$indent2"/>
		<xsl:value-of select="'Submenu'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="$indent2"/>
		<xsl:value-of select="CustomMenuReference/@name"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:apply-templates select="*[not(self::Step)]"/>
	</xsl:template>
	<xsl:template match="CustomMenuItem">
		<!-- Install Calc, if any -->
		<xsl:call-template name="InstallOptions"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="$indent2"/>
		<xsl:value-of select="'Item'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="$indent2"/>
		<xsl:value-of select="translate(Command/@name, concat($TAB, $CRLF), '   ')"/>
		<xsl:if test="Name/Calculation/text()">
			<xsl:value-of select="' = '"/>
		<xsl:value-of select="translate(Name/Calculation/text(), concat($TAB, $CRLF), '   ')"/>
		</xsl:if>
		<xsl:value-of select="$delimiter"/>
		<xsl:for-each select="Shortcut">
			<xsl:call-template name="Shortcut"/>
		</xsl:for-each>
		<xsl:value-of select="$delimiter"/>
		<xsl:variable name="Step">
			<xsl:apply-templates select="Step"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$Step!=''">
				<xsl:value-of select="$Step"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$newrecord"/>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:apply-templates select="*[not(self::Step)]"/>
	</xsl:template>
	<!-- 
	 ! NAMED TEMPLATES
	 !-->
	<!-- InstallOptions -->
	<xsl:template name="InstallOptions">

		<xsl:if test="Options/@browseMode = 'True'">
			<xsl:value-of select="'browse '"/>
		</xsl:if>
		<xsl:if test="Options/@findMode = 'True'">
			<xsl:value-of select="'find '"/>
		</xsl:if>
		<xsl:if test="Options/@previewMode = 'True'">
			<xsl:value-of select="'preview '"/>
		</xsl:if>
		<xsl:variable name="installCalc" select="Conditions/Install/Calculation"/>
		<xsl:variable name="winCalc">
			<xsl:text>If( Abs(Get( SystemPlatform )) = 2; 1; 0 )</xsl:text>
		</xsl:variable>
		<xsl:variable name="macCalc">
			<xsl:text>If( Abs(Get( SystemPlatform )) &lt;> 2; 1; 0 )</xsl:text>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$installCalc = 1">
				<xsl:value-of select="'always'"/>
			</xsl:when>
			<xsl:when test="$installCalc = 0">
				<xsl:value-of select="'disabled'"/>
			</xsl:when>
			<xsl:when test="$installCalc = $macCalc">
				<xsl:value-of select="'on Mac'"/>
			</xsl:when>
			<xsl:when test="$installCalc = $winCalc">
				<xsl:value-of select="'on Windows'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="translate($installCalc, concat($TAB, $CRLF), '   ')"/>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<!-- OverrideName -->
	<xsl:template name="OverrideName">
		<xsl:if test="Options/Override/name/Calculation/text()">
			<xsl:value-of
				select="translate(Options/Override/name/Calculation/text(), concat($TAB, $CRLF), '   ')"
			/>
		</xsl:if>
	</xsl:template>

	<xsl:template name="Shortcut">
		<xsl:variable name="key" select="number(@key)"/>
		<xsl:variable name="modifier" select="number(@modifier)"/>
		<xsl:if test="($modifier div 4) mod 2 &gt;= 1">
			<xsl:value-of select="'CMD+'"/>
		</xsl:if>
		<xsl:if test="($modifier div 2) mod 2 &gt;= 1">
			<xsl:value-of select="'ALT+'"/>
		</xsl:if>
		<xsl:if test="($modifier div 1) mod 2 &gt;= 1">
			<xsl:value-of select="'SHIFT+'"/>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="$key &gt;= 48 and $key &lt; 127">
				<xsl:value-of
					select="substring('0123456789:;_=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz', @key - 48 + 1, 1)"
				/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'Char('"/>
				<xsl:value-of select="$key"/>
				<xsl:value-of select="')'"/>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

</xsl:stylesheet>
