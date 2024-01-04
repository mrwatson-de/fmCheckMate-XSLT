<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: xsl_Text.Lines_ListTemplates.xsl

	XML-Source: any.xsl
	XML-Grammar: xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	XML-Content: any xslt stylesheet
	
	Lists the templates in the stylesheet.
	
	===== CHANGES HISTORY =====
	2011-02-09 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<xsl:template match="/xsl:stylesheet">
		<!-- Show all templates -->
		<xsl:value-of select="'Templates:'"/>
		<!--xsl:text>[mode:]"match"name(parameter)</xsl:text-->
		<xsl:value-of select="$newrecord"/>
		<xsl:for-each select="xsl:template">
			<xsl:if test="@mode">
				<xsl:value-of select="concat(@mode, ':')"/>
			</xsl:if>
			<xsl:if test="@match">
				<xsl:value-of select="concat('=&quot;',@match, '&quot;')"/>
			</xsl:if>
			<xsl:if test="@match and @name">
				<xsl:value-of select="', '"/>
			</xsl:if>
			<xsl:value-of select="@name"/>
			<xsl:if test="xsl:param">
				<xsl:value-of select="'( '"/>
				<!-- List Parameters -->
				<xsl:for-each select="xsl:param">
					<xsl:if test="position()>1">
						<xsl:value-of select="', '"/>
					</xsl:if>
					<xsl:value-of select="@name"/>
				</xsl:for-each>
				<xsl:value-of select="' )'"/>
			</xsl:if>
			<xsl:value-of select="$newrecord"/>
		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
