<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMAA_Text_ShowFmCheckMateXsltLibraryVersion.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: any FileMaker Clipboard content
	
	Returns the version of this library.
	
	ISSUE: needs a repository to automate the date.
	
	===== CHANGES HISTORY =====
	2018-08-28 MrW: Version 1.1.1 GitHub release :)
	2018-08-13 MrW: Version 1.1 File name corrected
	2015-01-23 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/">
		<xsl:value-of select="2018-08-28 03:00:00"/>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
