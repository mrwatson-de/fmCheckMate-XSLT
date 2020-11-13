<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_ConvertPerformScriptBetweenFromListAndByName.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Removes all script names in Perform Script steps.

	Perform Script from List:

		<Step enable="True" id="1" name="Perform Script">
			<FileReference id="1" name="fmAutoMate">
				<UniversalPathList>file:fmAutoMate</UniversalPathList>
			</FileReference>
			<Script id="8" name="Script 1 start"></Script>
		</Step>

	Perform Script by Name:
	
		<Step enable="True" id="1" name="Perform Script">
			<Calculated>
				<Calculation><![CDATA["fmAutoMate::Script 1 start"]]></Calculation>
			</Calculated>
		</Step>


	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2017-02-04 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Convert TO by Name: Add Calculated Scriptname -->
	<xsl:template match="Step[(@id='1' or @id='164') and not(Calculated)]">
		<xsl:variable name="FileScriptRef" select="concat(FileReference/@name,'::',Script/@name)"/>
		<xsl:variable name="QuotedFileScriptRef">
			<xsl:value-of select="concat('&quot;',$FileScriptRef,'&quot;')"/>
		</xsl:variable>
		<!-- OUTPUT -->
		<xsl:copy>
			<xsl:apply-templates select="@*|*"/>
			<Calculated>
				<Calculation>
					<xsl:value-of select="$QuotedFileScriptRef"/>
				</Calculation>
			</Calculated>
		</xsl:copy>
	</xsl:template>
	<!-- Convert FROM by Name: Add Script and optional FileReference -->
	<xsl:template match="Step[(@id='1' or @id='164') and Calculated]">
		<xsl:variable name="QuotedFileScriptRef" select="Calculated/Calculation/text()"/>
		<xsl:variable name="FileScriptRef">
			<xsl:value-of select="substring($QuotedFileScriptRef,2,string-length($QuotedFileScriptRef) - 2)"/>
		</xsl:variable>
		<xsl:variable name="File" select="substring-before($FileScriptRef,'::')"/>
		<xsl:variable name="Script">
			<xsl:choose>
				<xsl:when test="contains($FileScriptRef,'::')">
					<xsl:value-of select="substring-after($FileScriptRef,'::')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$FileScriptRef"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- OUTPUT -->
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:if test="$File!=''">
				<!-- Reference FileReference simply by name - FM sorts it out -->
				<FileReference name="{$File}"/>
			</xsl:if>
			<!-- Reference Script simply by name - FM sorts it out -->
			<Script id="0" name="{$Script}"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
