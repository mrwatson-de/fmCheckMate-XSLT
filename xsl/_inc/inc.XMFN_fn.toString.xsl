<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: inc.XMFN_fn.toString.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	toString function for custom functions.
	
	===== CHANGES HISTORY =====
	2017-10-02 MrW v0.1
	-->
	<!-- ===== TEMPLATES WITH MODES ===== -->
	<!--
	 ! CustomFunction.toString
	 ! Writes the name, id and position of a custom function
	 !-->
	<xsl:template match="CustomFunction" mode="toString">
		<xsl:value-of select="concat('Custom Function ',@name,' {',@id,'}',' #',1 + count(preceding-sibling::CustomFunction) )"/>
	</xsl:template>
</xsl:stylesheet>
