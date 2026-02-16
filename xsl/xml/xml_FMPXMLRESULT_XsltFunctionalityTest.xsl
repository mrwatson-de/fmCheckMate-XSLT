<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fmp="http://www.filemaker.com/fmpxmlresult">

  <!-- Root output -->
  <xsl:template match="/">
    <FMPXMLRESULT xmlns="http://www.filemaker.com/fmpxmlresult">
      <METADATA>
        <FIELD name="xslt_version" type="text"/>
        <FIELD name="function_name" type="text"/>
        <FIELD name="exists" type="number"/>
      </METADATA>
      <RESULTSET>
        <xsl:call-template name="run-tests"/>
      </RESULTSET>
    </FMPXMLRESULT>
  </xsl:template>


  <!-- ========================================================= -->
  <!--  MASTER TEST LIST                                         -->
  <!-- ========================================================= -->
  <xsl:variable name="tests">

    <!-- ===== STANDARD XSLT/XPath 1.0 FUNCTIONS ===== -->
    <test version="1.0">boolean</test>
    <test version="1.0">ceiling</test>
    <test version="1.0">concat</test>
    <test version="1.0">contains</test>
    <test version="1.0">count</test>
    <test version="1.0">document</test>
    <test version="1.0">false</test>
    <test version="1.0">floor</test>
    <test version="1.0">format-number</test>
    <test version="1.0">id</test>
    <test version="1.0">lang</test>
    <test version="1.0">last</test>
    <test version="1.0">local-name</test>
    <test version="1.0">name</test>
    <test version="1.0">namespace-uri</test>
    <test version="1.0">normalize-space</test>
    <test version="1.0">not</test>
    <test version="1.0">number</test>
    <test version="1.0">position</test>
    <test version="1.0">round</test>
    <test version="1.0">string</test>
    <test version="1.0">string-length</test>
    <test version="1.0">substring</test>
    <test version="1.0">substring-after</test>
    <test version="1.0">substring-before</test>
    <test version="1.0">sum</test>
    <test version="1.0">translate</test>
    <test version="1.0">true</test>
    <test version="1.0">starts-with</test>

    <!-- ===== XSLT 1.0 FUNCTION-LIKE EXTENSIONS (common libs) ===== -->
    <test version="1.0-ext">unparsed-entity-uri</test>
    <test version="1.0-ext">system-property</test>

    <!-- ========================================================= -->
    <!-- ==================   EXSLT: COMMON   ===================== -->
    <!-- ========================================================= -->
    <!-- namespace exsl: -->
    <test version="EXSLT-common">exsl:node-set</test>
    <test version="EXSLT-common">exsl:object-type</test>

    <!-- ==================   EXSLT: MATH   ======================= -->
    <!-- namespace math: -->
    <test version="EXSLT-math">math:abs</test>
    <test version="EXSLT-math">math:acosh</test>
    <test version="EXSLT-math">math:acos</test>
    <test version="EXSLT-math">math:asin</test>
    <test version="EXSLT-math">math:asinh</test>
    <test version="EXSLT-math">math:atan</test>
    <test version="EXSLT-math">math:atan2</test>
    <test version="EXSLT-math">math:atanh</test>
    <test version="EXSLT-math">math:cos</test>
    <test version="EXSLT-math">math:cosh</test>
    <test version="EXSLT-math">math:exp</test>
    <test version="EXSLT-math">math:log</test>
    <test version="EXSLT-math">math:max</test>
    <test version="EXSLT-math">math:min</test>
    <test version="EXSLT-math">math:power</test>
    <test version="EXSLT-math">math:random</test>
    <test version="EXSLT-math">math:sin</test>
    <test version="EXSLT-math">math:sinh</test>
    <test version="EXSLT-math">math:sqrt</test>
    <test version="EXSLT-math">math:tan</test>
    <test version="EXSLT-math">math:tanh</test>

    <!-- =============== EXSLT: STRING ================= -->
    <test version="EXSLT-strings">str:padding</test>
    <test version="EXSLT-strings">str:align</test>
    <test version="EXSLT-strings">str:concat</test>
    <test version="EXSLT-strings">str:tokenize</test>
    <test version="EXSLT-strings">str:split</test>
    <test version="EXSLT-strings">str:replace</test>

    <!-- =============== EXSLT: DATE/TIME =============== -->
    <test version="EXSLT-date">date:date</test>
    <test version="EXSLT-date">date:date-time</test>
    <test version="EXSLT-date">date:time</test>
    <test version="EXSLT-date">date:year</test>
    <test version="EXSLT-date">date:month-in-year</test>
    <test version="EXSLT-date">date:week-in-year</test>
    <test version="EXSLT-date">date:day-in-year</test>
    <test version="EXSLT-date">date:format-date</test>

    <!-- =============== FILEMAKER candidates (guessed) =============== -->
    <test version="FileMaker">fx:evaluate</test>
    <test version="FileMaker">fx:md5</test>
    <test version="FileMaker">fx:sha1</test>
    <test version="FileMaker">fx:uuid</test>

  </xsl:variable>


  <!-- ========================================================= -->
  <!--  EXECUTION OF TEST LIST                                   -->
  <!-- ========================================================= -->
  <xsl:template name="run-tests">
    <xsl:for-each select="$tests/test">
      <ROW>
        <COL><DATA><xsl:value-of select="@version"/></DATA></COL>
        <COL><DATA><xsl:value-of select="."/></DATA></COL>
        <COL>
          <DATA>
            <xsl:choose>
              <xsl:when test="function-available(.)">1</xsl:when>
              <xsl:otherwise/>
            </xsl:choose>
          </DATA>
        </COL>
      </ROW>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
