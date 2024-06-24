UpdateCheck: ;;;;;;; Update the version number on each new release ;;;;;;;;;;;;;
IfNotExist texter.ini 
{
	MsgBox,4,Check for Updates?,Would you like to automatically check for updates when on startup?
	IfMsgBox,Yes
		updatereply = 1
	else
		updatereply = 0
}
update := GetValFromIni("Preferences","UpdateCheck",updatereply)
IniWrite,%Version%,texter.ini,Preferences,Version
if (update = 1)
	SetTimer,RunUpdateCheck,10000
return

RunUpdateCheck:
update("texter")
return

update(program) {
	SetTimer, RunUpdateCheck, Off
	UrlDownloadToFile,http://svn.adampash.com/%program%/CurrentVersion.txt,VersionCheck.txt
	if ErrorLevel = 0
	{
		FileReadLine, Latest, VersionCheck.txt,1
		IniRead,Current,%program%.ini,Preferences,Version
		;MsgBox,Latest: %Latest% `n Current: %Current%
		FileDelete,VersionCheck.txt ;; delete version check
	}
}
