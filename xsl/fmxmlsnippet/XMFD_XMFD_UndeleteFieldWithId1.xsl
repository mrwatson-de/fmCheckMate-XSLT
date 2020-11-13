<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMFD_XMFD_UndeleteFieldWithId1.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied field or table definitions
	
	Returns field 1, creating a dummy definition if it is missing.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2016-06-04 MrW: Version 1.0.1 Renamed function for more clarity
	2012-07-10 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<!-- ===== PARAMETER ===== -->
	<xsl:param name="DeletedFieldNamePrefix" select="'zzz_Field_'"/>
	<xsl:param name="DeletedFieldNameSuffix" select="''"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="DefaultField1">
		
	</xsl:variable>
	<xsl:key name="LookupFieldByTableNameAndFieldId" match="//Field[not(ancestor::Field)]" use="concat(parent::BaseTable/@name,'::',@id)"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/fmxmlsnippet">
		<fmxmlsnippet type="FMObjectList">
			<xsl:choose>
				<xsl:when test="BaseTable">
					<!-- Tables copied: first field of each table -->
					<xsl:for-each select="BaseTable">
						<xsl:variable name="tableName" select="@name"/>
						<BaseTable name="{$tableName}">
							<xsl:call-template name="UndeleteField">
								<xsl:with-param name="tableName" select="$tableName"/>
								<xsl:with-param name="fieldId" select="1"/>
							</xsl:call-template>
						</BaseTable>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<!-- first field of each table -->
					<xsl:call-template name="UndeleteField">
						<xsl:with-param name="tableName" select="''"/>
						<xsl:with-param name="fieldId" select="1"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</fmxmlsnippet>
	</xsl:template>
	<!-- UndeleteField -->
	<xsl:template name="UndeleteField">
		<xsl:param name="tableName"/>
		<xsl:param name="fieldId"/>
		<!--  -->
		<xsl:variable name="id" select="concat($tableName,'::',$fieldId)"/>
		<xsl:variable name="FieldName" select="concat($DeletedFieldNamePrefix,$fieldId,$DeletedFieldNameSuffix)"/>
		<xsl:choose>
			<xsl:when test="key('LookupFieldByTableNameAndFieldId',$id)">
				<xsl:copy-of select="key('LookupFieldByTableNameAndFieldId',$id)"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- Undelete Field -->
				<Field id="{$id}" dataType="Number" fieldType="Normal" name="{$FieldName}">
					<!--Comment/>
					<AutoEnter allowEditing="True" constant="False" furigana="False" lookup="False" calculation="False">
						<ConstantData/>
					</AutoEnter>
					<Validation message="False" maxLength="False" valuelist="False" calculation="False" alwaysValidateCalculation="False" type="OnlyDuringDataEntry">
						<NotEmpty value="False"/>
						<Unique value="False"/>
						<Existing value="False"/>
						<StrictValidation value="False"/>
					</Validation>
					<Storage indexLanguage="English" global="True" maxRepetition="1"/-->
					<Storage global="True" maxRepetition="1"/>
				</Field>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
