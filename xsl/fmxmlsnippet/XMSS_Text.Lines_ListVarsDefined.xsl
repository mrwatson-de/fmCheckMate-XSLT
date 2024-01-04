<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSS_Text.Lines_ListVarsDefined.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or scriptsteps
	
	Returns all variables defined by Set Variable script step.
	
	===== CHANGES HISTORY =====
	2011-09-30 MrW: inc/constants.xsl
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.SubstringFunctions.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<xsl:variable name="and_EN" select="' and '"/>
	<xsl:variable name="kOR_EN" select="' or '"/>
	<xsl:variable name="kXOR_EN" select="' xor '"/>
	<xsl:variable name="and_GUI" select="' UND '"/>
	<xsl:variable name="or_GUI" select="' ODER '"/>
	<xsl:variable name="xor_GUI" select="' XODER '"/>
	<xsl:variable name="VariablenameEndWords" select="concat($kXOR_EN,'|',$and_EN,'|',$kOR_EN,'|',$xor_GUI,'|',$and_GUI,'|',$or_GUI,'|')"/>
	<xsl:variable name="VariablenameEndChars" select="'+-*/^([{;}])=≠≤≥&lt;&gt;&amp;&#9;&#10;&#13;'"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Script step 141. Set Variable -->
	<xsl:template match="Step[@id='141' and @enable='True']">
		<xsl:value-of select="Name"/>
		<xsl:value-of select="'='"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:apply-templates select="*"/>
	</xsl:template>
	<xsl:template match="Calculation[contains(text(),'$')]">
		<!--
		<xsl:value-of select="'Calculation='"/>
		<xsl:value-of select="'´'"/>
		<xsl:value-of select="."/>
		<xsl:value-of select="'´'"/>
		<xsl:value-of select="$newrecord"/>
		-->
		<xsl:call-template name="ListVariables">
			<xsl:with-param name="text" select="text()"/>
		</xsl:call-template>
	</xsl:template>
	<!-- ListVariables -->
	<xsl:template name="ListVariables">
		<xsl:param name="text"/>
		<!-- -->
		<xsl:if test="contains($text,'$')">
			<xsl:call-template name="ListVariables_recurse">
				<xsl:with-param name="text" select="concat(translate(substring-after($text,'$'),$VariablenameEndChars,'+++++++++++++++++++++++++'),'+')"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<xsl:template name="ListVariables_recurse">
		<xsl:param name="text"/>
		<!-- 
		<xsl:value-of select="concat('        DEBUG: ListVariables_recurse(', $text,')')"/>
		<xsl:value-of select="$newrecord"/>
		-->
		<xsl:variable name="varNameCandidate" select="substring-before($text,'+')"/>
		<xsl:choose>
			<xsl:when test="$varNameCandidate=''">
				<!-- it was a single dollar - ignore -->
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="varName">
					<xsl:choose>
						<xsl:when test="contains($varNameCandidate,' ')">
							<xsl:call-template name="fn.substring-before-first-Multiple-QnD">
								<xsl:with-param name="text" select="concat($varNameCandidate,' ')"/>
								<xsl:with-param name="searchValues" select="$VariablenameEndWords"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$varNameCandidate"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:value-of select="'!$'"/>
				<xsl:value-of select="normalize-space($varName)"/>
				<xsl:value-of select="''"/>
				<xsl:value-of select="$newrecord"/>
				<xsl:call-template name="ListVariables_recurse">
					<xsl:with-param name="text" select="substring-after(substring($text,string-length($varName)+1),'$')"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
