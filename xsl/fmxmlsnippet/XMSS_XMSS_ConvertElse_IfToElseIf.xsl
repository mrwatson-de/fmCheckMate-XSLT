<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_ConvertElse_IfToElseIf.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Replaces 
		Else
			If ( condition )
	with
		Else if ( condition )
	
	Sorry, until I work out how to do it in XSLT, I'm afraid you have to remove the closing End Ifs yourself!
	
	Note that:
	
	- there may be NO blank or comment lines between the else and the if!
	- this XSLT will also convert Else-Ifs in cases, where it is not suitable, such as: 
	
		Else
			If (condition)
				:
			End If
			#More Stuff here
		End If
	
	
	WHAT THIS XSLT IDEALLY SHOULD BE DOING:
	
	Replace
		If (condition)
			#A
n		Else
			(Empty lines)
n+1			If (condition)
				#B
			Else
				If ( condition )
						#C
				End If
				#D(Empty lines)
m-1			End If
		#E(Empty lines)
m		End If
		#F

	with
		If (condition)
			#A
		Else If (condition)
			#B
		Else If ( condition )
			#C
		#D
		#E
		End If
		#F
	
	…BUT ONLY WHERE #D and #E do not exist, or are empty lines!
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2016-12-29 MrW: Version 1.1 Only convert else-if where the else + if are directly next to each other!
	2013-09-09 MrW: Clone templates centralized in _inc/inc.Clone.xsl
	2012-06-11 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Remove an else, if it is directly followed by an if-->
	<xsl:template match="Step[@id='69' and following-sibling::Step[1]/@id='68']"/>
	<!-- Convert if (if preceded by an else) to else if-->
	<xsl:template match="Step[@id='68' and preceding-sibling::Step[1]/@id='69']">
		<xsl:variable name="enable" select="@enable"/>
		<!--  -->
		<Step enable="{$enable}" id="125" name="">
			<xsl:copy-of select="Calculation"/>
		</Step>
	</xsl:template>
</xsl:stylesheet>
