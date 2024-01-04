<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" xmlns:math="http://exslt.org/math" extension-element-prefixes="exsl math" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: fn.parseXML.xsl

	XML-Source: any.xml
	XML-Grammar: any
	XML-Content: XML containing encoded XML

	Templates to parse an XML string and convert it into XML nodes & attributes.


	fn.parseXML(XML)
	fn.parseXML_Content(XML,output)
	fn.parseXML_ProcessingInstruction(XML,output)
	fn.parseXML_Element(XML,output)
	fn.parseXML_AttributesAndContent(XML,output)

	How does it work?
	
	The main problem in parsing the XML is simply remembering where you have got to!
	
	Because variables in XML cannot be redefined, it is not possible to simply 
	have a pointer-variable to remember the position in the string,
	rather successive calls to templates have to process a bit (element, 
	comment or whatever) and then - recursively - process the rest of the string.

	However, the XML elements have to be created *hierarchically*, or 
	in other words to create the closing element tag the templates have to
	exit and thus causing the XSLT to go back up the recursion stack, 
	producing the closing elements as it goes.
	
	While this very neatly produces the XML hierarchy it does suffer the 
	problem that all of the local variables are lost - so you forget where
	you had got to in your parsing!
	
	The trick is to parse each bit of the string twice!

		On the first run - with parameter $output='XML' - the XML elements are output (i.e. created)
		On the second run - with parameter $output='RestXMLString' - the XML elements are skipped and the remaining string is output for further parsing.

	===== SEE ALSO =====

	The opposite function fn.serializeXML.xsl

	===== CHANGES HISTORY =====
	2014-05-28 MrW: Version 2.0 Dependencies defined as NEEDS
	2012-09-21 MrW: Version 1.0 (@ 3:33:33 a.m.)
	-->
	<!-- ===== HEAD ===== -->
	<!-- ===== NEEDS ===== -->
	<!--xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/-->
	<!-- ===== TEMPLATES ===== -->
	<!-- 
	 ! fn.parseXML function 
	 !
	 !
	 !   
	 !-->
	<xsl:template name="fn.parseXML">
		<xsl:param name="XML"/>
		<!--  -->
		<xsl:call-template name="fn.parseXML_Content">
			<xsl:with-param name="XML" select="$XML"/>
			<xsl:with-param name="output" select="'XML'"/>
			<!--xsl:with-param name="ElementStack" select="''"/-->
		</xsl:call-template>
	</xsl:template>
	<!-- Parse element content
	 ! Begins after a tag is closed.
	 !-->
	<xsl:template name="fn.parseXML_Content">
		<xsl:param name="XML"/>
		<xsl:param name="output"/>
		<!--  -->
		<xsl:variable name="l" select="string-length($XML)"/>
		<xsl:if test="$l&gt;0">
			<xsl:variable name="posLT" select="$l - string-length(substring-after($XML,'&lt;'))"/>
			<xsl:choose>
				<!-- look for an XML element or comment - in other words a less-than character -->
				<xsl:when test="not(contains($XML,'&lt;'))">
					<!-- No more tags found -->
					<xsl:if test="$output='XML'">
						<!-- Output the remaining text, if any, as a text node -->
						<xsl:value-of select="$XML"/>
					</xsl:if>
					<xsl:if test="$output='RestXMLString'">
						<!-- No more text to parse -->
						<xsl:value-of select="''"/>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<!-- Tag found -->
					<xsl:if test="$output='XML'">
						<!-- First of all output the text before the opening <, if any, as a text node -->
						<xsl:value-of select="substring-before($XML,'&lt;')"/>
					</xsl:if>
					<!-- See what kind of tag it is -->
					<xsl:choose>
						<xsl:when test="substring($XML,$posLT,4)='&lt;!--'">
							<!-- XML Comment -->
							<xsl:variable name="posEndComment" select="$l - string-length(substring-after($XML,'--&gt;'))"/>
							<xsl:if test="$output='XML'">
								<!-- Output the comment -->
								<xsl:variable name="commentText" select="substring($XML,$posLT+4,$posEndComment - $posLT-4)"/>
								<xsl:comment>
									<xsl:value-of select="$commentText"/>
								</xsl:comment>
							</xsl:if>
							<!-- and continue processing the content in the rest of the XML String -->
							<xsl:call-template name="fn.parseXML_Content">
								<xsl:with-param name="XML" select="substring($XML,$posEndComment+3)"/>
								<xsl:with-param name="output" select="$output"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="substring($XML,$posLT,2)='&lt;?'">
							<!-- Processing instruction -->
							<!-- in extra template -->
							<xsl:call-template name="fn.parseXML_ProcessingInstruction">
								<xsl:with-param name="XML" select="substring($XML,$posLT+2)"/>
								<xsl:with-param name="output" select="$output"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="substring($XML,$posLT,8)='&lt;!DOCTYPE'">
							<!-- SGML DOCTYPE declaration -->
							<xsl:variable name="posEndDoctypeDeclaration" select="$l - string-length(substring-after($XML,'--&gt;'))"/>
							<xsl:if test="$output='XML'">
								<!-- Output the DOCTYPE declaration -->
								<xsl:variable name="doctypeDeclarationText" select="substring($XML,$posLT+8,$posEndDoctypeDeclarationText - $posLT-8)"/>
								<xsl:comment>
									<xsl:value-of select="$doctypeDeclarationText"/>
								</xsl:comment>
							</xsl:if>
							<!-- and continue processing the content in the rest of the XML String -->
							<xsl:call-template name="fn.parseXML_Content">
								<xsl:with-param name="XML" select="substring($XML,$posEndDoctypeDeclaration+3)"/>
								<xsl:with-param name="output" select="$output"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="substring($XML,$posLT+1,1)='/'">
							<!-- Closing Element </...-->
							<!-- Later: you could put code here to check starting and ending tags match -->
							<!-- For now: we'll just assume they do -->
							<xsl:if test="$output='XML'">
								<!-- At this point we need do no more than exit this
								 ! template and return back UP the xslt stack so that
								 ! the template where the opening tag was output
								 ! can (automatically) output the matching closing tag.
								 !-->
							</xsl:if>
							<xsl:if test="$output='RestXMLString'">
								<!-- output the RestXMLString starting after the next '>' so that the
								 ! template that outputs the element tags can continue parsing the XML 
								 ! after the end of the closing tag.
								 !-->
								<xsl:variable name="posEndElement" select="$l - string-length(substring-after($XML,'&gt;'))"/>
								<xsl:value-of select="substring($XML,$posEndElement+1)"/>
							</xsl:if>
						</xsl:when>
						<xsl:when test="contains($WHITE_SPACE,substring($XML,$posLT + 1,1))">
							<!-- FIXME unallowed white-space error -->
							<xsl:value-of select="concat('ERROR: illegal white-space at character ',$posLT+1)"/>
							<xsl:value-of select="'/'"/>
							<xsl:value-of select="$posLT"/>
							<xsl:value-of select="'/'"/>
							<xsl:value-of select="$XML"/>
							<xsl:value-of select="'/'"/>
						</xsl:when>
						<xsl:otherwise>
							<!-- ELEMENT GEFUNDEN -->
							<!-- Output Element XML -->
							<xsl:call-template name="fn.parseXML_Element">
								<xsl:with-param name="XML" select="substring($XML,$posLT+1)"/>
								<xsl:with-param name="output" select="$output"/>
							</xsl:call-template>
							<!-- and continue processing the content in the rest of the XML String>
							<xsl:call-template name="fn.parseXML_Content">
								<xsl:with-param name="XML"-->
							<!-- Get the rest of the XML String -->
							<!--xsl:call-template name="fn.parseXML_Element">
										<xsl:with-param name="XML" select="substring($XML,$posLT+1)"/>
										<xsl:with-param name="output" select="'RestXMLString'"/>
									</xsl:call-template>
								</xsl:with-param>
								<xsl:with-param name="output" select="$output"/>
							</xsl:call-template-->
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<!--
	 ! fn.parseXML_ProcessingInstruction
	 !
	 ! beginning after the "<?", parses the XML string looking for the end of the element name and 
	 ! if output="XML" outputs the processing instruction
	 ! if output="RestXMLString" outputs the rest unused part of the XML string
	 !-->
	<xsl:template name="fn.parseXML_ProcessingInstruction">
		<xsl:param name="XML"/>
		<xsl:param name="output"/>
		<!--  -->
		<xsl:variable name="l" select="string-length($XML)"/>
		<xsl:variable name="posSPACE" select="$l - string-length(substring-after($XML,' '))"/>
		<xsl:variable name="posTAB" select="$l - string-length(substring-after($XML,$TAB))"/>
		<xsl:variable name="posCR" select="$l - string-length(substring-after($XML,$CR))"/>
		<xsl:variable name="posLF" select="$l - string-length(substring-after($XML,$LF))"/>
		<xsl:variable name="posEndProcessingInstruction" select="$l - string-length(substring-after($XML,'?&gt;'))"/>
		<xsl:variable name="valuesRTF">
			<values>
				<value>
					<xsl:value-of select="$posSPACE"/>
				</value>
				<value>
					<xsl:value-of select="$posTAB"/>
				</value>
				<value>
					<xsl:value-of select="$posCR"/>
				</value>
				<value>
					<xsl:value-of select="$posLF"/>
				</value>
				<value>
					<xsl:value-of select="$posEndProcessingInstruction"/>
				</value>
			</values>
		</xsl:variable>
		<xsl:variable name="posNext" select="math:min(exsl:node-set($valuesRTF)//value)"/>
		<xsl:if test="$output='XML'">
			<!-- Output the processing instruction -->
			<xsl:variable name="processingInstructionName" select="substring($XML,1,$posNext - 1)"/>
			<xsl:variable name="processingInstructionText" select="substring($XML,1,posEndProcessingInstruction - $posNext)"/>
			<xsl:processing-instruction name="$processingInstructionName">
				<xsl:value-of select="$processingInstructionText"/>
			</xsl:processing-instruction>
		</xsl:if>
		<!-- and continue processing the content in the rest of the XML String -->
		<xsl:call-template name="fn.parseXML_Content">
			<xsl:with-param name="XML" select="substring($XML,$posEndProcessingInstruction+2)"/>
			<xsl:with-param name="output" select="$output"/>
		</xsl:call-template>
	</xsl:template>
	<!--
	 ! fn.parseXML_Element
	 !
	 ! beginning after the "<", parses the XML string looking for the end of the element name and 
	 ! if output="XML" outputs the XML Elements and attributes
	 ! if output="RestXMLString" outputs the rest unused part of the XML string
	 !-->
	<xsl:template name="fn.parseXML_Element">
		<xsl:param name="XML"/>
		<xsl:param name="output"/>
		<xsl:param name="namespace" select="''"/>
		<!--  -->
		<xsl:variable name="l" select="string-length($XML)"/>
		<xsl:variable name="posCOLON" select="$l - string-length(substring-after($XML,':'))"/>
		<xsl:variable name="posSPACE" select="$l - string-length(substring-after($XML,' '))"/>
		<xsl:variable name="posTAB" select="$l - string-length(substring-after($XML,$TAB))"/>
		<xsl:variable name="posCR" select="$l - string-length(substring-after($XML,$CR))"/>
		<xsl:variable name="posLF" select="$l - string-length(substring-after($XML,$LF))"/>
		<xsl:variable name="posEQ" select="$l - string-length(substring-after($XML,'='))"/>
		<xsl:variable name="posGT" select="$l - string-length(substring-after($XML,'&gt;'))"/>
		<xsl:variable name="posFSGT" select="$l - string-length(substring-after($XML,'/&gt;'))"/>
		<xsl:variable name="valuesRTF">
			<values>
				<value>
					<xsl:value-of select="$posCOLON"/>
				</value>
				<value>
					<xsl:value-of select="$posSPACE"/>
				</value>
				<value>
					<xsl:value-of select="$posTAB"/>
				</value>
				<value>
					<xsl:value-of select="$posCR"/>
				</value>
				<value>
					<xsl:value-of select="$posLF"/>
				</value>
				<value>
					<xsl:value-of select="$posEQ"/>
				</value>
				<value>
					<xsl:value-of select="$posGT"/>
				</value>
				<value>
					<xsl:value-of select="$posFSGT"/>
				</value>
			</values>
		</xsl:variable>
		<xsl:variable name="posNext" select="math:min(exsl:node-set($valuesRTF)//value)"/>
		<xsl:variable name="nextChar" select="substring($XML,$posNext,1)"/>
		<xsl:variable name="elementName" select="normalize-space(substring($XML,1,$posNext - 1))"/>
		<xsl:choose>
			<xsl:when test="$nextChar=':'">
				<!-- Namespace: call this template again, setting the namespace parameter -->
				<xsl:call-template name="fn.parseXML_Element">
					<xsl:with-param name="XML" select="substring-after($XML,':')"/>
					<xsl:with-param name="namespace" select="$elementName"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="contains($WHITE_SPACE,$nextChar) or $nextChar='&gt;'">
				<!-- Whitespace after element name and before attributes -->
				<xsl:if test="$output='XML'">
					<!-- Output element -->
					<xsl:element name="{$elementName}" namespace="{$namespace}">
						<xsl:choose>
							<xsl:when test="$nextChar='&gt;'">
								<!-- Parse the content of the tag '>' -->
								<xsl:call-template name="fn.parseXML_Content">
									<xsl:with-param name="XML" select="substring($XML,$posNext+1)"/>
									<xsl:with-param name="output" select="'XML'"/>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<!-- Parse the attributes and then the content -->
								<xsl:call-template name="fn.parseXML_AttributesAndContent">
									<xsl:with-param name="XML" select="substring($XML,$posNext+1)"/>
									<xsl:with-param name="output" select="'XML'"/>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:element>
				</xsl:if>
				<!-- Then recurse and parse the content of the rest of the XML String -->
				<xsl:call-template name="fn.parseXML_Content">
					<xsl:with-param name="XML">
						<xsl:choose>
							<xsl:when test="$nextChar='&gt;'">
								<!-- After skipping past the end of this element -->
								<xsl:call-template name="fn.parseXML_Content">
									<xsl:with-param name="XML" select="substring($XML,$posNext+1)"/>
									<xsl:with-param name="output" select="'RestXMLString'"/>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<!-- After skipping past the the attributes and end of this element -->
								<xsl:call-template name="fn.parseXML_AttributesAndContent">
									<xsl:with-param name="XML" select="substring($XML,$posNext+1)"/>
									<xsl:with-param name="output" select="'RestXMLString'"/>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="output" select="$output"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$nextChar='/'">
				<!-- "/>" End of empty Element -->
				<xsl:if test="$output='XML'">
					<!-- Output an empty element -->
					<xsl:element name="{$elementName}" namespace="{$namespace}"/>
				</xsl:if>
				<!-- and continue processing the content in the rest of the XML String -->
				<xsl:call-template name="fn.parseXML_Content">
					<xsl:with-param name="XML" select="substring($XML,$posNext+2)"/>
					<xsl:with-param name="output" select="$output"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<!-- ERROR: malformned XML -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- 
	 ! parseXML attributes and the element content
	 !
	 ! Starts after 
	 !-->
	<xsl:template name="fn.parseXML_AttributesAndContent">
		<xsl:param name="XML"/>
		<xsl:param name="output"/>
		<xsl:param name="attributeNamespace" select="''"/>
		<!--  -->
		<xsl:variable name="l" select="string-length($XML)"/>
		<xsl:variable name="posCOLON" select="$l - string-length(substring-after($XML,':'))"/>
		<xsl:variable name="posEQ" select="$l - string-length(substring-after($XML,'='))"/>
		<xsl:variable name="posFSGT" select="$l+1-string-length(substring-after($XML,'/&gt;'))"/>
		<xsl:variable name="posGT" select="$l - string-length(substring-after($XML,'&gt;'))"/>
		<xsl:variable name="posQUOT" select="$l - string-length(substring-after($XML,$QUOT))"/>
		<xsl:variable name="valuesRTF">
			<values>
				<value>
					<xsl:value-of select="$posCOLON"/>
				</value>
				<value>
					<xsl:value-of select="$posEQ"/>
				</value>
				<value>
					<xsl:value-of select="$posFSGT"/>
				</value>
				<value>
					<xsl:value-of select="$posGT"/>
				</value>
				<value>
					<xsl:value-of select="$posQUOT"/>
				</value>
			</values>
		</xsl:variable>
		<xsl:variable name="posNext" select="math:min(exsl:node-set($valuesRTF)//value)"/>
		<xsl:variable name="nextChar" select="substring($XML,$posNext,1)"/>
		<xsl:variable name="attributeName" select="normalize-space(substring($XML,1,$posNext - 1))"/>
		<xsl:choose>
			<xsl:when test="$nextChar=':'">
				<!-- Namespace: call this template again, setting the namespace parameter -->
				<xsl:call-template name="fn.parseXML_AttributesAndContent">
					<xsl:with-param name="XML" select="substring($XML,$posNext+1)"/>
					<xsl:with-param name="output" select="$output"/>
					<xsl:with-param name="attributeNamespace" select="$attributeName"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$nextChar='='">
				<!-- ATTRIBUTE -->
				<xsl:variable name="posQUOT2" select="$l - string-length(substring-after(substring($XML,$posQUOT+1),$QUOT))"/>
				<xsl:if test="$output='XML'">
					<!-- Output attribute -->
					<xsl:attribute name="{$attributeName}" namespace="{$attributeNamespace}">
						<xsl:value-of select="substring($XML,$posQUOT+1,$posQUOT2 - $posQUOT - 1)"/>
					</xsl:attribute>
				</xsl:if>
				<!-- and continue processing the attributes after the second quote -->
				<xsl:call-template name="fn.parseXML_AttributesAndContent">
					<xsl:with-param name="XML" select="substring($XML,$posQUOT2+1)"/>
					<xsl:with-param name="output" select="$output"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$nextChar='&gt;'">
				<!-- '>' end of tag and start of content-->
				<!-- and continue processing the element content  after the close of the element -->
				<xsl:call-template name="fn.parseXML_Content">
					<xsl:with-param name="XML" select="substring($XML,$posNext+1)"/>
					<xsl:with-param name="output" select="$output"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$nextChar='/'">
				<!-- '/>' No more attributes and an emptytag with no content-->
				<!-- i.e. No more to output -->
				<xsl:if test="$output='RestXMLString'">
					<xsl:value-of select="substring($XML,$posNext+2)"/>
				</xsl:if>
				<!-- NOW GO BACK UP THE STACK in order to output the closing element tag -->
			</xsl:when>
			<xsl:otherwise>
				<!-- ERROR: malformned XML -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>