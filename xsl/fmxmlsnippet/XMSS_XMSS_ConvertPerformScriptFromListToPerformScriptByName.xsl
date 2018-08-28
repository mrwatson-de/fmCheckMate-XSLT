<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2018 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_ConvertPerformScriptFromListToPerformScriptByName.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Converts Perform Script [ From List: … into Perform Script [ By name: …
	(whilst keeping the scrift reference in the background) 
	
	Note: FileMaker 17 introduced Perform Script By name, which is defined 
	      by the presence of a Calculated/Calculation element.

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2018
	2018-05-04 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"
		cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Perform Script [ From List: … -->
	<xsl:template match="Step[@id = '1' and not(Calculated)]">
		<xsl:variable name="enable" select="@enable"/>
		<!-- -->
		<Step enable="{$enable}" id="1">
			<!-- Insert calculated calculation -->
			<Calculated>
				<Calculation>
					<xsl:value-of select="$QUOT"/>
					<xsl:if test="FileReference">
					<xsl:value-of select="FileReference/@name"/>
					</xsl:if>
					<xsl:if test="FileReference or contains(Script/@name,'::')">
						<xsl:value-of select="'::'"/>
					</xsl:if>
					<xsl:value-of select="Script/@name"/>
					<xsl:value-of select="$QUOT"/>
				</Calculation>
			</Calculated>
			<!-- Keep the script-reference in the background -->
			<xsl:copy-of select="*"/>
			<!-- Use the following to remove the script-reference from the background -->
			<!-- <xsl:copy-of select="Calculation"/>-->
			
		</Step>
	</xsl:template>
</xsl:stylesheet>
