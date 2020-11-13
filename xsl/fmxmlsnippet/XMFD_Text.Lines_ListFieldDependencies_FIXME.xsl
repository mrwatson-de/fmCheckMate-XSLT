<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMFD_Text.Lines_ListFieldDependencies_FIXME.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied field or table definitions
	
	PLANNED:
	Lists all fields, organised/indented based on references/dependencies.
	How to deal with CIRCULAR references?
	How to parse claculations so as not to match 'subnames'
		A: Maybe process the LONGEST names first and REMOVE references?

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2012-08-20 MrW: 3/4 year later some inspiration came...and field references started to be analysed
	2011-11-17 MrW: Started ... but with what hope?
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:key name="fieldsByFullName" match="//Field[not(ancestor::Field)]" use="concat('@table','::','@name')"/>
	<xsl:variable name="numberOfFields" select="count(//Field[not(ancestor::Field)])"/>
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<xsl:variable name="fieldReferences">
		<!-- analyse field references -->
		<FieldReferences>
			<xsl:for-each select="//Field[not(ancestor::Field)]">
				<xsl:sort select="string-length(../@name)*100+string-length(@name)" order="descending" data-type="number"/>
				<!--  -->
				<xsl:if test="//Field[not(ancestor::Field) and (@fieldType='Calculated' or AutoEnter/@calculation='True' or AutoEnter/@lookup='True')]">
						<xsl:variable name="table" select="@table"/>
						<xsl:variable name="name" select="@name"/>
						<xsl:variable name="id" select="@id"/>
						<Field table="{$table}" name="{$name}" id="{$id}">
						<xsl:choose>
							<xsl:when test="@fieldType='Calculated'">
								<!-- Parse the calculated field calculation to find field references-->
								<xsl:call-template name="getFieldReferencesOutOfCalculation">
									<xsl:with-param name="calculation" select="Calculation/text()"/>
									<xsl:with-param name="i" select="1"/>
									<xsl:with-param name="n" select="$numberOfFields"/>
								</xsl:call-template>
							</xsl:when>
							<xsl:when test="AutoEnter/@calculation='True'">
								<!-- Parse the auto-enter calculation to find field references -->
								<xsl:call-template name="getFieldReferencesOutOfCalculation">
									<xsl:with-param name="calculation" select="AutoEnter/Calculation/text()"/>
									<xsl:with-param name="i" select="1"/>
									<xsl:with-param name="n" select="$numberOfFields"/>
								</xsl:call-template>
							</xsl:when>
							<xsl:when test="AutoEnter/@lookup='True'">
								<!-- return the lookup field -->
								<xsl:copy-of select="AutoEnter/Lookup/Field"/>
							</xsl:when>
						</xsl:choose>
					</Field>
				</xsl:if>
			</xsl:for-each>
		</FieldReferences>
	</xsl:variable>
	<!-- ===== TEMPLATES ===== -->
	<!-- Match all fields  -->
	<xsl:template match="/">
		<xsl:copy-of select="$fieldReferences"/>
	</xsl:template>
	<!--  -->
	<!-- temp -->
	<xsl:template name="temp">
		<xsl:for-each select="//Field[not(ancestor::Field) and (@fieldType='Calculated' or AutoEnter/@calculation='True' or AutoEnter/@lookup='True')]">
			<xsl:sort select="number(@fieldType='Calculated')"/>
			<!--  -->
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="getFieldReferencesOutOfCalculation">
		<xsl:param name="calculation"/>
		<xsl:param name="i"/>
		<xsl:param name="n"/>
		<!--  -->
		<xsl:variable name="fieldname" select="key('fieldsByFullName',$i)"/>
		<xsl:variable name="calculationWithLongFieldNameRemoved">
		</xsl:variable>
		<xsl:if test="$i&lt;=$n">
			<xsl:call-template name="getFieldReferencesOutOfCalculation">
				<xsl:with-param name="calculation" select="calculationWithLongFieldNameRemoved"/>
				<xsl:with-param name="i" select="$i+1"/>
				<xsl:with-param name="n" select="$n"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
