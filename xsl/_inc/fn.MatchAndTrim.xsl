<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: fn.MatchAndTrim.xsl

	XML-Source: any.xml
	XML-Grammar: any
	XML-Content: any
	
	Functions for matching and trimming strings.
	
	
	
	===== CHANGES HISTORY =====
	2023-07-25 MrW: Version 1.0
	-->
    
    <!-- Return the first match in pText of the first term in pSearchTerms (delimited by pipe or pSearchTermDelim)-->
    <xsl:template name="getFirstMatchAndSurroundingWhiteSpace">
        <xsl:param name="pText"/>
        <xsl:param name="pSearchTerms"/>
        <xsl:param name="pSearchTermDelim" select="'|'"/>
        <!--  -->
        <xsl:variable name="match">
            <xsl:call-template name="getFirstMatch">
                <xsl:with-param name="pText" select="$pText"/>
                <xsl:with-param name="pSearchTerms" select="$pSearchTerms"/>
                <xsl:with-param name="pSearchTermDelim" select="$pSearchTermDelim"/>
            </xsl:call-template>
        </xsl:variable>
        <!--  -->
        <xsl:choose>
            <xsl:when test="$match != ''">
                <!-- Return the matching term including the surrounding white space -->
                <xsl:call-template name="getTrailingWhitespace">
                    <xsl:with-param name="pText" select="substring-before($pText,$match)"/>
                </xsl:call-template>
                <xsl:value-of select="$match"/>
                <xsl:call-template name="getLeadingWhitespace">
                    <xsl:with-param name="pText" select="substring-after($pText,$match)"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <!-- No match found, return an empty string -->
                <xsl:text></xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Return the first match in pText of the first term in pSearchTerms (delimited by pipe or pSearchTermDelim)-->
    <xsl:template name="getFirstMatch">
        <xsl:param name="pText"/>
        <xsl:param name="pSearchTerms"/>
        <xsl:param name="pSearchTermDelim" select="'|'"/>
        <!--  -->
        <!-- Extract the first term -->
        <xsl:variable name="firstTerm" select="substring-before(concat( $pSearchTerms, $pSearchTermDelim), $pSearchTermDelim)"/>
        <!--  -->
        <xsl:choose>
            <xsl:when test="$pText != '' and $firstTerm != '' and contains( $pText, $firstTerm )">
                <!-- Return the matching term -->
                <xsl:value-of select="$firstTerm"/>
            </xsl:when>
            <xsl:when test="$pSearchTermDelim != '' and contains($pSearchTerms, $pSearchTermDelim)">
                <!-- Recursive case: Remove the first term and call the function again -->
                <xsl:call-template name="getFirstMatch">
                    <xsl:with-param name="pText" select="$pText"/>
                    <xsl:with-param name="pSearchTerms" select="substring-after($pSearchTerms, $pSearchTermDelim)"/>
                    <xsl:with-param name="pSearchTermDelim" select="$pSearchTermDelim"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <!-- No match found, return an empty string -->
                <xsl:text></xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Returns the white space from the end of the text -->
    <xsl:template name="getTrailingWhitespace">
        <xsl:param name="pText"/>
        <!--  -->
        <xsl:call-template name="getTrailingCharacters">
            <xsl:with-param name="pText" select="$pText"/>
            <xsl:with-param name="pCharacters" select="' &#09;&#10;&#13;'"/>
        </xsl:call-template>
    </xsl:template>
    
    <!-- Returns the characters from the end of the text -->
    <xsl:template name="getTrailingCharacters">
        <xsl:param name="pText"/>
        <xsl:param name="pCharacters"/>
        <xsl:param name="pFound" select="0"/>
        <!--  -->
        <xsl:variable name="char" select="substring($pText,string-length( $pText )-$pFound,1)"/>
        <!--  -->
        <xsl:choose>
            <xsl:when test="string-length( $pText ) = 0 or string-length( $char ) = 0 or string-length( translate( $char, $pCharacters, '' ) ) = 1">
                <!-- Next character is NOT a character, so return the characters found so far -->
                <xsl:value-of select="substring($pText,string-length( $pText )+1-$pFound)"/>
            </xsl:when>
            <xsl:otherwise>
                <!-- Recursive case: Call the function again, incrementing the number of characters found -->
                <xsl:call-template name="getTrailingCharacters">
                    <xsl:with-param name="pText" select="$pText"/>
                    <xsl:with-param name="pCharacters" select="$pCharacters"/>
                    <xsl:with-param name="pFound" select="$pFound + 1"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Returns the white space from the beginning of the text -->
    <xsl:template name="getLeadingWhitespace">
        <xsl:param name="pText"/>
        <!--  -->
        <xsl:call-template name="getLeadingCharacters">
            <xsl:with-param name="pText" select="$pText"/>
            <xsl:with-param name="pCharacters" select="' &#09;&#10;&#13;'"/>
        </xsl:call-template>
    </xsl:template>
    
    <!-- Returns the characters from the beginning of the text -->
    <xsl:template name="getLeadingCharacters">
        <xsl:param name="pText"/>
        <xsl:param name="pCharacters"/>
        <xsl:param name="pFound" select="0"/>
        <!--  -->
        <xsl:variable name="char" select="substring($pText,1+$pFound,1)"/>
        <!--  -->
        <xsl:choose>
            <xsl:when test="string-length( $pText ) = 0 or string-length( $char ) = 0 or string-length( translate( $char, $pCharacters, '' ) ) = 1">
                <!-- Next character is NOT a character, so return the characters found so far -->
                <xsl:value-of select="substring($pText,1,$pFound)"/>
            </xsl:when>
            <xsl:otherwise>
                <!-- Recursive case: Call the function again, incrementing the number of characters found -->
                <xsl:call-template name="getLeadingCharacters">
                    <xsl:with-param name="pText" select="$pText"/>
                    <xsl:with-param name="pCharacters" select="$pCharacters"/>
                    <xsl:with-param name="pFound" select="$pFound+1"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>
