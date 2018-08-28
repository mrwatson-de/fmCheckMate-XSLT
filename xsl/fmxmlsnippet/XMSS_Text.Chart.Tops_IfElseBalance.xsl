<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_Text.Chart.Tops_IfElseBalance.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps

	Charts the ratio of If-parts to Else parts.

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2011-2016
	2011-09-30 MrW: inc/constants.xsl
	2011-08-10 MrW: Version 0.9
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.StepIDs.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<xsl:key name="keyIfStepsAtDepth" match="//Step[@id='68' or @id='125' or @id='70']" use="count(preceding-sibling::Step[@id='68']) - count(preceding-sibling::Step[@id='70'])"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/">
		<xsl:for-each select="//Step[@id='69']">
			<!-- -->
			<xsl:variable name="depthIf" select="count(preceding-sibling::Step[@id=$ID_IF]) - count(preceding-sibling::Step[@id=$ID_END_IF])"/>
			<xsl:variable name="posMatchingIf" select="count(preceding-sibling::Step[(@id=$ID_IF or @id=$ID_ELSE_IF) and count(preceding-sibling::Step[@id=$ID_IF]) - count(preceding-sibling::Step[@id=$ID_END_IF]) = $depthIf - 1][1]/preceding-sibling::Step)"/>
			<xsl:variable name="posMatchingEndIf" select="count(following-sibling::Step[(@id=$ID_IF or @id=$ID_ELSE_IF) and count(following-sibling::Step[@id=$ID_IF]) - count(following-sibling::Step[@id=$ID_END_IF]) = $depthIf - 1][1]/following-sibling::Step)"/>
			<xsl:variable name="backCount" select="count(preceding-sibling::Step) - $posMatchingIf"/>
			<xsl:variable name="forwardCount" select="count(following-sibling::Step) - $posMatchingEndIf"/>
			<xsl:if test="$backCount&gt;0 and $forwardCount&gt;0">
				<!-- -->
				<xsl:value-of select="../@name"/>
				<xsl:value-of select="':'"/>
				<xsl:value-of select="1+count(preceding-sibling::Step)"/>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="$backCount div $forwardCount"/>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="$forwardCount"/>
				<xsl:value-of select="$newrecord"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
