<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="text" indent="no"/>
	<!-- Main template for processing elements -->
	<xsl:template match="*">
		<xsl:text>"</xsl:text>
		<xsl:value-of select="name()"/>
		<xsl:text>": {</xsl:text>
		<xsl:apply-templates select="@*|node()"/>
		<xsl:text>}</xsl:text>
		<xsl:if test="position() != last()">
			<xsl:text>,</xsl:text>
		</xsl:if>
	</xsl:template>
	<!-- Template for processing attributes -->
	<xsl:template match="@*">
		<xsl:text>"@</xsl:text>
		<xsl:value-of select="name()"/>
		<xsl:text>": "</xsl:text>
		<xsl:value-of select="."/>
		<xsl:text>"</xsl:text>
		<xsl:if test="position() != last()">
			<xsl:text>,</xsl:text>
		</xsl:if>
	</xsl:template>
	<!-- Template for processing text nodes -->
	<xsl:template match="text()">
		<xsl:text>"#text": "</xsl:text>
		<xsl:value-of select="normalize-space(.)"/>
		<xsl:text>"</xsl:text>
		<xsl:if test="position() != last()">
			<xsl:text>,</xsl:text>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
