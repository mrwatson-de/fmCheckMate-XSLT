<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMAA_Text.Stats_AnalyseTextOfRawXml.xsl

	XML-Source: any.xml
	XML-Grammar: any
	XML-Content: any

	Clones the xml - which is displayed in the text statistics view of fmCheckMate
	(due to the output type Text.Stats)

	===== CHANGES HISTORY =====
		2017-10-25 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!--
	 ! Since we are ONLY cloning the source xml we need no templates here.
	 ! All the necessary templates are in the inc.Clone.xsl include file
	 !-->
</xsl:stylesheet>