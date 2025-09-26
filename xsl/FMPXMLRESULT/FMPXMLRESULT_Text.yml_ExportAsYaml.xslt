<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fmpxml="http://www.filemaker.com/fmpxmlresult" version="1.0" exclude-result-prefixes="fmp">
	<!-- ===== AUTHOR =====

  (c) 2024 @mrwatson-de

  ===== PURPOSE =====

  XSL-File: FMPXMLRESULT_Text.yml_ExportAsYaml.xslt

  XML-Source: FMPXMLRESULT.xml
  XML-Grammar: FMPXMLRESULT
  XML-Content: At least one record of data

  Converts FileMaker FMPXMLRESULT XML data to YAML format.

  ===== CHANGES HISTORY =====

  (c) russell@mrwatson.de 2024
  2024-11-28 MrW: Refactored and added date formatting
  -->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" encoding="UTF-8"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.StringFunctions.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="dateFormat" select="/fmpxml:FMPXMLRESULT/fmpxml:DATABASE/@DATEFORMAT"/>
	<xsl:variable name="timeFormat" select="/fmpxml:FMPXMLRESULT/fmpxml:DATABASE/@TIMEFORMAT"/>
	<xsl:variable name="fieldCount" select="count(/fmpxml:FMPXMLRESULT/fmpxml:METADATA/fmpxml:FIELD"/>
	<!-- ===== KEYS ===== -->
	<xsl:key name="fieldByColumn" match="/fmpxml:FMPXMLRESULT/fmpxml:METADATA/fmpxml:FIELD" use="1+count(preceding-siblings::*)"/>
	<xsl:key name="fieldByName" match="/fmpxml:FMPXMLRESULT/fmpxml:METADATA/fmpxml:FIELD" use="@NAME"/>
	<!--
   ! 
   ! 
   ! ===== TEMPLATES =====
   ! 
   ! 
  -->
	<!-- Root Template: Process the FMPXMLRESULT -->
	<xsl:template match="/fmpxml:FMPXMLRESULT">
		<!-- YAML Header -->
		<xsl:text># YAML export generated from FileMaker FMPXMLRESULT XML</xsl:text>
		<xsl:value-of select="$newrecord"/>
		<!-- YAML Table -->
		<xsl:for-each select="fmpxml:RESULTSET">
			<xsl:call-template name="process-table"/>
		</xsl:for-each>
	</xsl:template>
	<!--
   ! 
   ! 
   ! NAMED TEMPLATES
   ! 
   !-->
	<!-- Process the RESULTSET TABLE -->
	<xsl:template name="process-table">
		<xsl:param name="indent" select="''"/>
		<!-- -->
		<!-- TABLE Start -->
		<!-- Iterate over ROWs -->
		<xsl:for-each select="fmpxml:ROW">
			<xsl:call-template name="process-row">
				<xsl:with-param name="indent" select="$indent"/>
			</xsl:call-template>
		</xsl:for-each>
		<!-- TABLE End -->
	</xsl:template>
	<!-- Process a single ROW element -->
	<xsl:template name="process-row">
		<xsl:param name="indent" select="''"/>
		<!-- ROW Start -->
		<xsl:text>- </xsl:text>
		<!-- Iterate over COLs -->
		<xsl:for-each select="fmpxml:COL">
			<xsl:call-template name="process-col">
				<xsl:with-param name="indent" select="$indent"/>
			</xsl:call-template>
		</xsl:for-each>
		<!-- ROW End -->
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- Process a single COL element -->
	<xsl:template name="process-col">
		<xsl:param name="indent" select="''"/>
		<xsl:param name="colPos" select="1+(count(preceding-sibling::*))"/>
		<!-- -->
		<!-- COL Start -->
		<!-- Determine field metadata -->
		<xsl:variable name="field" select="key('fieldByColumn', $colPos)"/>
		<xsl:variable name="fieldName" select="$field/@NAME"/>
		<xsl:variable name="dataType" select="$field/@TYPE"/>
		<!-- Iterate over DATA repetitions -->
		<xsl:for-each select="fmpxml:DATA">
			<xsl:call-template name="process-repetition">
				<xsl:with-param name="colPos" select="$colPos"/>
				<xsl:with-param name="fieldName" select="$fieldName"/>
				<xsl:with-param name="dataType" select="$dataType"/>
			</xsl:call-template>
		</xsl:for-each>
		<!-- COL End -->
	</xsl:template>
	<!-- Process a single REPETITION element (=DATA cell) -->
	<xsl:template name="process-repetition">
		<xsl:param name="indent" select="''"/>
		<xsl:param name="colPos" select="1"/>
		<xsl:param name="repetition" select="1+(count(preceding-sibling::*))"/>
		<xsl:param name="fieldName"/>
		<xsl:param name="dataType"/>
		<!-- -->
		<!-- REPETITION Start -->
		<!-- get key and value for YAML -->
		<xsl:variable name="fieldName_Rep">
			<xsl:value-of select="$fieldName"/>
			<!-- rep -->
			<xsl:if test="$repetition &gt; 1">
				<xsl:value-of select="concat('_',$repetition)"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="fieldValue" select="."/>
		<!-- Write Key-Value Pair -->
		<xsl:call-template name="write-key-value-pair">
			<xsl:with-param name="indent" select="$indent"/>
			<xsl:with-param name="fieldName" select="$fieldName_Rep"/>
			<xsl:with-param name="fieldValue" select="$fieldValue"/>
			<xsl:with-param name="dataType" select="$dataType"/>
		</xsl:call-template>
		<!-- REPETITION End -->
	</xsl:template>
	<!-- Write Key-Value Pair -->
	<xsl:template name="write-key-value-pair">
		<xsl:param name="indent" select="'  '"/>
		<xsl:param name="fieldName"/>
		<xsl:param name="fieldValue"/>
		<xsl:param name="dataType"/>
		<xsl:param name="dataFormat" select="''"/>
		<!-- -->
		<!-- output field name-->
		<xsl:value-of select="concat($indent,$fieldName, ': ')"/>
		<!-- output field value-->
		<!-- Handle Field Value Based on Data Type -->
		<xsl:choose>
			<xsl:when test="$dataType = 'DATE'">
				<xsl:call-template name="format-filemaker-date-time-yyyy-mm-ddThh-mm-ss">
					<xsl:with-param name="date" select="$fieldValue"/>
					<xsl:with-param name="style" select="$dataFormat"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="not($fieldValue)">
				<xsl:text>null</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$fieldValue"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>
</xsl:text>
	</xsl:template>
	<!-- Format Date -->
	<xsl:template name="format-filemaker-date-time-yyyy-mm-ddThh-mm-ss">
		<xsl:param name="date"/>
		<xsl:param name="style"/>
		<!-- -->
		<!-- Normalize Date Format -->
		<xsl:variable name="normalizedDate" select="fn.SubstituteMultiple($date, 'day.month.year|-|')"/>
		<!-- Format the Date -->
		<xsl:variable name="day" select="substring-before($normalizedDate, '-')"/>
		<xsl:variable name="rest" select="substring-after($normalizedDate, '-')"/>
		<xsl:variable name="month" select="substring-before($rest, '-')"/>
		<xsl:variable name="year" select="substring-after($rest, '-')"/>
		<!-- Output YYYY-MM-DD -->
		<xsl:value-of select="concat($year, '-', format-filemaker-date-time-format-number($month, '00'), '-', format-filemaker-date-time-format-number($day, '00'))"/>
	</xsl:template>
	<!-- 
   ! format-filemaker-date-time-yyyy-mm-ddThh-mm-ss
   !
   ! FileMaker uses the following date format letters
   !
   !    DATABASE DATEFORMAT="D.m.yyyy" TIMEFORMAT="k:mm:ss "
   !
   ! - Date format:
   !   - D = Day
   !   - m = month
   !   - y = year
   !
   ! - Time format:
   !   - k = hour
   !   - m = minutes
   !   - s = seconds
   !
   !-->
	<xsl:template name="format-filemaker-date-time-yyyy-mm-ddThh-mm-ss">
		<xsl:param name="filemaker-date-or-time-or-timestamp"/>
		<xsl:param name="filemaker-date-format"/>
		<xsl:param name="filemaker-time-format"/>
		<xsl:param name="timestamp-delimiter" select="'T'"/>
		<!-- -->
		<!--
		 ! Step 1: Normalize the format strings into a single timestamp-format, 
		 ! 
		 !    where
		 ! 
		 !      D = Day
		 !      M = Month
		 !      Y = Year
		 !      h = hours
		 !      m = minutes
		 !      s = seconds
		 !-->
		<xsl:variable name="normalized-filemaker-date-format" select="translate($filemaker-date-format, 'dmy/., $apos;', 'DMY-----')"/>
		<xsl:variable name="normalized-filemaker-time-format" select="translate($filemaker-time-format, 'HMS:., ', 'hms----')"/>
		<xsl:variable name="normalized-filemaker-timestamp-format" select="concat($normalized-filemaker-time-format,'-',$normalized-filemaker-time-format)"/>
		<!--
		 ! Step 2: Create an array of date/time elements
		 !-->
		<xsl:variable name="filemaker-date-time-elements">
			<xsl:call-template name="format-filemaker-date-time-create-elements-array">
				<xsl:with-param name="filemaker-date-or-time-or-timestamp" select="$normalized-filemaker-timestamp-format"/>
			</xsl:call-template>
		</xsl:variable>
		<!--
		 ! Step 3: Calculate the positions of the date time elements in the format
		 !-->
		<xsl:variable name="yearPos">
			<xsl:call-template name="format-filemaker-date-time-get-array-position">
				<xsl:with-param name="filemaker-date-format" select="$normalized-filemaker-timestamp-format"/>
				<xsl:with-param name="filemaker-date-format" select=" 'Y')"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="monthPos">
			<xsl:call-template name="format-filemaker-date-time-get-array-position">
				<xsl:with-param name="filemaker-date-format" select="$normalized-filemaker-timestamp-format"/>
				<xsl:with-param name="filemaker-date-format" select=" 'M')"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="dayPos">
			<xsl:call-template name="format-filemaker-date-time-get-array-position">
				<xsl:with-param name="filemaker-date-format" select="$normalized-filemaker-timestamp-format"/>
				<xsl:with-param name="filemaker-date-format" select=" 'D')"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="hourPos">
			<xsl:call-template name="format-filemaker-date-time-get-array-position">
				<xsl:with-param name="filemaker-date-format" select="$normalized-filemaker-timestamp-format"/>
				<xsl:with-param name="filemaker-date-format" select=" 'h')"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="minutePos">
			<xsl:call-template name="format-filemaker-date-time-get-array-position">
				<xsl:with-param name="filemaker-date-format" select="$normalized-filemaker-timestamp-format"/>
				<xsl:with-param name="filemaker-date-format" select=" 'm')"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="secondsPos">
			<xsl:call-template name="format-filemaker-date-time-get-array-position">
				<xsl:with-param name="filemaker-date-format" select="$normalized-filemaker-timestamp-format"/>
				<xsl:with-param name="filemaker-date-format" select=" 's')"/>
			</xsl:call-template>
		</xsl:variable>
		<!-- Step 4: Extract and zero-pad elements -->
		<xsl:variable name="year" select="format-filemaker-date-time-extract-element($filemaker-date-time-elements, $yearPos)"/>
		<xsl:variable name="month" select="format-filemaker-date-time-format-number(format-filemaker-date-time-extract-element($filemaker-date-time-elements, $monthPos), '00')"/>
		<xsl:variable name="day" select="format-filemaker-date-time-format-number(format-filemaker-date-time-extract-element($filemaker-date-time-elements, $dayPos), '00')"/>
		<xsl:variable name="hour" select="format-filemaker-date-time-format-number(format-filemaker-date-time-extract-element($filemaker-date-time-elements, $hourPos), '00')"/>
		<xsl:variable name="minute" select="format-filemaker-date-time-format-number(format-filemaker-date-time-extract-element($filemaker-date-time-elements, $minutePos), '00')"/>
		<xsl:variable name="second" select="format-filemaker-date-time-format-number(format-filemaker-date-time-extract-element($filemaker-date-time-elements, $secondPos), '00')"/>
		<!-- Step 5: Determine presence of date and time -->
		<xsl:variable name="hasDate" select="contains($format, 'Y') and contains($format, 'D')"/>
		<xsl:variable name="hasTime" select="contains($format, 'H') and contains($format, 'M')"/>
		<!-- Step 6: Output formatted date, time, or timestamp -->
		<xsl:if test="$hasDate">
			<xsl:value-of select="concat($year, '-', $month, '-', $day)"/>
		</xsl:if>
		<xsl:if test="$hasDate and $hasTime">
			<xsl:value-of select="$timestamp-delimiter"/>
		</xsl:if>
		<xsl:if test="$hasTime">
			<xsl:choose>
				<xsl:when test="$second">
					<xsl:value-of select="concat($hour, ':', $minute, ':', $second)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat($hour, ':', $minute)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<!-- Helper function: Get array position -->
	<xsl:template name="format-filemaker-date-time-get-array-position">
		<xsl:param name="normalized-filemaker-timestamp-format"/>
		<xsl:param name="filemaker-date-time-element"/>
		<!-- -->
		<xsl:variable name="prefix" select="substring-before($normalized-filemaker-timestamp-format, $filemaker-date-time-element)"/>
		<xsl:variable name="position" select="string-length($prefix) - string-length(translate($prefix, '-', '')) + 1"/>
		<!-- -->
		<xsl:value-of select="$position"/>
	</xsl:template>
	<!-- Helper function: Create elements array -->
	<xsl:template name="format-filemaker-date-time-create-elements-array">
		<xsl:param name="data"/>
		<xsl:param name="normalized-filemaker-timestamp-format"/>
		<!-- Implementation of parsing data into an array based on normalized format -->
	</xsl:template>
	<!-- Helper function: Extract element -->
	<xsl:template name="format-filemaker-date-time-extract-element">
		<xsl:param name="elements"/>
		<xsl:param name="position"/>
		<!-- Extract the nth element from the array -->
	</xsl:template>
</xsl:stylesheet>
