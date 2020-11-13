<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_SelectStepsContainingFIXME.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied field or table definitions
	
	Returns all Script steps that contain 'FIXME'.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2013-09-09 MrW: Clone templates centralized in _inc/inc.Clone.xsl
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- don't clone Groups not containing the pSearchString -->
	<xsl:template match="//Group[not(ancestor::Step) and not(contains(.,'FIXME'))]"/>
	<!-- don't clone Scripts not containing the pSearchString -->
	<xsl:template match="//Script[not(ancestor::Step) and not(contains(.,'FIXME'))]"/>
	<!-- don't clone Steps not containing the pSearchString -->
	<xsl:template match="//Step[not(ancestor::Step) and not(contains(.,'FIXME'))]"/>
</xsl:stylesheet>