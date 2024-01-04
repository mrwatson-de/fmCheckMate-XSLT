<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" version="1.0" exclude-result-prefixes="exsl">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: fn.GetAbsoluteBounds.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: XML2
	XML-Content: Layout objects

	Functions for processing LayoutObjectBounds in fmp12 layout objects which are RELATIVE to their parent container.
	
	FIXME - ouch this is more complicated than I thought.
	An objects absolute coordinates are the sum of their and their parents' coordinates, EXCEPT:

	1. Portal borders (left ad top) affect the contained elements
	  Objects in Portal Container Pos = AbsPosParent + LineWidth + PosRelToContainer

	2. Popover coordinates are absolute
	
	3. Popover coordinates are ONLY NEARLY absolute
	
	===== CHANGES HISTORY =====
	2015-09-22 MrW: Version 2.3 Functions as named templates: fn.GetAbsBoundsOfCurrentNodeAsNumber/Text
	2015-09-16 MrW: Version 2.2 Corrected for PopoverButtons (Popovers, embedded in the Button, must ignore the button's Bounds)
	2015-09-15 MrW: Version 2.1 Added Layout.GetAbsoluteBoundsAsNumber to similarly get the layout enclosing rectangle
	2015-04-27 MrW: Version 2.0 Changed to use modes instead of calls + added mode "toString"
	2014-07-07 MrW: Version 1.1 New function GetAbsoluteBoundsAsNumber
	2014-07-02 MrW: Version 1.0
	-->
	<!-- Bounds.GetAbsoluteBoundsAsNumber -->
	<xsl:template match="Bounds" mode="GetAbsoluteBoundsAsNumber">
		<!-- Bounds -->
		<xsl:variable name="Bounds.top.rel" select="number(@top)"/>
		<xsl:variable name="Bounds.left.rel" select="number(@left)"/>
		<xsl:variable name="Bounds.bottom.rel" select="number(@bottom)"/>
		<xsl:variable name="Bounds.right.rel" select="number(@right)"/>
		<!--  -->
		<xsl:variable name="width" select="$Bounds.right.rel - $Bounds.left.rel"/>
		<xsl:variable name="height" select="$Bounds.bottom.rel - $Bounds.top.rel"/>
		<!--  -->
		<!-- The following calculates the absolute coordinates - corrects a pixel difference in portals - and ignores the position of PopoverButtons (at least for contained objects) -->
		<xsl:variable name="top.abs" select="sum(ancestor::Object[Bounds]/Bounds/@top) + count(ancestor::PortalObj) - sum(ancestor::Object/ancestor::Object[@type='PopoverButton' and Bounds]/Bounds/@top)"/>
		<xsl:variable name="left.abs" select="sum(ancestor::Object[Bounds]/Bounds/@left) + count(ancestor::PortalObj) - sum(ancestor::Object/ancestor::Object[@type='PopoverButton' and Bounds]/Bounds/@left)"/>
		<xsl:variable name="bottom.abs" select="$top.abs + $height"/>
		<xsl:variable name="right.abs" select="$left.abs + $width"/>
		<!--  -->
		<xsl:value-of select="concat('[',$left.abs,',',$top.abs,'-',$right.abs,',',$bottom.abs,'=',$width,'x',$height,']')"/>
	</xsl:template>
	<xsl:template match="Bounds" mode="GetAbsoluteBoundsAsNumberDEBUG">
		<!-- Bounds -->
		<xsl:apply-templates select="ancestor::Object/Bounds" mode="GetAbsoluteBoundsAsNumberDEBUG"/>
		<xsl:variable name="Bounds.top.rel" select="number(@top)"/>
		<xsl:variable name="Bounds.left.rel" select="number(@left)"/>
		<xsl:variable name="Bounds.bottom.rel" select="number(@bottom)"/>
		<xsl:variable name="Bounds.right.rel" select="number(@right)"/>
		<!--  -->
		<xsl:value-of select="concat('[',$Bounds.left.rel,',',$Bounds.top.rel,'-',$Bounds.right.rel,',',$Bounds.bottom.rel,':',ancestor::Object/@type,']')"/>
		<xsl:value-of select="$newrecord"/>
	</xsl:template>
	<!-- Layout.GetAbsoluteBoundsAsNumber -->
	<xsl:template match="Layout" mode="GetAbsoluteBoundsAsNumber">
		<!-- Layout -->
		<xsl:variable name="top.abs" select="@enclosingRectTop"/>
		<xsl:variable name="left.abs" select="@enclosingRectLeft"/>
		<xsl:variable name="bottom.abs" select="@enclosingRectBottom"/>
		<xsl:variable name="right.abs" select="@enclosingRectRight"/>
		<!--  -->
		<xsl:variable name="width" select="$right.abs - $left.abs"/>
		<xsl:variable name="height" select="$bottom.abs - $top.abs"/>
		<!--  -->
		<xsl:value-of select="concat('[',$left.abs,',',$top.abs,'-',$right.abs,',',$bottom.abs,'=',$width,'x',$height,']')"/>
	</xsl:template>
	<!-- Bounds.GetAbsoluteBoundsText -->
	<xsl:template match="Bounds" mode="GetAbsoluteBoundsText">
		<!-- Bounds -->
		<xsl:variable name="Bounds.top.rel" select="number(@top)"/>
		<xsl:variable name="Bounds.left.rel" select="number(@left)"/>
		<xsl:variable name="Bounds.bottom.rel" select="number(@bottom)"/>
		<xsl:variable name="Bounds.right.rel" select="number(@right)"/>
		<!--  -->
		<xsl:variable name="width" select="$Bounds.right.rel - $Bounds.left.rel"/>
		<xsl:variable name="height" select="$Bounds.bottom.rel - $Bounds.top.rel"/>
		<!--  -->
		<xsl:variable name="top.abs" select="sum(ancestor::Object[Bounds]/Bounds/@top) + count(ancestor::PortalObj) - sum(ancestor::Object/ancestor::Object[@type='PopoverButton' and Bounds]/Bounds/@top)"/>
		<xsl:variable name="left.abs" select="sum(ancestor::Object[Bounds]/Bounds/@left) + count(ancestor::PortalObj) - sum(ancestor::Object/ancestor::Object[@type='PopoverButton' and Bounds]/Bounds/@left)"/>
		<xsl:variable name="bottom.abs" select="$top.abs + $height"/>
		<xsl:variable name="right.abs" select="$left.abs + $width"/>
		<xsl:variable name="top.abs.text">
			<xsl:call-template name="GetBoundText">
				<xsl:with-param name="bound" select="$top.abs"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="left.abs.text">
			<xsl:call-template name="GetBoundText">
				<xsl:with-param name="bound" select="$left.abs"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="bottom.abs.text">
			<xsl:call-template name="GetBoundText">
				<xsl:with-param name="bound" select="$bottom.abs"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="right.abs.text">
			<xsl:call-template name="GetBoundText">
				<xsl:with-param name="bound" select="$right.abs"/>
			</xsl:call-template>
		</xsl:variable>
		<!--  -->
		<xsl:value-of select="concat('[',$left.abs.text,',',$top.abs.text,'-',$right.abs.text,',',$bottom.abs.text,'=',$width,'x',$height,']')"/>
	</xsl:template>
	<!--
	 ! fn.GetAbsBoundsOfCurrentObjectAsNumber
	 !
	 ! Returns the Bounds of the current object. 
	 ! The Layout, the Object the Bounds element or a neighboring element must be selected . 
	 !-->
	<xsl:template name="fn.GetAbsBoundsOfCurrentNodeAsNumber">
		<xsl:choose>
			<xsl:when test="self::Layout/@name">
				<!-- DDR Layout (has a name and a width) -->
				<xsl:variable name="top.abs" select="0"/>
				<xsl:variable name="left.abs" select="0"/>
				<xsl:variable name="bottom.abs" select="'?'"/>
				<xsl:variable name="right.abs" select="@width"/>
				<!--  -->
				<xsl:variable name="width" select="@width"/>
				<xsl:variable name="height" select="'?'"/>
				<!--  -->
				<xsl:value-of select="concat('[',$left.abs,',',$top.abs,'-',$right.abs,',',$bottom.abs,'=',$width,'x',$height,']')"/>
			</xsl:when>
			<xsl:when test="self::Layout">
				<!-- fmxmlsnippet Layout (has no name and enclosingBounds)-->
				<xsl:variable name="top.abs" select="@enclosingRectTop"/>
				<xsl:variable name="left.abs" select="@enclosingRectLeft"/>
				<xsl:variable name="bottom.abs" select="@enclosingRectBottom"/>
				<xsl:variable name="right.abs" select="@enclosingRectRight"/>
				<!--  -->
				<xsl:variable name="width" select="$right.abs - $left.abs"/>
				<xsl:variable name="height" select="$bottom.abs - $top.abs"/>
				<!--  -->
				<xsl:value-of select="concat('[',$left.abs,',',$top.abs,'-',$right.abs,',',$bottom.abs,'=',$width,'x',$height,']')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="self::Bounds | Bounds | ../Bounds">
					<xsl:variable name="MasterContainer" select="ancestor-or-self::Object[@type='Popover'][1]"/>
					<!-- -->
					<!-- Bounds -->
					<xsl:variable name="Bounds.top.rel" select="number(@top)"/>
					<xsl:variable name="Bounds.left.rel" select="number(@left)"/>
					<xsl:variable name="Bounds.bottom.rel" select="number(@bottom)"/>
					<xsl:variable name="Bounds.right.rel" select="number(@right)"/>
					<!--  -->
					<xsl:variable name="width" select="$Bounds.right.rel - $Bounds.left.rel"/>
					<xsl:variable name="height" select="$Bounds.bottom.rel - $Bounds.top.rel"/>
					<!--  -->
					<!--  -->
					<!-- The following calculates the absolute coordinates - corrects a pixel difference in portals - and ignores the position of PopoverButtons (at least for contained objects) -->
					<xsl:variable name="top.abs">
						<xsl:choose>
							<xsl:when test="$MasterContainer">
								<!-- calculate portal top border width -->
								<xsl:variable name="portalBorderLeftWidthText" select="translate( substring-before(substring-after(ancestor::PortalObj[not (descendant::Object = $MasterContainer)]/Styles/FullCSS[contains(substring-before(substring-after(text(),'self:normal .self'),'}'),'border-top-style: solid;')]/text() , 'border-top-width:' ) , ';' ), 'pt','')"/>
								<xsl:variable name="portalBorderLeftWidthNr">
									<xsl:choose>
										<xsl:when test="$portalBorderLeftWidthText=''">
											<xsl:value-of select="0"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="number($portalBorderLeftWidthText)"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<!-- calculate pos top -->
								<xsl:value-of select="sum(ancestor::Object[not (descendant::Object = $MasterContainer)]/Bounds/@top) + $portalBorderLeftWidthNr"/>
							</xsl:when>
							<xsl:otherwise>
								<!-- calculate portal top border width -->
								<xsl:variable name="portalBorderLeftWidthText" select="translate( substring-before(substring-after(ancestor::PortalObj/Styles/FullCSS[contains(substring-before(substring-after(text(),'self:normal .self'),'}'),'border-top-style: solid;')]/text() , 'border-top-width:' ) , ';' ), 'pt','')"/>
								<xsl:variable name="portalBorderLeftWidthNr">
									<xsl:choose>
										<xsl:when test="$portalBorderLeftWidthText=''">
											<xsl:value-of select="0"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="number($portalBorderLeftWidthText)"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<!-- calculate pos top -->
								<xsl:value-of select="sum(ancestor::Object/Bounds/@top) + $portalBorderLeftWidthNr"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="left.abs">
						<xsl:choose>
							<xsl:when test="$MasterContainer">
								<!-- calculate portal left border width -->
								<xsl:variable name="portalBorderLeftWidthText" select="translate( substring-before(substring-after(ancestor::PortalObj[not (descendant::Object = $MasterContainer)]/Styles/FullCSS[contains(substring-before(substring-after(text(),'self:normal .self'),'}'),'border-left-style: solid;')]/text() , 'border-left-width:' ) , ';' ), 'pt','')"/>
								<xsl:variable name="portalBorderLeftWidthNr">
									<xsl:choose>
										<xsl:when test="$portalBorderLeftWidthText=''">
											<xsl:value-of select="0"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="number($portalBorderLeftWidthText)"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<!-- calculate pos left -->
								<xsl:value-of select="sum(ancestor::Object[not (descendant::Object = $MasterContainer)]/Bounds/@left) + $portalBorderLeftWidthNr"/>
							</xsl:when>
							<xsl:otherwise>
								<!-- calculate portal left border width -->
								<xsl:variable name="portalBorderLeftWidthText" select="translate( substring-before(substring-after(ancestor::PortalObj/Styles/FullCSS[contains(substring-before(substring-after(text(),'self:normal .self'),'}'),'border-left-style: solid;')]/text() , 'border-left-width:' ) , ';' ), 'pt','')"/>
								<xsl:variable name="portalBorderLeftWidthNr">
									<xsl:choose>
										<xsl:when test="$portalBorderLeftWidthText=''">
											<xsl:value-of select="0"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="number($portalBorderLeftWidthText)"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<!-- calculate pos left -->
								<xsl:value-of select="sum(ancestor::Object/Bounds/@left) + $portalBorderLeftWidthNr"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="bottom.abs" select="$top.abs + $height"/>
					<xsl:variable name="right.abs" select="$left.abs + $width"/>
					<!--  -->
					<xsl:value-of select="concat('[',$left.abs,',',$top.abs,'-',$right.abs,',',$bottom.abs,'=',$width,'x',$height,']')"/>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	 ! fn.GetAbsBoundsOfCurrentNodeAsText
	 !
	 ! Returns the Bounds of the current object. 
	 ! The Object the Bounds element or a neighboring element must be selected . 
	 !-->
	<xsl:template name="fn.GetAbsBoundsOfCurrentNodeAsText">
		<xsl:choose>
			<xsl:when test="name()='Layout'">
				<!-- Layout -->
				<xsl:variable name="top.abs" select="@enclosingRectTop"/>
				<xsl:variable name="left.abs" select="@enclosingRectLeft"/>
				<xsl:variable name="bottom.abs" select="@enclosingRectBottom"/>
				<xsl:variable name="right.abs" select="@enclosingRectRight"/>
				<!--  -->
				<xsl:variable name="width" select="$right.abs - $left.abs"/>
				<xsl:variable name="height" select="$bottom.abs - $top.abs"/>
				<!--  -->
				<xsl:variable name="top.abs.text">
					<xsl:call-template name="GetBoundText">
						<xsl:with-param name="bound" select="$top.abs"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="left.abs.text">
					<xsl:call-template name="GetBoundText">
						<xsl:with-param name="bound" select="$left.abs"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="bottom.abs.text">
					<xsl:call-template name="GetBoundText">
						<xsl:with-param name="bound" select="$bottom.abs"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="right.abs.text">
					<xsl:call-template name="GetBoundText">
						<xsl:with-param name="bound" select="$right.abs"/>
					</xsl:call-template>
				</xsl:variable>
				<!--  -->
				<xsl:value-of select="concat('[',$left.abs.text,',',$top.abs.text,'-',$right.abs.text,',',$bottom.abs.text,'=',$width,'x',$height,']')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="self::Bounds | Bounds | ../Bounds">
					<xsl:variable name="Bounds.top.rel" select="number(@top)"/>
					<xsl:variable name="Bounds.left.rel" select="number(@left)"/>
					<xsl:variable name="Bounds.bottom.rel" select="number(@bottom)"/>
					<xsl:variable name="Bounds.right.rel" select="number(@right)"/>
					<!--  -->
					<xsl:variable name="width" select="$Bounds.right.rel - $Bounds.left.rel"/>
					<xsl:variable name="height" select="$Bounds.bottom.rel - $Bounds.top.rel"/>
					<!--  -->
					<xsl:variable name="top.abs" select="sum(ancestor::Object[Bounds]/Bounds/@top) + count(ancestor::PortalObj) - sum(ancestor::Object/ancestor::Object[@type='PopoverButton' and Bounds]/Bounds/@top)"/>
					<xsl:variable name="left.abs" select="sum(ancestor::Object[Bounds]/Bounds/@left) + count(ancestor::PortalObj) - sum(ancestor::Object/ancestor::Object[@type='PopoverButton' and Bounds]/Bounds/@left)"/>
					<xsl:variable name="bottom.abs" select="$top.abs + $height"/>
					<xsl:variable name="right.abs" select="$left.abs + $width"/>
					<xsl:variable name="top.abs.text">
						<xsl:call-template name="GetBoundText">
							<xsl:with-param name="bound" select="$top.abs"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="left.abs.text">
						<xsl:call-template name="GetBoundText">
							<xsl:with-param name="bound" select="$left.abs"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="bottom.abs.text">
						<xsl:call-template name="GetBoundText">
							<xsl:with-param name="bound" select="$bottom.abs"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="right.abs.text">
						<xsl:call-template name="GetBoundText">
							<xsl:with-param name="bound" select="$right.abs"/>
						</xsl:call-template>
					</xsl:variable>
					<!--  -->
					<xsl:value-of select="concat('[',$left.abs.text,',',$top.abs.text,'-',$right.abs.text,',',$bottom.abs.text,'=',$width,'x',$height,']')"/>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- GetBoundText -->
	<xsl:template name="GetBoundText">
		<xsl:param name="bound"/>
		<!--  -->
		<xsl:if test="$bound &lt; 10">
			<xsl:value-of select="' '"/>
		</xsl:if>
		<xsl:if test="$bound &lt; 100">
			<xsl:value-of select="' '"/>
		</xsl:if>
		<xsl:value-of select="$bound"/>
		<xsl:if test="not(contains($bound,'.'))">
			<xsl:value-of select="'.000000'"/>
		</xsl:if>
	</xsl:template>
	<!-- ===== IGNORE TEXT ===== -->
	<xsl:template match="text()" mode="GetAbsoluteBoundsAsNumber"/>
	<xsl:template match="text()" mode="GetAbsoluteBoundsText"/>
	<!--xsl:template match="/ | *" mode="GetAbsoluteBoundsAsNumber"/>
	<xsl:template match="/ | *" mode="GetAbsoluteBoundsText"/-->
</xsl:stylesheet>
