<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2025 @mrwatson-de

	===== PURPOSE =====

	XSL-File: _inc/inc.XMSS_Text_PrintSteps.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps

	Contains the basic functions for listing scripts & script steps.
	
	WARNING: BETA-VERSION STILL IN DEVELOPMENT!
	To Do:
		1) DOING - Standardise coding
		2) DOING - Refactor coding
		3) DOING - Make multiple output formats possible (not just single row multi-column format)
		4) LATER - i18n
	
	===== CHANGES HISTORY =====
	2025-09-15 @mrwatson-de:
	- Started adding comments defining the i18n strings
	2025-09-09 @mrwatson-de:
	- Resolves #11 Standardise Variables and parameters to use lowerCamelCase
	2025-09-08 @mrwatson-de:
	- Resolves #5 Update for FM21
	- Resolves #15 Update for FM22
	- Resolves #20 All the missing functionality I could find
	2025-06-30 @mrwatson-de:
	- Fixed many little changes to steps and bugs
	- Adding FM21 stuff but not finished yet
	2023-11-20 @mrwatson-de:
	- Added FM20.1 Perform Script on Server with Callback
	- Added FM20.1 Trigger Claris Connect Flow
	- Added FM20.3 Loop Flush
	2023-02-27 @mrwatson-de:
	- Added new script steps up to FM19.6.2
	- Fixed changed texts
	- Fixed spelling of parameter label (NOT lable)
	2019-05-23 @mrwatson-de: It's that time of year again - fm18 ! :-) ...
	- Added new script steps
	2018-05-06 @mrwatson-de: It's that time of year :-) ...
	- Corrected, refactored, sorted + tidied code, improved comments - thanks to oXygen XML Editor - nice!
	- Added FileMaker 17 script steps + changed output formatting
	- Improved output of Print + Print Setup steps, inc. attributes + printer names
	2017-05-21 @mrwatson-de: Another huge day...
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
	 ! Script step 3. Save a Copy as XML
	 ! ========
		<Step enable="True" id="3" name="Save a Copy as XML">
			<Option state="True"/>
			<UniversalPathList>$file</UniversalPathList>
			<Calculation><![CDATA["window"]]></Calculation>
		</Step>
	 ! ========
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '3']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
					<xsl:with-param name="optional_label" select="'Window name'"/>
					<xsl:with-param name="calc" select="Calculation"/>
				</xsl:call-template>
				<xsl:value-of select="'Destination file'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:call-template name="ScriptStepParamSpecifyFile">
					<xsl:with-param name="default" select="'&lt;unknown&gt;'"/>
				</xsl:call-template>
				<xsl:call-template name="ScriptStepParamBooleany">
					<xsl:with-param name="value" select="Option/@state"/>
					<xsl:with-param name="true" select="'Include details for analysis tools'"/>
				</xsl:call-template>
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
				<!-- i18n dbengine_string::kScriptEventWaitStrID -->
				
				<xsl:value-of select="'Wait for completion'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:call-template name="OutputTrueAsOnElseOff">
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
						<!-- i18n dbengine_string::kScriptPauseDurationStrID1 -->
						<xsl:value-of select="'Duration (seconds)'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:call-template name="OutputCalculation">
							<xsl:with-param name="calc" select="Calculation"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="PauseTime/@value = 'Indefinitely'">
						<!-- i18n dbengine_string::kScriptPauseIndefinitelyStrID -->
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
				<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
					<!-- i18n dbengine_string::kScriptReturnValueLabelStrID -->
					<xsl:with-param name="optional_label" select="'Text Result'"/>
					<xsl:with-param name="calc" select="Calculation"/>
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
					<xsl:with-param name="calc" select="Calculation"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 71. Loop
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '71']">
	<xsl:variable name="flush" select="FlushType/@value"/>
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:if test="$flush!=''">
			<xsl:call-template name="ScriptStepParameterList">
				<xsl:with-param name="pParameterList">
					<!-- i18n dbengine_string::kScriptLoopAlwaysFlushDoneStrID -->
					<xsl:value-of select="'Flush'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="@flush"/>
							<xsl:choose>
							<xsl:when test="$flush='Always'">
								<!-- i18n dbengine_string::kScriptLoopAlwaysFlushStrID -->
								<xsl:value-of select="'Always'"/>
						</xsl:when>
						<xsl:when test="$flush='Defer'">
							<!-- i18n dbengine_string::kScriptLoopDeferFlushStrID -->
							<xsl:value-of select="'Defer'"/>
						</xsl:when>
						<xsl:when test="$flush='Min'">
							<!-- i18n dbengine_string::kScriptLoopMinFlushStrID -->
							<xsl:value-of select="'Minimum'"/>
						</xsl:when>
					</xsl:choose>
					<xsl:value-of select="$delimiter3"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:call-template name="ScriptStepEND"/>
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
					<xsl:with-param name="calc" select="Calculation"/>
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
					<xsl:with-param name="calc" select="Calculation"/>
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
				<xsl:call-template name="OutputTrueAsOnElseOff">
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
				<xsl:call-template name="OutputTrueAsOnElseOff">
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
					<!-- i18n dbengine_string::kScriptValueStrID-->
					<xsl:value-of select="'Value'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="calc" select="Value/Calculation"/>
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
				<xsl:call-template name="OutputTrueAsOnElseOff">
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

						<xsl:call-template name="ScriptStepParamCalculation">
							<!-- i18n dbengine_string::kScriptParameterStrID -->
							<xsl:with-param name="optional_label" select="'Parameter'"/>
							<xsl:with-param name="calc" select="Calculation"/>
						</xsl:call-template>
					</xsl:if>
					<!-- -->
				</xsl:if>
				<xsl:if test="Interval/Calculation">
					<!-- i18n dbengine_string::kScriptSpecifyIntervalLabel -->
					<xsl:value-of select="'Interval'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="calc" select="Interval/Calculation"/>
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
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamLayoutDestination"/>
				<xsl:call-template name="ScriptStepParamAnimationValue"/>
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
						<!-- i18n dbengine_string::kScriptExitAfterLastStrID -->
						<xsl:value-of select="'Exit after last'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:call-template name="OutputTrueAsOnElseOff">
							<xsl:with-param name="state" select="Exit/@state"/>
						</xsl:call-template>
						<xsl:value-of select="$delimiter3"/>
					</xsl:when>
					<xsl:when test="RowPageLocation/@value = 'Next'">
						<xsl:value-of select="'Next'"/>
						<xsl:value-of select="$delimiter3"/>
						<!-- i18n dbengine_string::kScriptExitAfterLastStrID -->
						<xsl:value-of select="'Exit after last'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:call-template name="OutputTrueAsOnElseOff">
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
							<xsl:with-param name="calc" select="Calculation"/>
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
					<!-- i18n dbengine_string::kScriptShowOnlyRelatedStrID -->
					<xsl:value-of select="'Show only related records'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="MatchAllRecords/@state = 'True'">
					<!-- i18n dbengine_string::kScriptMatchFoundSetStrID -->
					<xsl:value-of select="'Match found set'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<!-- i18n dbengine_string::kScriptFromTableStrID -->
				<xsl:value-of select="'From table'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:call-template name="QuotedStringOrUnknown">
					<xsl:with-param name="string" select="Table/@name"/>
				</xsl:call-template>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
				<xsl:if test="Option/@state = 'True'">
					<!-- i18n dbengine_string::kScriptExternalStrID -->
					<xsl:value-of select="'External'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<!-- i18n dbengine_string::kScriptUsingLayoutStrID -->
				<xsl:value-of select="'Using layout'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:call-template name="ScriptStepParamLayoutDestination"/>
				<!-- -->
				<xsl:if test="ShowInNewWindow/@state = 'True'">
					<!-- i18n dbengine_string::kScriptCreateWindowStrID -->
					<xsl:value-of select="'New window'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<xsl:if test="Animation/@value and Animation/@value!='None'">
					<xsl:call-template name="ScriptStepParamAnimationValue"/>					
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
				<!-- i18n dbengine_string::kScriptSelectStrID -->
				<xsl:value-of select="'Select'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:call-template name="OutputTrueAsOnElseOff">
					<xsl:with-param name="state" select="SelectAll/@state"/>
				</xsl:call-template>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
				<xsl:choose>
					<xsl:when test="RowPageLocation/@value = 'First'">
						<!-- i18n dbengine_string::kGotoPopupFirstStrID -->
						<xsl:value-of select="'First'"/>
						<xsl:value-of select="$delimiter3"/>
						<!-- -->
					</xsl:when>
					<xsl:when test="RowPageLocation/@value = 'Previous'">
						<!-- i18n dbengine_string::kGotoPopupPreviousStrID -->
						<xsl:value-of select="'Previous'"/>
						<xsl:value-of select="$delimiter3"/>
						<!-- -->
						<!-- i18n dbengine_string::kScriptExitAfterLastStrID -->
						<xsl:value-of select="'Exit after last'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:call-template name="OutputTrueAsOnElseOff">
							<xsl:with-param name="state" select="Exit/@state"/>
						</xsl:call-template>
						<xsl:value-of select="$delimiter3"/>
					</xsl:when>
					<xsl:when test="RowPageLocation/@value = 'Next'">
						<!-- i18n dbengine_string::kGotoPopupNextStrID -->
						<xsl:value-of select="'Next'"/>
						<xsl:value-of select="$delimiter3"/>
						<!-- -->
						<!-- i18n dbengine_string::kScriptExitAfterLastStrID -->
						<xsl:value-of select="'Exit after last'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:call-template name="OutputTrueAsOnElseOff">
							<xsl:with-param name="state" select="Exit/@state"/>
						</xsl:call-template>
						<xsl:value-of select="$delimiter3"/>
					</xsl:when>
					<xsl:when test="RowPageLocation/@value = 'Last'">
						<!-- i18n dbengine_string::kGotoPopupLastStrID -->
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
							<xsl:with-param name="calc" select="Calculation"/>
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
					<xsl:call-template name="ScriptStepParamCalculation">
						<!-- i18n dbengine_string::kScriptOptionObjectNameStrID -->
						<xsl:with-param name="optional_label" select="'Object Name'"/>
						<xsl:with-param name="calc" select="ObjectName/Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<!-- -->
				<xsl:call-template name="ScriptStepParamRepetition"/>
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
					<!-- i18n dbengine_string::kScriptOptionSelectPerformStrID -->
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
				<xsl:choose>
					<xsl:when test="UndoRedo/@value='Undo'">
						<!-- i18n dbengine_string::kScriptUndoStrID -->
						<xsl:value-of select="'Undo'"/>
					</xsl:when>
					<xsl:when test="UndoRedo/@value='Redo'">
						<!-- i18n dbengine_string::kScriptRedoStrID -->
						<xsl:value-of select="'Redo'"/>
					</xsl:when>
					<xsl:when test="UndoRedo/@value='Toggle'">
						<!-- i18n dbengine_string::kScriptToggleUndoStrID -->
						<xsl:value-of select="'Toggle'"/>
					</xsl:when>
				</xsl:choose>
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
					<!-- i18n dbengine_string::kScriptNoStyleStrID -->
					<xsl:value-of select="'No style'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="LinkAvail/@state = 'True'">
					<!-- FIXME - isn't this outdated? -->
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

					<xsl:call-template name="ScriptStepParamCalculation">
						<!-- i18n dbengine_string::kScriptStartPosStrID -->
						<xsl:with-param name="optional_label" select="'Start Position'"/>
						<xsl:with-param name="calc" select="StartPosition/Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<!-- -->
				<xsl:if test="EndPosition">

					<xsl:call-template name="ScriptStepParamCalculation">
						<!-- i18n dbengine_string::kScriptEndPosStrID -->
						<xsl:with-param name="optional_label" select="'End Position'"/>
						<xsl:with-param name="calc" select="EndPosition/Calculation"/>
					</xsl:call-template>
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
						<xsl:with-param name="calc" select="FindCalc/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="ReplaceCalc/Calculation">
					<!--xsl:value-of select="'Replace'"/>
					<xsl:value-of select="$delimiter2"/-->
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="calc" select="ReplaceCalc/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:choose>
					<xsl:when test="FindReplaceOperation/@type = 'FindNext'">
						<!-- i18n dbengine_string::kScriptFindReplaceFindNextStrID -->
						<xsl:value-of select="'Find Next'"/>
					</xsl:when>
					<xsl:when test="FindReplaceOperation/@type = 'ReplaceAndFind'">
						<!-- i18n dbengine_string::kScriptFindReplaceReplaceAndFindStrID -->
						<xsl:value-of select="'Replace &amp; Find'"/>
					</xsl:when>
					<xsl:when test="FindReplaceOperation/@type = 'Replace'">
						<!-- i18n dbengine_string::kScriptFindReplaceReplaceStrID -->
						<xsl:value-of select="'Replace'"/>
					</xsl:when>
					<xsl:when test="FindReplaceOperation/@type = 'ReplaceAll'">
						<!-- i18n dbengine_string::kScriptFindReplaceReplaceAllStrID -->
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
					<xsl:with-param name="calc" select="Calculation"/>
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
					<xsl:with-param name="calc" select="TargetName/Calculation"/>
				</xsl:call-template>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
				<xsl:if test="Result">
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="calc" select="Result/Calculation"/>
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
					<xsl:with-param name="calc" select="Calculation"/>
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
				<xsl:call-template name="ScriptStepParamTarget"/>
				<xsl:if test="Text/text()">
					<xsl:value-of select="$OPENQUOTES"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="calc" select="Text"/>
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
				<xsl:call-template name="ScriptStepParamTarget"/>
				<xsl:call-template name="OutputCalculation">
					<xsl:with-param name="calc" select="Calculation"/>
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
				<xsl:call-template name="ScriptStepParamTarget">
					<xsl:with-param name="label" select="''"/>
				</xsl:call-template>
				<!-- i18n dbengine_string::kTypeStrID -->
				<xsl:value-of select="'Type'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:for-each select="InsertFrom/@value">
					<xsl:choose>
						<xsl:when test=".='Camera'">
							<!-- i18n dbengine_string::kInsertFromDeviceCameraStillStrID -->
							<xsl:value-of select="'Camera'"/>
						</xsl:when>
						<xsl:when test=".='Video Camera'">
							<!-- i18n dbengine_string::kInsertFromDeviceCameraVideoStrID -->
							<xsl:value-of select="'Video Camera'"/>
						</xsl:when>
						<xsl:when test=".='Microphone'">
							<!-- i18n dbengine_string::kInsertFromDeviceMicrophoneStrID -->
							<xsl:value-of select="'Microphone'"/>
						</xsl:when>
						<xsl:when test=".='Barcode'">
							<!-- i18n dbengine_string::kInsertFromDeviceBarCodeStrID -->
							<xsl:value-of select="'Barcode'"/>
						</xsl:when>
						<xsl:when test=".='Photo Library'">
							<!-- i18n dbengine_string::kInsertFromDevicePhotoLibStrID -->
							<xsl:value-of select="'Photo Library'"/>
						</xsl:when>
						<xsl:when test=".='Music Library'">
							<!-- i18n dbengine_string::kInsertFromDeviceMusicLibStrID -->
							<xsl:value-of select="'Music Library'"/>
						</xsl:when>
						<xsl:when test=".='Signature'">
							<!-- i18n dbengine_string::kInsertFromDeviceSignatureStrID -->
							<xsl:value-of select="'Signature'"/>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
				<xsl:if test="DeviceOptions/Camera">
					<!-- i18n dbengine_string::kDeviceCameraStrID -->
					<xsl:value-of select="'Camera'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:for-each select="DeviceOptions/Camera/@choice">
						<xsl:choose>
							<xsl:when test=".='Back'">
								<!-- i18n dbengine_string::kDeviceCameraBackStrID -->
								<xsl:value-of select="'Back'"/>
							</xsl:when>
							<xsl:when test=".='Front'">
								<!-- i18n dbengine_string::kDeviceCameraFrontStrID -->
								<xsl:value-of select="'Front'"/>
							</xsl:when>
						</xsl:choose>
					</xsl:for-each>
					
					
					<xsl:call-template name="SIC.delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="DeviceOptions/Resolution">
					<!-- i18n dbengine_string::kResolutionStrID -->
					<xsl:value-of select="'Resolution'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:for-each select="DeviceOptions/Resolution/@choice">
						<xsl:choose>
							<xsl:when test=".='Full'">
								<!-- i18n dbengine_string::kResolutionFullStrID -->
								<xsl:value-of select="'Full'"/>
							</xsl:when>
							<xsl:when test=".='Large'">
								<!-- i18n dbengine_string::kResolutionLargeStrID -->
								<xsl:value-of select="'Large'"/>
							</xsl:when>
							<xsl:when test=".='Medium'">
								<!-- i18n dbengine_string::kResolutionMediumStrID -->
								<xsl:value-of select="'Medium'"/>
							</xsl:when>
							<xsl:when test=".='Small'">
								<!-- i18n dbengine_string::kResolutionSmallStrID -->
								<xsl:value-of select="'Small'"/>
							</xsl:when>
						</xsl:choose>
					</xsl:for-each>
					<xsl:call-template name="SIC.delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="DeviceOptions/MaxDuration/@state = 'True'">
					<!-- i18n dbengine_string::kMaxDurationStrID -->
					<xsl:value-of select="'Max duration'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="calc" select="DeviceOptions/MaxDuration/Calculation"/>
					</xsl:call-template>
					<xsl:call-template name="SIC.delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="DeviceOptions/StartImmediately/@state = 'True'">
					<!-- i18n dbengine_string::kStartImmediatelyStrID -->
					<xsl:value-of select="'Start immediately'"/>
					<xsl:call-template name="SIC.delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="DeviceOptions/Title/Calculation">
					<!-- i18n dbengine_string::kPrintShowCustomDialogTitleStrID -->
					<xsl:value-of select="'Title'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="calc" select="DeviceOptions/Title/Calculation"/>
					</xsl:call-template>
					<xsl:call-template name="SIC.delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="DeviceOptions/Message/Calculation">
					<!-- i18n dbengine_string::kPrintShowCustomDialogMessageStrID -->
					<xsl:value-of select="'Message'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="calc" select="DeviceOptions/Message/Calculation"/>
					</xsl:call-template>
					<xsl:call-template name="SIC.delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="DeviceOptions/Prompt/Calculation">
					<!-- i18n dbengine_string::kSignaturePromptStrID -->
					<xsl:value-of select="'Prompt'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="calc" select="DeviceOptions/Prompt/Calculation"/>
					</xsl:call-template>
					<xsl:call-template name="SIC.delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="DeviceOptions/Presentation/@choice">
					<!-- i18n dbengine_string::kPresentationStrID -->
					<xsl:value-of select="'Presentation'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:choose>
						<xsl:when test="DeviceOptions/Presentation/@choice = 'Full Screen'">
							<!-- i18n dbengine_string::kPresentationFullStrID -->
							<xsl:value-of select="'Full Screen'"/>
						</xsl:when>
						<xsl:when test="DeviceOptions/Presentation/@choice = 'Overlay'">
							<!-- i18n dbengine_string::kPresentationInlineStrID -->
							<xsl:value-of select="'Overlay'"/>
						</xsl:when>
						<xsl:when test="DeviceOptions/Presentation/@choice = 'Embedded'">
							<!-- i18n dbengine_string::kPresentationEmbeddedStrID -->
							<xsl:value-of select="'Embedded'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="DeviceOptions/Presentation/@choice"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:call-template name="SIC.delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="DeviceOptions/ScanFrom/@type = 'Field'">
						<xsl:call-template name="ScriptStepParamTarget">
							<!-- i18n dbengine_string::kScanFromStrID -->
							<xsl:with-param name="label" select="'Scan from'"/>
							<xsl:with-param name="field" select="DeviceOptions/ScanFrom/Field"/>
						</xsl:call-template>
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

	Note: In FM18 the parameter order changed and demoted VerifySSLCertificates to behind the URL.
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '160']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamSelect"/>
				<xsl:call-template name="ScriptStepParamNoDialog"/>
				<xsl:call-template name="ScriptStepParamTarget"/>
				<xsl:if test="Calculation">
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="calc" select="Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<xsl:call-template name="ScriptStepParamVerifySSLCertificates"/>
				<!-- -->
				<xsl:if test="CURLOptions/Calculation">

					<xsl:call-template name="ScriptStepParamCalculation">
						<!-- i18n dbengine_string::kScriptPrintCURLOptionsID -->
						<xsl:with-param name="optional_label" select="'cURL options'"/>
						<xsl:with-param name="calc" select="CURLOptions/Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<!-- -->
				<xsl:if test="DontEncodeURL/@state = 'True'">
					<!-- i18n dbengine_string::kScriptDoNotAutoEncodeStrID -->
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
				<xsl:call-template name="ScriptStepParamTarget"/>
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
				<xsl:call-template name="ScriptStepParamTarget"/>
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
				<xsl:call-template name="ScriptStepParamTarget"/>
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
				<xsl:call-template name="ScriptStepParamTarget"/>
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
				<xsl:if test="UniversalPathList/@type = 'Reference'">
					<!-- i18n dbengine_string::kScriptReferenceStrID -->
					<xsl:value-of select="'Reference'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				
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
					<!-- i18n dbengine_string::kInsertFileOptionsFiltersStrID -->
					<xsl:value-of select="'Filters'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<!-- i18n FIXME - different key same result? dbengine_string::kInsertFileOptionsReferenceOnlyStrID -->
				<xsl:call-template name="ScriptStepParamUniversalPathListReference"/>
				<xsl:if test="DialogOptions[@enable = 'True']/Storage/@type = 'InsertOnly'">
					<!-- i18n dbengine_string::kInsertFileOptionsEmbedOnlyStrID -->
					<xsl:value-of select="'Insert'"/>
					<xsl:value-of select="$delimiter3"/>
					<!-- -->
				</xsl:if>
				<xsl:if test="DialogOptions/@asFile = 'False'">
					<!-- i18n dbengine_string::kInsertFileOptionsMediaStrID -->
					<xsl:value-of select="'Display content'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:choose>
					<xsl:when test="DialogOptions[@enable = 'True']/Compress/@type = 'UserChoice'">
						<!-- no text -->
					</xsl:when>
					<xsl:when test="DialogOptions[@enable = 'True']/Compress/@type = 'Never'">
						<!-- i18n dbengine_string::kInsertFileOptionsNeverStrID -->
						<xsl:value-of select="'Never compress'"/>
						<xsl:value-of select="$delimiter3"/>
						<!-- -->
					</xsl:when>
					<xsl:when test="DialogOptions[@enable = 'True']/Compress/@type = 'WhenPossible'">
						<!-- i18n dbengine_string::kInsertFileOptionsAlwaysStrID -->
						<xsl:value-of select="'Compress when possible'"/>
						<xsl:value-of select="$delimiter3"/>
						<!-- -->
					</xsl:when>
				</xsl:choose>
				<xsl:call-template name="ScriptStepParamTarget"/>
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
						<xsl:value-of select="$delimiter3"/>
					</xsl:when>
					<xsl:when test="With/@value='SerialNumbers'">
						<!-- i18n dbengine_string::kScriptSerialNumbersStrID -->
						<xsl:value-of select="'Serial numbers'"/>
						<xsl:if test="$pVerbose = 'True'">
							<xsl:value-of select="$delimiter2"/>
							<xsl:choose>
								<xsl:when test="SerialNumbers/@UseEntryOptions = 'True'">
									<!-- i18n -->
									<xsl:value-of select="'Use Entry Options'"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="SerialNumbers/@UpdateEntryOptions = 'False'">
											<!-- i18n -->
											<xsl:value-of select="'Update Entry Options'"/>
										</xsl:when>
										<xsl:otherwise>
											<!-- i18n -->
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
							<xsl:with-param name="calc" select="Calculation"/>
						</xsl:call-template>
						<xsl:value-of select="$delimiter3"/>
					</xsl:when>
				</xsl:choose>
				<xsl:if test="Restore/@state='True'">
					<!-- i18n dbengine_string::kScriptOptionSkipAutoEntryStrID -->
					<xsl:value-of select="'Skip auto-enter options'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
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
					<!-- i18n dbengine_string::kScriptForceCommitStrID -->
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
				<xsl:call-template name="ScriptStepParamNoDialog"/>
				<!-- In fm18 the target table was added to the script text - at last :-) -->
				<xsl:if test="Restore/@state='True' and Table">
					<!-- i18n dbengine_string::kTableStrID -->
					<xsl:value-of select="'Table'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:choose>
						<xsl:when test="Table/@id = 1">
							<xsl:value-of select="'{New table}'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="Table/@name"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<xsl:call-template name="ScriptStepParamDataSource"/>
				<!--
				 !
				 ! Import Profile Options
				 !
				 !-->
				<xsl:if test="Restore/@state = 'True' or DataSourceType/@value = 'Folder'">
					<xsl:if test="Profile/@IncludeEnclosedFolders = 'True'">
						<!-- i18n dbengine_string::kBatchProfileIncludeAllFoldersStrID -->
						<xsl:value-of select="'Include all enclosed folders'"/>
						<xsl:call-template name="SIC.delimiter3"/>
					</xsl:if>
					<!-- -->
					<xsl:choose>
						<xsl:when test="Profile/@PictureAndMovieImport = 'True'">
							<!-- i18n dbengine_string::kBatchProfilePictureAndMoveFilesStrID -->
							<xsl:value-of select="'Picture and movie files'"/>
							<xsl:call-template name="SIC.delimiter3"/>
							<!-- -->
						</xsl:when>
						<xsl:when
							test="DataSourceType/@value = 'Folder' and Profile/@PictureAndMovieImport = 'False'">
							<!-- i18n dbengine_string::kBatchProfileTextFilesStrID -->
							<xsl:value-of select="'Text files'"/>
							<xsl:value-of select="$delimiter3"/>
							<!-- -->
						</xsl:when>
					</xsl:choose>
					<xsl:if test="Profile/@ImportByReference = 'True'">
						<!-- i18n dbengine_string::kBatchProfileImportByReferenceStrID -->
						<xsl:value-of select="'Import only a reference'"/>
						<xsl:value-of select="$delimiter3"/>
						<!-- -->
					</xsl:if>
					<!-- Import method (Record) -->
					<xsl:choose>
						<xsl:when test="ImportOptions/@method = 'Add'">
							<!-- i18n dbengine_string::kImportActionAddStrID -->
							<xsl:value-of select="'Add'"/>
							<xsl:call-template name="SIC.delimiter3"/>
							<!-- -->
						</xsl:when>
						<xsl:when test="ImportOptions/@method = 'UpdateOnMatch'">
							<!-- i18n dbengine_string::kImportActionUpdateMatchingStrID -->
							<xsl:value-of select="'Update'"/>
							<xsl:call-template name="SIC.delimiter3"/>
							<!-- -->
						</xsl:when>
						<xsl:when test="ImportOptions/@method = 'Update'">
							<!-- i18n dbengine_string::kImportActionUpdateStrID -->
							<xsl:value-of select="'Replace'"/>
							<xsl:call-template name="SIC.delimiter3"/>
							<!-- -->
						</xsl:when>
					</xsl:choose>
					<!-- Excoding -->
					<xsl:if test="ImportOptions/@CharacterSet">
						<xsl:choose>
							<xsl:when test="ImportOptions/@CharacterSet = 'Windows'">
								<!-- i18n dbengine_string::kCharacterSetIOWindowsStrID -->
								<xsl:value-of select="'Windows ANSI'"/>
							</xsl:when>
							<xsl:when test="ImportOptions/@CharacterSet = 'DOS'">
								<!-- i18n dbengine_string::kCharacterSetIODOSStrID -->
								<xsl:value-of select="'DOS OEM'"/>
							</xsl:when>
							<xsl:when test="ImportOptions/@CharacterSet = 'Macintosh'">
								<!-- i18n dbengine_string::kCharacterSetIOMacStrID -->
								<xsl:value-of select="'Mac Roman'"/>
							</xsl:when>
							<xsl:when test="ImportOptions/@CharacterSet = 'Unicode'">
								<!-- i18n dbengine_string::kCharacterSetIOUTF16StrID -->
								<xsl:value-of select="'Unicode'"/>
							</xsl:when>
							<xsl:when test="ImportOptions/@CharacterSet = 'UnicodeBE'">
								<!-- i18n dbengine_string::kCharacterSetIOUTF16_BEStrID -->
								<xsl:value-of select="'Unicode (big endian)'"/>
							</xsl:when>
							<xsl:when test="ImportOptions/@CharacterSet = 'UTF-8'">
								<!-- i18n dbengine_string::kCharacterSetIOUTF8StrID -->
								<xsl:value-of select="'UTF-8'"/>
							</xsl:when>
							<xsl:when test="ImportOptions/@CharacterSet = 'ShiftJIS'">
								<!-- i18n dbengine_string::kCharacterSetIOShiftJISStrID -->
								<xsl:value-of select="'Shift JIS'"/>
							</xsl:when>
							<xsl:when test="ImportOptions/@CharacterSet = 'ChineseSimplified'">
								<!-- i18n dbengine_string::kCharacterSetIOChineseSimpStrID -->
								<xsl:value-of select="'Simplified Chinese (GB)'"/>
							</xsl:when>
							<xsl:when test="ImportOptions/@CharacterSet = 'ChineseTraditional'">
								<!-- i18n dbengine_string::kCharacterSetIOChineseTradStrID -->
								<xsl:value-of select="'Traditional Chinese (Big-5)'"/>
							</xsl:when>
							<xsl:when test="ImportOptions/@CharacterSet = 'EUC-KR'">
								<!-- i18n dbengine_string::kCharacterSetIOEUC_KRStrID -->
								<xsl:value-of select="'Korean (EUC-KR)'"/>
							</xsl:when>
						</xsl:choose>
						<!--xsl:call-template name="SIC.delimiter3"/-->
						<xsl:value-of select="$delimiter3"/>
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
						<xsl:call-template name="OutputTrueAsOnElseOff">
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
						<!-- i18n dbengine_string::kScriptImportSourceStrID -->
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
						<!-- i18n dbengine_string::kScriptImportTargetStrID -->
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
				<xsl:call-template name="ScriptStepParamVerifySSLCertificates"/>
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
					<!-- i18n dbengine_string::kScriptRestoreStrID -->
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
					<!-- i18n dbengine_string::kScriptRestoreStrID -->
					<xsl:value-of select="'Restore'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="Option/@state = 'True'">
					<!-- i18n dbengine_string::kScriptPDFAppendStrID -->
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
							<!-- i18n dbengine_string::kScriptPDFBrowsedRecords -->
							<xsl:value-of select="'Records being browsed'"/>
							<xsl:value-of select="$delimiter3"/>
							<!-- -->
						</xsl:when>
						<xsl:when test="PDFOptions/@source = 'CurrentRecord'">
							<!-- i18n dbengine_string::kScriptPDFCurrentRecord -->
							<xsl:value-of select="'Current record'"/>
							<xsl:value-of select="$delimiter3"/>
							<!-- -->
						</xsl:when>
						<xsl:when test="PDFOptions/@source = 'BlankRecord'">
							<xsl:value-of select="'Blank record'"/>
							<xsl:value-of select="', '"/>
							<xsl:choose>
								<xsl:when test="PDFOptions/@appearance = 'AsFormatted'">
									<!-- i18n dbengine_string::kScriptPDFBlankAsFormatted -->
									<xsl:value-of select="'as formatted'"/>
								</xsl:when>
								<xsl:when test="PDFOptions/@appearance = 'WithBoxes'">
									<!-- i18n dbengine_string::kScriptPDFBlankWithBoxes -->
									<xsl:value-of select="'with boxes'"/>
								</xsl:when>
								<xsl:when test="PDFOptions/@appearance = 'WithUnderlines'">
									<!-- i18n dbengine_string::kScriptPDFBlankWithUnderlines -->
									<xsl:value-of select="'with underlines'"/>
								</xsl:when>
								<xsl:when test="PDFOptions/@appearance = 'WithPlaceholderText'">
									<!-- i18n dbengine_string::kScriptPDFBlankWithPlaceholderText -->
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
					<xsl:with-param name="calc" select="Calculation"/>
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
				<xsl:if test="Option/@state = 'True'">
					<xsl:value-of select="'Find without indexes'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
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
					<xsl:with-param name="calc" select="Calculation"/>
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
					<!-- i18n dbengine_string::kScriptRestoreStrID -->
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
						<!-- i18n dbengine_string::kScriptValueStrID-->
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
		<xsl:variable name="newWndStylesStyles" select="NewWndStyles/@Styles"/>
		<xsl:variable name="newWndStylesDocument"
			select="($newWndStylesStyles mod (2 * 2)) &gt; ($newWndStylesStyles mod 2)"/>
		<xsl:variable name="newWndStylesDialog"
			select="($newWndStylesStyles mod (2 * 4)) &gt; ($newWndStylesStyles mod 4)"/>
		<xsl:variable name="newWndStylesFloating"
			select="($newWndStylesStyles mod (2 * 256)) &gt; ($newWndStylesStyles mod 256)"/>
		<xsl:variable name="newWndStylesResize"
			select="($newWndStylesStyles mod (2 * 512)) &gt; ($newWndStylesStyles mod 512)"/>
		<xsl:variable name="newWndStylesClose"
			select="($newWndStylesStyles mod (2 * 65536)) &gt; ($newWndStylesStyles mod 65536)"/>
		<xsl:variable name="newWndStylesMinimize"
			select="($newWndStylesStyles mod (2 * 131072)) &gt; ($newWndStylesStyles mod 131072)"/>
		<xsl:variable name="newWndStylesMaximize"
			select="($newWndStylesStyles mod (2 * 262144)) &gt; ($newWndStylesStyles mod 262144)"/>
		<xsl:variable name="newWndStylesZoom"
			select="($newWndStylesStyles mod (2 * 524288)) &gt; ($newWndStylesStyles mod 524288)"/>
		<xsl:variable name="newWndStylesDimParentWindow"
			select="($newWndStylesStyles mod (2 * 1048576)) &gt; ($newWndStylesStyles mod 1048576)"/>
		<!--2147483648-->
		<!--4294967296-->
		<!-- -->
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:value-of select="'Style'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:choose>
					<xsl:when test="not(NewWndStyles) or $newWndStylesDocument">
						<!--Default => Document --> 
						<xsl:value-of select="'Document'"/>
					</xsl:when>
					<xsl:when test="NewWndStyles/@Style='Floating'">
						<!--Rename Floating => Floating Document --> 
						<xsl:value-of select="'Floating Document'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="NewWndStyles/@Style"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
				<xsl:if test="Name/Calculation">

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'Name'"/>
						<xsl:with-param name="calc" select="Name/Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<!-- -->
				<xsl:value-of select="'Using layout'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:call-template name="ScriptStepParamLayoutDestination"/>
				<!-- -->
				<xsl:if test="Height/Calculation">

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'Height'"/>
						<xsl:with-param name="calc" select="Height/Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="Width/Calculation">

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'Width'"/>
						<xsl:with-param name="calc" select="Width/Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="DistanceFromTop/Calculation">

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'Top'"/>
						<xsl:with-param name="calc" select="DistanceFromTop/Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="DistanceFromLeft/Calculation">

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'Left'"/>
						<xsl:with-param name="calc" select="DistanceFromLeft/Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="$pVerbose = 'True'">
					<!-- Verbose -->
					<xsl:if test="not($newWndStylesClose)">
						<xsl:value-of select="'No Close'"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<xsl:if test="not($newWndStylesMinimize)">
						<xsl:value-of select="'No Minimize'"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<xsl:if test="not($newWndStylesMaximize)">
						<xsl:value-of select="'No Maximize'"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<xsl:if test="not($newWndStylesZoom)">
						<xsl:value-of select="'No Zoom'"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<xsl:if test="not($newWndStylesResize)">
						<xsl:value-of select="'No Resize'"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<xsl:if test="not($newWndStylesDimParentWindow)">
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
					<xsl:with-param name="label" select="'Name'"/>
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
					<xsl:with-param name="label" select="'Name'"/>
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
						<!-- i18n dbengine_string::kScriptRestoreStrID -->
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
					<xsl:with-param name="label" select="'Name'"/>
				</xsl:call-template>
				<xsl:if test="Height/Calculation">

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'Height'"/>
						<xsl:with-param name="calc" select="Height/Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<!-- -->
				<xsl:if test="Width/Calculation">

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'Width'"/>
						<xsl:with-param name="calc" select="Width/Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<!-- -->
				<xsl:if test="DistanceFromTop/Calculation">

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'Top'"/>
						<xsl:with-param name="calc" select="DistanceFromTop/Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<!-- -->
				<xsl:if test="DistanceFromLeft/Calculation">

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'Left'"/>
						<xsl:with-param name="calc" select="DistanceFromLeft/Calculation"/>
					</xsl:call-template>
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
					<xsl:with-param name="label" select="'Of Window'"/>
				</xsl:call-template>
				<xsl:if test="NewName/Calculation">

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'New Title'"/>
						<xsl:with-param name="calc" select="NewName/Calculation"/>
					</xsl:call-template>
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
				<xsl:call-template name="OutputTrueAsOnElseOff">
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
				<xsl:call-template name="OutputTrueAsOnElseOff">
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
					<xsl:with-param name="orCurrentFile"/>
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
				<xsl:if test="VerifySSLCertificates/@state = 'True'">
					<xsl:value-of select="'Verify SSL Certificates'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
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
						<!-- i18n dbengine_string::kScriptOnStrID -->
						<xsl:value-of select="'On'"/>
					</xsl:when>
					<xsl:when test="MultiUser/@value = 'OnHidden'">
						<xsl:value-of select="'On (Hidden)'"/>
					</xsl:when>
					<xsl:when test="MultiUser/@value = 'False'">
						<!-- i18n dbengine_string::kScriptOffStrID -->
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
				<xsl:call-template name="OutputTrueAsOnElseOff">
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
					<xsl:with-param name="saveAsType" select="SaveAsType"/>
				</xsl:call-template>
				<xsl:call-template name="ScriptStepParamCreateDirectories"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 96. Save a Copy as Add-on Package
	 !
	 ! Note: This step reuses the old obsolete step 96 Update Link.
	 !       Thus the XML element for the "Replace UUIDs option is
	 !       (confusingly) called LinkAvail !
	 !-->
	 <xsl:template match="//Step[not(ancestor::Step) and @id = '96']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
					<xsl:with-param name="optional_label" select="'Window name'"/>
					<xsl:with-param name="calc" select="Calculation"/>
				</xsl:call-template>

				<xsl:value-of select="'Replace UUIDs'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:call-template name="OutputTrueAsOnElseOff">
					<xsl:with-param name="state" select="LinkAvail/@state"/>
				</xsl:call-template>
				<xsl:value-of select="$delimiter3"/>

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
							<!-- i18n dbengine_string::kScriptRestoreStrID -->
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
						<xsl:variable name="printSettingsPrintType"
							select="PrintSettings/@PrintType"/>
						<xsl:choose>
							<xsl:when test="$printSettingsPrintType = 'BrowsedRecords'">
								<xsl:value-of select="'Records being browsed'"/>
							</xsl:when>
							<xsl:when test="$printSettingsPrintType = 'CurrentRecord'">
								<xsl:value-of select="'Current Record'"/>
							</xsl:when>
							<xsl:when test="$printSettingsPrintType = 'BlankAsFormatted'">
								<xsl:value-of select="'Blank record, as formatted'"/>
							</xsl:when>
							<xsl:when test="$printSettingsPrintType = 'BlankBoxed'">
								<xsl:value-of select="'Blank record, with boxes'"/>
							</xsl:when>
							<xsl:when test="$printSettingsPrintType = 'BlankUnderscore'">
								<xsl:value-of select="'Blank record, with underlines'"/>
							</xsl:when>
							<xsl:when test="$printSettingsPrintType = 'BlankWithPlaceholder'">
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
					<!-- i18n dbengine_string::kScriptRestoreStrID -->
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
	 ! ========
		<Step enable="True" id="134" name="Add Account">
			<ChgPwdOnNextLogin value="True"/>
			<AccountName>
				<Calculation><![CDATA[$Kontoname]]></Calculation>
			</AccountName>
			<Password>
				<Calculation><![CDATA[$Passwort]]></Calculation>
			</Password>
			<PrivilegeSet id="4" name="USER"/>
			<AddAccount>
				<AccountType>FileMaker</AccountType>
			</AddAccount>
		</Step>
	 ! ========
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '134']">
		<xsl:variable name="account_type" select="AddAccount/AccountType"/>
		<xsl:variable name="account_type_name">
			<xsl:choose>
				<xsl:when test="$account_type='ExternalServer'">
					<xsl:value-of select="'External Server'"/>
				</xsl:when>
				<xsl:when test="$account_type='AppleID'">
					<xsl:value-of select="'Apple Account'"/>
				</xsl:when>
				<xsl:when test="$account_type='Azure'">
					<xsl:value-of select="'Microsoft Entra ID'"/>
				</xsl:when>
				<xsl:when test="$account_type='AzureGroup'">
					<xsl:value-of select="'Microsoft Entra ID'"/>
				</xsl:when>
				<xsl:when test="$account_type='CustomOauth'">
					<xsl:value-of select="'Custom OAuth'"/>
				</xsl:when>
				<xsl:when test="$account_type='CustomOauthGroup'">
					<xsl:value-of select="'Custom OAuth'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$account_type"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="account_name_label">
			<xsl:choose>
				<xsl:when test="$account_type='AzureGroup' or $account_type='CustomOauthGroup' or $account_type='ExternalServer'">
					<xsl:value-of select="'Group Name'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'Account Name'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!--  -->
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="$account_type and PrivilegeSet">
					<xsl:value-of select="'Authenticate via'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:value-of select="$account_type_name"/>
					<xsl:value-of select="$delimiter3"/>
					<xsl:choose>
						<xsl:when test="$account_type='ExternalServer'">
							<!-- External Server -->
							<xsl:for-each select="AccountName/Calculation">
								<xsl:choose>
									<xsl:when test="$pSIC='True'">
										<xsl:value-of select="$account_name_label"/>
										<xsl:value-of select="substring($delimiter2,1,string-length($delimiter2)-1)"/>
										<xsl:call-template name="ScriptStepParamCalculation">
											<xsl:with-param name="calc" select="."/>
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
										<xsl:call-template name="ScriptStepParamCalculation">
											<xsl:with-param name="optional_label" select="$account_name_label"/>
											<xsl:with-param name="calc" select="."/>
										</xsl:call-template>										
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise>
							<!-- FileMaker, … -->
							<xsl:for-each select="AccountName/Calculation">
								<xsl:call-template name="ScriptStepParamCalculation">
									<xsl:with-param name="optional_label" select="$account_name_label"/>
									<xsl:with-param name="calc" select="."/>
								</xsl:call-template>
							</xsl:for-each>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<!-- -->
				<xsl:if test="Password">
					<xsl:value-of select="'Password'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="ScriptStepPassword">
						<xsl:with-param name="password" select="Password/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:value-of select="'Privilege Set'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:choose>
					<xsl:when test="string-length(PrivilegeSet/@name)=0">
						<xsl:value-of select="'&lt;unknown&gt;'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="PrivilegeSet/@name"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
				<xsl:if test="$account_type='FileMaker' and ChgPwdOnNextLogin/@value = 'True'">
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

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'Account Name'"/>
						<xsl:with-param name="calc" select="AccountName/Calculation"/>
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

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'Account Name'"/>
						<xsl:with-param name="calc" select="AccountName/Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<!-- -->
				<xsl:if test="Password">
					<xsl:value-of select="'Password'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="ScriptStepPassword">
						<xsl:with-param name="password" select="Password/Calculation"/>
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
						<xsl:with-param name="password" select="OldPassword/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="NewPassword">
					<!-- fm15 Just 'Password', not 'New Password'-->
					<xsl:value-of select="'Password'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="ScriptStepPassword">
						<xsl:with-param name="password" select="NewPassword/Calculation"/>
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

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'Account Name'"/>
						<xsl:with-param name="calc" select="AccountName/Calculation"/>
					</xsl:call-template>
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

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'Account Name'"/>
						<xsl:with-param name="calc" select="AccountName/Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<!-- -->
				<xsl:if test="Password">
					<xsl:value-of select="'Password'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="ScriptStepPassword">
						<xsl:with-param name="password" select="Password/Calculation"/>
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
	 ! Script step 118. Open Hosts (prior to fm17 Open Remote)
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
	 ! Script step 172. Upload to Host (prior to fm18 Upload to FileMaker Server)
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
						<xsl:with-param name="calc" select="Title/Calculation"/>
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
						<xsl:with-param name="calc" select="Message/Calculation"/>
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
							<xsl:with-param name="calc" select="Calculation"/>
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
							<xsl:with-param name="calc" select="Label/Calculation"/>
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
				<xsl:call-template name="OutputTrueAsOnElseOff">
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

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'Object Name'"/>
						<xsl:with-param name="calc" select="ObjectName/Calculation"/>
					</xsl:call-template>
					<!-- -->
				</xsl:if>
				<xsl:call-template name="ScriptStepParamRepetition"/>
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
					<xsl:with-param name="calc" select="Calculation"/>
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
					<xsl:with-param name="calc" select="Calculation"/>
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

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'Object Name'"/>
						<xsl:with-param name="calc" select="ObjectName/Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<!-- -->
				<xsl:choose>
					<xsl:when test="Action/@value = 'Reset'">
						<xsl:value-of select="'Action'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="'Reset'"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:when>
					<xsl:when test="Action/@value = 'Reload'">
						<xsl:value-of select="'Action'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="'Reload'"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:when>
					<xsl:when test="Action/@value = 'GoForward'">
						<xsl:value-of select="'Action'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="'Go Forward'"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:when>
					<xsl:when test="Action/@value = 'GoBack'">
						<xsl:value-of select="'Action'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="'Go Back'"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:when>
					<xsl:when test="Action/@value = 'GoToURL'">

						<xsl:call-template name="ScriptStepParamCalculation">
							<xsl:with-param name="optional_label" select="'URL'"/>
							<xsl:with-param name="calc" select="URL/Calculation"/>
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
				<xsl:if test="Option/@state='True'">
					<xsl:value-of select="'In external browser'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<xsl:call-template name="OutputCalculation">
					<xsl:with-param name="calc" select="Calculation"/>
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
					<xsl:when test="SendViaOAuthAuthentication/@state = 'True'">
						<xsl:value-of select="'Send via OAuth 2.0'"/>
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

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'To'"/>
						<xsl:with-param name="calc" select="To/Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<!-- -->
				<xsl:if test="Cc">

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'CC'"/>
						<xsl:with-param name="calc" select="Cc/Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<!-- -->
				<xsl:if test="Bcc">

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'BCC'"/>
						<xsl:with-param name="calc" select="Bcc/Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<!-- -->
				<xsl:if test="Subject">

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'Subject'"/>
						<xsl:with-param name="calc" select="Subject/Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<!-- -->
				<xsl:if test="Message">

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'Message'"/>
						<xsl:with-param name="calc" select="Message/Calculation"/>
					</xsl:call-template>
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
							<xsl:with-param name="calc" select="Calculation"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="ContentType/@value = 'Text'">
						<!--xsl:value-of select="'Precompiled'"/>
						<xsl:value-of select="$delimiter3"/>
						 !-->
						<xsl:value-of select="$QUOT"/>
						<xsl:call-template name="OutputCalculation">
							<xsl:with-param name="calc" select="Text"/>
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
						<xsl:with-param name="calc" select="Profile/Query"/>
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
				<xsl:with-param name="calc" select="Text"/>
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

						<xsl:call-template name="ScriptStepParamCalculation">
							<xsl:with-param name="optional_label" select="' '"/>
							<xsl:with-param name="calc" select="Source/Calculation"/>
						</xsl:call-template>
						<!-- -->
						<xsl:call-template name="ScriptStepParamRepetition">
							<xsl:with-param name="repetition_calc" select="Repetition/Calculation"/>
						</xsl:call-template>
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
					</xsl:when>
					<xsl:when test="Source/@value = 'URL'">
						<xsl:value-of select="'URL'"/>
						<!-- Bug fm15 -->

						<xsl:call-template name="ScriptStepParamCalculation">
							<xsl:with-param name="optional_label" select="' '"/>
							<xsl:with-param name="calc" select="Source/Calculation"/>
						</xsl:call-template>
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

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'Position'"/>
						<xsl:with-param name="calc" select="PlaybackPosition/Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<!-- -->
				<xsl:if test="StartOffset">

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'Start Offset'"/>
						<xsl:with-param name="calc" select="StartOffset/Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<!-- -->
				<xsl:if test="EndOffset">

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'End Offset'"/>
						<xsl:with-param name="calc" select="EndOffset/Calculation"/>
					</xsl:call-template>
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

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'Position'"/>
						<xsl:with-param name="calc" select="PlaybackPosition/Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<!-- -->
				<xsl:if test="StartOffset">

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'Start Offset'"/>
						<xsl:with-param name="calc" select="StartOffset/Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<!-- -->
				<xsl:if test="EndOffset">

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'End Offset'"/>
						<xsl:with-param name="calc" select="EndOffset/Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<!-- -->
				<xsl:if test="Volume">

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'Volume'"/>
						<xsl:with-param name="calc" select="Volume/Calculation"/>
					</xsl:call-template>
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

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'Object Name'"/>
						<xsl:with-param name="calc" select="ObjectName/Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 181. Get Folder Path (prior to fm18 Get Directory)
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
						<xsl:with-param name="calc" select="Name"/>
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
						<xsl:with-param name="calc" select="DialogTitle/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="DefaultLocation/Calculation/text()">
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="calc" select="DefaultLocation/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 183. Open Favorites (fm17 Open My Apps,prior to fm17 Open Launch Center)
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
				<!-- i18n dbengine_string::kMonitorRegionMonitorStrID -->
				<xsl:value-of select="'Monitor'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:choose>
					<xsl:when test="MonitorType/@value = 'iBeacon'">
						<!-- i18n dbengine_string::kMonitorRegionTypeBeaconStrID -->
						<xsl:value-of select="'iBeacon'"/>
					</xsl:when>
					<xsl:when test="MonitorType/@value = 'GeoLocation'">
						<!-- i18n dbengine_string::kMonitorRegionTypeGeoFenceStrID -->
						<xsl:value-of select="'Geofence'"/>
					</xsl:when>
				</xsl:choose>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
				<xsl:if test="MonitorType/RangeName">

					<xsl:call-template name="ScriptStepParamCalculation">
						<!-- i18n dbengine_string::kMonitorRegionNameStrID -->
						<xsl:with-param name="optional_label" select="'Name'"/>
						<xsl:with-param name="calc" select="MonitorType/RangeName/Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="Script">
					<!-- i18n dbengine_string::kScriptStrID -->
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
							<xsl:value-of select="' '"/>
							<!-- i18n dbengine_string::kScriptFileNotOpenStrID -->
							<xsl:value-of select="'(file not open)'"/>
						</xsl:if>
					</xsl:if>
					<xsl:value-of select="$delimiter3"/>
					<!-- -->
					<xsl:if test="Calculation">

						<xsl:call-template name="ScriptStepParamCalculation">
							<!-- i18n dbengine_string::kScriptParameterStrID -->
							<xsl:with-param name="optional_label" select="'Parameter'"/>
							<xsl:with-param name="calc" select="Calculation"/>
						</xsl:call-template>
					</xsl:if>
					<!-- -->
				</xsl:if>
				<!-- -->
				<xsl:choose>
					<xsl:when test="MonitorType/@value = 'iBeacon'">
						<xsl:if test="MonitorType/ProximityUUID">

							<xsl:call-template name="ScriptStepParamCalculation">
								<!-- i18n dbengine_string::kMonitorRegionUUIDStrID -->
								<xsl:with-param name="optional_label" select="'UUID'"/>
								<xsl:with-param name="calc"
									select="MonitorType/ProximityUUID/Calculation"/>
							</xsl:call-template>
						</xsl:if>
						<!-- -->
						<xsl:if test="MonitorType/MajorID">

							<xsl:call-template name="ScriptStepParamCalculation">
								<!-- i18n dbengine_string::kMonitorRegionMajorStrID -->
								<xsl:with-param name="optional_label" select="'Major'"/>
								<xsl:with-param name="calc" select="MonitorType/MajorID/Calculation"
								/>
							</xsl:call-template>
						</xsl:if>
						<!-- -->
						<xsl:if test="MonitorType/MinorID">

							<xsl:call-template name="ScriptStepParamCalculation">
								<!-- i18n dbengine_string::kMonitorRegionMinorStrID -->
								<xsl:with-param name="optional_label" select="'Minor'"/>
								<xsl:with-param name="calc" select="MonitorType/MinorID/Calculation"
								/>
							</xsl:call-template>
						</xsl:if>
						<!-- -->
					</xsl:when>
					<xsl:when test="MonitorType/@value = 'GeoLocation'">
						<xsl:if test="MonitorType/Latitude">

							<xsl:call-template name="ScriptStepParamCalculation">
								<!-- i18n dbengine_string::kMonitorRegionLatitudeStrID -->
								<xsl:with-param name="optional_label" select="'Latitude'"/>
								<xsl:with-param name="calc"
									select="MonitorType/Latitude/Calculation"/>
							</xsl:call-template>
						</xsl:if>
						<!-- -->
						<xsl:if test="MonitorType/Longitude">

							<xsl:call-template name="ScriptStepParamCalculation">
								<!-- i18n dbengine_string::kMonitorRegionLongitudeStrID -->
								<xsl:with-param name="optional_label" select="'Longitude'"/>
								<xsl:with-param name="calc"
									select="MonitorType/Longitude/Calculation"/>
							</xsl:call-template>
						</xsl:if>
						<!-- -->
						<xsl:if test="MonitorType/Radius">

							<xsl:call-template name="ScriptStepParamCalculation">
								<!-- i18n dbengine_string::kMonitorRegionRadiusStrID -->
								<xsl:with-param name="optional_label" select="'Radius'"/>
								<xsl:with-param name="calc" select="MonitorType/Radius/Calculation"
								/>
							</xsl:call-template>
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
					<xsl:variable name="calc"
						select="../../ParameterValues/Object[@index = $ID]/Calculation"/>
					<!-- -->
					<xsl:value-of select="@Label"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="calc" select="$calc"/>
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
	 ! 		<ShowWhenAppInForeground>
	 ! 			<Calculation><![CDATA[True]]></Calculation>
	 ! 		</ShowWhenAppInForeground>
	 ! 	</Action>
	 ! </Step>
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '187']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<!-- -->
				<!-- i18n dbengine_string::kLocalNotificationActionStrID -->
					<xsl:value-of select="'Action'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:choose>
					<xsl:when test="Action/@value='Clear'">
						<!-- i18n dbengine_string::kLocalNotificationActionClearStrID -->
						<xsl:value-of select="'Clear'"/>
					</xsl:when>
					<xsl:when test="Action/@value='Queue'">
						<!-- i18n dbengine_string::kLocalNotificationActionQueueStrID -->
						<xsl:value-of select="'Queue'"/>
					</xsl:when>
				</xsl:choose>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
				<xsl:if test="Action/Name">
					<!-- i18n dbengine_string::kLocalNotificationNameStrID -->
					<xsl:value-of select="'Name'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:value-of select="Action/Name/Calculation"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:if test="Action/@value = 'Queue'">
					<!-- -->
					<xsl:if test="Script/@name">
						<!-- i18n dbengine_string::kScriptStrID -->
						<xsl:value-of select="'Script'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:call-template name="QuotedStringOrUnknown">
							<xsl:with-param name="string" select="Script/@name"/>
						</xsl:call-template>
						<xsl:value-of select="$delimiter3"/>
						<!-- -->
						<xsl:if test="Calculation">
							<!-- i18n dbengine_string::kScriptParameterStrID -->
							<xsl:value-of select="'Parameter'"/>
							<xsl:value-of select="$delimiter2"/>
							<xsl:value-of select="Calculation"/>
							<xsl:value-of select="$delimiter3"/>
						</xsl:if>
					</xsl:if>
					<!-- -->
					<xsl:if test="Action/Delay">
						<!-- i18n dbengine_string::kLocalNotificationDelayStrID -->
						<xsl:value-of select="'Delay'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="Action/Delay/Calculation"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<!-- -->
					<xsl:if test="Action/Title">
						<!-- i18n dbengine_string::kLocalNotificationTitleStrID -->
						<xsl:value-of select="'Title'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="Action/Title/Calculation"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<!-- -->
					<xsl:if test="Action/Body">
						<!-- i18n dbengine_string::kLocalNotificationBodyStrID -->
						<xsl:value-of select="'Body'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="Action/Body/Calculation"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<!-- -->
					<xsl:if test="Action/Button1Label">
						<!-- i18n dbengine_string::kLocalNotificationButton0LabelStrID -->
						<xsl:value-of select="'Button 1 Label'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="Action/Button1Label/Calculation"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<!-- -->
					<!-- i18n dbengine_string::kLocalNotificationButton1LabelStrID -->
					<xsl:if test="Action/Button2Label">
						<xsl:value-of select="'Button 2 Label'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="Action/Button2Label/Calculation"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<!-- -->
					<!-- i18n dbengine_string::kLocalNotificationButton2LabelStrID -->
					<xsl:if test="Action/Button3Label">
						<xsl:value-of select="'Button 3 Label'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="Action/Button3Label/Calculation"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<!-- -->
					<xsl:if test="Action/Button1ForceFgnd">
						<!-- i18n dbengine_string::kLocalNotificationButton0ForegroundStrID -->
						<xsl:value-of select="'Button 1 Foreground'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="Action/Button1ForceFgnd/Calculation"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<!-- -->
					<!-- i18n dbengine_string::kLocalNotificationButton1ForegroundStrID -->
					<xsl:if test="Action/Button2ForceFgnd">
						<xsl:value-of select="'Button 2 Foreground'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="Action/Button2ForceFgnd/Calculation"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<!-- -->
					<!-- i18n dbengine_string::kLocalNotificationButton2ForegroundStrID -->
					<xsl:if test="Action/Button3ForceFgnd">
						<xsl:value-of select="'Button 3 Foreground'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="Action/Button3ForceFgnd/Calculation"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:if>
					<xsl:if test="Action/ShowWhenAppInForeground">
						<!-- i18n FIXME fm22 -->
						<xsl:value-of select="'Show when app in foreground'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:value-of select="Action/ShowWhenAppInForeground/Calculation"/>
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
					<xsl:call-template name="ScriptStepParamTarget"/>
				</xsl:if>
				<!-- Parameters (FIXME ONLY CALCS) -->
				<xsl:for-each
					select="PluginStep/Parameter[@Type = 'calc' and @ShowInline = 'true' and @ID]">
					<xsl:variable name="ID" select="@ID"/>
					<!-- -->
					<xsl:variable name="calc"
						select="../../ParameterValues/Object[@index = $ID]/Calculation"/>
					<!-- -->
					<xsl:value-of select="@Label"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="calc" select="$calc"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:for-each>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
     ! Script step 188. Get File Exists (FM18)
      !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '188']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamSpecifyFile"/>
				<!-- -->
				<!-- i18n dbengine_string::kScriptImportTargetStrID -->
				<xsl:value-of select="'Target'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:value-of select="Field/text()"/>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
     ! Script step 189. Get File Size (FM18)
      !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '189']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamSpecifyFile"/>
				<!-- -->
				<!-- i18n dbengine_string::kScriptImportTargetStrID -->
				<xsl:value-of select="'Target'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:value-of select="Field/text()"/>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
     ! Script step 190. Create Data File (FM18)
      !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '190']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="UniversalPathListFileName"/>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
				<xsl:call-template name="ScriptStepParamCreateDirectories"/>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
     ! Script step 191. Open Data File (FM18)
      !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '191']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamSpecifyFile"/>
				<!-- -->
				<!-- i18n dbengine_string::kScriptImportTargetStrID -->
				<xsl:value-of select="'Target'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:call-template name="ScriptStepParamField"/>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
     ! Script step 192. Write to Data File (FM18)
	 ! ========
	 ! ========
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '192']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="Calculation">

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'File ID'"/>
						<xsl:with-param name="calc" select="Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<!-- -->
				<xsl:value-of select="'Data source'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:call-template name="ScriptStepParamField"/>
				<xsl:if test="not(Field)">
					<!-- FIXME ':  ; ' is one space too many -->
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:value-of select="'Write as'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:choose>
					<xsl:when test="DataSourceType/@value = 1">
						<xsl:value-of select="'UTF-16'"/>
					</xsl:when>
					<xsl:when test="DataSourceType/@value = 2">
						<xsl:value-of select="'UTF-8'"/>
					</xsl:when>
				</xsl:choose>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
				<xsl:if test="AppendLineFeed/@state = 'True'">
					<xsl:value-of select="'Append line feed'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
     ! Script step 193. Read from Data File (FM18)
      !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '193']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="Calculation">

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'File ID'"/>
						<xsl:with-param name="calc" select="Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<!-- -->
				<xsl:if test="Count/Calculation">
					<xsl:choose>
						<xsl:when test="DataSourceType/@value = 1">
							<xsl:value-of select="'Amount'"/>
						</xsl:when>
						<xsl:when test="DataSourceType/@value = 2">
							<xsl:value-of select="'Amount (bytes)'"/>
						</xsl:when>
						<xsl:when test="DataSourceType/@value = 3">
							<xsl:value-of select="'Amount (bytes)'"/>
						</xsl:when>
					</xsl:choose>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="calc" select="Count/Calculation"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<!-- i18n dbengine_string::kScriptImportTargetStrID -->
				<xsl:value-of select="'Target'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:call-template name="ScriptStepParamField"/>
				<xsl:if test="not(Field)">
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
				<xsl:value-of select="'Read as'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:choose>
					<xsl:when test="DataSourceType/@value = 1">
						<xsl:value-of select="'UTF-16'"/>
					</xsl:when>
					<xsl:when test="DataSourceType/@value = 2">
						<xsl:value-of select="'UTF-8'"/>
					</xsl:when>
					<xsl:when test="DataSourceType/@value = 3">
						<xsl:value-of select="'Bytes'"/>
					</xsl:when>
				</xsl:choose>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
     ! Script step 194. Get Data File Position (FM18)
      !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '194']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="Calculation">

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'File ID'"/>
						<xsl:with-param name="calc" select="Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<!-- -->
				<!-- i18n dbengine_string::kScriptImportTargetStrID -->
				<xsl:value-of select="'Target'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:call-template name="ScriptStepParamField"/>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
     ! Script step 195. Set Data File Position (FM18)
      !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '195']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="Calculation or position/Calculation">

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'File ID'"/>
						<xsl:with-param name="calc" select="Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<!--  -->
				<xsl:if test="position/Calculation">
					<!-- SADLY FMI named the Element position with a LOWERCASE first letter :-/ -->

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'New position'"/>
						<xsl:with-param name="calc" select="position/Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
     ! Script step 196. Close Data File (FM18)
      !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '196']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">

				<xsl:value-of select="'File ID'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:call-template name="ScriptStepParamCalculation">
					<xsl:with-param name="calc" select="Calculation"/>
				</xsl:call-template>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
     ! Script step 197. Delete File (FM18)
      !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '197']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:value-of select="'Target file'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:call-template name="ScriptStepParamSpecifyFile"/>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
     ! Script step 199. Rename File (FM18)
      !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '199']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:value-of select="'Source file'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:call-template name="UniversalPathListFileName"/>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
				<xsl:if test="Calculation">

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'New name'"/>
						<xsl:with-param name="calc" select="Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
     ! Script step 200. Set Error Logging (FM18)
     !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '200']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="OutputTrueAsOnElseOff">
					<xsl:with-param name="state" select="Option/@state"/>
				</xsl:call-template>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
				<xsl:if test="Calculation">

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'Custom debug info'"/>
						<xsl:with-param name="calc" select="Calculation"/>
					</xsl:call-template>
				</xsl:if>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>

	<!--
	 ! Script step 201. Configure NFC Reading

	 ! <Step enable="True" id="201" name="Configure NFC Reading">
! 
! 	<FileReference id="2" name="Self">
! 		<UniversalPathList>file:fmSyntaxColorizer</UniversalPathList>
! 	</FileReference>
! 
! 	<Calculation><![CDATA[$Param]]></Calculation>
! 
! 	<Script id="201" name="Hello::World"/>
! 
! 	<Action value="Read">
! 		<Timeout>
! 			<Calculation><![CDATA[$Timeout]]></Calculation>
! 		</Timeout>
! 		<ReadMultiple>
! 			<Calculation><![CDATA[$Continuous]]></Calculation>
! 		</ReadMultiple>
! 	</Action>
! 
! </Step>
! 
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '201']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<!-- i18n dbengine_string::kConfigureNFCActionStrID -->
				<xsl:value-of select="'Action'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:choose>
					<xsl:when test="Action/@value='Cancel'">
						<!-- i18n dbengine_string::kConfigureNFCActionCancelStrID -->
						<xsl:value-of select="'Cancel'"/>						
					</xsl:when>
					<xsl:when test="Action/@value='Read'">
						<!-- i18n dbengine_string::kConfigureNFCActionReadStrID -->
						<xsl:value-of select="'Read'"/>						
					</xsl:when>
				</xsl:choose>
				<xsl:value-of select="$delimiter3"/>

				<xsl:if test="Script">
					<!-- i18n dbengine_string::kScriptStrID -->
					<xsl:value-of select="'Script'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="QuotedStringOrUnknown">
						<xsl:with-param name="string" select="Script/@name"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
					<!-- -->
					<xsl:if test="Calculation">
						<xsl:call-template name="ScriptStepParamCalculation">
							<!-- i18n dbengine_string::kScriptParameterStrID -->
							<xsl:with-param name="optional_label" select="'Parameter'"/>
						</xsl:call-template>
					</xsl:if>
					<!-- -->
				</xsl:if>

				<xsl:for-each select="Action/Timeout">
					<xsl:call-template name="ScriptStepParamCalculation">
						<!-- i18n dbengine_string::kConfigureNFCTimeoutStrID -->
						<xsl:with-param name="optional_label" select="'Timeout'"/>
					</xsl:call-template>
				</xsl:for-each>

				<xsl:for-each select="Action/ReadMultiple">
					<xsl:call-template name="ScriptStepParamCalculation">
						<!-- i18n dbengine_string::kConfigureNFCMultipleStrID -->
						<xsl:with-param name="optional_label" select="'Continuous Reading'"/>
					</xsl:call-template>
				</xsl:for-each>

				<xsl:for-each select="Action/JSONOutput">
					<xsl:call-template name="ScriptStepParamCalculation">
						<!-- i18n dbengine_string::kConfigureJSONOutputStrID -->
						<xsl:with-param name="optional_label" select="'Format Result as JSON'"/>
					</xsl:call-template>
				</xsl:for-each>

				
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 202. Configure Machine Learning Model 
	 ! ========
	 ! Configure Machine Learning Model [ Operation: General ; Name: "MyGeneral" ; From: TestTable::TextField1[2] ]
	 ! ========
	  <Step enable="True" id="202" name="Configure Machine Learning Model">
	    <Field table="TestTable" id="6" repetition="2" name="TextField1"/>
	    <ConfigureCoreML>General<Name><Calculation><![CDATA["MyGeneral"]]></Calculation></Name></ConfigureCoreML>
	    <Field table="TestTable" id="6" repetition="2" name="TextField1"/>
	  </Step>
	 ! ========
	 ! Configure Machine Learning Model [ Operation: Vision ; Name: "MyVision" ; From: TestTable::TextField1[2] ]
	 ! ========
  <Step enable="True" id="202" name="Configure Machine Learning Model">
    <Field table="TestTable" id="6" repetition="2" name="TextField1"/>
    <ConfigureCoreML>Vision<Name><Calculation><![CDATA["MyVision"]]></Calculation></Name></ConfigureCoreML>
    <Field table="TestTable" id="6" repetition="2" name="TextField1"/>
  </Step>
	 ! ========
	 !  Configure Machine Learning Model [ Operation: Unload ; Name: "MyModel" ]
	 ! ========
	  <Step enable="True" id="202" name="Configure Machine Learning Model">
	    <Field table="TestTable" id="6" repetition="2" name="TextField1"/>
	    <ConfigureCoreML>Vision<Name><Calculation><![CDATA["MyVision"]]></Calculation></Name></ConfigureCoreML>
	    <Field table="TestTable" id="6" repetition="2" name="TextField1"/>
	  </Step>
	 ! ========
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '202']">
		<xsl:variable name="operation" select="(ConfigureCoreML/text())[1]"/>
		<!--  -->
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				
				<xsl:value-of select="'Operation'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:choose>
					<xsl:when test="$operation = 'Uninstall'">
						<xsl:value-of select="'Unload'"/>
						<xsl:value-of select="$delimiter3"/>

						<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
							<xsl:with-param name="optional_label" select="'Name'"/>
							<xsl:with-param name="calc" select="ConfigureCoreML/Name/Calculation"/>
						</xsl:call-template>
						
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="$operation = 'General'">
								<xsl:value-of select="'General'"/>
							</xsl:when>
							<xsl:when test="$operation = 'Vision'">
								<xsl:value-of select="'Vision'"/>
							</xsl:when>
							<xsl:otherwise>
								<!-- Unknown Operation -->
								<xsl:value-of select="$operation"/>
							</xsl:otherwise>
						</xsl:choose>				
						<xsl:value-of select="$delimiter3"/>

						<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
							<xsl:with-param name="optional_label" select="'Name'"/>
							<xsl:with-param name="calc" select="ConfigureCoreML/Name/Calculation"/>
						</xsl:call-template>

						<!-- Note: The From label is always output, the function makes the label dependent on the Field --> 
						<xsl:value-of select="'From'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:call-template name="ScriptStepParamField">
							<xsl:with-param name="label" select="''"/>
							<xsl:with-param name="field" select="Field"/>
						</xsl:call-template>
						
					</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 203. Execute FileMaker Data API
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '203']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="ScriptStepParamSelect"/>

				<xsl:if test="Field">
					<xsl:call-template name="ScriptStepParamTarget"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>

				<xsl:if test="Calculation">
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="calc" select="Calculation"/>
					</xsl:call-template>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>


		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 175. Perform JavaScript in Web Viewer
	 ! ========

		<Step enable="True" id="175" name="Perform JavaScript in Web Viewer">
			<ObjectName>
				<Calculation><![CDATA["abc"]]></Calculation>
			</ObjectName>
			<FunctionName>
				<Calculation><![CDATA["def"]]></Calculation>
			</FunctionName>
			<Parameters Count="2">
				<P>
					<Calculation><![CDATA[$p1]]></Calculation>
				</P>
				<P>
					<Calculation><![CDATA[$p2]]></Calculation>
				</P>
			</Parameters>
		</Step>
	 ! ========
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '175']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">

			<xsl:value-of select="'Object Name'"/>
			<xsl:value-of select="$delimiter2"/>
				<xsl:choose>
					<xsl:when test="ObjectName/Calculation">
						<xsl:call-template name="OutputCalculationOrDefault">
							<xsl:with-param name="calc" select="ObjectName/Calculation"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'&lt;Active Object&gt;'"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="$delimiter3"/>

				<xsl:if test="FunctionName/Calculation">

					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'Function Name'"/>
						<xsl:with-param name="calc" select="FunctionName/Calculation"/>
					</xsl:call-template>
				</xsl:if>

				<xsl:variable name="parCnt" select="number(Parameters/@Count)"/>
				<xsl:if test="$parCnt&gt;0">
					<xsl:value-of select="'Parameters'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:for-each select="Parameters/P">
						<xsl:if test="position() &gt; 1">
							<xsl:value-of select="', '"/>
						</xsl:if>
						<xsl:call-template name="OutputCalculation">
							<xsl:with-param name="calc" select="Calculation"/>
						</xsl:call-template>
					</xsl:for-each>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 205. Open Transaction
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '205']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="SkipAutoEntry/@state='True'">
					<!-- i18n dbengine_string::kScriptOptionSkipAutoEntryStrID -->
					<xsl:value-of select="'Skip auto-enter options'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<xsl:if test="Option/@state='True'">
					<!-- i18n dbengine_string::kScriptSkipDataEntryStrID -->
					<xsl:value-of select="'Skip data entry validation'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<xsl:if test="ESSForceCommit/@state='True'">
					<!-- i18n dbengine_string::kESSLockOverrideStrID-->
					<xsl:value-of select="'Override ESS locking conflicts'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	! Script step 206. Commit Transaction
	!-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '206']">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	! Script step 207. Revert Transaction
	!-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '207']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
			<xsl:if test="Condition/Calculation">

				<xsl:call-template name="ScriptStepParamCalculation">
					<!-- i18n dbengine_string::kConditionalFormattingConditionID -->
					<xsl:with-param name="optional_label" select="'Condition'"/>
					<xsl:with-param name="calc" select="Condition/Calculation"/>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="ErrorCode/Calculation">

				<xsl:call-template name="ScriptStepParamCalculation">
					<!-- i18n dbengine_string::kScriptTransactionErrorCodeStrID -->
					<xsl:with-param name="optional_label" select="'Error Code'"/>
					<xsl:with-param name="calc" select="ErrorCode/Calculation"/>
				</xsl:call-template>

				<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
					<!-- i18n dbengine_string::kScriptTransactionErrorMessageStrID -->
					<xsl:with-param name="optional_label" select="'Error Message'"/>
					<xsl:with-param name="calc" select="ErrorMessage/Calculation"/>
				</xsl:call-template>
			</xsl:if>

				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	! Script step 208. Set Session Identifier
	!-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '208']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="OutputCalculation">
					<xsl:with-param name="calc" select="Calculation"/>
				</xsl:call-template>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	! Script step 209. Set Dictionary
	!-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '209']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:if test="MainDictionary/@value">
					<xsl:value-of select="'Spelling Language'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:value-of select="MainDictionary/@value"/>
				</xsl:if>
				<xsl:value-of select="$delimiter3"/>
				<xsl:if test="UniversalPathList">
					<xsl:value-of select="'User Dictionary'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="UniversalPathListFileName"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				<!-- -->
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
		</xsl:template>
		<!--
		! Script step 210. Perform Script on Server with Callback
		!-->
		<xsl:template match="//Step[not(ancestor::Step) and @id = '210']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
		<xsl:with-param name="pParameterList">
			<xsl:call-template name="ScriptStepParamCallbackScriptSpecified"/>
		</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	! Script step 211. Trigger Claris Connect Flow
	!-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '211']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<!-- i18n dbengine_string::kTriggerConnectWorkflowLabelStrID -->
				<xsl:value-of select="'Flow'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:choose>
					<xsl:when test="Flow/text()!=''">
						<xsl:value-of select="Flow/text()"/>
					</xsl:when>
					<xsl:otherwise>
						<!-- i18n dbengine_string::kUnknownScriptStrID -->
						<xsl:value-of select="'&lt;unknown&gt;'"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="$delimiter3"/>

				<xsl:call-template name="ScriptStepParamCalculation">
					<!-- i18n dbengine_string::kTriggerConnectJSONDataLabelStrID -->
					<xsl:with-param name="optional_label" select="'JSON Data'"/>
					<xsl:with-param name="calc" select="JSONData/Calculation"/>
				</xsl:call-template>

				<xsl:call-template name="ScriptStepParamField">
					<!-- i18n dbengine_string::kScriptImportTargetStrID -->
					<xsl:with-param name="label" select="'Target'"/>
					<xsl:with-param name="field" select="Field"/>
				</xsl:call-template>

				</xsl:with-param>
			</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
<!-- FM20 -->
<!-- FM21 -->
	<!--
	 ! Script step 212. Configure AI Account
	 ! Configure AI Account [ Account Name:    ; Model Provider: OpenAI ; API key:    ]
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '212']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">

				<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
					<xsl:with-param name="optional_label" select="'Account Name'"/>
					<!-- SIC - FIXME should Claris correct the spelling of Account --> 
					<xsl:with-param name="calc" select="SetLLMAccout/AccoutName/Calculation"/>
				</xsl:call-template>

				<xsl:value-of select="'Model Provider'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:choose>
					<xsl:when test="LLMType/@value='Other'">
						<xsl:value-of select="'Custom'"/>
						<xsl:value-of select="$delimiter3"/>

						<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
							<xsl:with-param name="optional_label" select="'Endpoint'"/>
							<!-- SIC - FIXME should Claris correct the spelling of Account --> 
							<xsl:with-param name="calc" select="SetLLMAccout/Endpoint/Calculation"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="LLMType/@value='ChatGPT'">
						<xsl:value-of select="'OpenAI'"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:when>
					<xsl:otherwise>
						<!-- output Model Provider unchanged -->  
						<xsl:value-of select="LLMType/@value"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:otherwise>
				</xsl:choose>

				<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
					<xsl:with-param name="optional_label" select="'API key'"/>
					<!-- SIC - FIXME should Claris correct the spelling of Account --> 
					<xsl:with-param name="calc" select="SetLLMAccout/AccessAPIKey/Calculation"/>
				</xsl:call-template>

			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!-- FM21 -->
	<!--
	 ! Script step 213. Fine-Tune Model 
	 ! ========
	 ! Fine-Tune Model [ Account Name: $Name ; Base Model: $BaseModel ; Training Data: File ; “$TrainingDataFilePath” ; Response Target: _Home::_gEmptyField ; Parameters: JSONSetElement ( "{}" ;["what_params" ; "don't know" ; JSONString] ) ]
	 ! ========
		<Step enable="True" id="213" name="Fine-Tune Model">
			<Option state="False"/>
			<UniversalPathList type="Reference">$TrainingDataFilePath</UniversalPathList>
			<Field table="_Home" id="9" name="_gEmptyField"/>
			<FineTuneLLM>
				<AccountName>
					<Calculation><![CDATA[$Name]]></Calculation>
				</AccountName>
				<FineTuneBaseModelName>
					<Calculation><![CDATA[$BaseModel]]></Calculation>
				</FineTuneBaseModelName>
				<Parameters>
					<Calculation><![CDATA[JSONSetElement ( "{}" ;["what_params" ; "don't know" ; JSONString])]]></Calculation>
				</Parameters>
				<DataSource>TrainingFile</DataSource>
			</FineTuneLLM>
		</Step>
	 ! ========
	 ! Fine-Tune Model [ Account Name: $Name ; Base Model: $BaseModel ; Training Data: Table ; “_Syntax” ; Completion Field: _Syntax::Collection ; Response Target: $ResponseTarget[$Rep] ; Parameters: $Param ]
	 ! ========
		<Step enable="True" id="213" name="Fine-Tune Model">
			<Option state="True"/>
			<UniversalPathList type="Embedded"/>
			<Text/>
			<Table id="1065113" name="_Syntax"/>
			<Field repetition="0">$ResponseTarget</Field>
			<Repetition>
				<Calculation><![CDATA[$Rep]]></Calculation>
			</Repetition>
			<FineTuneLLM>
				<AccountName>
					<Calculation><![CDATA[$Name]]></Calculation>
				</AccountName>
				<FineTuneBaseModelName>
					<Calculation><![CDATA[$BaseModel]]></Calculation>
				</FineTuneBaseModelName>
				<Parameters>
					<Calculation><![CDATA[$Param]]></Calculation>
				</Parameters>
				<DataSource>DataTable</DataSource>
				<Field table="_Syntax" id="41" name="Collection"/>
				<Repetition>
					<Calculation><![CDATA[$Rep]]></Calculation>
				</Repetition>
			</FineTuneLLM>
		</Step>
	 ! ========
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '213']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">

				<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
					<xsl:with-param name="optional_label" select="'Account Name'"/>
					<xsl:with-param name="calc" select="FineTuneLLM/AccountName/Calculation"/>
				</xsl:call-template>

				<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
					<xsl:with-param name="optional_label" select="'Base Model'"/>
					<xsl:with-param name="calc" select="FineTuneLLM/FineTuneBaseModelName"/>
				</xsl:call-template>
				
				<xsl:value-of select="'Training Data'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:choose>
					<xsl:when test="FineTuneLLM/DataSource='DataTable'">
						<xsl:value-of select="'Table'"/>
						<xsl:value-of select="$delimiter3"/>
						
						<!-- optional: Table: if empty an empty parameter is output --> 
						<xsl:call-template name="QuotedStringOrDefault">
							<xsl:with-param name="string" select="Table/@name"/>
							<xsl:with-param name="default" select="''"/>
						</xsl:call-template>
						<xsl:value-of select="$delimiter3"/>
						
						<xsl:call-template name="ScriptStepParamTarget">
							<xsl:with-param name="label" select="'Completion Field'"/>
							<xsl:with-param name="field" select="FineTuneLLM/Field"/>
						</xsl:call-template>
						
					</xsl:when>
					<xsl:otherwise>						
						<xsl:value-of select="'File'"/>
						<xsl:value-of select="$delimiter3"/>
						
						<xsl:if test="UniversalPathList!=''">
							<xsl:call-template name="UniversalPathListFileName"/>
							<xsl:value-of select="$delimiter3"/>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
				
				<xsl:if test="Field">
					<xsl:value-of select="'Response Target'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="ScriptStepParamField">
						<xsl:with-param name="field" select="Field"/>
					</xsl:call-template>

				</xsl:if>
				
				<xsl:for-each select="FineTuneLLM">
				
						<xsl:if test="Parameters/Calculation">

							<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
								<xsl:with-param name="optional_label" select="'Parameters'"/>
								<xsl:with-param name="calc" select="Parameters/Calculation"/>
								<xsl:with-param name="default" select="''"/>
							</xsl:call-template>
						</xsl:if>
					</xsl:for-each>
				
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	
	
	<!--
	 ! Script step 214. Perform SQL Query by Natural Language
	 ! ========
	 !	Perform SQL Query by Natural Language [ Account Name: … ; Model: … ; Prompt: … ; Options specified: From list ; Action: Query ; Data Tables: From list ; Tables... ; Stream ; Prompt Template Name: … ; Parameters: … ; Response Target: Table::Field ; Web Viewer: "…" ; Function Name: "…" ]
	 ! ========
		<Step enable="True" id="214" name="Perform SQL Query by Natural Language">
			<Option state="True"/>
			<Stream state="True"/>
			<UniversalPathList type="Embedded"/>
			<Field table="TestTable" id="6" name="TextField1"/>
			<PerformSQLQuerybyNaturalLanguage>
				<AccountName>
					<Calculation><![CDATA[$AccountName]]></Calculation>
				</AccountName>
				<Model>
					<Calculation><![CDATA[$Model]]></Calculation>
				</Model>
				<Parameters>
					<Calculation><![CDATA[$Parameters]]></Calculation>
				</Parameters>
				<TemplateName>
					<Calculation><![CDATA[$PromptTemplateName]]></Calculation>
				</TemplateName>
				<PromptMessage>
					<Calculation><![CDATA[$Prompt]]></Calculation>
				</PromptMessage>
				<OptionsSelectionType>By List</OptionsSelectionType>
				<Action>Query</Action>
				<TablesSelectionType>By List</TablesSelectionType>
				<TableAliases>
					<Table id="1065169" name="Contacts"/>
					<Table id="1065171" name="Contacts_TestTable"/>
					<Table id="1065168" name="TestTable"/>
					<Table id="1065170" name="TestTable_Contacts"/>
				</TableAliases>
				<WebScript>
					<ObjectName>
						<Calculation><![CDATA["WebViewer"]]></Calculation>
					</ObjectName>
					<FunctionName>
						<Calculation><![CDATA["JavascriptFunction"]]></Calculation>
					</FunctionName>
					<WebScriptParameters Count="2">
						<P>
							<Calculation><![CDATA["p1"]]></Calculation>
						</P>
						<P>
							<Calculation><![CDATA["p2"]]></Calculation>
						</P>
					</WebScriptParameters>
				</WebScript>
			</PerformSQLQuerybyNaturalLanguage>
		</Step>
	 ! ========
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '214']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:for-each select="PerformSQLQuerybyNaturalLanguage">
					
					<!-- Account Name -->

					<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
						<xsl:with-param name="optional_label" select="'Account Name'"/>
						<xsl:with-param name="calc" select="AccountName/Calculation"/>
					</xsl:call-template>
					
					<!-- Model -->

					<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
						<xsl:with-param name="optional_label" select="'Model'"/>
						<xsl:with-param name="calc" select="Model/Calculation"/>
					</xsl:call-template>
					
					<!-- Prompt -->

					<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
						<xsl:with-param name="optional_label" select="'Prompt'"/>
						<xsl:with-param name="calc" select="PromptMessage/Calculation"/>
					</xsl:call-template>
					
					<!-- Options specified -->
					<xsl:value-of select="'Options specified'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:choose>
						<xsl:when test="OptionsSelectionType='By JSON data'">
							<xsl:value-of select="'By JSON data'"/>
							<xsl:value-of select="$delimiter3"/>
							<xsl:call-template name="OutputCalculationOrTwoSpaces">
								<xsl:with-param name="calc" select="OptionsName/Calculation"/>
							</xsl:call-template>
							<xsl:value-of select="$delimiter3"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="OptionsSelectionType='By List'">
									<xsl:value-of select="'From list'"/>
								</xsl:when>
								<xsl:when test="OptionsSelectionType='By Name'">
									<xsl:value-of select="'By name'"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="OptionsSelectionType"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:value-of select="$delimiter3"/>
							<!-- Action -->
							<xsl:value-of select="'Action'"/>
							<xsl:value-of select="$delimiter2"/>
							<xsl:choose>
								<xsl:when test="Action='Query'">
									<xsl:value-of select="'Query'"/>
								</xsl:when>
								<xsl:when test="Action='Query for Data Only'">
									<xsl:value-of select="'Query for Data Only'"/>
								</xsl:when>
								<xsl:when test="Action='Get SQL'">
									<xsl:value-of select="'Get SQL'"/>
								</xsl:when>
								<xsl:when test="Action='Get First SQL Only'">
									<xsl:value-of select="'Get First SQL Only'"/>
								</xsl:when>
								<xsl:when test="Action='Get DDL'">
									<xsl:value-of select="'Get DDL'"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="Action"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:value-of select="$delimiter3"/>
							
							<!-- Data Tables -->
							<xsl:value-of select="'Data Tables'"/>
							<xsl:value-of select="$delimiter2"/>
							<xsl:choose>
								<xsl:when test="TablesSelectionType='By List'">
									<xsl:value-of select="'From list'"/>
									<xsl:value-of select="$delimiter3"/>
									<xsl:value-of select="'Tables...'"/>
								</xsl:when>
								<xsl:when test="TablesSelectionType='By Name'">
									<xsl:value-of select="'By name'"/>
									<xsl:value-of select="$delimiter3"/>
									<xsl:call-template name="OutputCalculationOrTwoSpaces">
										<xsl:with-param name="calc" select="TablesName/Calculation"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:when test="TablesSelectionType='By Customized DDL'">
									<xsl:value-of select="'By DDL'"/>
									<xsl:value-of select="$delimiter3"/>
									<xsl:call-template name="OutputCalculationOrTwoSpaces">
										<xsl:with-param name="calc" select="ByDDL/Calculation"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="TablesSelectionType"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:value-of select="$delimiter3"/>
							
							<!-- Stream -->
							<xsl:if test="../Stream/@state='True'">
								<xsl:value-of select="'Stream'"/>
								<xsl:value-of select="$delimiter3"/>
							</xsl:if>
							
							<!-- Prompt Template Name -->
							<xsl:if test="TemplateName/Calculation">

								<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
									<xsl:with-param name="optional_label" select="'Prompt Template Name'"/>
									<xsl:with-param name="calc" select="TemplateName/Calculation"/>
								</xsl:call-template>
							</xsl:if>
							
							<!-- Parameters -->
							<xsl:if test="Parameters/Calculation">

								<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
									<xsl:with-param name="optional_label" select="'Parameters'"/>
									<xsl:with-param name="calc" select="Parameters/Calculation"/>
								</xsl:call-template>
							</xsl:if>
							
							<!-- Response Target (field or variable) -->
							<xsl:variable name="vField" select="../Field"/>
							<xsl:if test="$vField">
								<xsl:value-of select="'Response Target'"/>
								<xsl:value-of select="$delimiter2"/>
								<xsl:choose>
									<xsl:when test="$vField/@table and $vField/@name">
										<xsl:value-of select="concat($vField/@table,'::',$vField/@name)"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="normalize-space($vField)"/>
										<xsl:if test="../Repetition/Calculation">
											<xsl:text>[</xsl:text>
											<xsl:value-of select="../Repetition/Calculation"/>
											<xsl:text>]</xsl:text>
										</xsl:if>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:value-of select="$delimiter3"/>
							</xsl:if>
							
							<!-- Web Viewer / Function Name -->
							<xsl:if test="WebScript/ObjectName/Calculation">

								<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
									<xsl:with-param name="optional_label" select="'Web Viewer'"/>
									<xsl:with-param name="calc" select="WebScript/ObjectName/Calculation"/>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="WebScript/FunctionName/Calculation">

								<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
									<xsl:with-param name="optional_label" select="'Function Name'"/>
									<xsl:with-param name="calc" select="WebScript/FunctionName/Calculation"/>
								</xsl:call-template>
							</xsl:if>						</xsl:otherwise>
					</xsl:choose>
					

					
				</xsl:for-each>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	
	<!-- FM21 -->
	<!--
	 ! Script step 215. Insert Embedding
	 ! ========
	 ! Insert Embedding [ Account Name: "MyChatGPT" ; Embedding Model: TestTable::TextField1 ; Input: TestTable::TextField1 ; Target: TestTable::TextField1[$Rep] ]
	 ! ========
	  <Step enable="True" id="215" name="Insert Embedding">
	    <Field table="TestTable" id="6" repetition="0" name="TextField1"/>
	    <Repetition>
	      <Calculation><![CDATA[$Rep]]></Calculation>
	    </Repetition>
	    <LLMEmbedding>
	      <AccountName>
	        <Calculation><![CDATA["MyChatGPT"]]></Calculation>
	      </AccountName>
	      <Model>
	        <Calculation><![CDATA[TestTable::TextField1]]></Calculation>
	      </Model>
	      <InputText>
	        <Calculation><![CDATA[TestTable::TextField1]]></Calculation>
	      </InputText>
	    </LLMEmbedding>
	  </Step>
	 ! ========
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '215']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				
				<!-- Account Name -->
				<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
					<xsl:with-param name="optional_label" select="'Account Name'"/>
					<xsl:with-param name="calc" select="LLMEmbedding/AccountName/Calculation"/>
				</xsl:call-template>
				
				<!-- Embedding Model -->
				<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
					<xsl:with-param name="optional_label" select="'Embedding Model'"/>
					<xsl:with-param name="calc" select="LLMEmbedding/Model/Calculation"/>
				</xsl:call-template>
				
				<!-- Input -->
				<xsl:if test="LLMEmbedding/InputText/Calculation or LLMEmbedding/Model/Calculation">
					<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
						<xsl:with-param name="optional_label" select="'Input'"/>
						<xsl:with-param name="calc" select="LLMEmbedding/InputText/Calculation"/>
					</xsl:call-template>
				</xsl:if>				
				<!-- Target -->
				<xsl:call-template name="ScriptStepParamTarget"/>
				
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	
	<!-- FM21 -->
	<!--
	 ! Script step 216. Insert Embedding in Found Set
	 ! ========
	 ! Insert Embedding in Found Set [ Account Name: "MyChatGPT" ; Embedding Model: "Model" ; Source Field: TestTable::TextField1 ; Target Field: Contacts::Name ; Replace target contents ; Continue on error ; Show summary ; Parameters: "ParamsJSON" ]
	 ! ========
	  <Step enable="True" id="216" name="Insert Embedding in Found Set">
	    <Field table="Contacts" id="6" name="Name"/>
	    <LLMBulkEmbedding>
	      <AccountName>
	        <Calculation><![CDATA["MyChatGPT"]]></Calculation>
	      </AccountName>
	      <Model>
	        <Calculation><![CDATA["Model"]]></Calculation>
	      </Model>
	      <Field table="TestTable" id="6" name="TextField1"/>
	      <Overwrite/>
	      <ContinueOnError/>
	      <ShowSummary/>
	      <Parameters>
	        <Calculation><![CDATA["ParamsJSON"]]></Calculation>
	      </Parameters>
	    </LLMBulkEmbedding>
	  </Step>
	 ! ========
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '216']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				
				<!-- Account Name -->
				<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
					<xsl:with-param name="optional_label" select="'Account Name'"/>
					<xsl:with-param name="calc" select="LLMBulkEmbedding/AccountName/Calculation"/>
				</xsl:call-template>
				
				<!-- Embedding Model -->
				<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
					<xsl:with-param name="optional_label" select="'Embedding Model'"/>
					<xsl:with-param name="calc" select="LLMBulkEmbedding/Model/Calculation"/>
				</xsl:call-template>
				
				<!-- Source Field -->
				<xsl:for-each select="LLMBulkEmbedding/Field">
					<xsl:call-template name="ScriptStepParamField">
						<xsl:with-param name="label" select="'Source Field'"/>
						<xsl:with-param name="field" select="."/>
					</xsl:call-template>
				</xsl:for-each>
			
				<!-- Target Field -->
				<xsl:call-template name="ScriptStepParamTarget">
					<xsl:with-param name="label" select="'Target Field'"/>
				</xsl:call-template>
				
				<!-- Replace target contents -->
				<xsl:if test="LLMBulkEmbedding/Overwrite">
					<xsl:value-of select="'Replace target contents'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				
				<!-- Continue on error -->
				<xsl:if test="LLMBulkEmbedding/ContinueOnError">
					<xsl:value-of select="'Continue on error'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				
				<!-- Show summary -->
				<xsl:if test="LLMBulkEmbedding/ShowSummary">
					<xsl:value-of select="'Show summary'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				
				<!-- Parameters -->
				<xsl:for-each select="LLMBulkEmbedding/Parameters/Calculation">
					<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
						<xsl:with-param name="optional_label" select="'Parameters'"/>
						<xsl:with-param name="calc" select="."/>
					</xsl:call-template>
				</xsl:for-each>

			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!-- 217 -->
	<!--
	 ! Script step 216. Set AI Call Logging
	 ! ========
	 ! Set AI Call Logging [ On ; Filename: "filename.ext" ; Verbose: On ; Truncate Messages: On ] 
	 ! ========
	  <Step enable="True" id="217" name="Set AI Call Logging">
	    <Set state="True"/>
	    <LLMDebugLog>
	      <FileName>
	        <Calculation><![CDATA["filename.ext"]]></Calculation>
	      </FileName>
	      <VerboseMode/>
	      <TruncateEmbeddingVectorsMode/>
	    </LLMDebugLog>
	  </Step>
	 ! ========
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '217']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				
				<xsl:call-template name="OutputTrueAsOnElseOff">
					<xsl:with-param name="state" select="Set/@state"/>
				</xsl:call-template>
				<xsl:value-of select="$delimiter3"/>

				<!-- FileName -->
				<xsl:for-each select="LLMDebugLog/FileName/Calculation">
					<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
						<xsl:with-param name="optional_label" select="'Filename'"/>
						<xsl:with-param name="calc" select="."/>
					</xsl:call-template>
				</xsl:for-each>
				
				<xsl:call-template name="ScriptStepParamBooleany">
					<xsl:with-param name="optional_label" select="'Verbose'"/>
					<xsl:with-param name="value" select="LLMDebugLog/VerboseMode"/>
					<!-- i18n dbengine_string::kScriptOnStrID -->
					<xsl:with-param name="present" select="'On'"/>
					<!-- i18n dbengine_string::kScriptOffStrID -->
					<xsl:with-param name="empty" select="'Off'"/>
				</xsl:call-template>
				
				<xsl:call-template name="ScriptStepParamBooleany">
					<xsl:with-param name="optional_label" select="'Truncate Messages'"/>
					<xsl:with-param name="value" select="LLMDebugLog/TruncateEmbeddingVectorsMode"/>
					<!-- i18n dbengine_string::kScriptOnStrID -->
					<xsl:with-param name="present" select="'On'"/>
					<!-- i18n dbengine_string::kScriptOffStrID -->
					<xsl:with-param name="empty" select="'Off'"/>
				</xsl:call-template>
				
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 218. Perform Semantic Find
	 ! ========
	 ! Perform Semantic Find [ Query by: Natural language ; Account Name: "MyChatGPT" ; Embedding Model: "Model" ; Text: _GUISyntax::Command ; Record set: Current found set ; Target field: _GUISyntax::Column 5 ; Return count: _GUISyntax::Command_ID ; Cosine similarity condition: greater than ; Cosine similarity value: 1/2 ; Save result: _GUISyntax::Language ]
	 ! ========
	  <Step enable="True" id="218" name="Perform Semantic Find">
	    <Field table="_GUISyntax" id="12" name="Column 5"/>
	    <LLMSemanticFind>
	      <Query type="1"/>
	      <AccountName>
	        <Calculation><![CDATA["MyChatGPT"]]></Calculation>
	      </AccountName>
	      <LLMEmbeddingModel>
	        <Calculation><![CDATA["Model"]]></Calculation>
	      </LLMEmbeddingModel>
	      <Text>
	        <Calculation><![CDATA[_GUISyntax::Command]]></Calculation>
	      </Text>
	      <Count>
	        <Calculation><![CDATA[_GUISyntax::Command_ID]]></Calculation>
	      </Count>
	      <Condition type="1"/>
	      <Records type="2"/>
	      <Threshold>
	        <Calculation><![CDATA[1/2]]></Calculation>
	      </Threshold>
	      <SaveResult>
	        <Field table="_GUISyntax" id="3" name="Language"/>
	      </SaveResult>
	    </LLM
				</xsl:for-each>
			SemanticFind>
	  </Step>
	 ! ========
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '218']">
		<xsl:variable name="queryType" select="LLMSemanticFind/Query/@type"/>
		<!--  -->
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				
				<!-- Query by -->
					<xsl:value-of select="'Query by'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:choose>
						<xsl:when test="$queryType='1'">
							<xsl:value-of select="'Natural language'"/>
						</xsl:when>
						<xsl:when test="$queryType='2'">
							<xsl:value-of select="'Vector data'"/>
						</xsl:when>
						<xsl:when test="$queryType='3'">
							<xsl:value-of select="'Image'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'Natural language'"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:value-of select="$delimiter3"/>
				
				<!-- Account Name -->
					<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
						<xsl:with-param name="optional_label" select="'Account Name'"/>
						<xsl:with-param name="calc" select="LLMSemanticFind/AccountName/Calculation"/>
					</xsl:call-template>
				<!-- Embedding Model -->
					<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
						<xsl:with-param name="optional_label" select="'Embedding Model'"/>
						<xsl:with-param name="calc" select="LLMSemanticFind/LLMEmbeddingModel/Calculation"/>
					</xsl:call-template>
				
				<xsl:choose>
					<xsl:when test="$queryType='2'">
						<!-- Image -->
						<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
							<xsl:with-param name="optional_label" select="'Vector'"/>
							<xsl:with-param name="calc" select="LLMSemanticFind/Vector/Calculation"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$queryType='3'">
						<!-- Image -->
						<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
							<xsl:with-param name="optional_label" select="'Image'"/>
							<xsl:with-param name="calc" select="LLMSemanticFind/Image/Calculation"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
							<!-- Text -->
							<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
								<xsl:with-param name="optional_label" select="'Text'"/>
								<xsl:with-param name="calc" select="LLMSemanticFind/Text/Calculation"/>
							</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
	
				<!-- Record set -->
				<xsl:for-each select="LLMSemanticFind/Records">
					<xsl:value-of select="'Record set'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:choose>
						<xsl:when test="@type='1'">
							<xsl:value-of select="'All records'"/>
						</xsl:when>
						<xsl:when test="@type='2'">
							<xsl:value-of select="'Current found set'"/>
						</xsl:when>
					</xsl:choose>
					<xsl:value-of select="$delimiter3"/>
				</xsl:for-each>
				
				<!-- Target field -->
				<xsl:call-template name="ScriptStepParamField">
					<xsl:with-param name="label" select="'Target field'"/>
					<xsl:with-param name="field" select="Field"/>
				</xsl:call-template>
				
				<!-- Return count -->
				<xsl:for-each select="LLMSemanticFind/Count/Calculation">
					<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
						<xsl:with-param name="optional_label" select="'Return count'"/>
						<xsl:with-param name="calc" select="."/>
					</xsl:call-template>
				</xsl:for-each>
				
				<!-- Cosine similarity condition -->
				<xsl:variable name="cosineSimilarityType">
					<xsl:for-each select="LLMSemanticFind/Condition">
						<xsl:choose>
							<xsl:when test="@type='1'">
								<xsl:value-of select="'greater than'"/>
							</xsl:when>
							<xsl:when test="@type='2'">
								<xsl:value-of select="'less than'"/>
							</xsl:when>
							<xsl:when test="@type='3'">
								<xsl:value-of select="'equal to'"/>
							</xsl:when>
							<xsl:when test="@type='4'">
								<xsl:value-of select="'greater than or equal to'"/>
							</xsl:when>
							<xsl:when test="@type='5'">
								<xsl:value-of select="'less than or equal to'"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="''"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</xsl:variable>
				
				<xsl:if test="string-length($cosineSimilarityType)&gt;0">
					<xsl:value-of select="'Cosine similarity condition'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:value-of select="$cosineSimilarityType"/>
					<xsl:value-of select="$delimiter3"/>
					
					<!-- Cosine similarity value -->
					<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
						<xsl:with-param name="optional_label" select="'Cosine similarity value'"/>
						<xsl:with-param name="calc" select="LLMSemanticFind/Threshold/Calculation"/>
					</xsl:call-template>
				</xsl:if>
				
				<!-- Save result -->
				<xsl:for-each select="LLMSemanticFind/SaveResult/Field">
					<xsl:call-template name="ScriptStepParamField">
						<xsl:with-param name="label" select="'Save result'"/>
						<xsl:with-param name="field" select="."/>
					</xsl:call-template>
				</xsl:for-each>
				
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>

	<!--
	 ! Script step 219. Perform RAG Action 
	 ! ========
	 ! Perform RAG Action [ RAG Account Name: $RagAcccount ; Space ID: $SpaceID ; Action: Send Prompt ; "Prompt" ; AI Account Name: $AccountName ; Model: $Model ; Stream: On ; Prompt Template Name: $PromptTemplateName ; Response Target: _Home::_gEmptyField[$Rep] ; Parameters: $Parameters ]
	 ! ========
		<Step enable="True" id="219" name="Perform RAG Action">
			<Stream state="True"/>
			<Text/>
			<Field table="_Home" id="9" repetition="0" name="_gEmptyField"/>
			<Repetition>
				<Calculation><![CDATA[$Rep]]></Calculation>
			</Repetition>
			<RAGSpace>
				<RAGAccountName>
					<Calculation><![CDATA[$RagAcccount]]></Calculation>
				</RAGAccountName>
				<SpaceID>
					<Calculation><![CDATA[$SpaceID]]></Calculation>
				</SpaceID>
				<RAGSpaceAction>Prompt</RAGSpaceAction>
				<PromptMessage>
					<Calculation><![CDATA["Prompt"]]></Calculation>
				</PromptMessage>
				<AIAccountName>
					<Calculation><![CDATA[$AccountName]]></Calculation>
				</AIAccountName>
				<Model>
					<Calculation><![CDATA[$Model]]></Calculation>
				</Model>
				<TemplateName>
					<Calculation><![CDATA[$PromptTemplateName]]></Calculation>
				</TemplateName>
				<Parameters>
					<Calculation><![CDATA[$Parameters]]></Calculation>
				</Parameters>
			</RAGSpace>
		</Step>
	 ! ========
	 ! Perform RAG Action [ RAG Account Name: $RagAcccount ; Space ID: $SpaceID ; Action: Add Data ; RAG Data: From Text ; "Rag data" ]
	 ! ========
		<Step enable="True" id="219" name="Perform RAG Action">
			<RAGSpace>
				<RAGAccountName>
					<Calculation><![CDATA[$RagAcccount]]></Calculation>
				</RAGAccountName>
				<SpaceID>
					<Calculation><![CDATA[$SpaceID]]></Calculation>
				</SpaceID>
				<RAGSpaceAction>Add</RAGSpaceAction>
				<DataSource>FromText</DataSource>
				<InputText>
					<Calculation><![CDATA["Rag data"]]></Calculation>
				</InputText>
			</RAGSpace>
		</Step>
	 ! ========
	 ! Perform RAG Action [ RAG Account Name: $RagAcccount ; Space ID: $SpaceID ; Action: Add Data ; RAG Data: From File (Async) ; “$InputFile” ]
	 ! ========
		<Step enable="True" id="219" name="Perform RAG Action">
			<UniversalPathList>$InputFile</UniversalPathList>
			<RAGSpace>
				<RAGAccountName>
					<Calculation><![CDATA[$RagAcccount]]></Calculation>
				</RAGAccountName>
				<SpaceID>
					<Calculation><![CDATA[$SpaceID]]></Calculation>
				</SpaceID>
				<RAGSpaceAction>Add</RAGSpaceAction>
				<DataSource>FromFileAsync</DataSource>
			</RAGSpace>
		</Step>
	 ! ========
	 ! Perform RAG Action [ RAG Account Name: $RagAcccount ; Space ID: $SpaceID ; Action: Add Data ; RAG Data: From Container (Async) ; Container Field: _Home::_gHomeScreenPicture[$Rep] ]
	 ! ========
		<Step enable="True" id="219" name="Perform RAG Action">
			<Field table="_Home" id="18" repetition="0" name="_gHomeScreenPicture"/>
			<Repetition>
				<Calculation><![CDATA[$Rep]]></Calculation>
			</Repetition>
			<RAGSpace>
				<RAGAccountName>
					<Calculation><![CDATA[$RagAcccount]]></Calculation>
				</RAGAccountName>
				<SpaceID>
					<Calculation><![CDATA[$SpaceID]]></Calculation>
				</SpaceID>
				<RAGSpaceAction>Add</RAGSpaceAction>
				<DataSource>FromContainerAsync</DataSource>
			</RAGSpace>
		</Step>
	 ! ========
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '219']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				
				<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
					<xsl:with-param name="optional_label" select="'RAG Account Name'"/>
					<xsl:with-param name="calc" select="RAGSpace/RAGAccountName/Calculation"/>
				</xsl:call-template>
				
				<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
					<xsl:with-param name="optional_label" select="'Space ID'"/>
					<xsl:with-param name="calc" select="RAGSpace/SpaceID/Calculation"/>
				</xsl:call-template>
				
				<xsl:value-of select="'Action'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:choose>
					<xsl:when test="RAGSpace/RAGSpaceAction='Prompt'">
						<!-- Send Prompt -->
						<xsl:value-of select="'Send Prompt'"/>
						<xsl:value-of select="$delimiter3"/>
						
						<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
							<xsl:with-param name="calc" select="RAGSpace/PromptMessage/Calculation"/>
						</xsl:call-template>
						
						<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
							<xsl:with-param name="optional_label" select="'AI Account Name'"/>
							<xsl:with-param name="calc" select="RAGSpace/AIAccountName/Calculation"/>
						</xsl:call-template>

						<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
							<xsl:with-param name="optional_label" select="'Model'"/>
							<xsl:with-param name="calc" select="RAGSpace/Model"/>
						</xsl:call-template>
						
						<xsl:call-template name="OutputScriptStepParamTrueOnOff">
							<xsl:with-param name="label" select="'Stream'"/>
							<xsl:with-param name="value" select="Stream/@state"/>
						</xsl:call-template>
						
						<xsl:if test="string-length(RAGSpace/TemplateName/Calculation)&gt;0">
							<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
								<xsl:with-param name="optional_label" select="'Prompt Template Name'"/>
								<xsl:with-param name="calc" select="RAGSpace/TemplateName/Calculation"/>
							</xsl:call-template>
						</xsl:if>
						
						<xsl:if test="Field">
							<xsl:value-of select="'Response Target'"/>
							<xsl:value-of select="$delimiter2"/>
							<xsl:call-template name="ScriptStepParamField">
								<xsl:with-param name="field" select="Field"/>
							</xsl:call-template>
		
						</xsl:if>
						
						<xsl:for-each select="RAGSpace">
							
							<xsl:if test="Parameters/Calculation">
								<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
									<xsl:with-param name="optional_label" select="'Parameters'"/>
									<xsl:with-param name="calc" select="Parameters/Calculation"/>
								</xsl:call-template>
							</xsl:if>
						</xsl:for-each>
						
					</xsl:when>
					<xsl:when test="RAGSpace/RAGSpaceAction='Remove'">
						<!-- Remove Data -->
						<xsl:value-of select="'Remove Data'"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:when>
					
					<xsl:otherwise>
						<!-- Add Data -->
						<xsl:value-of select="'Add Data'"/>
						<xsl:value-of select="$delimiter3"/>
						
						<xsl:value-of select="'RAG Data'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:choose>
							<xsl:when test="RAGSpace/DataSource='FromText'">
								<!-- Add Data (From Text) -->
								<xsl:value-of select="'From Text'"/>
								<xsl:value-of select="$delimiter3"/>

								<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
									<xsl:with-param name="calc" select="RAGSpace/InputText/Calculation"/>
								</xsl:call-template>
								
							</xsl:when>
							<xsl:when test="RAGSpace/DataSource='FromFile'">
								<!-- Add Data (From File) -->
								
								<xsl:value-of select="'From File'"/>
								<xsl:value-of select="$delimiter3"/>
								
								<xsl:if test="UniversalPathList!=''">
									<xsl:call-template name="UniversalPathListFileName"/>
									<xsl:value-of select="$delimiter3"/>
								</xsl:if>
							</xsl:when>
							<xsl:when test="RAGSpace/DataSource='FromFileAsync'">
								<!-- Add Data (From File) -->
								<xsl:value-of select="'From File (Async)'"/>
								<xsl:value-of select="$delimiter3"/>
								
								<xsl:if test="UniversalPathList!=''">
									<xsl:call-template name="UniversalPathListFileName"/>
									<xsl:value-of select="$delimiter3"/>
								</xsl:if>
							</xsl:when>
							<xsl:when test="RAGSpace/DataSource='FromContainer'">
								<!-- Add Data (From Container) -->
								<xsl:value-of select="'From Container'"/>
								<xsl:value-of select="$delimiter3"/>
								
								<xsl:if test="Field">
									<xsl:value-of select="'Container Field'"/>
									<xsl:value-of select="$delimiter2"/>
									<xsl:call-template name="ScriptStepParamField">
										<xsl:with-param name="field" select="Field"/>
									</xsl:call-template>
				
								</xsl:if>
								
							</xsl:when>
							<xsl:when test="RAGSpace/DataSource='FromContainerAsync'">
								<!-- Add Data (From Container) -->
								<xsl:value-of select="'From Container (Async)'"/>
								<xsl:value-of select="$delimiter3"/>
								
								<xsl:if test="Field">
									<xsl:value-of select="'Container Field'"/>
									<xsl:value-of select="$delimiter2"/>
									<xsl:call-template name="ScriptStepParamField">
										<xsl:with-param name="field" select="Field"/>
									</xsl:call-template>
								</xsl:if>
							</xsl:when>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
				
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	
	
	<!--
	 ! Script step 220. Generate Response from Model
	 ! ========
	 ! Generate Response from Model [ Account Name: $AccountName ; Model: $Model ; User Prompt: $UserPrompt ; Agentic mode ; Response: $TargetResponse ; Tool Calls from Model: $TargetToolCallsFromModel ; Instructions: $InstructionsCalculation ; Messages: $TargetMessages ; Save Message History To: $SaveMessageHistoryVariable[$Rep] ; Message History Count: $SaveMessageHistoryCountCalc ; Temperature: $TemparatureCalculation ; Tool Definitions: $ToolDefinitionsCalc ; Stream ; Parameters: $Parameters ; Web Viewer: $WebViewer ; Function Name: $JavascriptFunctionName ]
	 ! ========
		<Step enable="True" id="220" name="Generate Response from Model">
			<Option state="True"/>
			<SelectAll state="True"/>
			<Stream state="True"/>
			<Set state="True"/>
			<LinkAvail state="True"/>
			<Restore state="True"/>
			<UniversalPathList type="Reference"/>
			<Text/>
			<Field>$TargetResponse</Field>
			<LLMRequestWithTools>
				<AccountName><Calculation><![CDATA[$AccountName]]></Calculation></AccountName>
				<Model><Calculation><![CDATA[$Model]]></Calculation></Model>
				<UserPrompt><Calculation><![CDATA[$UserPrompt]]></Calculation></UserPrompt>
				<Instructions><Calculation><![CDATA[$InstructionsCalculation]]></Calculation></Instructions>
				<Field type="Messages">$TargetMessages</Field>
				<SlidingWindowVariable>$SaveMessageHistoryVariable</SlidingWindowVariable>
				<SlidingWindowMessageCount><Calculation><![CDATA[$SaveMessageHistoryCountCalc]]></Calculation></SlidingWindowMessageCount>
				<SlidingWindowVariableRepetition><Calculation><![CDATA[$Rep]]></Calculation></SlidingWindowVariableRepetition>
				<ToolDefinitions><Calculation><![CDATA[$ToolDefinitionsCalc]]></Calculation></ToolDefinitions>
				<Field type="ToolCalls">$TargetToolCallsFromModel</Field>
				<Temperature><Calculation><![CDATA[$TemparatureCalculation]]></Calculation></Temperature>
				<Parameters><Calculation><![CDATA[$Parameters]]></Calculation></Parameters>
				<WebScript>
					<ObjectName><Calculation><![CDATA[$WebViewer]]></Calculation></ObjectName>
					<FunctionName><Calculation><![CDATA[$JavascriptFunctionName]]></Calculation></FunctionName>
				</WebScript>
			</LLMRequestWithTools>
		</Step>
	 ! ========
	  <Step enable="True" id="220" name="Generate Response from Model">
	    <Option state="True"/>
	    <SelectAll state="True"/>
	    <Stream state="True"/>
	    <Set state="True"/>
	    <LinkAvail state="True"/>
	    <Restore state="True"/>
	    <UniversalPathList type="Reference"/>
	    <Text/>
	    <Field>$TargetResponse</Field>
	    <LLMRequestWithTools>
	      <AccountName>
	        <Calculation><![CDATA[$AccountName]]></Calculation>
	      </AccountName>
	      <Model>
	        <Calculation><![CDATA[$Model]]></Calculation>
	      </Model>
	      <UserPrompt>
	        <Calculation><![CDATA[$UserPrompt]]></Calculation>
	      </UserPrompt>
	      <Instructions>
	        <Calculation><![CDATA[$InstructionsCalculation]]></Calculation>
	      </Instructions>
	      <Field type="Messages">$TargetMessages</Field>
	      
	      <SlidingWindowVariable>$SaveMessageHistoryVariable</SlidingWindowVariable>
	      <SlidingWindowMessageCount>
	        <Calculation><![CDATA[$SaveMessageHistoryCountCalc]]></Calculation>
	      </SlidingWindowMessageCount>
	      <SlidingWindowVariableRepetition>
	        <Calculation><![CDATA[$Rep]]></Calculation>
	      </SlidingWindowVariableRepetition>
	      
	      <ToolDefinitions>
	        <Calculation><![CDATA[$ToolDefinitionsCalc]]></Calculation>
	      </ToolDefinitions>
	      <Field type="ToolCalls">$TargetToolCallsFromModel</Field>
	      <Temperature>
	        <Calculation><![CDATA[$TemparatureCalculation]]></Calculation>
	      </Temperature>
	      <Parameters>
	        <Calculation><![CDATA[$Parameters]]></Calculation>
	      </Parameters>
	      <WebScript>
	        <ObjectName>
	          <Calculation><![CDATA[$WebViewer]]></Calculation>
	        </ObjectName>
	        <FunctionName>
	          <Calculation><![CDATA[$JavascriptFunctionName]]></Calculation>
	        </FunctionName>
	        <WebScriptParameters Count="2">
	          <P>
	            <Calculation><![CDATA[$Param1]]></Calculation>
	          </P>
	          <P>
	            <Calculation><![CDATA[$Param2]]></Calculation>
	          </P>
	        </WebScriptParameters>
	      </WebScript>
	    </LLMRequestWithTools>
	  </Step>

	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '220']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				
				<!-- Account Name -->
				<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
					<xsl:with-param name="optional_label" select="'Account Name'"/>
					<xsl:with-param name="calc" select="LLMRequestWithTools/AccountName/Calculation"/>
				</xsl:call-template>
				
				<!-- Model -->
				<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
					<xsl:with-param name="optional_label" select="'Model'"/>
					<xsl:with-param name="calc" select="LLMRequestWithTools/Model/Calculation"/>
				</xsl:call-template>
				
				<!-- User Prompt -->
				<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
					<xsl:with-param name="optional_label" select="'User Prompt'"/>
					<xsl:with-param name="calc" select="LLMRequestWithTools/UserPrompt/Calculation"/>
				</xsl:call-template>

				<!-- Agentic mode -->
				<xsl:call-template name="ScriptStepParamBooleany">
					<xsl:with-param name="value" select="Set/@state"/>
					<xsl:with-param name="true" select="'Agentic mode'"/>
				</xsl:call-template>
				
				<!-- Response -->
				<xsl:call-template name="ScriptStepParamField">
					<xsl:with-param name="label" select="'Response'"/>
					<xsl:with-param name="field" select="Field[not(@type)]"/>
				</xsl:call-template>

				<!-- Tool Calls from Model -->
				<xsl:for-each select="LLMRequestWithTools/Field[@type='ToolCalls']">
					<xsl:call-template name="ScriptStepParamField">
						<xsl:with-param name="label" select="'Tool Calls from Model'"/>
						<xsl:with-param name="field" select="."/>
					</xsl:call-template>
				</xsl:for-each>
				
				<!-- Instructions -->
				<xsl:for-each select="LLMRequestWithTools/Instructions/Calculation">
					<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
						<xsl:with-param name="optional_label" select="'Instructions'"/>
						<xsl:with-param name="calc" select="."/>
					</xsl:call-template>
				</xsl:for-each>
				
				<!-- Messages
				 ! No Repetition allowed
				 !-->
				<xsl:for-each select="LLMRequestWithTools/Field[@type='Messages']">
					<xsl:call-template name="ScriptStepParamField">
						<xsl:with-param name="label" select="'Messages'"/>
						<xsl:with-param name="field" select="."/>
					</xsl:call-template>
				</xsl:for-each>
				
				<!-- Save Message History To -->
				<xsl:if test="LLMRequestWithTools/SlidingWindowVariable">
					<xsl:value-of select="'Save Message History To'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:value-of select="LLMRequestWithTools/SlidingWindowVariable"/>
					<xsl:for-each select="LLMRequestWithTools/SlidingWindowVariableRepetition/Calculation[string-length(text())&gt;0]">
						<xsl:call-template name="OutputRepetition">
							<xsl:with-param name="repetition_calc" select="."/>
						</xsl:call-template>
					</xsl:for-each>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				
				<!-- Message History Count -->
				<xsl:for-each select="LLMRequestWithTools/SlidingWindowMessageCount/Calculation">
					<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
						<xsl:with-param name="optional_label" select="'Message History Count'"/>
						<xsl:with-param name="calc" select="."/>
					</xsl:call-template>
				</xsl:for-each>
				
				<!-- Temperature -->
				<xsl:for-each select="LLMRequestWithTools/Temperature/Calculation">
					<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
						<xsl:with-param name="optional_label" select="'Temperature'"/>
						<xsl:with-param name="calc" select="."/>
					</xsl:call-template>
				</xsl:for-each>
				
				<!-- Tool Definitions -->
				<xsl:for-each select="LLMRequestWithTools/ToolDefinitions/Calculation">
					<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
						<xsl:with-param name="optional_label" select="'Tool Definitions'"/>
						<xsl:with-param name="calc" select="."/>
					</xsl:call-template>
				</xsl:for-each>
				
				<!-- Stream -->
				<xsl:if test="Stream/@state='True'">
					<xsl:value-of select="'Stream'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
				
				<!-- Parameters -->
				<xsl:for-each select="LLMRequestWithTools/Parameters/Calculation[string-length(text())&gt;0]">
					<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
						<xsl:with-param name="optional_label" select="'Parameters'"/>
						<xsl:with-param name="calc" select="."/>
					</xsl:call-template>
				</xsl:for-each>
				
				<!-- Web Viewer -->
				<xsl:for-each select="LLMRequestWithTools/WebScript">
					<xsl:call-template name="ScriptStepParamCalculation">
						<xsl:with-param name="optional_label" select="'Web Viewer'"/>
						<xsl:with-param name="calc" select="ObjectName/Calculation"/>
						<xsl:with-param name="default" select="'&lt;Active Object&gt;'"/>
					</xsl:call-template>
					
					<!-- Function Name -->
					<xsl:for-each select="FunctionName/Calculation[string-length(text())&gt;0]">
						<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
							<xsl:with-param name="optional_label" select="'Function Name'"/>
							<xsl:with-param name="calc" select="."/>
						</xsl:call-template>
					</xsl:for-each>
					
					<!-- Function Parameters-->
					<xsl:if test="$pVerbose = 'True'">
						<xsl:for-each select="WebScriptParameters/P">
							<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
								<xsl:with-param name="optional_label" select="'P'"/>
								<xsl:with-param name="calc" select="Calculation"/>
							</xsl:call-template>
						</xsl:for-each>
					</xsl:if>
				</xsl:for-each>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!--
	 ! Script step 221. Perform Find by Natural Language
	 ! ========
	 ! 	Configure Regression Model [ Action: Train Model ; Model Name: "Fred" ; Algorithm: Random Forest ; Training Vectors Field: TestTable::TextField1 ; Training Target Field: TestTable::TextField_lotsTurnedOn ; Skip empty or invalid records ; Parameters: $Parameters ; Save Model To: TestTable::ContainerField1 ]
	 ! ========
	  <Step enable="True" id="221" name="Perform Find by Natural Language">
	    <Option state="True"/>
	    <SelectAll state="True"/>
	    <LLMCreateFind>
	      <AccountName>
	        <Calculation><![CDATA[$AccountName]]></Calculation>
	      </AccountName>
	      <Model>
	        <Calculation><![CDATA[$Model]]></Calculation>
	      </Model>
	      <PromptMessage>
	        <Calculation><![CDATA[$Prompt]]></Calculation>
	      </PromptMessage>
	      <Parameters>
	        <Calculation><![CDATA[$Parameters]]></Calculation>
	      </Parameters>
	      <Action>Query</Action>
	    </LLMCreateFind>
	  </Step>
	 ! ========
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '221']">
		<xsl:variable name="Action" select="LLMCreateFind/Action"/>
		<xsl:variable name="ActionOutput">
			<xsl:choose>
				<xsl:when test="$Action='Query'">
					<xsl:value-of select="'Found Set'"/>
				</xsl:when>
				<xsl:when test="$Action='Data API'">
					<xsl:value-of select="'Found Set as JSON'"/>
				</xsl:when>
				<xsl:when test="$Action='None'">
					<xsl:value-of select="'Find Request as JSON'"/>
				</xsl:when>
				<xsl:otherwise>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!--  -->
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				
				<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
					<xsl:with-param name="optional_label" select="'Account Name'"/>
					<xsl:with-param name="calc" select="LLMCreateFind/AccountName/Calculation"/>
				</xsl:call-template>
				
				<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
					<xsl:with-param name="optional_label" select="'Model'"/>
					<xsl:with-param name="calc" select="LLMCreateFind/Model/Calculation"/>
				</xsl:call-template>

				<!--<xsl:for-each select="LLMCreateFind/Model/Calculation">
					<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
						<xsl:with-param name="optional_label" select="'Model'"/>
						<xsl:with-param name="calc" select="."/>
					</xsl:call-template>
				</xsl:for-each>-->				

				<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
					<xsl:with-param name="optional_label" select="'Prompt'"/>
					<xsl:with-param name="calc" select="LLMCreateFind/PromptMessage/Calculation"/>
				</xsl:call-template>

				<xsl:value-of select="'Get'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:value-of select="$ActionOutput"/>
				<xsl:value-of select="$delimiter3"/>
				
				<xsl:for-each select="LLMCreateFind/Parameters/Calculation">
					<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
						<xsl:with-param name="optional_label" select="'Parameters'"/>
						<xsl:with-param name="calc" select="."/>
					</xsl:call-template>
				</xsl:for-each>
				
				<xsl:if test="Field">
					<xsl:value-of select="'Response Target'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:call-template name="ScriptStepParamField">
						<xsl:with-param name="field" select="Field"/>
					</xsl:call-template>
				</xsl:if>
				
				<!-- Bug in fm22: Prompt Template Name is not passed to clipboard -->
				<xsl:for-each select="LLMCreateFind/TemplateName/Calculation">
					<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
						<xsl:with-param name="optional_label" select="'Prompt Template Name'"/>
						<xsl:with-param name="calc" select="."/>
					</xsl:call-template>
				</xsl:for-each>
				
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	
	<!--
	 ! Script step 222. Configure Regression Model
	 ! ========
	 ! 	Configure Regression Model [ Action: Train Model ; Model Name: "Fred" ; Algorithm: Random Forest ; Training Vectors Field: TestTable::TextField1 ; Training Target Field: TestTable::TextField_lotsTurnedOn ; Skip empty or invalid records ; Parameters: $Parameters ; Save Model To: TestTable::ContainerField1 ]
	 ! ========
		<Step enable="True" id="222" name="Configure Regression Model">
			<Field table="TestTable" id="11" name="ContainerField1"/>
			<LLMTrain>
				<LLMTrainAction>LLMTrainTrainModel</LLMTrainAction>
				<LLMAlgorithm>LLMTrainAlgForest</LLMAlgorithm>
				<LLMTrainModelName>
					<Calculation><![CDATA["Fred"]]></Calculation>
				</LLMTrainModelName>
				<LLMTrainVectorsField>
					<Field table="TestTable" id="6" name="TextField1"/>
				</LLMTrainVectorsField>
				<LLMTrainLabelsField>
					<Field table="TestTable" id="15" name="TextField_lotsTurnedOn"/>
				</LLMTrainLabelsField>
				<LLMTrainModelParameters>
					<Calculation><![CDATA[$Parameters]]></Calculation>
				</LLMTrainModelParameters>
				<LLMTrainSkipRecords/>
			</LLMTrain>
		</Step>
	 ! ========
	 ! Configure Regression Model [ Action: Save Model ; Model Name: "Fred" ; Save Model To: TestTable::ContainerField1 ] 
	 ! ========
		<Step enable="True" id="222" name="Configure Regression Model">
			<Field table="TestTable" id="11" name="ContainerField1"/>
			<LLMTrain>
				<LLMTrainAction>LLMTrainSaveModel</LLMTrainAction>
				<LLMAlgorithm>LLMTrainAlgForest</LLMAlgorithm>
				<LLMTrainModelName>
					<Calculation><![CDATA["Fred"]]></Calculation>
				</LLMTrainModelName>
				<LLMTrainVectorsField>
					<Field table="TestTable" id="6" name="TextField1"/>
				</LLMTrainVectorsField>
				<LLMTrainLabelsField>
					<Field table="TestTable" id="15" name="TextField_lotsTurnedOn"/>
				</LLMTrainLabelsField>
				<LLMTrainModelParameters>
					<Calculation><![CDATA[$Parameters]]></Calculation>
				</LLMTrainModelParameters>
				<LLMTrainSkipRecords/>
			</LLMTrain>
		</Step>
	 ! ========
	 ! Configure Regression Model [ Action: Load Model ; Model Name: "Fred" ; Load Model From: TestTable::ContainerField1 ]
	 ! ========
		<Step enable="True" id="222" name="Configure Regression Model">
			<Field table="TestTable" id="11" name="ContainerField1"/>
			<LLMTrain>
				<LLMTrainAction>LLMTrainLoadModel</LLMTrainAction>
				<LLMAlgorithm>LLMTrainAlgForest</LLMAlgorithm>
				<LLMTrainModelName>
					<Calculation><![CDATA["Fred"]]></Calculation>
				</LLMTrainModelName>
				<LLMTrainVectorsField>
					<Field table="TestTable" id="6" name="TextField1"/>
				</LLMTrainVectorsField>
				<LLMTrainLabelsField>
					<Field table="TestTable" id="15" name="TextField_lotsTurnedOn"/>
				</LLMTrainLabelsField>
				<LLMTrainModelParameters>
					<Calculation><![CDATA[$Parameters]]></Calculation>
				</LLMTrainModelParameters>
				<LLMTrainSkipRecords/>
			</LLMTrain>
		</Step>
	 ! ========
	 ! Configure Regression Model [ Action: Unload Model ; Model Name: "Fred" ]
	 ! ========
		<Step enable="True" id="222" name="Configure Regression Model">
			<Field table="TestTable" id="11" name="ContainerField1"/>
			<LLMTrain>
				<LLMTrainAction>LLMTrainUnloadModel</LLMTrainAction>
				<LLMAlgorithm>LLMTrainAlgForest</LLMAlgorithm>
				<LLMTrainModelName>
					<Calculation><![CDATA["Fred"]]></Calculation>
				</LLMTrainModelName>
				<LLMTrainVectorsField>
					<Field table="TestTable" id="6" name="TextField1"/>
				</LLMTrainVectorsField>
				<LLMTrainLabelsField>
					<Field table="TestTable" id="15" name="TextField_lotsTurnedOn"/>
				</LLMTrainLabelsField>
				<LLMTrainModelParameters>
					<Calculation><![CDATA[$Parameters]]></Calculation>
				</LLMTrainModelParameters>
				<LLMTrainSkipRecords/>
			</LLMTrain>
		</Step>
	 ! ========
	 ! Note: This step leaves *lots* of dead wood around in the background when the user switches between actions:
	 ! - Field
	 ! - LLMTrain
	 !   - LLMTrainVectorsField
	 !   - LLMTrainLabelsField
	 !   - LLMTrainModelParameters
	 !   - LLMTrainSkipRecords
	 ! ========
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '222']">
		<xsl:variable name="Action" select="LLMTrain/LLMTrainAction"/>
		<xsl:variable name="ActionOutput">
			<xsl:choose>
				<xsl:when test="$Action='LLMTrainTrainModel'">
					<xsl:value-of select="'Train Model'"/>
				</xsl:when>
				<xsl:when test="$Action='LLMTrainSaveModel'">
					<xsl:value-of select="'Save Model'"/>
				</xsl:when>
				<xsl:when test="$Action='LLMTrainLoadModel'">
					<xsl:value-of select="'Load Model'"/>
				</xsl:when>
				<xsl:when test="$Action='LLMTrainUnloadModel'">
					<xsl:value-of select="'Unload Model'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'&lt;Unknown Action&gt;'"/>
					<xsl:value-of select="concat( ' (',$Action,')')"/>
				</xsl:otherwise>
			</xsl:choose>
			
		</xsl:variable>
		<!--  -->
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				
				<xsl:value-of select="'Action'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:value-of select="$ActionOutput"/>
				<xsl:value-of select="$delimiter3"/>
				
				<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
					<xsl:with-param name="optional_label" select="'Model Name'"/>
					<xsl:with-param name="calc" select="LLMTrain/LLMTrainModelName"/>
				</xsl:call-template>
				
				<xsl:choose>
					<xsl:when test="$Action='LLMTrainTrainModel'">
						<!-- Train Model -->
						
						<xsl:value-of select="'Algorithm'"/>
						<xsl:value-of select="$delimiter2"/>
						<xsl:choose>
							<xsl:when test="LLMTrain/LLMAlgorithm='LLMTrainAlgForest'">
								<xsl:value-of select="'Random Forest'"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="LLMTrain/LLMAlgorithm"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:value-of select="$delimiter3"/>
						
						<xsl:for-each select="LLMTrain/LLMTrainVectorsField/Field">
							<xsl:call-template name="ScriptStepParamTarget">
								<xsl:with-param name="label" select="'Training Vectors Field'"/>
								<xsl:with-param name="field" select="."/>
							</xsl:call-template>
						</xsl:for-each>
						
						<xsl:for-each select="LLMTrain/LLMTrainLabelsField/Field">
							<xsl:call-template name="ScriptStepParamTarget">
								<xsl:with-param name="label" select="'Training Target Field'"/>
								<xsl:with-param name="field" select="."/>
							</xsl:call-template>
						</xsl:for-each>
						
						<xsl:for-each select="LLMTrain/LLMTrainSkipRecords">
							<xsl:value-of select="'Skip empty or invalid records'"/>
							<xsl:value-of select="$delimiter3"/>
						</xsl:for-each>
						
						<xsl:for-each select="LLMTrain/LLMTrainModelParameters/Calculation">
							<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
								<xsl:with-param name="optional_label" select="'Parameters'"/>
								<xsl:with-param name="calc" select="."/>
							</xsl:call-template>
						</xsl:for-each>
						
						<xsl:call-template name="ScriptStepParamTarget">
							<xsl:with-param name="label" select="'Save Model To'"/>
							<xsl:with-param name="field" select="Field"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$Action='LLMTrainSaveModel'">

						<xsl:call-template name="ScriptStepParamTarget">
							<xsl:with-param name="label" select="'Save Model To'"/>
							<xsl:with-param name="field" select="Field"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$Action='LLMTrainLoadModel'">
						<!-- Load Model -->

						<xsl:call-template name="ScriptStepParamTarget">
							<xsl:with-param name="label" select="'Load Model From'"/>
							<xsl:with-param name="field" select="Field"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$Action='LLMTrainUnloadModel'">
						<!-- Unload Model -->

					</xsl:when>
				</xsl:choose>

			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	
	
	
	

	<!--
	 ! Script step 223. Set Revert Transaction on Error
	 ! FM21
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '223']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<xsl:call-template name="OutputTrueAsOnElseOff">
					<xsl:with-param name="state" select="Set/@state"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	
	
	
	<!--
	 ! Script step 225. Save Records as JSONL
	 ! FM22
	 ! ========
		<Step enable="True" id="225" name="Save Records as JSONL">
			<Option state="True"/>
			<CreateDirectories state="False"/>
			<FineTuneFormat state="True"/>
			<AutoOpen state="False"/>
			<CreateEmail state="False"/>
			<UniversalPathList>$OutputFilePath</UniversalPathList>
			<Table id="1065168" name="TestTable"/>
			<SaveAsJSONL>
				<SystemPrompt>
					<Calculation><![CDATA[$SystemPrompt]]></Calculation>
				</SystemPrompt>
				<UserPrompt>
					<Calculation><![CDATA[$UserPrompt]]></Calculation>
				</UserPrompt>
				<AssistantPrompt>
					<Calculation><![CDATA[$AssistantPrompt]]></Calculation>
				</AssistantPrompt>
			</SaveAsJSONL>
		</Step>
	 ! ========
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '225']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				
				<xsl:value-of select="'Format for fine-tuning'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:call-template name="OutputScriptStepParamTrueOnOff">
					<xsl:with-param name="value" select="FineTuneFormat/@state"/>
				</xsl:call-template>

				<!-- optional: Table: if empty an empty parameter is output --> 
				<xsl:for-each select="Table">
					<xsl:value-of select="'Table'"/>
					<xsl:value-of select="$delimiter2"/>
					
					<xsl:call-template name="QuotedStringOrDefault">
						<xsl:with-param name="string" select="@name"/>
						<xsl:with-param name="default" select="''"/>
					</xsl:call-template>
					<xsl:value-of select="$delimiter3"/>
				</xsl:for-each>
				
				<xsl:for-each select="SaveAsJSONL">
					<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
						<xsl:with-param name="optional_label" select="'System Prompt'"/>
						<xsl:with-param name="calc" select="SystemPrompt/Calculation"/>
					</xsl:call-template>
					
					<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
						<xsl:with-param name="optional_label" select="'User Prompt'"/>
						<xsl:with-param name="calc" select="UserPrompt/Calculation"/>
					</xsl:call-template>
					
					<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
						<xsl:with-param name="optional_label" select="'Assistant Prompt'"/>
						<xsl:with-param name="calc" select="AssistantPrompt/Calculation"/>
					</xsl:call-template>
					
				</xsl:for-each>

				<xsl:call-template name="ScriptStepParamSpecifyOutputFile"/>
				<xsl:call-template name="ScriptStepParamCreateDirectories"/>
				
				
				
				<!--<xsl:call-template name="OutputScriptStepParamTrueOnOff">
					<xsl:with-param name="state" select="Option/@state"/>
				</xsl:call-template>-->
				
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	
	
	
	
	
	
	<!--
	 ! Script step 226. Configure Prompt Template 
	 ! ========
	 ! Configure Prompt Template [ Template Name: $TemplateName ; Model Provider: OpenAI ; Template Type: SQL Query ; SQL Prompt: "Generate a fully formed SQL query based on following rules:¶ …" ; Natural Language Prompt: "The answer should be…" ] 
	 ! ========
		<Step enable="True" id="226" name="Configure Prompt Template">
			<Option state="True"/>
			<ConfigurePromptTemplate>
				<TemplateName>
					<Calculation><![CDATA[$TemplateName]]></Calculation>
				</TemplateName>
				<ModelProvider>ChatGPT</ModelProvider>
				<RequestType>SQLQuery</RequestType>
				<SQLPrompt>
					<Calculation><![CDATA["Generate a fully formed SQL query based on following rules:¶ 1. Enclose all table and field names in double quotes.¶ 2. Format dates as \"DATE 'YYYY-MM-DD'\", times as \"TIME 'HH:MM:SS'\" and timestamps as \"TIMESTAMP 'YYYY-MM-DD HH:MM:SS'\".¶ 3. Return queries in plain text (not JSON).¶ 4. Use \"FETCH FIRST n ROW ONLY\" instead of \"LIMIT\".¶ 5. Support single queries only.¶ 6. No semicolon is needed at the end of SQL query.¶ 7. Don't generate nested SQL queries.¶ 8. Use \"LIKE\" instead of \"ILIKE\".¶ 9. Keep all comparisons case-sensitive.¶ 10. Do not include fields that are not included in the question.¶ 11. Use unquoted ROWID in queries.¶ 12. Only utilize the following database schema:¶ :schema:"]]></Calculation>
				</SQLPrompt>
				<NaturalLanguagePrompt>
					<Calculation><![CDATA["The answer should be returned in plain text, not in JSON.¶ Break down response if it is too long."]]></Calculation>
				</NaturalLanguagePrompt>
			</ConfigurePromptTemplate>
		</Step>
	 ! ========
	 ! 
	 ! ========
	 ! ========
	 ! ========
	 ! 
	 ! ========
	 ! ========
	 ! ========
	 ! 
	 ! ========
	 ! ========
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '226']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				
				<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
					<xsl:with-param name="optional_label" select="'Template Name'"/>
					<xsl:with-param name="calc" select="ConfigurePromptTemplate/TemplateName/Calculation"/>
				</xsl:call-template>
				
				<xsl:value-of select="'Model Provider'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:choose>
					<xsl:when test="ConfigurePromptTemplate/ModelProvider = 'ChatGPT'">
						<xsl:value-of select="'OpenAI'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="ConfigurePromptTemplate/ModelProvider"/>
					</xsl:otherwise>
				</xsl:choose>
				
				<xsl:value-of select="$delimiter3"/>
				
				
				<xsl:value-of select="'Template Type'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:choose>
					<xsl:when test="ConfigurePromptTemplate/RequestType='SQLQuery'">
						<!-- SQL Query -->
						<xsl:value-of select="'SQL Query'"/>
						<xsl:value-of select="$delimiter3"/>
						
						<xsl:for-each select="ConfigurePromptTemplate/SQLPrompt/Calculation">
							<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
								<xsl:with-param name="optional_label" select="'SQL Prompt'"/>
								<xsl:with-param name="calc" select="."/>
							</xsl:call-template>
						</xsl:for-each>
						
						<xsl:for-each select="ConfigurePromptTemplate/NaturalLanguagePrompt/Calculation">
							<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
								<xsl:with-param name="optional_label" select="'Natural Language Prompt'"/>
								<xsl:with-param name="calc" select="."/>
							</xsl:call-template>
						</xsl:for-each>
					</xsl:when>
					
					<xsl:when test="ConfigurePromptTemplate/RequestType='FindRequest'">
						<!-- Find Request -->
						<xsl:value-of select="'Find Request'"/>
						<xsl:value-of select="$delimiter3"/>
						
						<xsl:for-each select="ConfigurePromptTemplate/FindRequestPrompt/Calculation">
							<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
								<xsl:with-param name="optional_label" select="'Find Request Prompt'"/>
								<xsl:with-param name="calc" select="."/>
							</xsl:call-template>
						</xsl:for-each>
						
					</xsl:when>
					
					<xsl:when test="ConfigurePromptTemplate/RequestType='RAGPrompt'">
						<!-- RAG Prompt-->
						<xsl:value-of select="'RAG Prompt'"/>
						<xsl:value-of select="$delimiter3"/>
						
						<xsl:for-each select="ConfigurePromptTemplate/RAGPPrompt/Calculation">
							<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
								<xsl:with-param name="optional_label" select="'RAG Prompt'"/>
								<xsl:with-param name="calc" select="."/>
							</xsl:call-template>
						</xsl:for-each>
					</xsl:when>
				</xsl:choose>				
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>	
	
	
	<!--
	 ! Script step 227. Configure RAG Account
	 ! =========
	 ! Configure RAG Account  [ RAG Account Name: $MyRagAccount ; Endpoint: $Endpoint ; API key: $MySecretApiKey ; Verify SSL Certificates ]
	 ! =========
		<Step enable="True" id="227" name="Configure RAG Account ">
			<VerifySSLCertificates state="True"/>
			<ConfigureRAGAccount>
				<RAGAccountName>
					<Calculation><![CDATA[$MyRagAccount]]></Calculation>
				</RAGAccountName>
				<Endpoint>
					<Calculation><![CDATA[$Endpoint]]></Calculation>
				</Endpoint>
				<AccessAPIKey>
					<Calculation><![CDATA[$MySecretApiKey]]></Calculation>
				</AccessAPIKey>
			</ConfigureRAGAccount>
		</Step>
		 ! =========
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '227']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				
				<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
					<xsl:with-param name="optional_label" select="'RAG Account Name'"/>
					<xsl:with-param name="calc" select="ConfigureRAGAccount/RAGAccountName/Calculation"/>
				</xsl:call-template>
				
				<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
					<xsl:with-param name="optional_label" select="'Endpoint'"/>
					<xsl:with-param name="calc" select="ConfigureRAGAccount/Endpoint/Calculation"/>
				</xsl:call-template>
				
				<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
					<xsl:with-param name="optional_label" select="'API key'"/>
					<xsl:with-param name="calc" select="ConfigureRAGAccount/AccessAPIKey/Calculation"/>
				</xsl:call-template>
				
				<xsl:if test="VerifySSLCertificates/@state='True'">
					<xsl:value-of select="'Verify SSL Certificates'"/>
					<xsl:value-of select="$delimiter3"/>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	
	
	
	
	
	<!--
	 ! Script step 228. Go to List of Records
	 ! =========
	 ! Go to List of Records [ List of record IDs: $RecordIDs ; Using layout: “My Layout for TestTable” (TestTable) ; Animation: Cross Dissolve ]
	 ! =========
		<Step enable="True" id="228" name="Go to List of Records">
			<ShowInNewWindow state="False"/>
			<LayoutDestination value="SelectedLayout"/>
			<RowList>
				<Calculation><![CDATA[$RecordIDs]]></Calculation>
			</RowList>
			<NewWndStyles Style="Document" Close="Yes" Minimize="Yes" Maximize="Yes" Resize="Yes" Styles="3606018"/>
			<Layout id="41" name="My Layout for TestTable"/>
			<Animation value="CrossDissolve"/>
		</Step>
	 ! =========
	 !-->
	<xsl:template match="//Step[not(ancestor::Step) and @id = '228']">
		<xsl:call-template name="ScriptStepSTART"/>
		<xsl:call-template name="ScriptStepParameterList">
			<xsl:with-param name="pParameterList">
				<!-- -->
				<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
					<!-- i18n dbengine_string::kScriptListOfRecordIDs -->
					<xsl:with-param name="optional_label" select="'List of record IDs'"/>
					<xsl:with-param name="calc" select="RowList/Calculation"/>
				</xsl:call-template>
				<!-- -->
				<!-- i18n dbengine_string::kScriptUsingLayoutStrID -->
				<xsl:value-of select="'Using layout'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:call-template name="ScriptStepParamLayoutDestination"/>
				<!-- -->
				<xsl:choose>
					<xsl:when test="ShowInNewWindow/@state = 'True'">
						<!-- i18n dbengine_string::kScriptCreateWindowStrID -->
						<xsl:value-of select="'New window'"/>
						<xsl:value-of select="$delimiter3"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="ScriptStepParamAnimationValue"/>					
					</xsl:otherwise>
				</xsl:choose>
				<!-- -->
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
	 !  0 <unknown>*
	 !  2 <unknown>*
	 !  // 3 has been resurrected for Save a copy as XML
	 ! 15 <unknown>*
	 ! 52 [OBSOLETE] <unknown>
	 ! 53 [OBSOLETE] <unknown>
	 ! 54 <unknown>*
	 ! 58 [OBSOLETE] <unknown>
	 ! 59 [OBSOLETE] Insert QuickTime
	 ! 78 [OBSOLETE] Insert Object
	 ! 100 [OBSOLETE] <unknown>
	 ! 153 [OBSOLETE] <unknown>
	 ! 162 [OBSOLETE] Open from Test Server
	 ! 163 [OBSOLETE] Sign Out from Test Server
	 ! 170 [OBSOLETE] Upload to Test Server
	 ! 171 [OBSOLETE] Manage Test Server
	 ! 173 <unknown>*
	 ! 176 [OBSOLETE] Set Allowed Orientations
	 ! 204 [OBSOLETE]
	 ! 224 [OBSOLETE]  Execute URL []
	 !
	 ! <unknown>* = never used
	 !-->
	<xsl:template
		match="//Step[not(ancestor::Step) and (@id = 0 or @id = 2 or @id = 15 or @id = 52 or @id = 53 or @id = 54 or @id = 58 or @id = 59 or @id = 78 or @id = 100 or @id = 153 or @id = 162 or @id = 163 or @id = 170 or @id = 171 or @id = 173 or @id = 204 or @id = 224)]">
		<xsl:call-template name="ScriptStepSTARTEND"/>
	</xsl:template>
	<!--
	 ! Script step 176. Set Allowed Orientations
	 ! FIXME - Versioning? This was allowed in some distand version - now obsoleted - delete?
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
	 ! A-Z
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
		<xsl:param name="orCurrentFile" select="'False'"/>
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
			<xsl:when test="$orCurrentFile != 'False'">
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
					<xsl:with-param name="calc" select="Repetition/Calculation"/>
				</xsl:call-template>
				<xsl:value-of select="']'"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--
	 ! OutputCalculation
	 !-->
	<xsl:template name="OutputCalculation">
		<xsl:param name="calc"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="$pVerbose = 'True' and contains($delimiter3, $RETURN)">
				<xsl:value-of select="$calc"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="translate($calc, $CRLF, '  ')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="OutputCalculationOrDefault">
		<xsl:param name="calc"/>
		<xsl:param name="default" select="''"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="string-length($calc) = 0">
				<xsl:value-of select="$default"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="OutputCalculation">
					<xsl:with-param name="calc" select="$calc"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="OutputCalculationOrTwoSpaces">
		<xsl:param name="calc"/>
		<!-- -->
		<xsl:call-template name="OutputCalculationOrDefault">
			<xsl:with-param name="calc" select="$calc"/>
			<xsl:with-param name="default" select="'  '"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="OutputCalculationOrSpace">
		<xsl:param name="calc"/>
		<!-- -->
		<xsl:call-template name="OutputCalculationOrDefault">
			<xsl:with-param name="calc" select="$calc"/>
			<xsl:with-param name="default" select="' '"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="OutputAnimationValue">
		<xsl:param name="animationValue" select="Animation/@value"/>
		<!-- -->
				<xsl:choose>
					<xsl:when test="not($animationValue)">
						<!-- i18n dbengine_string::kLayoutTransitionNoneStrID -->
						<xsl:value-of select="'None'"/>
					</xsl:when>
					<xsl:when test="$animationValue = 'SlideFromLeft'">
						<!-- i18n dbengine_string::kLayoutTransitionSlideFromLeftStrID -->
						<xsl:value-of select="'Slide in from Left'"/>
					</xsl:when>
					<xsl:when test="$animationValue = 'SlideFromRight'">
						<!-- i18n dbengine_string::kLayoutTransitionSlideFromRightStrID -->
						<xsl:value-of select="'Slide in from Right'"/>
					</xsl:when>
					<xsl:when test="$animationValue = 'SlideFromBottom'">
						<!-- i18n dbengine_string::kLayoutTransitionSlideFromBottomStrID -->
						<xsl:value-of select="'Slide in from Bottom'"/>
					</xsl:when>
					<xsl:when test="$animationValue = 'SlideToLeft'">
						<!-- i18n dbengine_string::kLayoutTransitionSlideToLeftStrID -->
						<xsl:value-of select="'Slide out to Left'"/>
					</xsl:when>
					<xsl:when test="$animationValue = 'SlideToRight'">
						<!-- i18n dbengine_string::kLayoutTransitionSlideToRightStrID -->
						<xsl:value-of select="'Slide out to Right'"/>
					</xsl:when>
					<xsl:when test="$animationValue = 'SlideToBottom'">
						<!-- i18n dbengine_string::kLayoutTransitionSlideToBottomStrID -->
						<xsl:value-of select="'Slide out to Bottom'"/>
					</xsl:when>
					<xsl:when test="$animationValue = 'FlipFromLeft'">
						<!-- i18n dbengine_string::kLayoutTransitionFlipFromLeft -->
						<xsl:value-of select="'Flip from Left'"/>
					</xsl:when>
					<xsl:when test="$animationValue = 'FlipFromRight'">
						<!-- i18n dbengine_string::kLayoutTransitionFlipFromRight -->
						<xsl:value-of select="'Flip from Right'"/>
					</xsl:when>
					<xsl:when test="$animationValue = 'ZoomIn'">
						<!-- i18n dbengine_string::kLayoutTransitionZoomInStrID -->
						<xsl:value-of select="'Zoom In'"/>
					</xsl:when>
					<xsl:when test="$animationValue = 'ZoomOut'">
						<!-- i18n dbengine_string::kLayoutTransitionZoomOutStrID -->
						<xsl:value-of select="'Zoom Out'"/>
					</xsl:when>
					<xsl:when test="$animationValue = 'CrossDissolve'">
						<!-- i18n dbengine_string::kLayoutTransitionCrossDissolve -->
						<xsl:value-of select="'Cross Dissolve'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$animationValue"/>
					</xsl:otherwise>
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
				<!-- i18n dbengine_string::kUnknownScriptStrID -->
				<xsl:value-of select="'&lt;unknown&gt;'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$OPENQUOTES"/>
				<xsl:value-of select="$string"/>
				<xsl:value-of select="$CLOSEQUOTES"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	 ! QuotedStringOrDefault
	 !-->
	<xsl:template name="QuotedStringOrDefault">
		<xsl:param name="string"/>
		<xsl:param name="default"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="not($string) or $string = ''">
				<xsl:value-of select="$default"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$OPENQUOTES"/>
				<xsl:value-of select="$string"/>
				<xsl:value-of select="$CLOSEQUOTES"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	 ! ScriptStepParamAnimationValue
	 !-->
	<xsl:template name="ScriptStepParamAnimationValue">
		<!-- i18n dbengine_string::kLayoutTransitionLabelStrID -->
		<xsl:value-of select="'Animation'"/>
		<xsl:value-of select="$delimiter2"/>
		<xsl:call-template name="OutputAnimationValue"/>
		<xsl:value-of select="$delimiter3"/>
	</xsl:template>
	
	
	
	<!--
	 ! OutputScriptStepParamTrueleanOnOff
	 !-->
	<xsl:template name="OutputScriptStepParamTrueleanOnOff">
		<xsl:param name="label" select="''"/>
		<xsl:param name="true_or_false"/>
		<!--  -->
		<xsl:if test="string-length($label)&gt;0">
			<xsl:value-of select="'Label'"/>
			<xsl:value-of select="$delimiter2"/>
		</xsl:if>		
		<xsl:choose>
			<xsl:when test="$true_or_false= 'True'">
				<!-- i18n dbengine_string::kScriptOnStrID -->
				<xsl:value-of select="'On'"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- i18n dbengine_string::kScriptOffStrID -->
				<xsl:value-of select="'Off'"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="$delimiter3"/>
	</xsl:template>
	<!--
	 ! OutputScriptStepParamTrueOnOff
	 !-->
	<xsl:template name="OutputScriptStepParamTrueOnOff">
		<xsl:param name="label"/>
		<xsl:param name="value"/>
		<!--  -->
		<xsl:call-template name="ScriptStepParamBooleany">
			<xsl:with-param name="optional_label" select="$label"/>
			<xsl:with-param name="value" select="$value"/>
			<!-- i18n dbengine_string::kScriptOnStrID -->
			<xsl:with-param name="true" select="'On'"/>
			<!-- i18n dbengine_string::kScriptOffStrID -->
			<xsl:with-param name="otherwise" select="'Off'"/>
		</xsl:call-template>
	</xsl:template>
	<!--
	 ! ScriptStepParamBooleany
	 ! Outputs a boolean-like value
	 !
	 ! You can specify what output when the value is True / False / Empty or fallback on the Otherwise:
	 !
	 !   name="$true" select="'Value to output when the value is the word True'"
	 !   name="$false" select="'Value to output when the value is the word False'"
	 !   name="$empty" select="'Value to output when the value is empty (or missing)'"
	 !   name="$present" select="'Value to output when a value is present (in other words: a node is selected)'"
	 !   name="$otherwise" select="'Value to output when none of the above match'"
	 !-->
	<xsl:template name="ScriptStepParamBooleany">
		<xsl:param name="optional_label" select="''"/>
		<xsl:param name="value"/>
		<xsl:param name="true"  select="'NoTsPeCiFiEd'"/>
		<xsl:param name="false" select="'NoTsPeCiFiEd'"/>
		<xsl:param name="empty" select="'NoTsPeCiFiEd'"/>
		<xsl:param name="present" select="'NoTsPeCiFiEd'"/>
		<xsl:param name="otherwise" select="''"/>
		<!--  -->
		<xsl:variable name="label">
			<xsl:if test="string-length($optional_label)&gt;0">
				<xsl:value-of select="$optional_label"/>
				<xsl:value-of select="$delimiter2"/>
			</xsl:if>
		</xsl:variable>
		<!--  -->
		<xsl:choose>
			<xsl:when test="$value= 'True' and string-length( $true ) &gt; 0 and $true!='NoTsPeCiFiEd'">
				<xsl:value-of select="$label"/>
				<xsl:value-of select="$true"/>
				<xsl:value-of select="$delimiter3"/>
			</xsl:when>
			<xsl:when test="$value= 'False' and string-length( $false ) &gt; 0 and $false!='NoTsPeCiFiEd'">
				<xsl:value-of select="$label"/>
				<xsl:value-of select="$false"/>
				<xsl:value-of select="$delimiter3"/>
			</xsl:when>
			<xsl:when test="$present!='NoTsPeCiFiEd' and $value">
				<xsl:value-of select="$label"/>
				<xsl:value-of select="$present"/>
				<xsl:value-of select="$delimiter3"/>
			</xsl:when>
			<xsl:when test="string-length( $value ) = 0 and string-length( $empty ) &gt; 0 and $empty!='NoTsPeCiFiEd'">
				<xsl:value-of select="$label"/>
				<xsl:value-of select="$empty"/>
				<xsl:value-of select="$delimiter3"/>
			</xsl:when>
			<xsl:when test="string-length($otherwise)">
				<xsl:value-of select="$label"/>
				<xsl:value-of select="$otherwise"/>
				<xsl:value-of select="$delimiter3"/>
			</xsl:when>
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
					<!-- i18n dbengine_string::kScriptImportSourceStrID -->
					<xsl:value-of select="'Source'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:value-of select="concat($QUOT, Profile/@FileName, $QUOT)"/>
					<xsl:call-template name="SIC.delimiter3"/>
					<!-- -->
					<!-- i18n dbengine_string::kExcelOptionsWorksheet2StrID -->
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
								<xsl:with-param name="calc" select="Profile/XMLCalc/Calculation"/>
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
							<xsl:with-param name="calc" select="Profile/XSLCalc/Calculation"/>
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
		<xsl:if test="ExportEntries">
			<xsl:choose>
				<xsl:when test="string-length(ExportOptions/@CharacterSet) = 0">
					<!-- no output -->
				</xsl:when>
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
	 ! Outputs a field (or variable), with no label.
	 !-->
	 <xsl:template name="ScriptStepParamField">
		<xsl:param name="label" select="''"/>
		<xsl:param name="field" select="Field"/>
		<!--  -->
		<xsl:call-template name="ScriptStepParamTarget">
			<xsl:with-param name="label" select="$label"/>
			<xsl:with-param name="field" select="$field"/>
		</xsl:call-template>
	</xsl:template>
		
	<!-- 
	 ! ScriptStepParamTarget
	 !
	 ! Outputs a target field or variable, by default with a Target label.
	 !
	 ! Parameter
	 ! @param label - The label to output. Default = 'Target'. Note: No Field -> no label.
	 ! @param field - The fieldto output. Default = Field.
	 !
	 ! Input Variables
	 ! $delimiter2 - typically ': '
	 ! $delimiter3 - typically '; '
	 !
	 ! Input XML
	 ! child::Field (@name, @rep, @table)
	 ! child::Repetition/Calculation (text())
	 !-->
	<xsl:template name="ScriptStepParamTarget">
		<!-- i18n dbengine_string::kScriptImportTargetStrID -->
		<xsl:param name="label" select="'Target'"/>
		<xsl:param name="field" select="Field"/>
		<xsl:param name="repetition_calc"/>
		<!--  -->
		<xsl:if test="$field">
			<!-- label -->
			<xsl:if test="$label and $label!=''">
				<xsl:value-of select="$label"/>
				<xsl:value-of select="$delimiter2"/>
			</xsl:if>
			<!-- target name -->
			<xsl:choose>
				<!-- Starting fm16 target can also be a variable - var name is in the content of the Field tag -->
				<xsl:when test="$field/text()">
					<!-- Target: $var -->
					<xsl:value-of select="$field/text()"/>
				</xsl:when>
				<xsl:otherwise>
					<!-- Target: Table::Field -->
					<xsl:choose>
						<xsl:when test="$field/@table = ''">
							<xsl:value-of select="'&lt;Table Missing&gt;'"/>
						</xsl:when>
						<xsl:when test="$field/@name = ''">
							<xsl:value-of
								select="concat($field/@table, '::', '&lt;Field Missing&gt;')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat($field/@table, '::', $field/@name)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
			<!-- target [rep] -->
			<xsl:call-template name="OutputRepetition">
				<xsl:with-param name="optional_repetition_number" select="$field/@repetition"/>
				<xsl:with-param name="repetition_calc">
					<xsl:choose>
						<xsl:when test="$repetition_calc">
							<xsl:value-of select="$repetition_calc"/>
						</xsl:when>
						<xsl:when test="$field/following-sibling::Repetition/Calculation">
							<xsl:value-of select="$field/following-sibling::Repetition/Calculation"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="Repetition/Calculation"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
<!--			<xsl:choose>
				<xsl:when test="$field/@repetition = '1' or not($field/@repetition)">
					<!-\- [1] nicht ausgeben -\->
				</xsl:when>
				<xsl:when test="$field/@repetition = '0'">
					<!-\- [0] Calculation -\->
					<xsl:value-of select="'['"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="calc">
							<xsl:choose>
								<xsl:when test="$field/following-sibling::Repetition/Calculation">
									<xsl:value-of select="$field/following-sibling::Repetition/Calculation"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="Repetition/Calculation"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:value-of select="']'"/>
				</xsl:when>
				<xsl:when test="$field/@name != ''">
					<!-\- [n] repetition number -\->
					<xsl:value-of select="concat('[', $field/@repetition, ']')"/>
				</xsl:when>
			</xsl:choose>-->
			<xsl:value-of select="$delimiter3"/>
		</xsl:if>
	</xsl:template>

		<!-- …[rep] -->
	<xsl:template name="OutputRepetition">
		<xsl:param name="optional_repetition_number" select="'0'"/>
		<xsl:param name="repetition_calc"/>
		<!--  -->
		<xsl:choose>
			<xsl:when test="$optional_repetition_number = '1'">
				<!-- [1] nicht ausgeben -->
			</xsl:when>
			<xsl:when test="$optional_repetition_number &gt; 0">
				<!-- [n] repetition number -->
				<xsl:value-of select="concat('[', $optional_repetition_number, ']')"/>
			</xsl:when>
			<xsl:when test="$optional_repetition_number = '0'">
				<!-- [0] -> repetition Calculation -->
				<xsl:variable name="repetition_calc_normalized" select="normalize-space($repetition_calc)"/>
				<xsl:if test="string-length($repetition_calc_normalized) &gt; 0 and $repetition_calc_normalized != '1'">
					<xsl:value-of select="'['"/>
					<xsl:call-template name="OutputCalculation">
						<xsl:with-param name="calc" select="$repetition_calc"/>
					</xsl:call-template>
					<xsl:value-of select="']'"/>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<!-- don't output illegal optional_repetition_number value -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	 ! ScriptStepParamLayoutDestination
	 !-->
	<xsl:template name="ScriptStepParamLayoutDestination">
		<xsl:variable name="destinationValue" select="LayoutDestination/@value"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="$destinationValue = 'OriginalLayout'">
				<!-- i18n dbengine_string::kScriptOriginalLayoutStrID -->
				<xsl:value-of select="'original layout'"/>
			</xsl:when>
			<xsl:when test="$destinationValue = 'CurrentLayout' or not(LayoutDestination)">
				<!-- i18n dbengine_string::kScriptCurrentLayoutStrID -->
				<xsl:value-of select="'&lt;Current Layout&gt;'"/>
			</xsl:when>
			<xsl:when test="$destinationValue = 'SelectedLayout'">
				<xsl:call-template name="QuotedStringOrUnknown">
					<xsl:with-param name="string" select="Layout/@name"/>
				</xsl:call-template>
				<xsl:if test="Layout/@name != ''">
					<xsl:value-of select="' ('"/>
					<!-- FIXME - lookup in DDR? -->
					<!--<xsl:value-of select="'…'"/>-->
					<xsl:value-of select="')'"/>
				</xsl:if>
			</xsl:when>
			<xsl:when test="$destinationValue = 'LayoutNumberByCalc'">
				<xsl:if test="$pVerbose = 'True'">
					<xsl:value-of select="'By Number'"/>
					<xsl:value-of select="$delimiter2"/>
				</xsl:if>
				<xsl:call-template name="OutputCalculation">
					<xsl:with-param name="calc" select="Layout/Calculation"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$destinationValue = 'LayoutNameByCalc'">
				<xsl:if test="$pVerbose = 'True'">
					<xsl:value-of select="'By Name'"/>
					<xsl:value-of select="$delimiter2"/>
				</xsl:if>
				<xsl:call-template name="OutputCalculation">
					<xsl:with-param name="calc" select="Layout/Calculation"/>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
		<xsl:value-of select="$delimiter3"/>
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
				<!-- i18n dbengine_string::kScriptOnStrID -->
				<xsl:value-of select="'On'"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- i18n dbengine_string::kScriptOffStrID -->
				<xsl:value-of select="'Off'"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="$delimiter3"/>
	</xsl:template>
	<!--
	 ! ScriptStepParamNoDialog
	 !-->
	<xsl:template name="ScriptStepParamNoDialog">
		<!-- i18n dbengine_string::kScriptWithDialogLabelStrID -->
		<xsl:value-of select="'With dialog'"/>
		<xsl:value-of select="$delimiter2"/>
		<xsl:choose>
			<xsl:when test="NoInteract/@state = 'True'">
				<!-- i18n dbengine_string::kScriptOffStrID -->
				<xsl:value-of select="'Off'"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- i18n dbengine_string::kScriptOnStrID -->
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
		<!-- i18n dbengine_string::kScriptPauseStrID -->
		<xsl:value-of select="'Pause'"/>
		<xsl:value-of select="$delimiter2"/>
		<xsl:choose>
			<xsl:when test="Pause/@state = 'True'">
				<!-- i18n dbengine_string::kScriptOnStrID -->
				<xsl:value-of select="'On'"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- i18n dbengine_string::kScriptOffStrID -->
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
				<!-- i18n dbengine_string::kSaveRecordsBeingBrowsedID -->
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
	<!--
	 ! ScriptStepParamScriptSpecified
	 !   for Perform Script
	 !   and Perform Script on Server
	 !-->
	<xsl:template name="ScriptStepParamScriptSpecified">
		<!-- i18n dbengine_string::kPerformByNameSelectorLabelStrID -->
		<xsl:value-of select="'Specified'"/>
		<xsl:value-of select="$delimiter2"/>
		<xsl:choose>
			<xsl:when test="Calculated/Calculation">
				<!-- i18n dbengine_string::kPerformByNameSelectByNameStrID -->
				<xsl:value-of select="'By name'"/>
				<xsl:value-of select="$delimiter3"/>
				<xsl:call-template name="OutputCalculation">
					<xsl:with-param name="calc" select="Calculated/Calculation"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<!-- i18n dbengine_string::kPerformByNameSelectSpecificStrID -->
				<xsl:value-of select="'From list'"/>
				<xsl:value-of select="$delimiter3"/>
				<xsl:call-template name="QuotedStringOrUnknown">
					<xsl:with-param name="string" select="Script/@name"/>
				</xsl:call-template>
				<xsl:if test="FileReference/@name">
					<xsl:value-of select="' '"/>
					<!-- i18n dbengine_string::kScriptFromFileStrID -->
					<xsl:value-of select="'from file'"/>
					<xsl:value-of select="$delimiter2"/>
					<xsl:value-of select="$OPENQUOTES"/>
					<xsl:value-of select="FileReference/@name"/>
					<xsl:value-of select="$CLOSEQUOTES"/>
					<xsl:if test="FileReference/@name = ''">
						<xsl:value-of select="' '"/>
						<!-- i18n dbengine_string::kScriptFileNotOpenStrID -->
						<xsl:value-of select="'(file not open)'"/>
					</xsl:if>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="$delimiter3"/>
		<!-- Parameter -->
		<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
			<!-- i18n dbengine_string::kScriptParameterLabelStrID-->
			<xsl:with-param name="optional_label" select="'Parameter'"/>
			<xsl:with-param name="calc" select="Calculation"/>
		</xsl:call-template>
		<!-- -->
	</xsl:template>
	
	
	<!--
	 ! ScriptStepParamCalculation ( optional_label, Calculation )
	 !-->
	<xsl:template name="ScriptStepParamCalculation">
		<xsl:param name="optional_label"/>
		<xsl:param name="calc" select="Calculation"/>
		<xsl:param name="default"/>
		<!--  -->
		<xsl:if test="string-length($optional_label)&gt;0">
			<xsl:value-of select="$optional_label"/>
			<xsl:value-of select="$delimiter2"/>
		</xsl:if>
		<xsl:call-template name="OutputCalculationOrDefault">
			<xsl:with-param name="calc" select="$calc"/>
			<xsl:with-param name="default" select="$default"/>
		</xsl:call-template>
		<xsl:value-of select="$delimiter3"/>
	</xsl:template>
	
	<!--
	 ! ScriptStepParamCalculationOrSpace ( optional_label, Calculation )
	 !-->
	<xsl:template name="ScriptStepParamCalculationOrSpace">
		<xsl:param name="optional_label"/>
		<!--  -->
		<xsl:call-template name="OutputCalculationOrDefault">
			<xsl:with-param name="optional_label" select="$optional_label"/>
			<xsl:with-param name="calc" select="Calculation"/>
			<xsl:with-param name="default" select="' '"/>
		</xsl:call-template>
		<xsl:value-of select="$delimiter3"/>
	</xsl:template>
	
	<!--
	 ! ScriptStepParamCalculationOrTwoSpaces ( optional_label, Calculation )
	 !-->
	<xsl:template name="ScriptStepParamCalculationOrTwoSpaces">
		<xsl:param name="optional_label"/>
		<xsl:param name="calc"/>
		<!--  -->
		<xsl:if test="string-length($optional_label)&gt;0">
			<xsl:value-of select="$optional_label"/>
				<xsl:value-of select="$delimiter2"/>
			</xsl:if>
		<xsl:call-template name="OutputCalculationOrTwoSpaces">
			<xsl:with-param name="calc" select="$calc"/>
		</xsl:call-template>
		<xsl:value-of select="$delimiter3"/>
	</xsl:template>
	
	<!--
	 ! ScriptStepParamCallbackScriptSpecified
	 !   for Perform Script on Server with Callback
	 !   …since it does not (yet) support script-by-name
	 !-->
	 <xsl:template name="ScriptStepParamCallbackScriptSpecified">
		<!-- -->
		<xsl:if test="Script">
			<!-- Script -->
			<!-- i18n dbengine_string::kScriptStrID -->
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
					<xsl:value-of select="' '"/>
					<!-- i18n dbengine_string::kScriptFileNotOpenStrID -->
					<xsl:value-of select="'(file not open)'"/>
				</xsl:if>
			</xsl:if>
			<xsl:value-of select="$delimiter3"/>
		</xsl:if>
		<xsl:if test="Calculation">
			<!-- Script Parameter -->

			<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
				<!-- i18n dbengine_string::kScriptParameterStrID -->
				<xsl:with-param name="optional_label" select="'Parameter'"/>
				<xsl:with-param name="calc" select="Calculation"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="CallbackScript">
			<!-- Script -->
			<!-- i18n dbengine_string::kPSOSWithCallbackScriptNameStrID -->
			<xsl:value-of select="'Callback script'"/>
			<xsl:value-of select="$delimiter2"/>
			<xsl:call-template name="QuotedStringOrUnknown">
				<xsl:with-param name="string" select="CallbackScript/ScriptName/@name"/>
			</xsl:call-template>
			<xsl:if test="CallbackScript/FileReference/@name">
				<!-- CallbackScript File Reference -->
				<xsl:value-of select="' '"/>
				<!-- i18n dbengine_string::kScriptFromFileStrID -->
				<xsl:value-of select="'from file'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:value-of select="$OPENQUOTES"/>
				<xsl:value-of select="CallbackScript/FileReference/@name"/>
				<xsl:value-of select="$CLOSEQUOTES"/>
				<xsl:if test="CallbackScript/FileReference/@name = ''">
					<xsl:value-of select="' '"/>
					<!-- i18n dbengine_string::kScriptFileNotOpenStrID -->
					<xsl:value-of select="'(file not open)'"/>
				</xsl:if>
			</xsl:if>
			<xsl:value-of select="$delimiter3"/>
			<xsl:if test="CallbackScript/ScriptParameter">
				<!-- CallbackScript Parameter -->

				<xsl:call-template name="ScriptStepParamCalculationOrTwoSpaces">
					<!-- i18n dbengine_string::kScriptParameterStrID -->
					<xsl:with-param name="optional_label" select="'Parameter'"/>
					<xsl:with-param name="calc" select="CallbackScript/ScriptParameter/Calculation"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:if>
		<!-- -->
	</xsl:template>
	<!-- -->
	<xsl:template name="ScriptStepParamSelect">
		<!--xsl:param name="delimiter3"/-->
		<xsl:if test="SelectAll/@state = 'True'">
			<!-- i18n dbengine_string::kScriptSelectStrID -->
			<xsl:value-of select="'Select'"/>
			<xsl:value-of select="$delimiter3"/>
		</xsl:if>
	</xsl:template>
	<!--
	 ! ScriptStepParamSelectWindow
	 !-->
	<xsl:template name="ScriptStepParamSelectWindow">
		<xsl:param name="label" select="'Name'"/>
		<!--  -->
		<xsl:choose>
			<xsl:when test="Window/@value = 'Current'">
				<xsl:value-of select="'Current Window'"/>
				<xsl:value-of select="$delimiter3"/>
				<!-- -->
			</xsl:when>
			<xsl:when test="Window/@value = 'ByName'">
				<xsl:value-of select="$label"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:call-template name="OutputCalculation">
					<xsl:with-param name="calc" select="Name/Calculation"/>
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
		<xsl:param name="default" select="''"/>
		<!--  -->
		<xsl:choose>
			<xsl:when test="UniversalPathList/text()">
				<xsl:call-template name="UniversalPathListFileName"/>
				<xsl:value-of select="$delimiter3"/>
			</xsl:when>
			<xsl:when test="string-length( $default ) &gt; 0">
				<xsl:value-of select="$default"/>
				<xsl:value-of select="$delimiter3"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--
	 ! ScriptStepParamSpecifyOutputFile
	 !
	 ! In FM 17 the SaveAsType attribute has moved into this block 
	 !-->
	<xsl:template name="ScriptStepParamSpecifyOutputFile">
		<xsl:param name="saveAsType" select="''"/>
		<!--  -->
		<xsl:call-template name="ScriptStepParamSpecifyFile"/>
		<xsl:if test="$saveAsType">
			<xsl:choose>
				<xsl:when test="$saveAsType/@value = 'Clone'">
					<xsl:value-of select="'clone (no records)'"/>
				</xsl:when>
				<xsl:when test="$saveAsType/@value = 'CompactedCopy'">
					<xsl:value-of select="'compacted copy (smaller)'"/>
				</xsl:when>
				<xsl:when test="$saveAsType/@value = 'Copy'">
					<xsl:value-of select="'copy of current file'"/>
				</xsl:when>
				<xsl:when test="$saveAsType/@value = 'SelfContainedCopy'">
					<xsl:value-of select="'self-contained copy (single file)'"/>
				</xsl:when>
			</xsl:choose>
			<xsl:value-of select="$delimiter3"/>
		</xsl:if>
		<xsl:if test="AutoOpen/@state = 'True'">
			<!-- i18n dbengine_string::kScriptOpenAutomaticallyStrID -->
			<xsl:value-of select="'Automatically open'"/>
			<xsl:value-of select="$delimiter3"/>
		</xsl:if>
		<!-- -->
		<xsl:if test="CreateEmail/@state = 'True'">
			<!-- i18n dbengine_string::kScriptCreateEmailStrID -->
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
		<!-- -->
		<xsl:call-template name="OutputScriptStepParamTrueOnOff">
			<!-- i18n dbengine_string::kCreateDirectoryStrID -->
			<xsl:with-param name="label" select="'Create folders'"/>
			<xsl:with-param name="value" select="CreateDirectories/@state"/>
		</xsl:call-template>
	</xsl:template>
	<!--
	 ! ScriptStepParamRepetition
	 !-->
	<xsl:template name="ScriptStepParamRepetition">
		<xsl:param name="repetition" select="Field/@repetition"/>
		<!---->
		<xsl:choose>
			<xsl:when test="$repetition = 1 or number(Repetition/Calculation) = 1">
				<!-- [1] don't output -->
				<!-- i18n dbengine_string::kScriptOptionObjectRepetitionStrID -->
				<xsl:value-of select="'Repetition'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:value-of select="'1'"/>
			</xsl:when>
			<xsl:when test="$repetition &gt; 0">
				<!-- [2+] output -->
				<!-- i18n dbengine_string::kScriptOptionObjectRepetitionStrID -->
				<xsl:value-of select="'Repetition'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:value-of select="$repetition"/>
			</xsl:when>
			<xsl:when test="Repetition/Calculation">
				<!-- [1+1] Calculation -->
				<!-- i18n dbengine_string::kScriptOptionObjectRepetitionStrID -->
				<xsl:value-of select="'Repetition'"/>
				<xsl:value-of select="$delimiter2"/>
				<xsl:call-template name="OutputCalculation">
					<xsl:with-param name="calc" select="Repetition/Calculation"/>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
		<xsl:value-of select="$delimiter3"/>
	</xsl:template>
	<!--
	 ! ScriptStepParamRestore
	 !-->
	<xsl:template name="ScriptStepParamRestore">
		<xsl:if test="Restore/@state = 'True'">
			<!-- i18n dbengine_string::kScriptRestoreStrID -->
			<xsl:value-of select="'Restore'"/>
			<xsl:value-of select="$delimiter3"/>
		</xsl:if>
	</xsl:template>
	<!--
	 ! ScriptStepParamUniversalPathListReference
	 !-->
	<xsl:template name="ScriptStepParamUniversalPathListReference">
		<!---->
		<xsl:if test="UniversalPathList/@type = 'Reference'">
			<!-- i18n dbengine_string::kScriptReferenceStrID -->
			<xsl:value-of select="'Reference'"/>
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
			<!-- i18n dbengine_string::kScriptOptionVerifySSLCertificatesStrID -->
			<xsl:value-of select="'Verify SSL Certificates'"/>
			<xsl:value-of select="$delimiter3"/>
		</xsl:if>
	</xsl:template>
	<!--
	 ! ScriptStepPassword
	 !-->
	<xsl:template name="ScriptStepPassword">
		<xsl:param name="password"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="$pScriptStepHidePasswords = 'True'">
				<xsl:value-of select="'••••••••'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="OutputCalculation">
					<xsl:with-param name="calc" select="$password/Calculation"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	 ! OutputTrueAsOnElseOff: True/False -> On/Off
	 !-->
	<xsl:template name="OutputTrueAsOnElseOff">
		<xsl:param name="state"/>
		<!---->
		<xsl:choose>
			<xsl:when test="$state = 'True'">
				<!-- i18n dbengine_string::kScriptOnStrID -->
				<xsl:value-of select="'On'"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- i18n dbengine_string::kScriptOffStrID -->
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
				<!-- i18n dbengine_string::kScriptOffStrID -->
				<xsl:value-of select="'Off'"/>
			</xsl:when>
			<xsl:when test="$value = 'Show'">
				<!-- i18n dbengine_string::kScriptOnStrID -->
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
					<xsl:with-param name="calc" select="Profile/XSLCalc/Calculation"/>
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
		<xsl:call-template name="OutputTrueAsOnElseOff">
			<xsl:with-param name="state" select="$state"/>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
