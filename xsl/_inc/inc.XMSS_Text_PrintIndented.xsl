<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: inc.XMSS_Text_PrintIndented.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps

	Include file to list script steps in text form similar to FileMaker ScriptMaker.

	===== CHANGES HISTORY =====
	2023-02-27 MrW: Step 175 `Perform JavaScript in Web Viewer` and 96 `Save a Copy as Add-on Package` are no longer OBSOLETE
	2017-05-22 MrW: Corrected the parameter list to deal with faulty delimiters [pSIC]
	2013-09-07 MrW: Added formatting parameters: pShowLineNumbers, pLineNumbers, pIndentGroups, 
	    pIndentScripts, pIndentScriptSteps, pIndentString, pIndentLevel, pScriptGroupPathDelimiter, 
	    pScriptGroupNamePrefix, pScriptGroupNameSuffix, pScriptNamePrefix, pScriptNameSuffix, 
	    pShowScriptIDs, pScriptIDPrefix, pScriptIDSuffix, (TODO: NAMING P OR NOT P )
	2013-09-05 MrW: Refactored out of XMSS_Text.Lines_ListIndented.xsl
	-->
	<!-- ===== HEAD ===== -->
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XMSS_Text_PrintSteps.xsl"/>
	<!--
	 !===== inc.XMSS_Text.Lines_ListIndented INTERFACE PARAMETERS =====
	 !-->
	<!-- The following parameters MUST be implemented in the including XSLT. -->
	<!--
	<xsl:param name="pShowLineNumbers" select="'True'"/>
	<xsl:param name="pShowScriptIDs" select="'True'"/>
	<xsl:param name="pIndentGroups" select="'False'"/>
	<xsl:param name="pIndentScripts" select="'False'"/>
	<xsl:param name="pIndentScriptSteps" select="'True'"/>
	...
	-->
	<!--
	 !===== inc.XMSS_Text.List TEMPLATES =====
	 !-->
	<!--
	 ! ScriptGroups
	 !-->
	<!-- ScriptGroupSTART -->
	<xsl:template name="ScriptGroupSTART">
		<xsl:if test="$pShowLineNumbers='True'">
			<xsl:value-of select="'====:='"/>
			<xsl:value-of select="$TAB"/>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="$pIndentGroups='True'">
				<xsl:call-template name="ScriptStepAutoIndent"/>
				<xsl:value-of select="$pScriptGroupNamePrefix"/>
				<xsl:value-of select="@name"/>
				<xsl:value-of select="$pScriptGroupNameSuffix"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- If not indenting at least show the complete path -->
				<xsl:value-of select="$pScriptGroupNamePrefix"/>
				<xsl:for-each select="ancestor-or-self::Group">
					<xsl:if test="position()!=1">
						<xsl:value-of select="$pScriptGroupPathDelimiter"/>
					</xsl:if>
					<xsl:value-of select="@name"/>
				</xsl:for-each>
				<xsl:value-of select="$pScriptGroupNameSuffix"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="$pShowScriptIDs='True'">
			<xsl:value-of select="' {'"/>
			<xsl:value-of select="@id"/>
			<xsl:value-of select="'}'"/>
		</xsl:if>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- ScriptGroupEND -->
	<xsl:template name="ScriptGroupEND">
		<!--  -->
	</xsl:template>
	<!-- ScriptSTART -->
	<xsl:template name="ScriptSTART">
		<xsl:if test="$pShowLineNumbers='True'">
			<xsl:value-of select="'======'"/>
			<xsl:value-of select="$TAB"/>
		</xsl:if>
		<xsl:call-template name="ScriptStepAutoIndent"/>
		<xsl:variable name="ScriptBarLength" select="69"/>
		<xsl:variable name="ScriptName">
			<xsl:value-of select="$pScriptNamePrefix"/>
			<xsl:value-of select="@name"/>
			<xsl:value-of select="$pScriptNameSuffix"/>
			<xsl:if test="$pShowScriptIDs='True'">
				<xsl:value-of select="$pScriptIDPrefix"/>
				<xsl:value-of select="@id"/>
				<xsl:value-of select="$pScriptIDSuffix"/>
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat( substring(concat($ScriptName,' ====================================================================================================================================' ), 1, $ScriptBarLength),substring($ScriptName,$ScriptBarLength+1))"/>
		<!--xsl:text>Script </xsl:text-->
		<!--xsl:value-of select="concat($QUOT,@name,$QUOT)"/-->
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<xsl:template name="ScriptEND">
		<!--  -->
	</xsl:template>
	<!-- ScriptStepSTART -->
	<xsl:template name="ScriptStepSTART">
		<xsl:param name="obsolete"/>
		<!-- -->
		<xsl:call-template name="ScriptStepLineNumber"/>
		<xsl:call-template name="ScriptStepAutoIndent"/>
		<xsl:call-template name="ScriptStepDisable"/>
		<xsl:call-template name="ScriptStepName"/>
	</xsl:template>
	<!-- ===== TEMPLATES ===== -->
	<xsl:template name="ScriptStepName">
		<xsl:variable name="obsolete">
			<!-- OBSOLETE:
			 ! 59 Insert QuickTime
			 ! 78 Insert Object
			 ! 153 <unknown>
			 ! 162 Open from Test Server
			 ! 163 Sign Out from Test Server
			 ! 170 Upload to Test Server
			 ! 171 Manage Test Server
			 ! 176 Set Allowed Orientations
			 !-->
			<xsl:if test="@id=59 or @id=78 or @id=153 or @id=162 or @id=163 or @id=170 or @id=171 or @id=176">
				<xsl:value-of select="'OBSOLETE'"/>
			</xsl:if>
		</xsl:variable>
		<!-- -->
		<xsl:choose>
			<xsl:when test="@id=89 and Text">
				<!-- Comment with text -->
				<xsl:value-of select="'#'"/>
			</xsl:when>
			<xsl:when test="@id=89">
				<!-- Comment empty line -->
				<xsl:value-of select="''"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="$obsolete='OBSOLETE'">
					<!-- Obsolete step -->
					<xsl:value-of select="'#[OBSOLETE]  '"/>
				</xsl:if>
				<xsl:value-of select="@name"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ===== TEMPLATES ===== -->
	<xsl:template name="ScriptStepDisable">
		<xsl:if test="@enable='False'">
			<xsl:value-of select="'// '"/>
		</xsl:if>
	</xsl:template>
	<!-- ScriptStepLineNumber -->
	<xsl:template name="ScriptStepLineNumber">
		<xsl:if test="$pShowLineNumbers='True'">
			<xsl:variable name="n" select="1+count(preceding-sibling::Step)"/>
			<xsl:variable name="l" select="string-length($n)"/>
			<xsl:value-of select="substring('     ',1,5-$l)"/>
			<xsl:value-of select="count(preceding-sibling::Step)+1"/>
			<xsl:value-of select="' '"/>
			<xsl:value-of select="$TAB"/>
		</xsl:if>
	</xsl:template>
	<!-- 
	 ! ScriptStepParameterList 
	 !
	 !   Given a raw, incorrectly formatted parameter list "Param1; Param2; ... ParamN; " 
	 !   outputs the correctly formatted parameter list "[ Param1; Param2; ... ParamN ]" 
	 !   by adding square-brackets and removing the final delimiter.
	 !
	 !   Needs template fn.RemoveFinalDelimiterFromTextList
	 !-->
	<xsl:template name="ScriptStepParameterList">
		<xsl:param name="pParameterList"/>
		<!---->
		<xsl:variable name="params">
			<xsl:choose>
				<xsl:when test="$pSIC='True' and $delimiter3=' ; '">
					<!-- SIC mode => delimiter can also be missing a SPACE -->
					<xsl:call-template name="fn.RemoveFinalDelimiterFromTextList">
						<xsl:with-param name="pTextList">
							<xsl:call-template name="fn.RemoveFinalDelimiterFromTextList">
								<xsl:with-param name="pTextList" select="$pParameterList"/>
								<!-- first remove the normal delimiter -->
								<xsl:with-param name="pDelimiter" select="$delimiter3"/>
							</xsl:call-template>
						</xsl:with-param>
						<!-- Then try removing the faulty delimiter -->
						<xsl:with-param name="pDelimiter" select="'; '"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="fn.RemoveFinalDelimiterFromTextList">
						<xsl:with-param name="pTextList" select="$pParameterList"/>
						<xsl:with-param name="pDelimiter" select="$delimiter3"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$params!=''">
				<xsl:value-of select="$delimiter1"/>
				<xsl:value-of select="$params"/>
				<xsl:value-of select="$delimiter4"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$delimiter14"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ScriptStepEND -->
	<xsl:template name="ScriptStepEND">
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- ScriptStepSTARTEND
	 ! (Shortcut called from script steps that have no parameters)
	 !-->
	<xsl:template name="ScriptStepSTARTEND">
		<xsl:param name="obsolete"/>
		<!-- -->
		<xsl:call-template name="ScriptStepSTART">
			<xsl:with-param name="obsolete" select="$obsolete"/>
		</xsl:call-template>
		<!--  -->
		<xsl:call-template name="ScriptStepEND"/>
	</xsl:template>
	<!-- ============================================================================= -->
	<!-- 
	 ! automatic indentation
	 !-->
	<xsl:template name="ScriptStepAutoIndent">
		<xsl:call-template name="indent">
			<!-- Count depth = SUM:ancestor Groups + SUM:parent Script + SUM:previous Ifs + SUM:previous Loops - SUM:previous End ifs - SUM:previous end loops - else - end if - else if - end loop -->
			<xsl:with-param name="depth" select="($pIndentGroups='True')*count(ancestor::Group) + ($pIndentScripts='True')*count(parent::Script) + ($pIndentScriptSteps='True')*(count(preceding-sibling::Step[@id=$ID_IF or @id=$ID_LOOP]) - count(preceding-sibling::Step[@id=$ID_END_IF or @id=$ID_END_LOOP]) - (@id=$ID_ELSE) - (@id=$ID_ELSE_IF) - (@id=$ID_END_IF) - (@id=$ID_END_LOOP))"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="indent">
		<xsl:param name="depth"/>
		<!--  -->
		<xsl:if test="$depth &gt; 0">
			<xsl:value-of select="$pIndentString"/>
			<xsl:call-template name="indent">
				<xsl:with-param name="depth" select="$depth - 1"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
