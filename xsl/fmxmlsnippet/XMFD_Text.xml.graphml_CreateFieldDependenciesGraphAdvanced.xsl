<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://graphml.graphdrawing.org/xmlns" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMFD_Text.xml.graphml_CreateFieldDependenciesGraphAdvanced.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied field or table definitions
	
	Creates a directed graph of field references in graphml format.
	
	- Nodes are fields.
	- Edge arrows show the *trigger* direction.
	
	Thus if field A = B an edge will be shown B -> A

	##Known issues:
	
	- If you are analysing JUST fields and no base tables a reference to the current table will be considered as a reference to a related table.

	##Viewing the results of this XSLT
	
	- I recommend using the *free* Editor yEd, available from http://www.yworks.com, to view graphs
	- fmCheckMate can now output and open files, and will automatically prompt you to save the file :-)
	- If the file doesn't open or opens in the wrong app, configue your system to open graphml files with yEd!
	
	
	1. Save the results as Clipboard.tgf (CMD+Shift+S from the fmCheckMate text result view)
	2. Open Clipboard.tgf -> yEd should open and display a pile of nodes in the middle of the window
	3. Use the Property Mapper on the Edit menu, import the property configurations
	4. Select Menu Layout > Hierarchical, set the desired settings and press OK
	   -  General > Orientation = Left-to-Right
	   -  Layers > hierarchic
	   -  etc.
	   -  See screenshots for more
	5. You can use Tools > Select Elements to select nodes and improve the graph, e.g.
	   -  Tools > Select Elements > Nodes > with Degree min 0 max 0
	      - General Options = DON'T Act on current selection only, DON'T Inverse Selection, DO Clear Selection first
	      … and delete them.


	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2011-2017
	2017-12-01 MrW: Changed to output graphml xml - with embedded data for hugely improved visualisation and analysis possibilities
	2016-12-15 MrW: Technique vastly improved to avoid false links to fields whose names are a substring of other fields
	                The trick is to work through the fields in descending order of name length,
	                removing references as you go -> this avoids ever referring to a substring of a fieldname :-)
	2016-05-19 MrW: Node name logic refactored into include file.
	2016-05-11 MrW: WOW! Greatly improved // field name match now includes word-bounds :-) // references AND modified-triggers // labels improved with clearer markers and a prefix was added to ids so that we can (later) distinguish between field-ids (F###) and relationship-ids (R###)
	2011-11-17 MrW: Started ... but with what hope?
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.StringFunctions.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Graph_functions.xsl"/>
	<xsl:variable name="stylesheetName" select="''"/>
	<xsl:variable name="stylesheetVersion" select="'2017-12-01'"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="baseTableName" select="/*/BaseTable/@name"/>
	<!-- ===== KEYS ===== -->
	<xsl:key name="keyFieldIdFromName" match="//Field[not(ancestor::Field)]/@id" use="../@name"/>
	<!--
	 ! 
	 ! 
	 ! ===== TEMPLATES =====
	 ! 
	 ! 
	-->
	<!-- Match all fields  -->
	<xsl:template match="/">
		<xsl:call-template name="outputGraphml"/>
	</xsl:template>
	<!--
	 ! 
	 ! 
	 ! NAMED TEMPLATES
	 ! 
	 !-->
	<!-- outputGraphml -->
	<xsl:template name="outputGraphml">
		<!--
		 ! output graphml
		 ! 
		 ! 
		 !-->
		<graphml xmlns="http://graphml.graphdrawing.org/xmlns">
			<xsl:call-template name="outputGraphmlKeys"/>
			<graph edgedefault="directed" id="G">
				<xsl:call-template name="outputGraphmlGraphMetaData"/>
				<xsl:call-template name="outputGraphmlNodes"/>
				<xsl:call-template name="outputGraphmlEdges"/>
			</graph>
		</graphml>
	</xsl:template>
	<!--
	 ! outputGraphmlKeys
	 ! 
	 ! 
	 ! Outputs the key definitions (graphml keys = custom data fields)
	 ! 
	 ! 
	 !-->
	<xsl:template name="outputGraphmlKeys">
		<!-- graph fields -->
		<key attr.name="Description" attr.type="string" for="graph" id="d0"/>
		<key attr.name="Generator" attr.type="string" for="graph" id="d1"/>
		<key attr.name="Version" attr.type="string" for="graph" id="d2"/>
		<!-- node fields -->
		<key attr.name="Label" attr.type="string" for="node" id="d10"/>
		<key attr.name="Node Type" attr.type="string" for="node" id="d11"/>
		<key attr.name="Storage" attr.type="string" for="node" id="d12"/>
		<key attr.name="AutoIndex" attr.type="string" for="node" id="d13"/>
		<key attr.name="Data Type" attr.type="string" for="node" id="d14"/>
		<key attr.name="Field Type" attr.type="string" for="node" id="d15"/>
		<key attr.name="Tooltip" attr.type="string" for="node" id="d16"/>
		<key attr.name="Calc Type" attr.type="string" for="node" id="d17"/>
		<key attr.name="Calc Weight" attr.type="string" for="node" id="d18"/>
		<key attr.name="url" attr.type="string" for="node" id="d30"/>
		<key attr.name="description" attr.type="string" for="node" id="d31"/>
		<!-- edge fields -->
		<key attr.name="url" attr.type="string" for="edge" id="d50"/>
		<key attr.name="description" attr.type="string" for="edge" id="d51"/>
	</xsl:template>
	<!-- outputGraphmlGraphMetaData -->
	<xsl:template name="outputGraphmlGraphMetaData">
		<!-- output graph description -->
		<data key="d0">
			<xsl:if test="$baseTableName != ''">
				<xsl:value-of select="$baseTableName"/>
				<xsl:value-of select="' '"/>
			</xsl:if>
			<xsl:value-of select="'Field Dependency Graph'"/>
		</data>
		<!-- output graph generator -->
		<data key="d1">
			<xsl:value-of select="'fmCheckMate'"/>
		</data>
		<!-- output stylesheet name -->
		<data key="d2">
			<xsl:value-of select="$stylesheetName"/>
		</data>
		<!-- output stylesheet version -->
		<data key="d3">
			<xsl:value-of select="$stylesheetVersion"/>
		</data>
	</xsl:template>
	<!-- outputGraphmlNodes -->
	<xsl:template name="outputGraphmlNodes">
		<xsl:for-each select="//Field[not(ancestor::Field)]">
			<xsl:call-template name="outputGraphmlNode"/>
		</xsl:for-each>
	</xsl:template>
	<!-- outputGraphmlNode -->
	<xsl:template name="outputGraphmlNode">
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
		<xsl:variable name="CalcNoWS" select="translate(Calculation,concat($CRLF,$TAB,' '),'')"/>
		<xsl:variable name="nodeId" select="concat('F',@id)"/>
		<xsl:variable name="fieldLabel">
			<xsl:call-template name="FieldGraphNodeName">
				<xsl:with-param name="showDataType" select="'True'"/>
				<xsl:with-param name="showStorage" select="'True'"/>
				<xsl:with-param name="showCalcType" select="'True'"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="fieldType">
			<xsl:value-of select="@fieldType"/>
		</xsl:variable>
		<xsl:variable name="dataType">
			<xsl:value-of select="@dataType"/>
		</xsl:variable>
		<xsl:variable name="fieldStorage">
			<xsl:choose>
				<xsl:when test="Storage/@global='True'">
					<xsl:value-of select="'Global'"/>
				</xsl:when>
				<xsl:when test="@fieldType='Summary'">
					<xsl:value-of select="'Summary'"/>
				</xsl:when>
				<xsl:when test="Storage/@storeCalculationResults='False'">
					<xsl:value-of select="'Unstored'"/>
				</xsl:when>
				<xsl:when test="Storage/@index='All' and @dataType='Text'">
					<xsl:value-of select="'Double Index'"/>
				</xsl:when>
				<xsl:when test="Storage/@index!='None'">
					<xsl:value-of select="'Single Index'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'Stored'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="storageAutoIndex">
			<xsl:choose>
				<xsl:when test="Storage/@autoIndex='False'">
					<xsl:value-of select="'Locked'"/>
				</xsl:when>
				<xsl:when test="Storage/@autoIndex='True'">
					<xsl:value-of select="'AutoIndex'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="''"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="nodeType">
			<xsl:choose>
				<!-- Summary Fields -->
				<xsl:when test="@fieldType='Summary' and @dataType='Text'">
					<xsl:value-of select="'Summary Text Field'"/>
				</xsl:when>
				<xsl:when test="@fieldType='Summary' and @dataType='Number'">
					<xsl:value-of select="'Summary Number Field'"/>
				</xsl:when>
				<!-- Calculated Fields -->
				<xsl:when test="@fieldType='Calculated'">
					<xsl:value-of select="'Calculated Field'"/>
				</xsl:when>
				<!-- Output Fields -->
				<xsl:when test="AutoEnter/@allowEditing='False'">
					<xsl:value-of select="'Output Field'"/>
				</xsl:when>
				<!-- Input Fields -->
				<xsl:when test="AutoEnter/@calculation='False' and  not(AutoEnter/@value) and AutoEnter/@constant='False' and AutoEnter/@lookup='False' and AutoEnter/@furigana='False'">
					<xsl:value-of select="'Input Field'"/>
				</xsl:when>
				<!-- Automatic Fields (AutoEnter always or Modification* or Lookup fields)-->
				<xsl:when test="AutoEnter/@overwriteExistingValue='True' or starts-with(AutoEnter/@value,'Modification') or AutoEnter/@lookup='True'">
					<xsl:value-of select="'Automatic Field'"/>
				</xsl:when>
				<!-- Initialized Fields (AutoEnter once or Create* or AutoEnter Data)-->
				<xsl:when test="AutoEnter/@overwriteExistingValue='False' or AutoEnter/@value">
					<xsl:value-of select="'Initialized Field'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'Unknown'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="calcType">
			<xsl:choose>
				<xsl:when test="@fieldType='Summary'">
					<xsl:value-of select="'Summary'"/>
				</xsl:when>
				<xsl:when test="@fieldType='Calculated'">
					<xsl:value-of select="'Calculated'"/>
				</xsl:when>
				<xsl:when test="AutoEnter/@lookup='True'">
					<xsl:value-of select="'Lookup'"/>
				</xsl:when>
				<xsl:when test="AutoEnter/Serial">
					<xsl:value-of select="'Serial'"/>
				</xsl:when>
				<xsl:when test="AutoEnter/@calculation='True'">
					<xsl:value-of select="'AutoEnter'"/>
				</xsl:when>
				<xsl:when test="AutoEnter/@value='ConstantData'">
					<xsl:value-of select="'Data'"/>
				</xsl:when>
				<xsl:when test="AutoEnter/@value">
					<xsl:value-of select="'Value'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="''"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="tooltip">
			<xsl:value-of select="$fieldLabel"/>
			<xsl:value-of select="$newrecord"/>
			<xsl:choose>
				<xsl:when test="@fieldType='Calculated'">
					<xsl:value-of select="concat($calcType,' from table ',Calculation/@table,', =',Calculation)"/>
				</xsl:when>
				<xsl:when test="AutoEnter/@calculation='True'">
					<xsl:value-of select="concat($calcType,' from table ',AutoEnter/Calculation/@table,', :=',AutoEnter/Calculation)"/>
				</xsl:when>
				<xsl:when test="AutoEnter/@lookup='True'">
					<xsl:value-of select="concat($calcType,' from table ',AutoEnter/Lookup/Table/@name,', &lt;=',AutoEnter/Lookup/Field/@table,'::',AutoEnter/Lookup/Field/@name)"/>
				</xsl:when>
				<xsl:when test="AutoEnter/@value='ConstantData'">
					<xsl:value-of select="concat($calcType,':',$APOS,AutoEnter/ConstantData,$APOS)"/>
				</xsl:when>
				<xsl:when test="AutoEnter/@value">
					<xsl:value-of select="concat($calcType,':',$APOS,AutoEnter/@value,$APOS)"/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="calcWeight">
			<xsl:choose>
				<xsl:when test="$calcType='Summary'">
					<xsl:choose>
						<xsl:when test="@dataType='Text'">
							<xsl:value-of select="16"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="12"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="$calcType='Calculated' and contains( Calculation,'::' )">
					<xsl:choose>
						<xsl:when test="contains( $CalcNoWS,'List(' )">
							<xsl:value-of select="14"/>
						</xsl:when>
						<xsl:when test="contains( $CalcNoWS,'Sum(' )">
							<xsl:value-of select="10"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="5"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="$calcType='Calculated'">
					<xsl:value-of select="4"/>
				</xsl:when>
				<xsl:when test="$calcType='Value'">
					<xsl:value-of select="2"/>
				</xsl:when>
				<xsl:when test="$calcType='Data'">
					<xsl:value-of select="2"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="1"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- -->
		<node id="{$nodeId}">
			<data key="d10">
				<xsl:value-of select="$fieldLabel"/>
			</data>
			<data key="d11">
				<xsl:value-of select="$nodeType"/>
			</data>
			<data key="d12">
				<xsl:value-of select="$fieldStorage"/>
			</data>
			<data key="d13">
				<xsl:value-of select="$storageAutoIndex"/>
			</data>
			<data key="d14">
				<xsl:value-of select="$dataType"/>
			</data>
			<data key="d15">
				<xsl:value-of select="$fieldType"/>
			</data>
			<data key="d16">
				<xsl:value-of select="$tooltip"/>
			</data>
			<data key="d17">
				<xsl:value-of select="$calcType"/>
			</data>
			<data key="d18">
				<xsl:value-of select="$calcWeight"/>
			</data>
		</node>
	</xsl:template>
	<!-- outputGraphmlEdges -->
	<xsl:template name="outputGraphmlEdges">
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
	<!--
	 !
	 ! constructEdges
	 !
	 !
	 !
	 ! Note: The fieldNames MUST be sorted in descending order of length, in order to avoid 
	 !       linking to fields whose names are a substring of other field names
	 !
	 !-->
	<xsl:template name="constructEdges">
		<xsl:param name="fieldNames"/>
		<xsl:param name="fieldCalcs"/>
		<!-- -->
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
						<xsl:variable name="targetFieldId" select="concat('F',substring-before($lastLine,$delimiter))"/>
						<xsl:variable name="sourceFieldId" select="concat('F',$fieldId)"/>
						<xsl:variable name="edgeId" select="concat($sourceFieldId,$targetFieldId)"/>
						<!-- -->
						<edge id="{$edgeId}" source="{$sourceFieldId}" target="{$targetFieldId}"/>
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
</xsl:stylesheet>
