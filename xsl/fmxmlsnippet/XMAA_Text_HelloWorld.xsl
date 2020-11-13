<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMAA_Text_HelloWorld.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: any FileMaker Clipboard content
	
	Ignores the input and just returns "Hello World".
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2018-08-28 MrW: Version 1.0.1 Improved output message.
	2018-06-06 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/">
		<xsl:value-of select="'Hello World!'"/>
		<xsl:value-of select="'&#x0a;&#x0a;&#x0a;'"/>
		<xsl:value-of select="concat('(The XML you copied has ', count(//*), ' element nodes.)')"/>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
