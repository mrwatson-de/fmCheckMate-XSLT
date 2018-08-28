<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: inc.XMSS_XMSS_ConvertBetweenFM11Andfmp12.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: Copied scripts or script-steps.
	
	Converts scripts or script-steps between FM11 and fmp12 AND VICE-VERSA.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2011-2016
	2013-09-13 MrW: Commit Records/Requests ESSForceCommit and NewWndStyles
	 :              LOTS of changes
	2011-04-16 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<!--
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.serializeXML.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.parseXML.xsl"/>
	-->
	<!-- ===== VARIABLES ===== -->
	<!--
	<xsl:variable name="fmp12" select="//Step[@id*1&gt;152] or Step[@id='131']/DialogOptions or //Step[@id='87']/Buttons or //NewWndStyles or //ESSForceCommit"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	 -->
	<!-- ===== TEMPLATES ===== -->
	<!-- 
	 !
	 !
	 ! ===== both FM11->fmp12 and fmp12-> FM11 =====
	 !
	 !
	 !-->
	<!-- FIXME:is this general template good or bad? - Remove all Step/@name s, in case they have changed -->
	<xsl:template match="Step/@name"/>
	<!--  -->
	<!-- Script step 29. Show/Hide Toolbars  - Remove the command Name, because it has changed
	<xsl:template match="Step[@id='29']/@name"/>-->
	<!-- Script step 115. Allow Formatting Bar  - Remove the command Name, because it has changed
	<xsl:template match="Step[@id='115']/@name"/>-->
	<!--
	 !
	 !
	 ! ===== FM11->fmp12 =====
	 !
	 !
	 !-->
	<!-- 
	 ! Script step 87. Eigenes Dialogfeld anzeigen
	 !-->
	<!-- <ButtonCaptions> -> <Buttons> -->
	<xsl:template match="Step[@id='87']/ButtonCaptions">
		<Buttons>
			<xsl:apply-templates select="@*|node()"/>
		</Buttons>
	</xsl:template>
	<!-- ButtonCaption -> Button @CommitState -->
	<xsl:template match="Step[@id='87']/ButtonCaptions/ButtonCaption">
		<xsl:variable name="i" select="1+count(preceding-sibling::*)"/>
		<xsl:variable name="CommitState" select="../../InputFields/InputField[$i]/@CommitState"/>
		<Button CommitState="{$CommitState}">
			<xsl:apply-templates select="@*|node()"/>
		</Button>
	</xsl:template>
	<!-- InputField/@CommitState entfernen -->
	<xsl:template match="Step[@id='87']/InputFields[../ButtonCaptions]/InputField/@CommitState"/>
	<!-- 
	 ! Script step 131. Insert File
	 ! 
	 !:::::::::::::: FIXME ToDo::::::::::::::::::::::::::::::::::::::::::::::::::: 
	 !-->
	<!--  DialogOptions entfernen -->
	<xsl:template match="Step[@id='131']/DialogOptions"/>
	<!-- Script step 89. Kommentar #<Step ... convert to <Step 
	<xsl:template match="Step[@id='131' and not(DialogOptions) and substring(previous-sibling::Step[Text/text(),1,15)='&lt;DialogOptions ']">
		<xsl:value-of select="Text/text()" disable-output-escaping="yes"/>
	</xsl:template-->
	<!-- :::::::::::::: FIXME ToDo::::::::::::::::::::::::::::::::::::::::::::::::::: 
	    
	    <Step enable="True" id="131" name="Insert File">
	      <UniversalPathList type="Embedded"/>
	      <DialogOptions asFile="True" enable="False">
	        <Storage type="UserChoice"/>
	        <Compress type="UserChoice"/>
	        <FilterList/>
	      </DialogOptions>
	    </Step>
	
	<Step enable="True" id="74" name="Go to Related Record">
		<Option state="False"/>
		<MatchAllRecords state="False"/>
		<ShowInNewWindow state="False"/>
		<Restore state="True"/>
		<LayoutDestination value="SelectedLayout"/>
		<NewWndStyles Styles="983554"/>
		<Table id="1065214" name="EML_Spooler Maileingang"/>
		<Layout id="53" name="I EML_Spooler Maileingang"/>
	</Step>
	
	-->
	<!-- NewWndStyles (Go to Related Record) NewWndStyles entfernen -->
	<xsl:template match="Step/NewWndStyles"/>
	<!-- NewWndStyles: no template to ADD - let FM do it automatically -->
	<!-- Commit Records/Requests ESSForceCommit entfernen -->
	<xsl:template match="Step[@id='75']/ESSForceCommit"/>
	<!-- Commit Records/Requests ESSForceCommit Add -->
	<xsl:template match="Step[@id='75' and not(ESSForceCommit)]">
		<Step>
			<xsl:copy-of select="@*"/>
			<xsl:copy-of select="NoInteract"/>
			<xsl:copy-of select="Option"/>
			<ESSForceCommit state="False"/>
		</Step>
	</xsl:template>
	<!-- Script step 89. Kommentar "#<Step ..."
	 !
	 ! Converts fmp12-only steps (i.e. Script step id > 112) which have been embedded in a comment as an fmxmlsnippet
	 ! back to the fmp12 script step
	 !-->
	<xsl:template match="Step[@id='89' and substring(Text/text(),1,6)='&lt;Step ']">
		<xsl:call-template name="fn.parseXML">
			<xsl:with-param name="XML" select="Text/text()"/>
		</xsl:call-template>
	</xsl:template>
	<!--
	 !
	 !
	 ! ===== fmp12->FM11 =====
	 !
	 !
	 !-->
	<!-- Script step 87. Eigenes Dialogfeld anzeigen Buttons->ButtonCaptions -->
	<xsl:template match="Step[@id='87']/Buttons">
		<xsl:element name="ButtonCaptions">
			<ButtonCaption>
				<xsl:value-of select="Button[1]"/>
			</ButtonCaption>
			<ButtonCaption>
				<xsl:value-of select="Button[2]"/>
			</ButtonCaption>
			<ButtonCaption>
				<xsl:value-of select="Button[3]"/>
			</ButtonCaption>
		</xsl:element>
	</xsl:template>
	<!-- Script step 87. Eigenes Dialogfeld anzeigen @CommitState von Buttons entfernen -->
	<xsl:template match="Step[@id='87']/Buttons/Button/@CommitState"/>
	<!-- Script step 87. Eigenes Dialogfeld anzeigen @CommitState von Buttons zu InputField kopiern -->
	<xsl:template match="Step[@id='87']/InputFields[../Buttons]/InputField">
		<xsl:variable name="i" select="1+count(preceding-sibling::*)"/>
		<xsl:copy>
			<xsl:attribute name="CommitState">
				<xsl:value-of select="../../Buttons/Button[$i]/@CommitState"/>
			</xsl:attribute>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- Script step >112. convert fmp12 steps to comments -->
	<xsl:template match="Step[number(@id)&gt;152]">
		<Step enable="True" id="89">
			<Text>
				<xsl:call-template name="fn.serializeXML"/>
			</Text>
		</Step>
	</xsl:template>
</xsl:stylesheet>
