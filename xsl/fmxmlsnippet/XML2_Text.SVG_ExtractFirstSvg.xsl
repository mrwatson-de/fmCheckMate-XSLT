<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" xmlns:math="http://exslt.org/math" xmlns:str="http://exslt.org/strings" extension-element-prefixes="exsl str math" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XML2_Text.SVG_ExtractFirstSvg.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	Extracts the *first* SVG image found in the layout.

	FIXME - I have managed to convert hex -> Entities, but the entities need to be interpreted to characters

	Please see the discussion on stackoverflow[1] explaining why this can't be done with xslt 1.0
	
	[1] http://stackoverflow.com/questions/30539613/how-to-extract-an-svg-file-which-is-embedded-in-filemaker-xml-as-hex-codes-usi

	========================
	
	
	===== CHANGES HISTORY =====
	2019-09-09 MrW: Version 0.1.1 Removed incorrect and superfluous generation of XML Processing Instruction
	2015-05-29 MrW: Version 0.1
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="text" version="1.0" encoding="UTF-8"/>
	<!-- ===== PARAMETER ===== -->
	<xsl:param name="outputCharacterReferenceInHexadecimal" select="false()"/>
	<xsl:param name="debug" select="false()"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="APOS">
		<xsl:text>'</xsl:text>
	</xsl:variable>
	<xsl:variable name="HexToASCII">
		<xsl:value-of select="'¦09:&#9;¦0A:&#10;¦0D:&#13;¦'"/>
		<xsl:value-of select="'20: ¦21:!¦22:&quot;¦23:#¦24:$¦25:%¦26:&amp;¦27'"/>
		<xsl:value-of select="$APOS"/>
		<xsl:value-of select="'¦28:(¦29:)¦2A:*¦2B:+¦2C:,¦2D:-¦2E:.¦2F:/¦'"/>
		<xsl:value-of select="'30:0¦31:1¦32:2¦33:3¦34:4¦35:5¦36:6¦37:7¦38:8¦39:9¦3A::¦3B:¦¦3C:&lt;¦3D:=¦3E:&gt;¦3F:?¦'"/>
		<xsl:value-of select="'40:@¦41:A¦42:B¦43:C¦44:D¦45:E¦46:F¦47:G¦48:H¦49:I¦4A:J¦4B:K¦4C:L¦4D:M¦4E:N¦4F:O¦'"/>
		<xsl:value-of select="'50:P¦51:Q¦52:R¦53:S¦54:T¦55:U¦56:V¦57:W¦58:X¦59:Y¦5A:Z¦5B:[¦5C:\¦5D:]¦5E:^¦5F:_¦'"/>
		<xsl:value-of select="'60:`¦61:a¦62:b¦63:c¦64:d¦65:e¦66:f¦67:g¦68:h¦69:i¦6A:j¦6B:k¦6C:l¦6D:m¦6E:n¦6F:o¦'"/>
		<xsl:value-of select="'70:p¦71:q¦72:r¦73:s¦74:t¦75:u¦76:v¦77:w¦78:x¦79:y¦7A:z¦7B:{¦7C:|¦7D:}¦7E:~¦7F:¦'"/>
	</xsl:variable>
	<xsl:variable name="HEXDIGITSLOWER" select="'0123456789abcdef'"/>
	<xsl:variable name="HEXDIGITSUPPER" select="'0123456789ABCDEF'"/>
	<!-- TEMPLATES -->
	<!-- Main -->
	<xsl:template match="/">
		<!-- xml processing instruction -->
<!--		<xsl:value-of select="concat('&lt;?xml version=',&quot;,'1.0',&quot;,'?&gt;')"/>-->
		<!-- output first svg -->
		<xsl:for-each select="(//Stream[normalize-space(Type/text())='SVG']/HexData)[1]">
			<!-- -->
			<xsl:call-template name="UTF8HexData.toString">
				<xsl:with-param name="HexData" select="text()"/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<!-- NAMED TEMPLATES -->
	<!-- 
	 ! Convert UTF8HexData.toString
	 !-->
	<xsl:template name="UTF8HexData.toString">
		<xsl:param name="HexData"/>
		<!-- -->
		<xsl:call-template name="UppercaseUTF8HexData.toString">
			<xsl:with-param name="HexData" select="translate($HexData,'abcdefg','ABCDEFG')"/>
		</xsl:call-template>
	</xsl:template>
	<!-- 
	 ! UppercaseUTF8HexData.toString
	 ! 
	 ! This converts UTF8 characters where each byte is encoded as 2 hexadecimal 
	 ! characters to the equivalent UTF8 character.
	 ! Low-ASCII characters are converted into the equivalent ASCII character.
	 ! High-ASCII characters are converted into a numerical character reference, 
	 !   either hexadecimal or decimal, depending on the parameter.
	 !-->
	<xsl:template name="UppercaseUTF8HexData.toString">
		<xsl:param name="HexData"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="string-length($HexData)&lt;2">
				<!-- ignore single hex digit -->
			</xsl:when>
			<xsl:when test="string-length($HexData)&gt;24">
				<!-- Divide and Conquer -->
				<!--
				 ! Find the middle without splitting a multibyte character
				 !-->
				<xsl:variable name="l" select="string-length($HexData)"/>
				<xsl:variable name="n" select="($l - $l mod 4) div 2"/>
				<xsl:variable name="middle">
					<xsl:choose>
						<xsl:when test="not(contains('89AB',substring($HexData,$n+0,1)))">
							<xsl:value-of select="$n+0"/>
						</xsl:when>
						<xsl:when test="not(contains('89AB',substring($HexData,$n+2,1)))">
							<xsl:value-of select="$n+2"/>
						</xsl:when>
						<xsl:when test="not(contains('89AB',substring($HexData,$n+4,1)))">
							<xsl:value-of select="$n+4"/>
						</xsl:when>
						<xsl:when test="not(contains('89AB',substring($HexData,$n+6,1)))">
							<xsl:value-of select="$n+6"/>
						</xsl:when>
						<xsl:when test="not(contains('89AB',substring($HexData,$n+8,1)))">
							<xsl:value-of select="$n+8"/>
						</xsl:when>
						<xsl:when test="not(contains('89AB',substring($HexData,$n+10,1)))">
							<xsl:value-of select="$n+10"/>
						</xsl:when>
						<xsl:when test="not(contains('89AB',substring($HexData,$n+12,1)))">
							<xsl:value-of select="$n+12"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'FIXME'"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<!--
				 ! split + recurse
				 !-->
				<!--xsl:value-of select="'('"/>
				<xsl:value-of select="$middle"/>
				<xsl:value-of select="'/'"/>
				<xsl:value-of select="string-length($HexData)"/>
				<xsl:value-of select="':'"/>
				<xsl:value-of select="substring($HexData,1,$middle)"/>
				<xsl:value-of select="'|'"/>
				<xsl:value-of select="substring($HexData,$middle + 1)"/>
				<xsl:value-of select="':'"/>
				<xsl:value-of select="'&#10;'"/>
			-->
				<xsl:call-template name="UppercaseUTF8HexData.toString">
					<xsl:with-param name="HexData" select="substring($HexData,1,$middle)"/>
				</xsl:call-template>
				<xsl:call-template name="UppercaseUTF8HexData.toString">
					<xsl:with-param name="HexData" select="substring($HexData,$middle + 1)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="Hex1" select="substring($HexData,1,1)"/>
				<xsl:variable name="Hex2" select="substring($HexData,2,1)"/>
				<xsl:variable name="NumberOfMultibytes">
					<xsl:choose>
						<xsl:when test="contains('01234567', $Hex1)">
							<xsl:value-of select="1"/>
						</xsl:when>
						<xsl:when test="contains('CD', $Hex1)">
							<xsl:value-of select="2"/>
						</xsl:when>
						<xsl:when test="$Hex1='E'">
							<xsl:value-of select="3"/>
						</xsl:when>
						<xsl:when test="$Hex1='F'">
							<xsl:choose>
								<xsl:when test="contains('01234567', $Hex2)">
									<xsl:value-of select="4"/>
								</xsl:when>
								<xsl:when test="contains('89AB', $Hex2)">
									<xsl:value-of select="5"/>
								</xsl:when>
								<xsl:when test="contains('CD', $Hex2)">
									<xsl:value-of select="6"/>
								</xsl:when>
								<xsl:otherwise>
									<!-- ERROR - illegal UTF-8 encoding -->
									<xsl:value-of select="0"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<!-- ERROR - illegal UTF-8 encoding -->
							<xsl:value-of select="0"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<!-- process the characters -->
				<xsl:choose>
					<xsl:when test="$NumberOfMultibytes = 0">
						<!--
					 ! ERROR - illegal UTF-8 encoding
					 !-->
						<!-- recurse, skipping the illegal character -->
						<xsl:call-template name="UppercaseUTF8HexData.toString">
							<xsl:with-param name="HexData" select="substring($HexData,3)"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$NumberOfMultibytes = 1">
						<!--
					 ! Output a simple HexToASCII character
					 !-->
						<xsl:value-of select="substring-before(substring-after($HexToASCII,concat('¦',substring($HexData,1,2),':')),'¦')"/>
						<!-- recurse -->
						<xsl:call-template name="UppercaseUTF8HexData.toString">
							<xsl:with-param name="HexData" select="substring($HexData,3)"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<!--
					 ! Output a UTF 8 Multibyte character as a numeric character reference
					 !-->
						<xsl:variable name="MultibyteHexData" select="substring($HexData,1,$NumberOfMultibytes*2)"/>
						<!-- -->
						<!-- 1. first convert the bytes to binary -->
						<xsl:variable name="binaryString">
							<xsl:call-template name="Hex2Bin">
								<xsl:with-param name="Hex" select="$MultibyteHexData"/>
							</xsl:call-template>
						</xsl:variable>
						<!-- 2. extract the bits representing the code point -->
						<xsl:variable name="binaryCodePoint">
							<!-- skip the header bits of the leading byte-->
							<xsl:value-of select="substring($binaryString,$NumberOfMultibytes + 2, 7 - $NumberOfMultibytes)"/>
							<!--
						! IMPORTANT: The following XSLT 1.0 workaround/'trick'
						! could simplifies the XSLT code here, but  
						! requires the XML document to have at least 6 nodes.

						<xsl:for-each select="//*[position() &lt;= $NumberOfMultibytes]">
							<xsl:value-of select="substring($binaryString,position()*8 + 3,6)"/>
						</xsl:for-each>

						!-->
							<!-- skip the top 2 bits of each of the non-leading byte -->
							<xsl:if test="$NumberOfMultibytes &gt;= 1">
								<xsl:value-of select="substring($binaryString,1*8 + 3,6)"/>
							</xsl:if>
							<xsl:if test="$NumberOfMultibytes &gt;= 2">
								<xsl:value-of select="substring($binaryString,2*8 + 3,6)"/>
							</xsl:if>
							<xsl:if test="$NumberOfMultibytes &gt;= 3">
								<xsl:value-of select="substring($binaryString,3*8 + 3,6)"/>
							</xsl:if>
							<xsl:if test="$NumberOfMultibytes &gt;= 4">
								<xsl:value-of select="substring($binaryString,4*8 + 3,6)"/>
							</xsl:if>
							<xsl:if test="$NumberOfMultibytes &gt;= 5">
								<xsl:value-of select="substring($binaryString,5*8 + 3,6)"/>
							</xsl:if>
							<xsl:if test="$NumberOfMultibytes &gt;= 6">
								<xsl:value-of select="substring($binaryString,6*8 + 3,6)"/>
							</xsl:if>
						</xsl:variable>
						<!-- 3. output the code point -->
						<xsl:if test="$debug">
							<xsl:value-of select="concat('(',$Hex1,$Hex2,'-',$MultibyteHexData,'-',$NumberOfMultibytes,'-',$binaryString,'-',$binaryCodePoint,'-')"/>
							<xsl:call-template name="Bin2Hex">
								<xsl:with-param name="Bin" select="$binaryCodePoint"/>
							</xsl:call-template>
							<xsl:value-of select="'):'"/>
						</xsl:if>
						<xsl:choose>
							<xsl:when test="$outputCharacterReferenceInHexadecimal">
								<!-- ...as hexadecimal character reference -->
								<xsl:value-of select="'&amp;#x'"/>
								<xsl:call-template name="Bin2Hex">
									<xsl:with-param name="Bin" select="$binaryCodePoint"/>
								</xsl:call-template>
								<xsl:value-of select="';'"/>
							</xsl:when>
							<xsl:otherwise>
								<!-- ...as a decimal character reference -->
								<xsl:value-of select="'&amp;#x'"/>
								<xsl:call-template name="Bin2Dec">
									<xsl:with-param name="Bin" select="$binaryCodePoint"/>
								</xsl:call-template>
								<xsl:value-of select="';'"/>
							</xsl:otherwise>
						</xsl:choose>
						<!-- 4. recurse, skipping the multibyte characters -->
						<xsl:call-template name="UppercaseUTF8HexData.toString">
							<xsl:with-param name="HexData" select="substring($HexData,$NumberOfMultibytes*2+1)"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	 ! Bin2Hex
	 !-->
	<xsl:template name="Bin2Hex">
		<xsl:param name="Bin"/>
		<!-- -->
		<xsl:if test="$Bin!=''">
			<xsl:variable name="n" select="string-length($Bin)"/>
			<xsl:call-template name="Bin2Hex">
				<xsl:with-param name="Bin" select="substring($Bin,1,$n - 4)"/>
			</xsl:call-template>
			<xsl:variable name="Num" select="number(substring($Bin,$n - 3,1)) * 8 + number(substring($Bin,$n - 2,1)) * 4 + number(substring($Bin,$n - 1,1)) * 2 + number(substring($Bin,$n,1))"/>
			<xsl:value-of select="substring($HEXDIGITSUPPER,$Num+1,1)"/>
		</xsl:if>
	</xsl:template>
	<!--
	 ! Bin2Dec
	 !-->
	<xsl:template name="Bin2Dec">
		<xsl:param name="Bin"/>
		<xsl:param name="Num" select="0"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="$Bin=''">
				<xsl:value-of select="$Num"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="Bin2Dec">
					<xsl:with-param name="Bin" select="substring($Bin,2)"/>
					<xsl:with-param name="Num" select="$Num * 2 + number(substring($Bin,1,1))"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	 ! Hex2Bin
	 !-->
	<xsl:template name="Hex2Bin">
		<xsl:param name="Hex"/>
		<!-- -->
		<xsl:if test="$Hex!=''">
			<xsl:variable name="Num" select="string-length(substring-before($HEXDIGITSUPPER,substring($Hex,1,1)))"/>
			<xsl:value-of select="substring('0000 0001 0010 0011 0100 0101 0110 0111 1000 1001 1010 1011 1100 1101 1110 1111',1 + $Num * 5, 4)"/>
			<xsl:call-template name="Hex2Bin">
				<xsl:with-param name="Hex" select="substring($Hex,2)"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<!--
	 ! Hex2Dec
	 !-->
	<xsl:template name="Hex2Dec">
		<xsl:param name="Hex"/>
		<xsl:param name="Num" select="0"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="$Hex=''">
				<xsl:value-of select="$Num"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="Hex2Dec">
					<xsl:with-param name="Hex" select="substring($Hex,2)"/>
					<xsl:with-param name="Num" select="$Num * 16 + string-length(substring-before($HEXDIGITSUPPER,substring($Hex,1,1)))"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
