<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2014 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_SetFieldIfNotEmptyValue.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Wraps each Set Field X = Y in an if statement
	
	If [not Exact(Field X ; Y)]
	    Set Field X = Y
	End If

        ===== SEE ALSO =====
        
        XMSS_XMSS_SetFieldIfNotAlreadyEqual.xsl
        XMSS_Text_ConvertSetFieldsToPredicateEqual.xsl
        XMSS_Text_ConvertSetFieldsToPredicateExact.xsl
        
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2011-2014	
	2013-11-14 MrW: v1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XMAA_Text_Field.getReferenceForCalculation.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Script step 76 Set Field -->
	<xsl:template match="//Step[@id='76']">
		<xsl:variable name="enable" select="@enable"/>
		<!--  -->
		<Step enable="{$enable}" id="68"><Calculation>
			<xsl:value-of select="'not IsEmpty( '"/>
			<xsl:value-of select="Calculation/text()"/>
			<xsl:if test="contains(Calculation/text(),'//')">
				<xsl:value-of select="$newrecord"/>
			</xsl:if>		
			<xsl:value-of select="' )'"/>
		</Calculation></Step>
		<xsl:copy-of select="."/>
		<Step enable="{$enable}" id="70"/>
	</xsl:template>
</xsl:stylesheet>
