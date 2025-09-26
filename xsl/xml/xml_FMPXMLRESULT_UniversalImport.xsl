<?xml version="1.0" encoding="utf-8"?>
<!-- The one-fits-all XSLT for FileMaker.
     Transforms arbitrary XML grammars and namespaces
          into FileMaker records. Every node or attribute one
           record.
     Usage: Import your XML data with grammar FMPXMLRESULT using this file as
          XSLT stylesheet into a new FM table.
     Jens Teich v-0.4 12.08.2013

The FileMaker database needs the following 5 text fields

- path - The xpath to the node
- parent - The name of the parent
- node - The name of the node
- value - The value of the node
- type - The type of the node

     -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.filemaker.com/fmpxmlresult" version="1.0">
	<xsl:template match="/">
		<FMPXMLRESULT>
			<ERRORCODE>0</ERRORCODE>
			<PRODUCT BUILD="" NAME="" VERSION=""/>
			<DATABASE DATEFORMAT="" LAYOUT="" NAME="" RECORDS="" TIMEFORMAT=""/>
			<METADATA>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="path" TYPE="TEXT"/>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="parent" TYPE="TEXT"/>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="node" TYPE="TEXT"/>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="value" TYPE="TEXT"/>
				<FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="type" TYPE="TEXT"/>
			</METADATA>
			<RESULTSET FOUND="">
				<xsl:apply-templates/>
			</RESULTSET>
		</FMPXMLRESULT>
	</xsl:template>
	<xsl:template match="node()|comment()">
		<!-- Template handling all nodes -->
		<xsl:if test="self::*">
			<!-- no text nodes -->
			<ROW MODID="" RECORDID="">
				<COL>
					<DATA>
						<xsl:for-each select="ancestor-or-self::*">
							<xsl:value-of select="name()"/>
							<xsl:text>/</xsl:text>
						</xsl:for-each>
					</DATA>
				</COL>
				<COL>
					<DATA>
						<xsl:value-of select="name(parent::*)"/>
					</DATA>
				</COL>
				<COL>
					<DATA>
						<xsl:choose>
							<xsl:when test="name()=''">
								<xsl:value-of select="text()"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="name()"/>
							</xsl:otherwise>
						</xsl:choose>
					</DATA>
				</COL>
				<COL>
					<DATA>
						<xsl:if test="not(*)">
							<xsl:value-of select="."/>
						</xsl:if>
					</DATA>
				</COL>
				<COL>
					<DATA>
						<xsl:text>Node</xsl:text>
					</DATA>
				</COL>
			</ROW>
		</xsl:if>
		<xsl:apply-templates select="@*"/>
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="@*">
		<!-- Template handling attribute nodes -->
		<ROW MODID="" RECORDID="">
			<COL>
				<DATA>
					<xsl:for-each select="ancestor-or-self::*">
						<xsl:value-of select="name()"/>
						<xsl:text>/</xsl:text>
					</xsl:for-each>
				</DATA>
			</COL>
			<COL>
				<DATA>
					<xsl:value-of select="name(parent::*)"/>
				</DATA>
			</COL>
			<COL>
				<DATA>
					<xsl:value-of select="name()"/>
				</DATA>
			</COL>
			<COL>
				<DATA>
					<xsl:value-of select="."/>
				</DATA>
			</COL>
			<COL>
				<DATA>
					<xsl:text>Attribute</xsl:text>
				</DATA>
			</COL>
		</ROW>
	</xsl:template>
</xsl:stylesheet>
