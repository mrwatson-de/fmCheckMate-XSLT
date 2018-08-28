<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: fn.s.xsl

	XML-Source: any.xml
	XML-Grammar: any
	XML-Content: any

	Support for Internationalisation - Returns the string s in the included language:

	<xsl:include href="../../../fmCheckMate/xsl/_inc/Resources/{LANGUAGE},lproj/Strings.xsl"/>

	in developement / untested / TESTME

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2012-2016
	2012-06-28 MrW: Version 1.0
	-->
	<!-- Convert string s to localised text -->
	<xsl:template name="s">
		<xsl:param name="s"/>
		<!--  -->
		<xsl:choose>
			<!--Shapes-->
			<xsl:when test="$s='Rect'">
				<xsl:value-of select="$valRect"/>
			</xsl:when>
			<xsl:when test="$s='RRect'">
				<xsl:value-of select="$valRRect"/>
			</xsl:when>
			<xsl:when test="$s='Portal'">
				<xsl:value-of select="$valPortal"/>
			</xsl:when>
			<xsl:when test="$s='Oval'">
				<xsl:value-of select="$valOval"/>
			</xsl:when>
			<xsl:when test="$s='Line'">
				<xsl:value-of select="$valLine"/>
			</xsl:when>
			<xsl:when test="$s='Graphic'">
				<xsl:value-of select="$valGraphic"/>
			</xsl:when>
			<!--Sort-->
			<xsl:when test="$s='Ascending'">
				<xsl:value-of select="$valAscending"/>
			</xsl:when>
			<xsl:when test="$s='Descending'">
				<xsl:value-of select="$valDescending"/>
			</xsl:when>
			<xsl:when test="$s='CustomValueList'">
				<xsl:value-of select="$valCustomValueList"/>
			</xsl:when>
			<xsl:when test="$s='ReorderSummaryField'">
				<xsl:value-of select="$valReorderSummaryField"/>
			</xsl:when>
			<xsl:when test="$s='OverrideFieldLang'">
				<xsl:value-of select="$valOverrideFieldLang"/>
			</xsl:when>
			<!--Overview-->
			<xsl:when test="$s='BackToOverview'">
				<xsl:value-of select="$valBackToOverview"/>
			</xsl:when>
			<xsl:when test="$s='ReportCreated'">
				<xsl:value-of select="$valReportCreated"/>
			</xsl:when>
			<xsl:when test="$s='ReportOverview'">
				<xsl:value-of select="$valReportOverview"/>
			</xsl:when>
			<xsl:when test="$s='FileName'">
				<xsl:value-of select="$valFileName"/>
			</xsl:when>
			<!--Layout -->
			<xsl:when test="$s='ShowRecordsFrom'">
				<xsl:value-of select="$valShowRecordsFrom"/>
			</xsl:when>
			<xsl:when test="$s='SaveRecordChanges'">
				<xsl:value-of select="$valSaveRecordChanges"/>
			</xsl:when>
			<xsl:when test="$s='ShowFieldFrames'">
				<xsl:value-of select="$valShowFieldFrames"/>
			</xsl:when>
			<xsl:when test="$s='ContainsFields'">
				<xsl:value-of select="$valContainsFields"/>
			</xsl:when>
			<xsl:when test="$s='ContainsButtons'">
				<xsl:value-of select="$valContainsButtons"/>
			</xsl:when>
			<xsl:when test="$s='UsedInScripts'">
				<xsl:value-of select="$valUsedInScripts"/>
			</xsl:when>
			<!--Title-->
			<xsl:when test="$s='DatabaseDesignReport'">
				<xsl:value-of select="$valDatabaseDesignReport"/>
			</xsl:when>
			<xsl:when test="$s='FileOptionOverview'">
				<xsl:value-of select="$valFileOptionOverview"/>
			</xsl:when>
			<!--Script name-->
			<xsl:when test="$s='RunScriptFullAccess'">
				<xsl:value-of select="$valRunScriptFullAccess"/>
			</xsl:when>
			<xsl:when test="$s='LayoutsUseThisScript'">
				<xsl:value-of select="$valLayoutsUseThisScript"/>
			</xsl:when>
			<xsl:when test="$s='ScriptsUseThisScript'">
				<xsl:value-of select="$valScriptsUseThisScript"/>
			</xsl:when>
			<xsl:when test="$s='ScriptDefinition'">
				<xsl:value-of select="$valScriptDefinition"/>
			</xsl:when>
			<xsl:when test="$s='ScriptSteps'">
				<xsl:value-of select="$valScriptSteps"/>
			</xsl:when>
			<xsl:when test="$s='FieldsUsedInScript'">
				<xsl:value-of select="$valFieldsUsedInScript"/>
			</xsl:when>
			<xsl:when test="$s='TablesUsedInScript'">
				<xsl:value-of select="$valTablesUsedInScript"/>
			</xsl:when>
			<xsl:when test="$s='TableOccurrencesUsedInScript'">
				<xsl:value-of select="$valTableOccurrencesUsedInScript"/>
			</xsl:when>
			<xsl:when test="$s='LayoutsUsedInScript'">
				<xsl:value-of select="$valLayoutsUsedInScript"/>
			</xsl:when>
			<xsl:when test="$s='CustomFunctionsUsedInScript'">
				<xsl:value-of select="$valCustomFunctionsUsedInScript"/>
			</xsl:when>
			<xsl:when test="$s='ScriptsUsedInScript'">
				<xsl:value-of select="$valScriptsUsedInScript"/>
			</xsl:when>
			<!--Value list-->
			<xsl:when test="$s='Source'">
				<xsl:value-of select="$valSource"/>
			</xsl:when>
			<xsl:when test="$s='Values'">
				<xsl:value-of select="$valValues"/>
			</xsl:when>
			<xsl:when test="$s='External'">
				<xsl:value-of select="$valExternal"/>
			</xsl:when>
			<!--Account-->
			<xsl:when test="$s='AccountName'">
				<xsl:value-of select="$valAccountName"/>
			</xsl:when>
			<xsl:when test="$s='Password'">
				<xsl:value-of select="$valPassword"/>
			</xsl:when>
			<xsl:when test="$s='Status'">
				<xsl:value-of select="$valStatus"/>
			</xsl:when>
			<xsl:when test="$s='ChangePassword'">
				<xsl:value-of select="$valChangePassword"/>
			</xsl:when>
			<xsl:when test="$s='Active'">
				<xsl:value-of select="$valActive"/>
			</xsl:when>
			<xsl:when test="$s='Inactive'">
				<xsl:value-of select="$valInactive"/>
			</xsl:when>
			<xsl:when test="$s='ExternalServer'">
				<xsl:value-of select="$valExternalServer"/>
			</xsl:when>
			<xsl:when test="$s='FileMaker'">
				<xsl:value-of select="$valFileMaker"/>
			</xsl:when>
			<xsl:when test="$s='AccountNameAndPassword'">
				<xsl:value-of select="$valAccountNameAndPassword"/>
			</xsl:when>
			<!--File reference-->
			<xsl:when test="$s='PathList'">
				<xsl:value-of select="$valPathList"/>
			</xsl:when>
			<!--Custom function -->
			<xsl:when test="$s='FunctionName'">
				<xsl:value-of select="$valFunctionName"/>
			</xsl:when>
			<xsl:when test="$s='Parameters'">
				<xsl:value-of select="$valParameters"/>
			</xsl:when>
			<xsl:when test="$s='Availability'">
				<xsl:value-of select="$valAvailability"/>
			</xsl:when>
			<xsl:when test="$s='Definition'">
				<xsl:value-of select="$valDefinition"/>
			</xsl:when>
			<xsl:when test="$s='AllAccounts'">
				<xsl:value-of select="$valAllAccounts"/>
			</xsl:when>
			<xsl:when test="$s='OnlyAccountsFullPrivilege'">
				<xsl:value-of select="$valOnlyAccountsFullPrivilege"/>
			</xsl:when>
			<!--Privileges-->
			<xsl:when test="$s='Description'">
				<xsl:value-of select="$valDescription"/>
			</xsl:when>
			<xsl:when test="$s='UsedBy'">
				<xsl:value-of select="$valUsedBy"/>
			</xsl:when>
			<xsl:when test="$s='DataAccessAndDesign'">
				<xsl:value-of select="$valDataAccessAndDesign"/>
			</xsl:when>
			<xsl:when test="$s='record'">
				<xsl:value-of select="$valrecord"/>
			</xsl:when>
			<xsl:when test="$s='records'">
				<xsl:value-of select="$valrecords"/>
			</xsl:when>
			<xsl:when test="$s='Records'">
				<xsl:value-of select="$valRecords"/>
			</xsl:when>
			<xsl:when test="$s='AllowCreationLayouts'">
				<xsl:value-of select="$valAllowCreationLayouts"/>
			</xsl:when>
			<xsl:when test="$s='AllowCreationValueLists'">
				<xsl:value-of select="$valAllowCreationValueLists"/>
			</xsl:when>
			<xsl:when test="$s='AllowCreationScripts'">
				<xsl:value-of select="$valAllowCreationScripts"/>
			</xsl:when>
			<xsl:when test="$s='LayoutAccess'">
				<xsl:value-of select="$valLayoutAccess"/>
			</xsl:when>
			<xsl:when test="$s='AssociatedTableOccurrence'">
				<xsl:value-of select="$valAssociatedTableOccurrence"/>
			</xsl:when>
			<xsl:when test="$s='DataAccess'">
				<xsl:value-of select="$valDataAccess"/>
			</xsl:when>
			<xsl:when test="$s='ValueListName'">
				<xsl:value-of select="$valValueListName"/>
			</xsl:when>
			<xsl:when test="$s='ValueListAccess'">
				<xsl:value-of select="$valValueListAccess"/>
			</xsl:when>
			<xsl:when test="$s='ScriptAccess'">
				<xsl:value-of select="$valScriptAccess"/>
			</xsl:when>
			<xsl:when test="$s='ScriptName'">
				<xsl:value-of select="$valScriptName"/>
			</xsl:when>
			<xsl:when test="$s='Notes'">
				<xsl:value-of select="$valNotes"/>
			</xsl:when>
			<xsl:when test="$s='OtherPrivileges'">
				<xsl:value-of select="$valOtherPrivileges"/>
			</xsl:when>
			<xsl:when test="$s='AllowPrinting'">
				<xsl:value-of select="$valAllowPrinting"/>
			</xsl:when>
			<xsl:when test="$s='AllowExporting'">
				<xsl:value-of select="$valAllowExporting"/>
			</xsl:when>
			<xsl:when test="$s='ManageExtPrivileges'">
				<xsl:value-of select="$valManageExtPrivileges"/>
			</xsl:when>
			<xsl:when test="$s='AllowDataValidation'">
				<xsl:value-of select="$valAllowDataValidation"/>
			</xsl:when>
			<xsl:when test="$s='DisconnectFromFMServer'">
				<xsl:value-of select="$valDisconnectFromFMServer"/>
			</xsl:when>
			<xsl:when test="$s='AllowModifyPassword'">
				<xsl:value-of select="$valAllowModifyPassword"/>
			</xsl:when>
			<xsl:when test="$s='AvailableMenuCommands'">
				<xsl:value-of select="$valAvailableMenuCommands"/>
			</xsl:when>
			<xsl:when test="$s='EditingOnly'">
				<xsl:value-of select="$valEditingOnly"/>
			</xsl:when>
			<xsl:when test="$s='Minimal'">
				<xsl:value-of select="$valMinimal"/>
			</xsl:when>
			<xsl:when test="$s='ExpiraryDate'">
				<xsl:value-of select="$valExpiraryDate"/>
			</xsl:when>
			<xsl:when test="$s='MinPasswordLength'">
				<xsl:value-of select="$valMinPasswordLength"/>
			</xsl:when>
			<xsl:when test="$s='Characters'">
				<xsl:value-of select="$valCharacters"/>
			</xsl:when>
			<xsl:when test="$s='Days'">
				<xsl:value-of select="$valDays"/>
			</xsl:when>
			<xsl:when test="$s='ExtendedPrivileges'">
				<xsl:value-of select="$valExtendedPrivileges"/>
			</xsl:when>
			<xsl:when test="$s='Keyword'">
				<xsl:value-of select="$valKeyword"/>
			</xsl:when>
			<xsl:when test="$s='None'">
				<xsl:value-of select="$valNone"/>
			</xsl:when>
			<!--Access Level -->
			<xsl:when test="$s='ViewOnly'">
				<xsl:value-of select="$valViewOnly"/>
			</xsl:when>
			<xsl:when test="$s='ExecutableOnly'">
				<xsl:value-of select="$valExecutableOnly"/>
			</xsl:when>
			<xsl:when test="$s='CreateEdit'">
				<xsl:value-of select="$valCreateEdit"/>
			</xsl:when>
			<xsl:when test="$s='CreateEditDelete'">
				<xsl:value-of select="$valCreateEditDelete"/>
			</xsl:when>
			<xsl:when test="$s='Modifiable'">
				<xsl:value-of select="$valModifiable"/>
			</xsl:when>
			<xsl:when test="$s='NoAccess'">
				<xsl:value-of select="$valNoAccess"/>
			</xsl:when>
			<xsl:when test="$s='Custom'">
				<xsl:value-of select="$valCustom"/>
			</xsl:when>
			<xsl:when test="$s='Limited'">
				<xsl:value-of select="$valLimited"/>
			</xsl:when>
			<xsl:when test="$s='All'">
				<xsl:value-of select="$valAll"/>
			</xsl:when>
			<!--Access section -->
			<xsl:when test="$s='View'">
				<xsl:value-of select="$valView"/>
			</xsl:when>
			<xsl:when test="$s='Edit'">
				<xsl:value-of select="$valEdit"/>
			</xsl:when>
			<xsl:when test="$s='Create'">
				<xsl:value-of select="$valCreate"/>
			</xsl:when>
			<xsl:when test="$s='FieldAccess'">
				<xsl:value-of select="$valFieldAccess"/>
			</xsl:when>
			<!--Overview -->
			<xsl:when test="$s='Overview'">
				<xsl:value-of select="$valOverview"/>
			</xsl:when>
			<!--File options -->
			<xsl:when test="$s='FileOptions'">
				<xsl:value-of select="$valFileOptions"/>
			</xsl:when>
			<xsl:when test="$s='WhenOpeningFile'">
				<xsl:value-of select="$valWhenOpeningFile"/>
			</xsl:when>
			<xsl:when test="$s='WhenClosingFile'">
				<xsl:value-of select="$valWhenClosingFile"/>
			</xsl:when>
			<xsl:when test="$s='LoginUsing'">
				<xsl:value-of select="$valLoginUsing"/>
			</xsl:when>
			<xsl:when test="$s='SwitchToLayout'">
				<xsl:value-of select="$valSwitchToLayout"/>
			</xsl:when>
			<xsl:when test="$s='PerformScript'">
				<xsl:value-of select="$valPerformScript"/>
			</xsl:when>
			<xsl:when test="$s='On'">
				<xsl:value-of select="$valOn"/>
			</xsl:when>
			<xsl:when test="$s='Off'">
				<xsl:value-of select="$valOff"/>
			</xsl:when>
			<!--Different report sections -->
			<xsl:when test="$s='Tables'">
				<xsl:value-of select="$valTables"/>
			</xsl:when>
			<!--Plural-->
			<xsl:when test="$s='Fields'">
				<xsl:value-of select="$valFields"/>
			</xsl:when>
			<!--Singular-->
			<xsl:when test="$s='Field'">
				<xsl:value-of select="$valField"/>
			</xsl:when>
			<!--Plural-->
			<xsl:when test="$s='Relationships'">
				<xsl:value-of select="$valRelationships"/>
			</xsl:when>
			<!--Singular-->
			<xsl:when test="$s='Relationship'">
				<xsl:value-of select="$valRelationship"/>
			</xsl:when>
			<xsl:when test="$s='Layouts'">
				<xsl:value-of select="$valLayouts"/>
			</xsl:when>
			<!-- new for 11.0 -->
			<xsl:when test="$s='LayoutHierarchy'">
				<xsl:value-of select="$valLayoutHierarchy"/>
			</xsl:when>
			<!-- end of new for 11.0 -->
			<xsl:when test="$s='Scripts'">
				<xsl:value-of select="$valScripts"/>
			</xsl:when>
			<!-- new for 9.0 -->
			<xsl:when test="$s='ScriptHierarchy'">
				<xsl:value-of select="$valScriptHierarchy"/>
			</xsl:when>
			<!-- end of new for 9.0 -->
			<xsl:when test="$s='ValueLists'">
				<xsl:value-of select="$valValueLists"/>
			</xsl:when>
			<xsl:when test="$s='CustomFunctions'">
				<xsl:value-of select="$valCustomFunctions"/>
			</xsl:when>
			<xsl:when test="$s='Accounts'">
				<xsl:value-of select="$valAccounts"/>
			</xsl:when>
			<xsl:when test="$s='Account'">
				<xsl:value-of select="$valAccount"/>
			</xsl:when>
			<xsl:when test="$s='PrivilegeSets'">
				<xsl:value-of select="$valPrivilegeSets"/>
			</xsl:when>
			<!-- Singular -->
			<xsl:when test="$s='PrivilegeSet'">
				<xsl:value-of select="$valPrivilegeSet"/>
			</xsl:when>
			<xsl:when test="$s='FileReferences'">
				<xsl:value-of select="$valFileReferences"/>
			</xsl:when>
			<!-- new for 9.0 -->
			<xsl:when test="$s='OdbcDataSources'">
				<xsl:value-of select="$valOdbcDataSources"/>
			</xsl:when>
			<xsl:when test="$s='Name'">
				<xsl:value-of select="$valName"/>
			</xsl:when>
			<xsl:when test="$s='DSN'">
				<xsl:value-of select="$valDSN"/>
			</xsl:when>
			<xsl:when test="$s='Authentication'">
				<xsl:value-of select="$valAuthentication"/>
			</xsl:when>
			<xsl:when test="$s='Filtering'">
				<xsl:value-of select="$valFiltering"/>
			</xsl:when>
			<xsl:when test="$s='PromptForLogin'">
				<xsl:value-of select="$valPromptForLogin"/>
			</xsl:when>
			<xsl:when test="$s='LoginWithCredentials'">
				<xsl:value-of select="$valLoginWithCredentials"/>
			</xsl:when>
			<xsl:when test="$s='Username'">
				<xsl:value-of select="$valUsername"/>
			</xsl:when>
			<xsl:when test="$s='LoginWithSingleSignOn'">
				<xsl:value-of select="$valLoginWithSingleSignOn"/>
			</xsl:when>
			<xsl:when test="$s='SPN'">
				<xsl:value-of select="$valSPN"/>
			</xsl:when>
			<xsl:when test="$s='FilterTypes'">
				<xsl:value-of select="$valFilterTypes"/>
			</xsl:when>
			<xsl:when test="$s='FilterTables'">
				<xsl:value-of select="$valFilterTables"/>
			</xsl:when>
			<xsl:when test="$s='FilterViews'">
				<xsl:value-of select="$valFilterViews"/>
			</xsl:when>
			<xsl:when test="$s='FilterSystemTables'">
				<xsl:value-of select="$valFilterSystemTables"/>
			</xsl:when>
			<xsl:when test="$s='CatalogName'">
				<xsl:value-of select="$valCatalogName"/>
			</xsl:when>
			<xsl:when test="$s='TableName'">
				<xsl:value-of select="$valTableName"/>
			</xsl:when>
			<xsl:when test="$s='SchemaName'">
				<xsl:value-of select="$valSchemaName"/>
			</xsl:when>
			<xsl:when test="$s='HiddenPassword'">
				<xsl:value-of select="$valHiddenPassword"/>
			</xsl:when>
			<!-- new for 9.0 -->
			<!--Table headings for the Tables -->
			<xsl:when test="$s='fields'">
				<xsl:value-of select="$valfields"/>
			</xsl:when>
			<xsl:when test="$s='field'">
				<xsl:value-of select="$valfield"/>
			</xsl:when>
			<xsl:when test="$s='Defined'">
				<xsl:value-of select="$valDefined"/>
			</xsl:when>
			<xsl:when test="$s='Statistics'">
				<xsl:value-of select="$valStatistics"/>
			</xsl:when>
			<xsl:when test="$s='GraphOccurrences'">
				<xsl:value-of select="$valGraphOccurrences"/>
			</xsl:when>
			<!--Table headings for the Fields -->
			<xsl:when test="$s='TableName'">
				<xsl:value-of select="$valTableName"/>
			</xsl:when>
			<xsl:when test="$s='FieldName'">
				<xsl:value-of select="$valFieldName"/>
			</xsl:when>
			<xsl:when test="$s='Type'">
				<xsl:value-of select="$valType"/>
			</xsl:when>
			<xsl:when test="$s='Options'">
				<xsl:value-of select="$valOptions"/>
			</xsl:when>
			<xsl:when test="$s='Comments'">
				<xsl:value-of select="$valComments"/>
			</xsl:when>
			<xsl:when test="$s='OnLayouts'">
				<xsl:value-of select="$valOnLayouts"/>
			</xsl:when>
			<xsl:when test="$s='InRelationships'">
				<xsl:value-of select="$valInRelationships"/>
			</xsl:when>
			<xsl:when test="$s='InScripts'">
				<xsl:value-of select="$valInScripts"/>
			</xsl:when>
			<xsl:when test="$s='InValueLists'">
				<xsl:value-of select="$valInValueLists"/>
			</xsl:when>
			<xsl:when test="$s='AutoEnter'">
				<xsl:value-of select="$valAutoEnter"/>
			</xsl:when>
			<xsl:when test="$s='Validation'">
				<xsl:value-of select="$valValidation"/>
			</xsl:when>
			<xsl:when test="$s='Storage'">
				<xsl:value-of select="$valStorage"/>
			</xsl:when>
			<xsl:when test="$s='DataTypeText'">
				<xsl:value-of select="$valDataTypeText"/>
			</xsl:when>
			<xsl:when test="$s='DataTypeNumber'">
				<xsl:value-of select="$valDataTypeNumber"/>
			</xsl:when>
			<xsl:when test="$s='DataTypeDate'">
				<xsl:value-of select="$valDataTypeDate"/>
			</xsl:when>
			<xsl:when test="$s='DataTypeTime'">
				<xsl:value-of select="$valDataTypeTime"/>
			</xsl:when>
			<xsl:when test="$s='DataTypeTimeStamp'">
				<xsl:value-of select="$valDataTypeTimeStamp"/>
			</xsl:when>
			<xsl:when test="$s='DataTypeBinary'">
				<xsl:value-of select="$valDataTypeBinary"/>
			</xsl:when>
			<xsl:when test="$s='Repetitions'">
				<xsl:value-of select="$valRepetitions"/>
			</xsl:when>
			<xsl:when test="$s='IndexLanguage'">
				<xsl:value-of select="$valIndexLanguage"/>
			</xsl:when>
			<xsl:when test="$s='TableViewVisible'">
				<xsl:value-of select="$valTableViewVisible"/>
			</xsl:when>
			<xsl:when test="$s='TableViewNotVisible'">
				<xsl:value-of select="$valTableViewNotVisible"/>
			</xsl:when>
			<!-- AutoEnter values -->
			<xsl:when test="$s='CreationTime'">
				<xsl:value-of select="$valCreationTime"/>
			</xsl:when>
			<xsl:when test="$s='CreationDate'">
				<xsl:value-of select="$valCreationDate"/>
			</xsl:when>
			<xsl:when test="$s='CreationTimeStamp'">
				<xsl:value-of select="$valCreationTimeStamp"/>
			</xsl:when>
			<xsl:when test="$s='CreationName'">
				<xsl:value-of select="$valCreationName"/>
			</xsl:when>
			<xsl:when test="$s='CreationAccountName'">
				<xsl:value-of select="$valCreationAccountName"/>
			</xsl:when>
			<xsl:when test="$s='ModificationDate'">
				<xsl:value-of select="$valModificationDate"/>
			</xsl:when>
			<xsl:when test="$s='ModificationTime'">
				<xsl:value-of select="$valModificationTime"/>
			</xsl:when>
			<xsl:when test="$s='ModificationTimeStamp'">
				<xsl:value-of select="$valModificationTimeStamp"/>
			</xsl:when>
			<xsl:when test="$s='ModificationName'">
				<xsl:value-of select="$valModificationName"/>
			</xsl:when>
			<xsl:when test="$s='ModificationAccountName'">
				<xsl:value-of select="$valModificationAccountName"/>
			</xsl:when>
			<xsl:when test="$s='PreviousRecord'">
				<xsl:value-of select="$valPreviousRecord"/>
			</xsl:when>
			<xsl:when test="$s='ConstantData'">
				<xsl:value-of select="$valConstantData"/>
			</xsl:when>
			<xsl:when test="$s='AllowEditing'">
				<xsl:value-of select="$valAllowEditing"/>
			</xsl:when>
			<xsl:when test="$s='AlwaysEvaluate'">
				<xsl:value-of select="$valAlwaysEvaluate"/>
			</xsl:when>
			<xsl:when test="$s='Serial'">
				<xsl:value-of select="$valSerial"/>
			</xsl:when>
			<xsl:when test="$s='Generate'">
				<xsl:value-of select="$valGenerate"/>
			</xsl:when>
			<xsl:when test="$s='OnCommit'">
				<xsl:value-of select="$valOnCommit"/>
			</xsl:when>
			<xsl:when test="$s='OnCreate'">
				<xsl:value-of select="$valOnCreate"/>
			</xsl:when>
			<xsl:when test="$s='NextValue'">
				<xsl:value-of select="$valNextValue"/>
			</xsl:when>
			<xsl:when test="$s='Increment'">
				<xsl:value-of select="$valIncrement"/>
			</xsl:when>
			<xsl:when test="$s='Global'">
				<xsl:value-of select="$valGlobal"/>
			</xsl:when>
			<!--Storage-->
			<xsl:when test="$s='Indexing'">
				<xsl:value-of select="$valIndexing"/>
			</xsl:when>
			<xsl:when test="$s='AutoTurnIndexOn'">
				<xsl:value-of select="$valAutoTurnIndexOn"/>
			</xsl:when>
			<!--Validation values -->
			<xsl:when test="$s='AlwaysValidate'">
				<xsl:value-of select="$valAlwaysValidate"/>
			</xsl:when>
			<xsl:when test="$s='OnlyDuringDataEntry'">
				<xsl:value-of select="$valOnlyDuringDataEntry"/>
			</xsl:when>
			<xsl:when test="$s='AlwaysValidateCalc'">
				<xsl:value-of select="$valAlwaysValidateCalc"/>
			</xsl:when>
			<xsl:when test="$s='StrictDataType'">
				<xsl:value-of select="$valStrictDataType"/>
			</xsl:when>
			<xsl:when test="$s='FourDigitYear'">
				<xsl:value-of select="$valFourDigitYear"/>
			</xsl:when>
			<xsl:when test="$s='Numeric'">
				<xsl:value-of select="$valNumeric"/>
			</xsl:when>
			<xsl:when test="$s='TimeOfDay'">
				<xsl:value-of select="$valTimeOfDay"/>
			</xsl:when>
			<xsl:when test="$s='NotEmpty'">
				<xsl:value-of select="$valNotEmpty"/>
			</xsl:when>
			<xsl:when test="$s='Unique'">
				<xsl:value-of select="$valUnique"/>
			</xsl:when>
			<xsl:when test="$s='Existing'">
				<xsl:value-of select="$valExisting"/>
			</xsl:when>
			<xsl:when test="$s='ValueList'">
				<xsl:value-of select="$valValueList"/>
			</xsl:when>
			<xsl:when test="$s='Range'">
				<xsl:value-of select="$valRange"/>
			</xsl:when>
			<xsl:when test="$s='MaxDataLength'">
				<xsl:value-of select="$valMaxDataLength"/>
			</xsl:when>
			<xsl:when test="$s='StrictValidation'">
				<xsl:value-of select="$valStrictValidation"/>
			</xsl:when>
			<xsl:when test="$s='ErrorMessage'">
				<xsl:value-of select="$valErrorMessage"/>
			</xsl:when>
			<!-- Lookup values -->
			<xsl:when test="$s='Lookup'">
				<xsl:value-of select="$valLookup"/>
			</xsl:when>
			<xsl:when test="$s='DoNotCopy'">
				<xsl:value-of select="$valDoNotCopy"/>
			</xsl:when>
			<xsl:when test="$s='CopyNextHigher'">
				<xsl:value-of select="$valCopyNextHigher"/>
			</xsl:when>
			<xsl:when test="$s='CopyNextLower'">
				<xsl:value-of select="$valCopyNextLower"/>
			</xsl:when>
			<xsl:when test="$s='CopyConstant'">
				<xsl:value-of select="$valCopyConstant"/>
			</xsl:when>
			<xsl:when test="$s='DoNotCopyContent'">
				<xsl:value-of select="$valDoNotCopyContent"/>
			</xsl:when>
			<!--Summary information -->
			<xsl:when test="$s='Total'">
				<xsl:value-of select="$valTotal"/>
			</xsl:when>
			<xsl:when test="$s='RunningTotal'">
				<xsl:value-of select="$valRunningTotal"/>
			</xsl:when>
			<xsl:when test="$s='Average'">
				<xsl:value-of select="$valAverage"/>
			</xsl:when>
			<xsl:when test="$s='WeightedAverage'">
				<xsl:value-of select="$valWeightedAverage"/>
			</xsl:when>
			<xsl:when test="$s='Count'">
				<xsl:value-of select="$valCount"/>
			</xsl:when>
			<xsl:when test="$s='RunningCount'">
				<xsl:value-of select="$valRunningCount"/>
			</xsl:when>
			<xsl:when test="$s='Minimum'">
				<xsl:value-of select="$valMinimum"/>
			</xsl:when>
			<xsl:when test="$s='Maximum'">
				<xsl:value-of select="$valMaximum"/>
			</xsl:when>
			<xsl:when test="$s='StdDeviation'">
				<xsl:value-of select="$valStdDeviation"/>
			</xsl:when>
			<xsl:when test="$s='StdDeviationByPopulation'">
				<xsl:value-of select="$valStdDeviationByPopulation"/>
			</xsl:when>
			<xsl:when test="$s='Fractional'">
				<xsl:value-of select="$valFractional"/>
			</xsl:when>
			<xsl:when test="$s='FractionalSubtotal'">
				<xsl:value-of select="$valFractionalSubtotal"/>
			</xsl:when>
			<xsl:when test="$s='SummaryField'">
				<xsl:value-of select="$valSummaryField"/>
			</xsl:when>
			<xsl:when test="$s='AdditionalField'">
				<xsl:value-of select="$valAdditionalField"/>
			</xsl:when>
			<xsl:when test="$s='Together'">
				<xsl:value-of select="$valTogether"/>
			</xsl:when>
			<xsl:when test="$s='Individually'">
				<xsl:value-of select="$valIndividually"/>
			</xsl:when>
			<!--Table headings for the Layouts -->
			<xsl:when test="$s='LayoutName'">
				<xsl:value-of select="$valLayoutName"/>
			</xsl:when>
			<xsl:when test="$s='AssociatedLayouts'">
				<xsl:value-of select="$valAssociatedLayouts"/>
			</xsl:when>
			<!--Field type values -->
			<xsl:when test="$s='Normal'">
				<xsl:value-of select="$valNormal"/>
			</xsl:when>
			<xsl:when test="$s='Calculated'">
				<xsl:value-of select="$valCalculated"/>
			</xsl:when>
			<xsl:when test="$s='Summary'">
				<xsl:value-of select="$valSummary"/>
			</xsl:when>
			<xsl:when test="$s='Invalid'">
				<xsl:value-of select="$valInvalid"/>
			</xsl:when>
			<xsl:when test="$s='SummaryInfo'">
				<xsl:value-of select="$valSummaryInfo"/>
			</xsl:when>
			<xsl:when test="$s='Calculation'">
				<xsl:value-of select="$valCalculation"/>
			</xsl:when>
			<!-- Relationships -->
			<!--Plural-->
			<xsl:when test="$s='TableOccurrences'">
				<xsl:value-of select="$valTableOccurrences"/>
			</xsl:when>
			<!--Singular-->
			<xsl:when test="$s='TableOccurrence'">
				<xsl:value-of select="$valTableOccurrence"/>
			</xsl:when>
			<xsl:when test="$s='SourceTable'">
				<xsl:value-of select="$valSourceTable"/>
			</xsl:when>
			<xsl:when test="$s='SourceFile'">
				<xsl:value-of select="$valSourceFile"/>
			</xsl:when>
			<xsl:when test="$s='InFieldDefinitions'">
				<xsl:value-of select="$valInFieldDefinitions"/>
			</xsl:when>
			<xsl:when test="$s='Details'">
				<xsl:value-of select="$valDetails"/>
			</xsl:when>
			<xsl:when test="$s='FileReference'">
				<xsl:value-of select="$valFileReference"/>
			</xsl:when>
			<xsl:when test="$s='AllowCreationRelatedRecords'">
				<xsl:value-of select="$valAllowCreationRelatedRecords"/>
			</xsl:when>
			<xsl:when test="$s='AllowDeleteRelatedRecords'">
				<xsl:value-of select="$valAllowDeleteRelatedRecords"/>
			</xsl:when>
			<xsl:when test="$s='SortRecords'">
				<xsl:value-of select="$valSortRecords"/>
			</xsl:when>
			<xsl:when test="$s='FilterCalc'">
				<xsl:value-of select="$valFilterCalc"/>
			</xsl:when>
			<!-- Relationship -->
			<xsl:when test="$s='Infinite'">
				<xsl:value-of select="$valInfinite"/>
			</xsl:when>
			<xsl:when test="$s='And'">
				<xsl:value-of select="$valAnd"/>
			</xsl:when>
			<xsl:when test="$s='Equal'">
				<xsl:value-of select="$valEqual"/>
			</xsl:when>
			<xsl:when test="$s='NotEqual'">
				<xsl:value-of select="$valNotEqual"/>
			</xsl:when>
			<xsl:when test="$s='LessThan'">
				<xsl:value-of select="$valLessThan"/>
			</xsl:when>
			<xsl:when test="$s='LessThanOrEqualTo'">
				<xsl:value-of select="$valLessThanOrEqualTo"/>
			</xsl:when>
			<xsl:when test="$s='GreaterThan'">
				<xsl:value-of select="$valGreaterThan"/>
			</xsl:when>
			<xsl:when test="$s='GreaterThanOrEqualTo'">
				<xsl:value-of select="$valGreaterThanOrEqualTo"/>
			</xsl:when>
			<xsl:when test="$s='CartesianProduct'">
				<xsl:value-of select="$valCartesianProduct"/>
			</xsl:when>
			<!--Yes, No -->
			<xsl:when test="$s='Yes'">
				<xsl:value-of select="$valYes"/>
			</xsl:when>
			<xsl:when test="$s='No'">
				<xsl:value-of select="$valNo"/>
			</xsl:when>
			<xsl:when test="$s='GroupButton'">
				<xsl:value-of select="$valGroupButton"/>
			</xsl:when>
			<!--Languages-->
			<xsl:when test="$s='Default'">
				<xsl:value-of select="$valDefault"/>
			</xsl:when>
			<xsl:when test="$s='Unicode_Raw'">
				<xsl:value-of select="$valUnicode_Raw"/>
			</xsl:when>
			<xsl:when test="$s='Unicode_Standard'">
				<xsl:value-of select="$valUnicode_Standard"/>
			</xsl:when>
			<xsl:when test="$s='Catalog'">
				<xsl:value-of select="$valCatalog"/>
			</xsl:when>
			<xsl:when test="$s='Catalan'">
				<xsl:value-of select="$valCatalan"/>
			</xsl:when>
			<xsl:when test="$s='Croatian'">
				<xsl:value-of select="$valCroatian"/>
			</xsl:when>
			<xsl:when test="$s='Czech'">
				<xsl:value-of select="$valCzech"/>
			</xsl:when>
			<xsl:when test="$s='Danish'">
				<xsl:value-of select="$valDanish"/>
			</xsl:when>
			<xsl:when test="$s='Dutch'">
				<xsl:value-of select="$valDutch"/>
			</xsl:when>
			<xsl:when test="$s='English'">
				<xsl:value-of select="$valEnglish"/>
			</xsl:when>
			<xsl:when test="$s='Finnish'">
				<xsl:value-of select="$valFinnish"/>
			</xsl:when>
			<xsl:when test="$s='Finnish_Custom'">
				<xsl:value-of select="$valFinnish_Custom"/>
			</xsl:when>
			<xsl:when test="$s='French'">
				<xsl:value-of select="$valFrench"/>
			</xsl:when>
			<xsl:when test="$s='German'">
				<xsl:value-of select="$valGerman"/>
			</xsl:when>
			<xsl:when test="$s='German_Dictionary'">
				<xsl:value-of select="$valGerman_Dictionary"/>
			</xsl:when>
			<xsl:when test="$s='Greek'">
				<xsl:value-of select="$valGreek"/>
			</xsl:when>
			<xsl:when test="$s='Hungarian'">
				<xsl:value-of select="$valHungarian"/>
			</xsl:when>
			<xsl:when test="$s='Icelandic'">
				<xsl:value-of select="$valIcelandic"/>
			</xsl:when>
			<xsl:when test="$s='Italian'">
				<xsl:value-of select="$valItalian"/>
			</xsl:when>
			<xsl:when test="$s='Japanese'">
				<xsl:value-of select="$valJapanese"/>
			</xsl:when>
			<xsl:when test="$s='Norwegian'">
				<xsl:value-of select="$valNorwegian"/>
			</xsl:when>
			<xsl:when test="$s='Polish'">
				<xsl:value-of select="$valPolish"/>
			</xsl:when>
			<xsl:when test="$s='Portuguese'">
				<xsl:value-of select="$valPortuguese"/>
			</xsl:when>
			<xsl:when test="$s='Romanian'">
				<xsl:value-of select="$valRomanian"/>
			</xsl:when>
			<xsl:when test="$s='Russian'">
				<xsl:value-of select="$valRussian"/>
			</xsl:when>
			<xsl:when test="$s='Slovak'">
				<xsl:value-of select="$valSlovak"/>
			</xsl:when>
			<xsl:when test="$s='Slovenian'">
				<xsl:value-of select="$valSlovenian"/>
			</xsl:when>
			<xsl:when test="$s='Spanish'">
				<xsl:value-of select="$valSpanish"/>
			</xsl:when>
			<xsl:when test="$s='Spanish_Traditional'">
				<xsl:value-of select="$valSpanish_Traditional"/>
			</xsl:when>
			<xsl:when test="$s='Swedish'">
				<xsl:value-of select="$valSwedish"/>
			</xsl:when>
			<xsl:when test="$s='Swedish_Custom'">
				<xsl:value-of select="$valSwedish_Custom"/>
			</xsl:when>
			<xsl:when test="$s='Turkish'">
				<xsl:value-of select="$valTurkish"/>
			</xsl:when>
			<xsl:when test="$s='Ukrainian'">
				<xsl:value-of select="$valUkrainian"/>
			</xsl:when>
			<xsl:when test="$s='ChinesePinYin'">
				<xsl:value-of select="$valChinesePinYin"/>
			</xsl:when>
			<xsl:when test="$s='ChineseStroke'">
				<xsl:value-of select="$valChineseStroke"/>
			</xsl:when>
			<!--Furigana -->
			<xsl:when test="$s='Furigana'">
				<xsl:value-of select="$valFurigana"/>
			</xsl:when>
			<xsl:when test="$s='UseFuriganaField'">
				<xsl:value-of select="$valUseFuriganaField"/>
			</xsl:when>
			<xsl:when test="$s='TranslateInto'">
				<xsl:value-of select="$valTranslateInto"/>
			</xsl:when>
			<xsl:when test="$s='AsIs'">
				<xsl:value-of select="$valAsIs"/>
			</xsl:when>
			<xsl:when test="$s='Hiragana'">
				<xsl:value-of select="$valHiragana"/>
			</xsl:when>
			<xsl:when test="$s='FullWidthKatakana'">
				<xsl:value-of select="$valFullWidthKatakana"/>
			</xsl:when>
			<xsl:when test="$s='FullWidthRoman'">
				<xsl:value-of select="$valFullWidthRoman"/>
			</xsl:when>
			<xsl:when test="$s='HalfWidthKatakana'">
				<xsl:value-of select="$valHalfWidthKatakana"/>
			</xsl:when>
			<xsl:when test="$s='HalfWidthRoman'">
				<xsl:value-of select="$valHalfWidthRoman"/>
			</xsl:when>
			<!--Calculation storage-->
			<xsl:when test="$s='DoNotStoreCalcResults'">
				<xsl:value-of select="$valDoNotStoreCalcResults"/>
			</xsl:when>
			<!--Field Format-->
			<xsl:when test="$s='FieldFormat'">
				<xsl:value-of select="$valFieldFormat"/>
			</xsl:when>
			<xsl:when test="$s='EditBox'">
				<xsl:value-of select="$valEditBox"/>
			</xsl:when>
			<xsl:when test="$s='PopupList'">
				<xsl:value-of select="$valPopupList"/>
			</xsl:when>
			<xsl:when test="$s='PopupMenu'">
				<xsl:value-of select="$valPopupMenu"/>
			</xsl:when>
			<xsl:when test="$s='CheckboxSet'">
				<xsl:value-of select="$valCheckboxSet"/>
			</xsl:when>
			<xsl:when test="$s='RadioButtonSet'">
				<xsl:value-of select="$valRadioButtonSet"/>
			</xsl:when>
			<xsl:when test="$s='IncludeVScrollBar'">
				<xsl:value-of select="$valIncludeVScrollBar"/>
			</xsl:when>
			<xsl:when test="$s='DisplayValFrom'">
				<xsl:value-of select="$valDisplayValFrom"/>
			</xsl:when>
			<xsl:when test="$s='IncludeOther'">
				<xsl:value-of select="$valIncludeOther"/>
			</xsl:when>
			<xsl:when test="$s='IncludeEdit'">
				<xsl:value-of select="$valIncludeEdit"/>
			</xsl:when>
			<xsl:when test="$s='ShowRepetition'">
				<xsl:value-of select="$valShowRepetition"/>
			</xsl:when>
			<xsl:when test="$s='Through'">
				<xsl:value-of select="$valThrough"/>
			</xsl:when>
			<xsl:when test="$s='Orientation'">
				<xsl:value-of select="$valOrientation"/>
			</xsl:when>
			<xsl:when test="$s='Horizontal'">
				<xsl:value-of select="$valHorizontal"/>
			</xsl:when>
			<xsl:when test="$s='Vertical'">
				<xsl:value-of select="$valVertical"/>
			</xsl:when>
			<!--Field Behaviour-->
			<xsl:when test="$s='FieldBehavior'">
				<xsl:value-of select="$valFieldBehavior"/>
			</xsl:when>
			<xsl:when test="$s='AllowFieldEnter'">
				<xsl:value-of select="$valAllowFieldEnter"/>
			</xsl:when>
			<xsl:when test="$s='InBrowseMode'">
				<xsl:value-of select="$valInBrowseMode"/>
			</xsl:when>
			<xsl:when test="$s='InFindMode'">
				<xsl:value-of select="$valInFindMode"/>
			</xsl:when>
			<xsl:when test="$s='SelectEntireContents'">
				<xsl:value-of select="$valSelectEntireContents"/>
			</xsl:when>
			<xsl:when test="$s='DisableVisualSpellChecking'">
				<xsl:value-of select="$valDisableVisualSpellChecking"/>
			</xsl:when>
			<xsl:when test="$s='SetInputMethod'">
				<xsl:value-of select="$valSetInputMethod"/>
			</xsl:when>
			<xsl:when test="$s='GoToNextField'">
				<xsl:value-of select="$valGoToNextField"/>
			</xsl:when>
			<xsl:when test="$s='TabKey'">
				<xsl:value-of select="$valTabKey"/>
			</xsl:when>
			<xsl:when test="$s='ReturnKey'">
				<xsl:value-of select="$valReturnKey"/>
			</xsl:when>
			<xsl:when test="$s='EnterKey'">
				<xsl:value-of select="$valEnterKey"/>
			</xsl:when>
			<xsl:when test="$s='SynchFieldFont'">
				<xsl:value-of select="$valSynchFieldFont"/>
			</xsl:when>
			<xsl:when test="$s='JapActive'">
				<xsl:value-of select="$valJapActive"/>
			</xsl:when>
			<xsl:when test="$s='JapDirect'">
				<xsl:value-of select="$valJapDirect"/>
			</xsl:when>
			<xsl:when test="$s='FullWidthAlpha'">
				<xsl:value-of select="$valFullWidthAlpha"/>
			</xsl:when>
			<xsl:when test="$s='HalfWidthAlpha'">
				<xsl:value-of select="$valHalfWidthAlpha"/>
			</xsl:when>
			<!-- font/fill -->
			<!-- new for 9.0 -->
			<xsl:when test="$s='FillColor'">
				<xsl:value-of select="$valFillColor"/>
			</xsl:when>
			<xsl:when test="$s='FontFaceBold'">
				<xsl:value-of select="$valFontFaceBold"/>
			</xsl:when>
			<xsl:when test="$s='FontFaceItalic'">
				<xsl:value-of select="$valFontFaceItalic"/>
			</xsl:when>
			<xsl:when test="$s='FontFaceUnderline'">
				<xsl:value-of select="$valFontFaceUnderline"/>
			</xsl:when>
			<xsl:when test="$s='FontFaceCondense'">
				<xsl:value-of select="$valFontFaceCondense"/>
			</xsl:when>
			<xsl:when test="$s='FontFaceExtend'">
				<xsl:value-of select="$valFontFaceExtend"/>
			</xsl:when>
			<xsl:when test="$s='FontFaceStrikethrough'">
				<xsl:value-of select="$valFontFaceStrikethrough"/>
			</xsl:when>
			<xsl:when test="$s='FontFaceSmallCaps'">
				<xsl:value-of select="$valFontFaceSmallCaps"/>
			</xsl:when>
			<xsl:when test="$s='FontFaceSuperscript'">
				<xsl:value-of select="$valFontFaceSuperscript"/>
			</xsl:when>
			<xsl:when test="$s='FontFaceSubscript'">
				<xsl:value-of select="$valFontFaceSubscript"/>
			</xsl:when>
			<xsl:when test="$s='FontFaceUppercase'">
				<xsl:value-of select="$valFontFaceUppercase"/>
			</xsl:when>
			<xsl:when test="$s='FontFaceLowercase'">
				<xsl:value-of select="$valFontFaceLowercase"/>
			</xsl:when>
			<xsl:when test="$s='FontFaceTitleCase'">
				<xsl:value-of select="$valFontFaceTitleCase"/>
			</xsl:when>
			<xsl:when test="$s='FontFaceWordUnderline'">
				<xsl:value-of select="$valFontFaceWordUnderline"/>
			</xsl:when>
			<xsl:when test="$s='FontFaceDoubleUnderline'">
				<xsl:value-of select="$valFontFaceDoubleUnderline"/>
			</xsl:when>
			<xsl:when test="$s='FontName'">
				<xsl:value-of select="$valFontName"/>
			</xsl:when>
			<xsl:when test="$s='FontSize'">
				<xsl:value-of select="$valFontSize"/>
			</xsl:when>
			<xsl:when test="$s='FontColor'">
				<xsl:value-of select="$valFontColor"/>
			</xsl:when>
			<xsl:when test="$s='FontStyle'">
				<xsl:value-of select="$valFontStyle"/>
			</xsl:when>
			<!-- end of new for 9.0 -->
			<!-- new for 11.0 -->
			<xsl:when test="$s='FontFaceHighlight'">
				<xsl:value-of select="$valFontFaceHighlight"/>
			</xsl:when>
			<!-- end of new for 11.0 -->
			<!--AutoEnter-->
			<xsl:when test="$s='DoNotReplaceExisting'">
				<xsl:value-of select="$valDoNotReplaceExisting"/>
			</xsl:when>
			<!--Layout Object-->
			<xsl:when test="$s='Tabs'">
				<xsl:value-of select="$valTabs"/>
			</xsl:when>
			<xsl:when test="$s='TabControls'">
				<xsl:value-of select="$valTabControls"/>
			</xsl:when>
			<xsl:when test="$s='TabObject'">
				<xsl:value-of select="$valTabObject"/>
			</xsl:when>
			<!-- new for 9.0 -->
			<xsl:when test="$s='DefaultFrontTab'">
				<xsl:value-of select="$valDefaultFrontTab"/>
			</xsl:when>
			<xsl:when test="$s='TabWidth'">
				<xsl:value-of select="$valTabWidth"/>
			</xsl:when>
			<xsl:when test="$s='LabelWidth'">
				<xsl:value-of select="$valLabelWidth"/>
			</xsl:when>
			<xsl:when test="$s='LabelWidthPlusMarginOf'">
				<xsl:value-of select="$valLabelWidthPlusMarginOf"/>
			</xsl:when>
			<xsl:when test="$s='LabelWidthWidest'">
				<xsl:value-of select="$valLabelWidthWidest"/>
			</xsl:when>
			<xsl:when test="$s='LabelWidthMinimumOf'">
				<xsl:value-of select="$valLabelWidthMinimumOf"/>
			</xsl:when>
			<xsl:when test="$s='LabelWidthFixedOf'">
				<xsl:value-of select="$valLabelWidthFixedOf"/>
			</xsl:when>
			<!-- end of new 9.0 -->
			<xsl:when test="$s='Buttons'">
				<xsl:value-of select="$valButtons"/>
			</xsl:when>
			<xsl:when test="$s='Portals'">
				<xsl:value-of select="$valPortals"/>
			</xsl:when>
			<xsl:when test="$s='Tooltip'">
				<xsl:value-of select="$valTooltip"/>
			</xsl:when>
			<xsl:when test="$s='TableView'">
				<xsl:value-of select="$valTableView"/>
			</xsl:when>
			<!-- new for 9.0 -->
			<xsl:when test="$s='DataSource'">
				<xsl:value-of select="$valDataSource"/>
			</xsl:when>
			<xsl:when test="$s='DataSources'">
				<xsl:value-of select="$valDataSources"/>
			</xsl:when>
			<xsl:when test="$s='ShadowTables'">
				<xsl:value-of select="$valShadowTables"/>
			</xsl:when>
			<xsl:when test="$s='ShadowFields'">
				<xsl:value-of select="$valShadowFields"/>
			</xsl:when>
			<xsl:when test="$s='SupplementalFields'">
				<xsl:value-of select="$valSupplementalFields"/>
			</xsl:when>
			<xsl:when test="$s='ConditionalFormatting'">
				<xsl:value-of select="$valConditionalFormatting"/>
			</xsl:when>
			<xsl:when test="$s='DetailsName'">
				<xsl:value-of select="$valDetailsName"/>
			</xsl:when>
			<xsl:when test="$s='Condition'">
				<xsl:value-of select="$valCondition"/>
			</xsl:when>
			<xsl:when test="$s='Format'">
				<xsl:value-of select="$valFormat"/>
			</xsl:when>
			<xsl:when test="$s='Formula'">
				<xsl:value-of select="$valFormula"/>
			</xsl:when>
			<xsl:when test="$s='CFAnd'">
				<xsl:value-of select="$valCFAnd"/>
			</xsl:when>
			<xsl:when test="$s='Disabled'">
				<xsl:value-of select="$valDisabled"/>
			</xsl:when>
			<xsl:when test="$s='NotApplied'">
				<xsl:value-of select="$valNotApplied"/>
			</xsl:when>
			<xsl:when test="$s='CFValueIs'">
				<xsl:value-of select="$valCFValueIs"/>
			</xsl:when>
			<xsl:when test="$s='CFBetween'">
				<xsl:value-of select="$valCFBetween"/>
			</xsl:when>
			<xsl:when test="$s='CFNotBetween'">
				<xsl:value-of select="$valCFNotBetween"/>
			</xsl:when>
			<xsl:when test="$s='CFEqualTo'">
				<xsl:value-of select="$valCFEqualTo"/>
			</xsl:when>
			<xsl:when test="$s='CFNotEqualTo'">
				<xsl:value-of select="$valCFNotEqualTo"/>
			</xsl:when>
			<xsl:when test="$s='CFGreaterThan'">
				<xsl:value-of select="$valCFGreaterThan"/>
			</xsl:when>
			<xsl:when test="$s='CFLessThan'">
				<xsl:value-of select="$valCFLessThan"/>
			</xsl:when>
			<xsl:when test="$s='CFGreaterThanOrEqualTo'">
				<xsl:value-of select="$valCFGreaterThanOrEqualTo"/>
			</xsl:when>
			<xsl:when test="$s='CFLessThanOrEqualTo'">
				<xsl:value-of select="$valCFLessThanOrEqualTo"/>
			</xsl:when>
			<xsl:when test="$s='CFContaining'">
				<xsl:value-of select="$valCFContaining"/>
			</xsl:when>
			<xsl:when test="$s='CFNotContaining'">
				<xsl:value-of select="$valCFNotContaining"/>
			</xsl:when>
			<xsl:when test="$s='CFBeginningWith'">
				<xsl:value-of select="$valCFBeginningWith"/>
			</xsl:when>
			<xsl:when test="$s='CFEndingWith'">
				<xsl:value-of select="$valCFEndingWith"/>
			</xsl:when>
			<xsl:when test="$s='CFEmpty'">
				<xsl:value-of select="$valCFEmpty"/>
			</xsl:when>
			<xsl:when test="$s='CFBeforeToday'">
				<xsl:value-of select="$valCFBeforeToday"/>
			</xsl:when>
			<xsl:when test="$s='CFToday'">
				<xsl:value-of select="$valCFToday"/>
			</xsl:when>
			<xsl:when test="$s='CFAfterToday'">
				<xsl:value-of select="$valCFAfterToday"/>
			</xsl:when>
			<!--
			Localization notice:
			The 4 strings below are meant to construct the English phrase
			"More/less than x days ahead/passed." Since different languages
			will structure this sentence differently, attention must be paid
			to make sure that the below 4 strings are localized correctly.
			
			As a guideline, in HTML we output their values like this:
			valCF[more/less]Than [number] valCFDays[Ahead/Passed].
			
			NEW NOTE: valCFLessThan was already defined.  Don't create duplicate strings!
		-->
			<xsl:when test="$s='CFMoreThan'">
				<xsl:value-of select="$valCFMoreThan"/>
			</xsl:when>
			<xsl:when test="$s='CFLessThanLET'">
				<xsl:value-of select="$valCFLessThanLET"/>
			</xsl:when>
			<xsl:when test="$s='CFDaysAhead'">
				<xsl:value-of select="$valCFDaysAhead"/>
			</xsl:when>
			<xsl:when test="$s='CFDaysPassed'">
				<xsl:value-of select="$valCFDaysPassed"/>
			</xsl:when>
			<!-- end of localization notice -->
			<xsl:when test="$s='ObjectLayoutDetails'">
				<xsl:value-of select="$valObjectLayoutDetails"/>
			</xsl:when>
			<xsl:when test="$s='AutoResizeLeftRight'">
				<xsl:value-of select="$valAutoResizeLeftRight"/>
			</xsl:when>
			<xsl:when test="$s='AutoResizeTopBottom'">
				<xsl:value-of select="$valAutoResizeTopBottom"/>
			</xsl:when>
			<xsl:when test="$s='Anchoring'">
				<xsl:value-of select="$valAnchoring"/>
			</xsl:when>
			<!-- end of new for 9.0 -->
			<xsl:when test="$s='Coordinates'">
				<xsl:value-of select="$valCoordinates"/>
			</xsl:when>
			<xsl:when test="$s='Top'">
				<xsl:value-of select="$valTop"/>
			</xsl:when>
			<xsl:when test="$s='Left'">
				<xsl:value-of select="$valLeft"/>
			</xsl:when>
			<xsl:when test="$s='Right'">
				<xsl:value-of select="$valRight"/>
			</xsl:when>
			<xsl:when test="$s='Bottom'">
				<xsl:value-of select="$valBottom"/>
			</xsl:when>
			<xsl:when test="$s='NumberOfObjects'">
				<xsl:value-of select="$valNumberOfObjects"/>
			</xsl:when>
			<xsl:when test="$s='LayoutObjects'">
				<xsl:value-of select="$valLayoutObjects"/>
			</xsl:when>
			<xsl:when test="$s='FieldObjects'">
				<xsl:value-of select="$valFieldObjects"/>
			</xsl:when>
			<xsl:when test="$s='Panel'">
				<xsl:value-of select="$valPanel"/>
			</xsl:when>
			<xsl:when test="$s='Justification'">
				<xsl:value-of select="$valJustification"/>
			</xsl:when>
			<xsl:when test="$s='Appearance'">
				<xsl:value-of select="$valAppearance"/>
			</xsl:when>
			<xsl:when test="$s='MergeFieldObjects'">
				<xsl:value-of select="$valMergeFieldObjects"/>
			</xsl:when>
			<xsl:when test="$s='PortalObject'">
				<xsl:value-of select="$valPortalObject"/>
			</xsl:when>
			<xsl:when test="$s='MergeFields'">
				<xsl:value-of select="$valMergeFields"/>
			</xsl:when>
			<xsl:when test="$s='Text'">
				<xsl:value-of select="$valText"/>
			</xsl:when>
			<xsl:when test="$s='ButtonScriptStep'">
				<xsl:value-of select="$valButtonScriptStep"/>
			</xsl:when>
			<xsl:when test="$s='ButtonObject'">
				<xsl:value-of select="$valButtonObject"/>
			</xsl:when>
			<xsl:when test="$s='Table'">
				<xsl:value-of select="$valTable"/>
			</xsl:when>
			<xsl:when test="$s='InitRow'">
				<xsl:value-of select="$valInitRow"/>
			</xsl:when>
			<xsl:when test="$s='NumOfRows'">
				<xsl:value-of select="$valNumOfRows"/>
			</xsl:when>
			<xsl:when test="$s='ShowVBar'">
				<xsl:value-of select="$valShowVBar"/>
			</xsl:when>
			<xsl:when test="$s='AllowDeletePortalRecords'">
				<xsl:value-of select="$valAllowDeletePortalRecords"/>
			</xsl:when>
			<!-- new for 9.0 -->
			<xsl:when test="$s='GraphicObjs'">
				<xsl:value-of select="$valGraphicObjs"/>
			</xsl:when>
			<!-- end of new for 9.0 -->
			<xsl:when test="$s='GraphicObject'">
				<xsl:value-of select="$valGraphicObject"/>
			</xsl:when>
			<!--Custom menus-->
			<xsl:when test="$s='CustomMenuSets'">
				<xsl:value-of select="$valCustomMenuSets"/>
			</xsl:when>
			<xsl:when test="$s='CustomMenus'">
				<xsl:value-of select="$valCustomMenus"/>
			</xsl:when>
			<xsl:when test="$s='CustomMenuSet'">
				<xsl:value-of select="$valCustomMenuSet"/>
			</xsl:when>
			<xsl:when test="$s='MenuName'">
				<xsl:value-of select="$valMenuName"/>
			</xsl:when>
			<xsl:when test="$s='MenuOptions'">
				<xsl:value-of select="$valMenuOptions"/>
			</xsl:when>
			<xsl:when test="$s='OverrideDisplayTitle'">
				<xsl:value-of select="$valOverrideDisplayTitle"/>
			</xsl:when>
			<xsl:when test="$s='MenuPlatform'">
				<xsl:value-of select="$valMenuPlatform"/>
			</xsl:when>
			<xsl:when test="$s='MenuMode'">
				<xsl:value-of select="$valMenuMode"/>
			</xsl:when>
			<xsl:when test="$s='Windows'">
				<xsl:value-of select="$valWindows"/>
			</xsl:when>
			<xsl:when test="$s='Macintosh'">
				<xsl:value-of select="$valMacintosh"/>
			</xsl:when>
			<xsl:when test="$s='Browse'">
				<xsl:value-of select="$valBrowse"/>
			</xsl:when>
			<xsl:when test="$s='Find'">
				<xsl:value-of select="$valFind"/>
			</xsl:when>
			<xsl:when test="$s='Preview'">
				<xsl:value-of select="$valPreview"/>
			</xsl:when>
			<xsl:when test="$s='MenuItems'">
				<xsl:value-of select="$valMenuItems"/>
			</xsl:when>
			<xsl:when test="$s='MenuItem'">
				<xsl:value-of select="$valMenuItem"/>
			</xsl:when>
			<xsl:when test="$s='Usage'">
				<xsl:value-of select="$valUsage"/>
			</xsl:when>
			<xsl:when test="$s='Platform'">
				<xsl:value-of select="$valPlatform"/>
			</xsl:when>
			<xsl:when test="$s='OverrideTitle'">
				<xsl:value-of select="$valOverrideTitle"/>
			</xsl:when>
			<xsl:when test="$s='OverrideAction'">
				<xsl:value-of select="$valOverrideAction"/>
			</xsl:when>
			<xsl:when test="$s='OverrideShortcut'">
				<xsl:value-of select="$valOverrideShortcut"/>
			</xsl:when>
			<xsl:when test="$s='Menus'">
				<xsl:value-of select="$valMenus"/>
			</xsl:when>
			<xsl:when test="$s='MenuSets'">
				<xsl:value-of select="$valMenuSets"/>
			</xsl:when>
			<xsl:when test="$s='InLayouts'">
				<xsl:value-of select="$valInLayouts"/>
			</xsl:when>
			<xsl:when test="$s='Command'">
				<xsl:value-of select="$valCommand"/>
			</xsl:when>
			<xsl:when test="$s='SubMenu'">
				<xsl:value-of select="$valSubMenu"/>
			</xsl:when>
			<xsl:when test="$s='Separator'">
				<xsl:value-of select="$valSeparator"/>
			</xsl:when>
			<xsl:when test="$s='MissingField'">
				<xsl:value-of select="$valMissingField"/>
			</xsl:when>
			<xsl:when test="$s='MissingLayout'">
				<xsl:value-of select="$valMissingLayout"/>
			</xsl:when>
			<xsl:when test="$s='MissingValueList'">
				<xsl:value-of select="$valMissingValueList"/>
			</xsl:when>
			<xsl:when test="$s='MissingCustomFunction'">
				<xsl:value-of select="$valMissingCustomFunction"/>
			</xsl:when>
			<xsl:when test="$s='MissingFileReference'">
				<xsl:value-of select="$valMissingFileReference"/>
			</xsl:when>
			<xsl:when test="$s='MissingBaseTable'">
				<xsl:value-of select="$valMissingBaseTable"/>
			</xsl:when>
			<xsl:when test="$s='MissingAccount'">
				<xsl:value-of select="$valMissingAccount"/>
			</xsl:when>
			<xsl:when test="$s='MissingExtendedPrivilege'">
				<xsl:value-of select="$valMissingExtendedPrivilege"/>
			</xsl:when>
			<xsl:when test="$s='MissingScript'">
				<xsl:value-of select="$valMissingScript"/>
			</xsl:when>
			<xsl:when test="$s='MissingCustomMenuSet'">
				<xsl:value-of select="$valMissingCustomMenuSet"/>
			</xsl:when>
			<xsl:when test="$s='MissingCustomMenu'">
				<xsl:value-of select="$valMissingCustomMenu"/>
			</xsl:when>
			<xsl:when test="$s='MissingTableOccurrence'">
				<xsl:value-of select="$valMissingTableOccurrence"/>
			</xsl:when>
			<xsl:when test="$s='MissingPrivilegeSet'">
				<xsl:value-of select="$valMissingPrivilegeSet"/>
			</xsl:when>
			<xsl:when test="$s='ShowValuesOnlyFromSecondField'">
				<xsl:value-of select="$valShowValuesOnlyFromSecondField"/>
			</xsl:when>
			<xsl:when test="$s='ShowValuesOnlyFromPrimaryField'">
				<xsl:value-of select="$valShowValuesOnlyFromPrimaryField"/>
			</xsl:when>
			<xsl:when test="$s='PrimaryField'">
				<xsl:value-of select="$valPrimaryField"/>
			</xsl:when>
			<xsl:when test="$s='SecondaryField'">
				<xsl:value-of select="$valSecondaryField"/>
			</xsl:when>
			<xsl:when test="$s='SortByFirstField'">
				<xsl:value-of select="$valSortByFirstField"/>
			</xsl:when>
			<xsl:when test="$s='SortBySecondField'">
				<xsl:value-of select="$valSortBySecondField"/>
			</xsl:when>
			<xsl:when test="$s='RestartForEachSelectedGroup'">
				<xsl:value-of select="$valRestartForEachSelectedGroup"/>
			</xsl:when>
			<xsl:when test="$s='Ctrl'">
				<xsl:value-of select="$valCtrl"/>
			</xsl:when>
			<xsl:when test="$s='Shift'">
				<xsl:value-of select="$valShift"/>
			</xsl:when>
			<xsl:when test="$s='Alt'">
				<xsl:value-of select="$valAlt"/>
			</xsl:when>
			<xsl:when test="$s='PageUp'">
				<xsl:value-of select="$valPageUp"/>
			</xsl:when>
			<xsl:when test="$s='PageDown'">
				<xsl:value-of select="$valPageDown"/>
			</xsl:when>
			<xsl:when test="$s='End'">
				<xsl:value-of select="$valEnd"/>
			</xsl:when>
			<xsl:when test="$s='Home'">
				<xsl:value-of select="$valHome"/>
			</xsl:when>
			<xsl:when test="$s='LeftArrow'">
				<xsl:value-of select="$valLeftArrow"/>
			</xsl:when>
			<xsl:when test="$s='UpArrow'">
				<xsl:value-of select="$valUpArrow"/>
			</xsl:when>
			<xsl:when test="$s='RightArrow'">
				<xsl:value-of select="$valRightArrow"/>
			</xsl:when>
			<xsl:when test="$s='DownArrow'">
				<xsl:value-of select="$valDownArrow"/>
			</xsl:when>
			<xsl:when test="$s='Insert'">
				<xsl:value-of select="$valInsert"/>
			</xsl:when>
			<xsl:when test="$s='Delete'">
				<xsl:value-of select="$valDelete"/>
			</xsl:when>
			<xsl:when test="$s='Help'">
				<xsl:value-of select="$valHelp"/>
			</xsl:when>
			<xsl:when test="$s='F1'">
				<xsl:value-of select="$valF1"/>
			</xsl:when>
			<xsl:when test="$s='F2'">
				<xsl:value-of select="$valF2"/>
			</xsl:when>
			<xsl:when test="$s='F3'">
				<xsl:value-of select="$valF3"/>
			</xsl:when>
			<xsl:when test="$s='F4'">
				<xsl:value-of select="$valF4"/>
			</xsl:when>
			<xsl:when test="$s='F5'">
				<xsl:value-of select="$valF5"/>
			</xsl:when>
			<xsl:when test="$s='F6'">
				<xsl:value-of select="$valF6"/>
			</xsl:when>
			<xsl:when test="$s='F7'">
				<xsl:value-of select="$valF7"/>
			</xsl:when>
			<xsl:when test="$s='F8'">
				<xsl:value-of select="$valF8"/>
			</xsl:when>
			<xsl:when test="$s='F9'">
				<xsl:value-of select="$valF9"/>
			</xsl:when>
			<xsl:when test="$s='F10'">
				<xsl:value-of select="$valF10"/>
			</xsl:when>
			<xsl:when test="$s='F11'">
				<xsl:value-of select="$valF11"/>
			</xsl:when>
			<xsl:when test="$s='F12'">
				<xsl:value-of select="$valF12"/>
			</xsl:when>
			<xsl:when test="$s='F13'">
				<xsl:value-of select="$valF13"/>
			</xsl:when>
			<xsl:when test="$s='F14'">
				<xsl:value-of select="$valF14"/>
			</xsl:when>
			<xsl:when test="$s='F15'">
				<xsl:value-of select="$valF15"/>
			</xsl:when>
			<xsl:when test="$s='Back'">
				<xsl:value-of select="$valBack"/>
			</xsl:when>
			<xsl:when test="$s='Clear'">
				<xsl:value-of select="$valClear"/>
			</xsl:when>
			<xsl:when test="$s='Escape'">
				<xsl:value-of select="$valEscape"/>
			</xsl:when>
			<xsl:when test="$s='Tab'">
				<xsl:value-of select="$valTab"/>
			</xsl:when>
			<xsl:when test="$s='Space'">
				<xsl:value-of select="$valSpace"/>
			</xsl:when>
			<xsl:when test="$s='Return'">
				<xsl:value-of select="$valReturn"/>
			</xsl:when>
			<xsl:when test="$s='Capital'">
				<xsl:value-of select="$valCapital"/>
			</xsl:when>
			<xsl:when test="$s='Enter'">
				<xsl:value-of select="$valEnter"/>
			</xsl:when>
			<xsl:when test="$s='Rounded'">
				<xsl:value-of select="$valRounded"/>
			</xsl:when>
			<xsl:when test="$s='Square'">
				<xsl:value-of select="$valSquare"/>
			</xsl:when>
			<xsl:when test="$s='Center'">
				<xsl:value-of select="$valCenter"/>
			</xsl:when>
			<xsl:when test="$s='Full'">
				<xsl:value-of select="$valFull"/>
			</xsl:when>
			<xsl:when test="$s='DropdownCalendar'">
				<xsl:value-of select="$valDropdownCalendar"/>
			</xsl:when>
			<xsl:when test="$s='SelectionList'">
				<xsl:value-of select="$valSelectionList"/>
			</xsl:when>
			<xsl:when test="$s='IncludeInMenu'">
				<xsl:value-of select="$valIncludeInMenu"/>
			</xsl:when>
			<xsl:when test="$s='QuickFind'">
				<xsl:value-of select="$valQuickFind"/>
			</xsl:when>
			<xsl:when test="$s='HandCursor'">
				<xsl:value-of select="$valHandCursor"/>
			</xsl:when>
			<xsl:when test="$s='ContextTable'">
				<xsl:value-of select="$valContextTable"/>
			</xsl:when>
			<xsl:when test="$s='AllStandardMenus'">
				<xsl:value-of select="$valAllStandardMenus"/>
			</xsl:when>
			<xsl:when test="$s='ResetScrollBarAfterExit'">
				<xsl:value-of select="$valResetScrollBarAfterExit"/>
			</xsl:when>
			<xsl:when test="$s='AutoCompleteUsingValueList'">
				<xsl:value-of select="$valAutoCompleteUsingValueList"/>
			</xsl:when>
			<xsl:when test="$s='AutoCompletePreviousValues'">
				<xsl:value-of select="$valAutoCompletePreviousValues"/>
			</xsl:when>
			<xsl:when test="$s='IncludeDropIcon'">
				<xsl:value-of select="$valIncludeDropIcon"/>
			</xsl:when>
			<xsl:when test="$s='IncludeArrow'">
				<xsl:value-of select="$valIncludeArrow"/>
			</xsl:when>
			<xsl:when test="$s='DefaultCustomMenuSet'">
				<xsl:value-of select="$valDefaultCustomMenuSet"/>
			</xsl:when>
			<xsl:when test="$s='CustomMenuSetUsedByScript'">
				<xsl:value-of select="$valCustomMenuSetUsedByScript"/>
			</xsl:when>
			<xsl:when test="$s='BaseMenu'">
				<xsl:value-of select="$valBaseMenu"/>
			</xsl:when>
			<xsl:when test="$s='FileDefault'">
				<xsl:value-of select="$valFileDefault"/>
			</xsl:when>
			<xsl:when test="$s='DefaultMenuTitle'">
				<xsl:value-of select="$valDefaultMenuTitle"/>
			</xsl:when>
			<xsl:when test="$s='At'">
				<xsl:value-of select="$valAt"/>
			</xsl:when>
			<xsl:when test="$s='AtTime'">
				<xsl:value-of select="$valAtTime"/>
			</xsl:when>
			<!--Newly added strings for 8.5-->
			<xsl:when test="$s='FieldProperties'">
				<xsl:value-of select="$valFieldProperties"/>
			</xsl:when>
			<xsl:when test="$s='ObjectName'">
				<xsl:value-of select="$valObjectName"/>
			</xsl:when>
			<xsl:when test="$s='ButtonProperties'">
				<xsl:value-of select="$valButtonProperties"/>
			</xsl:when>
			<xsl:when test="$s='AdditionalProperties'">
				<xsl:value-of select="$valAdditionalProperties"/>
			</xsl:when>
			<xsl:when test="$s='PortalProperties'">
				<xsl:value-of select="$valPortalProperties"/>
			</xsl:when>
			<xsl:when test="$s='TabProperties'">
				<xsl:value-of select="$valTabProperties"/>
			</xsl:when>
			<xsl:when test="$s='Panels'">
				<xsl:value-of select="$valPanels"/>
			</xsl:when>
			<xsl:when test="$s='PanelProperties'">
				<xsl:value-of select="$valPanelProperties"/>
			</xsl:when>
			<xsl:when test="$s='WebControls'">
				<xsl:value-of select="$valWebControls"/>
			</xsl:when>
			<xsl:when test="$s='GraphicObjectProperties'">
				<xsl:value-of select="$valGraphicObjectProperties"/>
			</xsl:when>
			<xsl:when test="$s='RegularFields'">
				<xsl:value-of select="$valRegularFields"/>
			</xsl:when>
			<xsl:when test="$s='WebControlProperties'">
				<xsl:value-of select="$valWebControlProperties"/>
			</xsl:when>
			<xsl:when test="$s='WebAddress'">
				<xsl:value-of select="$valWebAddress"/>
			</xsl:when>
			<xsl:when test="$s='DisplayContentFindMode'">
				<xsl:value-of select="$valDisplayContentFindMode"/>
			</xsl:when>
			<xsl:when test="$s='AllowInteractWebViewer'">
				<xsl:value-of select="$valAllowInteractWebViewer"/>
			</xsl:when>
			<!-- new for 9.0 -->
			<xsl:when test="$s='DisplayProgressBar'">
				<xsl:value-of select="$valDisplayProgressBar"/>
			</xsl:when>
			<xsl:when test="$s='DisplayStatusMessages'">
				<xsl:value-of select="$valDisplayStatusMessages"/>
			</xsl:when>
			<!-- end of new for 9.0 -->
			<xsl:when test="$s='ResortLanguage'">
				<xsl:value-of select="$valResortLanguage"/>
			</xsl:when>
			<xsl:when test="$s='ExternalObjects'">
				<xsl:value-of select="$valExternalObjects"/>
			</xsl:when>
			<xsl:when test="$s='ExternalObjectProperties'">
				<xsl:value-of select="$valExternalObjectProperties"/>
			</xsl:when>
			<xsl:when test="$s='Calculations'">
				<xsl:value-of select="$valCalculations"/>
			</xsl:when>
			<xsl:when test="$s='Rectangular'">
				<xsl:value-of select="$valRectangular"/>
			</xsl:when>
			<!-- Script Navigation -->
			<!-- new for 9.0 -->
			<xsl:when test="$s='PreviousScript'">
				<xsl:value-of select="$valPreviousScript"/>
			</xsl:when>
			<xsl:when test="$s='ParentGroup'">
				<xsl:value-of select="$valParentGroup"/>
			</xsl:when>
			<xsl:when test="$s='NextScript'">
				<xsl:value-of select="$valNextScript"/>
			</xsl:when>
			<!-- end of new for 9.0 -->
			<!-- new for 9.0 -->
			<xsl:when test="$s='Shadow'">
				<xsl:value-of select="$valShadow"/>
			</xsl:when>
			<xsl:when test="$s='Supplemental'">
				<xsl:value-of select="$valSupplemental"/>
			</xsl:when>
			<!-- end of new for 9.0 -->
			<!-- Script Triggers -->
			<!-- new for 10.0 -->
			<xsl:when test="$s='ScriptTriggers'">
				<xsl:value-of select="$valScriptTriggers"/>
			</xsl:when>
			<xsl:when test="$s='Modes'">
				<xsl:value-of select="$valModes"/>
			</xsl:when>
			<xsl:when test="$s='ModeBrowse'">
				<xsl:value-of select="$valModeBrowse"/>
			</xsl:when>
			<xsl:when test="$s='ModeFind'">
				<xsl:value-of select="$valModeFind"/>
			</xsl:when>
			<xsl:when test="$s='ModePreview'">
				<xsl:value-of select="$valModePreview"/>
			</xsl:when>
			<xsl:when test="$s='ScriptItem'">
				<xsl:value-of select="$valScriptItem"/>
			</xsl:when>
			<xsl:when test="$s='FromFileItem'">
				<xsl:value-of select="$valFromFileItem"/>
			</xsl:when>
			<xsl:when test="$s='ParameterItem'">
				<xsl:value-of select="$valParameterItem"/>
			</xsl:when>
			<!-- end of new 10.0 -->
			<!-- File Access Section / Authorized Files Catalog -->
			<xsl:when test="$s='Security'">
				<xsl:value-of select="$valSecurity"/>
			</xsl:when>
			<xsl:when test="$s='FileAccess'">
				<xsl:value-of select="$valFileAccess"/>
			</xsl:when>
			<xsl:when test="$s='FileAccessInboundOutbound'">
				<xsl:value-of select="$valFileAccessInboundOutbound"/>
			</xsl:when>
			<xsl:when test="$s='FileAccessOptions'">
				<xsl:value-of select="$valFileAccessOptions"/>
			</xsl:when>
			<xsl:when test="$s='FileAccessRequireV2'">
				<xsl:value-of select="$valFileAccessRequireV2"/>
			</xsl:when>
			<xsl:when test="$s='FileAccessRequireAuth'">
				<xsl:value-of select="$valFileAccessRequireAuth"/>
			</xsl:when>
			<xsl:when test="$s='FileAccessInbound'">
				<xsl:value-of select="$valFileAccessInbound"/>
			</xsl:when>
			<xsl:when test="$s='FileAccessInboundFiles'">
				<xsl:value-of select="$valFileAccessInboundFiles"/>
			</xsl:when>
			<xsl:when test="$s='FileAccessAuthUser'">
				<xsl:value-of select="$valFileAccessAuthUser"/>
			</xsl:when>
			<xsl:when test="$s='FileAccessAuthDate'">
				<xsl:value-of select="$valFileAccessAuthDate"/>
			</xsl:when>
			<xsl:when test="$s='FileAccessOutbound'">
				<xsl:value-of select="$valFileAccessOutbound"/>
			</xsl:when>
			<xsl:when test="$s='FileAccessOutboundFiles'">
				<xsl:value-of select="$valFileAccessOutboundFiles"/>
			</xsl:when>
			<!-- Charting -->
			<!-- new for 11.0 -->
			<xsl:when test="$s='ChartObjects'">
				<xsl:value-of select="$valChartObjects"/>
			</xsl:when>
			<xsl:when test="$s='ChartProperties'">
				<xsl:value-of select="$valChartProperties"/>
			</xsl:when>
			<xsl:when test="$s='ChartTitle'">
				<xsl:value-of select="$valChartTitle"/>
			</xsl:when>
			<xsl:when test="$s='ChartLabel'">
				<xsl:value-of select="$valChartLabel"/>
			</xsl:when>
			<xsl:when test="$s='ChartValue'">
				<xsl:value-of select="$valChartValue"/>
			</xsl:when>
			<xsl:when test="$s='ChartSeries'">
				<xsl:value-of select="$valChartSeries"/>
			</xsl:when>
			<!-- vvvvvvv ACHTUNG var statt val vvvvvvv -->
			<xsl:when test="$s='ChartSourceFrom'">
				<xsl:value-of select="$varChartSourceFrom"/>
			</xsl:when>
			<xsl:when test="$s='ChartSourceTable'">
				<xsl:value-of select="$varChartSourceTable"/>
			</xsl:when>
			<xsl:when test="$s='ChartAxisInfo'">
				<xsl:value-of select="$varChartAxisInfo"/>
			</xsl:when>
			<xsl:when test="$s='ChartXAxis'">
				<xsl:value-of select="$varChartXAxis"/>
			</xsl:when>
			<xsl:when test="$s='ChartYAxis'">
				<xsl:value-of select="$varChartYAxis"/>
			</xsl:when>
			<xsl:when test="$s='ChartIncludeLegend'">
				<xsl:value-of select="$varChartIncludeLegend"/>
			</xsl:when>
			<!-- ^^^^^^^ ACHTUNG var statt val ^^^^^^^ -->
			<xsl:when test="$s='ChartTypeBar'">
				<xsl:value-of select="$valChartTypeBar"/>
			</xsl:when>
			<xsl:when test="$s='ChartTypeHBar'">
				<xsl:value-of select="$valChartTypeHBar"/>
			</xsl:when>
			<xsl:when test="$s='ChartTypeLine'">
				<xsl:value-of select="$valChartTypeLine"/>
			</xsl:when>
			<xsl:when test="$s='ChartTypeArea'">
				<xsl:value-of select="$valChartTypeArea"/>
			</xsl:when>
			<xsl:when test="$s='ChartTypePie'">
				<xsl:value-of select="$valChartTypePie"/>
			</xsl:when>
			<xsl:when test="$s='Unknown'">
				<xsl:value-of select="$valUnknown"/>
			</xsl:when>
			<xsl:when test="$s='SeriesSourceDelimited'">
				<xsl:value-of select="$valSeriesSourceDelimited"/>
			</xsl:when>
			<xsl:when test="$s='SeriesSourceCurrentFoundSet'">
				<xsl:value-of select="$valSeriesSourceCurrentFoundSet"/>
			</xsl:when>
			<xsl:when test="$s='RelatedRecords'">
				<xsl:value-of select="$valRelatedRecords"/>
			</xsl:when>
			<xsl:when test="$s='ShowDataPoints'">
				<xsl:value-of select="$valShowDataPoints"/>
			</xsl:when>
			<!-- end of new 11.0 -->
		</xsl:choose>
	</xsl:template>
	<!--END LOCALIZATION -->
</xsl:stylesheet>
