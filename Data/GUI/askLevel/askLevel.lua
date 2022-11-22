--function make_window()
-- askclose
function askclose()
askLevel:hide()
askLevel=nil
end
-- askok
function askok(w)



gameroot=getSceneInfo(IG3D_ROOT)
levelName="Data/Levels/"..w:value()
fastPath=gameroot..levelName
ig3d_CreateDirectory_s(fastPath) --create folder 
delete(ig3d_scene, false) --clearscene
--ig3d_ClearScene_b(true) 


ig3d_SetLevelName_s(levelName) --set name
saveLevel(levelName) --savelevel
game_func=nil
loadLevel(gameroot.."Data/Levels/default")
loadLevel(levelName)



UIMainTools:make_current()
askclose()
end
do askLevel= fltk:Fl_Double_Window(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Please Name and Press Enter")
askLevel:label(gLabelTable[#gLabelTable])
askLevel:callback(wClose)
askLevel:resize(558,428,369,44)
--unknown attribute: modal
--unknown attribute: noborder
askLevel:size_range(369,44,369,44)
--askLevel:show()
do Cancel= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Cancel")
Cancel:label(gLabelTable[#gLabelTable])
Cancel:callback(askclose)
Cancel:resize(290,10,55,20)
Cancel:labelsize(11)
end

do LevelName= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Name:")
LevelName:label(gLabelTable[#gLabelTable])
LevelName:callback(askok)
LevelName:resize(40,9,245,22)
LevelName:labelsize(11)
LevelName:when(8)
LevelName:textsize(11)
end
end
askLevel:show()

askLevel:show()
askLevel:x(UIMainTools:x())
askLevel:y(UIMainTools:y()+UIMainTools:h())
--end
Fl:run()
