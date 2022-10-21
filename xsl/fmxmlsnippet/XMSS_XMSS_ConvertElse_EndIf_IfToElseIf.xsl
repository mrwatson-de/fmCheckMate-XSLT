<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_ConvertElse_EndIf_IfToElseIf.xls

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Replaces 
		Else
		End If
		If ( condition )
	with
		Else if ( condition )
	
	Note that:
	
	- there may be NO blank or comment lines between the else and the if!

	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2022
	2022-02-18 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Remove an Else, if it is directly followed by an End If and an If-->
	<xsl:template match="Step[@id='69' and following-sibling::Step[1]/@id='70' and following-sibling::Step[2]/@id='68']"/>

	<!-- Remove an End If, if it is preceded by an Else and directly followed by an If-->
	<xsl:template match="Step[@id='70' and preceding-sibling::Step[1]/@id='69' and following-sibling::Step[1]/@id='68']"/>

	<!-- Convert an If (if preceded by an Else + End If) to Else If-->
	<xsl:template match="Step[@id='68' and preceding-sibling::Step[2]/@id='69' and preceding-sibling::Step[1]/@id='70']">
		<xsl:variable name="enable" select="@enable"/>
		<!--  -->
		<Step enable="{$enable}" id="125" name="">
			<xsl:copy-of select="Calculation"/>
		</Step>
	</xsl:template>
</xsl:stylesheet>
