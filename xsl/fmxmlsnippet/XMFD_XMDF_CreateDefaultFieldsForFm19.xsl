<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMFD_XMDF_CreateDefaultFieldsForFm19

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied field or table definitions
	
	Creates the equivalent FMDefaultFields.xml (XMDF = FileMaker Default Fields XML).
	
	BETA Version - please test
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2020-05-19 MrW: Version 2.1 Updated to XMDF from the XMDI version to be compatible with version 2.1 in FM19
	2018-11-08 MrW: Version 1.0.1 Documented XMDI abbreviation
	2018-07-12 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"
		cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- fmxmlsnippet -->
	<xsl:template match="fmxmlsnippet">
		<FMDefaultFields>
			<xsl:attribute name="version">
				<xsl:value-of select="'2.1.0'"/>
			</xsl:attribute>
			<xsl:attribute name="Source">
				<xsl:value-of select="'19.0.1'"/>
			</xsl:attribute>
			<xsl:attribute name="locale">
				<xsl:value-of select="'English'"/>
			</xsl:attribute>
			<ObjectList>
				<xsl:apply-templates/>
			</ObjectList>
		</FMDefaultFields>
	</xsl:template>
	<!-- Field -->
	<xsl:template match="Field">
		<xsl:copy>
			<xsl:attribute name="id">
				<xsl:value-of select="1 + count(preceding-sibling::Field)"/>
			</xsl:attribute>
			<xsl:attribute name="name">
				<xsl:value-of select="@name"/>
			</xsl:attribute>
			<xsl:attribute name="fieldtype">
				<xsl:value-of select="@fieldType"/>
			</xsl:attribute>
			<xsl:attribute name="datatype">
				<xsl:value-of select="@dataType"/>
			</xsl:attribute>
			<xsl:attribute name="comment">
				<xsl:value-of select="Comment"/>
			</xsl:attribute>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>

	<!-- Remove Field Comment (see Field/@comment)-->
	<xsl:template match="Field/Comment"/>

	<!-- **Calculations** -->

	<!-- Add Calculated tag around AutoEnter/Calculation -->
	<xsl:template match="AutoEnter/Calculation">
		<Calculated>
			<xsl:copy>
				<xsl:apply-templates/>
			</xsl:copy>
		</Calculated>
	</xsl:template>

	<!-- Remove Calculation table context-->
	<xsl:template match="Calculation/@table"/>

	<!-- Add Text around Calculation text -->
	<xsl:template match="Calculation/text()">
		<Text>
			<xsl:value-of select="."/>
		</Text>
	</xsl:template>

	<!-- AutoEnter -->
	<xsl:template match="AutoEnter">
		<xsl:variable name="type">
			<xsl:choose>
				<xsl:when test="@calculation = 'True'">
					<xsl:value-of select="'Calculated'"/>
				</xsl:when>
				<xsl:when test="@lookup = 'True'">
					<xsl:value-of select="'Lookup'"/>
				</xsl:when>
				<xsl:when test="Serial">
					<xsl:value-of select="'SerialNumber'"/>
				</xsl:when>
				<xsl:when test="@value = 'PreviousRecord'">
					<xsl:value-of select="'LastVisited'"/>
				</xsl:when>
				<xsl:when test="not(@value = '')">
					<xsl:value-of select="@value"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'OTHER'"/>
					<xsl:value-of select="@value"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:if test="$type != ''">

			<xsl:copy>

				<!-- Normalize attributes -->
				<xsl:attribute name="type">
					<xsl:value-of select="$type"/>
				</xsl:attribute>

				<!-- @prohibitModification = NOT @allowEditing -->
				<xsl:attribute name="prohibitModification">
					<xsl:call-template name="NegateTrueFalse">
						<xsl:with-param name="value" select="@allowEditing"/>
					</xsl:call-template>
				</xsl:attribute>

				<!-- DEPENDENT CONTENT -->
				<xsl:choose>
					<xsl:when test="$type = 'Calculated'">
						<!-- ONLY for calculations: -->

						<!-- alwaysEvaluate -->
						<xsl:attribute name="alwaysEvaluate">
							<xsl:value-of select="@alwaysEvaluate"/>
						</xsl:attribute>

						<!-- overwriteExisting -->
						<xsl:attribute name="overwriteExisting">
							<xsl:value-of select="@overwriteExistingValue"/>
						</xsl:attribute>

					</xsl:when>
					<xsl:otherwise> </xsl:otherwise>
				</xsl:choose>

				<xsl:apply-templates/>
			</xsl:copy>
		</xsl:if>
	</xsl:template>

	<!-- Remove unnecesary Auto Enter Constant Data -->
	<xsl:template match="AutoEnter[@constant != 'True']/ConstantData"/>








	<!-- Normalize or Remove Validation -->
	<xsl:template match="Validation">
		<!--<xsl:if test="@* = 'True' or */@value = 'True' or Range">-->
		<xsl:copy>
			<xsl:attribute name="type">
				<xsl:value-of select="@type"/>
			</xsl:attribute>

			<xsl:attribute name="allowOverride">
				<xsl:call-template name="NegateTrueFalse">
					<xsl:with-param name="value" select="StrictValidation/@value"/>
				</xsl:call-template>
			</xsl:attribute>

			<xsl:if test="NotEmpty/@value = 'True'">
				<xsl:attribute name="notEmpty">
					<xsl:value-of select="'True'"/>
				</xsl:attribute>
			</xsl:if>

			<xsl:if test="Unique/@value = 'True'">
				<xsl:attribute name="unique">
					<xsl:value-of select="'True'"/>
				</xsl:attribute>
			</xsl:if>

			<xsl:if test="Existing/@value = 'True'">
				<xsl:attribute name="existing">
					<xsl:value-of select="'True'"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</xsl:copy>
		<!--</xsl:if>-->
	</xsl:template>

	<!-- Simplify (Validation/)StrictDataType to Strict and TimeOfDay to Time-->
	<xsl:template match="Validation/StrictDataType">
		<Strict>
			<xsl:choose>
				<xsl:when test="@value = 'TimeOfDay'">
					<xsl:value-of select="'Time'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="@value"/>
				</xsl:otherwise>
			</xsl:choose>
		</Strict>
	</xsl:template>

	<!-- (Validation/)Range unchanged-->

	<!-- Remove inactive Validation/ValueLists -->
	<xsl:template match="Validation[@valuelist != 'True']/ValueList"/>

	<!-- Remove inactive Validation/Calculations -->
	<xsl:template match="Validation[@calculation != 'True']/Calculation"/>

	<!-- Add Calculated tag around Validation/Calculation -->
	<xsl:template match="Validation[@calculation = 'True']/Calculation">
		<Calculated>
			<xsl:copy>
				<xsl:apply-templates/>
			</xsl:copy>
		</Calculated>
	</xsl:template>

	<!-- Remove old Validation/StrictValidation tag (see AutoEnter/@…) -->
	<xsl:template match="Validation/StrictValidation"/>

	<!-- Remove old Validation/NotEmpty tag (see AutoEnter/@…) -->
	<xsl:template match="Validation/NotEmpty"/>

	<!-- Remove old Validation/Unique tag (see AutoEnter/@…) -->
	<xsl:template match="Validation/Unique"/>

	<!-- Remove old Validation/Existing tag (see AutoEnter/@…) -->
	<xsl:template match="Validation/Existing"/>

	<!-- Rename Validation/ErrorMessage or remove if inactive -->
	<xsl:template match="Validation/ErrorMessage">
		<xsl:if test="parent::Validation/@message = 'True'">
			<Message>
				<xsl:value-of select="text()"/>
			</Message>
		</xsl:if>
	</xsl:template>

	<!-- Rename AutoEnter/Serial -> SerialNumber-->
	<xsl:template match="AutoEnter/Serial">
		<SerialNumber>
			<xsl:apply-templates select="* | @*"/>
		</SerialNumber>
	</xsl:template>



	<!-- Move Storage indexLanguage to LanguageReference -->
	<xsl:template match="Field/Storage">
		<xsl:copy>
			<xsl:attribute name="maxRepetitions">
				<xsl:value-of select="@maxRepetition"/>
			</xsl:attribute>
			<xsl:apply-templates select="* | @*"/>
			<LanguageReference>

				<xsl:attribute name="name">
					<xsl:value-of select="@indexLanguage"/>
				</xsl:attribute>

				<xsl:attribute name="id">
					<xsl:choose>
						<xsl:when test="@indexLanguage = 'Unicode'">
							<xsl:value-of select="2"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="0"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>

			</LanguageReference>
		</xsl:copy>
	</xsl:template>

	<!-- Remove Field Storage indexLanguage (See LanguageReference)-->
	<xsl:template match="Field/Storage/@indexLanguage"/>

	<!-- Remove Field Storage maxRepetition (See @maxRepetitions)-->
	<xsl:template match="Field/Storage/@maxRepetition"/>

	<!-- SUMMARY FIELDS -->

	<!--
		<Field id="37" dataType="Number" fieldType="Summary" name="Summary Total">
			<SummaryInfo restartForEachSortedGroup="False" summarizeRepetition="Together" operation="Total">
				<SummaryField>
					<Field id="28" name="Data 2 Number"/>
				</SummaryField>
			</SummaryInfo>
		</Field>

		
		<Field id="37" name="Summary Total" dataType="Number" fieldType="Summary" comment="">
			<SummaryInfo restartEachGroup="False" summarizeRepetition="Together" operation="Total">
				<SummaryField>
					<FieldReference id="8" name="com.fmi.basetable.field._fm17_ETS::Nr" repetition="1" baseTable="com.fmi.basetable._fm17_ETS"></FieldReference>
				</SummaryField>
			</SummaryInfo>
		</Field>
		
	</field>
  -->
	<xsl:template match="SummaryInfo">
		<xsl:copy>
			<!-- Rename attribute -->
			<xsl:attribute name="restartEachGroup">
				<xsl:value-of select="@restartForEachSortedGroup"/>
			</xsl:attribute>
			<xsl:apply-templates select="*|@*"/>
		</xsl:copy>
	</xsl:template>
	
	<!-- Remove renamed attribute (See SummaryInfo > @restartEachGroup) -->
	<xsl:template match="SummaryInfo/@restartForEachSortedGroup"/>
	
	<!-- Rename SummaryField or AdditionalField > Fields to FieldReferenced -->
	<xsl:template match="SummaryField/Field|AdditionalField/Field">
		<FieldReference>
			<xsl:apply-templates select="*|@*"/>
		</FieldReference>
	</xsl:template>

	<!-- FIXME Summary OPTIONS still not correct! -->






	<!-- FURIGANA -->

	<!-- Remove inactive Furigana -->
	<xsl:template match="Furigana[../AutoEnter/@furigana!='True']"/>
	
	
	<!--
	 ! NAMED TEMPLATES
	 !-->
	<xsl:template name="NegateTrueFalse">
		<xsl:param name="value"/>
		<!--  -->
		<xsl:choose>
			<xsl:when test="$value != 'True'">
				<xsl:value-of select="'True'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'False'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
