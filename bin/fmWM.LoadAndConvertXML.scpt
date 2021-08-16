(*

DEPRECATED

AppleScript to tell fmWorkmate (RUNTIME version) to load & convert the fmxmlsnippet and activate FleMaker

*)
tell application "fmWorkMate"
	--activate
	set oneMoment to 0.1 -- seconds
	
	do script "Activate fmWorkMate"
	delay oneMoment
	
	do script "Open fmCheckMate"
	delay oneMoment
	
	do script "Load and Convert XML to FM"
	delay oneMoment
	
	do script "Activate FileMaker"
end tell