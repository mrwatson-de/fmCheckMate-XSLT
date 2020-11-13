<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMFD_XMFD_SortByType.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied field or table definitions
	
	Sorts the fields by type. There is sadly no table id available, so we can't sort the tables!
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2013-05-15 MrW: Version 1.1 Improved order to match FileMaker (exactly?)
	2013-05-07 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/fmxmlsnippet">
		<fmxmlsnippet type="FMObjectList">
			<xsl:choose>
				<xsl:when test="BaseTable">
					<!-- Sort fields *within* each table -->
					<xsl:for-each select="BaseTable">
						<xsl:sort select="@name"/>
						<!--  -->
						<xsl:copy>
							<xsl:for-each select="Field">
								<xsl:sort select="concat(translate(substring(@fieldType,1,1),'NCS','123'),translate(substring(@dataType,2,1),'euaio','12345'),substring(concat(@dataType,' '),5,1),translate(substring(Storage/@global,1,1),'FT','12'),@name)"/>
								<!--  -->
								<xsl:copy-of select="."/>
							</xsl:for-each>
						</xsl:copy>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<xsl:for-each select="Field">
						<xsl:sort select="concat(translate(substring(@fieldType,1,1),'NCS','123'),translate(substring(@dataType,2,1),'euaio','12345'),substring(concat(@dataType,' '),5,1),translate(substring(Storage/@global,1,1),'FT','12'),@name)"/>
						<!--  -->
						<xsl:copy-of select="."/>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
		</fmxmlsnippet>
	</xsl:template>
</xsl:stylesheet>
