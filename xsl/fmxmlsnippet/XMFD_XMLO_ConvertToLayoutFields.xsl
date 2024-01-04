<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMFD_XMLO_ConvertToLayoutFields.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects

	FIXME

	===== CHANGES HISTORY =====
	2011-09-30 MrW: inc/constants.xsl
	2011-08-10 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="delimiter" select="$TAB"/>
	<xsl:variable name="newrecord" select="$RETURN"/>
	<!-- KOMMENTAR HIER FIXME - WAS IST DAS? -->
	<xsl:variable name="TableName" select="'_Media__'"/>
	
	<!-- ===== TEMPLATES ===== -->
	<!-- Match all Fields definitions -->
	<xsl:template match="/">
		<xsl:element name="fmxmlsnippet">
			<xsl:attribute name="type">LayoutObjectList</xsl:attribute>
			<xsl:for-each select="//Field[not(ancestor::Field)]">
				<xsl:element name="Layout">
					<xsl:attribute name="enclosingRectLeft">  7.000000</xsl:attribute>
					<xsl:attribute name="enclosingRectRight">290.000000</xsl:attribute>
					<xsl:attribute name="enclosingRectBottom">140.000000</xsl:attribute>
					<xsl:attribute name="enclosingRectTop">123.000000</xsl:attribute>
					<xsl:element name="ObjectStyle">
						<xsl:attribute name="fontHeight">15</xsl:attribute>
						<xsl:attribute name="fieldBorders">0</xsl:attribute>
						<xsl:attribute name="id">0</xsl:attribute>
						<xsl:attribute name="graphicFormat">29</xsl:attribute>
						<xsl:element name="CharacterStyle">
							<xsl:attribute name="mask">32567</xsl:attribute>
							<xsl:element name="Font-family"><xsl:attribute name="fontId">9</xsl:attribute><xsl:attribute name="codeSet">Roman</xsl:attribute>Helvetica Neue Light</xsl:element>
							<xsl:element name="Font-size">12</xsl:element>
							<xsl:element name="Face">256</xsl:element>
							<xsl:element name="Color">#000000</xsl:element>
						</xsl:element>
						<xsl:element name="ParagraphStyle">
							<xsl:attribute name="mask">1983</xsl:attribute>
							<xsl:element name="LeftMargin">  2.000000</xsl:element>
							<xsl:element name="RightMargin">  2.000000</xsl:element>
						</xsl:element>
						<xsl:element name="NumFormat">
							<xsl:attribute name="flags">256</xsl:attribute>
							<xsl:attribute name="currencySymbol">€</xsl:attribute>
							<xsl:attribute name="thousandsSep">46</xsl:attribute>
							<xsl:attribute name="decimalPoint">44</xsl:attribute>
							<xsl:attribute name="trueString">Yes</xsl:attribute>
							<xsl:attribute name="decimalDigits">2</xsl:attribute>
							<xsl:attribute name="falseString">No</xsl:attribute>
							<xsl:attribute name="negativeColor">#DD000000</xsl:attribute>
							<xsl:attribute name="charStyle">0</xsl:attribute>
							<xsl:attribute name="negativeStyle">0</xsl:attribute>
						</xsl:element>
						<xsl:element name="DateFormat">
							<xsl:attribute name="format">0</xsl:attribute>
							<xsl:attribute name="dayStyle">1</xsl:attribute>
							<xsl:attribute name="monthStyle">1</xsl:attribute>
							<xsl:attribute name="charStyle">0</xsl:attribute>
							<xsl:attribute name="separator">46</xsl:attribute>
							<xsl:element name="DateElement">3</xsl:element>
							<xsl:element name="DateElement">1</xsl:element>
							<xsl:element name="DateElement">6</xsl:element>
							<xsl:element name="DateElement">8</xsl:element>
							<xsl:element name="DateElementSep">
								<xsl:attribute name="index">0</xsl:attribute>
							</xsl:element>
							<xsl:element name="DateElementSep"><xsl:attribute name="index">1</xsl:attribute>, </xsl:element>
							<xsl:element name="DateElementSep"><xsl:attribute name="index">2</xsl:attribute>. </xsl:element>
							<xsl:element name="DateElementSep">
								<xsl:attribute name="index">3</xsl:attribute>
							</xsl:element>
							<xsl:element name="DateElementSep">
								<xsl:attribute name="index">4</xsl:attribute>
							</xsl:element>
						</xsl:element>
						<xsl:element name="TimeFormat">
							<xsl:attribute name="flags">159</xsl:attribute>
							<xsl:attribute name="minsecStyle">1</xsl:attribute>
							<xsl:attribute name="amString"> vorm.</xsl:attribute>
							<xsl:attribute name="ampmString"/>
							<xsl:attribute name="hourStyle">0</xsl:attribute>
							<xsl:attribute name="pmString"> nachm.</xsl:attribute>
							<xsl:attribute name="charStyle">0</xsl:attribute>
							<xsl:attribute name="separator">58</xsl:attribute>
						</xsl:element>
						<xsl:element name="DrawStyle">
							<xsl:attribute name="linePat">2</xsl:attribute>
							<xsl:attribute name="fillPat">1</xsl:attribute>
							<xsl:attribute name="fillColor">#CCFFCC00</xsl:attribute>
							<xsl:attribute name="lineWidth">0</xsl:attribute>
							<xsl:attribute name="lineColor">#0</xsl:attribute>
							<xsl:attribute name="fillEffect">0</xsl:attribute>
						</xsl:element>
						<xsl:element name="AltLineStyle">
							<xsl:attribute name="linePat">7</xsl:attribute>
							<xsl:attribute name="lineWidth">1</xsl:attribute>
							<xsl:attribute name="lineColor">#0</xsl:attribute>
						</xsl:element>
					</xsl:element>
					<xsl:element name="Object">
						<xsl:attribute name="flags">0</xsl:attribute>
						<xsl:attribute name="portal">-1</xsl:attribute>
						<xsl:attribute name="type">Text</xsl:attribute>
						<xsl:attribute name="rotation">0</xsl:attribute>
						<xsl:element name="StyleId">0</xsl:element>
						<xsl:element name="Bounds">
							<xsl:attribute name="left">  7.000000</xsl:attribute>
							<xsl:attribute name="bottom">140.000000</xsl:attribute>
							<xsl:attribute name="right"> 92.000000</xsl:attribute>
							<xsl:attribute name="top">123.000000</xsl:attribute>
						</xsl:element>
						<xsl:element name="DrawStyle">
							<xsl:attribute name="linePat">1</xsl:attribute>
							<xsl:attribute name="fillPat">1</xsl:attribute>
							<xsl:attribute name="fillColor">#FFFFFF00</xsl:attribute>
							<xsl:attribute name="lineWidth">0</xsl:attribute>
							<xsl:attribute name="lineColor">#FFFFFF00</xsl:attribute>
							<xsl:attribute name="fillEffect">0</xsl:attribute>
						</xsl:element>
						<xsl:element name="TextObj">
							<xsl:attribute name="flags">2</xsl:attribute>
							<xsl:element name="CharacterStyleVector">
								<xsl:element name="Style">
									<xsl:element name="Data">Art</xsl:element>
									<xsl:element name="CharacterStyle">
										<xsl:attribute name="mask">32567</xsl:attribute>
										<xsl:element name="Font-family"><xsl:attribute name="fontId">9</xsl:attribute><xsl:attribute name="codeSet">Roman</xsl:attribute>Helvetica Neue Light</xsl:element>
										<xsl:element name="Font-size">12</xsl:element>
										<xsl:element name="Face">256</xsl:element>
										<xsl:element name="Color">#000000</xsl:element>
									</xsl:element>
								</xsl:element>
							</xsl:element>
							<xsl:element name="ParagraphStyleVector">
								<xsl:element name="Style">
									<xsl:element name="Data">Art</xsl:element>
									<xsl:element name="ParagraphStyle">
										<xsl:attribute name="mask">0</xsl:attribute>
									</xsl:element>
								</xsl:element>
							</xsl:element>
						</xsl:element>
					</xsl:element>
					<xsl:element name="ObjectStyle">
						<xsl:attribute name="fontHeight">15</xsl:attribute>
						<xsl:attribute name="fieldBorders">0</xsl:attribute>
						<xsl:attribute name="id">1</xsl:attribute>
						<xsl:attribute name="graphicFormat">3</xsl:attribute>
						<xsl:element name="CharacterStyle">
							<xsl:attribute name="mask">32567</xsl:attribute>
							<xsl:element name="Font-family"><xsl:attribute name="fontId">9</xsl:attribute><xsl:attribute name="codeSet">Roman</xsl:attribute>Helvetica Neue Light</xsl:element>
							<xsl:element name="Font-size">12</xsl:element>
							<xsl:element name="Face">0</xsl:element>
							<xsl:element name="Color">#000000</xsl:element>
						</xsl:element>
						<xsl:element name="ParagraphStyle">
							<xsl:attribute name="mask">1983</xsl:attribute>
							<xsl:element name="LeftMargin">  2.000000</xsl:element>
							<xsl:element name="RightMargin">  2.000000</xsl:element>
						</xsl:element>
						<xsl:element name="NumFormat">
							<xsl:attribute name="flags">1</xsl:attribute>
							<xsl:attribute name="currencySymbol">€</xsl:attribute>
							<xsl:attribute name="thousandsSep">46</xsl:attribute>
							<xsl:attribute name="decimalPoint">44</xsl:attribute>
							<xsl:attribute name="trueString">Yes</xsl:attribute>
							<xsl:attribute name="decimalDigits">2</xsl:attribute>
							<xsl:attribute name="falseString">No</xsl:attribute>
							<xsl:attribute name="negativeColor">#DD000000</xsl:attribute>
							<xsl:attribute name="charStyle">0</xsl:attribute>
							<xsl:attribute name="negativeStyle">0</xsl:attribute>
						</xsl:element>
						<xsl:element name="DateFormat">
							<xsl:attribute name="format">0</xsl:attribute>
							<xsl:attribute name="dayStyle">1</xsl:attribute>
							<xsl:attribute name="monthStyle">1</xsl:attribute>
							<xsl:attribute name="charStyle">0</xsl:attribute>
							<xsl:attribute name="separator">46</xsl:attribute>
							<xsl:element name="DateElement">3</xsl:element>
							<xsl:element name="DateElement">1</xsl:element>
							<xsl:element name="DateElement">6</xsl:element>
							<xsl:element name="DateElement">8</xsl:element>
							<xsl:element name="DateElementSep">
								<xsl:attribute name="index">0</xsl:attribute>
							</xsl:element>
							<xsl:element name="DateElementSep"><xsl:attribute name="index">1</xsl:attribute>, </xsl:element>
							<xsl:element name="DateElementSep"><xsl:attribute name="index">2</xsl:attribute>. </xsl:element>
							<xsl:element name="DateElementSep">
								<xsl:attribute name="index">3</xsl:attribute>
							</xsl:element>
							<xsl:element name="DateElementSep">
								<xsl:attribute name="index">4</xsl:attribute>
							</xsl:element>
						</xsl:element>
						<xsl:element name="TimeFormat">
							<xsl:attribute name="flags">159</xsl:attribute>
							<xsl:attribute name="minsecStyle">1</xsl:attribute>
							<xsl:attribute name="amString"> vorm.</xsl:attribute>
							<xsl:attribute name="ampmString"/>
							<xsl:attribute name="hourStyle">0</xsl:attribute>
							<xsl:attribute name="pmString"> nachm.</xsl:attribute>
							<xsl:attribute name="charStyle">0</xsl:attribute>
							<xsl:attribute name="separator">58</xsl:attribute>
						</xsl:element>
						<xsl:element name="DrawStyle">
							<xsl:attribute name="linePat">2</xsl:attribute>
							<xsl:attribute name="fillPat">1</xsl:attribute>
							<xsl:attribute name="fillColor">#FFFFFF00</xsl:attribute>
							<xsl:attribute name="lineWidth">1</xsl:attribute>
							<xsl:attribute name="lineColor">#88888800</xsl:attribute>
							<xsl:attribute name="fillEffect">0</xsl:attribute>
						</xsl:element>
						<xsl:element name="AltLineStyle">
							<xsl:attribute name="linePat">7</xsl:attribute>
							<xsl:attribute name="lineWidth">1</xsl:attribute>
							<xsl:attribute name="lineColor">#0</xsl:attribute>
						</xsl:element>
					</xsl:element>
					<xsl:element name="Object">
						<xsl:attribute name="flags">0</xsl:attribute>
						<xsl:attribute name="portal">-1</xsl:attribute>
						<xsl:attribute name="type">Field</xsl:attribute>
						<xsl:attribute name="rotation">0</xsl:attribute>
						<xsl:element name="StyleId">1</xsl:element>
						<xsl:element name="Bounds">
							<xsl:attribute name="left"> 97.000000</xsl:attribute>
							<xsl:attribute name="bottom">140.000000</xsl:attribute>
							<xsl:attribute name="right">290.000000</xsl:attribute>
							<xsl:attribute name="top">123.000000</xsl:attribute>
						</xsl:element>
						<xsl:element name="FieldObj">
							<xsl:attribute name="flags">34</xsl:attribute>
							<xsl:attribute name="inputMode">0</xsl:attribute>
							<xsl:attribute name="displayType">0</xsl:attribute>
							<xsl:attribute name="quickFind">1</xsl:attribute>
							<xsl:attribute name="numOfReps">1</xsl:attribute>
							<xsl:element name="Name">
								<xsl:value-of select="concat($TableName,'::')"/>
								<xsl:value-of select="@name"/>
							</xsl:element>
							<xsl:element name="ValueList"/>
							<xsl:element name="DDRInfo">
								<xsl:element name="Field">
									<xsl:attribute name="name">
										<xsl:value-of select="@name"/>
									</xsl:attribute>
									<xsl:attribute name="maxRepetition">1</xsl:attribute>
									<xsl:attribute name="id">
										<xsl:value-of select="@id"/>
									</xsl:attribute>
									<xsl:attribute name="table"><xsl:value-of select="$TableName"/></xsl:attribute>
									<xsl:attribute name="repetition">1</xsl:attribute>
								</xsl:element>
								<xsl:element name="ValueList">
									<xsl:attribute name="name">1 Liste</xsl:attribute>
									<xsl:attribute name="id">2</xsl:attribute>
								</xsl:element>
							</xsl:element>
						</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
