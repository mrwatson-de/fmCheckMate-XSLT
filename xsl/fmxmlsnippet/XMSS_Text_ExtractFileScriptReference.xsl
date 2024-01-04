<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSS_Text_ExtractFileScriptReference.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: FMPReport
	XML-Content: DDR (Database Definition Report)
	
	Returns the referenced script "file::script".
	
	===== CHANGES HISTORY =====
	2019-12-09 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8"/>
	<!-- ===== TEMPLATES ===== -->
	<xsl:template match="//Step[1]/Script">
		<xsl:if test="../FileReference">
			<xsl:value-of select="../FileReference/@name"/>
		</xsl:if>
		<xsl:value-of select="'::'"/>
		<xsl:value-of select="@name"/>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
