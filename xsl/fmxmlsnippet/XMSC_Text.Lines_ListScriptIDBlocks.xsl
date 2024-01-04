<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSC_Text.Lines_ListScriptIDBlocks.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied Script or table definitions
	
	Lists blocks of script IDs, so missing IDs can be easily identified
	
	===== CHANGES HISTORY =====
	2014-09-16 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== KEYS ===== -->
	<xsl:key name="ScriptsById" match="Script[not(ancestor::Script)]" use="number(@id)"/>
	<xsl:key name="GroupsById" match="Group" use="number(@id)"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/">
		<xsl:apply-templates select="//Script[not(ancestor::Script)] | //Group">
			<xsl:sort select="@id" data-type="number"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="Script | Group">
		<xsl:variable name="idp1" select="number(@id)+1"/>
		<xsl:variable name="idm1" select="number(@id)-1"/>
		<xsl:variable name="idm2" select="number(@id)-2"/>
		<xsl:variable name="idm3" select="number(@id)-3"/>
		<xsl:variable name="idNext">
			<xsl:choose>
				<xsl:when test="name()='Script'">
					<xsl:value-of select="number(@id)+1"/>
				</xsl:when>
				<xsl:when test="name()='Group'">
					<xsl:value-of select="number(@id)+2"/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="id">
			<xsl:value-of select="@id"/>
			<xsl:if test="name()='Group'">
				<xsl:value-of select="concat('+',$idp1)"/>
			</xsl:if>
		</xsl:variable>
		<!-- You are at the start of an ID-group if theree is no prior Script or no prior Group (Note:Groups use TWO ids!) -->
		<xsl:variable name="start" select="not(key('ScriptsById', $idm1)) and not(key('GroupsById', $idm2))"/>
		<xsl:variable name="end" select="not(key('ScriptsById', $idNext)) and not(key('GroupsById', $idNext))"/>
		<xsl:if test="$start">
			<xsl:if test="position()&gt;1">
				<xsl:value-of select="'-----'"/>
				<xsl:value-of select="$newrecord"/>
			</xsl:if>
			<xsl:value-of select="$id"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:value-of select="@name"/>
			<xsl:if test="name()='Group'">
				<xsl:value-of select="'/'"/>
			</xsl:if>
			<xsl:value-of select="$newrecord"/>
		</xsl:if>
		<xsl:if test="not($start) and not($end)">
			<xsl:variable name="idNextButOne">
				<xsl:choose>
					<xsl:when test="key('ScriptsById', $idNext)">
						<xsl:value-of select="$idNext+1"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$idNext+2"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:if test="not(key('ScriptsById', $idNextButOne)) and not(key('GroupsById', $idNextButOne))">
				<xsl:value-of select="'  :'"/>
				<xsl:value-of select="$newrecord"/>
			</xsl:if>
		</xsl:if>
		<xsl:if test="not($start) and $end">
			<xsl:value-of select="$id"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:value-of select="@name"/>
			<xsl:if test="name()='Group'">
				<xsl:value-of select="'/'"/>
			</xsl:if>
			<xsl:value-of select="$newrecord"/>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
