<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XML2_XML2_RevealHiddenHideConditions.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied fmp12 layout objects
	
	Moves HideCondition tags that are hidden (e.g. inside buttons) up
	
	FIXME

	===== CHANGES HISTORY =====
	20150417 MrW v1
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Find objects containing one Object having one HideCondition tag -->
	<xsl:template match="Object[count( GroupButtonObj/Object ) = 1 and GroupButtonObj/Object/HideCondition/Calculation/text() and not(HideCondition/Calculation/text()]">
		
		<xsl:copy>
		</xsl:copy>
		
		</xsl:template>
	<!-- remove HideCondition tag -->
	<xsl:template match="HideCondition"/>
	
	FIXME
	
	-/fmxmlsnippet/Layout/Object/GroupButtonObj/Object/HideCondition/Calculation
	+/fmxmlsnippet/Layout/Object/HideCondition
	+/fmxmlsnippet/Layout/Object/HideCondition[@findMode='False']
	+/fmxmlsnippet/Layout/Object/HideCondition/Calculation
	
</xsl:stylesheet>
