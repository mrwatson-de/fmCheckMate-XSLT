<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSS_Text_Print.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps

	Lists script steps in text form similar to FileMaker ScriptMaker.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2011-2016
	2016-03-12 MrW: Renamed simply Print, as indented is the default expectation
	2016-02-15 MrW: Renamed with "Print ..." to group print functions together
	2013-09-05 MrW: XSLT refactored out into three levels:
	                1. XMSS_Text.Lines_ListIndented.xsl, this file, includes
	                2. _inc/inc.XMSS_Text_PrintIndented.xsl, includes
	                3. _inc/inc.XMSS_Text_PrintSteps.xsl
	      :
	2011-15-02 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XMSS_Text_PrintIndented.xsl"/>
	<!-- ===== PARAMETERS ===== -->
	<!-- 
	 ! Delimiters
	 !
	 ! delimiter    = THIS DELIMITER IS UNUSED
	 ! delimiter1   = Start of the parameter list
	 ! delimiter2   = Delimiter between names and values
	 ! delimiter3   = Delimiter between parameter list items
	 ! delimiter4   = End of the parameter list
	 ! newrecord    = End of line character(s)
	 !
	 ! pIndentString = The text to use for each indent level (""=none)
	 ! pIndentLevel  = The basis indent level
	 !-->
	<!--xsl:param name="delimiter" select="$TAB"/-->
	<xsl:param name="delimiter1" select="' [ '"/>
	<xsl:param name="delimiter2" select="': '"/>
	<xsl:param name="delimiter3" select="concat(' ]',$RETURN,$TAB,$TAB,'[ ')"/>
	<xsl:param name="delimiter4" select="' ]'"/>
	<xsl:param name="delimiter14" select="' []'"/>
	<xsl:param name="newrecord" select="$RETURN"/>
	<!--
	 ! Indentation
	 !-->
	<xsl:param name="pIndentString" select="$TAB"/>
	<xsl:param name="pIndentLevel" select="0"/>
	<xsl:param name="pIndentGroups" select="'False'"/>
	<xsl:param name="pIndentScripts" select="'False'"/>
	<xsl:param name="pIndentScriptSteps" select="'True'"/>
	<!--
	 ! Line numbering
	 !-->
	<xsl:param name="pShowLineNumbers" select="'False'"/>
	<xsl:param name="pLineNumbers" select="'False'"/>
	<!--
	 ! Script Groups
	 !-->
	<xsl:param name="pScriptGroupPathDelimiter" select="' &gt; '"/>
	<xsl:param name="pScriptGroupNamePrefix" select="concat('GROUP','  ',$QUOT)"/>
	<xsl:param name="pScriptGroupNameSuffix" select="$QUOT"/>
	<!--
	 ! Scripts
	 !-->
	<xsl:param name="pScriptNamePrefix" select="concat('SCRIPT',' ',$QUOT)"/>
	<xsl:param name="pScriptNameSuffix" select="$QUOT"/>
	<xsl:param name="pShowScriptIDs" select="'False'"/>
	<xsl:param name="pScriptIDPrefix" select="' {'"/>
	<xsl:param name="pScriptIDSuffix" select="'}'"/>
	<!--
	 ! Steps
	 !-->
	<xsl:param name="pScriptStepHidePasswords" select="'True'"/>
	<!--
	 ! Rendering Options
	 !-->
	<xsl:param name="pVerbose" select="'False'"/>
	<!-- SIC = render exactly as the Script Workspace -->
	<xsl:param name="pSIC" select="'True'"/>
</xsl:stylesheet>
