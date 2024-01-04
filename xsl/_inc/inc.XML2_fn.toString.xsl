<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" xmlns:str="http://exslt.org/strings" extension-element-prefixes="str date" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: inc.XML2_fn.toString.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	toString function for layout objects
	
	===== CHANGES HISTORY =====
	2016-01-14 MrW v0.4 Extended getPathDescriptionOfCurrentNode for processing DDR-FMXMLREPORT XML
	2016-01-04 MrW v0.3 Added Bounds to getPathDescriptionOfCurrentNode
	2015-11-23 MrW v0.2 Fixed output of button name
	2015-04-27 MrW v0.1
	-->
	<!-- ===== NEEDS ===== -->
	<!-- ===== EXTERNAL DOCUMENTS ===== -->
	<!--xsl:variable name="docPath.iDDR.XML2.LookupIconName.xml" select="'/Users/rwatson/Documents/fmCheckMate/temp/iDDR/XML2/LookupIconName.xml'"/-->
	<xsl:key name="iDDR.XML2.LookupIconName" match="Object[*/Stream/Type='SVG ']/LabelCalc/Calculation/text()" use="ancestor::Object/*/Stream[Type='SVG ']/HexData/text()"/>
	<xsl:key name="keyPortalsWithBorderLeft" match="Object[*/Stream/Type='SVG ']/LabelCalc/Calculation/text()" use="ancestor::Object/*/Stream[Type='SVG ']/HexData/text()"/>
	<!-- ===== TEMPLATES WITH MODES ===== -->
	<!--
	 ! Object.toString
	 ! Writes the name and position of an object
	 !-->
	<xsl:template match="Object" mode="toString">
		<xsl:call-template name="getDescriptionOfCurrentNode"/>
		<xsl:value-of select="' '"/>
		<xsl:call-template name="fn.GetAbsBoundsOfCurrentNodeAsNumber"/>
	</xsl:template>
	<!--
	 ! Object.getPathDescriptionOfCurrentNode
	 ! Writes the path to the object
	 !-->
	<xsl:template name="getPathDescriptionOfCurrentNode">
		<xsl:param name="pathDelimiter" select="' / '"/>
		<!-- -->
		<!-- If processing a DDR then output the Layout name -->
		<xsl:if test="ancestor::Layout/@name">
			<xsl:value-of select="concat('Layout ',$APOS,ancestor::Layout/@name,$APOS,' &gt; ')"/>
		</xsl:if>
		<xsl:for-each select="ancestor::Object">
			<xsl:if test="position() &gt; 1">
				<xsl:value-of select="$pathDelimiter"/>
			</xsl:if>
			<xsl:call-template name="getDescriptionOfCurrentNode"/>
			<xsl:value-of select="' '"/>
			<xsl:call-template name="fn.GetAbsBoundsOfCurrentNodeAsNumber"/>
		</xsl:for-each>
	</xsl:template>
	<!--
	 ! getDescriptionOfCurrentNode
	 !-->
	<xsl:template name="getDescriptionOfCurrentNode">
		<!-- -->
		<xsl:choose>
			<xsl:when test="name()='Object'">
				<xsl:variable name="ObjectName" select="Name/text()"/>
				<xsl:variable name="bitLineFlip" select="8190"/>
				<xsl:choose>
					<xsl:when test="@type='Portal'">
						<xsl:value-of select="@type"/>
						<xsl:value-of select="' '"/>
						<xsl:value-of select="$APOS"/>
						<xsl:value-of select="PortalObj/TableAliasKey"/>
						<xsl:value-of select="'::'"/>
						<xsl:value-of select="$APOS"/>
					</xsl:when>
					<xsl:when test="@type='SlideControl'">
						<xsl:value-of select="'Slider'"/>
					</xsl:when>
					<xsl:when test="@type='SlidePanel'">
						<xsl:value-of select="concat('Panel ',1 + count(preceding-sibling::Object[@type='SlidePanel']))"/>
						<!--xsl:value-of select="' '"/>
						<xsl:call-template name="fn.GetAbsBoundsOfCurrentNodeAsNumber"/-->
					</xsl:when>
					<xsl:when test="@type='TabControl'">
						<xsl:value-of select="'Tab'"/>
						<!-- fmp11 TabPanel with static name: -->
						<xsl:if test="TabControlObj/TabPanelObj/TextObj/CharacterStyleVector/Style/Data">
							<xsl:value-of select="' '"/>
							<xsl:value-of select="$APOS"/>
							<xsl:value-of select="TabControlObj/TabPanelObj/TextObj/CharacterStyleVector/Style/Data"/>
							<xsl:value-of select="$APOS"/>
						</xsl:if>
						<!-- fmp12+ TabPanel but with no dynamic name: -->
						<xsl:if test="not(TabControlObj) and not(*/Object[@type='TabPanel']/TitleCalc/Calculation)">
							<!--xsl:value-of select="' '"/>
							<xsl:call-template name="fn.GetAbsBoundsOfCurrentNodeAsNumber"/-->
						</xsl:if>
					</xsl:when>
					<xsl:when test="@type='TabPanel'">
						<xsl:value-of select="concat('Panel ', 1 + count(preceding-sibling::Object[@type='TabPanel']),':')"/>
						<xsl:value-of select="translate(TitleCalc/Calculation,$CRLF,'')"/>
					</xsl:when>
					<xsl:when test="@type='Popover'">
						<xsl:value-of select="@type"/>
						<!-- Popover title -->
						<xsl:variable name="PopoverTitle">
							<xsl:value-of select="translate(TitleCalc/Calculation,$CRLF,'')"/>
						</xsl:variable>
						<xsl:choose>
							<xsl:when test="$ObjectName">
								<xsl:value-of select="$ObjectName"/>
							</xsl:when>
							<xsl:when test="$PopoverTitle">
								<xsl:value-of select="concat(' ',$PopoverTitle)"/>
							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="@type='PopoverButton'">
						<xsl:value-of select="@type"/>
						<xsl:choose>
							<xsl:when test="$ObjectName">
								<xsl:value-of select="$ObjectName"/>
							</xsl:when>
							<!-- Static button text -->
							<xsl:when test="TextObj/ParagraphStyleVector/Data/text()">
								<xsl:value-of select="' '"/>
								<xsl:value-of select="$APOS"/>
								<xsl:value-of select="TextObj/ParagraphStyleVector/Data"/>
								<xsl:value-of select="$APOS"/>
							</xsl:when>
							<!-- Dynamic button text -->
							<xsl:when test="LabelCalc/Calculation/text()">
								<xsl:value-of select="' '"/>
								<xsl:value-of select="translate(LabelCalc/Calculation,$CRLF,'')"/>
							</xsl:when>
							<xsl:when test="not(PopoverButtonObj/Object/TitleCalc/Calculation/text())">
								<!-- define title-less popover Button via Bounds NOT
								<xsl:value-of select="' '"/>
								<xsl:for-each select="Bounds">
									<xsl:call-template name="fn.GetAbsBoundsOfCurrentNodeAsNumber"/>
								</xsl:for-each-->
							</xsl:when>
							<!--xsl:otherwise>
								<xsl:variable name="IconName">
									<xsl:for-each select="document($docPath.iDDR.XML2.LookupIconName.xml)">
										<xsl:value-of select="key('iDDR.XML2.LookupIconName',$SVGHex)"/>
									</xsl:for-each>
								</xsl:variable>
								<xsl:choose>
									<!- Icon ->
									<xsl:when test="$IconName">
										<xsl:value-of select="concat('icon:',$APOS,$IconName,$APOS)"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="'?'"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise-->
						</xsl:choose>
					</xsl:when>
					<xsl:when test="@type='Button'">
						<xsl:value-of select="concat('Button ', 1 + count(preceding-sibling::Object[@type='Button']),':')"/>
						<xsl:choose>
							<!-- Static button text -->
							<xsl:when test="TextObj/ParagraphStyleVector/Style/Data/text()">
								<xsl:value-of select="' '"/>
								<xsl:value-of select="$APOS"/>
								<xsl:value-of select="TextObj/ParagraphStyleVector/Style/Data"/>
								<xsl:value-of select="$APOS"/>
							</xsl:when>
							<!-- Dynamic button text -->
							<xsl:when test="LabelCalc/Calculation/text()">
								<xsl:value-of select="' '"/>
								<xsl:value-of select="translate(LabelCalc/Calculation,$CRLF,'')"/>
							</xsl:when>
							<!--xsl:otherwise>
						<xsl:variable name="IconName">
							<xsl:for-each select="document($docPath.iDDR.XML2.LookupIconName.xml)">
								<xsl:value-of select="key('iDDR.XML2.LookupIconName',$SVGHex)"/>
							</xsl:for-each>
						</xsl:variable>
						<xsl:choose>
							<!- Icon ->
							<xsl:when test="$IconName">
								<xsl:value-of select="concat('icon:',$APOS,$IconName,$APOS)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="'?'"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise-->
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="ButtonObj/Step[@name='Perform Script']">
								<xsl:value-of select="' -&gt; '"/>
								<xsl:value-of select="$QUOT"/>
								<xsl:value-of select="ButtonObj/Step/Script/@name"/>
								<xsl:value-of select="$QUOT"/>
							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="@type='Field'">
						<xsl:value-of select="@type"/>
						<xsl:value-of select="' '"/>
						<xsl:value-of select="$APOS"/>
						<xsl:choose>
							<!-- field -->
							<xsl:when test="FieldObj/Name">
								<xsl:value-of select="FieldObj/Name"/>
							</xsl:when>
							<!-- broken field -->
							<xsl:when test="DDRInfo/Field/@table and not(DDRInfo/Field/@name)">
								<xsl:value-of select="DDRInfo/Field/@table"/>
								<xsl:value-of select="'::'"/>
								<xsl:value-of select="concat('{id:',DDRInfo/Field/@id,'}')"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="DDRInfo/Field/@table"/>
								<xsl:value-of select="'::'"/>
								<xsl:value-of select="DDRInfo/Field/@name"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:value-of select="$APOS"/>
					</xsl:when>
					<xsl:when test="@type='Text'">
						<xsl:variable name="maxLen" select="20"/>
						<!-- -->
						<xsl:variable name="text" select="TextObj/ParagraphStyleVector/Style/Data"/>
						<!-- -->
						<xsl:value-of select="@type"/>
						<xsl:value-of select="' '"/>
						<xsl:value-of select="$APOS"/>
						<xsl:choose>
							<xsl:when test="string-length( $text ) &gt; $maxLen">
								<xsl:value-of select="concat(substring($text,1,$maxLen - 1),'...')"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$text"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:value-of select="$APOS"/>
					</xsl:when>
					<xsl:when test="@type='Graphic'">
						<xsl:value-of select="'Graphic ('"/>
						<xsl:apply-templates select="GraphicObj" mode="getDescriptionOfCurrentNode"/>
						<xsl:value-of select="')'"/>
					</xsl:when>
					<xsl:when test="@type='RRect'">
						<xsl:value-of select="'Rounded Rect'"/>
					</xsl:when>
					<xsl:when test="@type='Line'">
						<xsl:value-of select="'Line '"/>
						<xsl:choose>
							<xsl:when test="Bounds/@top = Bounds/@bottom">
								<xsl:value-of select="'-'"/>
							</xsl:when>
							<xsl:when test="Bounds/@left = Bounds/@right">
								<xsl:value-of select="'|'"/>
							</xsl:when>
							<xsl:when test="(floor(@flags div $bitLineFlip) mod 2)=1">
								<xsl:value-of select="'\'"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="'/'"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="@type='GroupButton'">
						<xsl:value-of select="'GroupButton'"/>
						<xsl:if test="GroupButtonObj/Step/Script/@name">
							<xsl:value-of select="' -&gt; '"/>
							<xsl:value-of select="$QUOT"/>
							<xsl:value-of select="GroupButtonObj/Step/Script/@name"/>
							<xsl:value-of select="$QUOT"/>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="@type"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- GraphicObj ()-->
	<xsl:template match="GraphicObj" mode="getDescriptionOfCurrentNode">
		<xsl:choose>
			<xsl:when test="Stream/Type/text()='PDF '">
				<xsl:value-of select="'PDF'"/>
				<xsl:value-of select="concat(' (', Stream[Type/text()='PDF ']/@size,' bytes)')"/>
			</xsl:when>
			<xsl:when test="Stream/Type/text()='PNGf'">
				<xsl:value-of select="'PNG Image'"/>
				<xsl:value-of select="concat(' (', Stream[Type/text()='PNGf']/@size,' bytes)')"/>
			</xsl:when>
			<xsl:when test="Stream/Type/text()='JPEG'">
				<xsl:value-of select="'JPEG Image'"/>
				<xsl:value-of select="concat(' (', Stream[Type/text()='JPEG']/@size,' bytes)')"/>
			</xsl:when>
			<xsl:when test="Stream[Type/text()!='FNAM']">
				<xsl:value-of select="Stream[Type/text()!='FNAM']/Type/text()"/>
			</xsl:when>
		</xsl:choose>
		<!--xsl:if test="Stream[Type/text()='FNAM']">
			<xsl:value-of select="' '"/>
			<xsl:value-of select="$QUOT"/>
			<xsl:value-of select="Stream[Type/text()='FNAM']/HexData/text()"/>
			<xsl:value-of select="$QUOT"/>
		</xsl:if-->
	</xsl:template>
</xsl:stylesheet>
