Global mcNotepadBridgeDialog


rollout mcNotepadBridgeDialog "Notepad++ Bridge MXSPyCOM" width:516 height:76
(
	groupBox 'grp1' "Notepad Root Directory:" pos:[4,4] width:508 height:68 align:#left
	editText 'edt_path' "" pos:[8,20] width:436 height:20 align:#left
	button 'btn_browse' ".." pos:[448,20] width:60 height:20 align:#left
	button 'btn_cancel' "Cancel" pos:[12,44] width:116 height:24 align:#left
	button 'btn_accept' "Install" pos:[392,44] width:116 height:24 align:#left
	local XmlDoc = dotNetObject "System.Xml.XmlDocument"
	fn getNotepadPath = (
		
		local notepad_dir = (getFilenamePath  (getThisScriptFilename()))
		edt_path.text = notepad_dir
	)
	fn registerBridge = (
		
		local MaxUserDir = pathConfig.removePathLeaf (getDir #userMacros)
		local MaxUserSettings = MaxUserDir + "\\Plugin.UserSettings.ini"
		if not (doesFileExist MaxUserSettings) do return false
		local exist = getIniSetting MaxUserSettings "Directories" "Notepad Autorun" != ""
		if exist do return false
		local AutorunDir = edt_path.text + "tools\MXSPyCOM\\autorun\\"
	--format "AutorunDir:%\n" AutorunDir
		if not (doesDirectoryExist AutorunDir) do return false
		setIniSetting MaxUserSettings "Directories" "Notepad Autorun" AutorunDir --append Notepad's++ Autorun dir to 3DsMax
		
		messageBox "Notepad++ Bridge was estabilished succecfully!\nPlease Restart Notepad++.\nHave a Good Day!" title:"Notepad++:"
		DestroyDialog mcNotepadBridgeDialog
	)
	on btn_browse pressed  do (
		
		local  notepad_dir = getSavePath caption:"Select Notepad++ Root Folder:" initialDir:edt_path.text
		if notepad_dir != undefined do
		(
			edt_path.text = notepad_dir + "\\"
		)
	)
	on btn_cancel pressed  do (DestroyDialog mcNotepadBridgeDialog)
	on btn_accept pressed  do registerBridge()
	on mcNotepadBridgeDialog open do getNotepadPath()
)
CreateDialog mcNotepadBridgeDialog
