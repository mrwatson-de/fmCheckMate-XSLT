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
	 ! The first character indicates the data type = the SHORTCUT KEY for that data type
	 ! 
	 !     T = Text
	 !     N = Number
	 !     D = Date
	 !     I = Time
	 !     M = Timestamp
	 !     R = Container
	 ! 
	 ! The second character indicates storage type
	 ! 
	 !     s = stored (but not indexed)
	 !     x = single index
	 !     X = double index
	 !     u = unstored calculation
	 !     U = Unstored summary
	 !     g = global storage
	 ! 
	 ! 
	 ! The third character indicates the field calculation type:
	 ! 
	 !     O = Output Field // not modifiable
	 !     o = Initialized Field // with initial auto enter value
	 !     f = Input Field
	 !     F = Automatic Field // autoenter filter or lookup)
	 !     C = Calculated Field
	 !     s = Summary Number Field
	 !     S = Summary Text Field
	 ! 
	 ! Typical examples are:
	 ! 
	 !   (D-xO) = indexed Output Date Field
	 !   (N-so) = stored (unindexed) Initialized once Number Field
	 !   (N-sF) = stored (unindexed) Automatic Filter Number Field
	 !   (N-sf) = stored (unindexed) Number Field
	 !   (N-gC) = global Calculated Number Field
	 !   (N-uC) = unstored Calculated Number Field
	 !   (N-sC) = stored (unindexed) Calculated Number Field
	 !   (N-xC) = stored single-indexed Number Calculated Number Field
	 !   (T-xC) = stored single-indexed Calculated Field
	 !   (T-XC) = stored double-indexed Calculated Field
	 !   (T-US) = Unstored Summary Text Field (List)
	 !   (N-us) = Unstored Summary Number Field (Sum, etc.)
	 ! 
	 ! Note: In the last two characters...
	 !       CAPITAL letters indicate a 'heavier' property and
	 !       lowercae letters indicate a 'lighter' property:
	 !
	 !   x = single index, X = double index
	 !   f = field (with no calculation), F = Filter, C = Calculate
	 !   o = initialize once (modifiable), O = (poss. initialize and) output (unmodifiable)
	 !   s = number sum, S = text sum
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
			<xsl:if test="$showDataType = 'True' or $showStorage = 'True' or $showCalcType = 'True'">
				<xsl:value-of select="' '"/>
				<xsl:value-of select="'('"/>
				<xsl:if test="$showDataType = 'True'">
					<!--
					! The first character indicates the data type = the SHORTCUT KEY for that data type
					!-->
					<xsl:choose>
						<xsl:when test="@dataType = 'Text'">
							<xsl:value-of select="'T'"/>
						</xsl:when>
						<xsl:when test="@dataType = 'Number'">
							<xsl:value-of select="'N'"/>
						</xsl:when>
						<xsl:when test="@dataType = 'Date'">
							<xsl:value-of select="'D'"/>
						</xsl:when>
						<xsl:when test="@dataType = 'Time'">
							<xsl:value-of select="'I'"/>
						</xsl:when>
						<xsl:when test="@dataType = 'TimeStamp'">
							<xsl:value-of select="'M'"/>
						</xsl:when>
						<xsl:when test="@dataType = 'Binary'">
							<xsl:value-of select="'R'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'?'"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<xsl:if
					test="$showDataType = 'True' and ($showStorage = 'True' or $showCalcType = 'True')">
					<xsl:value-of select="$flagDelim"/>
				</xsl:if>
				<xsl:if test="$showStorage = 'True'">
					<!--
					! The second character indicates storage type
					! -->
					<xsl:choose>
						<xsl:when test="Storage/@global = 'True'">
							<xsl:value-of select="'g'"/>
						</xsl:when>
						<xsl:when test="@fieldType = 'Summary'">
							<xsl:value-of select="'U'"/>
						</xsl:when>
						<xsl:when test="Storage/@storeCalculationResults = 'False'">
							<xsl:value-of select="'u'"/>
						</xsl:when>
						<xsl:when test="Storage/@index = 'All' and @dataType = 'Text'">
							<xsl:value-of select="'X'"/>
						</xsl:when>
						<xsl:when test="Storage/@index != 'None'">
							<xsl:value-of select="'x'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'s'"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<xsl:if test="$showCalcType = 'True'">
					<!--
					! The third character indicates the field calculation type:
					! -->
					<xsl:choose>
						<!-- An Output field, i.e. not modifiable input field -->
						<xsl:when test="AutoEnter/@allowEditing = 'False'">
							<xsl:value-of select="'O'"/>
						</xsl:when>
						<!-- Summary Fields-->
						<xsl:when test="@fieldType = 'Summary' and SummaryInfo/@operation='List'">
							<xsl:value-of select="'S'"/>
						</xsl:when>
						<xsl:when test="@fieldType = 'Summary'">
							<xsl:value-of select="'s'"/>
						</xsl:when>
						<!-- Calculations -->
						<xsl:when test="@fieldType = 'Calculated'">
							<xsl:value-of select="'C'"/>
						</xsl:when>
						<!-- Automatic Fields (AutoEnter always or Modification* or Lookup fields)-->
						<xsl:when test="AutoEnter/@overwriteExistingValue='True' or starts-with(AutoEnter/@value,'Modification') or AutoEnter/@lookup='True'">
							<xsl:value-of select="'F'"/>
						</xsl:when>
						<!-- Fields with one-time initial values -->
						<xsl:when test="AutoEnter/@calculation = 'True' or AutoEnter/@constant = 'True' or AutoEnter/@value or AutoEnter/Serial">
							<xsl:value-of select="'o'"/>
						</xsl:when>
						<!-- Finally a simple data field -->
						<xsl:otherwise>
							<xsl:value-of select="'f'"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<xsl:value-of select="')'"/>
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="translate($name, '#', '_')"/>
	</xsl:template>
	<!-- ScriptGraphNodeName -->
	<xsl:template name="ScriptGraphNodeName">
		<xsl:variable name="name">
			<xsl:if test="../FileReference/@name">
				<xsl:value-of select="../FileReference/@name"/>
				<xsl:value-of select="'::'"/>
			</xsl:if>
			<xsl:value-of select="@name"/>
			<xsl:if test="includeInMenu = 'True'">
				<xsl:value-of select="' [X]'"/>
			</xsl:if>
			<xsl:if test="runFullAccess = 'True'">
				<xsl:value-of select="' (o)'"/>
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="translate($name, '#', '_')"/>
	</xsl:template>
	<!-- RelationGraphNodeName -->
	<xsl:template name="RelationGraphNodeName"> </xsl:template>
</xsl:stylesheet>
