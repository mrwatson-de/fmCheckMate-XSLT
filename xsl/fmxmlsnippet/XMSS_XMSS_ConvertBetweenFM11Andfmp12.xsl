<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_ConvertBetweenFM11Andfmp12.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: Copied scripts or script-steps.
	
	Converts scripts or script-steps between FM11 and fmp12 AND VICE-VERSA.
	
	Relevance of this XSLT:
	
	   XML is FM11 Script step  =>  75%

	@XsltRelevanceXpath="
	  75 * number(not(not( //Step[@id=89 and @name='Comment' or //ButtonCaptions or //NotWinStep]  )))
	"
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2014-09-29 MrW: Fixed bug that hadcrept in after refactoring
	2013-09-13 MrW: Commit Records/Requests ESSForceCommit and NewWndStyles
	 :              LOTS of changes
	2011-04-16 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.serializeXML.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.parseXML.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XMSS_XMSS_ConvertBetweenFM11Andfmp12.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="fmp12" select="//Step[@id*1&gt;152] or Step[@id='131']/DialogOptions or //Step[@id='87']/Buttons or //NewWndStyles or //ESSForceCommit"/>
	<xsl:variable name="newrecord" select="$RETURN"/>

</xsl:stylesheet>
