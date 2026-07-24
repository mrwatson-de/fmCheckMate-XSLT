<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2026 @mrwatson-de

	===== PURPOSE =====

	XSL-File: XMFN_XMFN_RemoveFunctionsByName.xsl

	XML-Source: fmxmlsnippet.xml
	XML-Grammar: fmxmlsnippet
	XML-Content: copied custom functions

	Removes the CustomFunctions whose name occurs in the parameter pCustomFunctionNames - and keeps everything else.

	pCustomFunctionNames is a list of custom function names, delimited by pipes and/or end-of-line characters
	(CR, LF or CRLF - i.e. from any OS). Empty entries and whitespace around the names are ignored,
	and the names are matched case-insensitively, so that they can be typed quickly.

	Because everything else is kept, the stylesheet works both for a simple list of copied custom functions,
	and for a copied hierarchy of custom functions in folders: only the custom functions are removed,
	the folder structure remains intact.

	===== CHANGES HISTORY =====
	2026-07-24 @mrwatson-de: Version 1.0
	-->
	<!-- ===== HEAD ===== -->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Calculation Text Data"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/inc.Clone.xsl"/>
	<xsl:include href="../../../fmCheckMate/xsl/_inc/constants.xsl"/>
	<!-- ===== PARAMS ===== -->
	<!-- The names of the custom functions to remove, pipe- and/or EOL-delimited -->
	<xsl:param name="pCustomFunctionNames">
G__Default
G_DA_Datum_Relativ
G_DA_HostZeit
G_DA_Zeit_Relativ
G_IS_AdvNaviAvailable
G_IS_BrowseMode
G_IS_DesktopSingleDocumentInterface
G_IS_ExistFileOrFolderTrue
G_IS_MAC
G_IS_MBSError
G_IS_MenuKey
G_IS_Modul_lizenziert
G_IS_PfadFM
G_IS_Server
G_IS_ShiftKey
G_IS_ValueInList
G_IS_WIN
G_IS_WindowModal
G_J_GetElementAsArray
G_J_IsValidJSON
G_J_Length
G_J_SP
G_Security_entschlüsseln_GBS
G_SY_BaseTable
G_SY_CardWindowCloseClickHandler
G_SY_CardWindowOpenClickHandler
G_SY_CenteredWindowLeft
G_SY_CenteredWindowTop
G_SY_Druckvorschau_FensterBreite
G_SY_DynArrayLesen
G_SY_FieldTable
G_SY_FMVar_Lesen
G_SY_FMVar_Löschen
G_SY_FMVar_Setzen
G_SY_FMVersionNr
G_SY_FrontPanels
G_SY_HoverPopover
G_SY_LayoutObjectNames
G_SY_Log
G_SY_Meldung
G_SY_PluginInfo
G_SY_PressKey
G_SY_ScriptName
G_SY_SerialNumberFields
G_SY_TranslateString
G_SY_TranslateToProgLang
G_SY_VerlaufLog
G_SY_Voreinst
G_SY_WindowDesktopHeight
G_SY_WindowDesktopLeft
G_SY_WindowDesktopTop
G_SY_WindowDesktopWidth
G_SY_WinMac
G_TD_Dlg
G_TD_Fortschrittsbalken
G_TF_DeleteFile
G_TF_DragDrop
G_TF_LaunchFile
G_TF_RevealFile
G_TF_SelectFileDialog
G_TF_Tools_Interpreter
G_TF_Tools_PathConvFmToNative
G_TF_Tools_PathConvFmToTroi
G_TF_Tools_PathConvNativeToTroi
G_TF_Tools_PathConvTroiToFm
G_TF_Tools_PathConvTroiToNative
G_TF_Tools_ShowFilenameWithoutFoldername
G_TX_Beschriften
G_TX_Delimit
G_TX_Format_Text
G_TX_GetItem
G_TX_ScriptParam
G_TX_ScriptParamChar4
G_TX_ScriptPipeVerstecken
G_TX_ScriptPipeZeigen
G_TX_ScriptResult
G_TX_StartsWith
G_TX_SubString
G_TX_SubstringAfterBefore
G_VL_Found_OK
</xsl:param>
	<!-- ===== VARIABLES ===== -->
	<!-- The normalised, lowercased name list as a key of the form |name1|name2|name3| -->
	<xsl:variable name="customFunctionNameKey">
		<xsl:value-of select="$PIPE"/>
		<xsl:call-template name="AppendNamesToKey">
			<!-- Turn all end-of-line characters into pipes, so that only one delimiter remains -->
			<xsl:with-param name="names" select="translate($pCustomFunctionNames,$CRLF,'||')"/>
		</xsl:call-template>
	</xsl:variable>
	<!-- ===== TEMPLATES ===== -->
	<!-- Remove the custom functions named in the key -->
	<xsl:template match="CustomFunction">
		<xsl:if test="not(contains($customFunctionNameKey,concat($PIPE,translate(normalize-space(@name),$UPPERCASE_CHARS,$LOWERCASE_CHARS),$PIPE)))">
			<!-- KEEP -->
			<xsl:copy-of select="."/>
		</xsl:if>
	</xsl:template>
	<!-- ===== NAMED TEMPLATES ===== -->
	<!-- Append each (trimmed, lowercased, non-empty) name of a pipe-delimited list to the key, each name followed by a pipe -->
	<xsl:template name="AppendNamesToKey">
		<xsl:param name="names"/>
		<xsl:variable name="name" select="translate(normalize-space(substring-before(concat($names,$PIPE),$PIPE)),$UPPERCASE_CHARS,$LOWERCASE_CHARS)"/>
		<xsl:if test="string-length($name)">
			<xsl:value-of select="concat($name,$PIPE)"/>
		</xsl:if>
		<xsl:if test="contains($names,$PIPE)">
			<xsl:call-template name="AppendNamesToKey">
				<xsl:with-param name="names" select="substring-after($names,$PIPE)"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
