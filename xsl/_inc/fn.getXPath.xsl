<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: fn.getXpath.xsl

	XML-Source: any.xml
	XML-Grammar: any
	XML-Content: any
	
	Returns an Xpath expression to the given node (root node, element, attribute or text).
	
	The returned Xpath may be used to reference the node in the current or future XSLT session.
	(The generate-id() function is only valid for the current XSLT session)
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2016
	2015-09-11 MrW Version 1.0
	-->
	<!-- ===== NEEDS ===== -->
	<!--nothing-->
	<!-- ===== TEMPLATES ===== -->
	<!-- "fn.getXpath" -->
	<xsl:template name="fn.getXpath">
		<xsl:param name="node"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="not($node/ancestor::node())">
				<!-- ROOT NODE-->
				<xsl:value-of select="'/'"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- recurse up the tree first -->
				<xsl:call-template name="fn.getXpath">
					<xsl:with-param name="node" select="$node/ancestor::*[1]"/>
				</xsl:call-template>
				<xsl:if test="$node/ancestor::*">
					<!-- Add separator between NODES - but NOT after the root '/'! -->
					<xsl:value-of select="'/'"/>
				</xsl:if>
				<!-- output the Xpath reference to the node: {@}name{[n]} -->
				<xsl:choose>
					<xsl:when test="$node/self::*">
						<!-- ELEMENT NODE -->
						<xsl:variable name="name" select="name($node)"/>
						<xsl:variable name="index" select="1 + count($node/preceding-sibling::*[name(.) = $name])"/>
						<!-- -->
						<xsl:value-of select="$name"/>
						<!-- ALSO output [1] to be absolutely explicit  -->
						<!--xsl:if test="$index &gt; 1"-->
						<xsl:value-of select="concat('[',$index,']')"/>
						<!--/xsl:if-->
					</xsl:when>
					<xsl:when test="count($node|$node/../@*)=count($node/../@*)">
						<!-- ATTRIBUTE NODE -->
						<xsl:value-of select="concat('@',name($node))"/>
					</xsl:when>
					<xsl:when test="$node/self::text()">
						<!-- TEXT NODE -->
						<xsl:variable name="index" select="1 + count($node/preceding-sibling::text())"/>
						<!-- -->
						<xsl:value-of select="'text()'"/>
						<!-- ALSO output [1] to be absolutely explicit  -->
						<!--xsl:if test="$index &gt; 1"-->
						<xsl:value-of select="concat('[',$index,']')"/>
						<!--/xsl:if-->
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'ERROR'"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
