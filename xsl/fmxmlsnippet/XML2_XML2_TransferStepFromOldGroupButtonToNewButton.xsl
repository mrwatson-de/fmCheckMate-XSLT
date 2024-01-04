<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XML2_XML2_TransferStepFromOldGroupButtonToNewButton.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	Moves the step from old to new buttons, by removing and replacing the step on the new button, if any.

	===== CHANGES HISTORY =====
	2019-09-26 MrW 
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Add Step to ButtonObj -->
	<xsl:template match="ButtonObj">
		<!--  -->
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:copy-of select="(//Step)[1]"/>
			<xsl:apply-templates select="*"/>
		</xsl:copy>
	</xsl:template>
	<!-- Remove any Steps -->
	<xsl:template match="Step" priority="1"/>
	<!-- Remove old GroupButton objects -->
	<xsl:template match="Object[GroupButtonObj]"/>
</xsl:stylesheet>
