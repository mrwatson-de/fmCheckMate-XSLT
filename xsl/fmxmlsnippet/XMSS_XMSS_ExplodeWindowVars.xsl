<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_ExplodeWindowVars.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps.
	
	Extracts the Window properties into window variables.
	
	===== CHANGES HISTORY =====
	2019-10-02 MrW: Changed Variable Names to english
	2013-09-09 MrW: Clone templates centralized in _inc/inc.Clone.xsl
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== PARAMETERS ===== -->
	<xsl:param name="VariableWindowName" select="'$WindowName'"/>
	<xsl:param name="VariableWindowTop" select="'$WindowTop'"/>
	<xsl:param name="VariableWindowLeft" select="'$WindowLeft'"/>
	<xsl:param name="VariableWindowWidth" select="'$WindowWidth'"/>
	<xsl:param name="VariableWindowHeight" select="'$WindowHeight'"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Go to related record Script step-->
	<xsl:template match="//Step[@id='74' and ShowInNewWindow/@state='True' or @id='119' or @id='122']">
		<!-- Extract window details into standard variables -->
		<xsl:variable name="enable" select="@enable"/>
		
		<xsl:if test="Name/Calculation">
			<Step enable="{$enable}" id="141">
				<Value>
					<xsl:copy-of select="Name/Calculation"/>
				</Value>
				<Repetition>
					<Calculation><![CDATA[1]]></Calculation>
				</Repetition>
				<Name>
					<xsl:value-of select="$VariableWindowName"/>
				</Name>
			</Step>
		</xsl:if>
		<xsl:if test="Height/Calculation">
			<Step enable="{$enable}" id="141">
				<Value>
					<xsl:copy-of select="Height/Calculation"/>
				</Value>
				<Repetition>
					<Calculation><![CDATA[1]]></Calculation>
				</Repetition>
				<Name>
					<xsl:value-of select="$VariableWindowHeight"/>
				</Name>
			</Step>
		</xsl:if>
		<xsl:if test="Width/Calculation">
			<Step enable="{$enable}" id="141">
				<Value>
					<xsl:copy-of select="Width/Calculation"/>
				</Value>
				<Repetition>
					<Calculation><![CDATA[1]]></Calculation>
				</Repetition>
				<Name>
					<xsl:value-of select="$VariableWindowWidth"/>
				</Name>
			</Step>
		</xsl:if>
		<xsl:if test="DistanceFromTop/Calculation">
			<Step enable="{$enable}" id="141">
				<Value>
					<xsl:copy-of select="DistanceFromTop/Calculation"/>
				</Value>
				<Repetition>
					<Calculation><![CDATA[1]]></Calculation>
				</Repetition>
				<Name>
					<xsl:value-of select="$VariableWindowTop"/>
				</Name>
			</Step>
		</xsl:if>
		<xsl:if test="DistanceFromLeft/Calculation">
			<Step enable="{$enable}" id="141">
				<Value>
					<xsl:copy-of select="DistanceFromLeft/Calculation"/>
				</Value>
				<Repetition>
					<Calculation><![CDATA[1]]></Calculation>
				</Repetition>
				<Name>
					<xsl:value-of select="$VariableWindowLeft"/>
				</Name>
			</Step>
		</xsl:if>
		<Step>
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates select="*[not(self::Name or self::Height or self::Width or self::DistanceFromTop or self::DistanceFromLeft)]"/>
			<xsl:if test="Name/Calculation">
				<Name>
					<Calculation>
						<xsl:value-of select="$VariableWindowName"/>
					</Calculation>
				</Name>
			</xsl:if>
			<xsl:if test="Height/Calculation">
				<Height>
					<Calculation>
						<xsl:value-of select="$VariableWindowHeight"/>
					</Calculation>
				</Height>
			</xsl:if>
			<xsl:if test="Width/Calculation">
				<Width>
					<Calculation>
						<xsl:value-of select="$VariableWindowWidth"/>
					</Calculation>
				</Width>
			</xsl:if>
			<xsl:if test="DistanceFromTop/Calculation">
				<DistanceFromTop>
					<Calculation>
						<xsl:value-of select="$VariableWindowTop"/>
					</Calculation>
				</DistanceFromTop>
			</xsl:if>
			<xsl:if test="DistanceFromLeft/Calculation">
				<DistanceFromLeft>
					<Calculation>
						<xsl:value-of select="$VariableWindowLeft"/>
					</Calculation>
				</DistanceFromLeft>
			</xsl:if>
		</Step>
	</xsl:template>
</xsl:stylesheet>
