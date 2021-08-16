<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XML2_Text.Lines_ConvertFieldsToLayoutText.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	Returns the names of all layout fields in <<>>.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2021
	2021-04-29 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
		<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/">
		<xsl:for-each select="//Object/FieldObj">
			<xsl:sort select="parent::Object/parent::GroupButtonObj/parent::Object/Bounds/@top div 5" data-type="number"/>
			<xsl:sort select="parent::Object/Bounds/@top div 5" data-type="number"/>
			<xsl:sort select="parent::Object/parent::GroupButtonObj/parent::Object/Bounds/@left div 1" data-type="number"/>
			<xsl:sort select="parent::Object/Bounds/@left div 1" data-type="number"/>

				<xsl:value-of select="concat('&lt;&lt;',Name,'&gt;&gt;')"/>

		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
