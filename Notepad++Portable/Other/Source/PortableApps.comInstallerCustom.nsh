Var bolInstallerCustomHandleTidy

!macro CustomCodePreInstall
	${If} ${FileExists} "$INSTDIR\Data\settings\config.xml"
		CreateDirectory "$INSTDIR\Data\settings-backup"
		CreateDirectory "$INSTDIR\Data\Config"
		CopyFiles /SILENT "$INSTDIR\Data\settings\*.xml" "$INSTDIR\Data\settings-backup"
		CopyFiles /SILENT "$INSTDIR\Data\settings\*.xml" "$INSTDIR\Data\Config"
		Delete "$INSTDIR\Data\settings\*.xml"
		Rename "$INSTDIR\Data\settings\Notepad++PortableSettings.ini" "$INSTDIR\Data\settings\Notepad++PortableSettings.preserve-ini"
		CopyFiles /SILENT "$INSTDIR\Data\settings\*.ini" "$INSTDIR\Data\settings-backup"
		CopyFiles /SILENT "$INSTDIR\Data\settings\*.ini" "$INSTDIR\Data\Config"
		Delete "$INSTDIR\Data\settings\*.ini"
		Rename "$INSTDIR\Data\settings\Notepad++PortableSettings.preserve-ini" "$INSTDIR\Data\settings\Notepad++PortableSettings.ini"
		CopyFiles /SILENT "$INSTDIR\Data\settings\*.lng" "$INSTDIR\Data\settings-backup"
		CopyFiles /SILENT "$INSTDIR\Data\settings\*.lng" "$INSTDIR\Data\Config"
		Delete "$INSTDIR\Data\settings\*.lng"
		CopyFiles /SILENT "$INSTDIR\Data\settings\*.enc" "$INSTDIR\Data\settings-backup"
		CopyFiles /SILENT "$INSTDIR\Data\settings\*.enc" "$INSTDIR\Data\Config"
		Delete "$INSTDIR\Data\settings\*.enc"		
		Delete "$INSTDIR\App\Notepad++\plugins\tidy"
		StrCpy $bolInstallerCustomHandleTidy true
	${EndIf}
	${If} ${FileExists} "$INSTDIR\App\Notepad++\themes\*.*"
	${AndIfNot} ${FileExists} "$INSTDIR\Data\themes\*.*"
		Rename "$INSTDIR\App\Notepad++\themes" "$INSTDIR\Data\themes"
	${EndIf}
!macroend

!macro CustomCodePostInstall
	${If} $bolInstallerCustomHandleTidy == true
		CreateDirectory "$INSTDIR\Data\Config\plugins\config\tidy"
		CopyFiles /SILENT "$INSTDIR\App\DefaultData\Config\plugins\Config\tidy\*.*" "$INSTDIR\Data\Config\plugins\config\tidy"
	${EndIf}
	RMDir "$INSTDIR\App\Notepad++\plugins\config"
	${If} ${FileExists} "$INSTDIR\Data\Config\plugins\Config\*.*"
		${IfNot} ${FileExists} "$INSTDIR\Data\Config\plugins\Config\Hunspell\*.*"
			CreateDirectory "$INSTDIR\Data\Config\plugins\Config\Hunspell"
			CopyFiles /SILENT "$INSTDIR\App\DefaultData\Config\plugins\Config\Hunspell\*.*" "$INSTDIR\Data\Config\plugins\Config\Hunspell"
		${EndIf}
		${If} ${FileExists} "$INSTDIR\App\DefaultData\Config\plugins\Config\nppPluginList.dll"
			Delete "$INSTDIR\Data\Config\plugins\Config\nppPluginList.dll"
			CopyFiles /SILENT "$INSTDIR\App\DefaultData\Config\plugins\Config\nppPluginList.dll" "$INSTDIR\Data\Config\plugins\Config"
		${EndIf}
	${EndIf}
	${If} ${FileExists} "$INSTDIR\Data\Config\*.*"
	${AndIfNot} ${FileExists} "$INSTDIR\Data\themes\*.*"
		CreateDirectory "$INSTDIR\Data\themes"
		CopyFiles /SILENT "$INSTDIR\App\DefaultData\themes\*.*" "$INSTDIR\Data\themes"
	${EndIf}
!macroend