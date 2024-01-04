<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSS_Text.Lines_ConvertSetVarOrFieldToLetCalculation.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps - with Set-Var steps
	
	Produces a Let calculation.
	
	===== CHANGES HISTORY =====
	2011-09-30 MrW: inc/constants.xsl
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../FMPReport/ToHTML/English.lproj/Strings.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!--xsl:variable name="scriptParameterDelimiter" select="¶"/-->
	<xsl:variable name="scriptParameterDelimiter" select="$PIPE"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Set Var Script step-->
	<xsl:template match="/">
		<xsl:value-of select="'Let(['"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:for-each select="//Step[@id='141' or @id='76' or @id='147' or (@id='91' and With/@value='Calculation')]">
			<!-- Variable name -->
			<xsl:variable name="variable">
				<xsl:choose>
					<xsl:when test="@id='141'">
						<!-- Set Variable -->
						<xsl:value-of select="Name"/>
					</xsl:when>
					<xsl:when test="@id='76'">
						<!-- Set Field -->
						<xsl:value-of select="'$'"/>
						<xsl:value-of select="Field/@name"/>
					</xsl:when>
					<xsl:when test="@id='147'">
						<!-- Set Field By Name-->
						<xsl:value-of select="'$'"/>
						<xsl:value-of select="TargetName/Calculation"/>
					</xsl:when>
					<xsl:when test="@id='91'">
						<!-- Replace Field Contents-->
						<xsl:value-of select="'$'"/>
						<xsl:value-of select="Field/@name"/>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="expression">
				<xsl:choose>
					<xsl:when test="@id='141'">
						<!-- Set Variable -->
						<xsl:value-of select="Value/Calculation/text()"/>
					</xsl:when>
					<xsl:when test="@id='76'">
						<!-- Set Field -->
						<xsl:value-of select="Calculation/text()"/>
					</xsl:when>
					<xsl:when test="@id='147'">
						<!-- Set Field By Name-->
						<xsl:value-of select="Result/Calculation/text()"/>
					</xsl:when>
					<xsl:when test="@id='91'">
						<!-- Replace Field Contents-->
						<xsl:value-of select="Calculation/text()"/>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<!-- -->
			<!-- output -->
			<xsl:value-of select="concat($variable, ' = ', $expression)"/>
			<xsl:choose>
				<xsl:when test="not(position()=last())">
					<xsl:value-of select="' ;'"/>
					<xsl:value-of select="$newrecord"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$newrecord"/>
					<xsl:value-of select="'];'"/>
					<xsl:value-of select="$newrecord"/>
					<xsl:value-of select="$variable"/>
					<xsl:value-of select="$newrecord"/>
					<xsl:value-of select="')'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
