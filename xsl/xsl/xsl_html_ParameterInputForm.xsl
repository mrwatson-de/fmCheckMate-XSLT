<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:dyn="http://exslt.org/dynamic"
	extension-element-prefixes="dyn"
	version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: xsl_html_ParameterInputForm.xsl

	XML-Source: any.xsl
	XML-Grammar: xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	XML-Content: any xslt stylesheet
	
	Creates an HTML input form for the parameters of the stylesheet.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2011-02-09 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="html" version="4.0" encoding="UTF-8"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/xsl:stylesheet">
		<xsl:if test="xsl:param">
			<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
				<head>
					<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
					<title>Input Parameters</title>
				</head>
				<body>
					<form action="#" method="get" accept-charset="utf-8">
						<xsl:for-each select="xsl:param">
							<xsl:variable name="id" select="concat('id',position())"/>
							<xsl:variable name="name" select="@name"/>
							<xsl:variable name="defaultValue">
								<xsl:choose>
									<xsl:when test="@select">
										<!-- use the dyn XSLT extension to evaluate the parameter value -->
										<xsl:value-of select="dyn:evaluate(@select)"/>
										<!--xsl:choose>
											<xsl:when test="contains(@select,$APOS)">
												<xsl:value-of select="string-before(string-after(@select,$APOS),$APOS)"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="string-before(string-after(@select,$APOS),$APOS)"/>
											</xsl:otherwise>
										</xsl:choose-->
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="."/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>
							<xsl:variable name="inputType">
								<xsl:choose>
									<xsl:when test="contains($defaultValue,$LF)">
										<xsl:value-of select="'textarea'"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="'input'"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>
							<!--  -->
							<p>
								<label for="{$id}">
									<xsl:value-of select="$name"/>
								</label>
								<xsl:choose>
									<xsl:when test="$inputType='textarea'">
										<textarea name="{$name}" rows="8" cols="80" id="{$id}">
											<xsl:value-of select="$defaultValue"/>
										</textarea>
									</xsl:when>
									<xsl:when test="$inputType='input'">
										<input type="text" name="{$name}" value="{$defaultValue}" id="{$id}"/>
									</xsl:when>
								</xsl:choose>
							</p>
						</xsl:for-each>
						<p>
							<input type="submit" value="OK"/>
						</p>
					</form>
				</body>
			</html>
		</xsl:if>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
