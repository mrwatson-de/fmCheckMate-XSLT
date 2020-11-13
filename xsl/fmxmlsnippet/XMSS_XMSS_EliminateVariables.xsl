<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_EliminateVariables.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	References to variables defined by way of the Set Variable script step 
	are replaced with their definition and the Set Variable script steps are removed.

	Note:
	- It does NOT support variables defined with the Let function.
	- It DOES support repeating values, e.g. $myVar[2]
	- It DOES support repeating values, e.g. $myVar[2]
	- Variables referred to in variable definitions are first removed. (Self-reference however is NOT removed)
	- Parentheses are added if necessary (and perhaps also where not necessary)

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2015-01-12 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.Substitute.xsl"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!--
	 ! Remove all Set Variable steps from the result
	 !-->
	<xsl:template match="//Step[@id='141']"/>
	<!-- 
	 ! In Calculations containing a dollar, perform Variable substitution
	 !-->
	<xsl:template match="Calculation/text()[contains(.,'$')]">
		<!-- Substitute the variables in the calculation -->
		<xsl:call-template name="fn.SubstituteMany">
			<!-- -->
			<xsl:with-param name="text" select="."/>
			<xsl:with-param name="substitutions">
				<xsl:apply-templates select="ancestor::Step" mode="collectVariableSubstitutions.start"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<!--
	 ! Mode (collectVariableSubstitutions.start)
	 ! Selects the current Step before collecting the 
	 !-->
	<xsl:template match="*" mode="collectVariableSubstitutions.start">
		<xsl:apply-templates select="preceding-sibling::Step[@id='141']" mode="collectVariableSubstitutions">
			<xsl:sort select="string-length(Name) * 100000 + count(preceding-sibling::*)" order="descending" data-type="number"/>
		</xsl:apply-templates>
	</xsl:template>
	<!--
	 ! Mode (collectVariableSubstitutions)
	 ! Creates
	 !-->
	<xsl:template match="*" mode="collectVariableSubstitutions">
		<xsl:call-template name="fn.SubstituteMany.setParam">
			<xsl:with-param name="searchString">
				<xsl:value-of select="Name"/>
				<xsl:if test="Repetition/Calculation/text() != '1'">
					<xsl:value-of select="'['"/>
					<xsl:apply-templates select="Repetition/Calculation/text()"/>
					<xsl:value-of select="']'"/>
				</xsl:if>
			</xsl:with-param>
			<xsl:with-param name="replaceString">
				<xsl:variable name="replacement">
					<xsl:apply-templates select="Value/Calculation/text()"/>
				</xsl:variable>
				<xsl:variable name="string" select="normalize-space($replacement)"/>
				<xsl:choose>
					<xsl:when test="substring($string,1,1) = $QUOT and substring($string,string-length($string)) = $QUOT and  not( contains(substring($string,2,string-length($string) - 2), $QUOT )) ">
						<!-- It is a simple string -->
						
						<xsl:value-of select="$replacement"/>
					</xsl:when>
					<xsl:when test="translate($replacement,'+-*/^&gt;&lt;=≤≥','') != $replacement">
						<!-- possibly a calculation, so add parentheses -->
						<xsl:value-of select="concat('(',$replacement,')')"/>
					</xsl:when>
					<xsl:otherwise>
						<!-- number or field or the like -->
						<xsl:value-of select="$replacement"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
