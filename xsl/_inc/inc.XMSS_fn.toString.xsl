<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: inc.XMSS_fn.toString.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied script steps
	
	toString function for script step.
	
	===== CHANGES HISTORY =====
	 2019-06-06 MrW v0.1
	-->
	<!-- ===== TEMPLATES WITH MODES ===== -->
	<!--
	 ! Step.toString
	 ! Writes the position of a step in a script/button
	 !-->
	<xsl:template match="Step" mode="toString">
		<xsl:value-of select="concat('Step ',1+count(preceding-sibling::Step))"/>
		<xsl:value-of select="concat(' &quot;',@name,'&quot; …')"/>
		<xsl:choose>
			<xsl:when test="parent::Script">
				<xsl:value-of select="' of '"/>
				<xsl:apply-templates select="parent::Script" mode="toString"/>
			</xsl:when>
			<xsl:when test="ancestor::Object">
				<xsl:value-of select="' in '"/>
				<xsl:apply-templates select="ancestor::Object[1]" mode="toString"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="' (Script unknown)'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
