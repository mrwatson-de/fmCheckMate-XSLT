<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMFD_Text_PrintFieldDefinitions.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied field or table definitions
	
	Prints all Field definitions inc. Type and the *whole* calculation.
	
	Here is an example list of each type of field:
	
`_ID :+1 7`
: A field with auto-incremented serial number (Auto-Increment)

`active : "1"`
: A field with an auto-enter fixed text (Auto-Data)

`Status := "New"`
: A field with an auto-enter initial calculated value (Auto-Init)

`DateDeparture :== DateArrival+2`
: A field with an auto-enter filter calculated value (Auto-Calc)

`Info :=== "Input: " & Quote(Input)`
: A field with an auto-enter filter calculated value even when inputs empty

`RepIndex = ArrIndex+1`
: A calculated field

`_sTotal =∑: Score`
: A statistic field = Total

`_sCount =N: Options`
: A statistic field = Count

`_sAve =∑/N: Score`
: A statistic field = Average

`_sMin =≤: Score`
: A statistic field = Minimum

`_sMax =≥: Score`
: A statistic field = Maximum

`_StdDev =σ: Score`
: A statistic field = Standard Deviation

`_Frac =½: Score`
: A statistic field = Fraction of Total

`_List =∑¶: Names`
: A statistic field = List of Text
	
	
	===== CHANGES HISTORY =====
	2021-10-15 MrW: Version 1.3 Duplicated from XMFD_Text.Lines_ListFieldDefinitions.xsl - needs refactoring
	2020-08-21 MrW: Version 1.2 Changed the type symbol for serial number fields from '=+1' to the more semantically correct ':+1' - conveying the meaning of 'set' rather than 'calculate'.
	2020-08-20 MrW: Version 1.1 Added Analysis of Summary list fields
	2012-09-28 MrW: Improved Docu: added example list
	2011-09-30 MrW: inc/constants.xsl
	2011-08-10 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- All Fields with serials AutoEnter (serial, constant, calculation, lookup) -->
	<xsl:template match="//Field[not(ancestor::Field)]">
		<!-- if the field is in the first field of a table, then output the table name --> 
		<xsl:if test="generate-id()=generate-id(parent::BaseTable/Field[position()=1])">
			<xsl:text>BaseTable </xsl:text>
			<xsl:value-of select="parent::BaseTable/@name"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:if>
		<xsl:if test="../@name"><xsl:value-of select="../@name"/>::</xsl:if><xsl:value-of select="@name"/>
		<xsl:choose>
			<xsl:when test="@fieldType='Calculated'">
				<xsl:value-of select="$delimiter"/>
				<xsl:text>=</xsl:text>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="Calculation"/>
			</xsl:when>
			<xsl:when test="@fieldType='Summary'">
				<xsl:value-of select="$delimiter"/>
				<xsl:choose>
					<xsl:when test="SummaryInfo/@operation='Total'">
						<xsl:text>=∑:</xsl:text>
					</xsl:when>
					<xsl:when test="SummaryInfo/@operation='Average'">
						<xsl:text>=∑/N:</xsl:text>
					</xsl:when>
					<xsl:when test="SummaryInfo/@operation='Count'">
						<xsl:text>=N:</xsl:text>
					</xsl:when>
					<xsl:when test="SummaryInfo/@operation='Minimum'">
						<xsl:text>=≤:</xsl:text>
					</xsl:when>
					<xsl:when test="SummaryInfo/@operation='Maximum'">
						<xsl:text>=≥:</xsl:text>
					</xsl:when>
					<xsl:when test="SummaryInfo/@operation='StdDeviation'">
						<xsl:text>=σ:</xsl:text>
					</xsl:when>
					<xsl:when test="SummaryInfo/@operation='Fractional'">
						<xsl:text>=½:</xsl:text>
					</xsl:when>
					<xsl:when test="SummaryInfo/@operation='List'">
						<xsl:text>=∑¶:</xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="SummaryInfo/SummaryField/Field/@name"/>
				
			</xsl:when>
			<xsl:when test="AutoEnter/Serial">
				<xsl:value-of select="$delimiter"/>
				<xsl:text>:+</xsl:text>
				<xsl:value-of select="AutoEnter/Serial/@increment"/>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="AutoEnter/Serial/@nextValue"/>
			</xsl:when>
			<xsl:when test="AutoEnter/@constant='True'">
				<xsl:value-of select="$delimiter"/>
				<xsl:text>:</xsl:text>
				<xsl:value-of select="$delimiter"/>
				<xsl:text>"</xsl:text>
				<xsl:value-of select="translate(AutoEnter/ConstantData,$CRLF,' ')"/>
				<xsl:text>"</xsl:text>
			</xsl:when>
			<xsl:when test="AutoEnter/@value">
				<xsl:value-of select="$delimiter"/>
				<xsl:text>:</xsl:text>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="AutoEnter/@value"/>
			</xsl:when>
			<xsl:when test="AutoEnter/@calculation='True'">
				<xsl:value-of select="$delimiter"/>
				<xsl:text>:=</xsl:text>
				<xsl:if test="AutoEnter/@overwriteExistingValue='True'">
					<xsl:text>=</xsl:text>
					<xsl:if test="AutoEnter/@alwaysEvaluate='True'">
						<xsl:text>=</xsl:text>
					</xsl:if>
				</xsl:if>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="AutoEnter/Calculation"/>
			</xsl:when>
			<xsl:when test="AutoEnter/@lookup='True'">
				<xsl:value-of select="$delimiter"/>
				<xsl:text>&lt;==</xsl:text>
				<xsl:if test="AutoEnter/Lookup/CopyEmptyContent/@value='True'"><xsl:text>=</xsl:text></xsl:if>
				<xsl:choose>
					<xsl:when test="AutoEnter/Lookup/NoMatchCopyOption/@value='CopyNextLower'">
						<xsl:text>-</xsl:text>
					</xsl:when>
					<xsl:when test="AutoEnter/Lookup/NoMatchCopyOption/@value='CopyNextHigher'">
						<xsl:text>+</xsl:text>
					</xsl:when>
					<xsl:when test="AutoEnter/Lookup/NoMatchCopyOption/@value='CopyConstant'">
						<xsl:text>:"</xsl:text>
						<xsl:value-of select="translate(AutoEnter/Lookup/CopyConstantValue,$CRLF,' ')"/>
						<xsl:text>"</xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="AutoEnter/Lookup/Field/@table"/>
				<xsl:text>::</xsl:text>
				<xsl:value-of select="AutoEnter/Lookup/Field/@name"/>
			</xsl:when>
		</xsl:choose>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
