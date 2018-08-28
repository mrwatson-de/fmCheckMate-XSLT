<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2018 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_ConvertIfSetFieldToSetFieldIf.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Converts 
	
		If [A]
			Set Field X = B
		Else If [C]
			Set Field X = D
		Else If [E]
			Set Field X = F
		Else
			Set Field X = G
		End If
	
	to

	Set Field X = 
		Case (
		A ; B ;
		C ; D ;
		E ; F ;
		G
		)
	
	...with comments


	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2018
	2018-04-20 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== Parameter ===== -->
	<xsl:variable name="useIf" select="false"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<xsl:variable name="ifOrCase">
		<xsl:choose>
			<xsl:when test="$useIf=true">
				<xsl:value-of select="'If'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'Case'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<!-- ===== TEMPLATES ===== -->
	<!-- 
	 !
	 ! remove…
	 !
	 !-->
	<!-- remove If ... and convert Set Field steps-->
	<xsl:template match="Step[@id='68']">
		<xsl:apply-templates select="(following-sibling::Step[@id='76'])[1]" mode="convert"/>
		<xsl:comment>
			<xsl:value-of select="'Removed '"/>
			<xsl:value-of select="@name"/>
		</xsl:comment>
	</xsl:template>
	<!-- remove everything between If and end if-->
	<xsl:template match="Step[preceding-sibling::Step/@id='68' and (@id = 70 or following-sibling::Step/@id='70')]">
		<xsl:comment>
			<xsl:value-of select="'Removed '"/>
			<xsl:value-of select="@name"/>
		</xsl:comment>
	</xsl:template>
	<!-- 
	 !
	 ! mode convert
	 !
	 !-->
	<!-- Step[@id='76'] Set Field -->
	<xsl:template match="Step[@id='76']" mode="convert">
		<!-- Replace calculation -->
		<xsl:variable name="enable" select="@enable"/>
		<!-- -->
		<Step enable="{$enable}" id="76">
			<xsl:copy-of select="Field"/>
			<xsl:copy-of select="Repetition"/>
			<Calculation>
				<xsl:apply-templates select="../*" mode="stepsToCalc"/>
			</Calculation>
		</Step>
		<xsl:apply-templates select="following-sibling::*"/>
	</xsl:template>
	<!-- 
	 !
	 ! mode stepsToCalc
	 !
	 !-->
	<!-- Step[@id='68'] If -->
	<xsl:template match="Step[@id='68']" mode="stepsToCalc">
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="$ifOrCase"/>
		<xsl:value-of select="' ('"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="'/* If */'"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="Calculation"/>
		<xsl:if test="contains(Calculation,'//')">
			<xsl:value-of select="$newrecord"/>
		</xsl:if>
		<xsl:value-of select="' ;'"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- Step[@id='89'] Comment -->
	<xsl:template match="Step[@id='89' and Text]" mode="stepsToCalc">
		<xsl:value-of select="'/* '"/>
		<xsl:value-of select="Text"/>
		<xsl:value-of select="' */'"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- Step[@id='76'] Set Field -->
	<xsl:template match="Step[@id='76']" mode="stepsToCalc">
		<!--xsl:value-of select="'/* = */ '"/-->
		<xsl:value-of select="Calculation"/>
		<xsl:if test="contains(Calculation,'//')">
			<xsl:value-of select="$newrecord"/>
		</xsl:if>
		<xsl:if test="following-sibling::Step[@id='125' or @id='69']">
			<xsl:value-of select="' ;'"/>
		</xsl:if>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- Step[@id='125'] Else If -->
	<xsl:template match="Step[@id='125']" mode="stepsToCalc">
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="'/* Else If */'"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="Calculation"/>
		<xsl:if test="contains(Calculation,'//')">
			<xsl:value-of select="$newrecord"/>
		</xsl:if>
		<xsl:value-of select="' ;'"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- Step[@id='69'] Else -->
	<xsl:template match="Step[@id='69']" mode="stepsToCalc">
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="'/* Else */'"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- Step[@id='70'] End If -->
	<xsl:template match="Step[@id='70']" mode="stepsToCalc">
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="'/* End If */'"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="')'"/>
	</xsl:template>
	<!-- Recurse -->
	<!--xsl:template match="*" mode="stepsToCalc">
		<xsl:apply-templates select="*" mode="stepsToCalc"/>
	</xsl:template-->
</xsl:stylesheet>
