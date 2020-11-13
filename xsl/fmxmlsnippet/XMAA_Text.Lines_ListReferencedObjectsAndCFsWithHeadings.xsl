<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMAA_Text.Lines_ListReferencedObjectsAndCFsWithHeadings.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: any FileMaker Clipboard content
	
	Returns a list of all referenced objects.
	
	Custom functions must be stored in fmxmlsnippet1.xml!
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2013-09-13 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XMAA_Text.Lines_ListReferencedObjects.xsl"/>
	<!-- ===== PARAMETERS ===== -->
	<xsl:param name="withHeadings" select="'True'"/>
	<xsl:param name="withCustomFunctions" select="'True'"/>
</xsl:stylesheet>
