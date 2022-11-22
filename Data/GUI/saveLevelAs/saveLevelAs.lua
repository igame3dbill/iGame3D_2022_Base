--function make_window()
-- askclose
function askclose()
asksaveLevel:hide()
asksaveLevel=nil
end
-- askok
function askok(w)
levelName="Data/Levels/"..w:value()
fastPath=gameroot..levelName

ig3d_CreateDirectory_s(fastPath) --create folder 
--delete(ig3d_scene, true) --clearscene
ig3d_SetLevelName_s(levelName) --set name

--saveLevel(levelName) --savelevel
setSceneInfo(IG3D_LEVEL_MESH,levelName..".wtf")
save_level()
asksaveLevel:hide()
asksaveLevel=nil
end
do asksaveLevel= fltk:Fl_Double_Window(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Please Name and Press Enter")
asksaveLevel:label(gLabelTable[#gLabelTable])
asksaveLevel:callback(wClose)
asksaveLevel:resize(428,357,423,45)
--unknown attribute: non_modal
asksaveLevel:size_range(369,44,369,44)
--asksaveLevel:show()
do Cancel= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Cancel")
Cancel:label(gLabelTable[#gLabelTable])
Cancel:callback(askclose)
Cancel:resize(355,10,55,20)
Cancel:labelsize(11)
end

do LevelName= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Save to New Level Name:")
LevelName:label(gLabelTable[#gLabelTable])
LevelName:callback(askok)
LevelName:resize(135,6,215,24)
LevelName:labelsize(11)
LevelName:when(8)
LevelName:textsize(11)
end
end
asksaveLevel:show()

asksaveLevel:show()
asksaveLevel:x(UIMainTools:x())
asksaveLevel:y(UIMainTools:y()+UIMainTools:h())
--end
Fl:run()
