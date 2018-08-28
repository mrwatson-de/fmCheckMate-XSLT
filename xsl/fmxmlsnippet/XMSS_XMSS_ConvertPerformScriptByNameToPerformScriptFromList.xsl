<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2018 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_ConvertPerformScriptByNameToPerformScriptFromList.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Converts Perform Script [ By name: … into Perform Script [ From List: …
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
	<!-- Perform Script [ By Name: … -->
	<xsl:template match="Step[@id = '1' and Calculated]">
		<xsl:variable name="enable" select="@enable"/>
		<xsl:variable name="calc" select="Calculated/Calculation/text()"/>
		<!--unquote-->
		<xsl:variable name="str" select="substring($calc, 2, string-length($calc) - 2)"/>
		<!--split-->
		<xsl:variable name="file" select="substring-before($str, '::')"/>
		<xsl:variable name="script" select="substring-after($str, '::')"/>
		<!-- -->
		<Step enable="{$enable}" id="1">
			<!-- Add the script reference (The id  will be looked up when pasted in) -->
			<Script id="0" name="{$script}"/>
			<!-- If the script is in a different file… -->
			<xsl:if test="$file">
				<!-- add a reference to the file -->
				<FileReference id="0" name="{$file}">
					<!-- and if a File Reference has to be created -->
					<UniversalPathList>
						<!-- let's assume it is a neighbouring file of the same name -->
						<xsl:value-of select="concat('file:', $file)"/>
					</UniversalPathList>
				</FileReference>
			</xsl:if>
			<!-- Copy only the parameter, whilst removing the calculated calculation (and hidden script)-->
			<xsl:copy-of select="Calculation"/>
		</Step>
	</xsl:template>
</xsl:stylesheet>
