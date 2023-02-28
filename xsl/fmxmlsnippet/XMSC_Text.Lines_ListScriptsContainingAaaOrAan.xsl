<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2022 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSC_Text.Lines_ListScriptsContainingAaaOrAan.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts
	
	Returns list of scripts containing AAA/AAN
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2022
	2022-11-30 MrW: Version 0.1
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!--xsl:variable name="pSearchText" select="'2013-06-26 RW: '"/-->
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- List all Scripts containing AAA/AAN  -->
	<xsl:template match="/">
		<xsl:for-each select="//Script[not(ancestor::Step) and (contains(.,'AAA') or contains(.,'AAN') or .//@name[contains(.,'AAA') or contains(.,'AAN')] )]">
			<!-- [contains(.,'AAA') or contains(.,'AAN')] or contains(@name,'AAA') or contains(@name,'AAN') -->
			<xsl:value-of select="@name"/>
			<xsl:value-of select="$newrecord"/>
			<xsl:for-each select="descendant::Step[not(ancestor::Step) and (contains(.,'AAA') or contains(.,'AAN') or .//@name[contains(.,'AAA') or contains(.,'AAN')] )]">
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="position()"/>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="@name"/>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="descendant::*/text()[contains(.,'AAA') or contains(.,'AAN')]"/>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="descendant::*/@name[contains(.,'AAA') or contains(.,'AAN')]"/>
				<xsl:value-of select="$newrecord"/>
			</xsl:for-each>
			
			<xsl:value-of select="$newrecord"/>
		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
