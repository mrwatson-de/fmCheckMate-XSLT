<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSS_Text_ConvertSetFieldsToPredicateEqual.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Set-Field steps are converted into a predicate (if-condition) to check equality.
	
	===== SEE ALSO =====

	XMSS_Text_ConvertSetFieldsToPredicateExact.xsl
	XMSS_XMSS_SetFieldIfNotAlreadyEqual.xsl
	XMSS_XMSS_SetFieldIfNotExactlyEqual.xsl

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
	<!-- Set Field -->
	<xsl:template match="/">
		<xsl:for-each select="//Step[@id='76']">
			<xsl:if test="position()>1">
				<xsl:value-of select="concat(' AND',$newrecord)"/>
			</xsl:if>
			<xsl:value-of select="concat(Field/@table,'::',Field/@name)"/>
			<xsl:value-of select="' = '"/>
			<xsl:value-of select="Calculation/text()"/>
			<xsl:if test="contains(Calculation/text(),'//')">
				<xsl:value-of select="$newrecord"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
