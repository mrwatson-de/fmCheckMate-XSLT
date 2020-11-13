<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: inc.XMSC_fn.toString.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts
	
	toString function for scripts.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2019-05-27 MrW v0.1
	-->
	<!-- ===== TEMPLATES WITH MODES ===== -->
	<!--
	 ! Script.toString
	 ! Writes the name, id and position of a script
	 !-->
	<xsl:template match="Script" mode="toString">
		<!-- Script name & id -->
		<xsl:value-of select="concat('Script ','&#34;',@name,'&#34;',' {id:',@id,'}')"/>
		<!-- Position in group -->
		<xsl:if test="@includeInMenu">
			<xsl:value-of select="concat(' #',1 + count(preceding-sibling::Script) )"/>
			<xsl:if test="parent::Group/@name">
				<xsl:value-of select="concat(' in ', ancestor::Group/@name )"/>
			</xsl:if>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
