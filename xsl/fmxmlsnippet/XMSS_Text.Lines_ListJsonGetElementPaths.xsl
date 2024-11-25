<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
    <!-- ===== AUTHOR =====

    (c) 2024 @mrwatson-de

    ===== PURPOSE =====

    XSL-File: XMSS_Text.Lines_ListJsonGetElementPaths.xsl

    XML-Source: fmxmlsnippet.xml
    XML-Grammar: fmxmlsnippet
    XML-Content: copied scripts or scriptsteps
    
    Returns a list of JSON paths / parameter names from the second parameter of JSONGetElement function in Set Variable steps.
    
    ===== CHANGES HISTORY =====
    2024-11-22 MrW: V1.0 New
    -->
    <!-- ===== HEAD ===== -->
    <xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
    <xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
    <!-- ===== VARIABLES ===== -->
    <xsl:variable name="delimiter" select="$TAB"/>
    <xsl:variable name="newrecord" select="$RETURN"/>
    <!-- ===== TEMPLATES ===== -->

    <!-- Template to extract the second parameter of JSONGetElement -->
    <xsl:template name="extract-parameter-name">
        <xsl:param name="calculation"/>
        <!-- Handle case with concatenated expressions and quotes in the first parameter -->
        <xsl:value-of select="substring-before(substring-after(substring-after($calculation, 'JSONGetElement'), '&quot;'), '&quot;')"/>
        <!--
					<xsl:call-template name="extract-parameter-name">
            <xsl:with-param name="calculation" select="substring-after($calculation, 'JSONGetElement')"/>
        </xsl:call-template>
				-->
    </xsl:template>

    <!-- Script step 141. Set Variable with JSONGetElement -->
    <xsl:template match="Step[@id='141'][contains(Value/Calculation, 'JSONGetElement')]">
        <xsl:if test="@enable='False'">
            <xsl:value-of select="'// '" />
        </xsl:if>
        <!-- Call the named template to extract the second parameter of JSONGetElement -->
        <xsl:call-template name="extract-parameter-name">
            <xsl:with-param name="calculation" select="Value/Calculation"/>
        </xsl:call-template>
        <xsl:value-of select="$newrecord"/>
    </xsl:template>

    <!-- ignore all other text -->
    <xsl:template match="text()"/>
    
</xsl:stylesheet>
