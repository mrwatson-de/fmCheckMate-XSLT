<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2018 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: _inc/inc.XMSS_Text_PrintSteps.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps

	Contains the basic functions for listing scripts & script steps.
	
	WARNING: ALPHA-VERSION STILL IN DEVELOPMENT!
	To Do:
	1) DOING - Complete all Script steps (FM17).
	2) DOING - Make multiple output formats possible (not just single row multi-column format)
	3) DOING - Standardise coding
	4) DOING - Factorise coding
	5) LATER - i18n
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2011-2018
	2018-05-06 MrW: It's that time of year :-) ...
	                + Corrected, refactored, sorted + tidied code, improved comments - thanks to oXygen XML Editor - nice!
	                + Added FileMaker 17 script steps + changed output formatting
	                + Improved output of Print + Print Setup steps, inc. attributes + printer names
	2017-05-21 MrW: Another huge day...
	                + Corrected 99.9% for all FM16 commands (known to me)
	                + Added support for parameters 
	                  - pSIC - 'True' outputs the ';' delimiter exactly as it appears in the Script Workspace (i.e. missing a space in Import Records + Insert from Device)
	                  - pVerbose - 'True' outputs more detail than visible in the Script Workspace (Verbose mode is not finished yet)
	                + Corrected nearly all known rendering bugs. Issues still open:
	                  - In (Go to) layout references the LayoutTablename cannot be known without a DDR => we output (…) as a placeholder
			  - In the Print Step printer names with high ascii characters are encoded (code?)
	2016-03-12 MrW: Big day...Corrected 99.9% for all FM15 commands
	2014-11-21 MrW: Stubs for FM14 Commands
	2013-12-15 MrW: Stubs for FM13 Commands
	2013-09-07 MrW: Accounts, Spelling, Files and Export Records, Save Records as Excel, Save Records as PDF, Save Records as Snapshot Link
	2013-09-05 MrW: :-) Refactored out of XMSS_Text.Lines_ListIndented.xsl, so that parameters can be set by the including XSL file.
	2013-06-01 MrW: STILL TO DO TEST: Files, Accounts, Spelling
	2013-06-01 MrW: Added new fmp12 commands
	2013-05-29 MrW: Improved Control, Navigation, Editing, Fields, Records, Found Sets, Windows, Open Menu Item script steps
	2013-05-28 MrW: with ../../../fmCheckMate/xsl/_inc/constants.StepIDs.xsl and ScriptStepAutoIndent
	2011-09-30 MrW: with ../../../fmCheckMate/xsl/_inc/constants.xsl
	 !-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.StepIDs.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.ListFunctions.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.StringFunctions.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.NumberFunctions.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.BaseFunctions.xsl"/>
	<!--
	 !
	 !
	 !
	 ! ===== 
	 ! NEEDS
	 ! =====
	 !
	 !
	 !
	 !-->
	<!--
	 ! ===== inc.XMSS_Text.List INTERFACE PARAMETERS =====
	 !
	 ! The following parameters MUST be implemented in the including XSLT.
	 !-->
	<!--
	<xsl:param name="pShowLineNumbers" select="'True'"/>
	<xsl:param name="pShowScriptIDs" select="'True'"/>
	<xsl:param name="pIndentGroups" select="'False'"/>
	<xsl:param name="pIndentScripts" select="'False'"/>
	<xsl:param name="pIndentScriptSteps" select="'True'"/>
	 !-->
	<!--
	 ! ===== inc.XMSS_Text.List INTERFACE VARIABLES =====
	 !
	 ! The following variables MUST be implemented in the including XSLT.
	 !-->
	<!--
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="delimiter1" select="' ['"/>
	<xsl:variable name="delimiter2" select="': '"/>
	<xsl:variable name="delimiter3" select="'; '"/>
	<xsl:variable name="delimiter4" select="']'"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<xsl:variable name="pIndentString" select="$TAB"/>
	<xsl:variable name="pIndentLevel" select="0"/>
	 !-->
	<!--
	 !===== inc.XMSS_Text.List INTERFACE TEMPLATES =====
	 !
	 ! The following templates MUST be implemented in the including XSLT.
	 !-->
	<!--
	 ! for ScriptGroups
	 !-->
	<!-- ScriptGroupSTART -->
	<!-- ScriptGroupEND -->
	<!--
	 ! for Scripts:
	 !-->
	<!-- ScriptSTART -->
	<!-- ScriptEND -->
	<!--
	 ! for Script steps:
	 !-->
	<!-- ScriptStepSTART -->
	<!-- ScriptStepDisable -->
	<!-- ScriptStepParameterList -->
	<!-- ScriptStepEND -->
	<!-- ScriptStepSTARTEND // Shortcut template called from script steps that have no parameters -->
	<!--
	 !
	 !
	 !
	 ! =====================
	 ! ===== TEMPLATES =====
	 ! =====================
	 !
	 !
	 !
	 !-->
	<!--
	 !
	 ! ScriptGroups
	 !
	 !-->
	<xsl:template match="//Group">
		<xsl:call-template name="ScriptGroupSTART"/>
		<xsl:apply-templates select="*"/>
		<xsl:call-template name="ScriptGroupEND"/>
	</xsl:template>
	<!--
	 !
	 ! Scripts
	 !
	 !-->
	<xsl:template match="//Script[not(ancestor::Step)]">
		<xsl:call-template name="ScriptSTART"/>
		<xsl:apply-templates select="*"/>
		<xsl:call-template name="ScriptEND"/>
	</xsl:template>
	<!--
	 !
	 ! Script steps
	 !
	 !-->
	<!-- 
	 !
	 ! =============
	 ! CONTROL STEPS
	 ! =============
	 !
	 !-->
	<!--
	 ! Script step 1. Perform Script
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '1']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamScriptSpecified"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 164. Perform Script on Server (from fm13)
	 !
	 ! In FM 17:
	 !  - refactored into sub-template
	 !  - added Specified From list/ By Name
	 !  - always with Parameter: …
	 !  - Wait for completion at the end 
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '164']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamScriptSpecified"/>
				<!-- -->
				<xsl:value-of select="'Wait for completion'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:call-template name="Set_state">
					<xsl:with-param name="state" select="WaitForCompletion/@state"/>
				</xsl:call-template>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 62. Pause/Resume Script
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '62']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:choose>
					<xsl:when test="PauseTime/@value = 'ForDuration'">
						<xsl:value-of select="concat('Duration (seconds)', $delimiter2)"/>
						<xsl:call-template name="OutputCalculation">
							<xsl:with-param name="Calc" select="Calculation"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="PauseTime/@value = 'Indefinitely'">
						<xsl:value-of select="'Indefinitely'"/>
					</xsl:when>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 103. Exit Script
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '103']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:value-of select="'Text Result'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:call-template name="OutputCalculationOrTwoSpaces">
					<xsl:with-param name="Calc" select="Calculation"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 90. Halt Script
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '90']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 68. If
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '68']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="OutputCalculationOrTwoSpaces">
					<xsl:with-param name="Calc" select="Calculation"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 71. Loop
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '71']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 70. End If
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '70']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 73. End Loop
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '73']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 125. Else If
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '125']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="OutputCalculationOrTwoSpaces">
					<xsl:with-param name="Calc" select="Calculation"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 69. Else
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '69']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 72. Exit Loop If
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '72']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="OutputCalculationOrTwoSpaces">
					<xsl:with-param name="Calc" select="Calculation"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 85. Allow User Abort
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '85']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="Set_state">
					<xsl:with-param name="state" select="Set/@state"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 86. Set Error Capture
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '86']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="Set_state">
					<xsl:with-param name="state" select="Set/@state"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 141. Set Variable
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '141']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:value-of select="Name"/>
				<xsl:call-template name="FieldRepetition"/>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
				<xsl:if test="Value/Calculation">
					<xsl:value-of select="concat('Value', $delimiter2)"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="Value/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 168. Set Layout Object Animation
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '168']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="Set_state">
					<xsl:with-param name="state" select="Set/@state"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 148. Install OnTimer Script
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '148']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="Script">
					<xsl:call-template name="QuotedStringOrUnknown">
						<xsl:with-param name="string" select="Script/@name"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
					<!-- -->
					<xsl:if test="Calculation">
						<xsl:value-of select="'Parameter'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:call-template name="OutputCalculation">
							<xsl:with-param name="Calc" select="Calculation"/>
						</xsl:call-template>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<!-- -->
				</xsl:if>
				<xsl:if test="Interval/Calculation">
					<xsl:value-of select="concat('Interval', $delimiter2)"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="Interval/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 !
	 ! ================
	 ! NAVIGATION STEPS
	 ! ================
	 !
	 !-->
	<!--
	 ! Script step 6. Go to Layout
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '6']">
		<xsl:variable name="animationValue" select="Animation/@value"/>
		<xsl:variable name="destinationValue" select="LayoutDestination/@value"/>
		<!-- -->
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamLayoutDestination"/>
				<xsl:value-of select="$delimiter3"/>
				<xsl:value-of select="'Animation'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:choose>
					<xsl:when test="not($animationValue)">
						<xsl:value-of select="'None'"/>
					</xsl:when>
					<xsl:when test="$animationValue = 'SlideFromLeft'">
						<xsl:value-of select="'Slide in from Left'"/>
					</xsl:when>
					<xsl:when test="$animationValue = 'SlideFromRight'">
						<xsl:value-of select="'Slide in from Right'"/>
					</xsl:when>
					<xsl:when test="$animationValue = 'SlideFromBottom'">
						<xsl:value-of select="'Slide in from Bottom'"/>
					</xsl:when>
					<xsl:when test="$animationValue = 'SlideToLeft'">
						<xsl:value-of select="'Slide out to Left'"/>
					</xsl:when>
					<xsl:when test="$animationValue = 'SlideToRight'">
						<xsl:value-of select="'Slide out to Right'"/>
					</xsl:when>
					<xsl:when test="$animationValue = 'SlideToBottom'">
						<xsl:value-of select="'Slide out to Bottom'"/>
					</xsl:when>
					<xsl:when test="$animationValue = 'FlipFromLeft'">
						<xsl:value-of select="'Flip from Left'"/>
					</xsl:when>
					<xsl:when test="$animationValue = 'FlipFromRight'">
						<xsl:value-of select="'Flip from Right'"/>
					</xsl:when>
					<xsl:when test="$animationValue = 'ZoomIn'">
						<xsl:value-of select="'Zoom In'"/>
					</xsl:when>
					<xsl:when test="$animationValue = 'ZoomOut'">
						<xsl:value-of select="'Zoom Out'"/>
					</xsl:when>
					<xsl:when test="$animationValue = 'CrossDissolve'">
						<xsl:value-of select="'Cross Dissolve'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$animationValue"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="$delimiter3"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 16. Go to Record/Request/Page
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '16']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<!--xsl:value-of select="RowPageLocation/@value"/-->
				<xsl:choose>
					<xsl:when test="RowPageLocation/@value = 'First'">
						<xsl:value-of select="'First'"/>
					</xsl:when>
					<xsl:when test="RowPageLocation/@value = 'Previous'">
						<xsl:value-of select="'Previous'"/>
						<xsl:value-of select="$delimiter3"/>
						<xsl:value-of select="'Exit after last'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:call-template name="Set_state">
							<xsl:with-param name="state" select="Exit/@state"/>
						</xsl:call-template>
						<xsl:value-of select="$delimiter3"/>
					</xsl:when>
					<xsl:when test="RowPageLocation/@value = 'Next'">
						<xsl:value-of select="'Next'"/>
						<xsl:value-of select="$delimiter3"/>
						<xsl:value-of select="'Exit after last'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:call-template name="Set_state">
							<xsl:with-param name="state" select="Exit/@state"/>
						</xsl:call-template>
						<xsl:value-of select="$delimiter3"/>
					</xsl:when>
					<xsl:when test="RowPageLocation/@value = 'Last'">
						<xsl:value-of select="'Last'"/>
					</xsl:when>
					<xsl:when test="RowPageLocation/@value = 'ByCalculation'">
						<xsl:call-template name="ScriptStepParamNoDialog"/>
						<xsl:if test="$pVerbose = 'True'">
							<xsl:value-of select="'By Number'"/>
							<xsl:value-of select="$delimiter2"/>
						</xsl:if>
						<xsl:call-template name="OutputCalculation">
							<xsl:with-param name="Calc" select="Calculation"/>
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 74. Go to Related Record
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '74']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="Restore/@state = 'True'">
					<xsl:value-of select="'Show only related records'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="MatchAllRecords/@state = 'True'">
					<xsl:value-of select="'Match found set'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:value-of select="concat('From table', $delimiter2)"/>
				<xsl:call-template name="QuotedStringOrUnknown">
					<xsl:with-param name="string" select="Table/@name"/>
				</xsl:call-template>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
				<xsl:if test="Option/@state = 'True'">
					<xsl:value-of select="'External'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:value-of select="'Using layout'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:call-template name="ScriptStepParamLayoutDestination"/>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
				<xsl:if test="ShowInNewWindow/@state = 'True'">
					<xsl:value-of select="'New window'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 99. Go to Portal Row
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '99']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:value-of select="'Select'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:call-template name="Set_state">
					<xsl:with-param name="state" select="SelectAll/@state"/>
				</xsl:call-template>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
				<xsl:choose>
					<xsl:when test="RowPageLocation/@value = 'First'">
						<xsl:value-of select="'First'"/>
						<xsl:value-of select="$delimiter3"/>
						<!-- -->
					</xsl:when>
					<xsl:when test="RowPageLocation/@value = 'Previous'">
						<xsl:value-of select="'Previous'"/>
						<xsl:value-of select="$delimiter3"/>
						<!-- -->
						<xsl:value-of select="'Exit after last'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:call-template name="Set_state">
							<xsl:with-param name="state" select="Exit/@state"/>
						</xsl:call-template>
						<xsl:value-of select="$delimiter3"/>
					</xsl:when>
					<xsl:when test="RowPageLocation/@value = 'Next'">
						<xsl:value-of select="'Next'"/>
						<xsl:value-of select="$delimiter3"/>
						<!-- -->
						<xsl:value-of select="'Exit after last'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:call-template name="Set_state">
							<xsl:with-param name="state" select="Exit/@state"/>
						</xsl:call-template>
						<xsl:value-of select="$delimiter3"/>
					</xsl:when>
					<xsl:when test="RowPageLocation/@value = 'Last'">
						<xsl:value-of select="'Last'"/>
						<xsl:value-of select="$delimiter3"/>
						<!-- -->
					</xsl:when>
					<xsl:when test="RowPageLocation/@value = 'ByCalculation'">
						<xsl:call-template name="ScriptStepParamNoDialog"/>
						<xsl:if test="$pVerbose = 'True'">
							<xsl:value-of select="'By Number'"/>
							<xsl:value-of select="$delimiter2"/>
						</xsl:if>
						<xsl:call-template name="OutputCalculation">
							<xsl:with-param name="Calc" select="Calculation"/>
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 145. Go to Object
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '145']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="ObjectName">
					<xsl:value-of select="'Object Name'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="ObjectName/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:call-template name="NamedRepetition"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 17. Go to Field
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '17']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="SelectAll/@state = 'True'">
					<xsl:value-of select="'Select/perform'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:call-template name="ScriptStepParamField"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 4. Go to Next Field
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '4']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 5. Go to Previous Field
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '5']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 169. Close Popover
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '169']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 55. Enter Browse Mode
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '55']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamPause"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 22. Enter Find Mode
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '22']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamQuery"/>
				<xsl:call-template name="ScriptStepParamRestore"/>
				<xsl:call-template name="ScriptStepParamPause"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 41. Enter Preview Mode
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '41']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamPause"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!-- 
	 !
	 ! =============
	 ! EDITING STEPS
	 ! =============
	 !
	 !-->
	<!--
	 ! Script step 45. Undo/Redo
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '45']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:value-of select="UndoRedo/@value"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 46. Cut
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '46']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamSelect"/>
				<xsl:call-template name="ScriptStepParamField"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 47. Copy
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '47']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamSelect"/>
				<xsl:call-template name="ScriptStepParamField"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 48. Paste
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '48']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamSelect"/>
				<xsl:if test="NoStyle/@state = 'True'">
					<xsl:value-of select="'No style'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="LinkAvail/@state = 'True'">
					<xsl:value-of select="'If link available'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:call-template name="ScriptStepParamField"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 49. Clear
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '49']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamSelect"/>
				<xsl:call-template name="ScriptStepParamField"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 130. Set Selection
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '130']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamField"/>
				<xsl:if test="StartPosition">
					<xsl:value-of select="'Start Position'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="StartPosition/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="EndPosition">
					<xsl:value-of select="'End Position'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="EndPosition/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 50. Select All
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '50']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 128. Perform Find/Replace
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '128']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamNoDialog"/>
				<xsl:if test="FindCalc/Calculation">
					<!--xsl:value-of select="'Find'"/>
					<xsl:value-of select="$delimiter2"/-->
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="FindCalc/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="ReplaceCalc/Calculation">
					<!--xsl:value-of select="'Replace'"/>
					<xsl:value-of select="$delimiter2"/-->
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="ReplaceCalc/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:choose>
					<xsl:when test="FindReplaceOperation/@type = 'FindNext'">
						<xsl:value-of select="'Find Next'"/>
					</xsl:when>
					<xsl:when test="FindReplaceOperation/@type = 'ReplaceAndFind'">
						<xsl:value-of select="'Replace &amp; Find'"/>
					</xsl:when>
					<xsl:when test="FindReplaceOperation/@type = 'Replace'">
						<xsl:value-of select="'Replace'"/>
					</xsl:when>
					<xsl:when test="FindReplaceOperation/@type = 'ReplaceAll'">
						<xsl:value-of select="'Replace All'"/>
					</xsl:when>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 !
	 ! ============
	 ! FIELDS STEPS
	 ! ============
	 !
	 !-->
	<!--
	 ! Script step 76. Set Field
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '76']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamField"/>
				<xsl:call-template name="OutputCalculation">
					<xsl:with-param name="Calc" select="Calculation"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 147. Set Field By Name
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '147']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="OutputCalculation">
					<xsl:with-param name="Calc" select="TargetName/Calculation"/>
				</xsl:call-template>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
				<xsl:if test="Result">
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="Result/Calculation"/>
					</xsl:call-template>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 116. Set Next Serial Value
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '116']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamField"/>
				<xsl:call-template name="OutputCalculation">
					<xsl:with-param name="Calc" select="Calculation"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 61. Insert Text
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '61']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamSelect"/>
				<xsl:call-template name="ScriptStepParamField"/>
				<xsl:if test="Text/text()">
					<xsl:value-of select="$OPENQUOTES"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="Text"/>
					</xsl:call-template>
					<xsl:value-of select="$CLOSEQUOTES"/>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 77. Insert Calculated Result
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '77']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamSelect"/>
				<xsl:call-template name="ScriptStepParamField"/>
				<xsl:call-template name="OutputCalculation">
					<xsl:with-param name="Calc" select="Calculation"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 161. Insert from Device (fm13)
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '161']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamField"/>
				<xsl:value-of select="'Type'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:value-of select="InsertFrom/@value"/>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
				<xsl:if test="DeviceOptions/Camera">
					<xsl:value-of select="'Camera'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:value-of select="DeviceOptions/Camera/@choice"/>
					<xsl:call-template name="SIC.delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="DeviceOptions/Resolution">
					<xsl:value-of select="'Resolution'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:value-of select="DeviceOptions/Resolution/@choice"/>
					<xsl:call-template name="SIC.delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="DeviceOptions/MaxDuration/@state = 'True'">
					<xsl:value-of select="'Max duration'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="DeviceOptions/MaxDuration/Calculation"/>
					</xsl:call-template>
					<xsl:call-template name="SIC.delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="DeviceOptions/StartImmediately/@state = 'True'">
					<xsl:value-of select="'Start immediately'"/>
					<xsl:call-template name="SIC.delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="DeviceOptions/ScanFrom/@type = 'Field'">
					<xsl:value-of select="'Scan from'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:value-of select="'FIXME Field name'"/>
					<xsl:call-template name="SIC.delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="DeviceOptions/Title/Calculation">
					<xsl:value-of select="'Title'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="DeviceOptions/Title/Calculation"/>
					</xsl:call-template>
					<xsl:call-template name="SIC.delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="DeviceOptions/Message/Calculation">
					<xsl:value-of select="'Message'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="DeviceOptions/Message/Calculation"/>
					</xsl:call-template>
					<xsl:call-template name="SIC.delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="DeviceOptions/Prompt/Calculation">
					<xsl:value-of select="'Prompt'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="DeviceOptions/Prompt/Calculation"/>
					</xsl:call-template>
					<xsl:call-template name="SIC.delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="DeviceOptions/Presentation/@choice">
					<xsl:value-of select="'Presentation'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:choose>
						<xsl:when test="DeviceOptions/Presentation/@choice = 'Full Screen'">
							<xsl:value-of select="'Full Screen'"/>
						</xsl:when>
						<xsl:when test="DeviceOptions/Presentation/@choice = 'Overlay'">
							<xsl:value-of select="'Overlay'"/>
						</xsl:when>
						<xsl:when test="DeviceOptions/Presentation/@choice = 'Embedded'">
							<xsl:value-of select="'Embedded'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="DeviceOptions/Presentation/@choice"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:call-template name="SIC.delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="BarCodes">
					<!-- nothing is output -->
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 11. Insert from Index
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '11']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamSelect"/>
				<xsl:call-template name="ScriptStepParamField"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 12. Insert from Last Visited
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '12']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamSelect"/>
				<xsl:call-template name="ScriptStepParamField"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 160. Insert from URL (fmp12) 
	<Step enable="True" id="160" name="Insert from URL">
		<NoInteract state="True"/>
		<SelectAll state="True"/>
		<Calculation><![CDATA["http://www.mrwatson.de"]]></Calculation>
		<Field table="Students" id="2" name="Name"/>
	</Step>
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '160']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamVerifySSLCertificates"/>
				<xsl:call-template name="ScriptStepParamSelect"/>
				<xsl:call-template name="ScriptStepParamNoDialog"/>
				<xsl:call-template name="ScriptStepParamField"/>
				<xsl:if test="Calculation">
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="CURLOptions/Calculation">
					<xsl:value-of select="'cURL options'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="CURLOptions/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="DontEncodeURL/@state = 'True'">
					<xsl:value-of select="'Do not automatically encode URL'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 13. Insert Current Date
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '13']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamSelect"/>
				<xsl:call-template name="ScriptStepParamField"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 14. Insert Current Time
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '14']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamSelect"/>
				<xsl:call-template name="ScriptStepParamField"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 60. Insert Current User Name
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '60']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamSelect"/>
				<xsl:call-template name="ScriptStepParamField"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 56. Insert Picture
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '56']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamUniversalPathListReference"/>
				<!-- -->
				<xsl:call-template name="ScriptStepParamSpecifyFile"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 159. Insert Audio/Video (fmp12) 
	 ! <Step enable="True" id="159" name="Insert Audio/Video">
	 !	<UniversalPathList type="Reference">movie:../../../Music/iTunes/iTunes Music/Music/Lily Allen/It's Not Me, It's You/03 Not Fair.m4a</UniversalPathList>
	 ! </Step>
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '159']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamUniversalPathListReference"/>
				<!-- -->
				<xsl:call-template name="ScriptStepParamField"/>
				<xsl:call-template name="ScriptStepParamSpecifyFile"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 158. Insert PDF (fmp12) 
	<Step enable="True" id="158" name="Insert PDF">
		<UniversalPathList type="Embedded">image:../../../../../Library/Documentation/User Information.localized/AirPort Extreme and Bluetooth Regulatory Certification.pdf</UniversalPathList>
	</Step>
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '158']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamUniversalPathListReference"/>
				<!-- -->
				<xsl:call-template name="ScriptStepParamSpecifyFile"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 131. Insert File 
	<Step enable="True" id="131" name="Insert File">
		<UniversalPathList type="Embedded">file:../../../Documents/1 MrW/20071028_MrWatson2/fmWorkMate/fmWorkMate.fp7</UniversalPathList>
		<Field table="Students" id="3" name="Picture"/>
		<DialogOptions asFile="True" enable="True">
			<Storage type="UserChoice"/>
			<Compress type="UserChoice"/>
			<FilterList>
				<Filter id="0">
					<name>
						<Calculation><![CDATA["FileMaker 12 Files"]]></Calculation>
					</name>
					<List>*.fmp12</List>
				</Filter>
			</FilterList>
		</DialogOptions>
	</Step>
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '131']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="DialogOptions[@enable = 'True']/FilterList/Filter">
					<xsl:value-of select="'Filters'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:call-template name="ScriptStepParamUniversalPathListReference"/>
				<xsl:if test="DialogOptions[@enable = 'True']/Storage/@type = 'InsertOnly'">
					<xsl:value-of select="'Insert'"/>
					<xsl:value-of select="$delimiter3"/>
					<!-- -->
				</xsl:if>
				<xsl:if test="DialogOptions/@asFile = 'False'">
					<xsl:value-of select="'Display content'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:choose>
					<xsl:when test="DialogOptions[@enable = 'True']/Compress/@type = 'UserChoice'">
						<!-- no text -->
					</xsl:when>
					<xsl:when test="DialogOptions[@enable = 'True']/Compress/@type = 'Never'">
						<xsl:value-of select="'Never compress'"/>
						<xsl:value-of select="$delimiter3"/>
						<!-- -->
					</xsl:when>
					<xsl:when test="DialogOptions[@enable = 'True']/Compress/@type = 'WhenPossible'">
						<xsl:value-of select="'Compress when possible'"/>
						<xsl:value-of select="$delimiter3"/>
						<!-- -->
					</xsl:when>
				</xsl:choose>
				<xsl:call-template name="ScriptStepParamField"/>
				<xsl:call-template name="ScriptStepParamSpecifyFile"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 91. Replace Field Contents
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '91']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamNoDialog"/>
				<xsl:call-template name="ScriptStepParamField"/>
				<!-- -->
				<xsl:choose>
					<xsl:when test="With/@value='CurrentContents'">
						<xsl:value-of select="'Current contents'"/>
					</xsl:when>
					<xsl:when test="With/@value='SerialNumbers'">
						<xsl:value-of select="'Serial numbers'"/>
						<xsl:if test="$pVerbose = 'True'">
							<xsl:value-of select="$delimiter2"/>
							<xsl:choose>
								<xsl:when test="SerialNumbers/@UseEntryOptions = 'True'">
									<xsl:value-of select="'Use Entry Options'"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="SerialNumbers/@UpdateEntryOptions = 'False'">
											<xsl:value-of select="'Update Entry Options'"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="'Custom values'"/>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:value-of select="$delimiter2"/>
									<xsl:value-of select="SerialNumbers/@InitialValue"/>
									<xsl:value-of select="' + '"/>
									<xsl:value-of select="SerialNumbers/@increment"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
						<xsl:value-of select="$delimiter3"/>
					</xsl:when>
					<xsl:when test="With/@value='Calculation'">
						<xsl:call-template name="OutputCalculation">
							<xsl:with-param name="Calc" select="Calculation"/>
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 40. Relookup Field Contents
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '40']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamNoDialog"/>
				<xsl:call-template name="ScriptStepParamField"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 132. Export Field Contents
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '132']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamField"/>
				<!-- -->
				<xsl:if test="UniversalPathList">
					<xsl:call-template name="ScriptStepParamExportFileParameters"/>
				</xsl:if>
				<xsl:call-template name="ScriptStepParamCreateDirectories"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!-- 
	 !
	 ! =============
	 ! RECORDS STEPS
	 ! =============
	 !
	 !-->
	<!--
	 ! Script step 7. New Record/Request
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '7']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 8. Duplicate Record/Request
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '8']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 9. Delete Record/Request
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '9']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamNoDialog"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 104. Delete Portal Row
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '104']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamNoDialog"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 10. Delete All Records
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '10']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamNoDialog"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 133. Open Record/Request
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '133']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 51. Revert Record/Request
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '51']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamNoDialog"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 75. Commit Records/Requests
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '75']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="Option/@state = 'True'">
					<xsl:value-of select="'Skip data entry validation'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:call-template name="ScriptStepParamNoDialog"/>
				<!-- -->
				<xsl:if test="ESSForceCommit/@state = 'True'">
					<xsl:value-of select="'Force Commit'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 101. Copy Record/Request
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '101']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 98. Copy All Records/Requests
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '98']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 35. Import Records
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '35']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamVerifySSLCertificates"/>
				<xsl:call-template name="ScriptStepParamNoDialog"/>
				<xsl:call-template name="ScriptStepParamDataSource"/>
				<!--
				 !
				 ! Import Profile Options
				 !
				 !-->
				<xsl:if test="Restore/@state = 'True' or DataSourceType/@value = 'Folder'">
					<xsl:if test="Profile/@IncludeEnclosedFolders = 'True'">
						<xsl:value-of select="'Include all enclosed folders'"/>
						<xsl:call-template name="SIC.delimiter3"/>
					</xsl:if>
					<!-- -->
					<xsl:choose>
						<xsl:when test="Profile/@PictureAndMovieImport = 'True'">
							<xsl:value-of select="'Picture and movie files'"/>
							<xsl:call-template name="SIC.delimiter3"/>
							<!-- -->
						</xsl:when>
						<xsl:when
							test="DataSourceType/@value = 'Folder' and Profile/@PictureAndMovieImport = 'False'">
							<xsl:value-of select="'Text files'"/>
							<xsl:value-of select="$delimiter3"/>
							<!-- -->
						</xsl:when>
					</xsl:choose>
					<xsl:if test="Profile/@ImportByReference = 'True'">
						<xsl:value-of select="'Import only a reference'"/>
						<xsl:value-of select="$delimiter3"/>
						<!-- -->
					</xsl:if>
					<!-- Import method (Record) -->
					<xsl:choose>
						<xsl:when test="ImportOptions/@method = 'Add'">
							<xsl:value-of select="'Add'"/>
							<xsl:call-template name="SIC.delimiter3"/>
							<!-- -->
						</xsl:when>
						<xsl:when test="ImportOptions/@method = 'UpdateOnMatch'">
							<xsl:value-of select="'Update matching'"/>
							<xsl:call-template name="SIC.delimiter3"/>
							<!-- -->
						</xsl:when>
						<xsl:when test="ImportOptions/@method = 'Update'">
							<xsl:value-of select="'Update existing'"/>
							<xsl:call-template name="SIC.delimiter3"/>
							<!-- -->
						</xsl:when>
					</xsl:choose>
					<!-- Excoding -->
					<xsl:if test="ImportOptions/@CharacterSet">
						<xsl:choose>
							<xsl:when test="ImportOptions/@CharacterSet = 'Windows'">
								<xsl:value-of select="'Windows ANSI'"/>
							</xsl:when>
							<xsl:when test="ImportOptions/@CharacterSet = 'DOS'">
								<xsl:value-of select="'DOS OEM'"/>
							</xsl:when>
							<xsl:when test="ImportOptions/@CharacterSet = 'Macintosh'">
								<xsl:value-of select="'Mac Roman'"/>
							</xsl:when>
							<xsl:when test="ImportOptions/@CharacterSet = 'Unicode'">
								<xsl:value-of select="'Unicode'"/>
							</xsl:when>
							<xsl:when test="ImportOptions/@CharacterSet = 'UnicodeBE'">
								<xsl:value-of select="'Unicode (big endian)'"/>
							</xsl:when>
							<xsl:when test="ImportOptions/@CharacterSet = 'UTF-8'">
								<xsl:value-of select="'UTF-8'"/>
							</xsl:when>
							<xsl:when test="ImportOptions/@CharacterSet = 'ShiftJIS'">
								<xsl:value-of select="'Shift JIS'"/>
							</xsl:when>
							<xsl:when test="ImportOptions/@CharacterSet = 'ChineseSimplified'">
								<xsl:value-of select="'Simplified Chinese (GB)'"/>
							</xsl:when>
							<xsl:when test="ImportOptions/@CharacterSet = 'ChineseTraditional'">
								<xsl:value-of select="'Traditional Chinese (Big-5)'"/>
							</xsl:when>
							<xsl:when test="ImportOptions/@CharacterSet = 'EUC-KR'">
								<xsl:value-of select="'Korean (EUC-KR)'"/>
							</xsl:when>
						</xsl:choose>
						<xsl:call-template name="SIC.delimiter3"/>
					</xsl:if>
					<xsl:if test="$pVerbose = 'True'">
						<!-- Options -->
						<!-- Import method (Field) -->
						<xsl:if test="ImportOptions/@MatchFieldNames = 'True'">
							<xsl:value-of select="'Match Field Names'"/>
							<xsl:call-template name="SIC.delimiter3"/>
						</xsl:if>
						<!-- -->
						<xsl:value-of select="'Auto Enter'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:call-template name="Set_state">
							<xsl:with-param name="state" select="ImportOptions/@AutoEnter"/>
						</xsl:call-template>
						<xsl:call-template name="SIC.delimiter3"/>
						<!-- -->
						<xsl:if test="ImportOptions/@PreserveContainer = 'True'">
							<xsl:value-of select="'Preserve external container storage'"/>
							<xsl:call-template name="SIC.delimiter3"/>
						</xsl:if>
						<!-- -->
						<xsl:if test="ImportOptions/@SplitRepetitions = 'True'">
							<xsl:value-of select="'Split Repetitions'"/>
							<xsl:call-template name="SIC.delimiter3"/>
						</xsl:if>
						<!-- -->
						<xsl:value-of select="'Source'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:choose>
							<xsl:when test="DataSourceType/@value = 'Folder'">
								<xsl:value-of select="'folder'"/>
								<xsl:call-template name="SIC.delimiter3"/>
							</xsl:when>
							<xsl:when test="DataSourceType/@value = 'FMP '">
								<xsl:value-of select="'{table'"/>
								<xsl:value-of select="Profile/@table"/>
								<xsl:value-of select="'}'"/>
								<xsl:call-template name="SIC.delimiter3"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="SIC.delimiter3"/>
							</xsl:otherwise>
						</xsl:choose>
						<!-- -->
						<xsl:value-of select="'Target'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="Table/@name"/>
						<xsl:call-template name="SIC.delimiter3"/>
						<!-- -->
						<!-- List hard coded field mapping -->
						<xsl:if test="ImportOptions/@MatchFieldNames != 'True'">
							<xsl:value-of select="'Import Fields'"/>
							<xsl:value-of select="$delimiter2"/>
							<xsl:value-of select="$delimiter3"/>
							<!-- -->
							<xsl:for-each select="TargetFields/Field">
								<xsl:choose>
									<xsl:when test="@map = 'Match'">
										<!-- Match field -->
										<xsl:value-of select="'Field'"/>
										<xsl:value-of select="' '"/>
										<xsl:value-of select="position()"/>
										<xsl:value-of select="$TAB"/>
										<xsl:value-of select="'==='"/>
										<xsl:value-of select="$TAB"/>
										<xsl:value-of select="@name"/>
										<xsl:value-of select="$delimiter3"/>
									</xsl:when>
									<xsl:when test="@map = 'Import'">
										<!-- Import field -->
										<xsl:value-of select="'Field'"/>
										<xsl:value-of select="' '"/>
										<xsl:value-of select="position()"/>
										<xsl:value-of select="$TAB"/>
										<xsl:value-of select="'--&gt;'"/>
										<xsl:value-of select="$TAB"/>
										<xsl:value-of select="@name"/>
										<xsl:value-of select="$delimiter3"/>
									</xsl:when>
									<xsl:when
										test="following-sibling::Field[@map = 'Import' or @map = 'Match']">
										<!-- Placeholder field -->
										<xsl:value-of select="'Field'"/>
										<xsl:value-of select="' '"/>
										<xsl:value-of select="position()"/>
										<xsl:value-of select="$TAB"/>
										<xsl:value-of select="' : '"/>
										<xsl:value-of select="$TAB"/>
										<xsl:value-of select="@name"/>
										<xsl:value-of select="$delimiter3"/>
									</xsl:when>
									<xsl:otherwise>
										<!-- Unimportant field -->
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</xsl:if>
					</xsl:if>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
		<!--
		<xsl:value-of select="'Destination:'"/>
		<xsl:value-of select="'::'"/>
		<xsl:value-of select="$newrecord"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:for-each select="TargetFields/Field">
					<xsl:value-of select="'Spalte '"/>
					<xsl:value-of select="position()"/>
					<xsl:value-of select="$delimiter3"/>
					<xsl:choose>
						<xsl:when test="@map='Import'">
							<xsl:value-of select="'-&gt;'"/>
							<xsl:value-of select="$delimiter3"/>
							<xsl:value-of select="@name"/>
						</xsl:when>
						<xsl:when test="@map='DoNotImport'">
							<xsl:value-of select="'XXX'"/>
							<xsl:value-of select="$delimiter3"/>
						</xsl:when>
						<xsl:when test="@map='Match'">
							<xsl:value-of select="'==='"/>
							<xsl:value-of select="$delimiter3"/>
							<xsl:value-of select="@name"/>
						</xsl:when>
					</xsl:choose>
					<xsl:value-of select="$newrecord"/>
				</xsl:for-each>
			</xsl:with-param>
		</xsl:call-template>
		 !-->
	</xsl:template>
	<!--
	 ! Script step 36. Export Records
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '36']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamNoDialog"/>
				<xsl:if test="$pVerbose != 'True'">
					<xsl:call-template name="ScriptStepParamCreateDirectories"/>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="Profile/@XSLType">
						<xsl:call-template name="SpecifyXMLandXSLOptions"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="ScriptStepParamExportFileParameters"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="$pVerbose = 'True'">
					<xsl:for-each select="ExportEntries/ExportEntry">
						<xsl:value-of select="'Field'"/>
						<xsl:value-of select="' '"/>
						<xsl:value-of select="position()"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:for-each select="Field">
							<xsl:value-of select="@table"/>
							<xsl:value-of select="'::'"/>
							<xsl:value-of select="@name"/>
							<xsl:value-of select="$delimiter3"/>
						</xsl:for-each>
					</xsl:for-each>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 143. Save Records as Excel
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '143']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="Restore/@state = 'True'">
					<xsl:value-of select="'Restore'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:call-template name="ScriptStepParamNoDialog"/>
				<xsl:call-template name="ScriptStepParamExportFileParameters"/>
				<xsl:if test="Restore/@state = 'True'">
					<xsl:call-template name="ScriptStepParamSaveType"/>
				</xsl:if>
				<xsl:call-template name="ScriptStepParamCreateDirectories"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 144. Save Records as PDF
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '144']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="Restore/@state = 'True'">
					<xsl:value-of select="'Restore'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="Option/@state = 'True'">
					<xsl:value-of select="'Append'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:call-template name="ScriptStepParamNoDialog"/>
				<xsl:call-template name="ScriptStepParamExportFileParameters"/>
				<!-- PDF Options -->
				<xsl:if test="Restore/@state = 'True'">
					<xsl:choose>
						<xsl:when test="PDFOptions/@source = 'RecordsBeingBrowsed'">
							<xsl:value-of select="'Records being browsed'"/>
							<xsl:value-of select="$delimiter3"/>
							<!-- -->
						</xsl:when>
						<xsl:when test="PDFOptions/@source = 'CurrentRecord'">
							<xsl:value-of select="'Current record'"/>
							<xsl:value-of select="$delimiter3"/>
							<!-- -->
						</xsl:when>
						<xsl:when test="PDFOptions/@source = 'BlankRecord'">
							<xsl:value-of select="'Blank record'"/>
							<xsl:value-of select="', '"/>
							<xsl:choose>
								<xsl:when test="PDFOptions/@appearance = 'AsFormatted'">
									<xsl:value-of select="'as formatted'"/>
								</xsl:when>
								<xsl:when test="PDFOptions/@appearance = 'WithBoxes'">
									<xsl:value-of select="'with boxes'"/>
								</xsl:when>
								<xsl:when test="PDFOptions/@appearance = 'WithUnderlines'">
									<xsl:value-of select="'with underlines'"/>
								</xsl:when>
								<xsl:when test="PDFOptions/@appearance = 'WithPlaceholderText'">
									<xsl:value-of select="'with placeholder text'"/>
								</xsl:when>
							</xsl:choose>
							<xsl:value-of select="$delimiter3"/>
							<!-- -->
						</xsl:when>
					</xsl:choose>
				</xsl:if>
				<xsl:call-template name="ScriptStepParamCreateDirectories"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 152. Save Records as Snapshot Link
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '152']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamExportFileParameters"/>
				<xsl:call-template name="ScriptStepParamSaveType"/>
				<xsl:call-template name="ScriptStepParamCreateDirectories"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 182. Truncate Table
	
	
	<Step enable="True" id="182" name="Truncate Table"><NoInteract state="False"></NoInteract>
		<BaseTable id="-1" name="&lt;Current Table&gt;"></BaseTable></Step>
	
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '182']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamNoDialog"/>
				<xsl:value-of select="'Table'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:choose>
					<xsl:when test="BaseTable/@id = '-1'">
						<xsl:value-of select="'&lt;Current Table&gt;'"/>
					</xsl:when>
					<xsl:when test="BaseTable/@name = ''">
						<xsl:value-of select="'&lt;Table Missing&gt;'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$OPENQUOTES"/>
						<xsl:value-of select="BaseTable/@name"/>
						<xsl:value-of select="$CLOSEQUOTES"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!-- 
	 !
	 ! ================
	 ! FOUND SETS STEPS
	 ! ================
	 !
	 !-->
	<!--
	 ! Script step 28. Perform Find
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '28']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamQuery"/>
				<xsl:call-template name="ScriptStepParamRestore"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 150. Perform Quick Find
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '150']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="OutputCalculation">
					<xsl:with-param name="Calc" select="Calculation"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 126. Constrain Found Set
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '126']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamQuery"/>
				<xsl:call-template name="ScriptStepParamRestore"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 127. Extend Found Set
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '127']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamQuery"/>
				<xsl:call-template name="ScriptStepParamRestore"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 24. Modify Last Find
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '24']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 23. Show All Records
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '23']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 27. Show Omitted Only
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '27']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 25. Omit Record
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '25']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 26. Omit Multiple Records
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '26']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamNoDialog"/>
				<xsl:call-template name="OutputCalculation">
					<xsl:with-param name="Calc" select="Calculation"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 39. Sort Records
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '39']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="Restore/@state = 'True'">
					<xsl:value-of select="'Restore'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:call-template name="ScriptStepParamNoDialog"/>
				<!-- -->
				<xsl:if test="$pVerbose = 'True'">
					<xsl:if test="SortList/@Maintain = 'True'">
						<xsl:value-of select="'Keep Sorted'"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<xsl:if test="SortList/@Value = 'True'">
						<xsl:value-of select="'Value'"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<xsl:for-each select="SortList/Sort">
						<!-- -->
						<xsl:choose>
							<xsl:when test="@type = 'Ascending'">
								<xsl:value-of select="'+'"/>
							</xsl:when>
							<xsl:when test="@type = 'Descending'">
								<xsl:value-of select="'-'"/>
							</xsl:when>
							<xsl:when test="@type = 'Custom'">
								<xsl:value-of select="'~'"/>
								<xsl:value-of select="$QUOT"/>
								<xsl:value-of select="ValueList/@name"/>
								<xsl:value-of select="$QUOT"/>
							</xsl:when>
						</xsl:choose>
						<xsl:value-of select="PrimaryField/Field/@table"/>
						<xsl:value-of select="'::'"/>
						<xsl:value-of select="PrimaryField/Field/@name"/>
						<xsl:if test="SummaryField">
							<xsl:value-of select="$delimiter2"/>
							<xsl:value-of select="SummaryField/Field/@table"/>
							<xsl:value-of select="'::'"/>
							<xsl:value-of select="SummaryField/Field/@name"/>
						</xsl:if>
						<xsl:if test="OverrideLanguage/@language">
							<xsl:value-of select="'('"/>
							<xsl:value-of select="OverrideLanguage/@language"/>
							<xsl:value-of select="')'"/>
						</xsl:if>
						<xsl:value-of select="$delimiter3"/>
					</xsl:for-each>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 154. Sort Records by Field
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '154']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:choose>
					<xsl:when test="SortRecordsByField/@value = 'SortAscending'">
						<xsl:value-of select="'Ascending'"/>
					</xsl:when>
					<xsl:when test="SortRecordsByField/@value = 'SortDescending'">
						<xsl:value-of select="'Descending'"/>
					</xsl:when>
					<xsl:when test="SortRecordsByField/@value = 'SortValueList'">
						<xsl:value-of select="'Associated value list'"/>
					</xsl:when>
				</xsl:choose>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
				<xsl:call-template name="ScriptStepParamField"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 21. Unsort Records
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '21']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 155. Find Matching Records -->
	<!--
	<Step enable="True" id="155" name="Find Matching Records">
		<FindMatchingRecordsByField value="FindMatchingReplace"/>
		<Field table="Students" id="2" name="Name"/>
	</Step>
	<Step enable="True" id="155" name="Find Matching Records">
		<FindMatchingRecordsByField value="FindMatchingConstrain"/>
		<Field table="Students" id="2" name="Name"/>
	</Step>
	<Step enable="True" id="155" name="Find Matching Records">
		<FindMatchingRecordsByField value="FindMatchingExtend"/>
		<Field table="Students" id="2" name="Name"/>
	</Step>
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '155']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:choose>
					<xsl:when test="FindMatchingRecordsByField/@value = 'FindMatchingReplace'">
						<xsl:value-of select="'Replace'"/>
					</xsl:when>
					<xsl:when test="FindMatchingRecordsByField/@value = 'FindMatchingConstrain'">
						<xsl:value-of select="'Constrain'"/>
					</xsl:when>
					<xsl:when test="FindMatchingRecordsByField/@value = 'FindMatchingExtend'">
						<xsl:value-of select="'Extend'"/>
					</xsl:when>
				</xsl:choose>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
				<xsl:call-template name="ScriptStepParamField"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!-- 
	 !
	 ! =============
	 ! WINDOWS STEPS
	 ! ============
	 !
	 !-->
	<!--
	 ! Script step 122. New Window
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '122']">
		<xsl:variable name="NewWndStylesStyles" select="NewWndStyles/@Styles"/>
		<xsl:variable name="NewWndStylesDocument"
			select="($NewWndStylesStyles mod (2 * 2)) &gt; ($NewWndStylesStyles mod 2)"/>
		<xsl:variable name="NewWndStylesDialog"
			select="($NewWndStylesStyles mod (2 * 4)) &gt; ($NewWndStylesStyles mod 4)"/>
		<xsl:variable name="NewWndStylesFloating"
			select="($NewWndStylesStyles mod (2 * 256)) &gt; ($NewWndStylesStyles mod 256)"/>
		<xsl:variable name="NewWndStylesResize"
			select="($NewWndStylesStyles mod (2 * 512)) &gt; ($NewWndStylesStyles mod 512)"/>
		<xsl:variable name="NewWndStylesClose"
			select="($NewWndStylesStyles mod (2 * 65536)) &gt; ($NewWndStylesStyles mod 65536)"/>
		<xsl:variable name="NewWndStylesMinimize"
			select="($NewWndStylesStyles mod (2 * 131072)) &gt; ($NewWndStylesStyles mod 131072)"/>
		<xsl:variable name="NewWndStylesMaximize"
			select="($NewWndStylesStyles mod (2 * 262144)) &gt; ($NewWndStylesStyles mod 262144)"/>
		<xsl:variable name="NewWndStylesZoom"
			select="($NewWndStylesStyles mod (2 * 524288)) &gt; ($NewWndStylesStyles mod 524288)"/>
		<xsl:variable name="NewWndStylesDimParentWindow"
			select="($NewWndStylesStyles mod (2 * 1048576)) &gt; ($NewWndStylesStyles mod 1048576)"/>
		<!--2147483648-->
		<!--4294967296-->
		<!-- -->
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:value-of select="'Style'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:choose>
					<xsl:when test="not(NewWndStyles) or $NewWndStylesDocument">
						<xsl:value-of select="'Document'"/>
					</xsl:when>
					<!--<xsl:when test="$NewWndStylesDialog">
						<xsl:value-of select="'Dialog'"/>
					</xsl:when>
					<xsl:when test="$NewWndStylesFloating">
						<xsl:value-of select="'Floating Document'"/>
					</xsl:when>
					<xsl:when test="NewWndStyles/@Style='Card'">
						<xsl:value-of select="'Card'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'Unknown Window Style'"/>
					</xsl:otherwise>-->
					<xsl:otherwise>
						<xsl:value-of select="NewWndStyles/@Style"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
				<xsl:if test="Name/Calculation">
					<xsl:value-of select="'Name'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="Name/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:value-of select="'Using layout'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:call-template name="ScriptStepParamLayoutDestination"/>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
				<xsl:if test="Height/Calculation">
					<xsl:value-of select="'Height'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="Height/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<xsl:if test="Width/Calculation">
					<xsl:value-of select="'Width'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="Width/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<xsl:if test="DistanceFromTop/Calculation">
					<xsl:value-of select="'Top'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="DistanceFromTop/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<xsl:if test="DistanceFromLeft/Calculation">
					<xsl:value-of select="'Left'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="DistanceFromLeft/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<xsl:if test="$pVerbose = 'True'">
					<!-- Verbose -->
					<xsl:if test="not($NewWndStylesClose)">
						<xsl:value-of select="'No Close'"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<xsl:if test="not($NewWndStylesMinimize)">
						<xsl:value-of select="'No Minimize'"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<xsl:if test="not($NewWndStylesMaximize)">
						<xsl:value-of select="'No Maximize'"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<xsl:if test="not($NewWndStylesZoom)">
						<xsl:value-of select="'No Zoom'"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<xsl:if test="not($NewWndStylesResize)">
						<xsl:value-of select="'No Resize'"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<xsl:if test="not($NewWndStylesDimParentWindow)">
						<xsl:value-of select="'No Dim'"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 123. Select Window
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '123']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamSelectWindow">
					<xsl:with-param name="Label" select="'Name'"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 121. Close Window
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '121']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamSelectWindow">
					<xsl:with-param name="Label" select="'Name'"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 31. Adjust Window
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '31']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:choose>
					<xsl:when test="WindowState/@value = 'Hide'">
						<xsl:value-of select="'Hide'"/>
					</xsl:when>
					<xsl:when test="WindowState/@value = 'Maximize'">
						<xsl:value-of select="'Maximize'"/>
					</xsl:when>
					<xsl:when test="WindowState/@value = 'Minimize'">
						<xsl:value-of select="'Minimize'"/>
					</xsl:when>
					<xsl:when test="WindowState/@value = 'ResizeToFit'">
						<xsl:value-of select="'Resize to Fit'"/>
					</xsl:when>
					<xsl:when test="WindowState/@value = 'Restore'">
						<xsl:value-of select="'Restore'"/>
					</xsl:when>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 119. Move/Resize Window
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '119']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamSelectWindow">
					<xsl:with-param name="Label" select="'Name'"/>
				</xsl:call-template>
				<xsl:if test="Height/Calculation">
					<xsl:value-of select="'Height'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="Height/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="Width/Calculation">
					<xsl:value-of select="'Width'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="Width/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="DistanceFromTop/Calculation">
					<xsl:value-of select="'Top'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="DistanceFromTop/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="DistanceFromLeft/Calculation">
					<xsl:value-of select="'Left'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="DistanceFromLeft/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 120. Arrange All Windows
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '120']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:choose>
					<xsl:when test="WindowArrangement/@value = 'BringAllToFront'">
						<xsl:value-of select="'Bring All To Front'"/>
					</xsl:when>
					<xsl:when test="WindowArrangement/@value = 'Cascade'">
						<xsl:value-of select="'Cascade Window'"/>
					</xsl:when>
					<xsl:when test="WindowArrangement/@value = 'TileHorizontally'">
						<xsl:value-of select="'Tile Horizontally'"/>
					</xsl:when>
					<xsl:when test="WindowArrangement/@value = 'TileVertically'">
						<xsl:value-of select="'Tile Vertically'"/>
					</xsl:when>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 79. Freeze Window
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '79']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 80. Refresh Window
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '80']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="Option/@state = 'True'">
					<xsl:value-of select="'Flush cached join results'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="FlushSQLData/@state = 'True'">
					<xsl:value-of select="'Flush cached external data'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 81. Scroll Window
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '81']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:choose>
					<xsl:when test="ScrollOperation/@value = 'Home'">
						<xsl:value-of select="'Home'"/>
					</xsl:when>
					<xsl:when test="ScrollOperation/@value = 'End'">
						<xsl:value-of select="'End'"/>
					</xsl:when>
					<xsl:when test="ScrollOperation/@value = 'PageUp'">
						<xsl:value-of select="'Page Up'"/>
					</xsl:when>
					<xsl:when test="ScrollOperation/@value = 'PageDown'">
						<xsl:value-of select="'Page Down'"/>
					</xsl:when>
					<xsl:when test="ScrollOperation/@value = 'ToSelection'">
						<xsl:value-of select="'To Selection'"/>
					</xsl:when>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 166. Show/Hide Menubar
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '166']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamLock_state">
					<xsl:with-param name="state" select="Lock/@state"/>
				</xsl:call-template>
				<xsl:value-of select="ShowHide/@value"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 29. Show/Hide Toolbars
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '29']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="Lock/@state = 'True'">
					<xsl:value-of select="'Lock'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<xsl:if test="IncludeEditRecordToolbar/@state = 'True'">
					<xsl:value-of select="'Include Edit Record Toolbar'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<xsl:value-of select="ShowHide/@value"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 92. Show/Hide Text Ruler
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '92']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:value-of select="ShowHide/@value"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 124. Set Window Title
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '124']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamSelectWindow">
					<xsl:with-param name="Label" select="'Of Window'"/>
				</xsl:call-template>
				<xsl:if test="NewName/Calculation">
					<xsl:value-of select="'New Title'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="NewName/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 97. Set Zoom Level
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '97']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:value-of select="'Lock'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:call-template name="Set_state">
					<xsl:with-param name="state" select="Lock/@state"/>
				</xsl:call-template>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
				<xsl:choose>
					<xsl:when test="Zoom/@value = 'ZoomIn'">
						<xsl:value-of select="'Zoom In'"/>
					</xsl:when>
					<xsl:when test="Zoom/@value = 'ZoomOut'">
						<xsl:value-of select="'Zoom Out'"/>
					</xsl:when>
					<xsl:when test="Zoom/@value">
						<xsl:value-of select="Zoom/@value"/>
						<xsl:value-of select="'%'"/>
					</xsl:when>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 30. View As
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '30']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:choose>
					<xsl:when test="View/@value = 'Cycle'">
						<xsl:value-of select="'Cycle'"/>
					</xsl:when>
					<xsl:when test="View/@value = 'Form'">
						<xsl:value-of select="'View as Form'"/>
					</xsl:when>
					<xsl:when test="View/@value = 'List'">
						<xsl:value-of select="'View as List'"/>
					</xsl:when>
					<xsl:when test="View/@value = 'Table'">
						<xsl:value-of select="'View as Table'"/>
					</xsl:when>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!-- 
	 !
	 ! ===========
	 ! FILES STEPS
	 ! ===========
	 !
	 !-->
	<!--
	 ! Script step 82. New File
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '82']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 33. Open File
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '33']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:value-of select="'Open hidden'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:call-template name="Set_state">
					<xsl:with-param name="state" select="Option/@state"/>
				</xsl:call-template>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
				<xsl:call-template name="ExternalDataSourceName"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 34. Close File
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '34']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ExternalDataSourceName">
					<xsl:with-param name="OrCurrentFile"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 139. Convert File
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '139']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="Option/@state = 'False'">
					<xsl:value-of select="'Open File'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="SkipIndexes/@state = 'True'">
					<xsl:value-of select="'Skip Indexes'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:call-template name="ScriptStepParamNoDialog"/>
				<!-- FIXME - Convert File from XML - ??? -->
				<xsl:call-template name="ScriptStepParamDataSource"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 84. Set Multi-User
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '84']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:choose>
					<xsl:when test="MultiUser/@value = 'True'">
						<xsl:value-of select="'On'"/>
					</xsl:when>
					<xsl:when test="MultiUser/@value = 'OnHidden'">
						<xsl:value-of select="'On (Hidden)'"/>
					</xsl:when>
					<xsl:when test="MultiUser/@value = 'False'">
						<xsl:value-of select="'Off'"/>
					</xsl:when>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 94. Set Use System Formats
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '94']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="Set_state">
					<xsl:with-param name="state" select="Set/@state"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 37. Save a Copy as
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '37']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamSpecifyOutputFile">
					<xsl:with-param name="SaveAsType" select="SaveAsType"/>
				</xsl:call-template>
				<xsl:call-template name="ScriptStepParamCreateDirectories"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 95. Recover File
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '95']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamNoDialog"/>
				<xsl:call-template name="ScriptStepParamSpecifyFile"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 42. Print Setup
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '42']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="Restore/@state = 'True'">
					<xsl:choose>
						<xsl:when test="$pVerbose = 'True'">
							<xsl:call-template name="ScriptStepParamPageFormat"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'Restore'"/>
							<xsl:if test="1 = 0">
								<xsl:value-of select="$delimiter2"/>
								<xsl:value-of select="'unknown'"/>
							</xsl:if>
							<xsl:value-of select="$delimiter3"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<!-- -->
				<xsl:call-template name="ScriptStepParamNoDialog"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 43. Print
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '43']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="Restore/@state = 'True'">
					<xsl:if test="$pVerbose = 'True'">
						<!-- Print type -->
						<xsl:variable name="PrintSettingsPrintType"
							select="PrintSettings/@PrintType"/>
						<xsl:choose>
							<xsl:when test="$PrintSettingsPrintType = 'BrowsedRecords'">
								<xsl:value-of select="'Records being browsed'"/>
							</xsl:when>
							<xsl:when test="$PrintSettingsPrintType = 'CurrentRecord'">
								<xsl:value-of select="'Current Record'"/>
							</xsl:when>
							<xsl:when test="$PrintSettingsPrintType = 'BlankAsFormatted'">
								<xsl:value-of select="'Blank record, as formatted'"/>
							</xsl:when>
							<xsl:when test="$PrintSettingsPrintType = 'BlankBoxed'">
								<xsl:value-of select="'Blank record, with boxes'"/>
							</xsl:when>
							<xsl:when test="$PrintSettingsPrintType = 'BlankUnderscore'">
								<xsl:value-of select="'Blank record, with underlines'"/>
							</xsl:when>
							<xsl:when test="$PrintSettingsPrintType = 'BlankWithPlaceholder'">
								<xsl:value-of select="'Blank record, with placeholder text'"/>
							</xsl:when>
						</xsl:choose>
						<xsl:value-of select="$delimiter3"/>

						<!-- Pages -->
						<xsl:if test="PrintSettings/@AllPages = 'True'">
							<xsl:value-of select="'All Pages'"/>
							<xsl:value-of select="$delimiter3"/>
						</xsl:if>
						<xsl:if test="PrintSettings/@FromPage or PrintSettings/@ToPage">
							<xsl:value-of select="'Pages'"/>
							<xsl:value-of select="$delimiter2"/>
							<xsl:value-of
								select="concat(PrintSettings/@FromPage, ' to ', PrintSettings/@ToPage)"/>
							<xsl:value-of select="$delimiter3"/>
						</xsl:if>
						<!-- Copies -->
						<xsl:if test="PrintSettings/@NumCopies and PrintSettings/@NumCopies != 1">
							<xsl:value-of select="'Number of copies'"/>
							<xsl:value-of select="$delimiter2"/>
							<xsl:value-of select="PrintSettings/@NumCopies"/>
							<xsl:value-of select="$delimiter3"/>
						</xsl:if>
						<!-- Collated -->
						<xsl:if test="PrintSettings/@collated = 'True'">
							<xsl:value-of select="'Collated'"/>
							<xsl:value-of select="$delimiter3"/>
						</xsl:if>
						<xsl:if test="PrintSettings/@PageNumberingOffset != '0'">
							<xsl:value-of select="'Number pages from'"/>
							<xsl:value-of select="$delimiter2"/>
							<xsl:value-of select="PrintSettings/@PageNumberingOffset"/>
							<xsl:value-of select="$delimiter3"/>
						</xsl:if>
						<xsl:if test="PrintSettings/@PrintToFile = 'True'">
							<xsl:value-of select="'Print to file'"/>
							<xsl:value-of select="$delimiter3"/>
						</xsl:if>
						<!-- Page Format-->
						<xsl:call-template name="ScriptStepParamPageFormat"/>
					</xsl:if>
					<!-- -->
					<xsl:value-of select="'Restore'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:if test="PrintSettings/PlatformData/@PlatformType = 'PrNm'">
						<xsl:call-template name="decodePrintSettingsPrinterData">
							<xsl:with-param name="hex" select="PrintSettings/PlatformData/text()"/>
						</xsl:call-template>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
				</xsl:if>
				<!-- -->
				<xsl:call-template name="ScriptStepParamNoDialog"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!-- 
	 !
	 ! ==============
	 ! ACCOUNTS STEPS
	 ! ==============
	 !
	 !-->
	<!--
	 ! Script step 134. Add Account
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '134']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="AccountName">
					<xsl:value-of select="'Account Name'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="AccountName/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="Password">
					<xsl:value-of select="'Password'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="ScriptStepPassword">
						<xsl:with-param name="Password" select="Password/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:value-of select="'Privilege Set'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:choose>
					<xsl:when test="not(PrivilegeSet/@name)">
						<xsl:value-of select="'&lt;unknown&gt;'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="PrivilegeSet/@name"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
				<xsl:if test="ChgPwdOnNextLogin/@value = 'True'">
					<xsl:value-of select="'Expire password'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 135. Delete Account
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '135']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="AccountName">
					<xsl:value-of select="'Account Name'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="AccountName/Calculation"/>
					</xsl:call-template>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 136. Reset Account Password
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '136']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="AccountName">
					<xsl:value-of select="'Account Name'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="AccountName/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="Password">
					<xsl:value-of select="'Password'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="ScriptStepPassword">
						<xsl:with-param name="Password" select="Password/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="ChgPwdOnNextLogin/@value = 'True'">
					<xsl:value-of select="'Expire password'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 83. Change Password
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '83']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="OldPassword">
					<xsl:value-of select="'Old Password'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="ScriptStepPassword">
						<xsl:with-param name="Password" select="OldPassword/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="NewPassword">
					<!-- fm15 Just 'Password', not 'New Password'-->
					<xsl:value-of select="'Password'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="ScriptStepPassword">
						<xsl:with-param name="Password" select="NewPassword/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:call-template name="ScriptStepParamNoDialog"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 137. Enable Account
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '137']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="AccountName">
					<xsl:value-of select="'Account Name'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="AccountName/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:value-of select="AccountOperation/@value"/>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 138. Re-Login
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '138']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="AccountName">
					<xsl:value-of select="'Account Name'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="AccountName/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="Password">
					<xsl:value-of select="'Password'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="ScriptStepPassword">
						<xsl:with-param name="Password" select="Password/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:call-template name="ScriptStepParamNoDialog"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!-- 
	 !
	 ! ==============
	 ! SPELLING STEPS
	 ! ==============
	 !
	 !-->
	<!--
	 ! Script step 18. Check Selection
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '18']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamSelect"/>
				<xsl:call-template name="ScriptStepParamField"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 19. Check Record
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '19']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 20. Check Found Set
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '20']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 106. Correct Word
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '106']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 107. Spelling Options
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '107']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 108. Select Dictionaries
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '108']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 109. Edit User Dictionary
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '109']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!-- 
	 !
	 ! ===============
	 ! OPEN MENU STEPS
	 ! ===============
	 !
	 !-->
	<!--
	 ! Script step 149. Open Edit Saved Finds
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '149']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 105. Open Preferences
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '105']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 114. Open File Options
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '114']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 156. Open Manage Containers
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '156']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 38. Open Manage Database
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '38']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 140. Open Manage Data Sources
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '140']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 151. Open Manage Layouts
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '151']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 88. Open Script Workspace
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '88']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 165. Open Manage Themes
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '165']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 112. Open Manage Value Lists
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '112']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 129. Open Find/Replace
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '129']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 32. Open Help
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '32']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 118. Open Remote
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '118']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 113. Open Sharing
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '113']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 172. Upload to FileMaker Server
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '172']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!-- 
	 !
	 ! ===================
	 ! MISCELLANEOUS STEPS
	 ! ===================
	 !
	 !-->
	<!--
	 ! Script step 87. Show Custom Dialog
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '87']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="Title/Calculation">
					<xsl:if test="$pVerbose = 'True'">
						<xsl:value-of select="'Title'"/>
						<xsl:value-of select="$delimiter2"/>
					</xsl:if>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="Title/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="Message/Calculation">
					<xsl:if test="$pVerbose = 'True'">
						<xsl:value-of select="'Message'"/>
						<xsl:value-of select="$delimiter2"/>
					</xsl:if>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="Message/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<!-- Buttons -->
				<xsl:if test="$pVerbose = 'True'">
					<xsl:variable name="inputCount"
						select="count(InputFields/InputField/Field[@id &gt; 0 or text()])"/>
					<!-- -->
					<xsl:for-each select="Buttons/Button[Calculation/text()]">
						<!-- Button n: Name -->
						<xsl:choose>
							<xsl:when test="position() = 1">
								<xsl:value-of select="'Default Button'"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="'Button'"/>
								<xsl:value-of select="' '"/>
								<xsl:value-of select="1 + count(preceding-sibling::*)"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:value-of select="$delimiter2"/>
						<xsl:call-template name="OutputCalculation">
							<xsl:with-param name="Calc" select="Calculation"/>
						</xsl:call-template>
						<xsl:value-of select="$delimiter3"/>
						<xsl:choose>
							<xsl:when test="$inputCount = 0">
								<!-- NO Inputs -->
							</xsl:when>
							<xsl:when test="@CommitState = 'False'">
								<xsl:value-of select="'Commit'"/>
								<xsl:value-of select="$delimiter2"/>
								<xsl:value-of select="$OPENQUOTES"/>
								<xsl:value-of select="'No'"/>
								<xsl:value-of select="$CLOSEQUOTES"/>

								<xsl:value-of select="$delimiter3"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="'Commit'"/>
								<xsl:value-of select="$delimiter2"/>
								<xsl:value-of select="$OPENQUOTES"/>
								<xsl:value-of select="'Yes'"/>
								<xsl:value-of select="$CLOSEQUOTES"/>
								<xsl:value-of select="$delimiter3"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</xsl:if>
				<!-- -->
				<!-- Inputs -->
				<xsl:for-each select="InputFields/InputField[Field/@id &gt; 0 or Field/text()]">
					<xsl:if test="$pVerbose = 'True'">
						<!-- Label:Field -->
						<xsl:value-of select="'Input'"/>
						<xsl:value-of select="' '"/>
						<xsl:value-of select="1 + count(preceding-sibling::*)"/>
						<xsl:if test="@UsePasswordCharacter = 'True'">
							<xsl:value-of select="' (•)'"/>
						</xsl:if>
						<xsl:value-of select="$delimiter2"/>
						<xsl:call-template name="OutputCalculation">
							<xsl:with-param name="Calc" select="Label/Calculation"/>
						</xsl:call-template>
						<xsl:value-of select="$delimiter2"/>
					</xsl:if>
					<xsl:call-template name="ScriptStepParamField"/>
				</xsl:for-each>

			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 115. Allow Formatting Bar (fmp12)
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '115']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="Set_state">
					<xsl:with-param name="state" select="Set/@state"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 167. Refresh Object
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '167']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="ObjectName">
					<xsl:value-of select="'Object Name'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="ObjectName/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
					<!-- -->
				</xsl:if>
				<xsl:call-template name="NamedRepetition"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 93. Beep
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '93']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 66. Speak
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '66']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="OutputCalculation">
					<xsl:with-param name="Calc" select="Calculation"/>
				</xsl:call-template>
				<!--
		<xsl:value-of select="SpeechOptions/@VoiceName"/>
		<xsl:value-of select="$delimiter3"/>
		SpeechOptions/@WaitForCompletion="False"
		SpeechOptions/@VoiceId="300"
		SpeechOptions/@VoiceCreator="gala"
		 !-->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 65. Dial Phone
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '65']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamNoDialog"/>
				<xsl:call-template name="OutputCalculation">
					<xsl:with-param name="Calc" select="Calculation"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 157. Install Plug-In File
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '157']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamField"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 142. Install Menu Set
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '142']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:value-of select="$OPENQUOTES"/>
				<xsl:choose>
					<xsl:when test="CustomMenuSet/@id = '0'">
						<xsl:value-of select="'[File Default]'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="CustomMenuSet/@name"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="$CLOSEQUOTES"/>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
				<xsl:if test="CustomMenuSet/@id != '0'">
					<xsl:call-template name="UseAsFileDefault_state">
						<xsl:with-param name="state" select="UseAsFileDefault/@state"/>
					</xsl:call-template>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 146. Set Web Viewer
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '146']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="ObjectName/Calculation">
					<xsl:value-of select="'Object Name'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="ObjectName/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:choose>
					<xsl:when test="Action/@value = 'Reset'">
						<xsl:value-of select="'Action'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="'Reset'"/>
					</xsl:when>
					<xsl:when test="Action/@value = 'Reload'">
						<xsl:value-of select="'Action'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="'Reload'"/>
					</xsl:when>
					<xsl:when test="Action/@value = 'GoForward'">
						<xsl:value-of select="'Action'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="'Go Forward'"/>
					</xsl:when>
					<xsl:when test="Action/@value = 'GoBack'">
						<xsl:value-of select="'Action'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="'Go Back'"/>
					</xsl:when>
					<xsl:when test="Action/@value = 'GoToURL'">
						<xsl:value-of select="'URL'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:call-template name="OutputCalculation">
							<xsl:with-param name="Calc" select="URL/Calculation"/>
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 111. Open URL
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '111']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamNoDialog"/>
				<xsl:call-template name="OutputCalculation">
					<xsl:with-param name="Calc" select="Calculation"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 63. Send Mail
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '63']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:choose>
					<xsl:when test="SendViaSMTP/@state = 'True'">
						<xsl:value-of select="'Send via SMTP Server'"/>
						<xsl:value-of select="$delimiter3"/>
						<!-- -->
						<xsl:value-of select="'No dialog'"/>
						<xsl:value-of select="$delimiter3"/>
						<!-- -->
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'Send via E-mail Client'"/>
						<xsl:value-of select="$delimiter3"/>
						<!-- -->
						<xsl:call-template name="ScriptStepParamNoDialog"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="To">
					<xsl:value-of select="'To'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="To/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="Cc">
					<xsl:value-of select="'CC'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="Cc/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="Bcc">
					<xsl:value-of select="'BCC'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="Bcc/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="Subject">
					<xsl:value-of select="'Subject'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="Subject/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="Message">
					<xsl:value-of select="'Message'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="Message/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="Attachment">
					<xsl:variable name="attachmentCount"
						select="1 + string-length(Attachment/UniversalPathList) - string-length(translate(Attachment/UniversalPathList, ';', ''))"/>
					<xsl:choose>
						<xsl:when test="$attachmentCount &gt; 1">
							<xsl:value-of select="concat($attachmentCount, ' ', 'Attachments')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="UniversalPathListFileName">
								<xsl:with-param name="pathList"
									select="Attachment/UniversalPathList"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 64. Send DDE Execute
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '64']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 67. Perform AppleScript
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '67']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:choose>
					<xsl:when test="ContentType/@value = 'Calculation'">
						<!--xsl:value-of select="'Calculation'"/>
						<xsl:value-of select="$delimiter3"/>
						 -->
						<xsl:call-template name="OutputCalculation">
							<xsl:with-param name="Calc" select="Calculation"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="ContentType/@value = 'Text'">
						<!--xsl:value-of select="'Precompiled'"/>
						<xsl:value-of select="$delimiter3"/>
						 !-->
						<xsl:value-of select="$QUOT"/>
						<xsl:call-template name="OutputCalculation">
							<xsl:with-param name="Calc" select="Text"/>
						</xsl:call-template>
						<xsl:value-of select="$QUOT"/>
					</xsl:when>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 117. Execute SQL
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '117']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamNoDialog"/>
				<xsl:if test="Profile/Query">
					<xsl:value-of select="concat('SQL Text', $delimiter2)"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="Profile/Query"/>
					</xsl:call-template>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 57. Send Event
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '57']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="Event/@TargetName">
					<xsl:value-of select="$OPENQUOTES"/>
					<xsl:value-of select="Event/@TargetName"/>
					<xsl:value-of select="$CLOSEQUOTES"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="Event/@class">
					<xsl:value-of select="$OPENQUOTES"/>
					<xsl:value-of select="Event/@class"/>
					<xsl:value-of select="$CLOSEQUOTES"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="Event/@id">
					<xsl:value-of select="$OPENQUOTES"/>
					<xsl:value-of select="Event/@id"/>
					<xsl:value-of select="$CLOSEQUOTES"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<!--xsl:value-of select="ContentType"/>
				<xsl:value-of select="$delimiter3"/>
				
				<xsl:value-of select="ContentType/@value"/>
				<xsl:value-of select="$delimiter3"/-->
				<xsl:choose>
					<xsl:when test="ContentType/@value = 'Text' and Text/text()">
						<xsl:value-of select="$OPENQUOTES"/>
						<xsl:value-of select="Text"/>
						<xsl:value-of select="$CLOSEQUOTES"/>
						<xsl:value-of select="$delimiter3"/>
						<!-- -->
					</xsl:when>
					<xsl:when test="ContentType/@value = 'File'">
						<xsl:call-template name="ScriptStepParamSpecifyFile"/>
					</xsl:when>
				</xsl:choose>
				<!--xsl:value-of select="Event/@TargetType"/>
				<xsl:if test="Event/@BringTargetToForeground='False'">
					<xsl:value-of select="'BringTargetToForeground'"/>
</xsl:if>
				<xsl:value-of select="$delimiter3"/>
				<xsl:if test="Event/@WaitForCompletion='True'">
					<xsl:value-of select="'WaitForCompletion'"/>
</xsl:if>
				<xsl:value-of select="$delimiter3"/>
				<xsl:if test="Event/@CopyResultToClipboard='True'">
					<xsl:value-of select="'CopyResultToClipboard'"/>
				</xsl:if-->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 89. Comment
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '89']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:if test="Text != ''">
			<xsl:value-of select="' '"/>
			<xsl:call-template name="OutputCalculation">
				<xsl:with-param name="Calc" select="Text"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 102. Flush Cache to Disk
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '102']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 44. Exit Application
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '44']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!-- 
	 !
	 ! =============
	 ! UNKNOWN STEPS
	 ! =============
	 !
	 !-->
	<!--
	 ! Script step 0. <unknown>
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '0']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 !
	 ! ==================
	 ! FILEMAKER 14 STEPS
	 ! ==================
	 !
	 !-->
	<!--
	 ! Script step 173. EMPTY -> UNKNWONN
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '173']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 174. Enable Touch Keyboard
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '174']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ShowHide_value">
					<xsl:with-param name="value" select="ShowHide/@value"/>
				</xsl:call-template>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 177. AVPlayer Play
	
	AVPlayer Play [ Object Name : "AVPlayer" ; 
	                Repetition: 2 ; 
	                Presentation: Start Full Screen ; 
	                Disable Interaction: No ; 
	                Hide Controls: No ; 
	                Position: 123 ; 
	                Start Offset: 1 ; 
	                End Offset: 234 ] 
	
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '177']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:choose>
					<xsl:when test="Source/@value = 'Object' and not(Source/Calculation)">
						<xsl:value-of select="'Object Name'"/>
						<!-- Bug fm15 -->
						<xsl:value-of select="' '"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="'&lt;Active Object&gt;'"/>
						<xsl:value-of select="$delimiter3"/>
						<!-- -->
					</xsl:when>
					<xsl:when test="Source/@value = 'Object'">
						<xsl:value-of select="'Object Name'"/>
						<!-- Bug fm15 -->
						<xsl:value-of select="' '"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:call-template name="OutputCalculation">
							<xsl:with-param name="Calc" select="Source/Calculation"/>
						</xsl:call-template>
						<xsl:value-of select="$delimiter3"/>
						<!-- -->
						<xsl:if
							test="Repetition/Calculation/text() and Repetition/Calculation/text() != '1'">
							<xsl:value-of select="'Repetition'"/>
							<xsl:value-of select="$delimiter2"/>
							<xsl:call-template name="OutputCalculation">
								<xsl:with-param name="Calc" select="Repetition/Calculation"/>
							</xsl:call-template>
							<xsl:value-of select="$delimiter3"/>
						</xsl:if>
						<!-- -->
					</xsl:when>
					<xsl:when test="Source/@value = 'Field'">
						<xsl:value-of select="'Field'"/>
						<!-- Bug fm15 -->
						<xsl:value-of select="' '"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:for-each select="Source">
							<xsl:call-template name="ScriptStepParamField"/>
						</xsl:for-each>
						<!-- -->
						<xsl:if
							test="Repetition/Calculation/text() and Repetition/Calculation/text() != '1'">
							<xsl:value-of select="'Repetition'"/>
							<xsl:value-of select="$delimiter2"/>
							<xsl:call-template name="OutputCalculation">
								<xsl:with-param name="Calc" select="Repetition/Calculation"/>
							</xsl:call-template>
							<xsl:value-of select="$delimiter3"/>
						</xsl:if>
						<!-- -->
					</xsl:when>
					<xsl:when test="Source/@value = 'URL'">
						<xsl:value-of select="'URL'"/>
						<!-- Bug fm15 -->
						<xsl:value-of select="' '"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:call-template name="OutputCalculation">
							<xsl:with-param name="Calc" select="Source/Calculation"/>
						</xsl:call-template>
						<xsl:value-of select="$delimiter3"/>
						<!-- -->
					</xsl:when>
				</xsl:choose>
				<!-- -->
				<xsl:if test="Presentation">
					<xsl:value-of select="'Presentation'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:value-of select="Presentation/@value"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="DisableInteraction">
					<xsl:value-of select="'Disable Interaction'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:choose>
						<xsl:when test="DisableInteraction/@value = 'True'">
							<xsl:value-of select="'Yes'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'No'"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="HideControls">
					<xsl:value-of select="'Hide Controls'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:choose>
						<xsl:when test="HideControls/@value = 'True'">
							<xsl:value-of select="'Yes'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'No'"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="PlaybackPosition">
					<xsl:value-of select="'Position'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="PlaybackPosition/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="StartOffset">
					<xsl:value-of select="'Start Offset'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="StartOffset/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="EndOffset">
					<xsl:value-of select="'End Offset'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="EndOffset/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 178. AVPlayer Set Playback State
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '178']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:value-of select="PlaybackState/@value"/>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 179. AVPlayer Set Options
	
	AVPlayer Set Options [ Presentation: Start Full Screen ; 
	                       Disable Interaction: No ;
	                       Hide Controls: No ; 
	                       Disable External Controls: No ; 
	                       Pause in Background: No ; 
	                       Position: 123 ; 
	                       Start Offset: 123 ; 
	                       End Offset: 123 ; 
	                       Volume: 123 ;
	                       Zoom: Stretch ;
	                       Sequence: Next ]
	
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '179']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="Presentation">
					<xsl:value-of select="'Presentation'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:value-of select="Presentation/@value"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="DisableInteraction">
					<xsl:value-of select="'Disable Interaction'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:choose>
						<xsl:when test="DisableInteraction/@value = 'True'">
							<xsl:value-of select="'Yes'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'No'"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="HideControls">
					<xsl:value-of select="'Hide Controls'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:choose>
						<xsl:when test="HideControls/@value = 'True'">
							<xsl:value-of select="'Yes'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'No'"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="DisableExternalControls">
					<xsl:value-of select="'Disable External Controls'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:choose>
						<xsl:when test="DisableExternalControls/@value = 'True'">
							<xsl:value-of select="'Yes'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'No'"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="PauseInBackground">
					<xsl:value-of select="'Pause in Background'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:choose>
						<xsl:when test="PauseInBackground/@value = 'True'">
							<xsl:value-of select="'Yes'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'No'"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="PlaybackPosition">
					<xsl:value-of select="'Position'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="PlaybackPosition/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="StartOffset">
					<xsl:value-of select="'Start Offset'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="StartOffset/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="EndOffset">
					<xsl:value-of select="'End Offset'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="EndOffset/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="Volume">
					<xsl:value-of select="'Volume'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="Volume/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="Zoom">
					<xsl:value-of select="'Zoom'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:choose>
						<xsl:when test="Zoom/@value = 'Fit'">
							<xsl:value-of select="'Fit'"/>
						</xsl:when>
						<xsl:when test="Zoom/@value = 'Fill'">
							<xsl:value-of select="'Fill'"/>
						</xsl:when>
						<xsl:when test="Zoom/@value = 'Stretch'">
							<xsl:value-of select="'Stretch'"/>
						</xsl:when>
						<xsl:when test="Zoom/@value = 'FitOnly'">
							<xsl:value-of select="'Fit Only'"/>
						</xsl:when>
						<xsl:when test="Zoom/@value = 'FillOnly'">
							<xsl:value-of select="'Fill Only'"/>
						</xsl:when>
						<xsl:when test="Zoom/@value = 'StretchOnly'">
							<xsl:value-of select="'Stretch Only'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="Zoom/@value"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="Sequence">
					<xsl:value-of select="'Sequence'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:value-of select="Sequence/@value"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 180. Refresh Portal
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '180']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="ObjectName">
					<xsl:value-of select="'Object Name'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="ObjectName/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 181. Get Directory
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '181']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="AllowFolderCreation/@state = 'True'">
					<xsl:value-of select="'Allow Folder Creation'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="Name/text()">
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="Name"/>
					</xsl:call-template>
					<xsl:if
						test="Repetition/Calculation/text() and Repetition/Calculation/text() != '1'">
						<xsl:value-of select="concat('[', Repetition/Calculation/text(), ']')"/>
					</xsl:if>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="DialogTitle/Calculation/text()">
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="DialogTitle/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="DefaultLocation/Calculation/text()">
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="DefaultLocation/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 183. Open Launch Center
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '183']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 184. Open Starter Solution
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '184']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 185. Configure Region Monitor Script
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '185']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:value-of select="'Monitor'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:choose>
					<xsl:when test="MonitorType/@value = 'iBeacon'">
						<xsl:value-of select="'iBeacon'"/>
					</xsl:when>
					<xsl:when test="MonitorType/@value = 'GeoLocation'">
						<xsl:value-of select="'Geofence'"/>
					</xsl:when>
				</xsl:choose>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
				<xsl:if test="MonitorType/RangeName">
					<xsl:value-of select="'Name'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="MonitorType/RangeName/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<xsl:if test="Script">
					<xsl:value-of select="'Script'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="QuotedStringOrUnknown">
						<xsl:with-param name="string" select="Script/@name"/>
					</xsl:call-template>
					<xsl:if test="FileReference/@name">
						<xsl:value-of select="' '"/>
						<xsl:value-of select="'from file'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="$OPENQUOTES"/>
						<xsl:value-of select="FileReference/@name"/>
						<xsl:value-of select="$CLOSEQUOTES"/>
						<xsl:if test="FileReference/@name = ''">
							<xsl:value-of select="' (file not open)'"/>
						</xsl:if>
					</xsl:if>
					<xsl:value-of select="$delimiter3"/>
					<!-- -->
					<xsl:if test="Calculation">
						<xsl:value-of select="'Parameter'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:call-template name="OutputCalculation">
							<xsl:with-param name="Calc" select="Calculation"/>
						</xsl:call-template>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<!-- -->
				</xsl:if>
				<!-- -->
				<xsl:choose>
					<xsl:when test="MonitorType/@value = 'iBeacon'">
						<xsl:if test="MonitorType/ProximityUUID">
							<xsl:value-of select="'UUID'"/>
							<xsl:value-of select="$delimiter2"/>
							<xsl:call-template name="OutputCalculation">
								<xsl:with-param name="Calc"
									select="MonitorType/ProximityUUID/Calculation"/>
							</xsl:call-template>
							<xsl:value-of select="$delimiter3"/>
						</xsl:if>
						<!-- -->
						<xsl:if test="MonitorType/MajorID">
							<xsl:value-of select="'Major'"/>
							<xsl:value-of select="$delimiter2"/>
							<xsl:call-template name="OutputCalculation">
								<xsl:with-param name="Calc" select="MonitorType/MajorID/Calculation"
								/>
							</xsl:call-template>
							<xsl:value-of select="$delimiter3"/>
						</xsl:if>
						<!-- -->
						<xsl:if test="MonitorType/MinorID">
							<xsl:value-of select="'Minor'"/>
							<xsl:value-of select="$delimiter2"/>
							<xsl:call-template name="OutputCalculation">
								<xsl:with-param name="Calc" select="MonitorType/MinorID/Calculation"
								/>
							</xsl:call-template>
							<xsl:value-of select="$delimiter3"/>
						</xsl:if>
						<!-- -->
					</xsl:when>
					<xsl:when test="MonitorType/@value = 'GeoLocation'">
						<xsl:if test="MonitorType/Latitude">
							<xsl:value-of select="'Latitude'"/>
							<xsl:value-of select="$delimiter2"/>
							<xsl:call-template name="OutputCalculation">
								<xsl:with-param name="Calc"
									select="MonitorType/Latitude/Calculation"/>
							</xsl:call-template>
							<xsl:value-of select="$delimiter3"/>
						</xsl:if>
						<!-- -->
						<xsl:if test="MonitorType/Longitude">
							<xsl:value-of select="'Longitude'"/>
							<xsl:value-of select="$delimiter2"/>
							<xsl:call-template name="OutputCalculation">
								<xsl:with-param name="Calc"
									select="MonitorType/Longitude/Calculation"/>
							</xsl:call-template>
							<xsl:value-of select="$delimiter3"/>
						</xsl:if>
						<!-- -->
						<xsl:if test="MonitorType/Radius">
							<xsl:value-of select="'Radius'"/>
							<xsl:value-of select="$delimiter2"/>
							<xsl:call-template name="OutputCalculation">
								<xsl:with-param name="Calc" select="MonitorType/Radius/Calculation"
								/>
							</xsl:call-template>
							<xsl:value-of select="$delimiter3"/>
						</xsl:if>
						<!-- -->
					</xsl:when>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 186. External Script Step
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '186']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<!-- -->
				<xsl:call-template name="ScriptStepParamSelect"/>
				<!-- Destination -->
				<xsl:if
					test="PluginStep/Parameter[@Type = 'target' and @ShowInLine = 'true' and not(@ID)]">
					<xsl:value-of
						select="PluginStep/Parameter[@Type = 'target' and @ShowInLine = 'true' and not(@ID)]/@Label"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="ScriptStepParamField"/>
				</xsl:if>
				<!-- Parameters (FIXME ONLY CALCS) -->
				<xsl:for-each
					select="PluginStep/Parameter[@Type = 'calc' and @ShowInline = 'true' and @ID]">
					<xsl:variable name="ID" select="@ID"/>
					<!-- -->
					<xsl:variable name="Calc"
						select="../../ParameterValues/Object[@index = $ID]/Calculation"/>
					<!-- -->
					<xsl:value-of select="@Label"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="$Calc"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:for-each>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!-- 
	 ! Script step 187. Configure Local Notification (FM17 - iOS)
	 !
	 ! Configure Local Notification [ Action: Queue ; Name: $Name ; Script: “Notified” ; Parameter: $Param ; Delay: $Delay ; Title: $Title ; Body: $Body ; Button 1 Label: $Button1Label ; Button 2 Label: $Button2Label ; Button 3 Label: $Button3Label ; Button 1 Foreground: $Button1Foreground ; Button 2 Foreground: $Button2Foreground ; Button 3 Foreground: $Button3Foreground ] 
	 !
	 ! <Step enable="True" id="187" name="Configure Local Notification">
	 ! 	<Calculation><![CDATA[$Param]]></Calculation>
	 ! 	<Script id="42" name="Notified"></Script>
	 ! 	<Action value="Queue">
	 ! 		<Name>
	 ! 			<Calculation><![CDATA[$Name]]></Calculation>
	 ! 		</Name>
	 ! 		<Delay>
	 ! 			<Calculation><![CDATA[$Delay]]></Calculation>
	 ! 		</Delay>
	 ! 		<Title>
	 ! 			<Calculation><![CDATA[$Title]]></Calculation>
	 ! 		</Title>
	 ! 		<Body>
	 ! 			<Calculation><![CDATA[$Body]]></Calculation>
	 ! 		</Body>
	 ! 		<Button1Label>
	 ! 			<Calculation><![CDATA[$Button1Label]]></Calculation>
	 ! 		</Button1Label>
	 ! 		<Button2Label>
	 ! 			<Calculation><![CDATA[$Button2Label]]></Calculation>
	 ! 		</Button2Label>
	 ! 		<Button3Label>
	 ! 			<Calculation><![CDATA[$Button3Label]]></Calculation>
	 ! 		</Button3Label>
	 ! 		<Button1ForceFgnd>
	 ! 			<Calculation><![CDATA[$Button1Foreground]]></Calculation>
	 ! 		</Button1ForceFgnd>
	 ! 		<Button2ForceFgnd>
	 ! 			<Calculation><![CDATA[$Button2Foreground]]></Calculation>
	 ! 		</Button2ForceFgnd>
	 ! 		<Button3ForceFgnd>
	 ! 			<Calculation><![CDATA[$Button3Foreground]]></Calculation>
	 ! 		</Button3ForceFgnd>
	 ! 	</Action>
	 ! </Step>
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '187']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<!-- -->
				<xsl:value-of select="'Action'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:value-of select="Action/@value"/>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
				<xsl:if test="Action/Name">
					<xsl:value-of select="'Name'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:value-of select="Action/Name/Calculation"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="Action/@value = 'Queue'">
					<!-- -->
					<xsl:if test="Script/@name">
						<xsl:value-of select="'Script'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:call-template name="QuotedStringOrUnknown">
							<xsl:with-param name="string" select="Script/@name"/>
						</xsl:call-template>
						<xsl:value-of select="$delimiter3"/>
						<!-- -->
						<xsl:value-of select="'Parameter'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="Calculation"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<!-- -->
					<xsl:if test="Action/Delay">
						<xsl:value-of select="'Delay'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="Action/Delay/Calculation"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<!-- -->
					<xsl:if test="Action/Title">
						<xsl:value-of select="'Title'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="Action/Title/Calculation"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<!-- -->
					<xsl:if test="Action/Body">
						<xsl:value-of select="'Body'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="Action/Body/Calculation"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<!-- -->
					<xsl:if test="Action/Button1Label">

						<xsl:value-of select="'Button 1 Label'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="Action/Button1Label/Calculation"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<!-- -->
					<xsl:if test="Action/Button2Label">
						<xsl:value-of select="'Button 2 Label'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="Action/Button2Label/Calculation"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<!-- -->
					<xsl:if test="Action/Button3Label">
						<xsl:value-of select="'Button 3 Label'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="Action/Button3Label/Calculation"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<!-- -->
					<xsl:if test="Action/Button1ForceFgnd">
						<xsl:value-of select="'Button 1 Foreground'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="Action/Button1ForceFgnd/Calculation"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<!-- -->
					<xsl:if test="Action/Button2ForceFgnd">
						<xsl:value-of select="'Button 2 Foreground'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="Action/Button2ForceFgnd/Calculation"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<!-- -->
					<xsl:if test="Action/Button3ForceFgnd">
						<xsl:value-of select="'Button 3 Foreground'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="Action/Button3ForceFgnd/Calculation"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<!-- -->
				</xsl:if>
				<!-- Parameter -->
				<xsl:if
					test="PluginStep/Parameter[@Type = 'target' and @ShowInLine = 'true' and not(@ID)]">
					<xsl:value-of
						select="PluginStep/Parameter[@Type = 'target' and @ShowInLine = 'true' and not(@ID)]/@Label"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="ScriptStepParamField"/>
				</xsl:if>
				<!-- Parameters (FIXME ONLY CALCS) -->
				<xsl:for-each
					select="PluginStep/Parameter[@Type = 'calc' and @ShowInline = 'true' and @ID]">
					<xsl:variable name="ID" select="@ID"/>
					<!-- -->
					<xsl:variable name="Calc"
						select="../../ParameterValues/Object[@index = $ID]/Calculation"/>
					<!-- -->
					<xsl:value-of select="@Label"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="Calc" select="$Calc"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:for-each>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>

	<!--
	 !
	 ! ==============
	 ! OBSOLETE STEPS
	 ! ==============
	 !
	 !-->
	<!--
	 !  2 <unknown>*
	 !  3 <unknown>*
	 ! 15 <unknown>*
	 ! 52 [OBSOLETE] <unknown>
	 ! 53 [OBSOLETE] <unknown>
	 ! 54 <unknown>*
	 ! 58 [OBSOLETE] <unknown>
	 ! 59 [OBSOLETE] Insert QuickTime
	 ! 78 [OBSOLETE] Insert Object
	 ! 96 <unknown> Update Link
	 ! 153 [OBSOLETE] <unknown>
	 ! 162 [OBSOLETE] Open from Test Server
	 ! 163 [OBSOLETE] Sign Out from Test Server
	 ! 170 [OBSOLETE] Upload to Test Server
	 ! 171 [OBSOLETE] Manage Test Server
	 ! 173 <unknown>*
	 ! 175 [OBSOLETE] Perform Web Script
	 ! 176 [OBSOLETE] Set Allowed Orientations
	 !
	 ! <unknown>* = never used
	 !-->
	<xsl:template
		match="//Step[not(ancestor::Step) and (@id = 2 or @id = 3 or @id = 15 or @id = 52 or @id = 53 or @id = 54 or @id = 58 or @id = 59 or @id = 78 or @id = 96 or @id = 153 or @id = 162 or @id = 163 or @id = 170 or @id = 171 or @id = 173 or @id = 175)]">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 176. Set Allowed Orientations
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '176']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="fn.SubstituteMultiple">
					<xsl:with-param name="text" select="AllowedOrientations/@value"/>
					<xsl:with-param name="substitutions"
						select="concat(':', '|', $delimiter2, '|', ';', '|', $delimiter3)"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! ignore all other text
	 !-->
	<xsl:template match="text()"/>
	<!--
	 !
	 !
	 !
	 ! ===========================
	 ! ===== NAMED TEMPLATES =====
	 ! ===========================
	 !
	 !
	 !
	 !-->
	<!--
	 !
	 ! The following should be centralized...
	 !
	 !-->
	<!--
	 ! charEntity( n )
	 ! Outputs the given number as a character entity reference
	 !
	 ! the number n may be:
	 ! - a decimal value, for example: 65 -> 'A'
	 ! - or a hexadecimal value prefixed by an 'x' or 'X', for example: "x41" -> 'A'
	 !
	 !-->
	<xsl:template name="charEntity">
		<xsl:param name="n"/>
		<!-- -->
		<xsl:text disable-output-escaping="yes">&amp;#</xsl:text>
		<xsl:value-of select="$n"/>
		<xsl:text>;</xsl:text>
	</xsl:template>
	<!--
	 ! DECODE the PrintSettings printer data:
	 ! 
	 ! Data is stored as 8 digit hex blocks = read + skip
	 ! Block 1 = n = number of prefix codes = skip
	 ! Block 2..n+1 = the prefix codes = skip
	 ! Block n+2 = zero = skip
	 ! Block n+3 = m = length of the printer name = skip
	 ! Block n+4 = the beginning of the printer name = read + output recursively
	 !             (each block (seems to) represent a Unicode code point.)
	 !-->
	<xsl:template name="decodePrintSettingsPrinterData">
		<xsl:param name="hex"/>
		<!-- -->
		<xsl:variable name="n">
			<xsl:call-template name="fn.0x">
				<xsl:with-param name="hex" select="substring($hex, 1, 8)"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:call-template name="decodePrintSettingsPrinterName">
			<xsl:with-param name="hex" select="substring($hex, 1 + ($n + 3) * 8)"/>
		</xsl:call-template>
	</xsl:template>
	<!-- Recursively decode the printer name - oh what fun!
	 !-->
	<xsl:template name="decodePrintSettingsPrinterName">
		<xsl:param name="hex"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="string-length($hex) &lt; 8">
				<xsl:value-of select="substring('********', 1, string-length($hex))"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="n">
					<xsl:call-template name="fn.0x">
						<xsl:with-param name="hex" select="substring($hex, 1, 8)"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$n &gt; 31 and $n &lt; 128">
						<xsl:value-of
							select="substring(concat(' !',$QUOT,'#$%&amp;',$APOS,'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~'),$n - 32+1,1)"
						/>
					</xsl:when>
					<xsl:when test="$n &gt; 128 + 31 and $n &lt; 128 + 128">
						<xsl:value-of
							select="substring(' ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿĀ', $n - 128 - 32 + 1, 1)"
						/>
					</xsl:when>
					<xsl:otherwise>
						<!--<xsl:variable name="c">
							<xsl:call-template name="charEntity">
								<xsl:with-param name="n" select="$n"/>
							</xsl:call-template>
						</xsl:variable>-->
						<!--						<xsl:value-of select="exsl:node-set($c)/text()"/>-->
						<xsl:value-of select="concat('(', $n, '?)')"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:call-template name="decodePrintSettingsPrinterName">
					<xsl:with-param name="hex" select="substring($hex, 9)"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	 ! ExternalDataSourceName
	 !-->
	<xsl:template name="ExternalDataSourceName">
		<xsl:param name="OrCurrentFile" select="'False'"/>
		<!--  -->
		<xsl:choose>
			<xsl:when test="FileReference/@name">
				<xsl:call-template name="QuotedStringOrUnknown">
					<xsl:with-param name="string" select="FileReference/@name"/>
				</xsl:call-template>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
			</xsl:when>
			<xsl:when test="OdbcDataSource/@DSN">
				<xsl:value-of select="$OPENQUOTES"/>
				<xsl:value-of select="OdbcDataSource/@DSN"/>
				<xsl:value-of select="$CLOSEQUOTES"/>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
			</xsl:when>
			<xsl:when test="$OrCurrentFile != 'False'">
				<xsl:value-of select="'Current File'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'&lt;unknown&gt;'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	 ! FieldRepetition
	 !-->
	<xsl:template name="FieldRepetition">
		<xsl:param name="repetition" select="Field/@repetition"/>
		<!---->
		<xsl:choose>
			<xsl:when test="$repetition = 1 or number(Repetition/Calculation) = 1">
				<!-- [1] don't output -->
			</xsl:when>
			<xsl:when test="$repetition &gt; 0">
				<!-- [2+] output -->
				<xsl:value-of select="concat('[', $repetition, ']')"/>
			</xsl:when>
			<xsl:when test="Repetition/Calculation">
				<!-- [1+1] Calculation -->
				<xsl:value-of select="'['"/>
				<xsl:call-template name="OutputCalculation">
					<xsl:with-param name="Calc" select="Repetition/Calculation"/>
				</xsl:call-template>
				<xsl:value-of select="']'"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--
	 ! NamedRepetition
	 !-->
	<xsl:template name="NamedRepetition">
		<xsl:param name="repetition" select="Field/@repetition"/>
		<!---->
		<xsl:choose>
			<xsl:when test="$repetition = 1 or number(Repetition/Calculation) = 1">
				<!-- [1] don't output -->
			</xsl:when>
			<xsl:when test="$repetition &gt; 0">
				<!-- [2+] output -->
				<xsl:value-of select="'Repetition'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:value-of select="$repetition"/>
			</xsl:when>
			<xsl:when test="Repetition/Calculation">
				<!-- [1+1] Calculation -->
				<xsl:value-of select="'Repetition'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:call-template name="OutputCalculation">
					<xsl:with-param name="Calc" select="Repetition/Calculation"/>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--
	 ! QuotedStringOrUnknown
	 !-->
	<xsl:template name="QuotedStringOrUnknown">
		<xsl:param name="string"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="not($string) or $string = ''">
				<xsl:value-of select="'&lt;unknown&gt;'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$OPENQUOTES"/>
				<xsl:value-of select="$string"/>
				<xsl:value-of select="RW"/>
				<xsl:value-of select="$CLOSEQUOTES"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- OutputCalculation
	 !-->
	<xsl:template name="OutputCalculation">
		<xsl:param name="Calc" select="''"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="$pVerbose = 'True' and contains($delimiter3, $RETURN)">
				<xsl:value-of select="$Calc"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="translate($Calc, $CRLF, '  ')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="OutputCalculationOrTwoSpaces">
		<xsl:param name="Calc"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="string-length($Calc) = 0">
				<xsl:value-of select="'  '"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="OutputCalculation">
					<xsl:with-param name="Calc" select="$Calc"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- 
	 ! =============================
	 ! ScriptStepParameter Templates
	 ! =============================
	 !-->
	<!--
	 ! ScriptStepParamDataSource
	 !-->
	<xsl:template name="ScriptStepParamDataSource">
		<!-- DataSource -->
		<xsl:choose>
			<!-- Excel -->
			<xsl:when
				test="DataSourceType/@value = 'File' and (Profile/@DataType = 'XLS ' or Profile/@DataType = 'XLSX')">
				<xsl:if test="UniversalPathList">
					<xsl:value-of select="'Source'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:value-of select="concat($QUOT, Profile/@FileName, $QUOT)"/>
					<xsl:call-template name="SIC.delimiter3"/>
					<!-- -->
					<xsl:value-of select="'Worksheet'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:value-of select="concat($QUOT, Profile/@WorksheetName, $QUOT)"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
			</xsl:when>
			<!-- File -->
			<xsl:when test="DataSourceType/@value = 'File'">
				<xsl:call-template name="ScriptStepParamSpecifyFile"/>
			</xsl:when>
			<!-- Folder -->
			<xsl:when test="DataSourceType/@value = 'Folder'">
				<xsl:value-of select="'folder'"/>
				<xsl:call-template name="SIC.delimiter3"/>
				<!-- -->
			</xsl:when>
			<!-- XML / XSL -->
			<xsl:when test="DataSourceType/@value = 'XMLSource'">
				<!-- XML -->
				<xsl:choose>
					<xsl:when test="Profile/@XMLType = 'XMLHttp'">
						<!-- XML URL -->
						<xsl:value-of select="Profile/XMLHttp"/>
						<xsl:call-template name="SIC.delimiter3"/>
					</xsl:when>
					<xsl:when test="Profile/@XMLType = 'XMLCalculation'">
						<!-- XSL URL -->
						<xsl:if test="Profile/XMLCalc/Calculation">
							<xsl:call-template name="OutputCalculation">
								<xsl:with-param name="Calc" select="Profile/XMLCalc/Calculation"/>
							</xsl:call-template>
							<xsl:call-template name="SIC.delimiter3"/>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<!-- XML File -->
						<xsl:call-template name="fn.substring-after-last">
							<xsl:with-param name="text" select="Profile/XMLFile"/>
							<xsl:with-param name="searchString">
								<xsl:choose>
									<xsl:when test="contains(Profile/XMLFile, '/')">
										<xsl:value-of select="'/'"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="':'"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="SIC.delimiter3"/>
					</xsl:otherwise>
				</xsl:choose>
				<!-- XSL -->
				<xsl:choose>
					<xsl:when test="Profile/@XSLType = 'NoXSL'">
						<!-- nothing! -->
					</xsl:when>
					<xsl:when test="Profile/@XSLType = 'XSLHttp'">
						<!-- XSL URL -->
						<xsl:value-of select="Profile/XSLHttp"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:when>
					<xsl:when test="Profile/@XSLType = 'XSLCalculation'">
						<!-- XSL URL -->
						<xsl:call-template name="OutputCalculation">
							<xsl:with-param name="Calc" select="Profile/XSLCalc/Calculation"/>
						</xsl:call-template>
						<xsl:value-of select="$delimiter3"/>
					</xsl:when>
					<xsl:when test="Profile/@XSLType = 'XSLFile'">
						<!-- XSL File -->
						<xsl:call-template name="fn.substring-after-last">
							<xsl:with-param name="text" select="Profile/XSLFile"/>
							<xsl:with-param name="searchString">
								<xsl:choose>
									<xsl:when test="contains(Profile/XSLFile, '/')">
										<xsl:value-of select="'/'"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="':'"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:value-of select="$delimiter3"/>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--
	 ! ScriptStepParamExportFileParameters
	 !-->
	<xsl:template name="ScriptStepParamExportFileParameters">
		<!--  -->
		<xsl:call-template name="ScriptStepParamSpecifyOutputFile"/>
		<xsl:if test="$pVerbose = 'True'">
			<xsl:if test="ExportOptions/@FormatUsingCurrentLayout = 'True'">
				<xsl:value-of select="'Format using current layout'"/>
				<xsl:value-of select="$delimiter3"/>
			</xsl:if>
		</xsl:if>
		<xsl:if test="ExportOptions/@CharacterSet">
			<xsl:choose>
				<xsl:when test="ExportOptions/@CharacterSet = 'UTF-8'">
					<xsl:value-of select="'Unicode (UTF-8)'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:when>
				<xsl:when test="ExportOptions/@CharacterSet = 'Windows'">
					<xsl:value-of select="'Windows (ANSI)'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:when>
				<xsl:when test="ExportOptions/@CharacterSet = 'DOS'">
					<xsl:value-of select="'ASCII (DOS)'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:when>
				<xsl:when test="ExportOptions/@CharacterSet = 'Macintosh'">
					<xsl:value-of select="'Macintosh'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:when>
				<xsl:when test="ExportOptions/@CharacterSet = 'Unicode'">
					<xsl:value-of select="'Unicode (UTF-16)'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:when>
				<xsl:when test="ExportOptions/@CharacterSet = 'ShiftJIS'">
					<xsl:value-of select="'Japanese (Shift-JIS)'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:when>
				<xsl:when test="ExportOptions/@CharacterSet = 'ChineseSimplified'">
					<xsl:value-of select="'Simplified Chinese (GB)'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:when>
				<xsl:when test="ExportOptions/@CharacterSet = 'ChineseTraditional'">
					<xsl:value-of select="'Traditional Chinese (Big-5)'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:when>
				<xsl:when test="ExportOptions/@CharacterSet = 'EUC-KR'">
					<xsl:value-of select="'Korean (EUC-KR)'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:when>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<!-- 
	 ! ScriptStepParamField
	 !
	 ! Outputs a target field or variable 
	 !-->
	<xsl:template name="ScriptStepParamField">
		<xsl:if test="Field">
			<xsl:choose>
				<!-- Starting fm16 target can also be a variable - var name is in the content of the Field tag -->
				<xsl:when test="Field/text()">
					<xsl:if test="$pVerbose = 'True'">
						<xsl:value-of select="'Target'"/>
						<xsl:value-of select="$delimiter2"/>
					</xsl:if>
					<xsl:value-of select="Field/text()"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="Field/@table = ''">
							<xsl:value-of select="'&lt;Table Missing&gt;'"/>
						</xsl:when>
						<xsl:when test="Field/@name = ''">
							<xsl:value-of
								select="concat(Field/@table, '::', '&lt;Field Missing&gt;')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(Field/@table, '::', Field/@name)"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="Field/@repetition = '1' or not(Field/@repetition)">
							<!-- [1] nicht ausgeben -->
						</xsl:when>
						<xsl:when test="Field/@repetition = '0'">
							<!-- [0] Calculation -->
							<xsl:value-of select="'['"/>
							<xsl:call-template name="OutputCalculation">
								<xsl:with-param name="Calc" select="Repetition/Calculation"/>
							</xsl:call-template>
							<xsl:value-of select="']'"/>
						</xsl:when>
						<xsl:when test="Field/@name != ''">
							<!-- [n] repetition number -->
							<xsl:value-of select="concat('[', Field/@repetition, ']')"/>
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:value-of select="$delimiter3"/>
		</xsl:if>
	</xsl:template>
	<!--
	 ! ScriptStepParamLayoutDestination
	 !-->
	<xsl:template name="ScriptStepParamLayoutDestination">
		<xsl:choose>
			<xsl:when test="LayoutDestination/@value = 'OriginalLayout'">
				<xsl:value-of select="'original layout'"/>
			</xsl:when>
			<xsl:when test="LayoutDestination/@value = 'CurrentLayout' or not(LayoutDestination)">
				<xsl:value-of select="'&lt;Current Layout&gt;'"/>
			</xsl:when>
			<xsl:when test="LayoutDestination/@value = 'SelectedLayout'">
				<xsl:call-template name="QuotedStringOrUnknown">
					<xsl:with-param name="string" select="Layout/@name"/>
				</xsl:call-template>
				<xsl:if test="Layout/@name != ''">
					<xsl:value-of select="' ('"/>
					<!-- FIXME - lookup in DDR? -->
					<xsl:value-of select="'…'"/>
					<xsl:value-of select="')'"/>
				</xsl:if>
			</xsl:when>
			<xsl:when test="LayoutDestination/@value = 'LayoutNumberByCalc'">
				<xsl:if test="$pVerbose = 'True'">
					<xsl:value-of select="'By Number'"/>
					<xsl:value-of select="$delimiter2"/>
				</xsl:if>
				<xsl:call-template name="OutputCalculation">
					<xsl:with-param name="Calc" select="Layout/Calculation"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="LayoutDestination/@value = 'LayoutNameByCalc'">
				<xsl:if test="$pVerbose = 'True'">
					<xsl:value-of select="'By Name'"/>
					<xsl:value-of select="$delimiter2"/>
				</xsl:if>
				<xsl:call-template name="OutputCalculation">
					<xsl:with-param name="Calc" select="Layout/Calculation"/>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--
	 ! ScriptStepParamLock_state: True/False -> Lock/""
	 !-->
	<xsl:template name="ScriptStepParamLock_state">
		<xsl:param name="state"/>
		<!---->
		<xsl:value-of select="'Lock'"/>
		<xsl:value-of select="$delimiter2"/>
		<xsl:choose>
			<xsl:when test="$state = 'True'">
				<xsl:value-of select="'On'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'Off'"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="$delimiter3"/>
	</xsl:template>
	<!--
	 ! ScriptStepParamNoDialog
	 !-->
	<xsl:template name="ScriptStepParamNoDialog">
		<xsl:value-of select="'With dialog'"/>
		<xsl:value-of select="$delimiter2"/>
		<xsl:choose>
			<xsl:when test="NoInteract/@state = 'True'">
				<xsl:value-of select="'Off'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'On'"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="$delimiter3"/>
	</xsl:template>
	<!--
	 ! ScriptStepParamPageFormat
	 !-->
	<xsl:template name="ScriptStepParamPageFormat">
		<!-- -->
		<xsl:value-of select="'Orientation'"/>
		<xsl:value-of select="$delimiter2"/>
		<xsl:choose>
			<xsl:when test="PageFormat/@PageOrientation">
				<xsl:value-of select="PageFormat/@PageOrientation"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'Portrait'"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="$delimiter3"/>
		<!-- -->
		<xsl:if test="PageFormat/@PaperRight">
			<xsl:variable name="pageWidth"
				select="(PageFormat/@PaperRight - PageFormat/@PaperLeft) div 72"/>
			<xsl:variable name="pageWidth2dp" select="round($pageWidth * 100) div 100"/>
			<xsl:variable name="pageHeight"
				select="(PageFormat/@PaperBottom - PageFormat/@PaperTop) div 72"/>
			<xsl:variable name="pageHeight2dp" select="round($pageHeight * 100) div 100"/>
			<xsl:value-of select="'Paper size'"/>
			<xsl:value-of select="$delimiter2"/>
			<xsl:value-of select="concat($pageWidth2dp, $QUOT, ' x ', $pageHeight2dp, $QUOT)"/>
			<xsl:value-of select="$delimiter3"/>
		</xsl:if>
		<!-- -->
		<xsl:if test="PageFormat/@ScaleFactor and PageFormat/@ScaleFactor != '1'">
			<xsl:variable name="pageScalingPercent" select="PageFormat/@ScaleFactor * 100"/>
			<xsl:variable name="pageScalingPercent2dp"
				select="round($pageScalingPercent * 100) div 100"/>
			<xsl:value-of select="'Scaling'"/>
			<xsl:value-of select="$delimiter2"/>
			<xsl:value-of select="concat($pageScalingPercent2dp, '%')"/>
			<xsl:value-of select="$delimiter3"/>
		</xsl:if>
	</xsl:template>
	<!--
	 ! ScriptStepParamPause
	 !-->
	<xsl:template name="ScriptStepParamPause">
		<xsl:value-of select="'Pause'"/>
		<xsl:value-of select="$delimiter2"/>
		<xsl:choose>
			<xsl:when test="Pause/@state = 'True'">
				<xsl:value-of select="'On'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'Off'"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="$delimiter3"/>
	</xsl:template>
	<!--
	 ! ScriptStepParamSaveType
	 !-->
	<xsl:template name="ScriptStepParamSaveType">
		<xsl:choose>
			<xsl:when test="SaveType/@value = 'BrowsedRecords'">
				<xsl:value-of select="'Records being browsed'"/>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
			</xsl:when>
			<xsl:when test="SaveType/@value = 'CurrentRecord'">
				<xsl:value-of select="'Current record'"/>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="ScriptStepParamScriptSpecified">
		<xsl:value-of select="'Specified'"/>
		<xsl:value-of select="$delimiter2"/>
		<xsl:choose>
			<xsl:when test="Calculated/Calculation">
				<xsl:value-of select="'By name'"/>
				<xsl:value-of select="$delimiter3"/>
				<xsl:call-template name="OutputCalculation">
					<xsl:with-param name="Calc" select="Calculated/Calculation"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'From list'"/>
				<xsl:value-of select="$delimiter3"/>
				<xsl:call-template name="QuotedStringOrUnknown">
					<xsl:with-param name="string" select="Script/@name"/>
				</xsl:call-template>
				<xsl:if test="FileReference/@name">
					<xsl:value-of select="' '"/>
					<xsl:value-of select="'from file'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:value-of select="$OPENQUOTES"/>
					<xsl:value-of select="FileReference/@name"/>
					<xsl:value-of select="$CLOSEQUOTES"/>
					<xsl:if test="FileReference/@name = ''">
						<xsl:value-of select="' (file not open)'"/>
					</xsl:if>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="$delimiter3"/>
		<!-- Parameter -->
		<xsl:value-of select="'Parameter'"/>
		<xsl:value-of select="$delimiter2"/>
		<xsl:call-template name="OutputCalculationOrTwoSpaces">
			<xsl:with-param name="Calc" select="Calculation"/>
		</xsl:call-template>
		<xsl:value-of select="$delimiter3"/>
		<!-- -->
	</xsl:template>
	<xsl:template name="ScriptStepParamSelect">
		<xsl:param name="delimiter3"/>
		<xsl:if test="SelectAll/@state = 'True'">
			<xsl:value-of select="'Select'"/>
			<xsl:value-of select="$delimiter3"/>
		</xsl:if>
	</xsl:template>
	<!--
	 ! ScriptStepParamSelectWindow
	 !-->
	<xsl:template name="ScriptStepParamSelectWindow">
		<xsl:param name="Label" select="'Name'"/>
		<!--  -->
		<xsl:choose>
			<xsl:when test="Window/@value = 'Current'">
				<xsl:value-of select="'Current Window'"/>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
			</xsl:when>
			<xsl:when test="Window/@value = 'ByName'">
				<xsl:value-of select="$Label"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:call-template name="OutputCalculation">
					<xsl:with-param name="Calc" select="Name/Calculation"/>
				</xsl:call-template>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
				<xsl:if test="LimitToWindowsOfCurrentFile/@state = 'True'">
					<xsl:value-of select="'Current file'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--
	 ! ScriptStepParamSpecifyFile
	 !-->
	<xsl:template name="ScriptStepParamSpecifyFile">
		<!--  -->
		<xsl:if test="UniversalPathList/text()">
			<xsl:call-template name="UniversalPathListFileName"/>
			<xsl:value-of select="$delimiter3"/>
		</xsl:if>
	</xsl:template>
	<!--
	 ! ScriptStepParamSpecifyOutputFile
	 !
	 ! In FM 17 the SaveAsType attribute has moved into this block 
	 !-->
	<xsl:template name="ScriptStepParamSpecifyOutputFile">
		<xsl:param name="SaveAsType" select="''"/>
		<!--  -->
		<xsl:call-template name="ScriptStepParamSpecifyFile"/>
		<xsl:if test="$SaveAsType">
			<xsl:choose>
				<xsl:when test="$SaveAsType/@value = 'Clone'">
					<xsl:value-of select="'clone (no records)'"/>
				</xsl:when>
				<xsl:when test="$SaveAsType/@value = 'CompactedCopy'">
					<xsl:value-of select="'compacted copy (smaller)'"/>
				</xsl:when>
				<xsl:when test="$SaveAsType/@value = 'Copy'">
					<xsl:value-of select="'copy of current file'"/>
				</xsl:when>
				<xsl:when test="$SaveAsType/@value = 'SelfContainedCopy'">
					<xsl:value-of select="'self-contained copy (single file)'"/>
				</xsl:when>
			</xsl:choose>
			<xsl:value-of select="$delimiter3"/>
		</xsl:if>
		<xsl:if test="AutoOpen/@state = 'True'">
			<xsl:value-of select="'Automatically open'"/>
			<xsl:value-of select="$delimiter3"/>
		</xsl:if>
		<!-- -->
		<xsl:if test="CreateEmail/@state = 'True'">
			<xsl:value-of select="'Create email'"/>
			<xsl:value-of select="$delimiter3"/>
		</xsl:if>
		<xsl:if test="$pVerbose = 'True'">
			<xsl:call-template name="ScriptStepParamCreateDirectories"/>
		</xsl:if>
	</xsl:template>
	<!--
	 ! ScriptStepParamQuery
	 !-->
	<xsl:template name="ScriptStepParamQuery">
		<xsl:if test="Restore/@state = 'True'">
			<xsl:if test="$pVerbose = 'True'">
				<!--xsl:value-of select="'Specified Find Requests'"/>
				<xsl:value-of select="$delimiter2"/-->
				<xsl:for-each select="Query/RequestRow">
					<xsl:choose>
						<xsl:when test="@operation = 'Include'">
							<xsl:value-of select="'Find Records'"/>
						</xsl:when>
						<xsl:when test="@operation = 'Exclude'">
							<xsl:value-of select="'Omit Records'"/>
						</xsl:when>
					</xsl:choose>
					<xsl:value-of select="$delimiter2"/>
					<!-- -->
					<xsl:for-each select="Criteria">
						<xsl:if test="not(position() = 1)">
							<xsl:value-of select="' AND '"/>
						</xsl:if>
						<xsl:value-of select="Field/@table"/>
						<xsl:value-of select="'::'"/>
						<xsl:value-of select="Field/@name"/>
						<!-- FIXME -->
						<xsl:value-of select="': '"/>
						<xsl:value-of select="$OPENQUOTES"/>
						<xsl:value-of select="translate(Text, $CRLF, '  ')"/>
						<xsl:value-of select="$CLOSEQUOTES"/>
						<!-- -->
					</xsl:for-each>
					<xsl:if test="not(position() = last())">
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
				</xsl:for-each>
				<xsl:value-of select="$delimiter3"/>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<!--
	 ! ScriptStepParamCreateDirectories
	 !-->
	<xsl:template name="ScriptStepParamCreateDirectories">
		<xsl:choose>
			<xsl:when test="CreateDirectories/@state = 'True'">
				<xsl:value-of select="'Create directories'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:value-of select="'On'"/>
				<xsl:value-of select="$delimiter3"/>
			</xsl:when>
			<xsl:when test="CreateDirectories/@state = 'False'">
				<xsl:value-of select="'Create directories'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:value-of select="'Off'"/>
				<xsl:value-of select="$delimiter3"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- FileMaker 16- ... no CreateDirectories function -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	 ! ScriptStepParamRestore
	 !-->
	<xsl:template name="ScriptStepParamRestore">
		<xsl:if test="Restore/@state = 'True'">
			<xsl:value-of select="'Restore'"/>
			<xsl:value-of select="$delimiter3"/>
		</xsl:if>
	</xsl:template>
	<!--
	 ! ScriptStepParamUniversalPathListReference
	 !-->
	<xsl:template name="ScriptStepParamUniversalPathListReference">
		<!---->
		<xsl:if test="UniversalPathList/text() and UniversalPathList/@type = 'Reference'">
			<xsl:value-of select="UniversalPathList/@type"/>
			<xsl:value-of select="$delimiter3"/>
		</xsl:if>
		<!-- -->
	</xsl:template>
	<!--
	 ! ScriptStepParamVerifySSLCertificates
	 !-->
	<xsl:template name="ScriptStepParamVerifySSLCertificates">
		<!--  -->
		<xsl:if test="VerifySSLCertificates/@state = 'True'">
			<xsl:value-of select="'Verify SSL Certificates'"/>
			<xsl:value-of select="$delimiter3"/>
		</xsl:if>
	</xsl:template>
	<!--
	 ! ScriptStepPassword
	 !-->
	<xsl:template name="ScriptStepPassword">
		<xsl:param name="Password"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="$pScriptStepHidePasswords = 'True'">
				<xsl:value-of select="'••••••••'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="OutputCalculation">
					<xsl:with-param name="Calc" select="$Password/Calculation"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	 ! Set_state: True/False -> On/Off
	 !-->
	<xsl:template name="Set_state">
		<xsl:param name="state"/>
		<!---->
		<xsl:choose>
			<xsl:when test="$state = 'True'">
				<xsl:value-of select="'On'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'Off'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	 ! ShowHide_value: Show/Hide/Toggle -> On/Off/Toggle
	 !-->
	<xsl:template name="ShowHide_value">
		<xsl:param name="value"/>
		<!---->
		<xsl:choose>
			<xsl:when test="$value = 'Hide'">
				<xsl:value-of select="'Off'"/>
			</xsl:when>
			<xsl:when test="$value = 'Show'">
				<xsl:value-of select="'On'"/>
			</xsl:when>
			<xsl:when test="$value = 'Toggle'">
				<xsl:value-of select="'Toggle'"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--
	 ! SIC.delimiter3
	 !  Outputs the delimiter WITHOUT a space, exactly as it is (incorrectly) output in FileMaker
	 !-->
	<xsl:template name="SIC.delimiter3">
		<xsl:choose>
			<xsl:when test="$pSIC = 'True' and $delimiter3 = ' ; '">
				<!-- output with MISSING space, as script text really is -->
				<xsl:value-of select="'; '"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$delimiter3"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	 ! SpecifyXMLandXSLOptions
	 !-->
	<xsl:template name="SpecifyXMLandXSLOptions">
		<xsl:call-template name="ScriptStepParamSpecifyFile"/>
		<xsl:value-of select="$OPENQUOTES"/>
		<xsl:value-of select="Profile/@grammar"/>
		<xsl:value-of select="$CLOSEQUOTES"/>
		<xsl:value-of select="$delimiter3"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="Profile/@XSLType = 'XSLFile'">
				<xsl:call-template name="UniversalPathListFileName">
					<xsl:with-param name="pathList" select="Profile/XSLFile"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="Profile/@XSLType = 'XSLHttp'">
				<xsl:value-of select="$OPENQUOTES"/>
				<xsl:value-of select="Profile/XSLHttp"/>
				<xsl:value-of select="$CLOSEQUOTES"/>
			</xsl:when>
			<xsl:when test="Profile/@XSLType = 'XSLCalculation'">
				<xsl:call-template name="OutputCalculation">
					<xsl:with-param name="Calc" select="Profile/XSLCalc/Calculation"/>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
		<xsl:value-of select="$delimiter3"/>
		<!-- -->
		<xsl:value-of select="'Unicode (UTF-8)'"/>
		<xsl:value-of select="$delimiter3"/>
	</xsl:template>
	<!--
	 ! UniversalPathListFileName 
	 !
	 ! protocol:path/to/filename1;protocol:path/to/filename2;...
	 ! 
	 !-->
	<xsl:template name="UniversalPathListFileName">
		<xsl:param name="pathList" select="UniversalPathList"/>
		<!--  -->
		<xsl:if test="$pathList">
			<xsl:value-of select="$OPENQUOTES"/>
			<xsl:call-template name="fn.substring-after-last">
				<xsl:with-param name="text" select="substring-before(concat($pathList, ';'), ';')"/>
				<xsl:with-param name="searchString">
					<xsl:choose>
						<xsl:when test="contains($pathList, '/')">
							<xsl:value-of select="'/'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="':'"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$CLOSEQUOTES"/>
		</xsl:if>
	</xsl:template>
	<!--
	 ! UseAsFileDefault/@state: True/False -> delim + No dialog/""
	 !-->
	<xsl:template name="UseAsFileDefault_state">
		<xsl:param name="state"/>
		<!---->
		<xsl:value-of select="'Use as file default'"/>
		<xsl:value-of select="$delimiter2"/>
		<xsl:call-template name="Set_state">
			<xsl:with-param name="state" select="$state"/>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
