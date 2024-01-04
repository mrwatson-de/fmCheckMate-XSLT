<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMTB_Text.Lines_ListFieldsWithBadCalcContext.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: table definitions
	
	Lists all Fields containing a calculation, that appears not to be based on a TO other that the PTO.
	
	IMPORTANT: THIS FUNCTION WORKS ON THE ASSUMPTION THAT EACH BASETABLE HAS A PTO OF EXACTLY THE SAME NAME.

	===== CHANGES HISTORY =====
	2012-10-12 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- All Fields with serials AutoEnter (serial, constant, calculation, lookup) -->
	<xsl:template match="//Field[not(ancestor::Field) and ((@fieldType='Calculated' and not(Calculation/@table=../@name)) or (@fieldType='Normal' and AutoEnter/@calculation='True' and not(AutoEnter/Calculation/@table=../@name)))]">
		<xsl:value-of select="concat(../@name,'::',@name)"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
