<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2022 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_UncommentBrokenCalculations.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Removes the /* .... */ from arround calcaultions that have been commented out

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2022
	2022-09-14 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	
	<!-- ===== TEMPLATES ===== -->
	<!-- remove /* ... */ from calculation text -->
	<xsl:template match="Calculation/text()[substring(.,1,2)='/*' and substring(.,string-length(.) - 1)='*/']">
		<xsl:value-of select="substring(.,3,string-length(.) - 4)"/>
	</xsl:template>
</xsl:stylesheet>
