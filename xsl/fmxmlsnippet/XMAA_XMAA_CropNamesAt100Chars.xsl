<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2021 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMAA_XMAA_CropNamesAt100Chars.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied filemaker objects

	Makes an exact copy of everything - except NAMES longer than 100 are cropped to 100
	
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2021
	2021-02-25 MrW: 
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<!--xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/-->
	<xsl:param name="NameLengthMax" select="100"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Field name - DON'T COPY -->
	<xsl:template match="*[@name]">
		<xsl:choose>
			<xsl:when test="string-length(@name) > $NameLengthMax">
				<xsl:copy>
					<xsl:attribute name="name">
						<xsl:value-of select="substring(@name,1,$NameLengthMax)"/>
					</xsl:attribute>
					<xsl:apply-templates select="@*[name()!='name']"/>
					<xsl:apply-templates select="*"/>
				</xsl:copy>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@*|node()"/>
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- match and copy every node...and continue processing recursively -->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
