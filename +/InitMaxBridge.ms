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
		
		local server_file = edt_path.text + "tools\MXSPyCOM\\initialize_COM_server.ms"
		local max_file = (getDir #userStartupScripts)+ "\\initialize_COM_server.ms"
		if doesFileExist max_file do deleteFile max_file --if file exists remove it (update purpose)
		copyFile server_file max_file
	)
	on btn_browse pressed  do (
		
		local  notepad_dir = getSavePath caption:"Select Notepad++ Root Folder:" initialDir:edt_path.text
		if notepad_dir != undefined do
		(
			edt_path.text = notepad_dir + "\\"
		)
	)
	on btn_cancel pressed  do (DestroyDialog mcNotepadBridgeDialog)
	on btn_accept pressed  do (
	
		registerBridge()
		messageBox "Notepad++ Bridge was estabilished succecfully!\nPlease Restart Notepad++.\nHave a Good Day!" title:"Micra:"
		DestroyDialog mcNotepadBridgeDialog
	)
	on mcNotepadBridgeDialog open do getNotepadPath()
)
CreateDialog mcNotepadBridgeDialog
