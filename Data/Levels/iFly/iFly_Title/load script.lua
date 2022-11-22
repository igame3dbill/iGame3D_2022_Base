

gameroot = getSceneInfo(IG3D_ROOT)

labels={"New Game","Continue","Options","Controls","Exit"}
levels={"iFly/iFly_EnterName","iFly/iFly_Game","iFly/iFly_Options","iFly/iFly_Controls","iFly/iFly_Quit"}
gFontSize=24
gNumBoxes=5
gSelBox=0
clear_textboxes()

TextBox_Labels_Menu()  -- see Data/Scripts/Entity/textBox_functions.lua
game_func=titleWait
edit_func=default_escapekey


