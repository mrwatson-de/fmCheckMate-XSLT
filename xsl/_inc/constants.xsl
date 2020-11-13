<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: _inc/constants.xsl

	Defines useful constants to make stylesheet coding easier.
	
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2016-03-09 MrW: Added OPENQUOTES and CLOSEQUOTES
	2013-07-01 MrW: Corrected upper and lowercase chars (you can forget the apostrophes?! with NO error!?)
	2011-02-15 MrW: Version 1.0
	-->
	<!-- ===== CONSTANTS ===== -->
	<xsl:variable name="APOS">'</xsl:variable>
	<xsl:variable name="QUOT">"</xsl:variable>
	<xsl:variable name="OPENQUOTES" select="'“'"/>
	<!--Left Double Quotation Mark	-->
	<xsl:variable name="CLOSEQUOTES" select="'”'"/>
	<!--Right Double Quotation Mark -->
	<xsl:variable name="PIPE">|</xsl:variable>
	<xsl:variable name="TAB" select="'&#9;'"/>
	<xsl:variable name="LF" select="'&#10;'"/>
	<xsl:variable name="CR" select="'&#13;'"/>
	<xsl:variable name="CRLF" select="'&#13;&#10;'"/>
	<xsl:variable name="TABCRLF" select="'&#9;&#13;&#10;'"/>
	<xsl:variable name="WHITE_SPACE" select="' &#9;&#13;&#10;'"/>
	<xsl:variable name="NBSP" select="'&#160;'"/>
	<xsl:variable name="RETURN" select="$LF"/>
	<xsl:variable name="LOWERCASE_CHARS" select="'abcdefghijklmnopqrstuvwxyzäöüéèëç'"/>
	<xsl:variable name="UPPERCASE_CHARS" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜÉÈËÇ'"/>
	<!-- These constant variables are needed to help find field names in calculations -->
	<xsl:variable name="CALC_FIELD_BOUNDARY_CHARS">
		<!-- The list of characters - inc. space and tab - which may border a field name -->
		<xsl:text disable-output-escaping="yes"> 	
	&amp;+-*/^=&gt;&lt;≠≤≥()[]:;</xsl:text>
	</xsl:variable>
	<xsl:variable name="CALC_FIELD_BOUNDARY_BARS">
		<!-- A list of pipe characters to replace the boundary characters with -->
		<xsl:text disable-output-escaping="yes">|||||||||||||||||||||||||</xsl:text>
	</xsl:variable>
</xsl:stylesheet>
