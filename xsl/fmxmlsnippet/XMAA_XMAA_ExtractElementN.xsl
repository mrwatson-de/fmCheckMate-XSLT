<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMAA_XMAA_ExtractElementN.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied filemaker objects

	Keeps the nth element of the XML.
	
	Use to split a single XML containing multiple elements into multiple XMLs each with a single element!
	
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2020-09-03 MrW: Let's split!
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:param name="n" select="1"/>
	<!-- ===== TEMPLATES ===== -->
	<xsl:template match="/*">
		<xsl:copy>
			<!-- Within the root element + attributes -->
			<xsl:copy-of select="@*"/>
			<!-- …keep only node $n -->
			<xsl:copy-of select="*[number($n)]"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
