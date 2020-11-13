<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_Text.Lines_ListVariableNames.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or scriptsteps
	
	Returns a list of names of all set variables.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2014-07-14 MrW: At last!
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Script step 141. Set Variable -->
	<xsl:template match="Step[@id='141' and @enable='True']">
		<xsl:value-of select="Name"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
	
</xsl:stylesheet>
