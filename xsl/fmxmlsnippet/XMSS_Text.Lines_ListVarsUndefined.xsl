<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_Text.Lines_ListVarsUndefined.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts

	Lists variables which appear not to be defined.
	
	!!FIXME!!

	===== KNOWN ISSUES =====

	- In the output any correctly defined variables have '§' instead of '$' in their names.
	- The search method is over-simplified, which causes some 'false positives' (but it is better than nothing!):
	- $ characters in strings are also falsely considered to be variables and are thus also referenced
	- $$ variables are also listed, although such references are seldom an error
	- Variables in inactive places are also referenced

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2014-06-25 MrW: Version 0.1.1 Known issues documented
	2013-08-31 MrW: Version 0.1
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="indent" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!--  -->
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/">
		<xsl:variable name="probs">
			<xsl:choose>
				<xsl:when test="//Script[not(ancestor::Step)]">
					<xsl:apply-templates select="//Script[not(ancestor::Step)]"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="fmxmlsnippet"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$probs!=''">
				<xsl:value-of select="$probs"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'OK'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Script -->
	<xsl:template match="Script|fmxmlsnippet">
		<xsl:variable name="ScriptName" select="@name"/>
		<xsl:variable name="ListOfVarsDefinedBySetVar">
			<!-- $$vars descending in length-->
			<xsl:for-each select="Step[@id='141' and substring(Name,1,2)='$$']">
				<xsl:sort select="string-length(Name)" order="descending" data-type="number"/>
				<xsl:value-of select="Name"/>
				<xsl:value-of select="$newrecord"/>
			</xsl:for-each>
			<!-- $vars descending in length-->
			<xsl:for-each select="Step[@id='141' and substring(Name,1,1)='$' and substring(Name,2,1)!='$']">
				<xsl:sort select="string-length(Name)" order="descending" data-type="number"/>
				<xsl:value-of select="Name"/>
				<xsl:value-of select="$newrecord"/>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="ListOfVarsDefinedByLet">
			<!-- FIXME -->
		</xsl:variable>
		<xsl:variable name="vars" select="concat($ListOfVarsDefinedBySetVar,$ListOfVarsDefinedByLet)"/>
		<xsl:variable name="problemCalculations">
			<xsl:for-each select=".//Calculation[contains(.,'$')]">
				<xsl:variable name="CalcWithDefinedVarsRemoved">
					<xsl:call-template name="RemoveDefinedVariables">
						<xsl:with-param name="calc" select="."/>
						<xsl:with-param name="vars" select="$vars"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:if test="contains($CalcWithDefinedVarsRemoved,'$')">
					<!-- output the problem calculation-->
					<!--xsl:value-of select="1+count(preceding::Step)"/-->
					<xsl:value-of select="count(preceding::Step[parent::Script/@name=$ScriptName])"/>
					<xsl:value-of select="$delimiter"/>
					<xsl:value-of select="$CalcWithDefinedVarsRemoved"/>
					<xsl:value-of select="$newrecord"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:if test="$problemCalculations!=''">
			<xsl:if test="name()='Script' and @name">
				<xsl:value-of select="concat('Script ', @name,'-------------------------------------')"/>
				<xsl:value-of select="$newrecord"/>
			</xsl:if>
			<xsl:value-of select="$problemCalculations"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:if>
	</xsl:template>
	<!--  -->
	<xsl:template match="Calculation[contains(.,'$')]">
		<xsl:variable name="CalcWithDefinedVarsRemoved">
			<xsl:call-template name="RemoveDefinedVariables">
				<xsl:with-param name="calc" select="."/>
				<xsl:with-param name="vars" select="$vars"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="contains($CalcWithDefinedVarsRemoved,'$')">
			<!-- output the problem calculation-->
			<xsl:value-of select="1+count(preceding::Step)"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:value-of select="$CalcWithDefinedVarsRemoved"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:if>
	</xsl:template>
	<!-- RemoveDefinedVariables -->
	<xsl:template name="RemoveDefinedVariables">
		<xsl:param name="calc"/>
		<xsl:param name="vars"/>
		<!--  -->
		<!--		<xsl:value-of select="$calc"/>
		<xsl:value-of select="'(x)'"/>
		<xsl:value-of select="$vars"/>
		<xsl:value-of select="'(=========)'"/>
		<xsl:value-of select="$newrecord"/>
-->
		<xsl:choose>
			<xsl:when test="$vars=''">
				<!-- Finished -->
				<xsl:value-of select="$calc"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- Recurse -->
				<xsl:call-template name="RemoveDefinedVariables">
					<xsl:with-param name="calc">
						<xsl:call-template name="RemoveDefinedVar">
							<xsl:with-param name="calc" select="$calc"/>
							<xsl:with-param name="var" select="substring-before($vars,$newrecord)"/>
						</xsl:call-template>
					</xsl:with-param>
					<xsl:with-param name="vars" select="substring-after($vars,$newrecord)"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- RemoveDefinedVar -->
	<xsl:template name="RemoveDefinedVar">
		<xsl:param name="calc"/>
		<xsl:param name="var"/>
		<!--  -->
		<xsl:choose>
			<xsl:when test="not(contains($calc,$var))">
				<!-- Finished -->
				<xsl:value-of select="$calc"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- Recurse -->
				<xsl:call-template name="RemoveDefinedVar">
					<xsl:with-param name="calc" select="concat(substring-before($calc,$var),translate($var,'$','§'),substring-after($calc,$var))"/>
					<xsl:with-param name="var" select="$var"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
