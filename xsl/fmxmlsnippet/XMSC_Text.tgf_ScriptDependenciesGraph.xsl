<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSC_Text.tgf_ScriptDependenciesGraph.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts
	
	Creates a graph of script calls in tgf format (trivial graph format)

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2016
	2016-05-19 MrW: New
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Graph_functions.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== KEYS ===== -->
	<xsl:key name="externalScriptsCallByID" match="//Step[@enable='True' and (@id='1' or @id='164') and Script and FileReference]" use="concat('X',FileReference/@id,'S',Script/@id)"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Match all scripts  -->
	<xsl:template match="/">
		<!--
		 ! 1. Output scripts as nodes
		 !
		 ! The tgf format is:
		 !     node-id<space>node-label
		 !
		 ! for the node-id we use 
		 !     S<field-id>
		 ! and for the node-label:
		 !     script-name [X] (o)
		 !-->
		<!-- first list the local scripts -->
		<xsl:for-each select="//Script[not(ancestor::Step) and not(@name='-')]">
			<xsl:value-of select="'S'"/>
			<xsl:value-of select="@id"/>
			<xsl:value-of select="' '"/>
			<xsl:call-template name="ScriptGraphNodeName"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:for-each>
		<!-- then list all called external scripts -->
		<xsl:for-each select="//Step[@enable='True' and (@id='1' or @id='164') and FileReference and count(.|key('externalScriptsCallByID',concat('X',FileReference/@id,'S',Script/@id))[1])=1]">
			<!-- concat('X',FileReference/@id,'S',Script/@id) -->
			<xsl:value-of select="'X'"/>
			<xsl:value-of select="FileReference/@id"/>
			<xsl:value-of select="'S'"/>
			<xsl:value-of select="Script/@id"/>
			<xsl:value-of select="' '"/>
			<xsl:for-each select="Script">
				<xsl:call-template name="ScriptGraphNodeName"/>
			</xsl:for-each>
			<xsl:value-of select="$newrecord"/>
		</xsl:for-each>
		<!-- 
		 ! 2. Output tgf delimiter which separates the nodes from the edges
		 ! a pound sign on a separate line
		-->
		<xsl:value-of select="'#'"/>
		<xsl:value-of select="$newrecord"/>
		<!--
		 ! 3. Output script calls as _directed_ edges:
		 !
		 !   script -> called script
		 !
		 ! The tgf format is:
		 !
		 !    node-id<space>node-id
		 !
		-->
		<xsl:for-each select="//Script[not(ancestor::Step) and not(@name='-')]">
			<xsl:variable name="id" select="@id"/>
			<xsl:variable name="scriptname" select="@name"/>
			<!-- -->
			<xsl:for-each select="Step[@enable='True' and (@id='1' or @id='164')]">
				<xsl:value-of select="'S'"/>
				<xsl:value-of select="$id"/>
				<xsl:value-of select="' '"/>
				<xsl:if test="FileReference">
					<xsl:value-of select="'X'"/>
					<xsl:value-of select="FileReference/@id"/>
				</xsl:if>
				<xsl:value-of select="'S'"/>
				<xsl:value-of select="Script/@id"/>
				<xsl:value-of select="$newrecord"/>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
