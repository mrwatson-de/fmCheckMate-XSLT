<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fmpxml="http://www.filemaker.com/fmpxmlresult" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: FMSaveAsXML_Text_GetMetaData.xsl

	XML-Source: filename.xml
	XML-Grammar: FMSaveAsXML
	XML-Content: saved database XML metadata
	

	===== CHANGES HISTORY =====
	2023-10-06 MrW v0.1 So, what is this?
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" encoding="UTF-8"/>
	<!--
				<TableOccurrence viewState="Collapse" height="12" id="1065104" name="Adressen.STAMM PLZ" type="External">
					<UUID modifications="183" userName="RW MacMini FM18" accountName="gbs" timestamp="2020-08-05T08:48:44">19263110-2050-4456-BB2A-1FE94214E8C4</UUID>
					<BaseTableSourceReference type="ExternalDataSourceReference">
						<DataSourceReference id="211" name="Listen"></DataSourceReference>
						<BaseTableReference id="131" name="_PLZ" UUID="B2C97EF2-7149-4393-804D-0DC17E7B5318"></BaseTableReference>
					</BaseTableSourceReference>
	-->
	<!-- ===== PARAMS ===== -->
	<xsl:param name="account_name"/>
	<xsl:param name="base_table_name"/>
	<xsl:param name="custom_function_name"/>
	<xsl:param name="custom_menu_item_name"/>
	<xsl:param name="custom_menu_name"/>
	<xsl:param name="custom_menu_set_name"/>
	<xsl:param name="extended_privilege_name"/>
	<xsl:param name="external_data_source_name"/>
	<xsl:param name="field_name"/>
	<xsl:param name="layout_field_name"/>
	<xsl:param name="layout_name"/>
	<xsl:param name="layout_part_name"/>
	<xsl:param name="object_name"/>
	<xsl:param name="privilege_set_name"/>
	<xsl:param name="script_name"/>
	<xsl:param name="script_name_stub"/>
	<xsl:param name="script_step_name"/>
	<xsl:param name="t_o_name"/>
	<xsl:param name="table_name"/>
	<xsl:param name="theme_name"/>
	<xsl:param name="value_list_name"/>
	<xsl:param name="account_number"/>
	<xsl:param name="base_table_number"/>
	<xsl:param name="custom_function_number"/>
	<xsl:param name="custom_menu_item_number"/>
	<xsl:param name="custom_menu_number"/>
	<xsl:param name="custom_menu_set_number"/>
	<xsl:param name="extended_privilege_number"/>
	<xsl:param name="external_data_source_number"/>
	<xsl:param name="field_number"/>
	<xsl:param name="layout_field_number"/>
	<xsl:param name="layout_number"/>
	<xsl:param name="layout_part_number"/>
	<xsl:param name="object_number"/>
	<xsl:param name="privilege_set_number"/>
	<xsl:param name="script_number"/>
	<xsl:param name="script_step_number"/>
	<xsl:param name="script_step_number_to"/>
	<xsl:param name="t_o_number"/>
	<xsl:param name="table_number"/>
	<xsl:param name="theme_number"/>
	<xsl:param name="value_list_number"/>
	<xsl:param name="account_id"/>
	<xsl:param name="base_table_id"/>
	<xsl:param name="custom_function_id"/>
	<xsl:param name="custom_menu_id"/>
	<xsl:param name="custom_menu_item_id"/>
	<xsl:param name="custom_menu_set_id"/>
	<xsl:param name="extended_privilege_id"/>
	<xsl:param name="external_data_source_id"/>
	<xsl:param name="field_id"/>
	<xsl:param name="layout_field_id"/>
	<xsl:param name="layout_id"/>
	<xsl:param name="layout_part_id"/>
	<xsl:param name="object_id"/>
	<xsl:param name="privilege_set_id"/>
	<xsl:param name="script_id"/>
	<xsl:param name="script_step_id"/>
	<xsl:param name="t_o_id"/>
	<xsl:param name="table_id"/>
	<xsl:param name="theme_id"/>
	<xsl:param name="value_list_id"/>
	<xsl:param name="account_uuid"/>
	<xsl:param name="base_table_uuid"/>
	<xsl:param name="custom_function_uuid"/>
	<xsl:param name="custom_menu_item_uuid"/>
	<xsl:param name="custom_menu_set_uuid"/>
	<xsl:param name="custom_menu_uuid"/>
	<xsl:param name="extended_privilege_uuid"/>
	<xsl:param name="external_data_source_uuid"/>
	<xsl:param name="field_uuid"/>
	<xsl:param name="layout_field_uuid"/>
	<xsl:param name="layout_part_uuid"/>
	<xsl:param name="layout_uuid"/>
	<xsl:param name="object_uuid"/>
	<xsl:param name="privilege_set_uuid"/>
	<xsl:param name="script_step_uuid"/>
	<xsl:param name="script_uuid"/>
	<xsl:param name="t_o_uuid"/>
	<xsl:param name="table_uuid"/>
	<xsl:param name="theme_uuid"/>
	<xsl:param name="value_list_uuid"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delim" select="'|'"/>
	<!-- ===== TEMPLATES ===== -->
	<xsl:variable name="parameter_names_found">
		<xsl:value-of select="$delim"/>
		<xsl:if test="string-length($account_name)"><xsl:value-of select="concat('account_name',$delim)"/></xsl:if>
		<xsl:if test="string-length($base_table_name)"><xsl:value-of select="concat('base_table_name',$delim)"/></xsl:if>
		<xsl:if test="string-length($custom_function_name)"><xsl:value-of select="concat('custom_function_name',$delim)"/></xsl:if>
		<xsl:if test="string-length($custom_menu_item_name)"><xsl:value-of select="concat('custom_menu_item_name',$delim)"/></xsl:if>
		<xsl:if test="string-length($custom_menu_name)"><xsl:value-of select="concat('custom_menu_name',$delim)"/></xsl:if>
		<xsl:if test="string-length($custom_menu_set_name)"><xsl:value-of select="concat('custom_menu_set_name',$delim)"/></xsl:if>
		<xsl:if test="string-length($extended_privilege_name)"><xsl:value-of select="concat('extended_privilege_name',$delim)"/></xsl:if>
		<xsl:if test="string-length($external_data_source_name)"><xsl:value-of select="concat('external_data_source_name',$delim)"/></xsl:if>
		<xsl:if test="string-length($field_name)"><xsl:value-of select="concat('field_name',$delim)"/></xsl:if>
		<xsl:if test="string-length($layout_field_name)"><xsl:value-of select="concat('layout_field_name',$delim)"/></xsl:if>
		<xsl:if test="string-length($layout_name)"><xsl:value-of select="concat('layout_name',$delim)"/></xsl:if>
		<xsl:if test="string-length($layout_part_name)"><xsl:value-of select="concat('layout_part_name',$delim)"/></xsl:if>
		<xsl:if test="string-length($object_name)"><xsl:value-of select="concat('object_name',$delim)"/></xsl:if>
		<xsl:if test="string-length($privilege_set_name)"><xsl:value-of select="concat('privilege_set_name',$delim)"/></xsl:if>
		<xsl:if test="string-length($script_name)"><xsl:value-of select="concat('script_name',$delim)"/></xsl:if>
		<xsl:if test="string-length($script_name_stub)"><xsl:value-of select="concat('script_name_stub',$delim)"/></xsl:if>
		<xsl:if test="string-length($script_step_name)"><xsl:value-of select="concat('script_step_name',$delim)"/></xsl:if>
		<xsl:if test="string-length($t_o_name)"><xsl:value-of select="concat('t_o_name',$delim)"/></xsl:if>
		<xsl:if test="string-length($table_name)"><xsl:value-of select="concat('table_name',$delim)"/></xsl:if>
		<xsl:if test="string-length($theme_name)"><xsl:value-of select="concat('theme_name',$delim)"/></xsl:if>
		<xsl:if test="string-length($value_list_name)"><xsl:value-of select="concat('value_list_name',$delim)"/></xsl:if>
		<xsl:if test="string-length($account_number)"><xsl:value-of select="concat('account_number',$delim)"/></xsl:if>
		<xsl:if test="string-length($base_table_number)"><xsl:value-of select="concat('base_table_number',$delim)"/></xsl:if>
		<xsl:if test="string-length($custom_function_number)"><xsl:value-of select="concat('custom_function_number',$delim)"/></xsl:if>
		<xsl:if test="string-length($custom_menu_item_number)"><xsl:value-of select="concat('custom_menu_item_number',$delim)"/></xsl:if>
		<xsl:if test="string-length($custom_menu_number)"><xsl:value-of select="concat('custom_menu_number',$delim)"/></xsl:if>
		<xsl:if test="string-length($custom_menu_set_number)"><xsl:value-of select="concat('custom_menu_set_number',$delim)"/></xsl:if>
		<xsl:if test="string-length($extended_privilege_number)"><xsl:value-of select="concat('extended_privilege_number',$delim)"/></xsl:if>
		<xsl:if test="string-length($external_data_source_number)"><xsl:value-of select="concat('external_data_source_number',$delim)"/></xsl:if>
		<xsl:if test="string-length($field_number)"><xsl:value-of select="concat('field_number',$delim)"/></xsl:if>
		<xsl:if test="string-length($layout_field_number)"><xsl:value-of select="concat('layout_field_number',$delim)"/></xsl:if>
		<xsl:if test="string-length($layout_number)"><xsl:value-of select="concat('layout_number',$delim)"/></xsl:if>
		<xsl:if test="string-length($layout_part_number)"><xsl:value-of select="concat('layout_part_number',$delim)"/></xsl:if>
		<xsl:if test="string-length($object_number)"><xsl:value-of select="concat('object_number',$delim)"/></xsl:if>
		<xsl:if test="string-length($privilege_set_number)"><xsl:value-of select="concat('privilege_set_number',$delim)"/></xsl:if>
		<xsl:if test="string-length($script_number)"><xsl:value-of select="concat('script_number',$delim)"/></xsl:if>
		<xsl:if test="string-length($script_step_number)"><xsl:value-of select="concat('script_step_number',$delim)"/></xsl:if>
		<xsl:if test="string-length($script_step_number_to)"><xsl:value-of select="concat('script_step_number_to',$delim)"/></xsl:if>
		<xsl:if test="string-length($t_o_number)"><xsl:value-of select="concat('t_o_number',$delim)"/></xsl:if>
		<xsl:if test="string-length($table_number)"><xsl:value-of select="concat('table_number',$delim)"/></xsl:if>
		<xsl:if test="string-length($theme_number)"><xsl:value-of select="concat('theme_number',$delim)"/></xsl:if>
		<xsl:if test="string-length($value_list_number)"><xsl:value-of select="concat('value_list_number',$delim)"/></xsl:if>
		<xsl:if test="string-length($account_id)"><xsl:value-of select="concat('account_id',$delim)"/></xsl:if>
		<xsl:if test="string-length($base_table_id)"><xsl:value-of select="concat('base_table_id',$delim)"/></xsl:if>
		<xsl:if test="string-length($custom_function_id)"><xsl:value-of select="concat('custom_function_id',$delim)"/></xsl:if>
		<xsl:if test="string-length($custom_menu_id)"><xsl:value-of select="concat('custom_menu_id',$delim)"/></xsl:if>
		<xsl:if test="string-length($custom_menu_item_id)"><xsl:value-of select="concat('custom_menu_item_id',$delim)"/></xsl:if>
		<xsl:if test="string-length($custom_menu_set_id)"><xsl:value-of select="concat('custom_menu_set_id',$delim)"/></xsl:if>
		<xsl:if test="string-length($extended_privilege_id)"><xsl:value-of select="concat('extended_privilege_id',$delim)"/></xsl:if>
		<xsl:if test="string-length($external_data_source_id)"><xsl:value-of select="concat('external_data_source_id',$delim)"/></xsl:if>
		<xsl:if test="string-length($field_id)"><xsl:value-of select="concat('field_id',$delim)"/></xsl:if>
		<xsl:if test="string-length($layout_field_id)"><xsl:value-of select="concat('layout_field_id',$delim)"/></xsl:if>
		<xsl:if test="string-length($layout_id)"><xsl:value-of select="concat('layout_id',$delim)"/></xsl:if>
		<xsl:if test="string-length($layout_part_id)"><xsl:value-of select="concat('layout_part_id',$delim)"/></xsl:if>
		<xsl:if test="string-length($object_id)"><xsl:value-of select="concat('object_id',$delim)"/></xsl:if>
		<xsl:if test="string-length($privilege_set_id)"><xsl:value-of select="concat('privilege_set_id',$delim)"/></xsl:if>
		<xsl:if test="string-length($script_id)"><xsl:value-of select="concat('script_id',$delim)"/></xsl:if>
		<xsl:if test="string-length($script_step_id)"><xsl:value-of select="concat('script_step_id',$delim)"/></xsl:if>
		<xsl:if test="string-length($t_o_id)"><xsl:value-of select="concat('t_o_id',$delim)"/></xsl:if>
		<xsl:if test="string-length($table_id)"><xsl:value-of select="concat('table_id',$delim)"/></xsl:if>
		<xsl:if test="string-length($theme_id)"><xsl:value-of select="concat('theme_id',$delim)"/></xsl:if>
		<xsl:if test="string-length($value_list_id)"><xsl:value-of select="concat('value_list_id',$delim)"/></xsl:if>
		<xsl:if test="string-length($account_uuid)"><xsl:value-of select="concat('account_uuid',$delim)"/></xsl:if>
		<xsl:if test="string-length($base_table_uuid)"><xsl:value-of select="concat('base_table_uuid',$delim)"/></xsl:if>
		<xsl:if test="string-length($custom_function_uuid)"><xsl:value-of select="concat('custom_function_uuid',$delim)"/></xsl:if>
		<xsl:if test="string-length($custom_menu_item_uuid)"><xsl:value-of select="concat('custom_menu_item_uuid',$delim)"/></xsl:if>
		<xsl:if test="string-length($custom_menu_set_uuid)"><xsl:value-of select="concat('custom_menu_set_uuid',$delim)"/></xsl:if>
		<xsl:if test="string-length($custom_menu_uuid)"><xsl:value-of select="concat('custom_menu_uuid',$delim)"/></xsl:if>
		<xsl:if test="string-length($extended_privilege_uuid)"><xsl:value-of select="concat('extended_privilege_uuid',$delim)"/></xsl:if>
		<xsl:if test="string-length($external_data_source_uuid)"><xsl:value-of select="concat('external_data_source_uuid',$delim)"/></xsl:if>
		<xsl:if test="string-length($field_uuid)"><xsl:value-of select="concat('field_uuid',$delim)"/></xsl:if>
		<xsl:if test="string-length($layout_field_uuid)"><xsl:value-of select="concat('layout_field_uuid',$delim)"/></xsl:if>
		<xsl:if test="string-length($layout_part_uuid)"><xsl:value-of select="concat('layout_part_uuid',$delim)"/></xsl:if>
		<xsl:if test="string-length($layout_uuid)"><xsl:value-of select="concat('layout_uuid',$delim)"/></xsl:if>
		<xsl:if test="string-length($object_uuid)"><xsl:value-of select="concat('object_uuid',$delim)"/></xsl:if>
		<xsl:if test="string-length($privilege_set_uuid)"><xsl:value-of select="concat('privilege_set_uuid',$delim)"/></xsl:if>
		<xsl:if test="string-length($script_step_uuid)"><xsl:value-of select="concat('script_step_uuid',$delim)"/></xsl:if>
		<xsl:if test="string-length($script_uuid)"><xsl:value-of select="concat('script_uuid',$delim)"/></xsl:if>
		<xsl:if test="string-length($t_o_uuid)"><xsl:value-of select="concat('t_o_uuid',$delim)"/></xsl:if>
		<xsl:if test="string-length($table_uuid)"><xsl:value-of select="concat('table_uuid',$delim)"/></xsl:if>
		<xsl:if test="string-length($theme_uuid)"><xsl:value-of select="concat('theme_uuid',$delim)"/></xsl:if>
		<xsl:if test="string-length($value_list_uuid)"><xsl:value-of select="concat('value_list_uuid',$delim)"/></xsl:if>
	</xsl:variable>
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
