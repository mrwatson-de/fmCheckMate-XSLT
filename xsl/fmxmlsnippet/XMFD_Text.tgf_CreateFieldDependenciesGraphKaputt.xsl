<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMFD_Text.tgf_CreateFieldDependenciesGraphKaputt.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied field or table definitions
	
	PLANNED: Lists all fields, organised/indented based on references/dependencies.

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2016-05-19 MrW: Node name logic refactored into include file.
	2016-05-11 MrW: WOW! Greatly improved // field name match now includes word-bounds :-) // references AND modified-triggers // labels improved with clearer markers and a prefix was added to ids so that we can (later) distinguish between field-ids (F###) and relationship-ids (R###)
	2011-11-17 MrW: Started ... but with what hope?
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Graph_functions.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Match all fields  -->
	<xsl:template match="/">
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
		 !   referenced field -> referring field
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
		<xsl:for-each select="//Field[not(ancestor::Field)]">
			<xsl:variable name="id" select="@id"/>
			<xsl:variable name="fieldname" select="@name"/>
			<!-- -->
			<xsl:variable name="searchFieldname" select="concat('|',translate($fieldname,$CALC_FIELD_BOUNDARY_CHARS,$CALC_FIELD_BOUNDARY_BARS),'|')"/>
			<!--  -->
			<!--
			 ! 
			 ! 
			 ! Find ALL fields referring to or triggering the test field
			 ! 
			 ! 
			 !-->
			<!--
			 ! 
			 ! NORMAL AutoEnter field references
			 ! 
			 !-->
			<xsl:for-each select="//Field[@fieldType='Normal' and AutoEnter/@calculation='True' and contains(AutoEnter/Calculation,$fieldname)]">
				<xsl:sort select="@name"/>
				<!--  ONLY output a connection if the fieldname is bordered -->
				<xsl:if test="contains(concat('|',translate(.//Calculation,$CALC_FIELD_BOUNDARY_CHARS,$CALC_FIELD_BOUNDARY_BARS),'|'),$searchFieldname)">
					<xsl:value-of select="'F'"/>
					<xsl:value-of select="$id"/>
					<xsl:value-of select="' '"/>
					<xsl:value-of select="'F'"/>
					<xsl:value-of select="@id"/>
					<xsl:value-of select="$newrecord"/>
				</xsl:if>
			</xsl:for-each>
			<!--
			 ! 
			 ! NORMAL Lookup relation references
			 ! FIXME
			 !-->
			<!--
			 ! 
			 ! Calculated field references
			 ! 
			 !-->
			<xsl:for-each select="//Field[@fieldType='Calculated' and contains(Calculation,$fieldname)]">
				<xsl:sort select="@name"/>
				<!--  ONLY output a connection if the fieldname is bordered -->
				<xsl:if test="contains(concat('|',translate(.//Calculation,$CALC_FIELD_BOUNDARY_CHARS,$CALC_FIELD_BOUNDARY_BARS),'|'),$searchFieldname)">
					<xsl:value-of select="'F'"/>
					<xsl:value-of select="$id"/>
					<xsl:value-of select="' '"/>
					<xsl:value-of select="'F'"/>
					<xsl:value-of select="@id"/>
					<xsl:value-of select="$newrecord"/>
				</xsl:if>
			</xsl:for-each>
			<!--
			 ! 
			 ! SUMMARY field references
			 ! 
			 ! -->
			<xsl:for-each select="//Field[@fieldType='Summary' and SummaryInfo/SummaryField/Field/@id=$id]">
				<xsl:sort select="@name"/>
				<xsl:value-of select="'F'"/>
				<xsl:value-of select="$id"/>
				<xsl:value-of select="' '"/>
				<xsl:value-of select="'F'"/>
				<xsl:value-of select="@id"/>
				<xsl:value-of select="$newrecord"/>
			</xsl:for-each>
			<!--
			 ! 
			 ! SELF reference using the Self function
			 ! 
			 ! -->
			<xsl:if test="1=2 and contains(concat('|',translate(.//Calculation,$CALC_FIELD_BOUNDARY_CHARS,$CALC_FIELD_BOUNDARY_BARS),'|'),'|Self|')">
				<!-- a calculation uses a self reference via the Self function -->
				<xsl:value-of select="'F'"/>
				<xsl:value-of select="$id"/>
				<xsl:value-of select="' '"/>
				<xsl:value-of select="'F'"/>
				<xsl:value-of select="$id"/>
				<xsl:value-of select="$newrecord"/>
			</xsl:if>
			<!--
			 ! 
			 ! FIXME Trigger changes
			 ! 
			 ! -->
			<xsl:if test="1=2 and substring(AutoEnter/@value,1,12)='Modification'">
				<!-- is triggered from ALL normal fields -->
				<xsl:for-each select="//Field[@fieldType='Normal']">
					<xsl:sort select="@name"/>
					<!-- -->
					<xsl:value-of select="'F'"/>
					<xsl:value-of select="@id"/>
					<xsl:value-of select="' '"/>
					<xsl:value-of select="'F'"/>
					<xsl:value-of select="$id"/>
					<xsl:value-of select="$newrecord"/>
				</xsl:for-each>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!-- NAMED TEMPLATES -->
	<!-- extractRelationNames -->
	<xsl:template name="extractRelationNames">
		
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
