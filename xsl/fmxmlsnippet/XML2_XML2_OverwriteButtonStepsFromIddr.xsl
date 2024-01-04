<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XML2_XML2_OverwriteButtonStepsFromIddr.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied fmp12 layout objects
	
	Overwrites any button steps in the layout objects with the successive steps
	stored in the iDDR* script steps file xml/iDDR/XMSS_fmxmlsnippet.xml .
	
	Comments cause a button to be skipped (left as is).
	
	(Parameter $removeRest

	You need to turn on the Auto-save-iDDR-Files option in the Extended Settings 
	on the File tab. For Extended Settings press (i) + (i) buttons or CMD+9 + CMD+9. 
	
	* The iDDR is an "instant-DDR", or in other words when you convert FileMaker objects 
	with fmCheckMate the XML is saved in a file "XM??_fmxmlsnippet.xml" in the
	fmCheckMate/xml/iDDR folder  (where the ?? depends on the type of object you have
	converted)

	How to use this transformation to copy a single button step
	
	1. Make sure the Auto-save-iDDR-Files option in the fmCheckMate Extended Settings is on.
	
	2. Get the button step you want to move
	
	   2.1 In FileMaker: Copy the SOURCE button
	   2.2 With fmCheckMate: Convert to XML…
	   2.3 Press [T] and choose the transformation "Extract Button Steps"
	       Note: This extracts the Step XML, but - in the (currently) current version of
	       fmCheckMate - does NOT write the iDDR File, so you have to do a little
	       workaround:
	   2.4 Force the iDDR file to be saved by converting the XML to FM obects (CMD+2)
	
	3. Apply the button step to the target button
	
	   3.1 Create the TARGET button in the style you want 
	   3.2 If it doesn't already have a button step, give the TARGET button *ANY* step 
	   3.3 Copy the Target button
	   3.4 Convert to XML with fmCheckMate
	   3.5 Press [T] and choose the "Overwrite Button Steps from IDDR" transformation
	       This overwrites the button's step with the correct step.
	   3.6 Convert back to FileMaker objects
	   3.7 In FileMaker: Paste the TARGET button back in.


	How to use this transformation to copy multiple button steps to a button bar
	
	1. Make sure the Auto-save-iDDR-Files option in the fmCheckMate Extended Settings is on.
	
	2. Get the button steps you want to transfer (in the right order!)
	
	   2.1 In FileMaker: Copy the SOURCE buttons
	       (You may want to make sure the SOURCE buttons have the desired z-order first)
	   2.2 With fmCheckMate: Convert to XML…
	   2.3 Press [T] and choose the transformation "Extract Button Steps"
	       Note: This extracts the Step XML, but - in the (currently) current version of
	       fmCheckMate - does NOT write the iDDR File, so you have to do a little
	       workaround:
	   2.4 Force the iDDR file to be saved by converting the XML to FM obects (CMD+2)
	
	3. Apply the button steps to the target buttons
	
	   3.1 Create the TARGET buttons / button bar in the style you want 
	   3.2 If it doesn't already have a button step, give the TARGET button *ANY* step 
	   3.3 Copy the Target button
	   3.4 Convert to XML with fmCheckMate
	   3.5 Press [T] and choose the "Overwrite Button Steps from IDDR" transformation
	       This overwrites the button's step with the correct step.
	   3.6 Convert back to FileMaker objects
	   3.7 In FileMaker: Paste the TARGET button back in.




	===== CHANGES HISTORY =====
	2018-10-26 MrW Version 1.1 Extended the logic to skip comments
	2018-10-25 MrW Version 1.0
	
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<!-- ===== PARAMETER ===== -->
	<xsl:param name="removeRest" select="false()"/>
	<!-- ===== VARIABLES ===== -->
	<xsl:variable name="iDDRStepsFile" select="document('../../../fmCheckMate/xml/iDDR/XMSS_fmxmlsnippet.xml')"/>

	<!-- ===== KEY ===== -->
<!--	<xsl:key name="iDDRStepN" match="//Step" use=""/>-->
	
	<!-- ===== TEMPLATES ===== -->
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>

	<!-- Replace the nth Step in the layout objects with the nth step in the iDDR-->
	<xsl:template match="Step" priority="1">
		<xsl:variable name="pos" select="1+count(preceding::Step)"/>
		<xsl:variable name="stepN" select="$iDDRStepsFile//Step[$pos]"/>
		<xsl:choose>
			<xsl:when test="$stepN/@id=89">
				<!-- Comment: leave as is-->
				<xsl:copy-of select="."/>
			</xsl:when>
			<xsl:when test="$stepN">
				<!-- Replace with the nth step, if it exists-->
				<xsl:copy-of select="$stepN"/>
			</xsl:when>
			<xsl:when test="$removeRest">
				<!-- Remove step -->
			</xsl:when>
			<xsl:otherwise>
				<!-- leave button as is -->
				<xsl:copy-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
</xsl:stylesheet>
