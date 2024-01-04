<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XML2_XMSS_GoToField.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	Returns a script step to go to the copied field(s)

	===== CHANGES HISTORY =====
	2016-06-20 MrW Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/fmxmlsnippet/Layout">
		<!--  -->
		<fmxmlsnippet type="FMObjectList">
			<xsl:for-each select="//FieldObj/DDRInfo/Field">
				<xsl:variable name="fieldId" select="@id"/>
				<xsl:variable name="fieldTable" select="@table"/>
				<xsl:variable name="fieldName" select="@name"/>
				<!-- -->
				<Step enable="True" id="17"><!-- name="Go to Field" -->
					<SelectAll state="False"></SelectAll>
					<Field table="{$fieldTable}" id="{$fieldId}" name="{$fieldName}"></Field>
				</Step>
			</xsl:for-each>
		</fmxmlsnippet>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
