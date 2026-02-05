<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) 2024 @mrwatson-de

	===== PURPOSE =====

	XSL-File: _inc/constants.StepIDs.xsl

	Defines script step id constants to make stylesheet coding easier.
	
	===== CHANGES HISTORY =====
	2023-04-30 MrW: Version 1.5
	- Added new Script Step IDs for fm20.3.1
	  - 210 = ID_PERFORM_SCRIPT_ON_SERVER_WITH_CALLBACK
	  - 211 = ID_TRIGGER_CLARIS_CONNECT_FLOW
	2023-02-27 MrW: Version 1.4
	- Added new Script Step IDs for fm19.6.2 up to 209 = ID_SET_DICTIONARY
	- Added 96 ID_SAVE_A_COPY_AS_ADD_ON_PACKAGE
	- Renamed 175 ID_PERFORM_SCRIPT_IN_WEB_VIEWER
	2019-03-31 MrW: Version 1.3.1 Added comments indicating renamings and obsoletions
	2019-03-30 MrW: Version 1.3 FileMaker 18 Script Steps
	2016-09-01 MrW: Version 1.2 corrected select value
	2013-12-15 MrW: Version 1.1 FileMaker 13 Script steps 
	2013-05-09 MrW: Version 1.0
	-->
	<!-- ===== CONSTANTS ===== -->
	<xsl:variable name="ID_PERFORM_SCRIPT" select="'1'"/>
	<xsl:variable name="ID_GO_TO_NEXT_FIELD" select="'4'"/>
	<xsl:variable name="ID_GO_TO_PREVIOUS_FIELD" select="'5'"/>
	<xsl:variable name="ID_GO_TO_LAYOUT" select="'6'"/>
	<xsl:variable name="ID_NEW_RECORD_REQUEST" select="'7'"/>
	<xsl:variable name="ID_DUPLICATE_RECORD_REQUEST" select="'8'"/>
	<xsl:variable name="ID_DELETE_RECORD_REQUEST" select="'9'"/>
	<xsl:variable name="ID_DELETE_ALL_RECORDS" select="'10'"/>
	<xsl:variable name="ID_INSERT_FROM_INDEX" select="'11'"/>
	<xsl:variable name="ID_INSERT_FROM_LAST_VISITED" select="'12'"/>
	<xsl:variable name="ID_INSERT_CURRENT_DATE" select="'13'"/>
	<xsl:variable name="ID_INSERT_CURRENT_TIME" select="'14'"/>
	<xsl:variable name="ID_GO_TO_RECORD_REQUEST_PAGE" select="'16'"/>
	<xsl:variable name="ID_GO_TO_FIELD" select="'17'"/>
	<xsl:variable name="ID_CHECK_SELECTION" select="'18'"/>
	<xsl:variable name="ID_CHECK_RECORD" select="'19'"/>
	<xsl:variable name="ID_CHECK_FOUND_SET" select="'20'"/>
	<xsl:variable name="ID_UNSORT_RECORDS" select="'21'"/>
	<xsl:variable name="ID_ENTER_FIND_MODE" select="'22'"/>
	<xsl:variable name="ID_SHOW_ALL_RECORDS" select="'23'"/>
	<xsl:variable name="ID_MODIFY_LAST_FIND" select="'24'"/>
	<xsl:variable name="ID_OMIT_RECORD" select="'25'"/>
	<xsl:variable name="ID_OMIT_MULTIPLE_RECORDS" select="'26'"/>
	<xsl:variable name="ID_SHOW_OMITTED_ONLY" select="'27'"/>
	<xsl:variable name="ID_PERFORM_FIND" select="'28'"/>
	<xsl:variable name="ID_SHOW_HIDE_TOOLBARS" select="'29'"/>
	<xsl:variable name="ID_VIEW_AS" select="'30'"/>
	<xsl:variable name="ID_ADJUST_WINDOW" select="'31'"/>
	<xsl:variable name="ID_OPEN_HELP" select="'32'"/>
	<xsl:variable name="ID_OPEN_FILE" select="'33'"/>
	<xsl:variable name="ID_CLOSE_FILE" select="'34'"/>
	<xsl:variable name="ID_IMPORT_RECORDS" select="'35'"/>
	<xsl:variable name="ID_EXPORT_RECORDS" select="'36'"/>
	<xsl:variable name="ID_SAVE_A_COPY_AS" select="'37'"/>
	<xsl:variable name="ID_OPEN_MANAGE_DATABASE" select="'38'"/>
	<xsl:variable name="ID_SORT_RECORDS" select="'39'"/>
	<xsl:variable name="ID_RELOOKUP_FIELD_CONTENTS" select="'40'"/>
	<xsl:variable name="ID_ENTER_PREVIEW_MODE" select="'41'"/>
	<xsl:variable name="ID_PRINT_SETUP" select="'42'"/>
	<xsl:variable name="ID_PRINT" select="'43'"/>
	<xsl:variable name="ID_EXIT_APPLICATION" select="'44'"/>
	<xsl:variable name="ID_UNDO_REDO" select="'45'"/>
	<xsl:variable name="ID_CUT" select="'46'"/>
	<xsl:variable name="ID_COPY" select="'47'"/>
	<xsl:variable name="ID_PASTE" select="'48'"/>
	<xsl:variable name="ID_CLEAR" select="'49'"/>
	<xsl:variable name="ID_SELECT_ALL" select="'50'"/>
	<xsl:variable name="ID_REVERT_RECORD_REQUEST" select="'51'"/>
	<xsl:variable name="ID_ENTER_BROWSE_MODE" select="'55'"/>
	<xsl:variable name="ID_INSERT_PICTURE" select="'56'"/>
	<xsl:variable name="ID_SEND_EVENT" select="'57'"/>
	<xsl:variable name="ID_INSERT_QUICKTIME" select="'59'"/>
	<xsl:variable name="ID_INSERT_CURRENT_USER_NAME" select="'60'"/>
	<xsl:variable name="ID_INSERT_TEXT" select="'61'"/>
	<xsl:variable name="ID_PAUSE_RESUME_SCRIPT" select="'62'"/>
	<xsl:variable name="ID_SEND_MAIL" select="'63'"/>
	<xsl:variable name="ID_SEND_DDE_EXECUTE" select="'64'"/>
	<xsl:variable name="ID_DIAL_PHONE" select="'65'"/>
	<xsl:variable name="ID_SPEAK" select="'66'"/>
	<xsl:variable name="ID_PERFORM_APPLESCRIPT" select="'67'"/>
	<xsl:variable name="ID_IF" select="'68'"/>
	<xsl:variable name="ID_ELSE" select="'69'"/>
	<xsl:variable name="ID_END_IF" select="'70'"/>
	<xsl:variable name="ID_LOOP" select="'71'"/>
	<xsl:variable name="ID_EXIT_LOOP_IF" select="'72'"/>
	<xsl:variable name="ID_END_LOOP" select="'73'"/>
	<xsl:variable name="ID_GO_TO_RELATED_RECORD" select="'74'"/>
	<xsl:variable name="ID_COMMIT_RECORDS_REQUESTS" select="'75'"/>
	<xsl:variable name="ID_SET_FIELD" select="'76'"/>
	<xsl:variable name="ID_INSERT_CALCULATED_RESULT" select="'77'"/>
	<xsl:variable name="ID_FREEZE_WINDOW" select="'79'"/>
	<xsl:variable name="ID_REFRESH_WINDOW" select="'80'"/>
	<xsl:variable name="ID_SCROLL_WINDOW" select="'81'"/>
	<xsl:variable name="ID_NEW_FILE" select="'82'"/>
	<xsl:variable name="ID_CHANGE_PASSWORD" select="'83'"/>
	<xsl:variable name="ID_SET_MULTI-USER" select="'84'"/>
	<xsl:variable name="ID_ALLOW_USER_ABORT" select="'85'"/>
	<xsl:variable name="ID_SET_ERROR_CAPTURE" select="'86'"/>
	<xsl:variable name="ID_SHOW_CUSTOM_DIALOG" select="'87'"/>
	<xsl:variable name="ID_OPEN_MANAGE_SCRIPTS" select="'88'"/>
	<xsl:variable name="ID_COMMENT" select="'89'"/>
	<xsl:variable name="ID_HALT_SCRIPT" select="'90'"/>
	<xsl:variable name="ID_REPLACE_FIELD_CONTENTS" select="'91'"/>
	<xsl:variable name="ID_SHOW_HIDE_TEXT_RULER" select="'92'"/>
	<xsl:variable name="ID_BEEP" select="'93'"/>
	<xsl:variable name="ID_SET_USE_SYSTEM_FORMATS" select="'94'"/>
	<xsl:variable name="ID_RECOVER_FILE" select="'95'"/>
	<xsl:variable name="ID_SAVE_A_COPY_AS_ADD_ON_PACKAGE" select="'96'"/>
	<xsl:variable name="ID_SET_ZOOM_LEVEL" select="'97'"/>
	<xsl:variable name="ID_COPY_ALL_RECORDS_REQUESTS" select="'98'"/>
	<xsl:variable name="ID_GO_TO_PORTAL_ROW" select="'99'"/>
	<xsl:variable name="ID_COPY_RECORD_REQUEST" select="'101'"/>
	<xsl:variable name="ID_FLUSH_CACHE_TO_DISK" select="'102'"/>
	<xsl:variable name="ID_EXIT_SCRIPT" select="'103'"/>
	<xsl:variable name="ID_DELETE_PORTAL_ROW" select="'104'"/>
	<xsl:variable name="ID_OPEN_PREFERENCES" select="'105'"/>
	<xsl:variable name="ID_CORRECT_WORD" select="'106'"/>
	<xsl:variable name="ID_SPELLING_OPTIONS" select="'107'"/>
	<xsl:variable name="ID_SELECT_DICTIONARIES" select="'108'"/>
	<xsl:variable name="ID_EDIT_USER_DICTIONARY" select="'109'"/>
	<xsl:variable name="ID_OPEN_URL" select="'111'"/>
	<xsl:variable name="ID_OPEN_MANAGE_VALUE_LISTS" select="'112'"/>
	<xsl:variable name="ID_OPEN_SHARING" select="'113'"/>
	<xsl:variable name="ID_OPEN_FILE_OPTIONS" select="'114'"/>
	<xsl:variable name="ID_ALLOW_FORMATTING_BAR" select="'115'"/>
	<xsl:variable name="ID_SET_NEXT_SERIAL_VALUE" select="'116'"/>
	<xsl:variable name="ID_EXECUTE_SQL" select="'117'"/>
	<xsl:variable name="ID_OPEN_REMOTE" select="'118'"/>
	<!-- ^-Renamed in FM17 -v -->
	<xsl:variable name="ID_OPEN_HOSTS" select="'118'"/>
	<xsl:variable name="ID_MOVE_RESIZE_WINDOW" select="'119'"/>
	<xsl:variable name="ID_ARRANGE_ALL_WINDOWS" select="'120'"/>
	<xsl:variable name="ID_CLOSE_WINDOW" select="'121'"/>
	<xsl:variable name="ID_NEW_WINDOW" select="'122'"/>
	<xsl:variable name="ID_SELECT_WINDOW" select="'123'"/>
	<xsl:variable name="ID_SET_WINDOW_TITLE" select="'124'"/>
	<xsl:variable name="ID_ELSE_IF" select="'125'"/>
	<xsl:variable name="ID_CONSTRAIN_FOUND_SET" select="'126'"/>
	<xsl:variable name="ID_EXTEND_FOUND_SET" select="'127'"/>
	<xsl:variable name="ID_PERFORM_FIND_REPLACE" select="'128'"/>
	<xsl:variable name="ID_OPEN_FIND_REPLACE" select="'129'"/>
	<xsl:variable name="ID_SET_SELECTION" select="'130'"/>
	<xsl:variable name="ID_INSERT_FILE" select="'131'"/>
	<xsl:variable name="ID_EXPORT_FIELD_CONTENTS" select="'132'"/>
	<xsl:variable name="ID_OPEN_RECORD_REQUEST" select="'133'"/>
	<xsl:variable name="ID_ADD_ACCOUNT" select="'134'"/>
	<xsl:variable name="ID_DELETE_ACCOUNT" select="'135'"/>
	<xsl:variable name="ID_RESET_ACCOUNT_PASSWORD" select="'136'"/>
	<xsl:variable name="ID_ENABLE_ACCOUNT" select="'137'"/>
	<xsl:variable name="ID_RE-LOGIN" select="'138'"/>
	<xsl:variable name="ID_CONVERT_FILE" select="'139'"/>
	<xsl:variable name="ID_OPEN_MANAGE_DATA_SOURCES" select="'140'"/>
	<xsl:variable name="ID_SET_VARIABLE" select="'141'"/>
	<xsl:variable name="ID_INSTALL_MENU_SET" select="'142'"/>
	<xsl:variable name="ID_SAVE_RECORDS_AS_EXCEL" select="'143'"/>
	<xsl:variable name="ID_SAVE_RECORDS_AS_PDF" select="'144'"/>
	<xsl:variable name="ID_GO_TO_OBJECT" select="'145'"/>
	<xsl:variable name="ID_SET_WEB_VIEWER" select="'146'"/>
	<xsl:variable name="ID_SET_FIELD_BY_NAME" select="'147'"/>
	<xsl:variable name="ID_INSTALL_ONTIMER_SCRIPT" select="'148'"/>
	<xsl:variable name="ID_OPEN_EDIT_SAVED_FINDS" select="'149'"/>
	<xsl:variable name="ID_PERFORM_QUICK_FIND" select="'150'"/>
	<xsl:variable name="ID_OPEN_MANAGE_LAYOUTS" select="'151'"/>
	<xsl:variable name="ID_SAVE_RECORDS_AS_SNAPSHOT_LINK" select="'152'"/>
	<xsl:variable name="ID_SORT_RECORDS_BY_FIELD" select="'154'"/>
	<xsl:variable name="ID_FIND_MATCHING_RECORDS" select="'155'"/>
	<xsl:variable name="ID_OPEN_MANAGE_CONTAINERS" select="'156'"/>
	<xsl:variable name="ID_INSTALL_PLUG-IN_FILE" select="'157'"/>
	<xsl:variable name="ID_INSERT_PDF" select="'158'"/>
	<xsl:variable name="ID_INSERT_AUDIO_VIDEO" select="'159'"/>
	<xsl:variable name="ID_INSERT_FROM_URL" select="'160'"/>
	<xsl:variable name="ID_INSERT_FROM_DEVICE" select="'161'"/>
	<xsl:variable name="ID_PERFORM_SCRIPT_ON_SERVER" select="'164'"/>
	<xsl:variable name="ID_OPEN_MANAGE_THEMES" select="'165'"/>
	<xsl:variable name="ID_SHOW_HIDE_MENUBAR" select="'166'"/>
	<xsl:variable name="ID_REFRESH_OBJECT" select="'167'"/>
	<xsl:variable name="ID_SET_SCRIPT_ANIMATION" select="'168'"/>
	<xsl:variable name="ID_CLOSE_POPOVER" select="'169'"/>
	<xsl:variable name="ID_UPLOAD_TO_FILEMAKER_SERVER" select="'172'"/>
	<!-- ^-Renamed in FM18 -v -->
	<xsl:variable name="ID_OPEN_UPLOAD_TO_HOST" select="'172'"/>
	<xsl:variable name="ID_UNKNOWN_173" select="'173'"/>
	<xsl:variable name="ID_ENABLE_TOUCH_KEYBOARD" select="'174'"/>
	<xsl:variable name="ID_PERFORM_SCRIPT_IN_WEB_VIEWER" select="'175'"/>
	<!-- Obsoleted in FM16: -->
	<xsl:variable name="ID_OBSOLETE_SET_ALLOWED_ORIENTATIONS" select="'176'"/>
	<xsl:variable name="ID_AVPLAYER_PLAY" select="'177'"/>
	<xsl:variable name="ID_AVPLAYER_SET_PLAYBACK_STATE" select="'178'"/>
	<xsl:variable name="ID_AVPLAYER_SET_OPTIONS" select="'179'"/>
	<xsl:variable name="ID_REFRESH_PORTAL" select="'180'"/>
	<xsl:variable name="ID_GET_DIRECTORY" select="'181'"/>
	<!-- ^-Renamed in FM18 -v -->
	<xsl:variable name="ID_GET_FOLDER_PATH" select="'181'"/>
	<xsl:variable name="ID_TRUNCATE_TABLE" select="'182'"/>
	<xsl:variable name="ID_OPEN_LAUNCH_CENTER" select="'183'"/>
	<!-- ^-Renamed in FM17 -v -->
	<xsl:variable name="ID_OPEN_MY_APPS" select="'183'"/>
	<!-- ^-Renamed in FM18 -v -->
	<xsl:variable name="ID_OPEN_FAVORITES" select="'183'"/>
	<xsl:variable name="ID_OPEN_STARTER_SOLUTION" select="'184'"/>
	<xsl:variable name="ID_CONFIGURE_REGION_MONITOR_SCRIPT" select="'185'"/>
	<xsl:variable name="ID_UNKNOWN_EXTERNAL_SCRIPT_STEP_FROM_MISSING_PLUG-IN" select="'186'"/>
	<xsl:variable name="ID_CONFIGURE_LOCAL_NOTIFICATION" select="'187'"/>
	<xsl:variable name="ID_GET_FILE_EXISTS" select="'188'"/>
	<xsl:variable name="ID_GET_FILE_SIZE" select="'189'"/>
	<xsl:variable name="ID_CREATE_DATA_FILE" select="'190'"/>
	<xsl:variable name="ID_OPEN_DATA_FILE" select="'191'"/>
	<xsl:variable name="ID_WRITE_TO_DATA_FILE" select="'192'"/>
	<xsl:variable name="ID_READ_FROM_DATA_FILE" select="'193'"/>
	<xsl:variable name="ID_GET_DATA_FILE_POSITION" select="'194'"/>
	<xsl:variable name="ID_SET_DATA_FILE_POSITION" select="'195'"/>
	<xsl:variable name="ID_CLOSE_DATA_FILE" select="'196'"/>
	<xsl:variable name="ID_DELETE_FILE" select="'197'"/>
	<xsl:variable name="ID_UNKNOWN_198" select="'198'"/>
	<xsl:variable name="ID_RENAME_FILE" select="'199'"/>
	<xsl:variable name="ID_SET_ERROR_LOGGING" select="'200'"/>
	<xsl:variable name="ID_CONFIGURE_NFC_READING" select="'201'"/>
	<xsl:variable name="ID_CONFIGURE_MACHINE_LEARNING_MODEL" select="'202'"/>
	<xsl:variable name="ID_EXECUTE_FILEMAKER_DATA_API" select="'203'"/>
	<xsl:variable name="ID_UNKNOWN_204" select="'204'"/>
	<xsl:variable name="ID_OPEN_TRANSACTION" select="'205'"/>
	<xsl:variable name="ID_COMMIT_TRANSACTION" select="'206'"/>
	<xsl:variable name="ID_REVERT_TRANSACTION" select="'207'"/>
	<xsl:variable name="ID_SET_SESSION_IDENTIFIER" select="'208'"/>
	<xsl:variable name="ID_SET_DICTIONARY" select="'209'"/>
	<xsl:variable name="ID_PERFORM_SCRIPT_ON_SERVER_WITH_CALLBACK" select="'210'"/>
	<xsl:variable name="ID_TRIGGER_CLARIS_CONNECT_FLOW" select="'211'"/>
	<!-- 212 not found -->
	<xsl:variable name="ID_FINE_TUNE_MODEL" select="'213'"/>
	<xsl:variable name="ID_PERFORM_SQL_QUERY_BY_NATURAL_LANGUAGE" select="'214'"/>
	<xsl:variable name="ID_INSERT_EMBEDDING" select="'215'"/>
	<xsl:variable name="ID_INSERT_EMBEDDING_IN_FOUND_SET" select="'216'"/>
	<xsl:variable name="ID_SET_AI_CALL_LOGGING" select="'217'"/>
	<xsl:variable name="ID_PERFORM_SEMANTIC_FIND" select="'218'"/>
	<xsl:variable name="ID_PERFORM_RAG_ACTION" select="'219'"/>
	<xsl:variable name="ID_GENERATE_RESPONSE_FROM_MODEL" select="'220'"/>
	<xsl:variable name="ID_PERFORM_FIND_BY_NATURAL_LANGUAGE" select="'221'"/>
	<xsl:variable name="ID_CONFIGURE_REGRESSION_MODEL" select="'222'"/>
	<!-- 223 not found -->
	<!-- 224 not found -->
	<xsl:variable name="ID_SAVE_RECORDS_AS_JSONL" select="'225'"/>
	<xsl:variable name="ID_CONFIGURE_PROMPT_TEMPLATE" select="'226'"/>
	<xsl:variable name="ID_CONFIGURE_RAG_ACCOUNT" select="'227'"/>
	<xsl:variable name="ID_GO_TO_LIST_OF_RECORDS" select="'228'"/>
	<xsl:variable name="STEP_ID_1" select="'Perform Script'"/>
	<xsl:variable name="STEP_ID_4" select="'Go To Next Field'"/>
	<xsl:variable name="STEP_ID_5" select="'Go To Previous Field'"/>
	<xsl:variable name="STEP_ID_6" select="'Go To Layout'"/>
	<xsl:variable name="STEP_ID_7" select="'New Record Request'"/>
	<xsl:variable name="STEP_ID_8" select="'Duplicate Record Request'"/>
	<xsl:variable name="STEP_ID_9" select="'Delete Record Request'"/>
	<xsl:variable name="STEP_ID_10" select="'Delete All Records'"/>
	<xsl:variable name="STEP_ID_11" select="'Insert From Index'"/>
	<xsl:variable name="STEP_ID_12" select="'Insert From Last Visited'"/>
	<xsl:variable name="STEP_ID_13" select="'Insert Current Date'"/>
	<xsl:variable name="STEP_ID_14" select="'Insert Current Time'"/>
	<xsl:variable name="STEP_ID_16" select="'Go To Record Request page'"/>
	<xsl:variable name="STEP_ID_17" select="'Go To Field'"/>
	<xsl:variable name="STEP_ID_18" select="'Check Selection'"/>
	<xsl:variable name="STEP_ID_19" select="'Check Record'"/>
	<xsl:variable name="STEP_ID_20" select="'Check Found Set'"/>
	<xsl:variable name="STEP_ID_21" select="'Unsort Records'"/>
	<xsl:variable name="STEP_ID_22" select="'Enter Find Mode'"/>
	<xsl:variable name="STEP_ID_23" select="'Show All Records'"/>
	<xsl:variable name="STEP_ID_24" select="'Modify Last Find'"/>
	<xsl:variable name="STEP_ID_25" select="'Omit Record'"/>
	<xsl:variable name="STEP_ID_26" select="'Omit Multiple Records'"/>
	<xsl:variable name="STEP_ID_27" select="'Show Omitted Only'"/>
	<xsl:variable name="STEP_ID_28" select="'Perform Find'"/>
	<xsl:variable name="STEP_ID_29" select="'Show Hide Toolbars'"/>
	<xsl:variable name="STEP_ID_30" select="'View As'"/>
	<xsl:variable name="STEP_ID_31" select="'Adjust Window'"/>
	<xsl:variable name="STEP_ID_32" select="'Open Help'"/>
	<xsl:variable name="STEP_ID_33" select="'Open File'"/>
	<xsl:variable name="STEP_ID_34" select="'Close File'"/>
	<xsl:variable name="STEP_ID_35" select="'Import Records'"/>
	<xsl:variable name="STEP_ID_36" select="'Export Records'"/>
	<xsl:variable name="STEP_ID_37" select="'Save A copy As'"/>
	<xsl:variable name="STEP_ID_38" select="'Open Manage Database'"/>
	<xsl:variable name="STEP_ID_39" select="'Sort Records'"/>
	<xsl:variable name="STEP_ID_40" select="'Relookup Field Contents'"/>
	<xsl:variable name="STEP_ID_41" select="'Enter Preview Mode'"/>
	<xsl:variable name="STEP_ID_42" select="'Print Setup'"/>
	<xsl:variable name="STEP_ID_43" select="'Print'"/>
	<xsl:variable name="STEP_ID_44" select="'Exit Application'"/>
	<xsl:variable name="STEP_ID_45" select="'Undo Redo'"/>
	<xsl:variable name="STEP_ID_46" select="'Cut'"/>
	<xsl:variable name="STEP_ID_47" select="'Copy'"/>
	<xsl:variable name="STEP_ID_48" select="'Paste'"/>
	<xsl:variable name="STEP_ID_49" select="'Clear'"/>
	<xsl:variable name="STEP_ID_50" select="'Select All'"/>
	<xsl:variable name="STEP_ID_51" select="'Revert Record Request'"/>
	<xsl:variable name="STEP_ID_55" select="'Enter Browse Mode'"/>
	<xsl:variable name="STEP_ID_56" select="'Insert Picture'"/>
	<xsl:variable name="STEP_ID_57" select="'Send Event'"/>
	<xsl:variable name="STEP_ID_59" select="'Insert Quicktime'"/>
	<xsl:variable name="STEP_ID_60" select="'Insert Current User Name'"/>
	<xsl:variable name="STEP_ID_61" select="'Insert Text'"/>
	<xsl:variable name="STEP_ID_62" select="'Pause Resume Script'"/>
	<xsl:variable name="STEP_ID_63" select="'Send Mail'"/>
	<xsl:variable name="STEP_ID_64" select="'Send Dde Execute'"/>
	<xsl:variable name="STEP_ID_65" select="'Dial Phone'"/>
	<xsl:variable name="STEP_ID_66" select="'Speak'"/>
	<xsl:variable name="STEP_ID_67" select="'Perform Applescript'"/>
	<xsl:variable name="STEP_ID_68" select="'If'"/>
	<xsl:variable name="STEP_ID_69" select="'Else'"/>
	<xsl:variable name="STEP_ID_70" select="'End If'"/>
	<xsl:variable name="STEP_ID_71" select="'Loop'"/>
	<xsl:variable name="STEP_ID_72" select="'Exit Loop If'"/>
	<xsl:variable name="STEP_ID_73" select="'End Loop'"/>
	<xsl:variable name="STEP_ID_74" select="'Go To Related Record'"/>
	<xsl:variable name="STEP_ID_75" select="'Commit Records Requests'"/>
	<xsl:variable name="STEP_ID_76" select="'Set Field'"/>
	<xsl:variable name="STEP_ID_77" select="'Insert Calculated Result'"/>
	<xsl:variable name="STEP_ID_79" select="'Freeze Window'"/>
	<xsl:variable name="STEP_ID_80" select="'Refresh Window'"/>
	<xsl:variable name="STEP_ID_81" select="'Scroll Window'"/>
	<xsl:variable name="STEP_ID_82" select="'New File'"/>
	<xsl:variable name="STEP_ID_83" select="'Change Password'"/>
	<xsl:variable name="STEP_ID_84" select="'Set Multi-User'"/>
	<xsl:variable name="STEP_ID_85" select="'Allow User Abort'"/>
	<xsl:variable name="STEP_ID_86" select="'Set Error Capture'"/>
	<xsl:variable name="STEP_ID_87" select="'Show Custom Dialog'"/>
	<xsl:variable name="STEP_ID_88" select="'Open Manage Scripts'"/>
	<xsl:variable name="STEP_ID_89" select="'Comment'"/>
	<xsl:variable name="STEP_ID_90" select="'Halt Script'"/>
	<xsl:variable name="STEP_ID_91" select="'Replace Field Contents'"/>
	<xsl:variable name="STEP_ID_92" select="'Show Hide Text Ruler'"/>
	<xsl:variable name="STEP_ID_93" select="'Beep'"/>
	<xsl:variable name="STEP_ID_94" select="'Set Use System Formats'"/>
	<xsl:variable name="STEP_ID_95" select="'Recover File'"/>
	<xsl:variable name="STEP_ID_96" select="'Save A copy As Add on package'"/>
	<xsl:variable name="STEP_ID_97" select="'Set Zoom Level'"/>
	<xsl:variable name="STEP_ID_98" select="'Copy All Records Requests'"/>
	<xsl:variable name="STEP_ID_99" select="'Go To Portal Row'"/>
	<xsl:variable name="STEP_ID_101" select="'Copy Record Request'"/>
	<xsl:variable name="STEP_ID_102" select="'Flush Cache To Disk'"/>
	<xsl:variable name="STEP_ID_103" select="'Exit Script'"/>
	<xsl:variable name="STEP_ID_104" select="'Delete Portal Row'"/>
	<xsl:variable name="STEP_ID_105" select="'Open Preferences'"/>
	<xsl:variable name="STEP_ID_106" select="'Correct Word'"/>
	<xsl:variable name="STEP_ID_107" select="'Spelling Options'"/>
	<xsl:variable name="STEP_ID_108" select="'Select Dictionaries'"/>
	<xsl:variable name="STEP_ID_109" select="'Edit User Dictionary'"/>
	<xsl:variable name="STEP_ID_111" select="'Open Url'"/>
	<xsl:variable name="STEP_ID_112" select="'Open Manage Value Lists'"/>
	<xsl:variable name="STEP_ID_113" select="'Open Sharing'"/>
	<xsl:variable name="STEP_ID_114" select="'Open File Options'"/>
	<xsl:variable name="STEP_ID_115" select="'Allow Formatting Bar'"/>
	<xsl:variable name="STEP_ID_116" select="'Set Next Serial Value'"/>
	<xsl:variable name="STEP_ID_117" select="'Execute Sql'"/>
	<xsl:variable name="STEP_ID_118_FM16" select="'open remote'"/>
	<xsl:variable name="STEP_ID_118" select="'Open Hosts'"/>
	<xsl:variable name="STEP_ID_119" select="'Move Resize Window'"/>
	<xsl:variable name="STEP_ID_120" select="'Arrange All Windows'"/>
	<xsl:variable name="STEP_ID_121" select="'Close Window'"/>
	<xsl:variable name="STEP_ID_122" select="'New Window'"/>
	<xsl:variable name="STEP_ID_123" select="'Select Window'"/>
	<xsl:variable name="STEP_ID_124" select="'Set Window Title'"/>
	<xsl:variable name="STEP_ID_125" select="'Else If'"/>
	<xsl:variable name="STEP_ID_126" select="'Constrain Found Set'"/>
	<xsl:variable name="STEP_ID_127" select="'Extend Found Set'"/>
	<xsl:variable name="STEP_ID_128" select="'Perform Find Replace'"/>
	<xsl:variable name="STEP_ID_129" select="'Open Find Replace'"/>
	<xsl:variable name="STEP_ID_130" select="'Set Selection'"/>
	<xsl:variable name="STEP_ID_131" select="'Insert File'"/>
	<xsl:variable name="STEP_ID_132" select="'Export Field Contents'"/>
	<xsl:variable name="STEP_ID_133" select="'Open Record Request'"/>
	<xsl:variable name="STEP_ID_134" select="'Add Account'"/>
	<xsl:variable name="STEP_ID_135" select="'Delete Account'"/>
	<xsl:variable name="STEP_ID_136" select="'Reset Account Password'"/>
	<xsl:variable name="STEP_ID_137" select="'Enable Account'"/>
	<xsl:variable name="STEP_ID_138" select="'Re-Login'"/>
	<xsl:variable name="STEP_ID_139" select="'Convert File'"/>
	<xsl:variable name="STEP_ID_140" select="'Open Manage Data Sources'"/>
	<xsl:variable name="STEP_ID_141" select="'Set variable'"/>
	<xsl:variable name="STEP_ID_142" select="'Install Menu Set'"/>
	<xsl:variable name="STEP_ID_143" select="'Save Records As Excel'"/>
	<xsl:variable name="STEP_ID_144" select="'Save Records As Pdf'"/>
	<xsl:variable name="STEP_ID_145" select="'Go To Object'"/>
	<xsl:variable name="STEP_ID_146" select="'Set Web Viewer'"/>
	<xsl:variable name="STEP_ID_147" select="'Set Field By Name'"/>
	<xsl:variable name="STEP_ID_148" select="'Install Ontimer Script'"/>
	<xsl:variable name="STEP_ID_149" select="'Open Edit Saved Finds'"/>
	<xsl:variable name="STEP_ID_150" select="'Perform Quick Find'"/>
	<xsl:variable name="STEP_ID_151" select="'Open Manage Layouts'"/>
	<xsl:variable name="STEP_ID_152" select="'Save Records As Snapshot link'"/>
	<xsl:variable name="STEP_ID_154" select="'Sort Records By Field'"/>
	<xsl:variable name="STEP_ID_155" select="'Find Matching Records'"/>
	<xsl:variable name="STEP_ID_156" select="'Open Manage Containers'"/>
	<xsl:variable name="STEP_ID_157" select="'Install Plug-In File'"/>
	<xsl:variable name="STEP_ID_158" select="'Insert Pdf'"/>
	<xsl:variable name="STEP_ID_159" select="'Insert Audio Video'"/>
	<xsl:variable name="STEP_ID_160" select="'Insert From Url'"/>
	<xsl:variable name="STEP_ID_161" select="'Insert From Device'"/>
	<xsl:variable name="STEP_ID_164" select="'Perform Script On Server'"/>
	<xsl:variable name="STEP_ID_165" select="'Open Manage Themes'"/>
	<xsl:variable name="STEP_ID_166" select="'Show Hide Menubar'"/>
	<xsl:variable name="STEP_ID_167" select="'Refresh Object'"/>
	<xsl:variable name="STEP_ID_168" select="'Set Script Animation'"/>
	<xsl:variable name="STEP_ID_169" select="'Close Popover'"/>
	<xsl:variable name="STEP_ID_172_ALT" select="'upload to filemaker server'"/>
	<!-- ^-Renamed in FM18 -v -->
	<xsl:variable name="STEP_ID_172" select="'Open Upload To Host'"/>
	<xsl:variable name="STEP_ID_173" select="'Unknown 173'"/>
	<xsl:variable name="STEP_ID_174" select="'Enable Touch Keyboard'"/>
	<xsl:variable name="STEP_ID_175" select="'Perform Script In Web viewer'"/>
	<!-- Obsoleted in FM16: -->
	<xsl:variable name="STEP_ID_176" select="'Obsolete Set Allowed Orientations'"/>
	<xsl:variable name="STEP_ID_177" select="'Avplayer Play'"/>
	<xsl:variable name="STEP_ID_178" select="'Avplayer Set Playback State'"/>
	<xsl:variable name="STEP_ID_179" select="'Avplayer Set Options'"/>
	<xsl:variable name="STEP_ID_180" select="'Refresh Portal'"/>
	<xsl:variable name="STEP_ID_181_FM17" select="'get directory'"/>
	<!-- ^-Renamed in FM18 -v -->
	<xsl:variable name="STEP_ID_181" select="'Get Folder Path'"/>
	<xsl:variable name="STEP_ID_182" select="'Truncate Table'"/>
	<xsl:variable name="STEP_ID_183_FM16" select="'open launch center'"/>
	<!-- ^-Renamed in FM17 -v -->
	<xsl:variable name="STEP_ID_183_FM17" select="'open my apps'"/>
	<!-- ^-Renamed in FM18 -v -->
	<xsl:variable name="STEP_ID_183" select="'Open Favorites'"/>
	<xsl:variable name="STEP_ID_184" select="'Open Starter Solution'"/>
	<xsl:variable name="STEP_ID_185" select="'Configure Region Monitor Script'"/>
	<xsl:variable name="STEP_ID_186" select="'Unknown External Script Step from missing plug-in'"/>
	<xsl:variable name="STEP_ID_187" select="'Configure Local Notification'"/>
	<xsl:variable name="STEP_ID_188" select="'Get File Exists'"/>
	<xsl:variable name="STEP_ID_189" select="'Get File Size'"/>
	<xsl:variable name="STEP_ID_190" select="'Create Data File'"/>
	<xsl:variable name="STEP_ID_191" select="'Open Data File'"/>
	<xsl:variable name="STEP_ID_192" select="'Write To Data File'"/>
	<xsl:variable name="STEP_ID_193" select="'Read From Data File'"/>
	<xsl:variable name="STEP_ID_194" select="'Get Data File Position'"/>
	<xsl:variable name="STEP_ID_195" select="'Set Data File Position'"/>
	<xsl:variable name="STEP_ID_196" select="'Close Data File'"/>
	<xsl:variable name="STEP_ID_197" select="'Delete File'"/>
	<xsl:variable name="STEP_ID_198" select="'Unknown 198'"/>
	<xsl:variable name="STEP_ID_199" select="'Rename File'"/>
	<xsl:variable name="STEP_ID_200" select="'Set Error Logging'"/>
	<xsl:variable name="STEP_ID_201" select="'Configure Nfc Reading'"/>
	<xsl:variable name="STEP_ID_202" select="'Configure Machine Learning Model'"/>
	<xsl:variable name="STEP_ID_203" select="'Execute Filemaker Data Api'"/>
	<xsl:variable name="STEP_ID_204" select="'Unknown 204'"/>
	<xsl:variable name="STEP_ID_205" select="'Open Transaction'"/>
	<xsl:variable name="STEP_ID_206" select="'Commit Transaction'"/>
	<xsl:variable name="STEP_ID_207" select="'Revert Transaction'"/>
	<xsl:variable name="STEP_ID_208" select="'Set Session Identifier'"/>
	<xsl:variable name="STEP_ID_209" select="'Set Dictionary'"/>
	<xsl:variable name="STEP_ID_210" select="'Perform Script On Server with Callback'"/>
	<xsl:variable name="STEP_ID_211" select="'Trigger Claris Connect Flow'"/>
	<!-- 212 not found -->
	<xsl:variable name="STEP_ID_213" select="'Fine-Tune Model'"/>
	<xsl:variable name="STEP_ID_214" select="'Perform SQL Query by Natural Language'"/>
	<xsl:variable name="STEP_ID_215" select="'Insert Embedding'"/>
	<xsl:variable name="STEP_ID_216" select="'Insert Embedding in Found Set'"/>
	<xsl:variable name="STEP_ID_217" select="'Set AI Call Logging'"/>
	<xsl:variable name="STEP_ID_218" select="'Perform Semantic Find'"/>
	<xsl:variable name="STEP_ID_219" select="'Perform RAG Action'"/>
	<xsl:variable name="STEP_ID_220" select="'Generate Response from Model'"/>
	<xsl:variable name="STEP_ID_221" select="'Perform Find by Natural Language'"/>
	<xsl:variable name="STEP_ID_222" select="'Configure Regression Model'"/>
	<!-- 223 not found -->
	<!-- 224 not found -->
	<xsl:variable name="STEP_ID_225" select="'Save Records as JSONL'"/>
	<xsl:variable name="STEP_ID_226" select="'Configure Prompt Template'"/>
	<xsl:variable name="STEP_ID_227" select="'Configure RAG Account'"/>
	<xsl:variable name="STEP_ID_228" select="'Go to List of Records'"/>
</xsl:stylesheet>
