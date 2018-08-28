<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2018 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: inc.Graph_functions.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: some functions for graphing
	

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2016-2018
	2018-02-05 MrW: Version 0.4 Changed order (DataType-StorageCalcType), and corrected for Containers='Binary'
	2017-11-29 MrW: Version 0.3 Improved the indicator for Index type - now big "X" is shown ONLY for text fields
	2017-01-12 MrW: Version 0.2 Improved the output of the metadata flags to be more meaningful, of a more useful granularity, and to make it easier to find/select nodes.
	2016-05-18 MrW: Version 0.1
	-->
	<!-- ===== HEAD ===== -->
	<!--  -->
	<!-- NAMED TEMPLATES -->
	<!--
	 ! FieldGraphNodeName
	 ! 
	 !     Outputs a field name for a (tgf) graph node, inc. flags to indicate what kind of field it is.
	 ! 
	 ! The first character indicates the storage type:
	 ! 
	 !     s = stored (but not indexed)
	 !     x = single index
	 !     X = double index
	 !     u = unstored calculation
	 !     U = Unstored summary
	 !     g = global storage
	 ! 
	 ! The second character indicates the data type (= the SHORTCUT KEY for that data type):
	 ! 
	 !     T = Text
	 !     N = Number
	 !     D = Date
	 !     I = Time
	 !     M = Timestamp
	 !     R = Container
	 ! 
	 ! The third character indicates the field calculation type:
	 ! 
	 !     F = Input Field
	 !     o = Output Field // not modifiable
	 !     f = Initialized Field // with initial auto enter value
	 !     c = Automatic Field // autoenter filter or lookup)
	 !     C = Calculated Field
	 !     s = Summary Number Field
	 !     S = Summary Text Field
	 ! 
	 ! Typical examples are:
	 ! 
	 !     (U-T-S) = Unstored Text Summary Field (List)
	 !     (U-N-S) = Unstored Number Summary Field (Sum, etc.)
	 !     (g-N-C) = global Number Calculated Field
	 !     (u-N-C) = unstored Number Calculated Field
	 !     (s-N-C) = stored (unindexed) Number Calculated Field
	 !     (x-N-C) = stored single-indexed Number Calculated Field
	 !     (x-T-C) = stored single-indexed Text Calculated Field
	 !     (X-T-C) = stored double-indexed Text Calculated Field
	 !     (s-N-c) = stored (unindexed) Automatic Number Field
	 !     (s-N-f) = stored (unindexed) Initialized Number Field
	 !     (s-N-F) = stored (unindexed) (Input) Number Field
	 ! 
	 ! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	 ! 
	 !  A note on filtering the nodes in yEd
	 ! 
	 !  Remove all non-numerical fields
	 !  
	 !     Tools > Select Elements
	 !         General  
	 !             Clear Selection First
	 !             Select Inverse
	 !         Nodes
	 !             Use these criteria
	 !             Label
	 ! 
	 ! 
	 !-->
	<xsl:template name="FieldGraphNodeName">
		<!-- param -->
		<xsl:param name="flagDelim" select="'-'"/>
		<xsl:param name="showDataType" select="'True'"/>
		<xsl:param name="showStorage" select="'True'"/>
		<xsl:param name="showCalcType" select="'True'"/>
		<!-- var -->
		<xsl:variable name="name">
			<xsl:if test="../@name">
				<xsl:value-of select="../@name"/>
				<xsl:value-of select="'::'"/>
			</xsl:if>
			<xsl:value-of select="@name"/>
			<xsl:if test="$showDataType='True' or $showStorage='True' or $showCalcType='True'">
				<xsl:value-of select="' '"/>
				<xsl:value-of select="'('"/>
				<xsl:if test="$showDataType='True'">
					<!--
					! The first character indicates the data type = the SHORTCUT KEY for that data type
					!-->
					<xsl:choose>
						<xsl:when test="@dataType='Text'">
							<xsl:value-of select="'T'"/>
						</xsl:when>
						<xsl:when test="@dataType='Number'">
							<xsl:value-of select="'N'"/>
						</xsl:when>
						<xsl:when test="@dataType='Date'">
							<xsl:value-of select="'D'"/>
						</xsl:when>
						<xsl:when test="@dataType='Time'">
							<xsl:value-of select="'I'"/>
						</xsl:when>
						<xsl:when test="@dataType='TimeStamp'">
							<xsl:value-of select="'M'"/>
						</xsl:when>
						<xsl:when test="@dataType='Binary'">
							<xsl:value-of select="'R'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'?'"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<xsl:if test="$showDataType='True' and ($showStorage='True' or $showCalcType='True')">
					<xsl:value-of select="$flagDelim"/>
				</xsl:if>
				<xsl:if test="$showStorage='True'">
					<!--
					! The second character indicates storage type
					! -->
					<xsl:choose>
						<xsl:when test="Storage/@global='True'">
							<xsl:value-of select="'g'"/>
						</xsl:when>
						<xsl:when test="@fieldType='Summary'">
							<xsl:value-of select="'U'"/>
						</xsl:when>
						<xsl:when test="Storage/@storeCalculationResults='False'">
							<xsl:value-of select="'u'"/>
						</xsl:when>
						<xsl:when test="Storage/@index='All' and @dataType='Text'">
							<xsl:value-of select="'X'"/>
						</xsl:when>
						<xsl:when test="Storage/@index!='None'">
							<xsl:value-of select="'x'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'s'"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<xsl:if test="0=1  and ($showDataType='True' or $showStorage='True') and $showCalcType='True'">
					<xsl:value-of select="$flagDelim"/>
				</xsl:if>
				<xsl:if test="$showCalcType='True'">
					<!--
					! The third character indicates the field calculation type:
					! -->
					<xsl:choose>
						<!-- An Output field, i.e. not modifiable input field -->
						<xsl:when test="AutoEnter/@allowEditing='False'">
							<xsl:value-of select="'O'"/>
						</xsl:when>
						<xsl:when test="@fieldType='Summary'">
							<xsl:value-of select="'S'"/>
						</xsl:when>
						<!-- Calculation and Auto-Enter filters-->
						<xsl:when test="@fieldType='Calculated'">
							<xsl:value-of select="'C'"/>
						</xsl:when>
						<xsl:when test="AutoEnter/@calculation='True' and AutoEnter/@overwriteExistingValue='True'">
							<xsl:value-of select="'c'"/>
						</xsl:when>
						<xsl:when test="AutoEnter/@lookup='True'">
							<xsl:value-of select="'c'"/>
						</xsl:when>
						<!-- Fields with initial values -->
						<xsl:when test="AutoEnter/@calculation='True'">
							<xsl:value-of select="'f'"/>
						</xsl:when>
						<xsl:when test="AutoEnter/@constant='True'">
							<xsl:value-of select="'f'"/>
						</xsl:when>
						<xsl:when test="AutoEnter/@value">
							<xsl:value-of select="'f'"/>
						</xsl:when>
						<xsl:when test="AutoEnter/Serial">
							<xsl:value-of select="'f'"/>
						</xsl:when>
						<!-- simple data field -->
						<xsl:otherwise>
							<xsl:value-of select="'F'"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<xsl:value-of select="')'"/>
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="translate($name,'#','_')"/>
	</xsl:template>
	<!-- ScriptGraphNodeName -->
	<xsl:template name="ScriptGraphNodeName">
		<xsl:variable name="name">
			<xsl:if test="../FileReference/@name">
				<xsl:value-of select="../FileReference/@name"/>
				<xsl:value-of select="'::'"/>
			</xsl:if>
			<xsl:value-of select="@name"/>
			<xsl:if test="includeInMenu='True'">
				<xsl:value-of select="' [X]'"/>
			</xsl:if>
			<xsl:if test="runFullAccess='True'">
				<xsl:value-of select="' (o)'"/>
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="translate($name,'#','_')"/>
	</xsl:template>
	<!-- RelationGraphNodeName -->
	<xsl:template name="RelationGraphNodeName">

	</xsl:template>
</xsl:stylesheet>
