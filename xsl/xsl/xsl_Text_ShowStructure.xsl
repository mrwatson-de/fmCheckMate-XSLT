<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: xsl_Text_ShowStructure.xsl

	XML-Source: any.xsl
	XML-Grammar: xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	XML-Content: any xslt stylesheet
	
	Shows the structure of the stylesheet, incluing templates, for-loops and further template-calling
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
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
		<xsl:for-each select="xsl:template">
			<xsl:value-of select="$newrecord"/>
			<xsl:value-of select="'Template '"/>
			<xsl:if test="@mode">
				<xsl:value-of select="concat(@mode, ':')"/>
			</xsl:if>
			<xsl:if test="@match">
				<xsl:value-of select="concat('&quot;',@match, '&quot;')"/>
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
			
			<!-- show template calls -->
			<xsl:apply-templates select="*"/>
			
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="xsl:for-each">
		<xsl:value-of select="concat('for-each: ',@select)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:apply-templates select="*"/>
	</xsl:template>
	<xsl:template match="xsl:apply-templates">
		<xsl:value-of select="concat('apply-templates: ',$QUOT, @select, $QUOT)"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:apply-templates select="*"/>
	</xsl:template>
	<xsl:template match="xsl:call-template">
		<xsl:value-of select="'call-template: '"/>
		<xsl:if test="@mode">
			<xsl:value-of select="concat(@mode, ':')"/>
		</xsl:if>
		<xsl:if test="@select">
			<xsl:value-of select="concat('&quot;',@select, '&quot;')"/>
		</xsl:if>
		<xsl:if test="@select and @name">
			<xsl:value-of select="', '"/>
		</xsl:if>
		<xsl:value-of select="@name"/>
		<xsl:if test="xsl:with-param">
			<xsl:value-of select="'( '"/>
			<!-- List Parameters -->
			<xsl:for-each select="xsl:with-param">
				<xsl:if test="position()>1">
					<xsl:value-of select="', '"/>
				</xsl:if>
				<xsl:value-of select="@name"/>
			</xsl:for-each>
			<xsl:value-of select="' )'"/>
		</xsl:if>
		<xsl:value-of select="$newrecord"/>
		<xsl:apply-templates select="*"/>
	</xsl:template>
	
	
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
