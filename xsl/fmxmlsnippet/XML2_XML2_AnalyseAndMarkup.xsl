<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XML2_XML2_AnalyseAndMarkup.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied fmp12 layout objects
	
	

	===== CHANGES HISTORY =====
	20150417 MrW v1
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.Substitute.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.cssText.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- remove LocalCSS tag -->
	<xsl:template match="LocalCSS | FullCSS">
		<xsl:copy>
			<xsl:call-template name="fn.cssText.markup.CSS-Rules">
				<xsl:with-param name="css">
					<xsl:call-template name="fn.cssText.normalize">
						<xsl:with-param name="css" select="text()"/>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
