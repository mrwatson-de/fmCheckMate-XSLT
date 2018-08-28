<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2018 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_ReplaceSetVarWithInsertCalculatedResult.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps - with SetVar X = foo bar
	
	Converts:
	
	   Set Var [ $X ; $X & foo ]
	to
	   Insert Calculated Result [ $X ; foo ]

	and

	   Set Var [ $X ; bar ]
	to
	   Insert Calculated Result [ Select ; $X ; foo ]

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2018
	2018-08-16 MrW: The Spass goes on…
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"
		cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!--
	 ! Convert Set Variable to Insert Calculated Result
	 !-->
	<xsl:template match="//Step[@id = '141']">
		<!-- convert to Set Field step -->
		<xsl:variable name="enable" select="@enable"/>

		<!-- Get the Full variable name including repetition -->
		<xsl:variable name="varName" select="Name"/>
		<xsl:variable name="varRepCalc" select="Repetition/Calculation/text()"/>
		<xsl:variable name="varNameFull">
			<xsl:value-of select="$varName"/>
			<xsl:choose>
				<xsl:when test="$varRepCalc != '1'">
					<!-- Add repetition reference only if not 1-->
					<xsl:value-of select="concat('[', $varRepCalc, ']')"/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<!-- From the calculation, e.g. "$varName[Repetition] // Comment" extract Table, Fied and repetition -->
		<xsl:variable name="valueCalculation" select="Value/Calculation/text()"/>
		<xsl:variable name="isAppend"
			select="contains($valueCalculation,'&amp;') and normalize-space(substring-before($valueCalculation,'&amp;')) = $varNameFull"/>
		<xsl:variable name="isListAppend"
			select="
				contains($valueCalculation, ';') and
				not(contains(substring-after($valueCalculation, ';'), ';')) and
				translate(normalize-space(substring-before($valueCalculation, ';')), ' ', '') = concat('List(', $varNameFull)
				"/>

		<!--
		 ! Output Insert Calculated Result
		 !-->

		<Step enable="{$enable}" id="77">
			<SelectAll>
				<xsl:attribute name="state">
					<xsl:choose>
						<xsl:when test="$isAppend">
							<xsl:value-of select="'False'"/>
						</xsl:when>
						<xsl:when test="$isListAppend">
							<xsl:value-of select="'False'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'True'"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
			</SelectAll>
			<Calculation>
				<xsl:choose>
					<xsl:when test="$isAppend">
						<!-- Remove "$varNameFull & " from the rest of the calculation -->
						<xsl:variable name="remainingStringRaw"
							select="substring-after($valueCalculation,'&amp;')"/>
						<xsl:variable name="remainingStringRawChar1"
							select="substring(normalize-space($remainingStringRaw), 1, 1)"/>
						<xsl:value-of
							select="concat($remainingStringRawChar1, substring-after($remainingStringRaw, $remainingStringRawChar1))"
						/>
					</xsl:when>
					<xsl:when test="$isListAppend">
						<!-- Convert
						 !
						 ! 		List( $varNameFull ; $whatever )
						 !
						 ! to
						 !
						 !		Let(
						 !      [
						 !      
						 !      vAppendText = ( $whatever )
						 !      
						 !      ];
						 !      
						 !      Case ( not IsEmpty ( $varNameFull ) and not IsEmpty ( vAppendText ) ; ¶ ) & vAppendText
						 !      
						 !      )
						 !
						 !-->
						<xsl:variable name="remainingStringRaw"
							select="substring-after($valueCalculation, ';')"/>
						<xsl:variable name="remainingStringRawChar1"
							select="substring(normalize-space($remainingStringRaw), 1, 1)"/>
						<xsl:variable name="remainingString"
							select="concat($remainingStringRawChar1, substring-after($remainingStringRaw, $remainingStringRawChar1))"/>

						<!-- (Removing the final parentheses is not so easy, since we'd have to parse comments) /* (so…) */-->
						<!-- …add an unnecessary opening parentheses just to balance the parentheses -->
						<xsl:variable name="appendCalc" select="concat('( ', $remainingString)"/>


						<!-- Output the new Let statement -->
						<xsl:text>Let(
[

vAppendText = </xsl:text>
						<xsl:value-of select="$appendCalc"/>
						<xsl:text>

];

Case ( not IsEmpty ( </xsl:text>
						<xsl:value-of select="$varNameFull"/>
						<xsl:text> ) and not IsEmpty ( vAppendText ) ; ¶ ) &amp; vAppendText

)						</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$valueCalculation"/>
					</xsl:otherwise>
				</xsl:choose>

			</Calculation>
			<!-- I don't know what this is, but it is THERE in the XML! -->
			<Text/>
			<Field>
				<!-- Target the variable  -->
				<xsl:value-of select="$varNameFull"/>
			</Field>
		</Step>
	</xsl:template>

</xsl:stylesheet>
