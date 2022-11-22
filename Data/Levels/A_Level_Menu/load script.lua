-- Begin of auto-script
LockScript = true
-- End of auto-script
if UIMainTools then UIMainTools:hide() end
gameroot=getSceneInfo(IG3D_ROOT)

--default global functions init
--	dofile(gameroot.."Data/Scripts/Default/default_Globals.lua")
	showDefaultTools() --   see Data/Scripts/Default/User_Interface/main_tool_functions.lua
	ig3d_SetMode_i(1) -- 
	TextBox_Levels_Menu()  -- see Data/Scripts/Default//Entity/textBox_functions.lua

game_func = titleWait -- fltk_update
edit_func = default_escapekey
