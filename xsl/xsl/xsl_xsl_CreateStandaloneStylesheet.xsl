<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: xsl_xsl_CreateStandaloneStylesheet.xsl

	XML-Source: any.xsl
	XML-Grammar: xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	XML-Content: any xslt stylesheet
	
	Replaces xsl:include tags with the referenced stylesheets content.
	
	IMPORTANT: If you have used xsl:import elements, you must first 
	replace them with xsl:include tags, splitting stylesheets if necessary 
	into a file containing the function and one containing the test code.
	
	===== CHANGES HISTORY =====
	2014-09-29 MrW: Version 1.1 Extended to document the included content with comments.
	2011-02-09 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Copy import files ionto main body of the stylesheet -->
	<xsl:template match="//xsl:include">
		<xsl:comment>
			<xsl:value-of select="'vvvvvvvvvvvvvvvvv'"/>
			<xsl:value-of select="concat(' INCLUDE ',@href,' ')"/>
			<xsl:value-of select="'vvvvvvvvvvvvvvvvv'"/>
		</xsl:comment>
		<xsl:apply-templates select="document(@href)/xsl:stylesheet/*"/>
		<xsl:comment>
			<xsl:value-of select="'^^^^^^^^^^^^^^^^^^'"/>
			<xsl:value-of select="concat(' INCLUDE ',@href,' ')"/>
			<xsl:value-of select="'^^^^^^^^^^^^^^^^^^'"/>
		</xsl:comment>
	</xsl:template>
</xsl:stylesheet>
