<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_Text.Lines_PrintWithLineNumbers.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps

	Lists script steps in text form similar to FileMaker ScriptMaker.
	
	WARNING: ALPHA-VERSION STILL IN DEVELOPMENT!

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2016-03-12 MrW: Renamed simply Print, as indented is the default expectation
	2016-02-15 MrW: Renamed with "Print ..." to group print functions together
	2013-12-09 MrW: Version 1.2 Added missing Parameters
	2013-09-05 MrW: XSLT refactored out into three levels:
	                1. XMSS_Text.Lines_ListIndented.xsl, this file, includes
	                2. _inc/inc.XMSS_Text_PrintIndented.xsl, includes
	                3. _inc/inc.XMSS_Text_PrintSteps.xsl
	      :
	2011-15-02 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XMSS_Text.Lines_Listindented.xsl"/>
	<!-- ===== PARAMETERS ===== -->
	<!-- Line numbering and indentation -->
	<xsl:param name="pShowLineNumbers" select="'True'"/>
	<xsl:param name="pLineNumbers" select="'False'"/>
	<!--  -->
	<xsl:param name="pIndentGroups" select="'False'"/>
	<xsl:param name="pIndentScripts" select="'False'"/>
	<xsl:param name="pIndentScriptSteps" select="'True'"/>
	<xsl:param name="pIndentString" select="'    '"/>
	<xsl:param name="pIndentLevel" select="0"/>
	
	<!--  -->
	<xsl:param name="pScriptGroupPathDelimiter" select="' &gt; '"/>
	<xsl:param name="pScriptGroupNamePrefix" select="concat('Group  ',$QUOT)"/>
	<xsl:param name="pScriptGroupNameSuffix" select="$QUOT"/>
	<!--  -->
	<xsl:param name="pScriptNamePrefix" select="concat('Script ',$QUOT)"/>
	<xsl:param name="pScriptNameSuffix" select="$QUOT"/>
	<!--  -->
	<xsl:param name="pShowScriptIDs" select="'True'"/>
	<xsl:param name="pScriptIDPrefix" select="' {'"/>
	<xsl:param name="pScriptIDSuffix" select="'}'"/>
</xsl:stylesheet>
