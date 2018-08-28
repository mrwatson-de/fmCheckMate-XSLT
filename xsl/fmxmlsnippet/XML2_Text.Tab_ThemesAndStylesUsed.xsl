<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" extension-element-prefixes="exsl" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XML2_Text.Tab_ThemesAndStylesUsed.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: fmp12 layout objects
	
	Lists the themes and styles that are used by the layout objects.
	
	Note:
	This XSLT uses the "instant DDR" themes fmxmlsnippet file stored in ~Documents/fmCheckMate/temp/iDDR/XMTH_fmxmlsnippet.xml
	Before you can use this XSLT you must:
	- Copy all custom themes of the current file
	- Convert them to an fmxmlsnippet
	- Save the file to the given path.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2017
	2017-10-27 MrW: Version 1.0.2 iDDR folder moved from xml/ to temp/ folder
	2015-09-12 MrW: Version 1.0.1 iddr renamed to iDDR 
	2015-04-29 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== EXTERNAL DOCUMENTS ===== -->
	<xsl:variable name="iDDR.XMTH" select="document('../../../fmCheckMate/temp/iDDR/XMTH_fmxmlsnippet.xml')"/>
	<!-- ===== TEMPLATES ===== -->
	<!--  -->
	<xsl:template match="/">
		<xsl:if test="not($iDDR.XMTH)">
			<!--" or not(document('../../../fmCheckMate/temp/iDDR/XMTH_fmxmlsnippet.xml')//Theme[@internalName=//ThemeName]/@name)"-->
			<!-- Error -->
			<xsl:value-of select="concat('Warning:',$delimiter,'in order to lookup theme and style names, you need to copy and save your theme fmlxmlsnippet to ~/Documents/fmCheckMate/temp/iDDR/XMTH_fmxmlsnippet.xml')"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:if>
		<!-- -->
		<!-- Output column headings -->
		<xsl:value-of select="'Type'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Visible Name'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Internal UUID'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Occurs'"/>
		<xsl:value-of select="$newrecord"/>
		<!-- '-' indicates the first row is a heading row -->
		<xsl:value-of select="'-'"/>
		<xsl:value-of select="$newrecord"/>
		<!-- Output tabulated data -->
		<xsl:for-each select="//ThemeName[not(preceding::ThemeName=.)]">
			<xsl:sort select="."/>
			<xsl:variable name="ThemeGUID" select="."/>
			<!-- -->
			<xsl:value-of select="'Theme'"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:value-of select="document('../../../fmCheckMate/temp/iDDR/XMTH_fmxmlsnippet.xml')//Theme[@internalName=$ThemeGUID]/@name"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:value-of select="$ThemeGUID"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:value-of select="1"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:for-each>
		<xsl:for-each select="(//Styles[not(CustomStyles)])[1]">
			<xsl:value-of select="'Style'"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:value-of select="'[Default]'"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:value-of select="'-'"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:value-of select="count(//Styles[not(CustomStyles)])"/>
			<xsl:value-of select="$newrecord"/>
</xsl:for-each>			
		<xsl:for-each select="//Styles/CustomStyles/Name[not(preceding::CustomStyles/Name=.)]">
			<xsl:sort select="document('../../../fmCheckMate/temp/iDDR/XMTH_fmxmlsnippet.xml')//*[name()=current()/text()]/text()"/>
			<xsl:variable name="styleGUID" select="text()"/>
			<xsl:variable name="styleName" select="document('../../../fmCheckMate/temp/iDDR/XMTH_fmxmlsnippet.xml')//*[name()=$styleGUID]/text()"/>
			<!-- -->
			<xsl:value-of select="'Style'"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:value-of select="$styleName"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:value-of select="$styleGUID"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:value-of select="count(//Styles/CustomStyles/Name[text()=$styleGUID])"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
