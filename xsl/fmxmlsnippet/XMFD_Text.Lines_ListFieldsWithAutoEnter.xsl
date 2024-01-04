<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMFD_Text.Lines_ListFieldsWithAutoEnter.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied field or table definitions
	
	Lists all Fields that have automatic entry 
	
	===== CHANGES HISTORY =====
	2011-11-01 MrW: renamed as 'List' function.
	2011-09-30 MrW: inc/constants.xsl
	2011-08-10 MrW: Version 1.0
	2011-03-10 MrW: With AutoEnter= creation & modification date, time, etc
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Fields with serials AutoEnter (serial, constant, calculation, lookup) -->
	<xsl:template match="//Field[AutoEnter/@value='ModificationDate' or 
		                     AutoEnter/@value='ModificationTime' or 
		                     AutoEnter/@value='ModificationTimeStamp' or 
		                     AutoEnter/@value='ModificationName' or 
		                     AutoEnter/@value='ModificationAccountName' or 
		                     AutoEnter/@value='CreationDate' or 
		                     AutoEnter/@value='CreationTime' or 
		                     AutoEnter/@value='CreationTimeStamp' or 
		                     AutoEnter/@value='CreationName' or 
		                     AutoEnter/@value='CreationAccountName' or 
		                     AutoEnter/Serial or AutoEnter/@lookup='True' or 
		                     AutoEnter/@constant='True' or 
		                     AutoEnter/@calculation='True']">

		<!-- if the field is in a different table to the last field we output, then output the table name --> 
		<!-- if the field is in the first field of a table, then output the table name --> 
		<xsl:if test="generate-id()=generate-id(parent::BaseTable/Field[position()=1])">
			<xsl:text>BaseTable </xsl:text>
			<xsl:value-of select="parent::BaseTable/@name"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:if>
		<xsl:if test="../@name"><xsl:value-of select="../@name"/>::</xsl:if><xsl:value-of select="@name"/>

		<xsl:choose>
			<xsl:when test="AutoEnter/@value='ModificationDate' or 
				        AutoEnter/@value='ModificationTime' or 
				        AutoEnter/@value='ModificationTimeStamp' or 
				        AutoEnter/@value='ModificationName' or 
				        AutoEnter/@value='ModificationAccountName' or 
				        AutoEnter/@value='CreationDate' or 
				        AutoEnter/@value='CreationTime' or 
				        AutoEnter/@value='CreationTimeStamp' or 
				        AutoEnter/@value='CreationName' or 
				        AutoEnter/@value='CreationAccountName'">
				<xsl:value-of select="$delimiter"/>
				<xsl:text>:</xsl:text>
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="AutoEnter/@value"/>
			</xsl:when>
			<xsl:when test="AutoEnter/Serial">
				<xsl:value-of select="$delimiter"/>
				<xsl:text>=+</xsl:text>
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
				<xsl:value-of select="translate(AutoEnter/Calculation,$CRLF,' ')"/>
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
