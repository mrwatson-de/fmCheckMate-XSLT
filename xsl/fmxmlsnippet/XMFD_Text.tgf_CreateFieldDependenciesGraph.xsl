<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMFD_Text.tgf_CreateFieldDependenciesGraph.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied field or table definitions
	
	Creates a directed graph of field references in trivial graph format.
	
	- Nodes are fields.
	- Edge arrows show the trigger direction.
	
	Thus if field A = B an edge will be shown B -> A

	##Known issues:
	
	- If you are analysing JUST fields and no base tables a reference to the current table will be considered as a reference to a related table.

	##Processing the results of this XSLT
	
	I recommend using the free Editor yEd, available from http://www.yworks.com
	
	1. Save the results as Clipboard.tgf (CMD+Shift+S from the fmCheckMate text result view)
	2. Open Clipboard.tgf -> yEd should open and display a pile of nodes in the middle of the window
	3. Select Menu Layout > Hierarchical, set the desired settings and press OK
	   -  General > Orientation = Left-to-Right
	   -  Layers > hierarchic
	   -  etc.
	   -  See screenshots for more
	4. You can use Tools > Select Elements to select nodes and improve the graph, e.g.
	   -  Tools > Select Elements > Nodes > with Degree min 0 max 0
	      - General Options = DON'T Act on current selection only, DON'T Inverse Selection, DO Clear Selection first
	      … and delete them.


	===== CHANGES HISTORY =====
	2016-12-15 MrW: Technique vastly improved to avoid false links to fields whose names are a substring of other fields
	                The trick is to work through the fields in descending order of name length,
	                removing references as you go -> this avoids ever referring to a substring of a fieldname :-)
	2016-05-19 MrW: Node name logic refactored into include file.
	2016-05-11 MrW: WOW! Greatly improved // field name match now includes word-bounds :-) // references AND modified-triggers // labels improved with clearer markers and a prefix was added to ids so that we can (later) distinguish between field-ids (F###) and relationship-ids (R###)
	2011-11-17 MrW: Started ... but with what hope?
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.StringFunctions.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Graph_functions.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.XMFD_Text.tgf_FieldDependenciesGraph.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="baseTableName" select="/*/BaseTable/@name"/>
	<!-- ===== KEYS ===== -->
	<xsl:key name="keyFieldIdFromName" match="//Field[not(ancestor::Field)]/@id" use="../@name"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Match all fields  -->
	<xsl:template match="/">
		<xsl:if test="$baseTableName != ''">
			<xsl:value-of select="'T1 '"/>
			<xsl:value-of select="$baseTableName"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:if>
		<!--
		 ! 1. Output fields as nodes
		 !
		 ! The tgf format is:
		 !     node-id<space>node-label
		 !
		 ! for the node-id we use 
		 !     F<field-id>
		 ! and for the node-label:
		 !     field-name (<field-type><storage-type>)
		 !-->
		<xsl:for-each select="//Field[not(ancestor::Field)]">
			<xsl:value-of select="'F'"/>
			<xsl:value-of select="@id"/>
			<xsl:value-of select="' '"/>
			<xsl:call-template name="FieldGraphNodeName"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:for-each>
		<!-- 
		 ! 2. Output tgf delimiter which separates the nodes from the edges
		 ! a pound sign on a separate line
		-->
		<xsl:value-of select="'#'"/>
		<xsl:value-of select="$newrecord"/>
		<!--
		 ! 3. Output field references as _directed_ edges:
		 !
		 !   referenced field -> referencing field
		 !
		 ! The tgf format is:
		 !
		 !    node-id<space>node-id
		 !
		-->
		<!-- 
		FIXME
		
		Calculation
		AutoEnter[@calculation='True']/Calculation
		AutoEnter[@lookup='True']/Lookup/Field/@table // TO name
		
		-->
		<xsl:call-template name="constructEdges">
			<!--
			 ! the list of target fields
			 !-->
			<xsl:with-param name="fieldNames">
				<xsl:for-each select="//Field[not(ancestor::Field)]">
					<xsl:sort select="string-length(@name)" order="descending" data-type="number"/>
					<!-- -->
					<xsl:value-of select="@name"/>
					<xsl:value-of select="$newrecord"/>
				</xsl:for-each>
			</xsl:with-param>
			<!--
			 ! the list of reference calculations
			 !
			 ! {newrecord}
			 ! id{delim}Calculation{newrecord}
			 ! id{delim}Calculation{newrecord}
			 ! ...
			 !
			 !-->
			<xsl:with-param name="fieldCalcs">
				<!-- Add a return at the front to make text handling easier -->
				<xsl:value-of select="$newrecord"/>
				<!-- -->
				<xsl:for-each select="//Field[not(ancestor::Field)]">
					<xsl:sort select="string-length(@name)" order="descending" data-type="number"/>
					<!-- -->
					<xsl:choose>
						<!-- Calculation -->
						<xsl:when test="@fieldType='Calculated'">
							<xsl:value-of select="@id"/>
							<xsl:value-of select="$delimiter"/>
							<xsl:value-of select="translate(Calculation/text(),$CRLF,'  ')"/>
							<xsl:if test="contains(concat('|',translate(Calculation/text(),$CALC_FIELD_BOUNDARY_CHARS,$CALC_FIELD_BOUNDARY_BARS),'|'),'|Self|')">
								<!-- expand self-reference to field name -->
								<xsl:value-of select="'+'"/>
								<xsl:value-of select="@name"/>
							</xsl:if>
							<xsl:value-of select="$newrecord"/>
						</xsl:when>
						<!-- AutoEnter Calculation -->
						<xsl:when test="@fieldType='Normal' and AutoEnter/@calculation='True'">
							<xsl:value-of select="@id"/>
							<xsl:value-of select="$delimiter"/>
							<xsl:value-of select="translate(AutoEnter/Calculation/text(),$CRLF,'  ')"/>
							<xsl:if test="contains(concat('|',translate(AutoEnter/Calculation/text(),$CALC_FIELD_BOUNDARY_CHARS,$CALC_FIELD_BOUNDARY_BARS),'|'),'|Self|')">
								<!-- expand self-reference to field name -->
								<xsl:value-of select="'+'"/>
								<xsl:value-of select="@name"/>
							</xsl:if>
							<xsl:value-of select="$newrecord"/>
						</xsl:when>
						<!-- AutoEnter Lookup -->
						<xsl:when test="@fieldType='Normal' and AutoEnter/@lookup='True'">
							<!-- FIXME - ADD NAMES OF RELATIONSHIP SOURCE FIELDS HERE -->
						</xsl:when>
						<xsl:when test="@fieldType='Summary'">
							<xsl:value-of select="@id"/>
							<xsl:value-of select="$delimiter"/>
							<xsl:value-of select="SummaryInfo/SummaryField/Field/@name"/>
							<!-- FIXME - ALSO RESORT FIELD? -->
							<xsl:value-of select="$newrecord"/>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<!-- NAMED TEMPLATES -->
	<!-- extractRelationNames -->
	<xsl:template name="extractRelationNames">
		
	</xsl:template>
	<!--
	 !
	 ! constructEdges
	 !
	 !
	 !
	 ! Note: The fieldNames MUST be sorted in descending order of length, in order to avoid 
	 !       linking to fields whose names are a substring of other fieldnames
	 !
	 !-->
	<xsl:template name="constructEdges">
		<xsl:param name="fieldNames"/>
		<xsl:param name="fieldCalcs"/>
		<!-- -->
		<xsl:if test="false()">
			<xsl:value-of select="$newrecord"/>
			<xsl:value-of select="'fieldNames:'"/>
			<xsl:value-of select="$newrecord"/>
			<xsl:value-of select="$fieldNames"/>
			<xsl:value-of select="$newrecord"/>
			<xsl:value-of select="'fieldCalcs:'"/>
			<xsl:value-of select="$newrecord"/>
			<xsl:value-of select="$fieldCalcs"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="$fieldNames=''">
				<!--
				 ! FINISHED
				 !-->
			</xsl:when>
			<xsl:otherwise>
				<!--
				 ! NEXT source field
				 !-->
				<xsl:variable name="fieldName" select="substring-before($fieldNames,$newrecord)"/>
				<xsl:variable name="fieldId" select="key('keyFieldIdFromName',$fieldName)"/>
				<!--
				 ! output all edges from the current source field
				 !-->
				<xsl:call-template name="constructEdgesForField">
					<xsl:with-param name="fieldId" select="$fieldId"/>
					<xsl:with-param name="fieldName" select="$fieldName"/>
					<xsl:with-param name="fieldCalcs" select="$fieldCalcs"/>
				</xsl:call-template>
				<!--
				 ! Recurse to next source field
				 !-->
				<xsl:call-template name="constructEdges">
					<!--
					 ! Remove field name from list
					 !-->
					<xsl:with-param name="fieldNames" select="substring-after($fieldNames,$newrecord)"/>
					<!--
					 ! Remove field name from calculations
					 !-->
					<xsl:with-param name="fieldCalcs">
						<xsl:call-template name="fn.Substitute">
							<xsl:with-param name="text" select="$fieldCalcs"/>
							<xsl:with-param name="searchString" select="$fieldName"/>
							<xsl:with-param name="replaceString" select="''"/>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	 !
	 ! constructEdgesForField
	 !
	 !
	 !
	 !
	 !-->
	<xsl:template name="constructEdgesForField">
		<xsl:param name="fieldId"/>
		<xsl:param name="fieldName"/>
		<xsl:param name="fieldCalcs"/>
		<!-- -->
		<xsl:variable name="calcBefore" select="substring-before($fieldCalcs,$fieldName)"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="$calcBefore=''">
				<!--
				 ! FINISHED - this field is not referenced by any of the remaining fields
				 !-->
			</xsl:when>
			<xsl:otherwise>
				<!--
				 ! NEXT target field
				 !
				 ! targetFieldId is first column of last line
				 !
				 !-->
				<xsl:choose>
					<xsl:when test="substring($calcBefore, string-length($calcBefore) - 1) = '::' and ($baseTableName = '' or ($baseTableName != '' and substring($calcBefore, string-length($calcBefore) - 1 - string-length($baseTableName), string-length($baseTableName)) != $baseTableName))">
						<!-- Ignore related field names -->
					</xsl:when>
					<xsl:otherwise>
						<!-- Output reference to field -->
						<xsl:variable name="lastLine">
							<xsl:call-template name="fn.substring-after-last">
								<xsl:with-param name="text" select="$calcBefore"/>
								<xsl:with-param name="searchString" select="$newrecord"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:variable name="targetFieldId" select="substring-before($lastLine,$delimiter)"/>
						<!-- -->
						<xsl:value-of select="'F'"/>
						<xsl:value-of select="$fieldId"/>
						<xsl:value-of select="' '"/>
						<xsl:value-of select="'F'"/>
						<xsl:value-of select="$targetFieldId"/>
						<xsl:value-of select="$newrecord"/>
					</xsl:otherwise>
				</xsl:choose>
				<!--
				 ! Recurse to next target field
				 !-->
				<xsl:call-template name="constructEdgesForField">
					<xsl:with-param name="fieldId" select="$fieldId"/>
					<xsl:with-param name="fieldName" select="$fieldName"/>
					<!-- skipping to next target field -->
					<xsl:with-param name="fieldCalcs" select="substring-after(substring-after($fieldCalcs,$fieldName),$newrecord)"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
