<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_ExplodeFind.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps - with Perform Find steps
	
	Expands the contents of the Perform Find step to a "proper" search script 
	with enter find mode, set fields, omit record, etc.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2014-06-25 MrW: Addes quotes to text IFF it has no quotes, and internationalized the function
	2013-11-08 MrW: Removed doubled quotes from the criteria.
	2013-09-09 MrW: Clone templates centralized in _inc/inc.Clone.xsl
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.Substitute.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.Quote.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- 28/Perform Find or 126/Constrain Found Set or 127/Extend Found Set-->
	<xsl:template match="//Step[@id='28' or @id='126' or @id='127']">
		<!-- convert to Set Field step -->
		<xsl:variable name="enable" select="@enable"/>
		<xsl:variable name="stepId" select="@id"/>
		<xsl:variable name="stepName" select="@name"/>
		<!-- Enter Find Mode -->
		<Step id="22" enable="{$enable}">
			<Pause state="False"/>
			<Restore state="False"/>
			<Query/>
		</Step>
		<!-- For each criteria -->
		<xsl:for-each select="Query/RequestRow">
			<xsl:if test="position()!=1">
				<!-- New Record/Request (OR) -->
				<Step id="7" enable="{$enable}"/>
			</xsl:if>
			<xsl:if test="@operation='Exclude'">
				<!-- Omit Record -->
				<Step id="25" enable="{$enable}"/>
			</xsl:if>
			<!-- For each criteria -->
			<xsl:for-each select="Criteria">
				<!-- Set Field -->
				<Step id="76" enable="{$enable}">
					<Calculation>
						<xsl:choose>
							<xsl:when test="starts-with(Text,$QUOT)">
								<!-- Quoted string (Does this ever really occur?) -->
								<xsl:value-of select="Text"/>
							</xsl:when>
							<xsl:when test="starts-with(Text,'$')">
								<!-- Search for a variable value -->
								<xsl:value-of select="Text"/>
							</xsl:when>
							<xsl:otherwise>
								<!-- Search for a text value -->
								<xsl:call-template name="fn.Quote">
									<xsl:with-param name="text">
										<xsl:value-of select="Text"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
					</Calculation>
					<xsl:copy-of select="Field"/>
				</Step>
			</xsl:for-each>
		</xsl:for-each>
		<!-- and finally an *empty* search command -->
		<Step id="{$stepId}" enable="{$enable}">
			<Restore state="False"/>
			<Query/>
		</Step>
	</xsl:template>
</xsl:stylesheet>
