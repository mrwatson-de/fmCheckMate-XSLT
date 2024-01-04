<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMSS_XMSS_ConvertSetVarToJsonSetElementToVariable.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied scripts or script-steps
	
	Converts
	
	  Set Var [ $X ; Value1 ]
	  Set Var [ $Y ; Value2 ]
	
	into
	
	  Set Var [ $JSON ; JSONSetElement ( "{}" ;
	    ["X" ; $X ; JSONString] ;
		["Y" ; $Y ; JSONString]
		) ]

	===== CHANGES HISTORY =====
	2021-09-23 MrW: New
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="EOL" select="$CR"/>
	<!-- ===== TEMPLATES ===== -->
	<!--
	 ! Convert Set Variable to Set Field
	 !-->
	<xsl:template match="/fmxmlsnippet">
		<xsl:variable name="targetVarName" select="'$JSON'"/>
		<!-- -->
		<xsl:variable name="lines">
			<xsl:for-each select="Step[@id='141' and @enable='True']">
				<!-- convert to a JSON Replace -->
				<xsl:variable name="varName" select="Name"/>
				<xsl:variable name="jsonKey" select="translate($varName,'$','')"/>
				<xsl:variable name="line" select="concat('[&quot;',$jsonKey,'&quot;',' ; ',$varName,' ; JSONString]')"/>
				<!-- -->
				<xsl:value-of select="$line"/>
				<xsl:if test="position()!=last()">
					<xsl:value-of select="' ;'"/>
				</xsl:if>
				<xsl:value-of select="$EOL"/>
			</xsl:for-each>
		</xsl:variable>
		<!--
		! Output Set Variable
		!-->
		<fmxmlsnippet type="FMObjectList">
			<Step enable="True" id="141">
				<Value>
					<Calculation>
						<xsl:value-of select="concat('JSONSetElement ( &quot;{}&quot; ;',$EOL,$lines,')')"/>
					</Calculation>
				</Value>
				<Repetition>
					<Calculation>
						<xsl:text>1</xsl:text>
					</Calculation>
				</Repetition>
				<Name>
					<xsl:copy-of select="$targetVarName"/>
				</Name>
			</Step>
		</fmxmlsnippet>
	</xsl:template>
</xsl:stylesheet>
