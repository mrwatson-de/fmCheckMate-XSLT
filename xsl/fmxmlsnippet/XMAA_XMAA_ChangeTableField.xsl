<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- ===== PARAMETERS ===== -->
	<xsl:param name="pTable"/>
	<xsl:param name="pField"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Change the field name, if specified -->
	<xsl:template match="Field">
		<xsl:copy>
			<xsl:attribute name="name">
				<xsl:choose>
					<xsl:when test="$pField=''">
						<!-- keep -->
						<xsl:value-of select="@name"/>
					</xsl:when>
					<xsl:otherwise>
						<!-- replace -->
						<xsl:value-of select="$pField"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:attribute name="table">
				<xsl:choose>
					<xsl:when test="$pTable=''">
						<!-- keep -->
						<xsl:value-of select="@table"/>
					</xsl:when>
					<xsl:otherwise>
						<!-- replace -->
						<xsl:value-of select="$pTable"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<!-- copy rest of tag -->
			<xsl:apply-templates select="@*[name(.)!='name' and name(.)!='table']"/>
			<xsl:apply-templates select="node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>