fmCheckMate-XSLT revision history
=================================


Note: This history list is currently manually - and only intermittantly - updated.
It is thus horrendously out of date!
Please check the history entries in the individual files for more details.

---

20230227 mrwatson-de: Upgraded script printing for FM19.6.2, and added a few usful functions
20221021 MrW: Two more years slip by :D - Time to make our first release, which I think we will just name after the date.
20201113 MrW: Two years on, ... Time to get fmWorkMate + fmCheckMate XSLT-Library + FieldDependencyGraph stuff out!
20191004 MrW: One year older, a bunch of transformations wiser.
20180828 MrW: Hello GitHub! ... We're going to have to wait and see if we are going to get along ;-)
20180827 MrW: Added transformation XMSS_XMSS_ReplaceSetVarWithInsertCalculatedResult.xsl to change 
              Set Variable steps into the faster Insert Calculated Result step (which runs in linear
              time instead of quadratic)
20180801 MrW: Corrected various errors thanks to oXygen XML Editor

---

20180711 MrW: Tidied up the formatting of this file, will update contents later.
20180513 MrW: Added transformation XMSS_XMSS_ConvertCustomDialogInputsToVars.xsl to help convert per fm17
              Custom Dialogs to variable-based rather than field based input.
20180511 MrW: Added transformation XMFD_XMFD_RemoveFieldsWithSerialnumbers.xsl to remove fields
              with serial numbers from the list of copied fields

20180511 MrW: Added transformation XMFD_Text.Lines_ListPrimaryFields.xsl to list just the primary key fields
              from the list of copied fields, that is fields with Serial Numbers or Get( UUID[Number] )
              calculations, or fields marked internally as primary fields.
20180511 MrW: Added transformation XMFD_XMFD_SelectPrimaryFields.xsl to select only the primary key fields
              from the list of copied fields, that is fields with Serial Numbers or Get( UUID[Number] )
              calculations, or fields marked internally as primary fields.

---

20180501 MrW: At last got a good XML Editor - oXygen...Let's see where it takes us! :)  

---

20160222 MrW: Added a whole bunch of stuff

- Improved Layout Analysis
  - Added a layout analysis to report quoted object names.
  - Added a layout analysis to report objects which have classic style.
  - Corrected reference of Style info for ButtonBars.
  - Extended the iDDR functionality so style names can be more easily looked up.
    - Added XSLT to import the iDDR theme file into fmCheckMate, 
- Prefixed the XSLTs to output scripts with the word Print, to make them easier to understand and find.
- Added XSLT to select/remove repeating fields from a field list

---

20160115 MrW: fmCheckMate-XSLT and fmCheckMate improved

- Added support for processing DDR files!
  - It turns out that the DDR-XML grammar is similar enough to the fmxmlsnippet grammer, that the existing Layout Analysis XSLTs also work (with a little tweaking) on the DDR
- Improved Layout Analysis
  - Added the layout name into the fmCM AnalysisResults:
  - Improved the object path to not shown double entries any more
  - "Report Objects Lost In Containers" now reports objects hidden by portal scroll bars
  - "ReportCopiedObjectNames" now warn of object name clashes caused by pasting (object names with a number at the end) as well as by duplicating
  - "BrokenBrokenValueLists" now warns of missing value lists as well as deleted value lists
- Added Layout Analysis XSLTs to only check BrokenValueLists or only duplicate ObjectNames, so that these can be applied retrospectively to the DDR
- Added an XSLT to show the current fmCheckMate XSLT-Library Version
- Cleared up some old broken Applescripts

    :

---

20141010 MrW Another XSLT to convert all in-line calculation comments into block comments - great when transfering stuff to Windows :)

---

20141009 MrW Added 4 XSLTs for merging script comments into and out of if statements.

---

20140901 MrW Added XMSC_XMSC_RemoveScriptSteps.xsl (to help transfer scripts to old versions of the DB)

---

20140826 MrW Added 4 XSLTs for extracting field names (and merge field names) from copied layout objects

---

20140715 MrW Two XSLTs for analysing script call frequency

---

20140714 MrW List the table names

---

20140714 MrW (at last!) List all variables defined (BUT NOT variables defined with Let)

---

20140527 MrW Integrated FileMaker Themes (using the (presumed, but missing!) 4 letter Mac clipboard class name XMTH), and created XMTH_Text.Lines_ThemeNames.xsl and XMTH_Text.Lines_ThemeDetails.xsl

---

20131219 MrW Tidied up some more

---

20131212 MrW Having introduced support for multiple XSLT-folders in fmCheckMate, I can start splitting fmCheckMate.mrwatson.de stuff from fmCheckMate stuff - at last :-)

---

20131120 MrW Tidied up a bit and added XSLT XMSS_Text.Lines_VarsDefined.xsl and renamed XMLO_Text.Lines_Objects.xsl for fmp12 (need to think how to organize XSLTs that can be used for BOTH fm11 AND fm12)

---

20131115 MrW Fixed XMSS_Text_ConvertSetFieldsToPredicateEqual.xsl and added XSLTs XMSS_XMSS_SetFieldIfNotAlreadyEqual.xsl  (& their 'Exact' partners)

---

20131112 MrW Sorted out many of the xsl file names.

---

20131108 MrW fmPseudoCodeToFmxmlsnippetScriptSteps awk script added - but I need to learn perl!

---

20130909 MrW CHANGE HISTORY added, HEAD tidied up: xsl:output first

---

20130907 MrW Improving inc.XMSS_Text.List.xsl: Accounts, Spelling, Files and Export Records, Save Records as Excel, Save Records as PDF, Save Records as Snapshot Link
	Extracted inc.Clone.xsl ... still to be used!
	XMSS_XMSS_SelectStepsContainingFIXME und XMSS_XMSS_SelectStepsContaining$ hard coded.
	Renamed all of the .txt documents to .mdown to reflect their markdown content

---

20130905 MrW :-) inc.XMSS_Text.List...Refactored out of XMSS_Text.Lines_Indented.xsl, so it can be developed centrally.

---

20130831 MrW Extracting Script steps from Layouts

---

20130830 MrW Started developing FM11/FM12-ID-aware XSLs, fixed UndeleteFields issues

---

20130507 MrW fmxmlsnippet-XSLT files renamed <InputType>_<OutputType>_<Function>.xslt to make usage clearer.

---

20130506 MrW More field-sorting XSLTs

---

20130503 MrW standardised the xsl:output and added cdata-section-elements attribute.
    :    MrW wrote lots of good XSLTs!

---

20121019 MrW simplified names of all XSLTs and fmCheckMate TextMate commands to use the 4 letter Mac clipboard class name:
	fmxmlCFs	-> XMFN
	fmxmlTables	-> XMTB
	fmxmlFields	-> XMFD
	fmxmlLayout	-> XMLO
	fmxmlScripts	-> XMSC
	fmxmlScriptsteps	-> XMSS

---

20121019 MrW restructured bundle command-menus:

---

20121016 MrW renamed modules and products:
	FMCheckMate	-> fmCheckMate
	FM-DevBox	-> fmWorkMate
	FMModule	-> fmModule
	FMLogAnalyser	-> fmLogAnalyser

---

20121013 MrW tidied up the functions (work in progress)

---

20121019 MrW FMPReportSummary_ListNameTable1 - Attempt to reference multiple XML files (work in progress)

---

20121001 MrW xsl_CreateStandaloneStylesheet.xsl (in order to create fn.parseXML_STANDALONE.xsl)

---

20120928 MrW created Developing and Documenting fmCheckMate XSLT - How to log change history in XML

---

20110209 MrW replaced xsl:import with xsl:include so that making stand-alone stylesheets is possible

---

20110207 MrW A lot of field-processing XSLTs, started conversions between fm11 and fm12

---

20110123 MrW A whole bunch of basic XSLTs for processing tables, fields, scripts, (fm11) layout objects

---

20110114 MrW The raw beginnings! Two first XSLTs, one to "internationalise" your xml as best as we can (removes step names), the other to reference fields by ID.