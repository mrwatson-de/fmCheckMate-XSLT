<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- ===== AUTHOR =====

	(c) Copyright 2023 MrWatson, russell@mrwatson.de All Rights Reserved. 

	===== PURPOSE =====

	XSL-File: _inc/constants.StepIDs.xsl

	Defines script step id constants to make stylesheet coding easier.
	
	===== CHANGES HISTORY =====
	(c) russell@mrwatson.de 2023
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
</xsl:stylesheet>
