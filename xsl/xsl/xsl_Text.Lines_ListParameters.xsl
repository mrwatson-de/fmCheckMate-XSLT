<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: xsl_Text.Lines_ListParameters.xsl

	XML-Source: any.xsl
	XML-Grammar: xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	XML-Content: any xslt stylesheet
	
	Lists the parameters of a stylesheet.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2011-2016
	2011-02-09 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<!-- ===== TEMPLATES ===== -->
	<xsl:template match="/xsl:stylesheet">
		<xsl:for-each select="xsl:param">
			<xsl:if test="position() &gt; 1">
				<xsl:value-of select="';'"/>
			</xsl:if>
			<xsl:value-of select="@name"/>
		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
