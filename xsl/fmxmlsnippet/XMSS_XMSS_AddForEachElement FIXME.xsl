<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_AddForEachElement.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Adds a FOR EACH loop construction to the end of the script.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2015-02-02 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== PARAMETERS ===== -->
	<xsl:param name="ElementVariableName" select="'Element'"/>
	<xsl:param name="ListVariableName" select="'ListOfElements'"/>
	<xsl:param name="LoopVariableName" select="'i'"/>
	<xsl:param name="LoopMaxVariableName" select="'n'"/>
	<xsl:param name="LoopStepValue" select="'1'"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- REMOVE Script envelope, copy steps if any and add new steps at the end -->
	<xsl:template match="Script[not(ancestor::Step)]">
		<xsl:choose>
			<xsl:when test="Step">
				<xsl:apply-templates select="Step"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="ForEachElementInList"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- match the last Step of the Script and then add the snippet-->
	<xsl:template match="Step[last()]">
		<xsl:copy-of select="."/>
		<xsl:call-template name="ForEachElementInList"/>
	</xsl:template>
	<!-- ForEachElementInList -->
	<xsl:template name="ForEachElementInList">
		<Step enable="True" id="89" name="Comment"/>
		<Step enable="True" id="141" name="Set Variable">
			<Value>
				<Calculation><![CDATA["A¶B¶C"]]></Calculation>
			</Value>
			<Repetition>
				<Calculation><![CDATA[1]]></Calculation>
			</Repetition>
			<Name>
				<xsl:value-of select="concat('$',$ListVariableName)"/>
			</Name>
		</Step>
		<Step enable="True" id="89" name="Comment"/>
		<Step enable="True" id="89" name="Comment">
			<Text>
				<xsl:value-of select="concat('FOR EACH ',$ElementVariableName,' IN ',$ListVariableName)"/>
			</Text>
		</Step>
		<Step enable="True" id="141" name="Set Variable">
			<Value>
				<Calculation><![CDATA[1]]></Calculation>
			</Value>
			<Repetition>
				<Calculation><![CDATA[1]]></Calculation>
			</Repetition>
			<Name>
				<xsl:value-of select="concat('$',$LoopVariableName)"/>
			</Name>
		</Step>
		<Step enable="True" id="141" name="Set Variable">
			<Value>
				<Calculation>
					<xsl:value-of select="concat('ValueCount( $',$LoopVariableName,' )')"/>
				</Calculation>
			</Value>
			<Repetition>
				<Calculation><![CDATA[1]]></Calculation>
			</Repetition>
			<Name>
				<xsl:value-of select="concat('ValueCount( $',$LoopMaxVariableName,' )')"/>
			</Name>
		</Step>
		<Step enable="True" id="71" name="Loop"/>
		<Step enable="True" id="72" name="Exit Loop If">
			<Calculation>
				<xsl:value-of select="concat('$',$LoopVariableName,' &gt; $',$LoopMaxVariableName)"/>
			</Calculation>
		</Step>
		<Step enable="True" id="141" name="Set Variable">
			<Value>
				<Calculation>
					<xsl:value-of select="concat('GetValue( $',$ListVariableName,' ; $',$LoopVariableName,' )')"/>
				</Calculation>
			</Value>
			<Repetition>
				<Calculation><![CDATA[1]]></Calculation>
			</Repetition>
			<Name>
				<xsl:value-of select="concat('$',$ElementVariableName)"/>
			</Name>
		</Step>
		<Step enable="True" id="89" name="Comment">
			<Text>
				<xsl:value-of select="concat('Process ',$ElementVariableName)"/>
			</Text>
		</Step>
		<Step enable="True" id="89" name="Comment"/>
		<Step enable="True" id="89" name="Comment">
			<Text>Add steps here</Text>
		</Step>
		<Step enable="True" id="89" name="Comment">
			<Text>
				<xsl:value-of select="concat('NEXT ',$LoopVariableName)"/>
			</Text>
		</Step>
		<Step enable="True" id="141" name="Set Variable">
			<Value>
				<Calculation>
					<xsl:value-of select="concat('$',$LoopVariableName,' + ',$LoopStepValue)"/>
				</Calculation>
			</Value>
			<Repetition>
				<Calculation><![CDATA[1]]></Calculation>
			</Repetition>
			<Name>
				<xsl:value-of select="concat('$',$LoopVariableName)"/>
			</Name>
		</Step>
		<Step enable="True" id="73" name="End Loop"/>
		<Step enable="True" id="89" name="Comment"/>
	</xsl:template>
</xsl:stylesheet>
