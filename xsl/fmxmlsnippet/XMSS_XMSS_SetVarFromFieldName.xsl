<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_SetVarFromFieldName.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps - with SetVar X = Field Y
	
	Converts SetVar X = Field Y into Set Var Y = Field Y.
	
	===== CHANGES HISTORY =====
	2019-10-03 MrW: Degermanified
	2013-09-09 MrW: Clone templates centralized in _inc/inc.Clone.xsl
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Set Variable -->
	<xsl:template match="//Step[@id='141']">
		<!-- convert to Set Field step -->
		<xsl:variable name="enable" select="@enable"/>
		<!-- From the calculation, e.g. "Table::Field[Repetition] // Comment" extract Table, Field and repetition -->
		<xsl:variable name="valueCalculation" select="Value/Calculation/text()"/>
		<xsl:variable name="fieldFullname" select="normalize-space(substring-before(concat(substring-before(concat($valueCalculation,'//'),'//'),'/*'),'/*'))"/>
		<xsl:variable name="fieldTableName" select="substring-before(concat($fieldFullname,'['),'[')"/>
		<xsl:variable name="fieldTable" select="substring-before($fieldTableName,'::')"/>
		<xsl:variable name="fieldName" select="substring-after($fieldTableName,'::')"/>
		<xsl:variable name="varName" select="$fieldName"/>
		<Step enable="{$enable}" id="141">
			<xsl:copy-of select="Value"/>
			<xsl:copy-of select="Repetition"/>
			<Name>
				<xsl:copy-of select="$varName"/>
			</Name>
		</Step>
	</xsl:template>
</xsl:stylesheet>
