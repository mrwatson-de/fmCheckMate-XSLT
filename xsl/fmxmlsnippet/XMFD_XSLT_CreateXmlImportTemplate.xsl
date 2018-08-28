<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xslt="FIXMEhttp://www.w3.org/1999/XSL/Transform"
	version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2018 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XMFD_XSLT_CreateXmlImportTemplate.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied field or table definitions
	
	Generates an xslt stylesheet template, to be used to import xml data into the fields.
	
	===== CHANGES HISTORY =====
	(c) russell@MrWatson.de 2018
	2018-06-06 MrW: Version 0.9.4 Renamed File
	2013-05-15 MrW: Version 0.9.3 Import, export and xslt namespaces sorted out, and DOCH all fields - in case you need them as placeholders.
	2013-05-14 MrW: Version 0.9.2 Supports repeating fields
	2013-05-09 MrW: Version 0.9.1 Not calculated nor summary fields
	2013-05-08 MrW: Version 0.9 First attempt
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:namespace-alias stylesheet-prefix="xslt" result-prefix="xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.Substitute.xsl"/>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="/fmxmlsnippet">
		<xslt:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:imp="http://www.filemaker.com/fmpdsoresult" exclude-result-prefixes="imp" version="1.0">
			<xsl:comment>
				<xsl:text>
   #################################################################################################################
   This XSLT Sytylesheet has been automtically genereated from the XSLT file: 

         fmCheckMate/xsl/fmxmlsnippet/XMFD_XSLT_CreateXmlImportTemplate.xsl
   
   In its initial form the stylesheet is modeled on importing the old FileMaker FMPDSORESULT XML grammar.
   (To test on an FMPDSORESULT grammar you only need to delete the string "imp:FIXME/" and it is ready!)
   
   To customize this template stylesheet for your specific import file:

   1. Correct the namespace URI for the imp prefix to match the namespace of the import XML.

   2. Customize the Xpath expressions in this template, where the word FIXME occurs.
      2a. To help with step 2 you may wish to generate Xpaths by applying the following fmCheckMate XSLT to the xml import file:
          ~/Documents/fmCheckMate/xsl/xml/xml_Text.Lines_ListXpathsToElementsAndAttributes.xsl
          or
          ~/Documents/fmCheckMate/xsl/xml/xml_Text.Lines_ListXpathsToSelectElementsByAttributeValue.xsl
      2b. Note:Don't forget to add the imp: namespace prefix to each element of the Xpath

   3. Customize the comments and delete this section.
   #################################################################################################################

   ===== AUTHOR =====
   
   FIXME
   
   ===== PURPOSE =====
   
   XSL-File: FIXMESourceGrammar_FMPXMLRESULT_ImportFIXME.xsl
   
   XML-Source: FIXME.xml
   XML-Grammar: FIXMESourceGrammar
   XML-Content: FIXME
   

   Converts XML file #FIXME# into FMPXMLRESULT for importing into table #FIXME# of FileMaker database #FIXME#.
   
   ===== CHANGES HISTORY =====
   FIXME DATE PERSON: Version FIXME Stylesheet created by fmCheckMate
   
</xsl:text>
			</xsl:comment>
			<xsl:comment> ===== HEAD ===== </xsl:comment>
			<xslt:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
			<xsl:comment> ===== VARIABLES ===== </xsl:comment>
			<xsl:comment>Absolute Xpath to ROW element:</xsl:comment>
			<xslt:variable name="foundCount" select="count(/imp:FIXME/imp:FMPDSORESULT/imp:ROW)"/>
			<xsl:comment> ===== TEMPLATES ===== </xsl:comment>
			<xsl:comment> Main </xsl:comment>
			<xslt:template match="/">
				<FMPXMLRESULT xmlns="http://www.filemaker.com/fmpxmlresult">
					<ERRORCODE>0</ERRORCODE>
					<PRODUCT BUILD="10-09-2012" NAME="FileMaker" VERSION="ProAdvanced 12.0v3"/>
					<DATABASE DATEFORMAT="D/m/yyyy" LAYOUT="" NAME="ETS Test Punkte.fmp12" RECORDS="47" TIMEFORMAT="k:mm:ss "/>
					<METADATA>
						<!-- Create metadata for each field -->
						<xsl:for-each select="//Field[not(ancestor::Field)]">
							<!-- comment in one of the following lines if you wish to sort the fields -->
							<!--xsl:sort select="@id" data-type="number"/-->
							<!--xsl:sort select="@name"/-->
							<!--xsl:sort select="concat(translate(substring(@fieldType,1,1),'NCS','123'),translate(substring(@dataType,2,1),'euaio','12345'),substring(concat(@dataType,' '),5,1),translate(substring(Storage/@global,1,1),'FT','12'),@name)"/-->
							<!--  -->
							<xsl:variable name="name" select="@name"/>
							<xsl:variable name="type" select="translate(@dataType,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
							<xsl:variable name="maxRepeat" select="Storage/@maxRepetition"/>
							<xsl:variable name="emptyOK">
								<xsl:choose>
									<xsl:when test="Validation/NotEmpty/@value='True'">
										<xsl:value-of select="'NO'"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="'YES'"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>
							<!--  -->
							<FIELD EMPTYOK="{$emptyOK}" MAXREPEAT="{$maxRepeat}" NAME="{$name}" TYPE="{$type}"/>
						</xsl:for-each>
					</METADATA>
					<RESULTSET>
						<xsl:attribute name="FOUND">
							<xsl:value-of select="'{$foundCount}'"/>
						</xsl:attribute>
						<!--  -->
						<xsl:comment>Relative Xpath to ROW element:</xsl:comment>
						<xslt:for-each select="imp:FIXME/imp:FMPDSORESULT/imp:ROW">
							<xsl:variable name="recid" select="position()"/>
							<!--  -->
							<xsl:comment> ROW </xsl:comment>
							<ROW MODID="1" RECORDID="{$recid}">
								<!-- For each target field -->
								<xsl:for-each select="//Field[not(ancestor::Field)]">
									<!-- comment in one of the following lines if you wish to sort the fields -->
									<!--xsl:sort select="@id" data-type="number"/-->
									<!--xsl:sort select="@name"/-->
									<!--xsl:sort select="concat(translate(substring(@fieldType,1,1),'NCS','123'),translate(substring(@dataType,2,1),'euaio','12345'),substring(concat(@dataType,' '),5,1),translate(substring(Storage/@global,1,1),'FT','12'),@name)"/-->
									<!--  -->
									<xsl:variable name="xmlElementName">
										<xsl:call-template name="fn.getAsXMLName">
											<xsl:with-param name="text" select="@name"/>
										</xsl:call-template>
									</xsl:variable>
									<xsl:variable name="XpathToField" select="concat('imp:FIXME/imp:',$xmlElementName)"/>
									<xsl:variable name="repetitions" select="Storage/@maxRepetition"/>
									<!--  -->
									<!-- create a commented COL/DATA output structure -->
									<xsl:comment>
										<xsl:value-of select="concat(' Column ',position(),': ',@name,' (',@dataType,')')"/>
									</xsl:comment>
									<COL>
										<xsl:choose>
											<xsl:when test="$repetitions = 1">
												<!-- normal field -->
												<DATA>
													<xslt:value-of select="{$XpathToField}"/>
												</DATA>
											</xsl:when>
											<xsl:otherwise>
												<!-- repeating field -->
												<xsl:call-template name="OutputDATAForFieldRepetition">
													<xsl:with-param name="XpathToField" select="$XpathToField"/>
													<xsl:with-param name="repetitions" select="$repetitions"/>
													<xsl:with-param name="repetition" select="1"/>
												</xsl:call-template>
											</xsl:otherwise>
										</xsl:choose>
									</COL>
								</xsl:for-each>
							</ROW>
						</xslt:for-each>
					</RESULTSET>
				</FMPXMLRESULT>
			</xslt:template>
			<!-- 
			 ! Create template to skip other text
			 !-->
			<xsl:comment> ignore all other text </xsl:comment>
			<xslt:template match="text()"/>
			<!-- End stylesheet generation -->
		</xslt:stylesheet>
		<!-- End Main Template -->
	</xsl:template>
	<!--
	 ! ignore all other text
	 !-->
	<xsl:template match="text()"/>
	<!--
	! ################ NAMED TEMPLATES ################
	!-->
	<!-- OutputDATAForFieldRepetition -->
	<xsl:template name="OutputDATAForFieldRepetition">
		<xsl:param name="XpathToField"/>
		<xsl:param name="repetitions"/>
		<xsl:param name="repetition"/>
		<!--  -->
		<xsl:if test="number($repetition) &lt;= number($repetitions)">
			<xsl:element name="DATA" namespace="http://www.filemaker.com/fmpxmlresult">
				<xsl:variable name="XpathToFieldRepetition" select="concat($XpathToField,'/imp:DATA[position()=',$repetition,']')"/>
				<xslt:value-of select="{$XpathToFieldRepetition}"/>
			</xsl:element>
			<xsl:call-template name="OutputDATAForFieldRepetition">
				<xsl:with-param name="XpathToField" select="$XpathToField"/>
				<xsl:with-param name="repetitions" select="$repetitions"/>
				<xsl:with-param name="repetition" select="$repetition + 1"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	<!-- 
	 ! fn.getAsXMLName function 
	 !
	 !   Does its best to produce a legal element name by converting (the most common) illegal characters to acceptable alternatives.
	 !
	 !   Returns a text suitable for an XML element name.
	 !-->
	<xsl:template name="fn.getAsXMLName">
		<xsl:param name="text"/>
		<!--  -->
		<!-- First substitute known problem characters with acceptable alternatives-->
		<xsl:variable name="text2">
			<xsl:call-template name="fn.SubstituteMultiple">
				<xsl:with-param name="text" select="$text"/>
				<xsl:with-param name="substitutions" select="' |_|:|.|$||{||}||Ä|AE|Ö|OE|Ü|UE|ä|ae|ö|oe|ü|ue|ß|ss'"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="$text2"/>
		
		<!-- We'll think about doing the rest another day....

		<xsl:variable name="startChar" select="substring($text2,1,1)"/>
		<xsl:variable name="rest" select="substring($text2,2)"/>
		<xsl:variable name="startChars">
			<xsl:text>ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz</xsl:text>
			<xsl:text>ÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ</xsl:text>
			<xsl:text>ĀāĂăĄąĆćĈĉĊċČčĎďĐđĒēĔĕĖėĘęĚěĜĝĞğĠġĢģĤĥĦħĨĩĪīĬĭĮįİıĲĳĴĵĶķĸĹĺĻļĽľĿŀŁłŃńŅņŇňŉŊŋŌōŎŏŐőŒœŔŕŖŗŘřŚśŜŝŞşŠšŢţŤťŦŧŨũŪūŬŭŮůŰűŲųŴŵŶŷŸŹźŻżŽžſƀƁƂƃƄƅƆƇƈƉƊƋƌƍƎƏƐƑƒƓƔƕƖƗƘƙƚƛƜƝƞƟƠơƢƣƤƥƦƧƨƩƪƫƬƭƮƯưƱƲƳƴƵƶƷƸƹƺƻƼƽƾƿǀǁǂǃǄǅǆǇǈǉǊǋǌǍǎǏǐǑǒǓǔǕǖǗǘǙǚǛǜǝǞǟǠǡǢǣǤǥǦǧǨǩǪǫǬǭǮǯǰǱǲǳǴǵǶǷǸǹǺǻǼǽǾǿ</xsl:text>
			<xsl:text>ȀȁȂȃȄȅȆȇȈȉȊȋȌȍȎȏȐȑȒȓȔȕȖȗȘșȚțȜȝȞȟȠȡȢȣȤȥȦȧȨȩȪȫȬȭȮȯȰȱȲȳȴȵȶȷȸȹȺȻȼȽȾȿɀɁɂɃɄɅɆɇɈɉɊɋɌɍɎɏɐɑɒɓɔɕɖɗɘəɚɛɜɝɞɟɠɡɢɣɤɥɦɧɨɩɪɫɬɭɮɯɰɱɲɳɴɵɶɷɸɹɺɻɼɽɾɿʀʁʂʃʄʅʆʇʈʉʊʋʌʍʎʏʐʑʒʓʔʕʖʗʘʙʚʛʜʝʞʟʠʡʢʣʤʥʦʧʨʩʪʫʬʭʮʯʰʱʲʳʴʵʶʷʸʹʺʻʼʽʾʿˀˁ˂˃˄˅ˆˇˈˉˊˋˌˍˎˏːˑ˒˓˔˕˖˗˘˙˚˛˜˝˞˟ˠˡˢˣˤ˥˦˧˨˩˪˫ˬ˭ˮ˯˰˱˲˳˴˵˶˷˸˹˺˻˼˽˾˿</xsl:text>
		</xsl:variable>
		<xsl:variable name="restChars">
			<xsl:text>-.1234567890</xsl:text>
			// technically also #xB7 (Greek comma) | [#x0300-#x036F] (Combinig diacritical marks) | [#x203F-#x2040] (UNDERTIE and CHARACHTER TIE)
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="contains($startChars,$startChar)">
				<xsl:value-of select="$startChar"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'_'"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="translate($rest,concat($startChars,$restChars),'FIXME')"/>

		-->
	</xsl:template>
</xsl:stylesheet>
