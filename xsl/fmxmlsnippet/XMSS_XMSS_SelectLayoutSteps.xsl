<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_SelectLayoutSteps.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied script-steps or scripts
	
	Removes all script steps except for layout relevant script steps - Go to Layout + Go to Related Record
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2016-03-14 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Remove Groups that do not contain layout script steps-->
	<xsl:template match="Group[not(//Script/Step[@id='6']) and not(//Script/Step[@id='74'])]"/>
	<!-- Remove scripts that do not contain layout script steps-->
	<xsl:template match="Script[not(ancestor::Step) and not(Step[@id='6']) and not(Step[@id='74'])]"/>
	<!-- Remove unwanted script steps-->
	<xsl:template match="Step[not(ancestor::Step) and @id!='6' and @id!='74']"/>
</xsl:stylesheet>
