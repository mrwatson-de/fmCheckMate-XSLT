<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== inc.Clone.xsl TEMPLATES TO CLONE AN XML DOCUMENT ===== -->
	<!-- empty element: copy and shorten -->
	<xsl:template match="*[count(node())=0]" priority="-1">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
		</xsl:copy>
	</xsl:template>
	<!-- match and copy every node...and continue processing recursively -->
	<xsl:template match="@*|node()" priority="-1">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
