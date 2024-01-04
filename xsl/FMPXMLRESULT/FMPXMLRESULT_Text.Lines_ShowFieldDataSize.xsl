<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xslt="urn:thisTemporaryNamespaceWillBeRemoved"
	xmlns:default="http://www.filemaker.com/fmpxmlresult" version="1.0">
	<!-- xmlns:xslt=""
 -->
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: FMPXMLRESULT_Text.Lines_ShowFieldDataSize.xsl

	XML-Source: FMPXMLRESULT.xml
	XML-Grammar: FMPXMLRESULT
	XML-Content: At least one record of data
	
	Lists the size of the data for each field.
	
	
	===== CHANGES HISTORY =====
	2019-09-02 MrW: Version 1.0.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/">
		<xsl:for-each select="/default:FMPXMLRESULT/default:RESULTSET[1]/default:ROW[1]/default:COL">
<!--			<xsl:sort select="string-length(default:DATA/text())" order="descending"/>-->
			<xsl:variable name="pos" select="position()"/>
			<xsl:value-of select="/default:FMPXMLRESULT/default:METADATA[1]/default:FIELD[$pos]/@NAME"/>
			<xsl:value-of select="$delimiter"/>
			<xsl:value-of select="string-length(default:DATA/text())"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
