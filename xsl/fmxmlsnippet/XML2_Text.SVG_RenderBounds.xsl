<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" xmlns:math="http://exslt.org/math" xmlns:str="http://exslt.org/strings" extension-element-prefixes="exsl str math" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2017 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: XML2_Text.SVG_RenderBounds.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied layout objects
	
	Creates an SVG representation of the bounds
	
	
	========================
	NOTES on SVG properties
	========================
	FM	SVG	Description
	f:background-color rgb	fill	Sets fill color of the shape.
	f:background-color a	fill-opacity	Sets fill opacity of the shape.
	n/a	fill-rule	Sets fill rule of the shape (defines 'inside').

	f:border-top-color rgb	stroke	Sets the stroke (line) color used to draw the outline of this shape.
	f:border-top-style	stroke-dasharray	Sets the stroke (line) dashing used to draw the outline of this shape.
	f:border-top-style	stroke-dashoffset	Sets the stroke (line) dash offset used to draw the outline of this shape.
	stroke-linecap:square;	stroke-linecap	Sets the stroke (line) line cap used to draw the outline of this shape. Valid values are round, butt and square.
	n/a	stroke-miterlimit	Sets the stroke (line) miter limit used to draw the outline of this shape.
	f:border-top-color a	stroke-opacity	Sets the stroke (line) opacity used to draw the outline of this shape.
	border-top-width	stroke-width	Sets the stroke (line) width used to draw the outline of this shape.

	?	text-rendering	Sets the text-rendering used to draw the outline of this shape.

	Markers and arrowheads on a line
	n/a	marker	Sets marker used along the lines (edges) of this shape.
	n/a	marker-start	Sets start marker used along the lines (edges) of this shape.
	n/a	marker-mid	Sets mid marker used along the lines (edges) of this shape.
	n/a	marker-end	Sets end marker used along the lines (edges) of this shape.


	FileMaker FullCSS:

	background-image: none;

	background-position: 0% 0%;
	background-size: auto;
	background-repeat: repeat repeat;
	background-origin: padding-box;
	background-clip: border-box;
	background-color: rgba(0%,93.3333%,0%,1);

	border-top-color: rgba(0%,0%,0%,1);
	border-right-color: rgba(0%,0%,0%,1);
	border-bottom-color: rgba(0%,0%,0%,1);
	border-left-color: rgba(0%,0%,0%,1);

	border-top-style: solid;
	border-right-style: solid;
	border-bottom-style: solid;
	border-left-style: solid;

	border-top-width: 3pt;
	border-right-width: 3pt;
	border-bottom-width: 3pt;
	border-left-width: 3pt;

	border-top-right-radius: 6.75pt 6.75pt;
	border-bottom-right-radius: 6.75pt 6.75pt;
	border-bottom-left-radius: 6.75pt 6.75pt;
	border-top-left-radius: 6.75pt 6.75pt;

	border-image-source: none;
	border-image-slice: 100% 100% 100% 100% fill;
	border-image-width: 1 1 1 1;
	border-image-outset: 0 0 0 0;
	border-image-repeat: stretch stretch;

	outline-width: 0pt;
	outline-style: none;
	outline-color: invert;
	outline-offset: 0pt;

	direction: ltr;
	line-height: 1line;
	block-progression: tb;
	text-align: left;
	text-indent: 0pt;
	display: inline;

	padding-top: 0pt;
	padding-right: 0pt;
	padding-bottom: 0pt;
	padding-left: 0pt;

	margin-top: 0pt;
	margin-right: 0pt;
	margin-bottom: 0pt;
	margin-left: 0pt;

	width: auto;
	height: auto;
	float: none;
	clear: none;

	overflow-x: visible;
	overflow-y: visible;
	overflow-style: auto;
	visibility: visible;

	top: auto;
	right: auto;
	bottom: auto;
	left: auto;
	position: static;

	box-shadow: none;
	box-sizing: content-box;

	vertical-align: baseline;





	AND -fm-properties:

	-fm-digit-set: roman;
	-fm-space-before: 0line;
	-fm-space-after: 0line;
	-fm-tab-stops: ;
	-fm-paragraph-margin-left: 0pt;
	-fm-paragraph-margin-right: 0pt;
	-fm-character-direction: ;
	-fm-tab-top-left-radius: 0 0;
	-fm-tab-top-right-radius: 0 0;
	-fm-use-default-appearance: false;
	-fm-icon: none;
	-fm-icon-color: rgba(0%,0%,0%,1);
	-fm-tab-spacing: 0;
	-fm-override-with-classic: true;
	-fm-table-background-color: rgba(0%,0%,0%,0);
	-fm-baseline-shift: 0pt;
	-fm-fill-effect: 0;
	-fm-highlight-color: rgba(0%,0%,0%,0);
	-fm-text-vertical-align: top;
	-fm-tategaki: false;
	-fm-rotation: 0;
	-fm-borders-between-reps: false;
	-fm-borders-baseline: false;
	-fm-texty-field: false;
	-fm-box-shadow-persist: none;
	========================
	
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2016
	2015-05-12 MrW: Version 0.3 with (radial) gradients - but not quite right yet ;)
	2015-05-10 MrW: Version 0.3 with (linear) gradients - but not quite right yet ;)
	2015-05-07 MrW: Version 0.2 with some basic CSS-formatting
	2015-04-29 MrW: Version 0.1
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/fn.Substitute.xsl"/>
	<!-- ===== Vars ===== -->
	<xsl:variable name="debug" select="'1'"/>
	<xsl:variable name="maxRight" select="math:max(//Bounds/@right)+1"/>
	<xsl:variable name="maxBottom" select="math:max(//Bounds/@bottom)+1"/>
	<xsl:variable name="data.font-metrics.line-height">
		<line-height font-size="1" m="">1</line-height>
		<line-height font-size="2" m="">2</line-height>
		<line-height font-size="3" m="">3</line-height>
		<line-height font-size="4" m="">4</line-height>
		<line-height font-size="5" m="">5</line-height>
		<line-height font-size="6" m="">7</line-height>
		<line-height font-size="7" m="">8</line-height>
		<line-height font-size="8" m="">9</line-height>
		<line-height font-size="9" m="">10</line-height>
		<line-height font-size="10" m="">11</line-height>
		<line-height font-size="11">12</line-height>
		<line-height font-size="12">14</line-height>
		<line-height font-size="13">15</line-height>
		<line-height font-size="14">16</line-height>
		<line-height font-size="15">17</line-height>
		<line-height font-size="16">18</line-height>
		<line-height font-size="17">20</line-height>
		<line-height font-size="18">21</line-height>
		<line-height font-size="19">23</line-height>
		<line-height font-size="20">23</line-height>
		<line-height font-size="21">25</line-height>
		<line-height font-size="22">26</line-height>
		<line-height font-size="23" m="">27</line-height>
		<line-height font-size="24">28</line-height>
		<line-height font-size="25" m="">29</line-height>
		<line-height font-size="26" m="">30</line-height>
		<line-height font-size="27" m="">31</line-height>
		<line-height font-size="28" m="">32</line-height>
		<line-height font-size="29" m="">33</line-height>
		<line-height font-size="30" m="">34</line-height>
		<line-height font-size="31" m="">35</line-height>
		<line-height font-size="32" m="">36</line-height>
		<line-height font-size="33" m="">37</line-height>
		<line-height font-size="34" m="">38</line-height>
		<line-height font-size="35" m="">40</line-height>
		<line-height font-size="36">42</line-height>
		<line-height font-size="37" m="">41</line-height>
		<line-height font-size="38" m="">42</line-height>
		<line-height font-size="39" m="">43</line-height>
		<line-height font-size="40" m="">44</line-height>
		<line-height font-size="41" m="">45</line-height>
		<line-height font-size="42" m="">46</line-height>
		<line-height font-size="43" m="">47</line-height>
		<line-height font-size="44" m="">48</line-height>
		<line-height font-size="45" m="">49</line-height>
		<line-height font-size="46" m="">50</line-height>
		<line-height font-size="47" m="">51</line-height>
		<line-height font-size="48" m="">52</line-height>
		<line-height font-size="49" m="">53</line-height>
		<line-height font-size="50" m="">54</line-height>
		<line-height font-size="51" m="">55</line-height>
		<line-height font-size="52" m="">56</line-height>
		<line-height font-size="53" m="">57</line-height>
		<line-height font-size="54" m="">58</line-height>
		<line-height font-size="55" m="">59</line-height>
		<line-height font-size="56" m="">60</line-height>
		<line-height font-size="57" m="">61</line-height>
		<line-height font-size="58" m="">62</line-height>
		<line-height font-size="59" m="">63</line-height>
		<line-height font-size="60" m="">64</line-height>
		<line-height font-size="61" m="">65</line-height>
		<line-height font-size="62" m="">66</line-height>
		<line-height font-size="63" m="">67</line-height>
		<line-height font-size="64" m="">68</line-height>
		<line-height font-size="65" m="">69</line-height>
		<line-height font-size="66" m="">70</line-height>
		<line-height font-size="67" m="">71</line-height>
		<line-height font-size="68" m="">72</line-height>
		<line-height font-size="69" m="">73</line-height>
		<line-height font-size="70" m="">74</line-height>
		<line-height font-size="71" m="">75</line-height>
		<line-height font-size="72" m="">76</line-height>
	</xsl:variable>
	<xsl:key name="lookup.font-metrics.line-height" match="line-height" use="@font-size"/>
	<xsl:variable name="lookup.font-metrics.line-height" select="';1:1;2:2;3:3;4:4;5:5;6:7;7:8;8:9;9:10;10:11;11:12;12:14;13:15;14:16;15:17;16:18;17:20;18:21;19:23;20:23;21:25;22:26;23:27;24:28;25:29;26:30;27:31;28:32;29:33;30:34;31:35;32:36;33:37;34:38;35:40;36:42;37:41;38:42;39:43;40:44;41:45;42:46;43:47;44:48;45:49;46:50;47:51;48:52;49:53;50:54;51:55;52:56;53:57;54:58;55:59;56:60;57:61;58:62;59:63;60:64;61:65;62:66;63:67;64:68;65:69;66:70;67:71;68:72;69:73;70:74;71:75;72:76;'"/>
	<!--  -->
	<xsl:template name="lookup.line-height.from.font-size">
		<xsl:param name="font-size"/>
		<!--  -->
		<xsl:variable name="line-height" select="substring-before(substring-after($lookup.font-metrics.line-height,concat(';',$font-size,':')),';')"/>
		<xsl:choose>
			<xsl:when test="$line-height!=''">
				<xsl:value-of select="number($line-height)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="floor($font-size * 1.17)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ===== TEMPLATES ===== -->
	<!-- Main -->
	<xsl:template match="Layout">
		<xsl:variable name="width" select="@enclosingRectRight - @enclosingRectLeft"/>
		<xsl:variable name="height" select="@enclosingRectBottom - @enclosingRectTop"/>
		<xsl:variable name="viewBox" select="concat(@enclosingRectLeft,' ',@enclosingRectTop,' ',$width,' ',$height)"/>
		<!-- -->
		<xsl:comment>
			<xsl:value-of select="'&#13;&#13;'"/>
			<xsl:value-of select="' LAYOUT OBJECT '"/>
			<xsl:value-of select="'&#13;&#13;'"/>
		</xsl:comment>
		<!-- -->
		<svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="{$maxRight}" height="{$maxBottom}">
			<rect x="{@enclosingRectLeft - 1}" y="{@enclosingRectTop - 1}" height="{$height + 2}" width="{$width + 2}" style="stroke-width:1;stroke-dasharray: 10 5;stroke:#cccccc;fill:none;"/>
			<defs>
				<xsl:apply-templates select="*" mode="defs"/>
			</defs>
			<xsl:apply-templates select="*"/>
		</svg>
	</xsl:template>
	<!--
	 !
	 !
	 ! DEFINE GRADIENTS ("defs"-mode)
	 !
	 ! in the fmxmlsnippet the gradient is defined in the css.self.background-image property
	 ! by way of a webkit-gradient tag. Gradients are linear or radial.
	 !
	 ! an example linear gradient:
	 !        background-image: -webkit-gradient(linear,25% 0%,25% 100%, from(rgba(86.3%,86.3%,86.3%,1)), to(rgba(100%,90.9804%,36.0784%,1)));
	 !
	 ! an example radial gradient with two colors (fm13):
	 !        background-image: -webkit-gradient(radial,49.8817% 47.0588%,0,100.833% 23.8095%,0, from(rgba(100%,90.9804%,36.0784%,1)), to(rgba(100%,40%,20%,1)));
	 !
	 ! pretty much the same radial gradient with two colors, however the second is not at the very end of the line:
	 !        background-image: -webkit-gradient(radial,49.0382% 49.9837%,0,100% 26.1905%,0, from(rgba(100%,90.9804%,36.0784%,1)), color-stop(0.99666, rgba(100%,40%,20%,1)));
	 !
	 ! The from and to functions are no more than color stops at the beginning and end of the color line:
	 ! from(...) = color-stop(0,...), 
	 ! to(...) = color-stop(1.0,...), 
	
	 !-->
	<!--
	 !
	 ! Match all FullCSS tags which contain a -webkit-gradient property
	 !
	 !-->
	<xsl:template mode="defs" match="text()"/>
	<xsl:template mode="defs" match="FullCSS[text()[contains(.,'-webkit-gradient')]]">
		<xsl:variable name="type" select="ancestor::Object/@type"/>
		<xsl:variable name="id" select="generate-id(.)"/>
		<!-- -->
		<xsl:variable name="css" select="text()"/>
		<xsl:variable name="css.self" select="substring-before(substring-after($css,'{'),'}')"/>
		<!-- -->
		<xsl:variable name="css.self.background-image" select="substring-before(substring-after($css.self, 'background-image: '),';')"/>
		<xsl:variable name="css.self.background-image.webkit-gradient" select="substring-after($css.self.background-image, '-webkit-gradient(')"/>
		<xsl:variable name="css.self.background-image.webkit-gradient.simplified">
			<xsl:call-template name="fn.SubstituteMany">
				<xsl:with-param name="text" select="$css.self.background-image.webkit-gradient"/>
				<xsl:with-param name="substitutions" select="'from(|color-stop(0,|to(|color-stop(1,'"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="css.self.background-image.webkit-gradient.params" select="substring-before($css.self.background-image.webkit-gradient.simplified, 'color-stop')"/>
		<xsl:variable name="css.self.background-image.webkit-gradient.type" select="str:tokenize($css.self.background-image.webkit-gradient.params, ',')[1]"/>
		<xsl:variable name="css.self.background-image.webkit-gradient.p1" select="str:tokenize($css.self.background-image.webkit-gradient.params, ',')[2]"/>
		<xsl:variable name="css.self.background-image.webkit-gradient.p2" select="str:tokenize($css.self.background-image.webkit-gradient.params, ',')[3]"/>
		<xsl:variable name="css.self.background-image.webkit-gradient.p3" select="str:tokenize($css.self.background-image.webkit-gradient.params, ',')[4]"/>
		<xsl:variable name="css.self.background-image.webkit-gradient.color-stops" select="substring($css.self.background-image.webkit-gradient.simplified, 1+string-length($css.self.background-image.webkit-gradient.params))"/>
		<!-- -->
		<xsl:comment>
			<xsl:value-of select="'&#13;'"/>
			<xsl:value-of select="concat('css.self.background-image.webkit-gradient: ',$css.self.background-image.webkit-gradient,'&#13;')"/>
			<xsl:value-of select="concat('css.self.background-image.webkit-gradient.simplified: ',$css.self.background-image.webkit-gradient.simplified,'&#13;')"/>
			<xsl:value-of select="concat('css.self.background-image.webkit-gradient.type: ',$css.self.background-image.webkit-gradient.type,'&#13;')"/>
			<xsl:value-of select="concat('css.self.background-image.webkit-gradient.p1: ',$css.self.background-image.webkit-gradient.p1,'&#13;')"/>
			<xsl:value-of select="concat('css.self.background-image.webkit-gradient.p2: ',$css.self.background-image.webkit-gradient.p2,'&#13;')"/>
			<xsl:value-of select="concat('css.self.background-image.webkit-gradient.p3: ',$css.self.background-image.webkit-gradient.p3,'&#13;')"/>
			<xsl:value-of select="concat('css.self.background-image.webkit-gradient.color-stops: ',$css.self.background-image.webkit-gradient.color-stops,'&#13;')"/>
		</xsl:comment>
		<xsl:choose>
			<xsl:when test="$css.self.background-image.webkit-gradient.type='linear'">
				<xsl:variable name="css.self.background-image.webkit-gradient.x1" select="substring-before($css.self.background-image.webkit-gradient.p1,' ')"/>
				<xsl:variable name="css.self.background-image.webkit-gradient.y1" select="substring-after($css.self.background-image.webkit-gradient.p1,' ')"/>
				<xsl:variable name="css.self.background-image.webkit-gradient.x2" select="substring-before($css.self.background-image.webkit-gradient.p2,' ')"/>
				<xsl:variable name="css.self.background-image.webkit-gradient.y2" select="substring-after($css.self.background-image.webkit-gradient.p2,' ')"/>
				<linearGradient id="{$id}" x1="{$css.self.background-image.webkit-gradient.x1}" y1="{$css.self.background-image.webkit-gradient.y1}" x2="{css.self.background-image.webkit-gradient.x2}" y2="{$css.self.background-image.webkit-gradient.y2}">
					<xsl:call-template name="webkit-gradient.renderSvgColorStops">
						<xsl:with-param name="pText" select="$css.self.background-image.webkit-gradient.color-stops"/>
					</xsl:call-template>
				</linearGradient>
			</xsl:when>
			<xsl:when test="$css.self.background-image.webkit-gradient.type='radial'">
				<!--radialGradient id="grad1" cx="50%" cy="50%" r="50%" fx="50%" fy="50%">
			      <stop offset="0%" style="stop-color:rgb(255,255,255);
			      stop-opacity:0" />
			      <stop offset="100%" style="stop-color:rgb(0,0,255);stop-opacity:1" />
			    </radialGradient-->
				<!-- -->
				<xsl:variable name="css.self.background-image.webkit-gradient.cx" select="substring-before($css.self.background-image.webkit-gradient.p1,' ')"/>
				<xsl:variable name="css.self.background-image.webkit-gradient.cy" select="substring-after($css.self.background-image.webkit-gradient.p1,' ')"/>
				<xsl:variable name="css.self.background-image.webkit-gradient.r" select="$css.self.background-image.webkit-gradient.p2"/>
				<xsl:variable name="css.self.background-image.webkit-gradient.fx" select="substring-before($css.self.background-image.webkit-gradient.p3,' ')"/>
				<xsl:variable name="css.self.background-image.webkit-gradient.fy" select="substring-after($css.self.background-image.webkit-gradient.p3,' ')"/>
				<!-- -->
				<xsl:variable name="css.self.background-image.webkit-gradient.cx.n" select="number(translate($css.self.background-image.webkit-gradient.cx,'%',''))"/>
				<xsl:variable name="css.self.background-image.webkit-gradient.cy.n" select="number(translate($css.self.background-image.webkit-gradient.cy,'%',''))"/>
				<xsl:variable name="css.self.background-image.webkit-gradient.r.n" select="number(translate($css.self.background-image.webkit-gradient.r,'%',''))"/>
				<xsl:variable name="css.self.background-image.webkit-gradient.fx.n" select="number(translate($css.self.background-image.webkit-gradient.fx,'%',''))"/>
				<xsl:variable name="css.self.background-image.webkit-gradient.fy.n" select="number(translate($css.self.background-image.webkit-gradient.fy,'%',''))"/>
				<!-- -->
				<xsl:variable name="r" select="math:sqrt(($css.self.background-image.webkit-gradient.fx.n - $css.self.background-image.webkit-gradient.cx.n) * ($css.self.background-image.webkit-gradient.fx.n - $css.self.background-image.webkit-gradient.cx.n) + ($css.self.background-image.webkit-gradient.fy.n - $css.self.background-image.webkit-gradient.cy.n) * ($css.self.background-image.webkit-gradient.fy.n - $css.self.background-image.webkit-gradient.cy.n)) div 100"/>
				<!-- -->
				<radialGradient id="{$id}" cx="{$css.self.background-image.webkit-gradient.cx}" cy="{$css.self.background-image.webkit-gradient.cy}" r="{$r}">
					<xsl:call-template name="webkit-gradient.renderSvgColorStops">
						<xsl:with-param name="pText" select="$css.self.background-image.webkit-gradient.color-stops"/>
					</xsl:call-template>
				</radialGradient>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat('WHAT kind of gradiant is that?: ',$css.self.background-image.webkit-gradient )"/>
				<!-- the gradient is not a background fill gradient: we can do border gradients another day I think ;-) -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- webkit-gradient.renderSvgColorStops -->
	<xsl:template name="webkit-gradient.renderSvgColorStops">
		<xsl:param name="pText"/>
		<!-- -->
		<xsl:variable name="colorStop" select="substring-after($pText,'color-stop(')"/>
		<!-- -->
		<xsl:choose>
			<xsl:when test="$colorStop=''">
				<!-- finished -->
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="colorStop.offset" select="substring-before($colorStop,',')"/>
				<xsl:variable name="colorStop.rgba" select="substring-before(substring-after($colorStop,'rgba('),')')"/>
				<xsl:variable name="colorStop.a" select="str:tokenize($colorStop.rgba, ',')[4]"/>
				<xsl:variable name="colorStop.rgb" select="substring($colorStop.rgba,1,string-length( $colorStop.rgba) - string-length( $colorStop.a) - 1)"/>
				<xsl:variable name="colorStop.rest" select="substring-after(substring-after($colorStop,'))'),',')"/>
				<!-- -->
				<xsl:variable name="colorStop.offset.percent" select="concat(number($colorStop.offset)*100,'%')"/>
				<xsl:variable name="colorStop.style" select="concat('stop-color:rgb(',$colorStop.rgb,');stop-opacity:',$colorStop.a,';')"/>
				<!-- -->
				<stop offset="{$colorStop.offset.percent}" style="{$colorStop.style}"/>
				<!-- Recurse -->
				<xsl:call-template name="webkit-gradient.renderSvgColorStops">
					<xsl:with-param name="pText" select="$colorStop"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	 ! Container Objects
	 !
	 ! DO NOT recurse through the contents of containers!
	 ! This is because containers have their own internal coordinate system, 
	 ! so the contents are processed relative to the Bounds of the container.
	 !-->
	<xsl:template match="Object[@type='TabControl' or @type='SlideControl' or @type='Portal' or @type='Popover' or @type='GroupButton' or @type='ButtonBar']">
		<!-- DO, however, draw their bounds (and recurse from there) -->
		<xsl:apply-templates select="Bounds"/>
	</xsl:template>
	<!--
	 ! Bounds
	 !
	 !
	 !
	 !
	 !
	 !-->
	<xsl:template match="Bounds">
		<!-- -->
		<xsl:variable name="type" select="parent::Object/@type"/>
		<xsl:variable name="flags" select="number(parent::Object/@flags)"/>
		<xsl:variable name="rightToLeft" select="substring($flags mod (2*4096) div 4096,1,1)"/>
		<xsl:variable name="bottomToTop" select="substring($flags mod (2*8192) div 8192,1,1)"/>
		<!-- -->
		<xsl:variable name="left" select="@left"/>
		<xsl:variable name="right" select="@right"/>
		<xsl:variable name="bottom" select="@bottom"/>
		<xsl:variable name="top" select="@top"/>
		<xsl:variable name="width" select="$right - $left"/>
		<xsl:variable name="height" select="$bottom - $top"/>
		<xsl:variable name="center" select="$left + $width div 2"/>
		<xsl:variable name="middle" select="$top + $height div 2"/>
		<!-- -->
		<!-- 
		 !                           FIXME 
		 ! NOTE: IN PORTALS: The border size works like PADDING, making the inner space SMALLER
		 !       and causing the inner coordinate space to MOVE
		 !-->
		<!-- -->
		<xsl:variable name="css">
			<xsl:choose>
				<xsl:when test="$type='Text' or $type='Button' or $type='PopoverButton'">
					<xsl:value-of select="parent::Object/TextObj/Styles/FullCSS"/>
				</xsl:when>
				<xsl:when test="$type='Field'">
					<xsl:value-of select="parent::Object/FieldObj/Styles/FullCSS"/>
				</xsl:when>
				<xsl:when test="$type='Slider'">
					<xsl:value-of select="parent::Object/SliderObj/Styles/FullCSS"/>
				</xsl:when>
				<xsl:when test="$type='Portal'">
					<xsl:value-of select="parent::Object/PortalObj/Styles/FullCSS"/>
				</xsl:when>
				<xsl:when test="$type='Graphic'">
					<xsl:value-of select="parent::Object/GraphicObj/Styles/FullCSS/text()"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="parent::Object/Styles/FullCSS"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="css.id">
			<xsl:choose>
				<xsl:when test="$type='Text' or $type='Button' or $type='PopoverButton'">
					<xsl:value-of select="generate-id(parent::Object/TextObj/Styles/FullCSS)"/>
				</xsl:when>
				<xsl:when test="$type='Graphic'">
					<xsl:value-of select="generate-id(parent::Object/GraphicObj/Styles/FullCSS)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="generate-id(parent::Object/Styles/FullCSS)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="css.self" select="substring-before(substring-after($css,'{'),'}')"/>
		<!-- -->
		<xsl:variable name="css.self.background-color" select="substring-before(substring-after($css.self, 'background-color: '),';')"/>
		<xsl:variable name="css.self.background-color.rgba" select="substring-before(substring-after($css.self.background-color, '('),')')"/>
		<xsl:variable name="css.self.background-color.a" select="str:tokenize($css.self.background-color.rgba, ',')[4]"/>
		<xsl:variable name="css.self.background-color.rgb" select="substring($css.self.background-color.rgba,1,string-length( $css.self.background-color.rgba) - string-length( $css.self.background-color.a) - 1)"/>
		<!-- -->
		<xsl:variable name="css.self.border-top-color" select="substring-before(substring-after($css.self, 'border-top-color: '),';')"/>
		<xsl:variable name="css.self.border-top-color.rgba" select="substring-before(substring-after($css.self.border-top-color, '('),')')"/>
		<xsl:variable name="css.self.border-top-color.a" select="str:tokenize($css.self.border-top-color.rgba, ',')[4]"/>
		<xsl:variable name="css.self.border-top-color.rgb" select="substring($css.self.border-top-color.rgba,1,string-length( $css.self.border-top-color.rgba) - string-length( $css.self.border-top-color.a) - 1)"/>
		<xsl:variable name="css.self.border-top-width" select="substring-before(substring-after($css.self, 'border-top-width: '),';')"/>
		<xsl:variable name="css.self.border-top-left-radius" select="substring-before(substring-after($css.self, 'border-top-left-radius: '),';')"/>
		<xsl:variable name="css.self.border-top-left-radius.rx" select="substring-before(normalize-space($css.self.border-top-left-radius), ' ')"/>
		<xsl:variable name="css.self.border-top-left-radius.rx.n" select="number(translate($css.self.border-top-left-radius.rx, translate($css.self.border-top-left-radius.rx, '1234567890.', ''), ''))"/>
		<xsl:variable name="css.self.border-top-left-radius.ry" select="substring-after(normalize-space($css.self.border-top-left-radius), ' ')"/>
		<xsl:variable name="css.self.border-top-left-radius.ry.n" select="number(translate($css.self.border-top-left-radius.ry, translate($css.self.border-top-left-radius.ry, '1234567890.', ''), ''))"/>
		<!-- -->
		<xsl:variable name="css.self.background-image" select="substring-before(substring-after($css.self, 'background-image: '),';')"/>
		<xsl:variable name="css.self.background-image.webkit-gradient" select="substring-after($css.self.background-image,'webkit-gradient(')"/>
		<!-- -->
		<!-- 
		 ! Common SVG properties
		 !-->
		<!-- The first two define BOTH property and value -->
		<xsl:variable name="svg.fill">
			<xsl:choose>
				<xsl:when test="$css.self.background-image.webkit-gradient!=''">
					<xsl:value-of select="concat('fill: url(#',$css.id,');')"/>
				</xsl:when>
				<xsl:when test="$css.self.background-color=''">
					<xsl:value-of select="'fill: none;'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat('fill: rgb(',$css.self.background-color.rgb,');')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="svg.fill-opacity">
			<xsl:choose>
				<xsl:when test="$css.self.background-image.webkit-gradient!=''">
					<xsl:value-of select="''"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat('fill-opacity: ',$css.self.background-color.a,';')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- from here it is ONLY the value -->
		<xsl:variable name="svg.stroke">
			<xsl:choose>
				<xsl:when test="$css.self.border-top-color=''">
					<xsl:value-of select="'none'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat('rgb(',$css.self.border-top-color.rgb,')')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="svg.stroke-opacity" select="$css.self.border-top-color.a"/>
		<xsl:variable name="svg.stroke-width" select="$css.self.border-top-width"/>
		<xsl:variable name="rx">
			<xsl:choose>
				<xsl:when test="$type='Oval'">
					<xsl:value-of select="$width div 2"/>
				</xsl:when>
				<xsl:when test="number($css.self.border-top-left-radius.rx.n)">
					<xsl:value-of select="$css.self.border-top-left-radius.rx.n"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="ry">
			<xsl:choose>
				<xsl:when test="$type='Oval'">
					<xsl:value-of select="$height div 2"/>
				</xsl:when>
				<xsl:when test="number($css.self.border-top-left-radius.ry.n)">
					<xsl:value-of select="$css.self.border-top-left-radius.ry.n"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- -->
		<xsl:variable name="style.common" select="concat($svg.fill,$svg.fill-opacity,'stroke:',$svg.stroke,';','stroke-opacity:',$svg.stroke-opacity,';','stroke-width:',$svg.stroke-width,';')"/>
		<!-- -->
		<xsl:comment>
			<xsl:value-of select="'&#13;&#13;'"/>
			<xsl:value-of select="concat(' ',$type,' OBJECT ')"/>
			<xsl:value-of select="'&#13;&#13;'"/>
		</xsl:comment>
		<!-- -->
		<xsl:if test="$debug=1">
			<xsl:comment>
				<xsl:value-of select="concat('x,y: ',$left,' ',$top,'&#13;')"/>
				<xsl:value-of select="concat('css: ',$css,'&#13;')"/>
				<xsl:value-of select="concat('css.self: ',$css.self,'&#13;')"/>
				<xsl:value-of select="concat('css.self.background-color: ',$css.self.background-color,'&#13;')"/>
				<xsl:value-of select="concat('css.self.background-color.rgba: ',$css.self.background-color.rgba,'&#13;')"/>
				<xsl:value-of select="concat('css.self.background-color.a: ',$css.self.background-color.a,'&#13;')"/>
				<xsl:value-of select="concat('css.self.background-color.rgb: ',$css.self.background-color.rgb,'&#13;')"/>
				<xsl:value-of select="concat('css.self.border-top-color: ',$css.self.border-top-color,'&#13;')"/>
				<xsl:value-of select="concat('css.self.border-top-color.rgba: ',$css.self.border-top-color.rgba,'&#13;')"/>
				<xsl:value-of select="concat('css.self.border-top-color.a: ',$css.self.border-top-color.a,'&#13;')"/>
				<xsl:value-of select="concat('css.self.border-top-color.rgb: ',$css.self.border-top-color.rgb,'&#13;')"/>
				<xsl:value-of select="concat('css.self.border-top-width: ',$css.self.border-top-width,'&#13;')"/>
				<xsl:value-of select="concat('css.self.border-top-left-radius: ',$css.self.border-top-left-radius,'&#13;')"/>
			</xsl:comment>
		</xsl:if>
		<!--
		 ! Object
		 !-->
		<xsl:choose>
			<!--
			 ! fm Line -> svg line
			 !-->
			<xsl:when test="$type='Line'">
				<xsl:variable name="style.forType" select="'stroke-linecap:square;'"/>
				<!-- -->
				<xsl:variable name="style" select="concat($style.common,$style.forType)"/>
				<xsl:variable name="styleRtoL" select="concat('stroke:red;',$style)"/>
				<xsl:variable name="styleLtoR" select="concat('stroke:green;',$style)"/>
				<!-- -->
				<xsl:choose>
					<xsl:when test="($rightToLeft=1 and $bottomToTop=0) or ($rightToLeft=0 and $bottomToTop=1)">
						<line x1="{$right}" y1="{$top}" x2="{$left}" y2="{$bottom}" style="{$styleRtoL}"/>
					</xsl:when>
					<xsl:otherwise>
						<line x1="{$left}" y1="{$top}" x2="{$right}" y2="{$bottom}" style="{$styleLtoR}"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!--
			 ! fm Oval -> svg ellipse
			 !-->
			<xsl:when test="$type='Oval'">
				<xsl:variable name="cx" select="$left + $rx"/>
				<xsl:variable name="cy" select="$top + $ry"/>
				<!-- -->
				<xsl:variable name="style.forType" select="''"/>
				<xsl:variable name="style" select="concat($style.common,$style.forType)"/>
				<!-- -->
				<ellipse cx="{$cx}" cy="{$cy}" rx="{$rx}" ry="{$ry}" style="{$style}"/>
			</xsl:when>
			<xsl:when test="$type='Oval'">
				<xsl:variable name="cx" select="$left + $rx"/>
				<xsl:variable name="cy" select="$top + $ry"/>
				<!-- -->
				<xsl:variable name="style.forType" select="''"/>
				<xsl:variable name="style" select="concat($style.common,$style.forType)"/>
				<!-- -->
				<ellipse cx="{$cx}" cy="{$cy}" rx="{$rx}" ry="{$ry}" style="{$style}"/>
			</xsl:when>
			<!--
			 ! Graphic
			 !-->
			<!--xsl:when test="$type='Graphic'">
				<xsl:variable name="style.common" select="concat('fill:',$svg.fill,';','fill-opacity:',$svg.fill-opacity,';','stroke:',$svg.stroke,';','stroke-opacity:',$svg.stroke-opacity,';','stroke-width:',$svg.stroke-width,';')"/>
			</xsl:when-->
			<xsl:otherwise>
				<!--
				 ! All other objects are (more or less) rectangular:
				 ! fm Rect, etc. -> svg rect
				 !-->
				<xsl:variable name="style.forType" select="''"/>
				<xsl:variable name="style" select="concat($style.common,$style.forType)"/>
				<!-- -->
				<rect x="{$left}" y="{$top}" height="{$height}" width="{$width}" rx="{$rx}" ry="{$ry}" style="{$style}"/>
				<!--
				 ! Now distinguish between different rectangular objects
				 !-->
				<xsl:comment>
					<xsl:value-of select="$type"/>
				</xsl:comment>
				<xsl:variable name="portalFlags" select="parent::Object/PortalObj/@portalFlags"/>
				<xsl:variable name="portalHasScrollBar" select="substring($portalFlags mod (2*1) div 1,1,1)='1'"/>
				<xsl:variable name="portalIsSorted" select="substring($portalFlags mod (2*8) div 8,1,1)='1'"/>
				<xsl:variable name="portalIsFiltered" select="substring($portalFlags mod (2*128) div 128,1,1)='1'"/>
				<xsl:comment>
					<xsl:value-of select="$portalFlags"/>
					<xsl:value-of select="','"/>
					<xsl:value-of select="$portalHasScrollBar"/>
				</xsl:comment>
				<xsl:if test="$type='Portal' and $portalHasScrollBar">
					<!-- Portal Scrollbar -->
					<xsl:variable name="portalScrollBarWidth" select="13"/>
					<xsl:variable name="portalScrollBarHeight" select="13"/>
					<!-- -->
					<xsl:comment>
						<xsl:value-of select="'PORTAL SCROLLBAR'"/>
					</xsl:comment>
					<g>
						<rect x="{$right - $portalScrollBarWidth}" y="{$top}" height="{$portalScrollBarHeight}" width="{$portalScrollBarWidth}" style="{$style}"/>
						<rect x="{$right - $portalScrollBarWidth}" y="{$bottom - $portalScrollBarHeight}" height="{$portalScrollBarHeight}" width="{$portalScrollBarWidth}" style="{$style}"/>
						<rect x="{$right - $portalScrollBarWidth}" y="{$top + $portalScrollBarHeight}" height="{$height - 2 * $portalScrollBarHeight}" width="{$portalScrollBarWidth}" style="{$style}"/>
					</g>
				</xsl:if>
				<!--
					 ! Add text to Text Objects and Buttons
					 !-->
				<xsl:if test="$type='Text' or $type='Button' or $type='PopoverButton' or $type='Field' or $type='Portal'or $type='TabPanel'">
					<!-- Text object -->
					<xsl:variable name="Text">
						<xsl:choose>
							<xsl:when test="$type='Portal'">
								<xsl:value-of select="concat(parent::Object/PortalObj/TableAliasKey,'[',parent::Object/PortalObj/@initialRow,'..',parent::Object/PortalObj/@numOfRows)"/>
								<xsl:if test="$portalHasScrollBar">
									<xsl:value-of select="'+'"/>
								</xsl:if>
								<xsl:if test="$portalIsSorted">
									<xsl:value-of select="',Sort'"/>
								</xsl:if>
								<xsl:if test="$portalIsFiltered">
									<xsl:value-of select="',Filter'"/>
								</xsl:if>
								<xsl:value-of select="']'"/>
							</xsl:when>
							<xsl:when test="$type='Field'">
								<!-- show the field name in the field -->
								<xsl:choose>
									<xsl:when test="parent::Object/FieldObj/DDRInfo/Field/@table=''">
										<xsl:value-of select="'&lt;Table Missing&gt;'"/>
									</xsl:when>
									<xsl:when test="parent::Object/FieldObj/DDRInfo/Field/@name=''">
										<xsl:value-of select="'&lt;Field Missing&gt;'"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:if test="substring(parent::Object/FieldObj/DDRInfo/Field/@table,1,1) = '_'">
											<xsl:value-of select="'::'"/>
										</xsl:if>
										<xsl:value-of select="parent::Object/FieldObj/DDRInfo/Field/@name"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="parent::Object/TextObj/ParagraphStyleVector/Style/Data"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="repetition">
						<xsl:choose>
							<xsl:when test="$type='Field'">
								<xsl:value-of select="number(parent::Object/FieldObj/DDRInfo/Field/@repetition)"/>
							</xsl:when>
							<xsl:when test="$type='Portal'">
								<xsl:value-of select="number(parent::Object/PortalObj/@initialRow)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="1"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<!--
						 ! Get the number of field repetitions or portal rows
						 ! NOTE: numOfReps is NEGATIVE for horizontal portals
						 !-->
					<xsl:variable name="numOfReps" select="number(parent::Object/FieldObj/@numOfReps)"/>
					<xsl:variable name="numOfRows" select="number(parent::Object/PortalObj/@numOfRows)"/>
					<xsl:variable name="repetitionDirection">
						<xsl:choose>
							<xsl:when test="$type='Portal' and  $numOfRows &gt; 1 or $type='Field' and $numOfReps &gt; 1">
								<xsl:value-of select="'vertical'"/>
							</xsl:when>
							<xsl:when test="$type='Field' and $numOfReps &lt; 1">
								<xsl:value-of select="'horizontal'"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="'none'"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="repetitionCount">
						<xsl:choose>
							<xsl:when test="$type='Field' and $repetitionDirection='horizontal'">
								<xsl:value-of select="- $numOfReps"/>
							</xsl:when>
							<xsl:when test="$type='Field' and $repetitionDirection='vertical'">
								<xsl:value-of select="$numOfReps"/>
							</xsl:when>
							<xsl:when test="$type='Portal'">
								<xsl:value-of select="$numOfRows"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="1"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<!-- -->
					<xsl:variable name="repetition.xOffset">
						<xsl:choose>
							<xsl:when test="$repetitionDirection='horizontal'">
								<xsl:value-of select="$width div $repetitionCount"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="0"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="repetition.yOffset">
						<xsl:choose>
							<xsl:when test="$repetitionDirection='vertical'">
								<xsl:value-of select="$height div $repetitionCount"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="0"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<!-- Font metrics -->
					<xsl:variable name="text.font-size">
						<xsl:choose>
							<xsl:when test="$type='Portal'">
								<xsl:value-of select="12"/>
							</xsl:when>
							<xsl:when test="$type='Field'">
								<xsl:value-of select="parent::Object/FieldObj/ExtendedAttributes/CharacterStyle/Font-size"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="parent::Object/TextObj/ExtendedAttributes/CharacterStyle/Font-size"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="text.font-family">
						<xsl:choose>
							<xsl:when test="$type='Portal'">
								<xsl:value-of select="'Helvetica'"/>
							</xsl:when>
							<xsl:when test="$type='Field'">
								<xsl:value-of select="parent::Object/FieldObj/ExtendedAttributes/CharacterStyle/Font-size"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="parent::Object/TextObj/ExtendedAttributes/CharacterStyle/Font-family"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<!-- -->
					<xsl:variable name="text.line-height-single">
						<xsl:call-template name="lookup.line-height.from.font-size">
							<xsl:with-param name="font-size" select="$text.font-size"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="css.self.line-height" select="normalize-space(substring-before(substring-after($css.self, 'line-height: '),';'))"/>
					<xsl:variable name="css.self.line-height.unit" select="translate($css.self.line-height,'1234567890. ','')"/>
					<xsl:variable name="css.self.line-height.n" select="normalize-space(translate($css.self.line-height,$css.self.line-height.unit,''))"/>
					<!-- Text position -->
					<xsl:variable name="css.self.text-align" select="normalize-space(substring-before(substring-after($css.self, 'text-align: '),';'))"/>
					<xsl:variable name="css.self.-fm-text-vertical-align" select="normalize-space(substring-before(substring-after($css.self, '-fm-text-vertical-align: '),';'))"/>
					<xsl:variable name="text.line-height">
						<xsl:choose>
							<xsl:when test="$css.self.line-height.unit='line'">
								<xsl:value-of select="$text.line-height-single * $css.self.line-height.n"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$css.self.line-height"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="css.self.color" select="normalize-space(substring-before(substring-after($css.self, concat('&#9;','color: ')),';'))"/>
					<xsl:variable name="css.self.color.rgba" select="substring-before(substring-after($css.self.color, '('),')')"/>
					<xsl:variable name="css.self.color.a" select="str:tokenize($css.self.color.rgba, ',')[4]"/>
					<xsl:variable name="css.self.color.rgb" select="substring($css.self.color.rgba,1,string-length( $css.self.color.rgba) - string-length( $css.self.color.a) - 1)"/>
					<!-- -->
					<xsl:variable name="svg.text-anchor">
						<xsl:choose>
							<xsl:when test="$css.self.text-align='left'">
								<xsl:value-of select="'start'"/>
							</xsl:when>
							<xsl:when test="$css.self.text-align='center'">
								<xsl:value-of select="'middle'"/>
							</xsl:when>
							<xsl:when test="$css.self.text-align='right'">
								<xsl:value-of select="'end'"/>
							</xsl:when>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="svg.x">
						<xsl:choose>
							<xsl:when test="$type='Portal'">
								<xsl:value-of select="$left"/>
							</xsl:when>
							<xsl:when test="$css.self.text-align='left'">
								<xsl:value-of select="$left"/>
							</xsl:when>
							<xsl:when test="$css.self.text-align='center'">
								<xsl:value-of select="$center"/>
							</xsl:when>
							<xsl:when test="$css.self.text-align='right'">
								<xsl:value-of select="$right"/>
							</xsl:when>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="svg.y">
						<xsl:choose>
							<xsl:when test="$type='Portal' or $type='TabPanel'">
								<xsl:value-of select="$top"/>
							</xsl:when>
							<xsl:when test="$css.self.-fm-text-vertical-align='top'">
								<xsl:value-of select="$top"/>
							</xsl:when>
							<xsl:when test="$css.self.-fm-text-vertical-align='center'">
								<xsl:value-of select="$middle"/>
							</xsl:when>
							<xsl:when test="$css.self.-fm-text-vertical-align='bottom'">
								<xsl:value-of select="$bottom"/>
							</xsl:when>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="svg.dy">
						<xsl:choose>
							<xsl:when test="$type='Portal'">
								<xsl:value-of select="$height div $repetitionCount"/>
							</xsl:when>
							<xsl:when test="$css.self.-fm-text-vertical-align='top'">
								<xsl:value-of select="$text.line-height"/>
							</xsl:when>
							<xsl:when test="$css.self.-fm-text-vertical-align='center'">
								<xsl:value-of select="$text.line-height div 2"/>
							</xsl:when>
							<xsl:when test="$css.self.-fm-text-vertical-align='bottom'">
								<xsl:value-of select="0"/>
							</xsl:when>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="text.style" select="concat('text-anchor: ',$svg.text-anchor,'; fill:rgb(0,0,0);color:rgb(',$css.self.color.rgb,');font-size:',$text.font-size,';font-family:',$text.font-family,';')"/>
					<!-- -->
					<xsl:comment>
						<xsl:value-of select="'&#13;'"/>
						<xsl:value-of select="concat('css.self.text-align: ',$css.self.text-align,'&#13;')"/>
						<xsl:value-of select="concat('css.self.-fm-text-vertical-align: ',$css.self.-fm-text-vertical-align,'&#13;')"/>
					</xsl:comment>
					<!--
						 ! 
						 ! Loop for repeating fields and portals
						 ! 
					 	 !-->
					<xsl:comment>
						<xsl:value-of select="concat($repetitionCount,' ',$repetitionDirection,' repetitions, starting at ',$repetition)"/>
						<xsl:value-of select="concat(', x=',$svg.x)"/>
						<xsl:value-of select="concat(', y=',$svg.y)"/>
						<xsl:if test="$repetition.xOffset&gt;0">
							<xsl:value-of select="concat(', dx=',$repetition.xOffset)"/>
						</xsl:if>
						<xsl:if test="$repetition.yOffset&gt;0">
							<xsl:value-of select="concat(', dy=',$repetition.yOffset)"/>
						</xsl:if>
					</xsl:comment>
					<!-- THIS is a FOR n = 1 to N loop construction in XSLT  -->
					<xsl:for-each select="(//*)[position() &lt;= $repetitionCount]">
						<xsl:variable name="repetitionNumber" select="$repetition + position() - 1"/>
						<xsl:variable name="loopIndex" select="position() - 1"/>
						<!-- -->
						<xsl:variable name="Text.calculated">
							<xsl:choose>
								<xsl:when test="$type='Portal'">
									<xsl:choose>
										<xsl:when test="position() = $repetitionCount and $repetitionCount!=1">
											<xsl:value-of select="$Text"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="''"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:when test="$type!='Field'">
									<xsl:value-of select="$Text"/>
								</xsl:when>
								<!-- Field -->
								<xsl:when test="$repetitionCount=1 and $repetitionNumber=1">
									<xsl:value-of select="$Text"/>
								</xsl:when>
								<xsl:when test="$loopIndex=0">
									<xsl:value-of select="concat($Text,'[',$repetitionNumber,']')"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$repetitionNumber"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="svg.x.calculated" select="$svg.x + $repetition.xOffset * $loopIndex"/>
						<xsl:variable name="svg.y.calculated" select="$svg.y + $repetition.yOffset * $loopIndex"/>
						<!-- -->
						<!--
						 ! NOTE: Render Text WITHIN an svg element, which acts as a clip frame for the text
						 !-->
						<xsl:if test="$Text.calculated!=''">
							<g>
								<xsl:comment>
									<xsl:value-of select="concat('index:',$loopIndex,', pos:',position(),', rep:',$repetitionNumber,', x.calc:',$svg.x.calculated,', y.calc:',$svg.y.calculated)"/>
								</xsl:comment>
								<!--svg xmlns="http://www.w3.org/2000/svg" version="1.1" x="0" y="0" width="{$width}" height="{$height}" style="'stroke:rgb(0,0,0);stroke-width:1;fill:yellow;stroke-dasharray: 10 5;'"-->
								<text x="{$svg.x.calculated}" y="{$svg.y.calculated}" dy="{$svg.dy - 2}" style="{$text.style}">
									<xsl:value-of select="$Text.calculated"/>
								</text>
								<!--/svg-->
							</g>
						</xsl:if>
					</xsl:for-each>
					<!--
						 ! 
						 ! 
						 ! 
						 ! 
						 ! 
						 ! 
						 ! 
						 ! 
						 ! 
						 ! 
						 ! 
						 ! 
						 !-->
				</xsl:if>
				<!--
					 ! Render Containers as embedded svg objects (so that the coordinates are relative)
					 !-->
				<xsl:if test="$type='TabControl' or $type='SlideControl' or $type='Portal' or $type='Popover' or $type='GroupButton' or $type='ButtonBar'">
					<!-- Containers -->
					<xsl:variable name="containerStyle">
						<xsl:value-of select="'stroke:rgb(0,0,0);stroke-width:1;fill:none;stroke-dasharray: 10 5;'"/>
					</xsl:variable>
					<!-- -->
					<svg x="{$left}" y="{$top}" width="{$width}" height="{$height}" style="{$containerStyle}">
						<!--
							 ! Within the new SVG-coordinate space recurse through containers contents
							 !-->
						<xsl:choose>
							<xsl:when test="$type='ButtonBar'">
								<xsl:apply-templates select="parent::*/ButtonBarObj"/>
							</xsl:when>
							<xsl:when test="$type='TabControl' or $type='SlideControl'">
								<xsl:variable name="visPanelKey">
									<xsl:choose>
										<xsl:when test="$type='TabControl'">
											<xsl:value-of select="parent::Object/TabControlObj/@visPanelKey"/>
										</xsl:when>
										<xsl:when test="$type='SlideControl'">
											<xsl:value-of select="parent::Object/SlideControlObj/@visPanelKey"/>
										</xsl:when>
									</xsl:choose>
								</xsl:variable>
								<xsl:apply-templates select="following-sibling::*/Object[@key=$visPanelKey]"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="following-sibling::*"/>
							</xsl:otherwise>
						</xsl:choose>
					</svg>
					<!--
						 ! "Accessories" in front of the container
						 !-->
					<xsl:if test="$type='Popover'">
						<!-- Place popover close button ON TOP OF content-->
						<ellipse cx="{$left + 2}" cy="{$top + 2}" rx="9" ry="9" style="fill:rgb(64,64,64);stroke:rgb(222,222,222);"/>
						<text x="{$left + 2}" y="{$top + 6}" style="text-anchor: middle; fill:rgb(180,180,180);font-size:15;font-weight:bold;font-family:sans-serif;">x</text>
						<!-- Popover arrow-->
						<xsl:variable name="PopoverButton.left" select="ancestor::Object[@type='PopoverButton']/Bounds/@left"/>
						<xsl:variable name="PopoverButton.right" select="ancestor::Object[@type='PopoverButton']/Bounds/@right"/>
						<xsl:variable name="PopoverButton.bottom" select="ancestor::Object[@type='PopoverButton']/Bounds/@bottom"/>
						<xsl:variable name="PopoverButton.top" select="ancestor::Object[@type='PopoverButton']/Bounds/@top"/>
						<xsl:variable name="PopoverButton.center" select="($PopoverButton.right + $PopoverButton.left) div 2"/>
						<xsl:variable name="PopoverButton.middle" select="($PopoverButton.bottom + $PopoverButton.top) div 2"/>
						<xsl:variable name="Popover-position" select="parent::Object/PopoverObj/@position"/>
						<xsl:variable name="PopoverButton.points">
							<xsl:choose>
								<xsl:when test="$Popover-position=3">
									<!-- upwards arrow -->
									<xsl:value-of select="concat($PopoverButton.center - 11, ',', $PopoverButton.top - 11, ',',$PopoverButton.center, ',', $PopoverButton.top, ',',$PopoverButton.center + 11, ',', $PopoverButton.top - 11 )"/>
								</xsl:when>
								<xsl:when test="$Popover-position=0">
									<!-- rightwards arrow -->
									<xsl:value-of select="concat($PopoverButton.right + 11, ',', $PopoverButton.middle - 11, ',',$PopoverButton.right, ',', $PopoverButton.middle, ',',$PopoverButton.right + 11 , ',', $PopoverButton.middle + 11)"/>
								</xsl:when>
								<xsl:when test="$Popover-position=1">
									<!-- upwards arrow -->
									<xsl:value-of select="concat($PopoverButton.center - 11, ',', $PopoverButton.bottom + 11, ',',$PopoverButton.center, ',', $PopoverButton.bottom, ',',$PopoverButton.center + 11, ',', $PopoverButton.bottom + 11 )"/>
								</xsl:when>
								<xsl:when test="$Popover-position=2">
									<!-- rightwards arrow -->
									<xsl:value-of select="concat($PopoverButton.left - 11, ',', $PopoverButton.middle - 11, ',',$PopoverButton.left, ',', $PopoverButton.middle, ',',$PopoverButton.left - 11, ',', $PopoverButton.middle + 11)"/>
								</xsl:when>
							</xsl:choose>
						</xsl:variable>
						<!-- -->
						<polygon points="{$PopoverButton.points}" style="{$style}"/>
					</xsl:if>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="$type!='Popover' or not(ancestor::Object[@type='PopoverButton'])">
			<g>
				<xsl:comment>
					<xsl:value-of select="'Selection highlight'"/>
				</xsl:comment>
				<xsl:choose>
					<xsl:when test="$type='Field'and (parent::Object/FieldObj/DDRInfo/Field/@table='' or parent::Object/FieldObj/DDRInfo/Field/@name='')">
						<!--
						 ! Object ERROR
						 !-->
						<rect x="{$left - 2}" y="{$top - 2}" height="{$height + 4}" width="{$width + 4}" rx="{$rx + 2}" ry="{$ry + 2}" style="stroke-opacity:50%;stroke:rgb(202,17,17);stroke-width:5;stroke-dasharray:3 5;fill:none;"/>
					</xsl:when>
					<xsl:otherwise>
						<!--
						 ! Object Bounds selected
						 !-->
						<rect x="{$left - 1}" y="{$top - 1}" height="{$height + 2}" width="{$width + 2}" rx="{$rx + 1}" ry="{$ry + 1}" style="stroke-opacity:75%;stroke:rgb(169,205,248);stroke-width:1;fill:none;"/>
						<rect x="{$left - 2}" y="{$top - 2}" height="{$height + 4}" width="{$width + 4}" rx="{$rx + 2}" ry="{$ry + 2}" style="stroke-opacity:50%;stroke:rgb(169,205,248);stroke-width:1;fill:none;"/>
						<!--rect x="{$left - 3}" y="{$top - 3}" height="{$height + 6}" width="{$width + 6}" rx="{$rx + 3}" ry="{$ry + 3}" style="stroke-opacity:25%;stroke:rgb(169,205,248);stroke-width:1;fill:none;"/-->
					</xsl:otherwise>
				</xsl:choose>
			</g>
		</xsl:if>
	</xsl:template>
	<!-- ignore all other text -->
	<xsl:template match="text()"/>
</xsl:stylesheet>
