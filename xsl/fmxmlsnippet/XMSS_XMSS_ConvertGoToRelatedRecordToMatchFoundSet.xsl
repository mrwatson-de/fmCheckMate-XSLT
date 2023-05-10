<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2023 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_ConvertGoToRelatedRecordToMatchFoundSet.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Converts
	
	  Go to Related Record [ From table: “tScriptStep” ; Using layout: “tScriptStep _Det” (tScriptStep) ; New window ] 
	  Go to Related Record [ Show only related records ; From table: “tScriptStep” ; Using layout: “tScriptStep _Det” (tScriptStep) ; New window ] 

	into
	
	  Go to Related Record [ Show only related records ; Match found set ; From table: “tScriptStep” ; Using layout: “tScriptStep _Det” (tScriptStep) ; New window ] 
	  Go to Related Record [ Show only related records ; Match found set ; From table: “tScriptStep” ; Using layout: “tScriptStep _Det” (tScriptStep) ; New window ] 

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2023
	2023-05-05 MrW: New
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!--
	 ! Convert Go to Related Record [ … ] to Go to Related Record [ Show only related records ; Match found set ; …]
	 !-->
	<xsl:template match="Step[@id='74']/Restore[@state='False']">
		<Restore state="True"/>
	</xsl:template>
	<xsl:template match="Step[@id='74']/MatchAllRecords[@state='False']">
		<MatchAllRecords state="True"/>
	</xsl:template>
</xsl:stylesheet>
