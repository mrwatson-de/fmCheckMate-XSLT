<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: _inc/fn.AllFunctions.xsl  

	Defines all necessary functions to make stylesheet coding easier.
	Where possible functions have been modelled on FileMaker functions.
	
	Files with name fn.functionname.xsl contain general functions.
	Files with name fm.functionname.xsl are functions which mimic FileMaker functions.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2011-2016
	2013-05-16 MrW: Version 1.0
	-->
	<xsl:include href="fn.CommonFunctions.xsl"/>
	<!--  -->
	<xsl:include href="fn.parseXML.xsl"/>
	<xsl:include href="fn.serializeXML.xsl"/>
</xsl:stylesheet>
