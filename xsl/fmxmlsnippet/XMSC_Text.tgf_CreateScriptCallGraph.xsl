<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XMSC_Text.tgf_CreateScriptCallGraph.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Creates a trivial graph format graph of script calls.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2011-09-30 MrW: inc/constants.xsl
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Graph_functions.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Script -->
	<xsl:template match="/">
		<!-- Nodes -->
		<xsl:for-each
			select="(//Script[not(ancestor::Step) and @name != '-']) | //Script[not(ancestor::Step)]/Step/Script[FileReference]">
			<xsl:call-template name="tgf.node">
				<xsl:with-param name="id">
					<xsl:value-of select="@id"/>
				</xsl:with-param>
				<xsl:with-param name="name">
					<xsl:value-of select="@name"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
		<!-- Delimiter -->
		<xsl:value-of select="'#'"/>
		<xsl:value-of select="$newrecord"/>
		<!-- Edges -->
		<xsl:for-each select="//Script/Step[@id = '1' and @enable = 'True']/Script">
			<xsl:call-template name="tgf.edge">
				<xsl:with-param name="from" select="ancestor::Script[1]/@id"/>
				<xsl:with-param name="to">
					<xsl:if test="../FileReference">
						<xsl:value-of select="../FileReference/@name"/>
						<xsl:value-of select="'::'"/>
					</xsl:if>
					<xsl:value-of select="@id"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
