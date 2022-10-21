<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fmp="http://www.filemaker.com/fmpxmlresult" version="1.0" exclude-result-prefixes="fmp">
	<!--
	 ! File:	FMPXMLRESULT_Text_ExportFieldContentsAsUTF-8.xslt
	 ! Purpose:	XSLT outputs the first cell of the first field of the first record of the filemaker XML export using the encoding stated in the xsl:output tag below.
	 ! Author:	r.watson@guenther-bs.de
	 ! Date:	2017-01-04
	 ! Version:	1.0
	 !-->
	<xsl:output method="text" encoding="UTF-8"/>
	<xsl:template match="fmp:FMPXMLRESULT/fmp:RESULTSET/fmp:ROW[1]/fmp:COL[1]/fmp:DATA[1]">
		<xsl:value-of select="text()"/>
	</xsl:template>
	<xsl:template match="text()"/>
</xsl:stylesheet>
