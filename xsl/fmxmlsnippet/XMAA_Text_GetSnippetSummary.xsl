<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMAA_Text_GetSnippetSummary.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: any FileMaker Clipboard content
	
	Returns a short summary of the fmxmlsnippet contents.
	
	===== CHANGES HISTORY =====
	2011-10-05 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/var.fmxmlsnippetClass.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<xsl:variable name="indent" select="$TAB"/>
	<xsl:variable name="snippetObjectCount" select="count(/*/*)"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/">
		<xsl:choose>
			<xsl:when test="$snippetObjectCount!=1">
				<xsl:value-of select="concat($snippetObjectCount, ' ', $fmxmlsnippetObjects)"/>
			</xsl:when>
			<xsl:when test="$fmxmlsnippetClass='XMSC'">
				<xsl:value-of select="concat($fmxmlsnippetObject, ' ', $APOS, /*/*/@name, $APOS)"/>
			</xsl:when>
			<xsl:when test="$fmxmlsnippetClass='XMSS'">
				<xsl:value-of select="concat($fmxmlsnippetObject, ' ', $APOS, /*/*/@name, $APOS)"/>
			</xsl:when>
			<xsl:when test="$fmxmlsnippetClass='XMLO' or $fmxmlsnippetObject='XML2'">
				<xsl:variable name="snippetLayoutObjectCount" select="count(//Object)"/>
				<xsl:choose>
					<xsl:when test="$snippetLayoutObjectCount=1">
						<!-- a single object -->
						<xsl:value-of select="concat($snippetLayoutObjectCount, ' ', $fmxmlsnippetObject)"/>
					</xsl:when>
					<xsl:otherwise>
						<!-- Analyse multiple objects -->
						<!-- fields + text -->
						<xsl:variable name="snippetLayoutFieldCount" select="count(//Object[@type='Field'])"/>
						<xsl:variable name="snippetLayoutTextCount" select="count(//Object[@type='Text'])"/>
						<!-- containers -->
						<xsl:variable name="snippetLayoutGroupButtonCount" select="count(//Object[@type='GroupButton'])"/>
						<xsl:variable name="snippetLayoutPortalCount" select="count(//Object[@type='Portal'])"/>
						<xsl:variable name="snippetLayoutTabControlCount" select="count(//Object[@type='TabControl'])"/>
						<xsl:variable name="snippetLayoutTabPanelCount" select="count(//Object[@type='TabPanel'])"/>
						<xsl:variable name="snippetLayoutSlideControlCount" select="count(//Object[@type='SlideControl'])"/>
						<xsl:variable name="snippetLayoutSlidePanelCount" select="count(//Object[@type='SlidePanel'])"/>
						<xsl:variable name="snippetLayoutContainerObjectCount" select="$snippetLayoutGroupButtonCount + $snippetLayoutPortalCount + $snippetLayoutTabControlCount + $snippetLayoutTabPanelCount + $snippetLayoutSlideControlCount + $snippetLayoutSlidePanelCount"/>
						<!-- External objects -->
						<xsl:variable name="snippetLayoutExternalObjectCount" select="count(//Object[@type='ExternalObject'])"/>
						<xsl:variable name="snippetLayoutWebViewerCount" select="count(//Object[@type='ExternalObject' and ExternalObj/@typeID='WEBV'])"/>
						<xsl:variable name="snippetLayoutChartCount" select="count(//Object[@type='ExternalObject' and ExternalObj/@typeID='CHRT'])"/>
						<!-- Graphic objects -->
						<xsl:variable name="snippetLayoutGraphicCount" select="count(//Object[@type='Graphic'])"/>
						<xsl:variable name="snippetLayoutLineCount" select="count(//Object[@type='Line'])"/>
						<xsl:variable name="snippetLayoutOvalCount" select="count(//Object[@type='Oval'])"/>
						<xsl:variable name="snippetLayoutRectCount" select="count(//Object[@type='Rect'])"/>
						<xsl:variable name="snippetLayoutRRectCount" select="count(//Object[@type='RRect'])"/>
						<xsl:variable name="snippetLayoutGraphicObjectCount" select="$snippetLayoutGraphicCount+$snippetLayoutLineCount+$snippetLayoutOvalCount+$snippetLayoutRectCount+$snippetLayoutRRectCount"/>
						<!-- Other objects -->
						<xsl:variable name="snippetLayoutAccountedObjectCount" select="$snippetLayoutFieldCount + $snippetLayoutTextCount + $snippetLayoutExternalObjectCount + $snippetLayoutGraphicCount"/>
						<xsl:variable name="snippetLayoutUnaccountedPObjectCount" select="$snippetLayoutObjectCount - $snippetLayoutAccountedObjectCount"/>
						<!--  -->
						<xsl:value-of select="concat($snippetLayoutObjectCount, ' ', $fmxmlsnippetObjects,':')"/>
						<!-- fields -->
						<xsl:if test="$snippetLayoutFieldCount">
							<xsl:value-of select="$newrecord"/>
							<xsl:value-of select="$indent"/>
							<xsl:value-of select="concat($snippetLayoutFieldCount,' ','Fields')"/>
						</xsl:if>
						<xsl:if test="$snippetLayoutTextCount">
							<xsl:value-of select="$newrecord"/>
							<xsl:value-of select="$indent"/>
							<xsl:value-of select="concat($snippetLayoutTextCount,' ','Texts')"/>
						</xsl:if>
						<!-- containers -->
						<xsl:if test="$snippetLayoutGroupButtonCount">
							<xsl:value-of select="$newrecord"/>
							<xsl:value-of select="$indent"/>
							<xsl:value-of select="concat($snippetLayoutGroupButtonCount,' ','GroupButtons')"/>
						</xsl:if>
						<xsl:if test="$snippetLayoutPortalCount">
							<xsl:value-of select="$newrecord"/>
							<xsl:value-of select="$indent"/>
							<xsl:value-of select="concat($snippetLayoutPortalCount,' ','Portals')"/>
						</xsl:if>
						<xsl:if test="$snippetLayoutTabControlCount">
							<xsl:value-of select="$newrecord"/>
							<xsl:value-of select="$indent"/>
							<xsl:value-of select="concat($snippetLayoutTabControlCount,' ','TabControls',':')"/>
							<xsl:if test="$snippetLayoutTabPanelCount">
								<xsl:value-of select="$newrecord"/>
								<xsl:value-of select="$indent"/>
								<xsl:value-of select="$indent"/>
								<xsl:value-of select="concat($snippetLayoutTabPanelCount,' ','TabPanels')"/>
							</xsl:if>
						</xsl:if>
						<xsl:if test="$snippetLayoutSlideControlCount">
							<xsl:value-of select="$newrecord"/>
							<xsl:value-of select="$indent"/>
							<xsl:value-of select="concat($snippetLayoutSlideControlCount,' ','SlideControls',':')"/>
							<xsl:if test="$snippetLayoutSlidePanelCount">
								<xsl:value-of select="$newrecord"/>
								<xsl:value-of select="$indent"/>
								<xsl:value-of select="$indent"/>
								<xsl:value-of select="concat($snippetLayoutSlidePanelCount,' ','SlidePanels')"/>
							</xsl:if>
						</xsl:if>
						<!-- External objects -->
						<xsl:if test="$snippetLayoutExternalObjectCount">
							<xsl:value-of select="$newrecord"/>
							<xsl:value-of select="concat($snippetLayoutExternalObjectCount,' ','ExternalObjects',':')"/>
							<xsl:value-of select="$newrecord"/>
							<xsl:value-of select="$indent"/>
							<xsl:if test="$snippetLayoutWebViewerCount">
								<xsl:if test="$snippetLayoutWebViewerCount!=$snippetLayoutExternalObjectCount">
									<xsl:value-of select="concat($snippetLayoutWebViewerCount,' ')"/>
								</xsl:if>
								<xsl:value-of select="'WebViewers'"/>
							</xsl:if>
							<xsl:if test="$snippetLayoutChartCount">
								<xsl:value-of select="$newrecord"/>
								<xsl:value-of select="$indent"/>
								<xsl:if test="$snippetLayoutChartCount!=$snippetLayoutExternalObjectCount">
									<xsl:value-of select="concat($snippetLayoutChartCount,' ')"/>
								</xsl:if>
								<xsl:value-of select="'Charts'"/>
							</xsl:if>
						</xsl:if>
						<!-- Graphic objects -->
						<xsl:if test="$snippetLayoutGraphicObjectCount">
							<xsl:value-of select="$newrecord"/>
							<xsl:value-of select="concat($snippetLayoutGraphicObjectCount,' ','GraphicObjects:')"/>
							<xsl:if test="$snippetLayoutGraphicCount">
								<xsl:value-of select="$newrecord"/>
								<xsl:value-of select="$indent"/>
								<xsl:value-of select="concat($snippetLayoutGraphicCount,' ','Graphics')"/>
							</xsl:if>
							<xsl:if test="$snippetLayoutLineCount">
								<xsl:value-of select="$newrecord"/>
								<xsl:value-of select="$indent"/>
								<xsl:value-of select="concat($snippetLayoutLineCount,' ','Lines')"/>
							</xsl:if>
							<xsl:if test="$snippetLayoutOvalCount">
								<xsl:value-of select="$newrecord"/>
								<xsl:value-of select="$indent"/>
								<xsl:value-of select="concat($snippetLayoutOvalCount,' ','Ovals')"/>
							</xsl:if>
							<xsl:if test="$snippetLayoutRectCount">
								<xsl:value-of select="$newrecord"/>
								<xsl:value-of select="$indent"/>
								<xsl:value-of select="concat($snippetLayoutRectCount,' ','Rectangles')"/>
							</xsl:if>
							<xsl:if test="$snippetLayoutRRectCount">
								<xsl:value-of select="$newrecord"/>
								<xsl:value-of select="$indent"/>
								<xsl:value-of select="concat($snippetLayoutRRectCount,' ','RoundedRectangles')"/>
							</xsl:if>
						</xsl:if>
						<!-- Graphic objects -->
						<xsl:if test="$snippetLayoutUnaccountedObjectCount">
							<xsl:value-of select="$newrecord"/>
							<xsl:value-of select="$indent"/>
							<xsl:value-of select="concat($snippetLayoutUnaccountedObjectCount,' ','other objects')"/>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$fmxmlsnippetClass='XMTB'">
				<xsl:value-of select="concat($fmxmlsnippetObject, ' ', $APOS, /*/*/@name, $APOS)"/>
			</xsl:when>
			<xsl:when test="$fmxmlsnippetClass='XMFD'">
				<xsl:value-of select="concat($fmxmlsnippetObject, ' ', $APOS, /*/*/@name, $APOS)"/>
			</xsl:when>
			<xsl:when test="$fmxmlsnippetClass='XMTH'">
				<xsl:value-of select="concat($fmxmlsnippetObject, ' ', $APOS, /*/Theme/@name, $APOS)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($snippetObjectCount, ' ', $fmxmlsnippetObject)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
