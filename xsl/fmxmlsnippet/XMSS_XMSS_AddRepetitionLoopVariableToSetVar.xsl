<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" exclude-result-prefixes="exsl" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2018 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_AddRepetitionLoopVariableToSetVar.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Adds a [repetition] to Set Var (target) and Set Field / Set Field By Name / Replace Field Contents (expression)
	
	Changes 
		Set Variable [ $var ; … ]
		Set Field [ … ; $var ]
		Set Field By Name [ … ; $var ]
		Set Field By Name [ … ; $var ]
	into
		Set Variable[ $var[repetition] ; … ]
		Set Field [ … ; $var[repetition] ]
	
	Default is
	
		Set Variable[ $var[$i] ; … ]
		Set Field [ … ; $var[$i] ]
	
	For Example
		Set Variable [ $Data ; Value: MyTable::MyField ] 
		Set Field [ MyTable::MyField ; $Data ] 
		Set Field By Name [ "whatever" ; MyTable::MyField ] 
		Replace Field Contents [ With dialog: On ; MyTable::MyField ; MyTable::MyField ] 
	becomes
		Set Variable [ $Data[$i] ; Value: MyTable::MyField ] 
		Set Field [ MyTable::MyField ; $Data[$i] ] 
		Set Field By Name [ "whatever" ; MyTable::MyField[$i] ] 
		Replace Field Contents [ With dialog: On ; MyTable::MyField ; MyTable::MyField[$i] ] 
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2018
	2018-02-28 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== PARAMETER ===== -->
	<xsl:param name="repetition" select="'$i'"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Set Variable: set repetition -->
	<xsl:template match="Step[@id='141']/Repetition/Calculation/text()">
		<xsl:value-of select="$repetition"/>
	</xsl:template>
	<!-- Set Field / Set Field By Name / Replace Field Contents: Insert [repetition] at end of calculation -->
	<xsl:template match="Step[@id='76']/Calculation/text()|Step[@id='147']/Result/Calculation/text()|Step[@id='91' and With/@value='Calculation']/Calculation/text()">
		<xsl:value-of select="concat(.,'[',$repetition,']')"/>
	</xsl:template>
</xsl:stylesheet>
