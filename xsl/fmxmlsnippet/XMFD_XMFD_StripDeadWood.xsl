<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!--===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMFD_XMFD_StripDeadWood.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied field or table definitions
	
	Removes 'dead wood' from field definitions, i.e. Calculations + Look-ups that are no longer active
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2013-09-09 MrW: Clone templates centralized in _inc/inc.Clone.xsl
	2011-08-10 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<!--===== TEMPLATES =====-->
	<!-- Main -->
	<xsl:template match="/">
		<xsl:apply-templates select="//Field[not(ancestor::Field)]"/>
	</xsl:template>
	<!--
	 !
	 !
	 ! AutoEnter
	 !
	 ! Creation, Modification, Serial Number clear themselves
	 !-->
	<!-- Summary fields -->
	<xsl:template match="Field[@fieldType='Summary']/AutoEnter"/>
	<!-- Calculation fields -->
	<xsl:template match="Field[@fieldType='Calculation']/AutoEnter"/>
	<!-- Inactive Data -->
	<xsl:template match="Field[@fieldType='Normal']/AutoEnter[@constant='False']/ConstantData/text()"/>
	<!-- Inactive Lookup -->
	<xsl:template match="Field[@fieldType='Normal']/AutoEnter[@lookup='False']/Lookup"/>
	<!-- Inactive Calculation -->
	<xsl:template match="Field[@fieldType='Normal']/AutoEnter[@calculation='False']/Calculation"/>
	<!--
	 !
	 !
	 ! Validation
	 !
	 ! InRange clears itself
	 !-->
	<!-- Validation ErrorMessage-->
	<xsl:template match="Field/Validation[@message='False']/ErrorMessage"/>
	<!-- Validation MaxDataLength -->
	<xsl:template match="Field/Validation[@maxLength='False']/MaxDataLength"/>
	<!-- Validation ValueList -->
	<xsl:template match="Field/Validation[@valuelist='False']/ValueList"/>
	<!-- Validation Calculation -->
	<xsl:template match="Field/Validation[@calculation='False']/Calculation"/>
</xsl:stylesheet>
