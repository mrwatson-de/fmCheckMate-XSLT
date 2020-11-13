<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XML2_XML2_ReplicateButtonbarButton1.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied fmp12 layout objects
	
	Replicates button 1 (text, step et al) throughout a button bar

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2018-10-25 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"
		cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Match any button in a buttonbar - except the first-->
	<xsl:template match="ButtonBarObj/Object[position() &gt; 1]">
		<!-- And replace it with a replica of button 1 -->
		<xsl:copy-of select="../Object[1]"/>
	</xsl:template>
</xsl:stylesheet>
