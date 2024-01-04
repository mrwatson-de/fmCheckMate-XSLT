<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMFN_Text.Lines_ListCustomFunctionCalls.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Returns the list of custom functions, showing the functoin calls
	
	===== CHANGES HISTORY =====
	2022-02-26 MrW: V0.1
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<xsl:variable name="indent" select="'  '"/>
	<xsl:variable name="CustomFunctionCount" select="count(//CustomFunction)"/>

	<xsl:key name="CFs" match="//CustomFunction" use="
		count(//CustomFunction[string-length(@name) &gt; string-length(./@name)]) +
		count(//CustomFunction[string-length(@name) = string-length(./@name) and @name &lt; ./@name])
		"/>
	
	<!-- ===== TEMPLATES ===== -->
	<xsl:template match="/">
		<xsl:for-each select="//CustomFunction">
			<xsl:sort select="string-length(@name)" data-type="number" order="descending"/>
			<xsl:sort select="@name" order="ascending"/>

			<xsl:value-of select="count(//CustomFunction[string-length(@name) > string-length(./@name)]) +
				count(//CustomFunction[string-length(@name) = string-length(./@name) and @name &lt; ./@name])"/>
			<xsl:value-of select="': '"/>
			<xsl:value-of select="@name"/>
			<xsl:value-of select="$newrecord"/>
			
		</xsl:for-each>
		<!--
		<xsl:value-of select="key('CFs',1)/@name"/>
		<xsl:call-template name="loop">
			<xsl:with-param name="i" select="1"/>
			<xsl:with-param name="n" select="count(//CustomFunction)"/>
		</xsl:call-template>-->
	</xsl:template>
		
	<xsl:template name="loop">
		<xsl:param name="i"/>
		<xsl:param name="n"/>
		<!-- -->
			<xsl:if test="$i &lt;= $n">
				<xsl:value-of select="$i"/>
				<xsl:value-of select="': '"/>
				<xsl:value-of select="key('CFs',$i)/@name"/>
				<xsl:value-of select="$newrecord"/>
				
				<xsl:call-template name="loop">
					<xsl:with-param name="i" select="$i + 1"/>
					<xsl:with-param name="n" select="$n"/>
				</xsl:call-template>
			</xsl:if>
	</xsl:template>
		
		
					<!-- CustomFunction
						
						




		<xsl:text>CustomFunction </xsl:text>
		<xsl:value-of select="@name"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:for-each select="//CustomFunction">
			<xsl:sort select="string-length(@name)" data-type="number"/>
			<xsl:sort select="@name"/>
			<xsl:value-of 
		</xsl:for-each>
				
				
						
						
	<xsl:template match="//CustomFunction">
		<xsl:variable name="calc" select="Calculation"/>





		<xsl:text>CustomFunction </xsl:text>
		<xsl:value-of select="@name"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:for-each select="//CustomFunction">
			<xsl:sort select="string-length(@name)" data-type="number"/>
			<xsl:sort select="@name"/>
			<xsl:value-of 
		</xsl:for-each>
	</xsl:template>
	 -->

	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
