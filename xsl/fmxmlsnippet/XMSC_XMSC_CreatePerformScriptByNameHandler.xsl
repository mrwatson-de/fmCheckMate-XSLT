<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSC_XMSC_CreatePerformScriptByNameHandler.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: any copied objects
	
	Creates the script steps for the Perform Script By Name handler script.
	
	===== CHANGES HISTORY =====
	2017-03-18 MrW: Version 0.1
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Remove old code -->
	<xsl:template match="Step[preceding-sibling::Step/Text/text()='##START##' and following-sibling::Step/Text/text()='##END##']"/>
	<!-- Add new code -->
	<xsl:template match="Step[contains(Text,'##START##')]">
		<xsl:variable name="lo" select="number(preceding-sibling::Step[@id='141' and Name='$nMin']/Value)"/>
		<xsl:variable name="hi" select="number(preceding-sibling::Step[@id='141' and Name='$nMax']/Value)"/>
		<!-- -->
		<Step enable="True" id="89" name="comment">
			<Text>##START##</Text>
		</Step>
		<xsl:call-template name="CreateScriptSteps">
			<xsl:with-param name="lo" select="$lo"/>
			<xsl:with-param name="hi" select="$hi"/>
			<xsl:with-param name="n" select="0"/>
		</xsl:call-template>
	</xsl:template>
	<!-- CreateScriptSteps -->
	<xsl:template name="CreateScriptSteps">
		<xsl:param name="lo"/>
		<xsl:param name="hi"/>
		<xsl:param name="n"/>
		<!-- -->
		<xsl:variable name="sum" select="($hi + $lo)"/>
		<xsl:variable name="mid" select="($sum + $sum mod 2) div 2"/>
		<!-- -->
		<!--Step enable="True" id="89" name="comment">
			<Text>
				<xsl:value-of select="concat($lo,' … ', $mid ,' … ', $hi)"/>
			</Text>
		</Step-->
		<xsl:choose>
			<!--xsl:when test="$n &gt; 9"/-->
			<xsl:when test="$hi - $lo = 0">
				<!-- NIX -->
			</xsl:when>
			<xsl:when test="$hi - $lo = 1">
				<!-- Perform Script lo-->
				<Step enable="True" id="1" name="Perform Script">
					<FileReference id="1" name="ExternalFile">
						<UniversalPathList>file:ExternalFile</UniversalPathList>
					</FileReference>
					<Calculation><![CDATA[$p]]></Calculation>
					<Script id="{$lo}"/>
				</Step>
			</xsl:when>
			<xsl:otherwise>
				<!-- if  [ $n < $mid ] -->
				<Step enable="True" id="68" name="If">
					<Calculation>
							<xsl:value-of select="concat('$n &lt; ',$mid)"/>
					</Calculation>
				</Step>
				<!--Step enable="True" id="89" name="comment">
					<Text>
						<xsl:value-of select="$lo"/>
						<xsl:if test="$mid -1 != $lo">
							<xsl:value-of select="concat(' … ',$mid - 1)"/>
						</xsl:if>
					</Text>
				</Step-->
				<xsl:call-template name="CreateScriptSteps">
					<xsl:with-param name="lo" select="$lo"/>
					<xsl:with-param name="hi" select="$mid"/>
					<xsl:with-param name="n" select="$n + 1"/>
				</xsl:call-template>
				<!-- else -->
				<Step enable="True" id="69" name="Else"/>
				<!--Step enable="True" id="89" name="comment">
					<Text>
						<xsl:value-of select="$mid"/>
						<xsl:if test="$mid != $hi - 1">
							<xsl:value-of select="concat(' … ',$hi - 1)"/>
						</xsl:if>
					</Text>
				</Step-->
				<xsl:call-template name="CreateScriptSteps">
					<xsl:with-param name="lo" select="$mid"/>
					<xsl:with-param name="hi" select="$hi"/>
					<xsl:with-param name="n" select="$n + 1"/>
				</xsl:call-template>
				<!-- End If -->
				<Step enable="True" id="70" name="End If"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
