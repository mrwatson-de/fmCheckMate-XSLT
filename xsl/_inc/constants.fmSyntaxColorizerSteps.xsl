<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: _inc/constants.StepIDs.xsl

	Contains the fmSyntaxColorizer fmxmlsnippet.xml.
	
	===== CHANGES HISTORY =====
	2025-10-13 @MrWatson-de Version 1.0
	-->
	<!-- ===== CONSTANTS ===== -->
	<xsl:variable name="fmSyntaxColorizerSteps-fmxmlsnippet">
		<Step enable="True" id="1" name="Perform Script"/>
		<Step enable="True" id="2" name="&lt;unknown&gt; [2]"/>
		<Step enable="True" id="3" name="Save a Copy as XML">
			<Option state="False"/>
		</Step>
		<Step enable="True" id="4" name="Go to Next Field"/>
		<Step enable="True" id="5" name="Go to Previous Field"/>
		<Step enable="True" id="6" name="Go to Layout">
			<LayoutDestination value="OriginalLayout"/>
		</Step>
		<Step enable="True" id="7" name="New Record/Request"/>
		<Step enable="True" id="8" name="Duplicate Record/Request"/>
		<Step enable="True" id="9" name="Delete Record/Request">
			<NoInteract state="False"/>
		</Step>
		<Step enable="True" id="10" name="Delete All Records">
			<NoInteract state="False"/>
		</Step>
		<Step enable="True" id="11" name="Insert from Index">
			<SelectAll state="True"/>
		</Step>
		<Step enable="True" id="12" name="Insert from Last Visited">
			<SelectAll state="True"/>
		</Step>
		<Step enable="True" id="13" name="Insert Current Date">
			<SelectAll state="True"/>
		</Step>
		<Step enable="True" id="14" name="Insert Current Time">
			<SelectAll state="True"/>
		</Step>
		<Step enable="True" id="15" name="&lt;unknown&gt; [15]">
			<Option state="False"/>
			<UniversalPathList type="Embedded"/>
		</Step>
		<Step enable="True" id="16" name="Go to Record/Request/Page">
			<NoInteract state="True"/>
			<RowPageLocation value="First"/>
		</Step>
		<Step enable="True" id="17" name="Go to Field">
			<SelectAll state="False"/>
		</Step>
		<Step enable="True" id="18" name="Check Selection">
			<SelectAll state="True"/>
		</Step>
		<Step enable="True" id="19" name="Check Record"/>
		<Step enable="True" id="20" name="Check Found Set"/>
		<Step enable="True" id="21" name="Unsort Records"/>
		<Step enable="True" id="22" name="Enter Find Mode">
			<Pause state="True"/>
			<Restore state="False"/>
		</Step>
		<Step enable="True" id="23" name="Show All Records"/>
		<Step enable="True" id="24" name="Modify Last Find"/>
		<Step enable="True" id="25" name="Omit Record"/>
		<Step enable="True" id="26" name="Omit Multiple Records">
			<NoInteract state="True"/>
		</Step>
		<Step enable="True" id="27" name="Show Omitted Only"/>
		<Step enable="True" id="28" name="Perform Find">
			<Restore state="False"/>
		</Step>
		<Step enable="True" id="29" name="Show/Hide Toolbars">
			<IncludeEditRecordToolbar state="True"/>
			<Lock state="False"/>
			<ShowHide value="Hide"/>
		</Step>
		<Step enable="True" id="30" name="View As">
			<View value="Cycle"/>
		</Step>
		<Step enable="True" id="31" name="Adjust Window">
			<WindowState value="ResizeToFit"/>
		</Step>
		<Step enable="True" id="32" name="Open Help"/>
		<Step enable="True" id="33" name="Open File">
			<Option state="False"/>
		</Step>
		<Step enable="True" id="34" name="Close File"/>
		<Step enable="True" id="35" name="Import Records">
			<NoInteract state="True"/>
			<Restore state="False"/>
			<VerifySSLCertificates state="False"/>
		</Step>
		<Step enable="True" id="36" name="Export Records">
			<NoInteract state="True"/>
			<CreateDirectories state="True"/>
			<Restore state="False"/>
			<AutoOpen state="False"/>
			<CreateEmail state="False"/>
		</Step>
		<Step enable="True" id="37" name="Save a Copy as">
			<CreateDirectories state="True"/>
			<AutoOpen state="False"/>
			<CreateEmail state="False"/>
			<SaveAsType value="Copy"/>
		</Step>
		<Step enable="True" id="38" name="Open Manage Database"/>
		<Step enable="True" id="39" name="Sort Records">
			<NoInteract state="True"/>
			<Restore state="False"/>
		</Step>
		<Step enable="True" id="40" name="Relookup Field Contents">
			<NoInteract state="True"/>
		</Step>
		<Step enable="True" id="41" name="Enter Preview Mode">
			<Pause state="False"/>
		</Step>
		<Step enable="True" id="42" name="Print Setup">
			<NoInteract state="True"/>
			<Restore state="False"/>
		</Step>
		<Step enable="True" id="43" name="Print">
			<NoInteract state="True"/>
			<Restore state="False"/>
		</Step>
		<Step enable="True" id="44" name="Exit Application"/>
		<Step enable="True" id="45" name="Undo/Redo">
			<UndoRedo value="Undo"/>
		</Step>
		<Step enable="True" id="46" name="Cut">
			<SelectAll state="True"/>
		</Step>
		<Step enable="True" id="47" name="Copy">
			<SelectAll state="True"/>
		</Step>
		<Step enable="True" id="48" name="Paste">
			<NoStyle state="True"/>
			<SelectAll state="True"/>
			<LinkAvail state="False"/>
		</Step>
		<Step enable="True" id="49" name="Clear">
			<SelectAll state="True"/>
		</Step>
		<Step enable="True" id="50" name="Select All"/>
		<Step enable="True" id="51" name="Revert Record/Request">
			<NoInteract state="True"/>
		</Step>
		<Step enable="True" id="52" name="&lt;unknown&gt; [52]"/>
		<Step enable="True" id="53" name="&lt;unknown&gt; [53]"/>
		<Step enable="True" id="54" name="&lt;unknown&gt; [54]"/>
		<Step enable="True" id="55" name="Enter Browse Mode">
			<Pause state="False"/>
		</Step>
		<Step enable="True" id="56" name="Insert Picture">
			<UniversalPathList type="Embedded"/>
		</Step>
		<Step enable="True" id="57" name="Send Event">
			<ContentType value="File"/>
			<Event CopyResultToClipboard="False" WaitForCompletion="False" BringTargetToForeground="False"/>
		</Step>
		<Step enable="True" id="58" name="&lt;unknown&gt; [58]">
			<NoInteract state="False"/>
		</Step>
		<Step enable="True" id="59" name="Insert QuickTime"/>
		<Step enable="True" id="60" name="Insert Current User Name">
			<SelectAll state="True"/>
		</Step>
		<Step enable="True" id="61" name="Insert Text">
			<SelectAll state="True"/>
		</Step>
		<Step enable="True" id="62" name="Pause/Resume Script">
			<PauseTime value="Indefinitely"/>
		</Step>
		<Step enable="True" id="63" name="Send Mail">
			<NoInteract state="True"/>
			<MultipleEmails state="False"/>
			<SendViaSMTP state="False"/>
			<SendViaOAuthAuthentication state="False"/>
			<SMTPEncryptionType type="SMTPEncryptionNone"/>
			<SMTPAuthenticationType type="SMTPAuthenticationNone"/>
			<OAuthProvider type="OAuthProviderGoogle"/>
		</Step>
		<Step enable="True" id="64" name="Send DDE Execute">
			<ContentType value="File"/>
		</Step>
		<Step enable="True" id="65" name="Dial Phone">
			<NoInteract state="True"/>
		</Step>
		<Step enable="True" id="66" name="Speak">
			<SpeechOptions WaitForCompletion="True" VoiceId="0"/>
		</Step>
		<Step enable="True" id="67" name="Perform AppleScript">
			<ContentType value="Text"/>
		</Step>
		<Step enable="True" id="68" name="If"/>
		<Step enable="True" id="69" name="Else"/>
		<Step enable="True" id="70" name="End If"/>
		<Step enable="True" id="71" name="Loop">
			<FlushType value="Always"/>
		</Step>
		<Step enable="True" id="72" name="Exit Loop If"/>
		<Step enable="True" id="73" name="End Loop"/>
		<Step enable="True" id="74" name="Go to Related Record">
			<Option state="False"/>
			<MatchAllRecords state="False"/>
			<ShowInNewWindow state="False"/>
			<Restore state="False"/>
			<LayoutDestination value="CurrentLayout"/>
			<NewWndStyles Style="Document" Close="Yes" Minimize="Yes" Maximize="Yes" Resize="Yes" Styles="3606018"/>
			<Table id="0" name=""/>
		</Step>
		<Step enable="True" id="75" name="Commit Records/Requests">
			<NoInteract state="True"/>
			<Option state="False"/>
			<ESSForceCommit state="False"/>
		</Step>
		<Step enable="True" id="76" name="Set Field"/>
		<Step enable="True" id="77" name="Insert Calculated Result">
			<SelectAll state="True"/>
		</Step>
		<Step enable="True" id="78" name="Insert Object"/>
		<Step enable="True" id="79" name="Freeze Window"/>
		<Step enable="True" id="80" name="Refresh Window">
			<Option state="False"/>
			<FlushSQLData state="False"/>
		</Step>
		<Step enable="True" id="81" name="Scroll Window">
			<ScrollOperation value="Home"/>
		</Step>
		<Step enable="True" id="82" name="New File"/>
		<Step enable="True" id="83" name="Change Password">
			<NoInteract state="False"/>
		</Step>
		<Step enable="True" id="84" name="Set Multi-User">
			<MultiUser value="True"/>
		</Step>
		<Step enable="True" id="85" name="Allow User Abort">
			<Set state="False"/>
		</Step>
		<Step enable="True" id="86" name="Set Error Capture">
			<Set state="True"/>
		</Step>
		<Step enable="True" id="87" name="Show Custom Dialog"/>
		<Step enable="True" id="88" name="Open Script Workspace"/>
		<Step enable="True" id="89" name="# (comment)">
			<Text>Comment</Text>
		</Step>
		<Step enable="True" id="90" name="Halt Script"/>
		<Step enable="True" id="91" name="Replace Field Contents">
			<NoInteract state="True"/>
			<With value="None"/>
			<SerialNumbers UpdateEntryOptions="False" increment="0" InitialValue="" UseEntryOptions="False"/>
		</Step>
		<Step enable="True" id="92" name="Show/Hide Text Ruler">
			<ShowHide value="Show"/>
		</Step>
		<Step enable="True" id="93" name="Beep"/>
		<Step enable="True" id="94" name="Set Use System Formats">
			<Set state="True"/>
		</Step>
		<Step enable="True" id="95" name="Recover File">
			<NoInteract state="True"/>
		</Step>
		<Step enable="True" id="96" name="Save a Copy as Add-on Package">
			<LinkAvail state="False"/>
		</Step>
		<Step enable="True" id="97" name="Set Zoom Level">
			<Lock state="False"/>
			<Zoom value="100"/>
		</Step>
		<Step enable="True" id="98" name="Copy All Records/Requests"/>
		<Step enable="True" id="99" name="Go to Portal Row">
			<NoInteract state="False"/>
			<SelectAll state="False"/>
			<RowPageLocation value="First"/>
		</Step>
		<Step enable="True" id="100" name="&lt;unknown&gt; [100]"/>
		<Step enable="True" id="101" name="Copy Record/Request"/>
		<Step enable="True" id="102" name="Flush Cache to Disk"/>
		<Step enable="True" id="103" name="Exit Script"/>
		<Step enable="True" id="104" name="Delete Portal Row">
			<NoInteract state="False"/>
		</Step>
		<Step enable="True" id="105" name="Open Settings"/>
		<Step enable="True" id="106" name="Correct Word"/>
		<Step enable="True" id="107" name="Spelling Options"/>
		<Step enable="True" id="108" name="Select Dictionaries"/>
		<Step enable="True" id="109" name="Edit User Dictionary"/>
		<Step enable="True" id="68" name="If">
			<Calculation><![CDATA[/* Command ID 110 <unknown> - but command 125, else if, has to be inside an if to be legal*/]]></Calculation>
		</Step>
		<Step enable="True" id="111" name="Open URL">
			<NoInteract state="True"/>
			<Option state="False"/>
		</Step>
		<Step enable="True" id="112" name="Open Manage Value Lists"/>
		<Step enable="True" id="113" name="Open Sharing"/>
		<Step enable="True" id="114" name="Open File Options"/>
		<Step enable="True" id="115" name="Allow Formatting Bar">
			<Set state="False"/>
		</Step>
		<Step enable="True" id="116" name="Set Next Serial Value"/>
		<Step enable="True" id="117" name="Execute SQL">
			<NoInteract state="True"/>
		</Step>
		<Step enable="True" id="118" name="Open Hosts"/>
		<Step enable="True" id="119" name="Move/Resize Window">
			<LimitToWindowsOfCurrentFile state="True"/>
			<Window value="Current"/>
		</Step>
		<Step enable="True" id="120" name="Arrange All Windows">
			<WindowArrangement value="TileHorizontally"/>
		</Step>
		<Step enable="True" id="121" name="Close Window">
			<LimitToWindowsOfCurrentFile state="True"/>
			<Window value="Current"/>
		</Step>
		<Step enable="True" id="122" name="New Window">
			<LayoutDestination value="CurrentLayout"/>
			<NewWndStyles Style="Document" Close="Yes" Minimize="Yes" Maximize="Yes" Resize="Yes" Styles="3606018"/>
		</Step>
		<Step enable="True" id="123" name="Select Window">
			<LimitToWindowsOfCurrentFile state="True"/>
			<Window value="Current"/>
		</Step>
		<Step enable="True" id="124" name="Set Window Title">
			<LimitToWindowsOfCurrentFile state="True"/>
			<Window value="Current"/>
		</Step>
		<Step enable="True" id="125" name="Else If"/>
		<Step enable="True" id="126" name="Constrain Found Set">
			<Option state="False"/>
			<Restore state="False"/>
		</Step>
		<Step enable="True" id="127" name="Extend Found Set">
			<Restore state="False"/>
		</Step>
		<Step enable="True" id="128" name="Perform Find/Replace">
			<NoInteract state="False"/>
			<FindReplaceOperation MatchWholeWords="False" MatchCase="False" WithinOptions="All" AcrossOptions="All" direction="Forward" type="FindNext"/>
		</Step>
		<Step enable="True" id="129" name="Open Find/Replace"/>
		<Step enable="True" id="130" name="Set Selection"/>
		<Step enable="True" id="131" name="Insert File">
			<UniversalPathList type="Embedded"/>
			<DialogOptions asFile="True" enable="False">
				<Storage type="UserChoice"/>
				<Compress type="UserChoice"/>
				<FilterList/>
			</DialogOptions>
		</Step>
		<Step enable="True" id="132" name="Export Field Contents">
			<CreateDirectories state="True"/>
			<AutoOpen state="False"/>
			<CreateEmail state="False"/>
		</Step>
		<Step enable="True" id="133" name="Open Record/Request"/>
		<Step enable="True" id="134" name="Add Account">
			<ChgPwdOnNextLogin value="False"/>
		</Step>
		<Step enable="True" id="135" name="Delete Account"/>
		<Step enable="True" id="136" name="Reset Account Password">
			<ChgPwdOnNextLogin value="False"/>
		</Step>
		<Step enable="True" id="137" name="Enable Account">
			<AccountOperation value="Activate"/>
		</Step>
		<Step enable="True" id="138" name="Re-Login">
			<NoInteract state="True"/>
		</Step>
		<Step enable="True" id="139" name="Convert File">
			<NoInteract state="False"/>
			<Option state="False"/>
			<SkipIndexes state="False"/>
			<VerifySSLCertificates state="False"/>
		</Step>
		<Step enable="True" id="140" name="Open Manage Data Sources"/>
		<Step enable="True" id="141" name="Set variable"/>
		<Step enable="True" id="142" name="Install Menu Set">
			<UseAsFileDefault state="False"/>
			<CustomMenuSet id="1" name="[Standard FileMaker Menus]"/>
		</Step>
		<Step enable="True" id="143" name="Save Records as Excel">
			<NoInteract state="True"/>
			<CreateDirectories state="True"/>
			<Restore state="False"/>
			<AutoOpen state="False"/>
			<CreateEmail state="False"/>
			<SaveType value="BrowsedRecords"/>
			<UseFieldNames state="False"/>
		</Step>
		<Step enable="True" id="144" name="Save Records as PDF">
			<NoInteract state="True"/>
			<Option state="False"/>
			<CreateDirectories state="True"/>
			<Restore state="False"/>
			<AutoOpen state="False"/>
			<CreateEmail state="False"/>
			<PDFOptions source="RecordsBeingBrowsed">
				<Document>
					<Pages AllPages="True">
						<NumberFrom>
							<Calculation><![CDATA[1]]></Calculation>
						</NumberFrom>
						<PageRange>
							<From>
								<Calculation><![CDATA[1]]></Calculation>
							</From>
							<To>
								<Calculation><![CDATA[1]]></Calculation>
							</To>
						</PageRange>
					</Pages>
				</Document>
				<Security allowScreenReader="True" enableCopying="True" controlEditing="AnyExceptExtractingPages" controlPrinting="HighResolution" requireControlEditPassword="False" requireOpenPassword="False"/>
				<View magnification="100" pageLayout="SinglePage" show="PagesPanelAndPage"/>
			</PDFOptions>
		</Step>
		<Step enable="True" id="145" name="Go to Object"/>
		<Step enable="True" id="146" name="Set Web Viewer">
			<Action value="Reset"/>
		</Step>
		<Step enable="True" id="147" name="Set Field By Name"/>
		<Step enable="True" id="148" name="Install OnTimer Script"/>
		<Step enable="True" id="149" name="Open Edit Saved Finds"/>
		<Step enable="True" id="150" name="Perform Quick Find"/>
		<Step enable="True" id="151" name="Open Manage Layouts"/>
		<Step enable="True" id="152" name="Save Records as Snapshot Link">
			<CreateDirectories state="True"/>
			<CreateEmail state="False"/>
			<SaveType value="BrowsedRecords"/>
		</Step>
		<Step enable="True" id="153" name="&lt;unknown&gt; [153]"/>
		<Step enable="True" id="154" name="Sort Records by Field">
			<SortRecordsByField value="SortAscending"/>
		</Step>
		<Step enable="True" id="155" name="Find Matching Records">
			<FindMatchingRecordsByField value="FindMatchingReplace"/>
		</Step>
		<Step enable="True" id="156" name="Open Manage Containers"/>
		<Step enable="True" id="157" name="Install Plug-In File"/>
		<Step enable="True" id="158" name="Insert PDF">
			<UniversalPathList type="Embedded"/>
		</Step>
		<Step enable="True" id="159" name="Insert Audio/Video">
			<UniversalPathList type="Embedded"/>
		</Step>
		<Step enable="True" id="160" name="Insert from URL">
			<NoInteract state="True"/>
			<DontEncodeURL state="False"/>
			<SelectAll state="True"/>
			<VerifySSLCertificates state="False"/>
		</Step>
		<Step enable="True" id="161" name="Insert from Device">
			<InsertFrom value="Camera"/>
			<DeviceOptions>
				<Camera choice="Back"/>
				<Resolution choice="Full"/>
			</DeviceOptions>
		</Step>
		<Step enable="True" id="162" name="&lt;unknown&gt; [162]"/>
		<Step enable="True" id="163" name="&lt;unknown&gt; [163]"/>
		<Step enable="True" id="164" name="Perform Script on Server">
			<WaitForCompletion state="True"/>
		</Step>
		<Step enable="True" id="165" name="Open Manage Themes"/>
		<Step enable="True" id="166" name="Show/Hide Menubar">
			<Lock state="False"/>
			<ShowHide value="Hide"/>
		</Step>
		<Step enable="True" id="167" name="Refresh Object"/>
		<Step enable="True" id="168" name="Set Layout Object Animation">
			<Set state="True"/>
		</Step>
		<Step enable="True" id="169" name="Close Popover"/>
		<Step enable="True" id="170" name="&lt;unknown&gt; [170]"/>
		<Step enable="True" id="171" name="&lt;unknown&gt; [171]"/>
		<Step enable="True" id="172" name="Open Upload to Host"/>
		<Step enable="True" id="173" name="&lt;unknown&gt; [173]"/>
		<Step enable="True" id="174" name="Enable Touch Keyboard">
			<ShowHide value="Show"/>
		</Step>
		<Step enable="True" id="175" name="Perform JavaScript in Web Viewer"/>
		<Step enable="True" id="176" name="Set Allowed Orientations"/>
		<Step enable="True" id="177" name="AVPlayer Play">
			<Source value="Object"/>
		</Step>
		<Step enable="True" id="178" name="AVPlayer Set Playback State">
			<PlaybackState value="Stopped"/>
		</Step>
		<Step enable="True" id="179" name="AVPlayer Set Options"/>
		<Step enable="True" id="180" name="Refresh Portal"/>
		<Step enable="True" id="181" name="Get Folder Path">
			<AllowFolderCreation state="False"/>
		</Step>
		<Step enable="True" id="182" name="Truncate Table">
			<NoInteract state="False"/>
			<BaseTable id="-1" name="&lt;Current Table&gt;"/>
		</Step>
		<Step enable="True" id="183" name="Open Favorites"/>
		<Step enable="True" id="184" name="Open Starter Solution"/>
		<Step enable="True" id="185" name="Configure Region Monitor Script">
			<MonitorType value="iBeacon"/>
		</Step>
		<Step index="2" Source="MBSP" enable="True" id="186" name="MBS">
			<PluginStep>
				<Parameter ShowInLine="true" Label="Destination" Type="target"/>
				<Parameter ID="0" Label="Function" ShowInline="true" DataType="text" Type="calc"/>
				<Parameter ID="1" Label="P1" ShowInline="true" DataType="text" Type="calc"/>
				<Parameter ID="2" Label="P2" ShowInline="true" DataType="text" Type="calc"/>
				<Parameter ID="3" Label="P3" ShowInline="true" DataType="text" Type="calc"/>
				<Parameter ID="4" Label="P4" ShowInline="true" DataType="text" Type="calc"/>
				<Parameter ID="5" Label="P5" ShowInline="false" DataType="text" Type="calc"/>
				<Parameter ID="6" Label="P6" ShowInline="false" DataType="text" Type="calc"/>
				<Parameter ID="7" Label="P7" ShowInline="false" DataType="text" Type="calc"/>
				<Parameter ID="8" Label="P8" ShowInline="false" DataType="text" Type="calc"/>
				<Parameter ID="9" Label="P9" ShowInline="false" DataType="text" Type="calc"/>
			</PluginStep>
			<SelectAll state="True"/>
			<Field table="_Home" id="6" name="_gInputText1"/>
			<ParameterValues>
				<Object index="0" type="Calc">
					<Calculation><![CDATA[$Command]]></Calculation>
				</Object>
				<Object index="1" type="Calc">
					<Calculation><![CDATA[$P1]]></Calculation>
				</Object>
				<Object index="2" type="Calc">
					<Calculation><![CDATA[$P2]]></Calculation>
				</Object>
				<Object index="3" type="Calc">
					<Calculation><![CDATA[$P3]]></Calculation>
				</Object>
				<Object index="4" type="Calc">
					<Calculation><![CDATA[$P4]]></Calculation>
				</Object>
				<Object index="5" type="Calc">
					<Calculation><![CDATA[$P5]]></Calculation>
				</Object>
				<Object index="6" type="Calc">
					<Calculation><![CDATA[$P6]]></Calculation>
				</Object>
				<Object index="7" type="Calc">
					<Calculation><![CDATA[$P7]]></Calculation>
				</Object>
				<Object index="8" type="Calc">
					<Calculation><![CDATA[$P8]]></Calculation>
				</Object>
				<Object index="9" type="Calc">
					<Calculation><![CDATA[$P9]]></Calculation>
				</Object>
			</ParameterValues>
		</Step>
		<Step enable="True" id="187" name="Configure Local Notification">
			<Action value="Queue"/>
		</Step>
		<Step enable="True" id="188" name="Get File Exists"/>
		<Step enable="True" id="189" name="Get File Size"/>
		<Step enable="True" id="190" name="Create Data File">
			<CreateDirectories state="True"/>
		</Step>
		<Step enable="True" id="191" name="Open Data File"/>
		<Step enable="True" id="192" name="Write to Data File">
			<AppendLineFeed state="True"/>
			<DataSourceType value="1"/>
		</Step>
		<Step enable="True" id="193" name="Read from Data File">
			<DataSourceType value="3"/>
		</Step>
		<Step enable="True" id="194" name="Get Data File Position"/>
		<Step enable="True" id="195" name="Set Data File Position"/>
		<Step enable="True" id="196" name="Close Data File"/>
		<Step enable="True" id="197" name="Delete File"/>
		<Step enable="True" id="198" name="&lt;unknown&gt; [198]"/>
		<Step enable="True" id="199" name="Rename File"/>
		<Step enable="True" id="200" name="Set Error Logging">
			<Option state="False"/>
		</Step>
		<Step enable="True" id="201" name="Configure NFC Reading">
			<Action value="Read"/>
		</Step>
		<Step enable="True" id="202" name="Configure Machine Learning Model">
			<ConfigureCoreML>Uninstall</ConfigureCoreML>
		</Step>
		<Step enable="True" id="203" name="Execute FileMaker Data API">
			<SelectAll state="True"/>
		</Step>
		<Step enable="True" id="89" name="# (comment)">
			<Text>[OBSOLETE]  &lt;unknown&gt; [204] // Note: 206 = Commit Transaction, 207 = Revert Transaction - but they are swapped here, so that the script is valid</Text>
		</Step>
		<Step enable="True" id="205" name="Open Transaction">
			<Option state="False"/>
			<ESSForceCommit state="False"/>
			<SkipAutoEntry state="False"/>
		</Step>
		<Step enable="True" id="207" name="Revert Transaction">
			<Option state="False"/>
		</Step>
		<Step enable="True" id="206" name="Commit Transaction"/>
		<Step enable="True" id="208" name="Set Session Identifier"/>
		<Step enable="True" id="209" name="Set Dictionary">
			<MainDictionary value="US English"/>
		</Step>
		<Step enable="True" id="210" name="Perform Script on Server with Callback">
			<CallbackScriptState value="Continue"/>
			<CallbackScript/>
		</Step>
		<Step enable="True" id="211" name="Trigger Claris Connect Flow">
			<NoInteract state="True"/>
			<DontEncodeURL state="False"/>
			<SelectAll state="True"/>
			<VerifySSLCertificates state="False"/>
			<Flow>&lt;unknown&gt;</Flow>
			<CURLOptions>
				<Calculation><![CDATA["--request POST --header \"Content-Type: application/json\" --data "]]></Calculation>
			</CURLOptions>
			<Text>&lt;unknown&gt;</Text>
		</Step>
		<Step enable="True" id="212" name="Configure AI Account">
			<LLMType value="ChatGPT"/>
			<SetLLMAccout/>
		</Step>
		<Step enable="True" id="213" name="Fine Tune LLM">
			<Option state="False"/>
			<UniversalPathList type="Embedded"/>
			<Table id="0" name=""/>
			<FineTuneLLM>
				<DataSource>DataTable</DataSource>
			</FineTuneLLM>
		</Step>
		<Step enable="True" id="214" name="LLM Request">
			<Option state="False"/>
			<Stream state="False"/>
			<UniversalPathList type="Embedded"/>
			<LLMRequest>
				<OptionsSelectionType>By List</OptionsSelectionType>
				<Action>Query</Action>
				<TablesSelectionType>By List</TablesSelectionType>
				<QueryScope>Database Only</QueryScope>
			</LLMRequest>
		</Step>
		<Step enable="True" id="215" name="Insert Embedding">
			<LLMEmbedding/>
		</Step>
		<Step enable="True" id="216" name="Insert Embedding in Found Set">
			<LLMBulkEmbedding/>
		</Step>
		<Step enable="True" id="217" name="Set AI Call Logging">
			<Set state="False"/>
			<LLMDebugLog/>
		</Step>
		<Step enable="True" id="218" name="Perform Semantic Find">
			<LLMSemanticFind>
				<Query type="1"/>
				<Records type="1"/>
			</LLMSemanticFind>
		</Step>
		<Step enable="True" id="219" name="LLM Claris RAG Space">
			<LLMClarisRAGSpace>
				<RAGSpaceAction>Add</RAGSpaceAction>
				<DataSource>FromText</DataSource>
			</LLMClarisRAGSpace>
		</Step>
		<Step enable="True" id="220" name="LLM Request With Tools">
			<Option state="False"/>
			<SelectAll state="False"/>
			<Stream state="False"/>
			<Restore state="False"/>
			<UniversalPathList type="Embedded"/>
			<LLMRequestWithTools/>
		</Step>
		<Step enable="True" id="221" name="LLM Create Find Request">
			<Option state="False"/>
			<SelectAll state="True"/>
			<LLMCreateFind>
				<Action>Query</Action>
			</LLMCreateFind>
		</Step>
		<Step enable="True" id="222" name="LLM Train">
			<LLMTrain/>
		</Step>
		<Step enable="True" id="223" name="Set Revert Transaction on Error">
			<Set state="False"/>
		</Step>
		<Step enable="True" id="224" name="Execute URL">
			<Option state="False"/>
			<VerifySSLCertificates state="False"/>
		</Step>
		<Step enable="True" id="225" name="Save Records as JSONL">
			<Option state="False"/>
			<CreateDirectories state="False"/>
			<AutoOpen state="False"/>
			<CreateEmail state="False"/>
			<SaveAsJSONL/>
		</Step>
		<Step enable="True" id="226" name="Configure LLM Template">
			<Option state="False"/>
			<ConfigureLLMTemplate>
				<ModelProvider>ChatGPT</ModelProvider>
			</ConfigureLLMTemplate>
		</Step>
		<Step enable="True" id="227" name="Configure LLM Claris RAG Account ">
			<VerifySSLCertificates state="False"/>
			<ConfigureLLMClarisRAGAccount/>
		</Step>
		<Step enable="True" id="228" name="&lt;unknown&gt;"/>
		<Step enable="True" id="89" name="# (comment)">
			<Text>&lt;fmxmlsnippet type="FMObjectList"&gt;&#13;&lt;Step enable="True" id="229"&gt;&lt;/Step&gt;&#13;&lt;/fmxmlsnippet&gt;</Text>
		</Step>
		<Step enable="True" id="89" name="# (comment)"/>
		<Step enable="True" id="89" name="# (comment)">
			<Text>-&gt; Watch this space :-) FM NEXT</Text>
		</Step>
		<Step enable="True" id="70" name="End If"/>
		<Step enable="True" id="89" name="# (comment)"/>
	</xsl:variable>
</xsl:stylesheet>
