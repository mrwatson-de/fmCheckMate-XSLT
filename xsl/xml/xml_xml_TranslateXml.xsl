<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: xml_xml_TranslateXml.xsl

	XML-Source: any
	XML-Grammar: any
	XML-Content: any
	
	Renames elements and attributes in the XML, based on the supplied translations.
	
	@param translations - a white-space separated list of element name and @attribute name translations in the form [@]oldname=newname (Note: no @in the new name)
	                      for example, the translations for a stylesheet into german could start somehting like this:
	                      "stylesheet=Formatvorlage @version=Version output=Ausgabe @method=Methode @encoding=Enkodierung template=Vorlage"
	
	===== CHANGES HISTORY =====
	2019-09-05 RW: Version 0.1
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no" omit-xml-declaration="no"/>
	<!-- ===== PARAMETERS ===== -->
	<xsl:param name="translations"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="spaceTranslationsSpace" select="concat( ' ',normalize-space($translations),' ')"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Rename elements-->
	<xsl:template match="*">
		<xsl:variable name="suche" select="concat(' ',name(),'=')"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="contains($spaceTranslationsSpace,$suche)">
				<!-- rename element-->
				<xsl:variable name="newName" select="substring-before(substring-after($spaceTranslationsSpace,$suche),' ')"/>
				<xsl:element name="{$newName}">
					<xsl:apply-templates select="*|@*|node()"/>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<!-- clone element-->
				<xsl:copy>
					<xsl:apply-templates select="*|@*|node()"/>
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Rename attributes-->
	<xsl:template match="@*">
		<xsl:variable name="suche" select="concat(',@',name(),'=')"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="contains($spaceTranslationsSpace,$suche)">
				<!-- rename attribute-->
				<xsl:variable name="newName" select="substring-before(substring-after($spaceTranslationsSpace,$suche),' ')"/>
				<xsl:attribute name="{$newName}">
					<xsl:apply-templates select="text()"/>
				</xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<!-- clone attribute-->
				<xsl:copy-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	===== CLONE EVERYTHING ELSE =====
	-->
	<!--
		match and copy every node...and continue processing recursively, but
		with a low priority, so that other (normal-priority) templates are applied first
	-->
	<xsl:template match="@*|node()" priority="-9">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>