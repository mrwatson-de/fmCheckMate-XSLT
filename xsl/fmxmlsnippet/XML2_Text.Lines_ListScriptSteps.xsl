<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XML2_Text.Lines_ListScriptSteps.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	Lists the script steps
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2011-2016
	2013-11-19 MrW: Umbenannt für XML2
	2011-09-30 MrW: inc/constants.xsl
	2011-08-10 MrW: Version 0.9
	-->
	<!-- ===== HEAD ===== -->
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XMSS_Text_PrintSteps.xsl"/>
	<!--xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XMSS_Text.Lines_Listindented.xsl"/-->
	<!-- ===== PARAMETERS ===== -->
	<!-- Line numbering and indentation -->
	<xsl:param name="pShowLineNumbers" select="'False'"/>
	<xsl:param name="pLineNumbers" select="'False'"/>
	<!--  -->
	<xsl:param name="pIndentGroups" select="'False'"/>
	<xsl:param name="pIndentScripts" select="'False'"/>
	<xsl:param name="pIndentScriptSteps" select="'False'"/>
	<xsl:param name="pIndentString" select="'    '"/>
	<xsl:param name="pIndentLevel" select="0"/>
	
	<!--  -->
	<xsl:param name="pScriptGroupPathDelimiter" select="' &gt; '"/>
	<xsl:param name="pScriptGroupNamePrefix" select="concat('Group  ',$QUOT)"/>
	<xsl:param name="pScriptGroupNameSuffix" select="$QUOT"/>
	<!--  -->
	<xsl:param name="pScriptNamePrefix" select="concat('Perform Script ',$QUOT)"/>
	<xsl:param name="pScriptNameSuffix" select="$QUOT"/>
	<!--  -->
	<xsl:param name="pShowScriptIDs" select="'False'"/>
	<xsl:param name="pScriptIDPrefix" select="' {'"/>
	<xsl:param name="pScriptIDSuffix" select="'}'"/>
</xsl:stylesheet>
