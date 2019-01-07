
//clear the NppExec console
cls 

//save current selection in temp file
SET temp_file = $(NPP_DIRECTORY)\tools\MXSPyCOM\runMaxscript.ms
SEL_SAVETO $(temp_file) :a

//run current script in 3DsMax (-f show errors) (-s hide errors)
$(NPP_DIRECTORY)\tools\MXSPyCOM\MXSPyCOM.exe -s $(temp_file)
UNSET temp_file