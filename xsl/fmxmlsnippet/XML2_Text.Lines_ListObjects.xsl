<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" xmlns:str="http://exslt.org/strings" extension-element-prefixes="str date" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XML2_Text.Lines_ListObjects.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	Returns a tabulated list of the objects.
	
	===== CHANGES HISTORY =====
	2013-11-19 MrW: Umbenannt für XML2
	2011-09-30 MrW: inc/constants.xsl
	2011-08-10 MrW: Version 0.9
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<!--xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/-->
	<xsl:include href="../../../fmCheckMate/xsl/_inc/exslt/str/str.replace.template.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XML2_CommonTemplates.xsl"/>
	<!--xsl:include href="../../../fmCheckMate/xsl/_inc/exslt/str/str.replace.function.xsl"/-->
	<!-- ===== VARIABLES ===== -->
	<!--xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/-->
	<!-- ===== TEMPLATES ===== -->
	<!-- Object List -->
	<xsl:template match="/*/Layout">
		<xsl:value-of select="'(rel) Bounds'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Object Path'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Object Name'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Object Type'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Object Reference'"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:value-of select="'Action/Properties'"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:apply-templates select="Object[not(parent::GroupButtonObj)]">
			<!--xsl:sort select="translate(concat(@type,TabControlObj/TabPanelObj/TextObj/ParagraphStyleVector/Style/Data,PortalObj/TableAliasKey,FieldObj/Name,GroupButtonObj/Object/TextObj/ParagraphStyleVector/Style/Data),'ABCDEFRGHIJKLMNOPQRSTUVWXYZÄÖÜ','abcdefrghijklmnopqrstuvwxyzäöü')"/-->
			<xsl:sort select="Bounds/@top * 10000000 + Bounds/@left" data-type="number"/>
		</xsl:apply-templates>
	</xsl:template>
	<!--  -->
	<xsl:template match="Object">
		<xsl:apply-templates select="." mode="getDelimitedDescriptionLine"/>
		<xsl:apply-templates select="*/Object"/>
	</xsl:template>
	
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
