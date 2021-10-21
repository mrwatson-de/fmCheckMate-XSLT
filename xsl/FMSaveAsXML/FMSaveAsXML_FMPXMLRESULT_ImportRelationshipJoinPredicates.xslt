<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fmpxml="http://www.filemaker.com/fmpxmlresult" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2021 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: FMSaveAsXML_FMPXMLRESULT_ImportRelationshipJoinPredicates.xsl

	XML-Source: filename.xml
	XML-Grammar: FMSaveAsXML
	XML-Content: saved database XML metadata
	
	Import Relationship joins into FileMaker, as part of a 'database explorer'.

	Once your database knows all about its own relationships, it should be possible 
	to make a *generic* record + relationship explorer.

	You'll need further 'reflection' functionality about tables and fields,
	and a good grasp of SQL to implement the lookup of relationships
	but the results of this XSLT could form the basis of the 'hopping' bit :)

	Originally created for a specific solution, this file has been included in the standard fmCheckMate library as a 'proof of concept'.

	This file was generated by MrWatson's automatic FileMaker Import XSLT generator 'FMPXMLRESULT_XSLT_CreateXMLImportTemplate.xsl'

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2021
	2021-10-21 MrW v0.1.1 Documentation improved
	2021-09-06 MrW v0.1 First succesful application
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<!-- ===== KEYS ===== -->
	<!-- Key to TOs for quick lookup of Filename+BaseTableName -->
	<xsl:key name="LookupTOByUUID" match="/FMSaveAsXML/Structure/AddAction/TableOccurrenceCatalog/TableOccurrence" use="UUID/text()"/>
	<xsl:key name="LookupTOsBaseTableNameByUUIDExtFile" match="/FMSaveAsXML/Structure/AddAction/TableOccurrenceCatalog/TableOccurrence/BaseTableSourceReference/BaseTableReference/@name" use="ancestor::TableOccurrence/UUID/text()"/>
	<xsl:key name="LookupTOsExtFileNameByUUID" match="/FMSaveAsXML/Structure/AddAction/TableOccurrenceCatalog/TableOccurrence/BaseTableSourceReference/DataSourceReference/@name" use="ancestor::TableOccurrence/UUID/text()"/>
	<!--
				<TableOccurrence viewState="Collapse" height="12" id="1065104" name="Adressen.STAMM PLZ" type="External">
					<UUID modifications="183" userName="RW MacMini FM18" accountName="gbs" timestamp="2020-08-05T08:48:44">19263110-2050-4456-BB2A-1FE94214E8C4</UUID>
					<BaseTableSourceReference type="ExternalDataSourceReference">
						<DataSourceReference id="211" name="Listen"></DataSourceReference>
						<BaseTableReference id="131" name="_PLZ" UUID="B2C97EF2-7149-4393-804D-0DC17E7B5318"></BaseTableReference>
					</BaseTableSourceReference>
	-->
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="foundcount">
		<xsl:value-of select="count(/FMSaveAsXML/Structure/AddAction/RelationshipCatalog/Relationship/JoinPredicateList/JoinPredicate)"/>
	</xsl:variable>
	<xsl:variable name="vFileName">
		<xsl:value-of select="/FMSaveAsXML/@File"/>
	</xsl:variable>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/">
		<FMPXMLRESULT xmlns="http://www.filemaker.com/fmpxmlresult">
			<ERRORCODE>0</ERRORCODE>
			<PRODUCT BUILD="07-06-2021" NAME="FileMaker" VERSION="Pro 19.3.2"/>
			<DATABASE DATEFORMAT="D.m.yyyy" LAYOUT="" NAME="Meta.fmp12" RECORDS="1" TIMEFORMAT="k:mm:ss "/>
			<METADATA>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Relationship_UUID" TYPE="TEXT"/>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Relationship_Title" TYPE="TEXT"/>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="LeftField_UUID" TYPE="TEXT"/>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="LeftField_id" TYPE="TEXT"/>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="LeftField_name" TYPE="TEXT"/>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="LeftTO_UUID" TYPE="TEXT"/>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="LeftTO_id" TYPE="TEXT"/>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="LeftTO_name" TYPE="TEXT"/>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="RightField_UUID" TYPE="TEXT"/>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="RightField_id" TYPE="TEXT"/>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="RightField_name" TYPE="TEXT"/>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="RightTO_UUID" TYPE="TEXT"/>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="RightTO_id" TYPE="TEXT"/>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="RightTO_name" TYPE="TEXT"/>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="JoinType" TYPE="TEXT"/>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="FileName" TYPE="TEXT"/>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="LeftTO_FileName" TYPE="TEXT"/>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="LeftTO_BaseTableName" TYPE="TEXT"/>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="RightTO_FileName" TYPE="TEXT"/>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="RightTO_BaseTableName" TYPE="TEXT"/>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="Temp" TYPE="TEXT"/>
			</METADATA>
			<RESULTSET FOUND="{$foundcount}">
				<xsl:apply-templates select="*"/>
			</RESULTSET>
		</FMPXMLRESULT>
	</xsl:template>
	<!-- ROW -->
	<xsl:template match="/FMSaveAsXML/Structure/AddAction/RelationshipCatalog/Relationship">
		<xsl:variable name="vUUID" select="UUID/text()"/>

		<xsl:variable name="vLeftTO_UUID" select="LeftTable/TableOccurrenceReference/@UUID"/>
		<xsl:variable name="vLeftTO_id" select="LeftTable/TableOccurrenceReference/@id"/>
		<xsl:variable name="vLeftTO_name" select="LeftTable/TableOccurrenceReference/@name"/>
		<!--xsl:variable name="vLeftTO_BaseTableName" select="key('LookupTOsBaseTableNameByUUIDExtFile',$vLeftTable/UUID/text())"/-->
		<xsl:variable name="vLeftTO_BaseTableName" select="key('LookupTOsBaseTableNameByUUIDExtFile',$vLeftTO_UUID)"/>
		<xsl:variable name="vLeftTO_ExtFileName" select="key('LookupTOsExtFileNameByUUID', $vLeftTO_UUID)"/>
		<xsl:variable name="vLeftTO_FileName">
			<xsl:choose>
				<xsl:when test="$vLeftTO_ExtFileName">
					<!-- External -->
					<xsl:value-of select="$vLeftTO_ExtFileName"/>
				</xsl:when>
				<xsl:otherwise>
					<!-- In<<ternal -->
					<xsl:value-of select="$vFileName"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="vRightTO_UUID" select="RightTable/TableOccurrenceReference/@UUID"/>
		<xsl:variable name="vRightTO_id" select="RightTable/TableOccurrenceReference/@id"/>
		<xsl:variable name="vRightTO_name" select="RightTable/TableOccurrenceReference/@name"/>
		<xsl:variable name="vRightTO_BaseTableName" select="key('LookupTOsBaseTableNameByUUIDExtFile',$vRightTO_UUID)"/>
		<xsl:variable name="vRightTO_ExtFileName" select="key('LookupTOsExtFileNameByUUID',$vRightTO_UUID)"/>
		<xsl:variable name="vRightTO_FileName">
			<xsl:choose>
				<xsl:when test="$vRightTO_ExtFileName">
					<!-- External -->
					<xsl:value-of select="$vRightTO_ExtFileName"/>
				</xsl:when>
				<xsl:otherwise>
					<!-- Internal -->
					<xsl:value-of select="$vFileName"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="Relationship_Title" select="concat($vLeftTO_name,'-',$vRightTO_name)"/>
		<!-- -->
		<xsl:for-each select="JoinPredicateList/JoinPredicate">
			<!-- -->
			<ROW>
				<!-- Column 1: Relationship_UUID (TEXT)-->
				<COL>
					<DATA>
						<xsl:value-of select="UUID/text()"/>
					</DATA>
				</COL>
				<!-- Column 2: Relationship_Title (TEXT)-->
				<COL>
					<DATA>
						<xsl:value-of select="$Relationship_Title"/>
					</DATA>
				</COL>
				<!-- Column 3: LeftField_UUID (TEXT)-->
				<COL>
					<DATA>
						<xsl:value-of select="LeftField/FieldReference/@UUID"/>
					</DATA>
				</COL>
				<!-- Column 4: LeftField_id (TEXT)-->
				<COL>
					<DATA>
						<xsl:value-of select="LeftField/FieldReference/@id"/>
					</DATA>
				</COL>
				<!-- Column 5: LeftField_name (TEXT)-->
				<COL>
					<DATA>
						<xsl:value-of select="LeftField/FieldReference/@name"/>
					</DATA>
				</COL>
				<!-- Column 6: LeftTO_UUID (TEXT)-->
				<COL>
					<DATA>
						<xsl:value-of select="$vLeftTO_UUID"/>
					</DATA>
				</COL>
				<!-- Column 7: LeftTO_id (TEXT)-->
				<COL>
					<DATA>
						<xsl:value-of select="$vLeftTO_id"/>
					</DATA>
				</COL>
				<!-- Column 8: LeftTO_name (TEXT)-->
				<COL>
					<DATA>
						<xsl:value-of select="$vLeftTO_name"/>
					</DATA>
				</COL>
				<!-- Column 9: RightField_UUID (TEXT)-->
				<COL>
					<DATA>
						<xsl:value-of select="RightField/FieldReference/@UUID"/>
					</DATA>
				</COL>
				<!-- Column 10: RightField_id (TEXT)-->
				<COL>
					<DATA>
						<xsl:value-of select="RightField/FieldReference/@id"/>
					</DATA>
				</COL>
				<!-- Column 11: RightField_name (TEXT)-->
				<COL>
					<DATA>
						<xsl:value-of select="RightField/FieldReference/@name"/>
					</DATA>
				</COL>
				<!-- Column 12: RightTO_UUID (TEXT)-->
				<COL>
					<DATA>
						<xsl:value-of select="$vRightTO_UUID"/>
					</DATA>
				</COL>
				<!-- Column 13: RightTO_id (TEXT)-->
				<COL>
					<DATA>
						<xsl:value-of select="$vRightTO_id"/>
					</DATA>
				</COL>
				<!-- Column 14: RightTO_name (TEXT)-->
				<COL>
					<DATA>
						<xsl:value-of select="$vRightTO_name"/>
					</DATA>
				</COL>
				<!-- Column 15: JoinType (TEXT)-->
				<COL>
					<DATA>
						<xsl:value-of select="@type"/>
					</DATA>
				</COL>
				<!-- Column 16: FileName (TEXT)-->
				<COL>
					<DATA>
						<xsl:value-of select="$vFileName"/>
					</DATA>
				</COL>
				<!-- Column 17: LeftTO_FileName (TEXT)-->
				<COL>
					<DATA>
						<xsl:value-of select="$vLeftTO_FileName"/>
					</DATA>
				</COL>
				<!-- Column 18: LeftTO_BaseTableName (TEXT)-->
				<COL>
					<DATA>
						<xsl:value-of select="$vLeftTO_BaseTableName"/>
					</DATA>
				</COL>
				<!-- Column 19: RightTO_FileName (TEXT)-->
				<COL>
					<DATA>
						<xsl:value-of select="$vRightTO_FileName"/>
					</DATA>
				</COL>
				<!-- Column 20: RightTO_BaseTableName (TEXT)-->
				<COL>
					<DATA>
						<xsl:value-of select="$vRightTO_BaseTableName"/>
					</DATA>
				</COL>
				<!-- Column 21: Temp (TEXT)-->
				<COL>
					<DATA>
						<xsl:value-of select="concat($vLeftTO_UUID,' -&gt; ',key('LookupTOsBaseTableNameByUUIDExtFile',$vLeftTO_UUID))"/>
					</DATA>
				</COL>
			</ROW>
		</xsl:for-each>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>