<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!--
	with thanks to:
	
	     http://www.stylusstudio.com/xsllist/201008/post60180.html
	     XSLT 1.0 serializer for XML

	     remarks:
	     - generates output nearly identical to <xsl:copy-of select="/"/>
	       - all attributes before namespace declarations
	       - attribute values might be different because of AVN

	     - since stylesheet does not have access to CDATA sections
	       it has to use template escapeLtGtAmp to ensure correct
	       escaping; overhead of 1 x call-template + 3 x contains()
	       for text output not containing any of &lt; , &gt; and &amp;

	     - because of "Attribute-Value Normalization" no newlines in
	       attribute values; this might change visual presentation
	       as can be seen in first <xsl:when>'s test attribute

	     - entity references like &#10; and &amp;quot; in the XML file are not
	       accessible by the stylesheet and are displayed as non-Entity


	          serialize.xsl: XML serializer

	     serialize-demo.xml: demonstration file (open in browser)
	     serialize-demo.xsl: referenced demonstration

	            copy-of.xsl: for comparison with serialize-test.xsl output
	     serialize-test.xsl: for comparison with copy-of.xsl output;
	                         view output in browser for comparing
	-->
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: fn.serializeXML.xsl

	XML-Source: any.xml
	XML-Grammar: any
	XML-Content: any

	Function to serialize the current XML node.

	===== SEE ALSO =====

	The opposite function fn.parseXML.xsl

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	20200107 MrW: Version 1.1.1 Corrected a bug, where node() was being used instead of * (element)
	20150515 MrW: Version 1.1 Quotes are also now correctly serialized.
	20110113 MrW: Version 1.0
	-->
	<!-- ===== TEMPLATES ===== -->
	<!-- Main function: serialize the current node -->
	<xsl:template name="fn.serializeXML">
		<xsl:choose>
			<xsl:when test="count(. | ../namespace::*) != count(../namespace::*)">
				<xsl:apply-templates select="." mode="serialize"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat('xmlns', substring(':',1 div boolean(name())),name(),'=&amp;quot;',.,'&amp;quot;')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Serialize an attribute -->
	<xsl:template match="@*" mode="serialize">
		<xsl:value-of select="concat(' ',name(),'=&amp;quot;',.,'&amp;quot;')"/>
	</xsl:template>
	<!-- Serialize a node -->
	<xsl:template match="*" mode="serialize">
		<xsl:value-of select="concat('&lt;',name())"/>
		<xsl:apply-templates select="@*" mode="serialize"/>
		<xsl:for-each select="namespace::*">
			<xsl:if test="not(.=../../namespace::*) and name()!='xml'">
				<xsl:value-of select="concat(' xmlns',substring(':',1 div boolean(name())),name(),'=&amp;quot;',.,'&amp;quot;')"/>
			</xsl:if>
		</xsl:for-each>
		<xsl:choose>
			<xsl:when test="*|text()|comment()|processing-instruction()">
				<xsl:text>&gt;</xsl:text>
				<xsl:apply-templates select="*|text()|comment()|processing-instruction()" mode="serialize"/>
				<xsl:value-of select="concat('&lt;/',name(),'&gt;')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>/&gt;</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Serialize a comment -->
	<xsl:template match="comment()" mode="serialize">
		<xsl:value-of select="concat('&lt;!--',.,'--&gt;')"/>
	</xsl:template>
	<!-- Serialize a processing instruction -->
	<xsl:template match="processing-instruction()" mode="serialize">
		<xsl:value-of select="concat('&lt;?',name(),' ',.,'?&gt;')"/>
	</xsl:template>
	<!-- Serialize text-->
	<xsl:template match="text()" mode="serialize">
		<!-- overhead: 1 x call-template + 3 x contains() for text without CDATA -->
		<xsl:call-template name="escapeLtGtAmp">
			<xsl:with-param name="str" select="."/>
		</xsl:call-template>
	</xsl:template>
	<!-- Replace special characters in text-->
	<xsl:template name="escapeLtGtAmp">
		<xsl:param name="str"/>
		<xsl:choose>
			<xsl:when test="contains($str,'&lt;') or                        contains($str,'&gt;') or                        contains($str,'&amp;')">
				<xsl:variable name="lt" select="substring-before(concat($str,'&lt;'),'&lt;')"/>
				<xsl:variable name="gt" select="substring-before(concat($str,'&gt;'),'&gt;')"/>
				<xsl:variable name="amp" select="substring-before(concat($str,'&amp;'),'&amp;')"/>
				<xsl:choose>
					<xsl:when test="string-length($gt) &gt; string-length($amp)">
						<xsl:choose>
							<xsl:when test="string-length($amp) &gt; string-length($lt)">
								<xsl:value-of select="concat(substring-before  ($str,'&lt;'),'&amp;lt;')"/>
								<xsl:call-template name="escapeLtGtAmp">
									<xsl:with-param name="str" select="substring-after($str,'&lt;')"/>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat(substring-before  ($str,'&amp;'),'&amp;amp;')"/>
								<xsl:call-template name="escapeLtGtAmp">
									<xsl:with-param name="str" select="substring-after($str,'&amp;')"/>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="string-length($gt) &gt; string-length($lt)">
								<xsl:value-of select="concat(substring-before  ($str,'&lt;'),'&amp;lt;')"/>
								<xsl:call-template name="escapeLtGtAmp">
									<xsl:with-param name="str" select="substring-after($str,'&lt;')"/>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat(substring-before  ($str,'&gt;'),'&amp;gt;')"/>
								<xsl:call-template name="escapeLtGtAmp">
									<xsl:with-param name="str" select="substring-after($str,'&gt;')"/>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$str"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
