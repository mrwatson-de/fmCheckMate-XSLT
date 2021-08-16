<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="text" version="1.0" encoding="UTF-8"/>
	<xsl:template match="*[@name]">
		<xsl:if test="string-length(@name) &gt; 100">:
			<xsl:value-of select="name(.)"/>
			<xsl:value-of select="'&#x09;'"/>
			<xsl:value-of select="@name"/>
			<xsl:value-of select="'&#x09;-&gt;&#x09;'"/>
			<xsl:value-of select="substring(@name,1,100)"/>
			<xsl:value-of select="'&#x0D;'"/>
		</xsl:if>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
