<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMFD_XMFD_FM11_UndeleteFieldsFrom1.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied field or table definitions
	
	Lists the fields in creation order, adding blank fields ("Field_nnn") where field IDs are missing, i.e. have been deleted.
	Starts at id 1 and iterates up to the maximum id.
	
	===== CHANGES HISTORY =====
	2013-08-30 MrW: Version 1.1 Renamed for FM11 where internal IDs are skipped
	2012-07-10 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<!-- ===== PARAMETER ===== -->
	<xsl:param name="DeletedFieldNamePrefix" select="'zzz_Field_'"/>
	<xsl:param name="DeletedFieldNameSuffix" select="''"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:key name="LookupFieldById" match="//Field[not(ancestor::Field)]" use="@id"/>
	<xsl:variable name="maxID" select="//Field[not(ancestor::Field) and not(preceding-sibling::Field/@id &gt;= @id) and not(following-sibling::Field/@id &gt;= @id)]/@id"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/">
		<fmxmlsnippet type="FMObjectList">
			<xsl:call-template name="UndeleteFields_iTOn">
				<xsl:with-param name="i" select="1"/>
				<xsl:with-param name="n" select="$maxID"/>
			</xsl:call-template>
		</fmxmlsnippet>
	</xsl:template>
	<!-- UndeleteFields_iTOn -->
	<xsl:template name="UndeleteFields_iTOn">
		<xsl:param name="i"/>
		<xsl:param name="n"/>
		<!--  -->
		<xsl:choose>
			<xsl:when test="$i - $n &gt; 0">
				<!-- finished -->
			</xsl:when>
			<xsl:when test="$i - 128 &gt;= 0 and $i - 32768 &lt; 0">
				<!-- skip ids from 128 to 32767, as these don't occur in FileMaker -->
				<xsl:call-template name="UndeleteFields_iTOn">
					<xsl:with-param name="i" select="$i - 128 + 32768"/>
					<xsl:with-param name="n" select="$n"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="UndeleteField">
					<xsl:with-param name="id" select="$i"/>
				</xsl:call-template>
				<!-- NEXT $i -->
				<xsl:call-template name="UndeleteFields_iTOn">
					<xsl:with-param name="i" select="$i+1"/>
					<xsl:with-param name="n" select="$n"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- UndeleteField -->
	<xsl:template name="UndeleteField">
		<xsl:param name="id"/>
		<!--  -->
		<xsl:variable name="FieldName" select="concat($DeletedFieldNamePrefix,$id,$DeletedFieldNameSuffix)"/>
		<xsl:choose>
			<xsl:when test="key('LookupFieldById',$id)">
				<xsl:copy-of select="key('LookupFieldById',$id)"/>
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
