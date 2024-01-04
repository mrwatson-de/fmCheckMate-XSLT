<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====
	
	XSL-File: XMFD_Text.Lines_ListFieldsWithValidation.xsl
	
	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied field or table definitions
	
	Lists all Fields that have validation
	
	===== CHANGES HISTORY =====
	2011-11-01 MrW: renamed as 'List' function.
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
	<!-- Fields with validation  -->
	<xsl:template match="//Field[Validation/@maxLength='True' or    Validation/@valuelist='True' or    Validation/@calculation='True' or    Validation/StrictDataType or    Validation/NotEmpty/@value='True' or    Validation/Unique/@value='True' or    Validation/Existing/@value='True' or    Validation/Range or    Validation/NotEmpty/@value='True']">
		<xsl:if test="../@name">
			<xsl:value-of select="../@name"/>
			<xsl:text>::</xsl:text>
		</xsl:if>
		<xsl:value-of select="@name"/>
		<xsl:value-of select="$delimiter"/>
		<xsl:text>Validate </xsl:text>
		<xsl:if test="Validation/@type='OnlyDuringDataEntry'">
			<xsl:text>OnInput</xsl:text>
		</xsl:if>
		<xsl:if test="Validation/@type='Always'">
			<xsl:text>ALWAYS!</xsl:text>
		</xsl:if>
		<xsl:if test="Validation/StrictValidation/@value='True'">
			<xsl:text>, </xsl:text>
			<xsl:text>STRICT!</xsl:text>
		</xsl:if>
		<xsl:if test="Validation/ErrorMessage">
			<xsl:text>, </xsl:text>
			<xsl:text>Msg</xsl:text>
		</xsl:if>
		<xsl:value-of select="$delimiter"/>
		<xsl:if test="Validation/StrictDataType/@value">
			<xsl:value-of select="Validation/StrictDataType/@value"/>
			<xsl:text>, </xsl:text>
		</xsl:if>
		<xsl:if test="Validation/NotEmpty/@value='True'">
			<xsl:text>NotEmpty</xsl:text>
			<xsl:text>, </xsl:text>
		</xsl:if>
		<xsl:if test="Validation/Unique/@value='True'">
			<xsl:text>Unique</xsl:text>
			<xsl:text>, </xsl:text>
		</xsl:if>
		<xsl:if test="Validation/Existing/@value='True'">
			<xsl:text>Existing</xsl:text>
			<xsl:text>, </xsl:text>
		</xsl:if>
		<xsl:if test="Validation/@valuelist='True'">
			<xsl:text>InList="</xsl:text>
			<xsl:value-of select="Validation/ValueList/@name"/>
			<xsl:text>"</xsl:text>
			<xsl:text>, </xsl:text>
		</xsl:if>
		<xsl:if test="Validation/Range">
			<xsl:text>InRange=[</xsl:text>
			<xsl:value-of select="Validation/Range/@from"/>
			<xsl:text>..</xsl:text>
			<xsl:value-of select="Validation/Range/@to"/>
			<xsl:text>]</xsl:text>
			<xsl:text>, </xsl:text>
		</xsl:if>
		<xsl:if test="Validation/@maxLength='True'">
			<xsl:text>MaxLen=</xsl:text>
			<xsl:value-of select="Validation/MaxDataLength/@value"/>
			<xsl:text>, </xsl:text>
		</xsl:if>
		<xsl:if test="Validation/@calculation='True'">
			<xsl:text>Calculation=</xsl:text>
			<xsl:value-of select="translate(Validation/Calculation,$CRLF,' ')"/>
			<xsl:text>, </xsl:text>
		</xsl:if>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
