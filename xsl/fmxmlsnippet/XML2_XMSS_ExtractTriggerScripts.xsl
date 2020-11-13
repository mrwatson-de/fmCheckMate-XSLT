<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XML2_XMSS_ExtractTriggerScripts.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	Returns the perform script steps from all script triggers.

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2013-08-31 MrW Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/fmxmlsnippet/Layout">
		<!--  -->
		<fmxmlsnippet type="FMObjectList">
			<xsl:for-each select="//Trigger/Script">
				<Step enable="True" id="1" name="Perform Script">
					<xsl:copy-of select=". "/>
				</Step>
			</xsl:for-each>
		</fmxmlsnippet>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
