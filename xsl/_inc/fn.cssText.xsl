<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" version="1.0" exclude-result-prefixes="exsl">
	<!-- ===== AUTHOR =====

	(c) Copyright 2020 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: fn.cssText.xsl

	XML-Source: any.xml
	XML-Grammar: any
	XML-Content: any

	Functions for processing CSS text.
	
	Notes:
	1. The white-space of the css text is normalized for easy processing. 
	2. In all returned text the text-formatting is thus lost.
	3. The functions here only work correctly when the following conditions are met.

	Prerequisites:
	  There MUST be white space around curly braces.
	  The last style of a rule block MUST be terminated with a (usually-optional) semi-colon.
	  Special css-characters ({ } : ;) MAY NOT be used within the body of css styles - neither in comments nor within quotes or apostophes. 
	
	rule { styleName: styleValue; styleName: styleValue; … } 
	
	===== IMPORTANT =====
	
	These templates (currently) work on the assumption that:
	1. within the {definition-part} of a CSS style there are no '}' characters.
	2. '/*' and '*/' are only used to bound block comments, and do not occur in {definition-part}s

	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2020
	2014-05-28 MrW: Version 2.0 Dependencies defined as NEEDS (to be declared at the top level)
	2011-12-29 MrW: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<!--xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/-->
	<!-- NEEDS -->
	<!--xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/-->
	<!--xsl:include href="../../../fmCheckMate/xsl/_inc/fn.Substitute.xsl"/-->
	<!-- ===== VARIABLES ===== -->
	<!--xsl:variable name="delimiter" select="$TAB"/-->
	<!--xsl:variable name="newrecord" select="$RETURN"/-->
	<!-- 
	 ! 
	 ! *PUBLIC* TEMPLATES
	 ! 
	-->
	<xsl:template name="fn.cssText.sort">
		<!-- Params -->
		<xsl:param name="css"/>
		<xsl:param name="filterRulesContaining" select="''"/>
		<!-- -->
		<!-- Markup the css and convert the Result Tree Fragment to 'real' XML node-set -->
		<xsl:variable name="css_Rules_RTF">
			<xsl:call-template name="fn.cssText.markup.CSS-Rules">
				<xsl:with-param name="css" select="$css"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="css_Rules" select="exsl:node-set($css_Rules_RTF)/CSS-Rules"/>
		<xsl:for-each select="$css_Rules/CSS-Rule[contains(CSS-Selector,$filterRulesContaining)]">
			<xsl:sort select="CSS-Selector"/>
			<!-- -->
			<xsl:value-of select="CSS-Selector"/>
			<xsl:value-of select="$newrecord"/>
			<xsl:value-of select="'{'"/>
			<xsl:value-of select="$newrecord"/>
			<xsl:for-each select="CSS-Properties/CSS-Property">
				<xsl:sort select="@name"/>
				<!-- -->
				<xsl:value-of select="$TAB"/>
				<xsl:value-of select="@name"/>
				<xsl:value-of select="': '"/>
				<xsl:value-of select="."/>
				<xsl:value-of select="';'"/>
				<xsl:value-of select="$newrecord"/>
			</xsl:for-each>
			<xsl:value-of select="'}'"/>
			<xsl:value-of select="$newrecord"/>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="fn.cssText.normalize">
		<!-- Params -->
		<xsl:param name="css"/>
		<!-- -->
		<xsl:call-template name="fn.cssText.stripBlockComments">
			<xsl:with-param name="css" select="normalize-space($css)"/>
		</xsl:call-template>
	</xsl:template>
	<!-- fn.cssText.stripBlockComments -->
	<xsl:template name="fn.cssText.stripBlockComments">
		<!-- Params -->
		<xsl:param name="css"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="contains($css,'/*') and contains(substring-after($css ,'/*'),'*/')">
				<xsl:value-of select="substring-before($css ,'/*')"/>
				<xsl:call-template name="fn.cssText.stripBlockComments">
					<xsl:with-param name="css" select="substring-after($css,'*/')"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$css"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- fn.cssText.markup 
	 ! Creates XML:
	 ! <CSS-Rules>
	 ! 	<CSS-Rule>
	 ! 		<Selector>selector</Selector>
	 ! 		<Value>styles</Value>
	 ! 	</CSS-Rule>
	 ! </CSS-Rules>
	 !-->
	<xsl:template name="fn.cssText.markup.CSS-Rules">
		<!-- Params -->
		<xsl:param name="css"/>
		<!-- -->
		<xsl:element name="CSS-Rules">
			<xsl:call-template name="fn.cssText.markup.CSS-Rule">
				<xsl:with-param name="css" select="$css"/>
			</xsl:call-template>
		</xsl:element>
	</xsl:template>
	<!-- 
	 ! 
	 ! *PRIVATE* TEMPLATES
	 ! 
	-->
	<!-- fn.cssText.markup.CSS-Rule
	 !
	 !-->
	<xsl:template name="fn.cssText.markup.CSS-Rule">
		<!-- Params -->
		<xsl:param name="css"/>
		<!-- -->
		<!-- Vars -->
		<xsl:variable name="rule1">
			<xsl:variable name="rule1NoComments">
				<xsl:call-template name="fn.cssText.stripBlockComments">
					<xsl:with-param name="css" select="substring-before($css ,'{')"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:value-of select="normalize-space($rule1NoComments)"/>
		</xsl:variable>
		<!-- Result -->
		<xsl:if test="$rule1!=''">
			<xsl:element name="CSS-Rule">
				<xsl:element name="CSS-Selector">
					<xsl:choose>
						<xsl:when test="1=1">
							<xsl:call-template name="fn.cssText.markup.Selector.FileMaker">
								<xsl:with-param name="cssSelector" select="$rule1"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$rule1"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
				<xsl:element name="CSS-Properties">
					<xsl:call-template name="fn.cssText.markup.CSS-Properties">
						<xsl:with-param name="css" select="substring-before(substring-after($css ,'{') ,'}')"/>
					</xsl:call-template>
				</xsl:element>
			</xsl:element>
			<xsl:call-template name="fn.cssText.markup.CSS-Rule">
				<xsl:with-param name="css" select="substring-after($css ,'}')"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<!--
	 ! 
	 ! FileMaker CSS selectors have the following format:
	 !
	 !       ObjectType.StyleID:State .ObjectElement
	 ! 
	 ! This function marks up the cssSelector, for example drop_down.minimal_drop-down_list:hover .icon:
	 !
	 ! <Selector>
	 ! 	<FmObjectType>drop_down<FmObjectType>
	 !	.
	 ! 	<FmStyleId>minimal_drop-down_list</FmStyleId>
	 !      :
	 ! 	<FmState>hover</FmState>
	 !	.
	 ! 	<FmObjectPart>icon</FmObjectPart>
	 ! </Selector>
	 ! 
	 -->
	<xsl:template name="fn.cssText.markup.Selector.FileMaker">
		<!-- Params -->
		<xsl:param name="cssSelector"/>
		<!-- -->
		<!-- Vars -->
		<xsl:variable name="word1" select="substring-before(concat($cssSelector,' '),' ')"/>
		<xsl:variable name="objectTypeStyle" select="substring-before($word1,':')"/>
		<!-- -->
		<xsl:variable name="fmObjectType" select="substring-before(concat($objectTypeStyle,'.'),'.')"/>
		<xsl:variable name="fMStyleId" select="substring-after($objectTypeStyle,'.')"/>
		<xsl:variable name="fmState" select="substring-after($word1,':')"/>
		<xsl:variable name="fmObjectPart" select="substring-after($word1,' ')"/>
		<!-- Result -->
		<xsl:if test="$cssSelector!=''">
			<xsl:element name="FmObjectType">
				<xsl:value-of select="$fmObjectType"/>
			</xsl:element>
			<xsl:if test="$fMStyleId!=''">
				<xsl:value-of select="'.'"/>
				<xsl:element name="FmStyleId">
					<xsl:value-of select="$fMStyleId"/>
				</xsl:element>
			</xsl:if>
			<xsl:if test="$fmState!=''">
				<xsl:value-of select="':'"/>
				<xsl:element name="FmState">
					<xsl:value-of select="$fmState"/>
				</xsl:element>
			</xsl:if>
			<xsl:if test="$fmObjectPart!=''">
				<xsl:value-of select="':'"/>
				<xsl:element name="FmObjectPart">
					<xsl:value-of select="$fmObjectPart"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<!-- fn.cssText.markup.CSS-Properties
	 !
	 !-->
	<xsl:template name="fn.cssText.markup.CSS-Properties">
		<!-- Params -->
		<xsl:param name="css"/>
		<!-- -->
		<!-- Vars -->
		<xsl:variable name="property1">
			<xsl:variable name="property1NoComments">
				<xsl:call-template name="fn.cssText.stripBlockComments">
					<xsl:with-param name="css" select="substring-before($css ,':')"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:value-of select="normalize-space($property1NoComments)"/>
		</xsl:variable>
		<!-- Result -->
		<xsl:if test="$property1!=''">
			<xsl:element name="CSS-Property">
				<xsl:attribute name="name">
					<xsl:value-of select="$property1"/>
				</xsl:attribute>
				<xsl:value-of select="normalize-space(substring-before(concat(substring-after($css ,':') ,';') ,';'))"/>
			</xsl:element>
			<xsl:call-template name="fn.cssText.markup.CSS-Properties">
				<xsl:with-param name="css" select="substring-after($css ,';')"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<!-- 
	 ! fn.cssText.getRuleNames( css ) function 
	 !
	 !   returns a list of all rule names
	 !-->
	<xsl:template name="fn.cssText.getRuleNames">
		<!-- Params -->
		<xsl:param name="css"/>
		<xsl:call-template name="fn.cssText.normalized.getRuleNames">
			<xsl:with-param name="css">
				<xsl:call-template name="fn.cssText.normalize">
					<xsl:with-param name="css" select="$css"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<!-- 
	 ! fn.cssText.normalized.getRuleNames( css ) function 
	 !
	 !   returns a list of all rule names
	 !-->
	<xsl:template name="fn.cssText.normalized.getRuleNames">
		<!-- Params -->
		<xsl:param name="css"/>
		<!-- Vars -->
		<xsl:variable name="rule1" select="normalize-space( substring-before($css ,'{'))"/>
		<!-- Result -->
		<xsl:if test="$rule1">
			<xsl:value-of select="$rule1"/>
			<xsl:variable name="rest" select="substring-after($css ,'}')"/>
			<xsl:if test="$rest">
				<xsl:value-of select="$newrecord"/>
				<xsl:call-template name="fn.cssText.normalized.getRuleNames">
					<xsl:with-param name="css" select="$rest"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<!-- 
	 ! fn.cssText.format function 
	 !
	 !   Formats the css text output for human consumption (styles on separate lines with indentation).
	 !-->
	<xsl:template name="fn.cssText.format">
		<!-- Params -->
		<xsl:param name="css"/>
		<!-- Vars -->
		<xsl:variable name="cssNormalized" select="concat(normalize-space($css), ' ')"/>
		<!-- Result -->
		<xsl:call-template name="fn.Substitute">
			<xsl:with-param name="text">
				<xsl:call-template name="fn.Substitute">
					<xsl:with-param name="text">
						<xsl:call-template name="fn.Substitute">
							<xsl:with-param name="text" select="$cssNormalized"/>
							<xsl:with-param name="searchString" select="' { '"/>
							<xsl:with-param name="replaceString" select="'&#10;{&#10;&#9;'"/>
						</xsl:call-template>
					</xsl:with-param>
					<xsl:with-param name="searchString" select="'; '"/>
					<xsl:with-param name="replaceString" select="';&#10;&#9;'"/>
				</xsl:call-template>
			</xsl:with-param>
			<xsl:with-param name="searchString" select="'&#9;} '"/>
			<xsl:with-param name="replaceString" select="'}&#10;'"/>
		</xsl:call-template>
	</xsl:template>
	<!-- 
	 ! fn.cssText.getRule function 
	 !
	 !   
	 !-->
	<xsl:template name="fn.cssText.getRule">
		<!-- Params -->
		<xsl:param name="css"/>
		<xsl:param name="rule"/>
		<!-- Vars -->
		<xsl:variable name="cssNormalized" select="concat('} ',normalize-space($css))"/>
		<xsl:variable name="ruleSignature" select="concat('} ',normalize-space($rule),' {')"/>
		<xsl:variable name="ruleBlock" select="normalize-space(concat($rule,' { ', substring-before(substring-after($cssNormalized,$ruleSignature),'}'),' }'))"/>
		<!-- Result -->
		<xsl:value-of select="$ruleBlock"/>
	</xsl:template>
	<!-- 
	 ! fn.cssText.styles.getPropertyValue function 
	 !
	 ! 
	 !-->
	<xsl:template name="fn.cssText.styles.getPropertyValue">
		<!-- Params -->
		<xsl:param name="styles"/>
		<xsl:param name="styleName"/>
		<!-- Vars -->
		<xsl:variable name="stylesNormalized" select="concat('; ', normalize-space($styles))"/>
		<xsl:variable name="propertySignature" select="concat('; ',$styleName,':')"/>
		<xsl:variable name="propertyValue" select="normalize-space(substring-before(substring-after($stylesNormalized,$propertySignature),';'))"/>
		<!-- Result -->
		<xsl:value-of select="$propertyValue"/>
	</xsl:template>
	<!-- 
	 ! fn.cssText.getPropertyValue function 
	 !
	 !   
	 !-->
	<xsl:template name="fn.cssText.getPropertyValue">
		<!-- Params -->
		<xsl:param name="css"/>
		<xsl:param name="rule"/>
		<xsl:param name="styleName"/>
		<!-- Vars -->
		<xsl:variable name="cssNormalized" select="concat('} ',normalize-space($css))"/>
		<xsl:variable name="ruleSignature" select="concat('} ',$rule,' {')"/>
		<xsl:variable name="ruleStyles" select="concat('; ', normalize-space(substring-before(substring-after($cssNormalized,$ruleSignature),'}')))"/>
		<xsl:variable name="propertySignature" select="concat('; ',$styleName,':')"/>
		<xsl:variable name="propertyValue" select="normalize-space(substring-before(substring-after($ruleStyles,$propertySignature),';'))"/>
		<!-- Result -->
		<xsl:value-of select="$propertyValue"/>
	</xsl:template>
	<!-- 
	 ! fn.cssText.setProperty function 
	 !
	 !   
	 !-->
	<xsl:template name="fn.cssText.setProperty">
		<!-- Params -->
		<xsl:param name="css"/>
		<xsl:param name="rule"/>
		<xsl:param name="styleName"/>
		<xsl:param name="styleValue"/>
		<xsl:param name="priority" select="''"/>
		<!-- Vars -->
		<!-- Result -->
	</xsl:template>
	<!-- 
	 ! fn.cssText.addRule function 
	 !
	 ! Adds a rule in the css for the given selectors and styles
	 !-->
	<xsl:template name="fn.cssText.addRule">
		<!-- Params -->
		<xsl:param name="css"/>
		<xsl:param name="rule"/>
		<xsl:param name="stylesText"/>
		<!-- Vars -->
		<!-- Result -->
	</xsl:template>
	<!-- 
	 ! fn.cssText.insertRule function 
	 !
	 ! NOT SUPPORTED
	 !-->
	<!-- 
	 ! fn.cssText.deleteRule function 
	 !
	 ! Deletes the rule from the css for the given selectors
	 !-->
	<xsl:template name="fn.cssText.deleteRule">
		<!-- Params -->
		<xsl:param name="css"/>
		<xsl:param name="rule"/>
		<!-- Vars -->
		<xsl:variable name="cssNormalized" select="normalize-space($css)"/>
		<xsl:variable name="ruleNormalized" select="normalize-space($rule)"/>
		<!-- Result -->
		<xsl:value-of select="concat(substring-before($cssNormalized, $ruleNormalized),substring-after(substring-after($cssNormalized, $ruleNormalized),'}'))"/>
	</xsl:template>
</xsl:stylesheet>
