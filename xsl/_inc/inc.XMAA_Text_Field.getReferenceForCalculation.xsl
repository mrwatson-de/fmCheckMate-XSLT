<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: _inc/inc.XMAA_Text_Field.getReferenceForCalculation.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: selected Field
	
	Converts the selected Field into a reference to this field for a calculation.
	
	Used by 
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2013	
	2013-11-14 MrW: v1.0
	-->
	<!-- ===== NAMED TEMPLATES ===== -->
	<!-- Field.getReferenceForCalculation -->
	<xsl:template match="Field" mode="getReferenceForCalculation">
		<xsl:if test="@table">
			<xsl:value-of select="concat(@table,'::')"/>
		</xsl:if>
		<xsl:value-of select="@name"/>
		<xsl:choose>
			<xsl:when test="@repetition=1 or number(Repetition/Calculation)=1">
				<!-- [1] don't output -->
			</xsl:when>
			<xsl:when test="@repetition &gt; 1">
				<!-- [2+] output -->
				<xsl:value-of select="concat('[',@repetition,']')"/>
			</xsl:when>
			<xsl:when test="Repetition/Calculation">
				<!-- [1+1] Calculation -->
				<xsl:value-of select="concat('[',Repetition/Calculation)"/>
				<xsl:if test="contains(Repetition/Calculation,'//')">
					<xsl:value-of select="$return"/>
				</xsl:if>
				<xsl:value-of select="']'"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
