<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_ChangeSortToTemporarySort.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied script-steps
	
	Disables Sort dialog "Keep Sort Order" Option.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2019-10-09 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Sort Records -->
	<xsl:template match="Step[@id=39]/SortList/@Maintain[.='True']">
		<xsl:attribute name="Maintain">
			<xsl:value-of select="'False'"/>
		</xsl:attribute>
	</xsl:template>
</xsl:stylesheet>
