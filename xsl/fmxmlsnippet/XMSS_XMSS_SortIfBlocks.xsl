<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!--
	===== AUTHOR =====
	
	(c) 2024 @mrwatson-de
	
	===== PURPOSE =====
	
	XSL-File: XMSS_XMSS_SortIfBlocks.xsl
	
	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied script-steps
	
	Sorts the if blocks
	
	===== CHANGES HISTORY =====
	2011-04-16 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data" />
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="ID_IF" select="'68'" />
	<xsl:variable name="ID_ELSE" select="'69'" />
	<xsl:variable name="ID_END_IF" select="'70'" />
	<xsl:variable name="ID_ELSE_IF" select="'125'" />
	<!-- ===== TEMPLATES ===== -->
	<!-- 
		Main template 
		-->
	<xsl:template match="/fmxmlsnippet">
		<!-- Copy the node... -->
		<xsl:copy>
			<xsl:copy-of select="@*" />
			<!-- ...and start processing sequentially at the FIRST child node -->
			<xsl:apply-templates select="*[1]" />
		</xsl:copy>
	</xsl:template>

	
	<!-- 
		Script Groups will automatically get cloned 
		-->
	
	
	<!-- 
		Stop the automatic cloning of scripts with all their steps 
		-->
	<xsl:template match="Script[not(ancestor::Step)]">
		<!-- Copy the node... -->
		<xsl:copy>
			<xsl:copy-of select="@*" />
			<!-- ...and start processing sequentially at the FIRST Step -->
			<xsl:apply-templates select="*[1]" />
		</xsl:copy>
		<!-- ...then process the NEXT Script -->
		<xsl:apply-templates select="following-sibling::Script[1]" />
	</xsl:template>
	
	
	
	
	<!-- 
		Process a Step by either cloning it, or by sorting the blocks 
		-->
	<xsl:template match="Step">
		<xsl:choose>
			<!-- FOUND AN IF/ELSE IF BLOCK -->
			<xsl:when test="@id=$ID_IF or @id=$ID_ELSE_IF">
				<xsl:variable name="if" select="@id=$ID_IF" />
				<xsl:variable name="firstStep" select="." />
				<!-- the final step is an Else or an End If or the last copied step -->
				<xsl:variable name="finalStep" select="(following-sibling::Step[@id='69' or @id='70'][1]/preceding-sibling::Step[1] | following-sibling::Step[last()])[1]" />
				<!--  -->
				<!-- Sort all the following If / Else If blocks () by calculation, which are not beyond the last step -->
				<xsl:for-each select=".|following-sibling::Step[(@id='68' or @id='125') and not(generate-id(preceding-sibling::*) = generate-id($finalStep) ) ]">
					<xsl:sort select="Calculation" />
					<xsl:variable name="enable" select="@enable"/>

					<!-- Output the If / Else If Step, changing the first to an If only if we started with an If -->
					<Step enable="{$enable}">
						<!-- adjust the id, changing the first step to an If only if we started with an If -->
						<xsl:choose>
							<xsl:when test="position()=1 and $if">
								<xsl:attribute name="id">
									<xsl:value-of select="$ID_IF" />
								</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="id">
									<xsl:value-of select="$ID_ELSE_IF" />
								</xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
						<!-- and elements -->
						<xsl:copy-of select="*" />
					</Step>
					<!-- then copy the remaining steps of the block -->
					<xsl:apply-templates select="following-sibling::Step[1]" mode="copyBlock"/>
				</xsl:for-each>
				<!-- and continue by processing the step after the final step of this blocks -->
				<!--xsl:apply-templates select="$finalStep/following-sibling::Step[1]" /-->
			</xsl:when>

			<xsl:otherwise>
				<!-- Clone the step and process the following step -->
				<xsl:copy-of select="." />
				<xsl:apply-templates select="following-sibling::Step[1]" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>





	<xsl:template match="Step" mode="copyBlock">
		<xsl:choose>
			<xsl:when test="@id=$ID_ELSE_IF or @id=$ID_ELSE or @id=$ID_END_IF">
				<!-- FINISHED -->
				<!--xsl:apply-templates select="." /-->
			</xsl:when>
			<xsl:when test="1=2 and @id=$ID_IF">
				<!-- Restart in normal mode -->
				<!--xsl:apply-templates select="." /-->
			</xsl:when>
			<xsl:otherwise>
				<!-- Clone the step and recurse with the following step -->
				<xsl:copy-of select="." />
				<xsl:apply-templates select="following-sibling::Step[1]" mode="copyBlock"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
