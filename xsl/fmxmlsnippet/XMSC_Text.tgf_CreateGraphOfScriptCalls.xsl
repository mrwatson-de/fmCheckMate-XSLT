<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSC_Text.tgf_CreateGraphOfScriptCalls.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Creates a directed graph in tgf format of the 
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2011-11-30 MrW: Version 1
	2011-09-30 MrW: inc/constants.xsl
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="ISO-8859-1" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Script -->
	<xsl:template match="/">
		<xsl:for-each select="//Script[not(ancestor::Step) and not(@name='-')]">
			<xsl:value-of select="concat(@id, ' ',translate(@name,'#','_'))"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:for-each>
		<xsl:value-of select="'#'"/>
		<xsl:value-of select="$newrecord"/>
		<!-- Output called Scripts (=edges)-->
		<!-- For each Perform Script script step in this table -->
		<!-- using Muenchian Grouping to remove duplicate references -->
		<xsl:for-each select="//Script[not(ancestor::Step) and not(@name='-')]/Step[@id='1' and @enable='True']">
			<xsl:variable name="id-of-called-script">
				<xsl:choose>
					<xsl:when test="FileReference/@name">
						<!-- Reference to external Scripts File:ScriptID -->
						<xsl:value-of select="translate(concat(FileReference/@name,':',Script/@id),'#','_')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="Script/@id"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="edge" select="concat(ancestor::Script/@id,' ',$id-of-called-script)"/>
			<xsl:variable name="edge-label">
				<xsl:choose>
					<xsl:when test="FileReference/@name">
						<!-- link to an EXTERNAL script, so add a name to the link -->
						<xsl:value-of select="translate(concat(Script/@name,' (',FileReference/@name,')'),'#','_')"/>
					</xsl:when>
					<xsl:when test="//Script[not(ancestor::Step) and @id=$id-of-called-script]">
						<!-- link to a script listed here, so no name needed -->
					</xsl:when>
					<xsl:otherwise>
						<!-- link to a script NOT listed here, so add the name to the edge -->
						<xsl:value-of select="translate(Script/@name,'#','_')"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<!--  -->
			<xsl:value-of select="$edge"/>
			<xsl:value-of select="' '"/>
			<xsl:value-of select="$edge-label"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
