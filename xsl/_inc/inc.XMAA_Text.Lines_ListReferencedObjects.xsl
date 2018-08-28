<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: inc.XMAA_Text.Lines_ListReferencedObjects.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: any FileMaker Clipboard content
	
	Returns a list of all referenced objects
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2013-2018
	2018-06-20 MrW: Version 1.1.1 Fixed broken stylesheet
	2013-09-13 MrW: Version 1.1 Creates unique list, with or without headings
	2013-09-07 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.StringFunctions.xsl"/>
	<!-- ===== PARAMETERS ===== -->
	<!-- <xsl:param name="withHeadings" select="'True'"/> -->
	<!-- <xsl:param name="withCustomFunctions" select="'True'"/> -->
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<xsl:variable name="commentPrefix" select="'//'"/>
	<!--  -->
	<!-- IMPORTANT: the Custom Functions MUST already be stored in fmxmlsnippet1.xml!!! -->
	<xsl:variable name="cfNamesList">
		<xsl:if test="$withCustomFunctions='True'">
			<!--<xsl:for-each select="document(FIXME)//CustomFunction">
				<xsl:sort select="string-length(@name)" order="descending" data-type="number"/>
				<xsl:value-of select="@name"/>
				<xsl:if test="@parameters!=''">
					<xsl:value-of select="'('"/>
				</xsl:if>
				<xsl:value-of select="$newrecord"/>
			</xsl:for-each>-->
		</xsl:if>
	</xsl:variable>
	<!-- Keys -->
	<xsl:key name="TablesReferencedByID" match="//Table[@id]" use="@id"/>
	<xsl:key name="referencedTablenames" match="//@table" use="."/>
	<xsl:key name="referencedFieldsByName" match="//Field" use="concat(@table,'::',@name)"/>
	<xsl:key name="referencedLayoutsByExternalAndName" match="//Layout" use="concat(../Option/@state='True',@name)"/>
	<xsl:key name="referencedScriptsByFileRefAndName" match="//Step/Script" use="concat(../FileReference/@name,substring('#',1,string-length(../FileReference/@name)),@name)"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/">
		<!-- =========================
		 ! Direct references (by ID)
		 !===========================
		 !-->
		<xsl:if test="//Table[@id]">
			<!-- Tables referenced by ID-->
			<xsl:if test="$withHeadings='True'">
				<xsl:value-of select="$commentPrefix"/>
				<xsl:value-of select="'Tables referenced by ID (e.g.: GRR - see also tables referenced in calculations below):'"/>
				<xsl:value-of select="$newrecord"/>
			</xsl:if>
			<xsl:for-each select="//Table[@id and count(.|key('TablesReferencedByID',@id)[1])=1]">
				<xsl:sort select="@id"/>
				<!--  -->
				<xsl:value-of select="'table:'"/>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="@id"/>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="@name"/>
				<xsl:value-of select="$newrecord"/>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="//@table">
			<!-- Tables referenced -->
			<xsl:if test="$withHeadings='True'">
				<xsl:value-of select="$commentPrefix"/>
				<xsl:value-of select="'Tables referenced directly (e.g. Set field - see also tables referenced in calculations below):'"/>
				<xsl:value-of select="$newrecord"/>
			</xsl:if>
			<xsl:for-each select="//@table[count(.|key('referencedTablenames',.)[1])=1]">
				<xsl:sort select="."/>
				<!--  -->
				<xsl:value-of select="'table:'"/>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="."/>
				<xsl:value-of select="$newrecord"/>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="//Field[not(ancestor::Step/@id='35')]">
			<!-- Fields referenced (excluding ImportRecords????) -->
			<xsl:if test="$withHeadings='True'">
				<xsl:value-of select="$commentPrefix"/>
				<xsl:value-of select="'Fields referenced directly - *excluding* ImportRecords! (see also fields referenced in calculations below):'"/>
				<xsl:value-of select="$newrecord"/>
			</xsl:if>
			<xsl:for-each select="//Field[not(ancestor::Step/@id='35') and count(.|key('referencedFieldsByName',concat(@table,'::',@name))[1])=1]">
				<xsl:sort select="concat(@table,'::',@name)"/>
				<!--  -->
				<xsl:value-of select="'field:'"/>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="@id"/>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="@table"/>
				<xsl:value-of select="'::'"/>
				<xsl:value-of select="@name"/>
				<xsl:value-of select="$newrecord"/>
			</xsl:for-each>
		</xsl:if>
		<!-- =============================
		 ! References in calculations 
		 !===============================
		 !-->
		<xsl:variable name="calculations">
			<xsl:for-each select="//Calculation">
				<xsl:value-of select="text()"/>
				<xsl:value-of select="';'"/>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="calculationsNormalized">
			<xsl:call-template name="fn.Substitute">
				<xsl:with-param name="text" select="normalize-space($calculations)"/>
				<xsl:with-param name="searchString" select="' ('"/>
				<xsl:with-param name="replaceString" select="'()'"/>
			</xsl:call-template>
		</xsl:variable>
		<!-- Custom Functions used in calculations -->
		<xsl:variable name="CFsInCalculations">
			<xsl:if test="$withCustomFunctions='True'">
				<xsl:call-template name="ListCustomFunctionsInText">
					<xsl:with-param name="text" select="$calculationsNormalized"/>
					<xsl:with-param name="searchList" select="$cfNamesList"/>
					<xsl:with-param name="result" select="''"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:variable>
		<!-- Field references in calculations -->
		<xsl:variable name="calculationsForFieldSearch">
			<xsl:call-template name="fn.SubstituteMultiple">
				<xsl:with-param name="text" select="concat(';',translate($calculationsNormalized,'&amp;()[]{}+-*/^=≠&lt;&gt;≤≥$',';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;'),';')"/>
				<xsl:with-param name="substitutions" select="' and |;| or |;| not |;| xor |;| ;|;|; |;'"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="fieldsInCalculations">
			<xsl:call-template name="ListFieldsInText">
				<xsl:with-param name="text" select="$calculationsForFieldSearch"/>
				<xsl:with-param name="result" select="''"/>
			</xsl:call-template>
		</xsl:variable>
		<!--  -->
		<xsl:if test="$fieldsInCalculations!=''">
			<xsl:if test="$withHeadings='True'">
				<xsl:value-of select="$commentPrefix"/>
				<xsl:value-of select="'Fields referenced by name in calculations:'"/>
				<xsl:value-of select="$newrecord"/>
			</xsl:if>
			<xsl:value-of select="$fieldsInCalculations"/>
		</xsl:if>
		<xsl:if test="$withCustomFunctions='True'">
			<xsl:if test="$CFsInCalculations!=''">
				<xsl:if test="$withHeadings='True'">
					<xsl:value-of select="$commentPrefix"/>
					<xsl:value-of select="'Custom Functions referenced by name in calculations:'"/>
					<xsl:value-of select="$newrecord"/>
				</xsl:if>
				<xsl:value-of select="$CFsInCalculations"/>
			</xsl:if>
		</xsl:if>
		<!-- Used Layouts -->
		<xsl:if test="//Step//Layout">
			<xsl:if test="$withHeadings='True'">
				<xsl:value-of select="$commentPrefix"/>
				<xsl:value-of select="'Layouts used:'"/>
				<xsl:value-of select="$newrecord"/>
			</xsl:if>
			<xsl:for-each select="//Step//Layout[count(.|key('referencedLayoutsByExternalAndName',concat(../Option/@state='True',@name))[1])=1]">
				<xsl:sort select="concat(../Option/@state='True',@name)"/>
				<!--  -->
				<xsl:value-of select="'layout:'"/>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="@id"/>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="concat(substring('ExtFileRef#',1 div (../Option/@state='True')),@name)"/>
				<xsl:value-of select="$newrecord"/>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="//Step//Script">
			<!-- Called Scripts -->
			<xsl:if test="$withHeadings='True'">
				<xsl:value-of select="$commentPrefix"/>
				<xsl:value-of select="'Scripts called:'"/>
				<xsl:value-of select="$newrecord"/>
			</xsl:if>
			<xsl:for-each select="//Step//Script[count(.|key('referencedScriptsByFileRefAndName',concat(../FileReference/@name,substring('#',1,string-length(../FileReference/@name)),@name))[1])=1]">
				<xsl:sort select="concat(../FileReference/@name,'#',@name)"/>
				<!--  -->
				<xsl:value-of select="'script:'"/>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="@id"/>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="concat(../FileReference/@name,substring('#',1,string-length(../FileReference/@name)),@name)"/>
				<xsl:value-of select="$newrecord"/>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>
	<!-- ListCustomFunctionsInText -->
	<xsl:template name="ListCustomFunctionsInText">
		<xsl:param name="text"/>
		<xsl:param name="searchList"/>
		<xsl:param name="result"/>
		<!--  -->
		<xsl:variable name="searchExpression" select="substring-before($searchList,$newrecord)"/>
		<xsl:choose>
			<xsl:when test="not(contains($searchList,$newrecord))">
				<!-- Finished -->
				<xsl:value-of select="$result"/>
			</xsl:when>
			<xsl:when test="contains($text,$searchExpression)">
				<!-- partial result -->
				<xsl:variable name="partialResult">
					<xsl:value-of select="'cf:'"/>
					<xsl:value-of select="$delimiter"/>
					<xsl:value-of select="$delimiter"/>
					<xsl:value-of select="$searchExpression"/>
					<xsl:value-of select="$newrecord"/>
				</xsl:variable>
				<!-- Recurse -->
				<xsl:call-template name="ListCustomFunctionsInText">
					<!-- text with the searchExpression removed -->
					<xsl:with-param name="text">
						<xsl:call-template name="fn.Substitute">
							<xsl:with-param name="text" select="$text"/>
							<xsl:with-param name="searchString" select="$searchExpression"/>
							<xsl:with-param name="replaceString" select="''"/>
						</xsl:call-template>
					</xsl:with-param>
					<!-- rest of the searchList -->
					<xsl:with-param name="searchList" select="substring-after($searchList,$newrecord)"/>
					<!-- result with searchExpression added -->
					<xsl:with-param name="result" select="concat($result,$partialResult)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<!-- Recurse -->
				<xsl:call-template name="ListCustomFunctionsInText">
					<!-- text unchanged -->
					<xsl:with-param name="text" select="$text"/>
					<!-- rest of the searchList -->
					<xsl:with-param name="searchList" select="substring-after($searchList,$newrecord)"/>
					<!-- result unchanged -->
					<xsl:with-param name="result" select="$result"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ListFieldsInText -->
	<xsl:template name="ListFieldsInText">
		<xsl:param name="text"/>
		<xsl:param name="result"/>
		<!--  -->
		<xsl:choose>
			<xsl:when test="not(contains($text,'::'))">
				<!-- Finished -->
				<xsl:value-of select="$result"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- Identify the bits FIXME DEPENDENCY ENGLISH -->
				<xsl:variable name="tablename">
					<xsl:call-template name="fn.substring-after-last">
						<xsl:with-param name="text" select="substring-before($text,'::')"/>
						<xsl:with-param name="searchString" select="';'"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="fieldname" select="normalize-space(substring-before(substring-after($text,'::'),';'))"/>
				<xsl:variable name="searchExpression" select="concat($tablename,'::',$fieldname)"/>
				<!-- partial result -->
				<xsl:variable name="partialResult">
					<xsl:value-of select="'field:'"/>
					<xsl:value-of select="$delimiter"/>
					<xsl:value-of select="$delimiter"/>
					<xsl:value-of select="$searchExpression"/>
					<xsl:value-of select="$newrecord"/>
				</xsl:variable>
				<!-- Recurse -->
				<xsl:call-template name="ListFieldsInText">
					<!-- text with the searchExpression removed -->
					<xsl:with-param name="text">
						<xsl:call-template name="fn.Substitute">
							<xsl:with-param name="text" select="substring-after($text,$searchExpression)"/>
							<xsl:with-param name="searchString" select="$searchExpression"/>
							<xsl:with-param name="replaceString" select="''"/>
						</xsl:call-template>
					</xsl:with-param>
					<!-- result with searchExpression added -->
					<xsl:with-param name="result" select="concat($result,$partialResult)"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
