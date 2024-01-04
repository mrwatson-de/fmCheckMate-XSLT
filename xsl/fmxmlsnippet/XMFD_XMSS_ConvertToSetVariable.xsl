<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMFD_XMSS_ConvertToSetVariable.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied fields or tables

	Converts calculated fields to set variable script steps.

	===== CHANGES HISTORY =====
	2014-06-24 MrW: Internationalized
	2011-09-30 MrW: inc/constants.xsl
	2011-08-10 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Match the root -->
	<xsl:template match="/">
		<fmxmlsnippet type="FMObjectList">
			<xsl:apply-templates select="*/*"/>
		</fmxmlsnippet>
	</xsl:template>
	<!-- Match all Fields definitions -->
	<xsl:template match="//Field[not(ancestor::Field)]">
		<Step enable="True" id="141">
			<Value>
				<Calculation>
					<xsl:value-of select="Calculation/text()"/>
				</Calculation>
			</Value>
			<Repetition>
				<Calculation><![CDATA[1]]></Calculation>
			</Repetition>
			<Name>
				<xsl:value-of select="concat('$',@name)"/>
			</Name>
		</Step>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
