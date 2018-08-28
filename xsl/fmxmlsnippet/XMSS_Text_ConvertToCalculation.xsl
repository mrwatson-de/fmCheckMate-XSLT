<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_Text_ConvertToCalculation.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Converts the script-based calculation to a FileMaker Calculation.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2011-2016
	2017-03-21 MrW: Version 0.9.1 Now parses thew calculation and renames variables
	2011-09-30 MrW: inc/constants.xsl
	2011-08-10 MrW: Version 0.9
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.Substitute.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="indent" select="'  '"/>
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<xsl:key name="KeySetVariableName" match="Step[@id='141']" use="Name/text()"/>
	<xsl:key name="KeySetFieldName" match="Step[@id='76']" use="concat(Field/@table,'::',Field/@name)"/>
	<xsl:key name="MixedKey" match="Step[@id='141' or @id='76']" use="concat(Name/text(),Field/@table,substring('::',1,2*count(Field/@name)),Field/@name)"/>
	<!--
	 !
	 ! ===== TEMPLATES =====
	 !
	 !-->
	<!-- Set Feldwert setzen-->
	<xsl:template match="/">
		<xsl:value-of select="'Let(['"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:apply-templates/>
		<xsl:value-of select="concat($indent,'vResult = FIXME')"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="'];'"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="concat($indent,'vResult')"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="')'"/>
	</xsl:template>
	<!-- Script step 89. Kommentar -->
	<xsl:template match="Step[@id='89']">
		<xsl:choose>
			<xsl:when test="contains(Text,$CR)">
				<xsl:value-of select="concat($indent,'/*',$newrecord,translate(Text/text(),$CR,$LF),$newrecord,'*/')" disable-output-escaping="yes"/>
			</xsl:when>
			<xsl:when test="Text">
				<xsl:value-of select="concat($indent,'/* ',translate(Text,$CRLF,' '),' */')"/>
			</xsl:when>
		</xsl:choose>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- Script step 141. Variable setzen -->
	<xsl:template match="Step[@id='141']">
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="'  '"/>
		<xsl:call-template name="GetCalculationVariableName">
			<xsl:with-param name="ScriptVariableName">
				<xsl:value-of select="Name/text()"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="' = '"/>
		<xsl:apply-templates select="Value/Calculation"/>
		<xsl:value-of select="' ;'"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- Script step 141. Feld setzen -->
	<xsl:template match="Step[@id='76']">
		<xsl:call-template name="GetCalculationVariableName">
			<xsl:with-param name="ScriptVariableName">
				<xsl:value-of select="concat(Field/@table,'::',Field/@name)"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="' = '"/>
		<xsl:apply-templates select="Calculation"/>
		<xsl:value-of select="' ;'"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- Script step 68. If -->
	<xsl:template match="Step[@id='68']">
		<xsl:value-of select="'Case('"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="Calculation"/>
		<xsl:if test="contains(Calculation,'//')">
			<xsl:value-of select="$newrecord"/>
		</xsl:if>
		<xsl:value-of select="';'"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- Script step 125. Else If -->
	<xsl:template match="Step[@id='125']">
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="';'"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="Calculation"/>
		<xsl:choose>
			<xsl:when test="contains(Calculation,'//')">
				<xsl:value-of select="$newrecord"/>
				<xsl:value-of select="';'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="' ;'"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- Script step 69. Else -->
	<xsl:template match="Step[@id='69']">
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="';'"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- Script step 70. End (if) -->
	<xsl:template match="Step[@id='70']">
		<xsl:value-of select="$newrecord"/>
		<xsl:value-of select="')'"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!--
	 ! Get Calculation With Renamed References
	 !-->
	<xsl:template match="Calculation">
		<!--xsl:value-of select="."/-->
		<xsl:call-template name="CorrectVariableReferences">
			<xsl:with-param name="Calc" select="text()"/>
		</xsl:call-template>
	</xsl:template>
	<!--
	 !
	 ! ===== NAMED TEMPLATES =====
	 !
	 !-->
	<!-- GetCalculationVariableName -->
	<xsl:template name="GetCalculationVariableName">
		<xsl:param name="ScriptVariableName"/>
		<xsl:choose>
			<xsl:when test="contains($ScriptVariableName,'::')">
				<!-- FULL Table::Field reference: prefix with v and replace '::' in name with TWO underscores-->
				<xsl:value-of select="concat('v',translate(substring($ScriptVariableName,1,1),$LOWERCASE_CHARS,$UPPERCASE_CHARS),translate(substring($ScriptVariableName,2),':','_'))"/>
			</xsl:when>
			<xsl:when test="starts-with($ScriptVariableName,'$') and not(starts-with($ScriptVariableName,'$$'))">
				<!-- Change local $variable to vVariable -->
				<xsl:value-of select="concat('v',translate(substring($ScriptVariableName,2,1),$LOWERCASE_CHARS,$UPPERCASE_CHARS),substring($ScriptVariableName,3))"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- Leave global $$variable as it is-->
				<xsl:value-of select="$ScriptVariableName"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- CorrectVariableReferences -->
	<xsl:template name="CorrectVariableReferences">
		<xsl:param name="Calc"/>
		<!-- -->
		<xsl:variable name="calcToDollar" select="substring-before(concat($Calc,'$'),'$')"/>
		<xsl:variable name="calcToQuote" select="substring-before(concat($Calc,'&quot;'),'&quot;')"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="not(contains($Calc,'$'))">
				<!-- NO more variables-->
				<xsl:value-of select="$Calc"/>
			</xsl:when>
			<xsl:when test="string-length ( $calcToQuote ) &lt; string-length ( $calcToDollar )">
				<!-- First parse a SIMPLE quote -->
				<xsl:variable name="stringRest" select="substring-after($Calc,'&quot;')"/>
				<xsl:variable name="string" select="substring-before($stringRest,'&quot;')"/>
				<xsl:variable name="rest" select="substring-after($stringRest,'&quot;')"/>
				<!-- -->
				<xsl:value-of select="$calcToQuote"/>
				<xsl:value-of select="'&quot;'"/>
				<xsl:value-of select="$string"/>
				<xsl:value-of select="'&quot;'"/>
				<!-- recursively process rest -->
				<xsl:call-template name="CorrectVariableReferences">
					<xsl:with-param name="Calc" select="$rest"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<!-- '… $($)varname …' -->
				<xsl:variable name="varnameRest" select="substring($Calc,1 + string-length($calcToDollar))"/>
				<xsl:variable name="varname" select="substring-before(concat(translate($varnameRest,'&amp;+-*/=&lt;&gt;≤≥;:()[]', '                '),' '),' ')"/>
				<xsl:variable name="rest" select="substring($varnameRest,1 + string-length($varname))"/>
				<!-- -->
				<xsl:value-of select="$calcToDollar"/>
				<xsl:call-template name="GetCalculationVariableName">
					<xsl:with-param name="ScriptVariableName" select="$varname"/>
				</xsl:call-template>
				<!-- recursively process rest -->
				<xsl:call-template name="CorrectVariableReferences">
					<xsl:with-param name="Calc" select="$rest"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
