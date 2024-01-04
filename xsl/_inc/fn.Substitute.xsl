<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: fn.Substitute.xsl

	XML-Source: any.xml
	XML-Grammar: any
	XML-Content: any

	Substitute function like in FileMaker. 

	===== CHANGES HISTORY =====
	2011-01-13 MrW: Version 1.0
	-->
	<!-- ===== TEMPLATES ===== -->
	<!-- 
	 ! fn.Substitute function 
	 !
	 !   Substitutes the searchString with the replaceString in the text.
	 !-->
	<xsl:template name="fn.Substitute">
		<xsl:param name="text"/>
		<xsl:param name="searchString"/>
		<xsl:param name="replaceString"/>
		<!---->
		<!--xsl:value-of select="concat('fn.Substitute(',$text,',',$searchString,',',$replaceString,')')"/-->
		<xsl:choose>
			<xsl:when test="contains($text, $searchString)">
				<xsl:value-of select="substring-before($text, $searchString)"/>
				<xsl:value-of select="$replaceString"/>
				<!-- recurse -->
				<xsl:call-template name="fn.Substitute">
					<xsl:with-param name="text" select="substring-after($text, $searchString)"/>
					<xsl:with-param name="searchString" select="$searchString"/>
					<xsl:with-param name="replaceString" select="$replaceString"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	 ! "fn.SubstituteMultiple"
	 ! Performs the substitutions on the text.
	 !
	 ! Parameter substitutions is a pipe delimited string or search and replace strings, e.g.:
	 ! "Ä|AE|Ö|OE|Ü|UE|ä|ae|ö|oe|ü|ue|ß|ss"
	 !-->
	<xsl:template name="fn.SubstituteMultiple">
		<xsl:param name="text"/>
		<xsl:param name="substitutions"/>
		<!---->
		<xsl:choose>
			<xsl:when test="contains($substitutions, '|')">
				<xsl:variable name="searchString" select="substring-before($substitutions, '|')"/>
				<xsl:variable name="replaceString">
					<xsl:choose>
						<xsl:when test="contains(substring-after($substitutions, '|'), '|')">
							<xsl:value-of select="substring-before(substring-after($substitutions, '|'), '|')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring-after($substitutions, '|')"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<!-- recurse -->
				<xsl:call-template name="fn.SubstituteMultiple">
					<xsl:with-param name="text">
						<xsl:choose>
							<xsl:when test="false() and string-length($searchString)=1 and string-length($replaceString) &lt;=1">
								<!-- replace or remove a single character -->
								<xsl:value-of select="translate($text,$searchString,$replaceString)"/>
							</xsl:when>
							<xsl:otherwise>
								<!-- substitute a single string -->
								<xsl:call-template name="fn.Substitute">
									<xsl:with-param name="text" select="$text"/>
									<xsl:with-param name="searchString" select="$searchString"/>
									<xsl:with-param name="replaceString" select="$replaceString"/>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="substitutions" select="substring($substitutions, string-length($searchString) + string-length($replaceString) + 3)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	 ! "fn.SubstitutePipeDelimitedStrings"
	 ! An alternative Substitute function which takes the search and replace arrays as separate parameters.
	 !-->
	<xsl:template name="fn.SubstitutePipeDelimitedStrings">
		<xsl:param name="text"/>
		<xsl:param name="pipeDelimitedSearchStrings"/>
		<xsl:param name="pipeDelimitedReplaceStrings"/>
		<!---->
		<xsl:choose>
			<xsl:when test="contains($pipeDelimitedSearchStrings, '|') and contains($pipeDelimitedReplaceStrings, '|')">
				<!-- recurse -->
				<xsl:call-template name="fn.SubstitutePipeDelimitedStrings">
					<xsl:with-param name="text">
						<xsl:call-template name="fn.Substitute">
							<xsl:with-param name="text" select="$text"/>
							<xsl:with-param name="searchString" select="substring-before($pipeDelimitedSearchStrings, '|')"/>
							<xsl:with-param name="replaceString" select="substring-before($pipeDelimitedReplaceStrings, '|')"/>
						</xsl:call-template>
					</xsl:with-param>
					<xsl:with-param name="pipeDelimitedSearchStrings" select="substring-after($pipeDelimitedSearchStrings, '|')"/>
					<xsl:with-param name="pipeDelimitedReplaceStrings" select="substring-after($pipeDelimitedReplaceStrings, '|')"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- 2015-01-13 MrW -->
	<xsl:variable name="fn.SubstituteMany.DELIMITER" select="'|'"/>
	<!--
	 ! "fn.SubstituteMany.setParam"(searchString,replaceString)
	 ! 
	 !-->
	<xsl:template name="fn.SubstituteMany.setParam">
		<xsl:param name="searchString"/>
		<xsl:param name="replaceString"/>
		<!-- -->
		<xsl:value-of select="concat($searchString,$fn.SubstituteMany.DELIMITER,$replaceString,$fn.SubstituteMany.DELIMITER)"/>
	</xsl:template>
	<!--
	 ! "fn.SubstituteMany"
	 ! Performs the substitutions on the text.
	 !
	 ! Parameter substitutions is a delimited string or search and replace strings,
	 ! created with the fn.SubstituteMultiple.setParam function
	 !-->
	<xsl:template name="fn.SubstituteMany">
		<xsl:param name="text"/>
		<xsl:param name="substitutions"/>
		<!---->
		<xsl:choose>
			<xsl:when test="contains($substitutions, $fn.SubstituteMany.DELIMITER)">
				<xsl:variable name="searchString" select="substring-before($substitutions, $fn.SubstituteMany.DELIMITER)"/>
				<xsl:variable name="replaceString">
					<xsl:choose>
						<xsl:when test="contains(substring-after($substitutions, $fn.SubstituteMany.DELIMITER), $fn.SubstituteMany.DELIMITER)">
							<xsl:value-of select="substring-before(substring-after($substitutions, $fn.SubstituteMany.DELIMITER), $fn.SubstituteMany.DELIMITER)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring-after($substitutions, $fn.SubstituteMany.DELIMITER)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<!-- recurse -->
				<xsl:call-template name="fn.SubstituteMany">
					<xsl:with-param name="text">
						<xsl:call-template name="fn.Substitute">
							<xsl:with-param name="text" select="$text"/>
							<xsl:with-param name="searchString" select="$searchString"/>
							<xsl:with-param name="replaceString" select="$replaceString"/>
						</xsl:call-template>
					</xsl:with-param>
					<xsl:with-param name="substitutions" select="substring($substitutions, string-length($searchString) + string-length($replaceString) + 3)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
