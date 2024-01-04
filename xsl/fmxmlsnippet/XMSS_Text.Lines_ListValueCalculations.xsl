<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSS_Text.Lines_ListValueCalculations.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or scriptsteps
	
	Returns a list of the value calculations in Set Variable, Set Field, Set Field by Name, Replace Field Contents.
	
	===== CHANGES HISTORY =====
	2011-09-30 MrW: inc/constants.xsl
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Script step 141. Set Variable -->
	<xsl:template match="Step[(@id='141' or @id='76' or @id='147' or @id='91') and @enable='True']">		
		<xsl:value-of select="translate(Value/Calculation,$CRLF,' ')"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
	
</xsl:stylesheet>
