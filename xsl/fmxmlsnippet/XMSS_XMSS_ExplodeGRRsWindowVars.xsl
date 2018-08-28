<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_ExplodeGRRsWindowVars.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps - with Go to Related Records steps containing window name and size
	
	Extracts the Window information into standard window variables.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2011-2016
	2013-09-09 MrW: Clone templates centralized in _inc/inc.Clone.xsl
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Gehe_zu_Bezugsdatensatz Script step-->
	<xsl:template match="//Step[@id='74' and ShowInNewWindow/@state='True']">
		<!-- Extract window details into standard variables -->
		<Step enable="True" id="141" name="Variable setzen">
			<Value>
				<xsl:copy-of select="Name/Calculation"/>
			</Value>
			<Repetition>
				<Calculation><![CDATA[1]]></Calculation>
			</Repetition>
			<Name>$fensterName</Name>
		</Step>
		<Step enable="True" id="141" name="Variable setzen">
			<Value>
				<xsl:copy-of select="Height/Calculation"/>
			</Value>
			<Repetition>
				<Calculation><![CDATA[1]]></Calculation>
			</Repetition>
			<Name>$fensterHoehe</Name>
		</Step>
		<Step enable="True" id="141" name="Variable setzen">
			<Value>
				<xsl:copy-of select="Width/Calculation"/>
			</Value>
			<Repetition>
				<Calculation><![CDATA[1]]></Calculation>
			</Repetition>
			<Name>$fensterBreite</Name>
		</Step>
		<Step enable="True" id="141" name="Variable setzen">
			<Value>
				<xsl:copy-of select="DistanceFromTop/Calculation"/>
			</Value>
			<Repetition>
				<Calculation><![CDATA[1]]></Calculation>
			</Repetition>
			<Name>$fensterOben</Name>
		</Step>
		<Step enable="True" id="141" name="Variable setzen">
			<Value>
				<xsl:copy-of select="DistanceFromLeft/Calculation"/>
			</Value>
			<Repetition>
				<Calculation><![CDATA[1]]></Calculation>
			</Repetition>
			<Name>$fensterLinks</Name>
		</Step>
		<Step>
			<xsl:apply-templates select="@*|Option|MatchAllRecords|ShowInNewWindow|Restore|LayoutDestination|Table|Layout"/>
			<Name>
				<Calculation><![CDATA[$fensterName]]></Calculation>
			</Name>
			<Height>
				<Calculation><![CDATA[$fensterHoehe]]></Calculation>
			</Height>
			<Width>
				<Calculation><![CDATA[$fensterBreite]]></Calculation>
			</Width>
			<DistanceFromTop>
				<Calculation><![CDATA[$fensterOben]]></Calculation>
			</DistanceFromTop>
			<DistanceFromLeft>
				<Calculation><![CDATA[$fensterLinks]]></Calculation>
			</DistanceFromLeft>
		</Step>
		<Step enable="True" id="121" name="Fenster schließen">
			<LimitToWindowsOfCurrentFile state="True"/>
			<Window value="ByName"/>
			<Name>
				<Calculation><![CDATA[$fensterName]]></Calculation>
			</Name>
		</Step>
		<Step enable="True" id="122" name="Neues Fenster">
			<Name>
				<Calculation><![CDATA[$fensterName]]></Calculation>
			</Name>
			<Height>
				<Calculation><![CDATA[$fensterHoehe]]></Calculation>
			</Height>
			<Width>
				<Calculation><![CDATA[$fensterBreite]]></Calculation>
			</Width>
			<DistanceFromTop>
				<Calculation><![CDATA[$fensterOben]]></Calculation>
			</DistanceFromTop>
			<DistanceFromLeft>
				<Calculation><![CDATA[$fensterLinks]]></Calculation>
			</DistanceFromLeft>
		</Step>
		<Step enable="True" id="29" name="Statusbereich ein-/ausblenden">
			<Lock state="False"/>
			<ShowHide value="Hide"/>
		</Step>
		<Step enable="True" id="119" name="Fensterposition/-größe ändern">
			<LimitToWindowsOfCurrentFile state="True"/>
			<Window value="ByName"/>
			<Name>
				<Calculation><![CDATA[$fensterName]]></Calculation>
			</Name>
			<Height>
				<Calculation><![CDATA[$fensterHoehe]]></Calculation>
			</Height>
			<Width>
				<Calculation><![CDATA[$fensterBreite]]></Calculation>
			</Width>
			<DistanceFromTop>
				<Calculation><![CDATA[$fensterOben]]></Calculation>
			</DistanceFromTop>
			<DistanceFromLeft>
				<Calculation><![CDATA[$fensterLinks]]></Calculation>
			</DistanceFromLeft>
		</Step>
	</xsl:template>
</xsl:stylesheet>
