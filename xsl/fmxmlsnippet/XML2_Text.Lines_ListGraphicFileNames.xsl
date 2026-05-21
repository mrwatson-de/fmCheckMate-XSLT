<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XML2_Text.Lines_ListGraphicFileNames.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	Returns all Layout Object Names
	
	===== CHANGES HISTORY =====
	2013-11-19 MrW: Umbenannt für XML2
	2011-09-30 MrW: inc/constants.xsl
	2011-08-10 MrW: Version 0.9
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== VARIABLES ===== -->
	<!-- ASCII lookup -->
	<xsl:variable name="ascii"> !&quot;#$%&amp;&apos;()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~</xsl:variable>
	<!-- ===== TEMPLATES ===== -->
	<!-- Objects -->
	<xsl:template match="/">
			<xsl:for-each select="//HexData[../Type='FNAM']/text()">
				<xsl:if test="position()!=1">
					<xsl:value-of select="'&#13;'"/>
				</xsl:if>
				<xsl:call-template name="decode-fnam">
					<xsl:with-param name="hex" select="."/>
				</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<!-- ===== NAMED TEMPLATES ===== -->
	<!-- -->
	<!-- ========================================================= -->
	<!-- Decode FileMaker FNAM HexData                             -->
	<!-- Usage:                                                     -->
	<!--   <xsl:call-template name="decode-fnam">                   -->
	<!--       <xsl:with-param name="hex" select="HexData"/>        -->
	<!--   </xsl:call-template>                                     -->
	<!-- ========================================================= -->
	<xsl:template name="decode-fnam">

	    <xsl:param name="hex"/>

	    <!-- remove FNAM header -->
	    <xsl:variable name="data" select="substring($hex,11)"/>

	    <!-- read type until Z -->
	    <xsl:variable name="type">
	        <xsl:call-template name="read-bytes">
	            <xsl:with-param name="hex" select="$data"/>
	            <xsl:with-param name="stop-char" select="'Z'"/>
	            <xsl:with-param name="xor" select="1"/>
	        </xsl:call-template>
	    </xsl:variable>

	    <!-- compute position after type + Z -->
	    <xsl:variable name="offset" select="string-length($type)+1"/>

	    <xsl:variable name="afterZ" select="substring($data,($offset*2)+1)"/>

	    <!-- read length (NOT XORed) -->
	    <xsl:variable name="lenHex" select="substring($afterZ,1,2)"/>

	    <xsl:variable name="len">
	        <xsl:call-template name="hex-to-dec">
	            <xsl:with-param name="hex" select="$lenHex"/>
	        </xsl:call-template>
	    </xsl:variable>

	    <!-- name -->
	    <xsl:variable name="name">
	        <xsl:call-template name="read-bytes">
	            <xsl:with-param name="hex" select="substring($afterZ,3)"/>
	            <xsl:with-param name="read-length" select="$len"/>
	            <xsl:with-param name="xor" select="1"/>
	        </xsl:call-template>
	    </xsl:variable>

	    <xsl:value-of select="concat($type,':',$name)"/>

	</xsl:template>
	<!--
	 ! decode-fnam-bytes
	 ! 
	 ! The recursive bit
	 ! 
	 ! -->
	<xsl:template name="decode-fnam-bytes">
		<xsl:param name="hex"/>
		<xsl:if test="string-length($hex) &gt; 0">
			<!-- next byte -->
			<xsl:variable name="byteHex" select="substring($hex,1,2)"/>
			<!-- hex → decimal -->
			<xsl:variable name="byte">
				<xsl:call-template name="hex-to-dec">
					<xsl:with-param name="hex" select="$byteHex"/>
				</xsl:call-template>
			</xsl:variable>
			<!-- XOR with 0x5A -->
			<xsl:variable name="decoded">
				<xsl:call-template name="xor">
					<xsl:with-param name="a" select="$byte"/>
					<xsl:with-param name="b" select="90"/>
				</xsl:call-template>
			</xsl:variable>
			<!-- output ASCII -->
			<xsl:value-of select="substring($ascii,$decoded - 31,1)"/>
			<!-- recurse -->
			<xsl:call-template name="decode-fnam-bytes">
				<xsl:with-param name="hex" select="substring($hex,3)"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="read-bytes">

	    <xsl:param name="hex"/>
	    <xsl:param name="stop-char"/>
	    <xsl:param name="read-length" select="-1"/>
	    <xsl:param name="result" select="''"/>
	    <xsl:param name="xor" select="1"/>

			<xsl:choose>
		    <xsl:when test="string-length($hex) = 0">
					<xsl:value-of select="$result"/>
				</xsl:when>
				<xsl:otherwise>
	        <!-- next byte -->
	        <xsl:variable name="byteHex" select="substring($hex,1,2)"/>

	        <!-- hex → decimal -->
	        <xsl:variable name="byte">
	            <xsl:call-template name="hex-to-dec">
	                <xsl:with-param name="hex" select="$byteHex"/>
	            </xsl:call-template>
	        </xsl:variable>

	        <!-- optional XOR -->
	        <xsl:variable name="decoded">
	            <xsl:choose>
	                <xsl:when test="$xor">
	                    <xsl:call-template name="xor">
	                        <xsl:with-param name="a" select="$byte"/>
	                        <xsl:with-param name="b" select="90"/>
	                    </xsl:call-template>
	                </xsl:when>
	                <xsl:otherwise>
	                    <xsl:value-of select="$byte"/>
	                </xsl:otherwise>
	            </xsl:choose>
	        </xsl:variable>

	        <!-- ASCII -->
	        <xsl:variable name="char" select="substring($ascii,$decoded - 31,1)"/>

	        <xsl:choose>

	            <!-- stop char reached -->
	            <xsl:when test="$stop-char != '' and $char = $stop-char">
	                <xsl:value-of select="$result"/>
	            </xsl:when>

	            <!-- continue -->
	            <xsl:otherwise>

	                <xsl:call-template name="read-bytes">
	                    <xsl:with-param name="hex" select="substring($hex,3)"/>
	                    <xsl:with-param name="stop-char" select="$stop-char"/>
	                    <xsl:with-param name="read-length"
	                        select="($read-length &gt; 0) * ($read-length - 1) + ($read-length &lt; 0) * -1"/>
	                    <xsl:with-param name="result" select="concat($result,$char)"/>
	                    <xsl:with-param name="xor" select="$xor"/>
	                </xsl:call-template>

	            </xsl:otherwise>

	        </xsl:choose>

				</xsl:otherwise>
			</xsl:choose>


	</xsl:template>
	<!--
	 ! xor
	 ! 
	 ! 
	 ! 
	 ! -->
	<xsl:template name="xor">
		<xsl:param name="a"/>
		<xsl:param name="b"/>
		<xsl:param name="factor" select="1"/>
		<xsl:param name="result" select="0"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="$a=0 and $b=0">
				<xsl:value-of select="$result"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="xor">
					<xsl:with-param name="a" select="floor($a div 2)"/>
					<xsl:with-param name="b" select="floor($b div 2)"/>
					<xsl:with-param name="factor" select="$factor * 2"/>
					<xsl:with-param name="result" select="$result + $factor * ((($a mod 2) + ($b mod 2)) mod 2)"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	 ! hex-to-decimal
	 ! 
	 ! 
	 ! 
	 ! -->
	<xsl:template name="hex-to-dec">
		<xsl:param name="hex"/>
		<xsl:variable name="digits" select="'0123456789ABCDEF'"/>
		<xsl:variable name="hi" select="string-length(substring-before($digits,substring($hex,1,1)))"/>
		<xsl:variable name="lo" select="string-length(substring-before($digits,substring($hex,2,1)))"/>
		<xsl:value-of select="$hi*16 + $lo"/>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
