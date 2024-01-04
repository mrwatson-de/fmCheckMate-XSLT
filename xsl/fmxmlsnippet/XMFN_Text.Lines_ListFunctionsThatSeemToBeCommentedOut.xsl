<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMFN_Text.Lines_ListFunctionsThatSeemToBeCommentedOut.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied Custom Function definitions
	
	Lists all Custom Function that appear to have been commented out.
	
	===== CHANGES HISTORY =====
	2013-09-10 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- All CustomFunctions -->
	<xsl:template match="//CustomFunction[not(ancestor::CustomFunction) and (substring(Calculation,1,2)='/*') and (substring(Calculation,string-length(Calculation)-1)='*/')]">
		<xsl:value-of select="@name"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
