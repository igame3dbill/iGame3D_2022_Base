--function make_window()
if gameroot==nil then dofile(getSceneInfo(IG3D_ROOT).."Data/game script.lua") end
resetFunctions()
-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
-- hideAllGroups
function hideAllGroups()
local ax = 10
local ay = 65
bonesgroup:x(ax)
uvmappinggroup:x(ax)
materialsgroup:x(ax)
magicgroup:x(ax)
meshviewgroup:x(ax)

bonesgroup:y(ay)
uvmappinggroup:y(ay)
materialsgroup:y(ay)
magicgroup:y(ay)
Translate:y(ay)
meshviewgroup:y(ay)
bonesgroup:hide()
uvmappinggroup:hide()
materialsgroup:hide()
magicgroup:hide()
pathsgroup:hide()

end
do mesheditor= fltk:Fl_Double_Window(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Mesh Editor")
mesheditor:label(gLabelTable[#gLabelTable])
mesheditor:callback(wClose)
mesheditor:resize(46,187,389,439)
mesheditor:labelsize(10)
Fl_Group:current():resizable(mesheditor)
--mesheditor:show()
do meshMenu= fltk:Fl_Menu_Bar(0,0,0,0,"")
menudir0=""
meshMenu:callback(mesh_menu_callback)
meshMenu:resize(0,-4,425,29)
meshMenu:labelsize(10)
meshMenu:textsize(11)
Fl_Group:current(Fl_Group:current():parent())
end

do mainttoolsgroup= fltk:Fl_Group(0,0,0,0,"")
mainttoolsgroup:resize(0,27,645,29)
do meshtooldropmesh= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "meshtooldropMesh")
meshtooldropmesh:label(gLabelTable[#gLabelTable])
meshtooldropmesh:callback(setMeshTool)
meshtooldropmesh:resize(5,27,26,26)
meshtooldropmesh:labelsize(1)
end

do meshtool1= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "meshtool1")
meshtool1:label(gLabelTable[#gLabelTable])
meshtool1:callback(setMeshTool)
meshtool1:resize(33,27,26,26)
meshtool1:labelsize(1)
end

do meshtool2= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "meshtool2")
meshtool2:label(gLabelTable[#gLabelTable])
meshtool2:callback(setMeshTool)
meshtool2:resize(62,27,26,26)
meshtool2:labelsize(1)
end

do meshtool3= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "meshtool3")
meshtool3:label(gLabelTable[#gLabelTable])
meshtool3:callback(setMeshTool)
meshtool3:resize(90,27,26,26)
meshtool3:labelsize(1)
end

do meshtool4= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "meshtool4")
meshtool4:label(gLabelTable[#gLabelTable])
meshtool4:callback(setMeshTool)
meshtool4:resize(119,27,26,26)
meshtool4:labelsize(1)
end

do meshtool5= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "meshtool5")
meshtool5:label(gLabelTable[#gLabelTable])
meshtool5:callback(setMeshTool)
meshtool5:resize(148,27,26,26)
meshtool5:labelsize(1)
end

do meshtoolbones= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "meshtoolBones")
meshtoolbones:label(gLabelTable[#gLabelTable])
meshtoolbones:callback(setMeshTool)
meshtoolbones:resize(176,27,26,26)
meshtoolbones:labelsize(1)
end

do uvgrouptab= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "UV")
uvgrouptab:label(gLabelTable[#gLabelTable])
uvgrouptab:callback(setMeshTool)
uvgrouptab:resize(205,27,26,26)
uvgrouptab:labelsize(11)
end

do meshtoolmaterials= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Materials")
meshtoolmaterials:label(gLabelTable[#gLabelTable])
meshtoolmaterials:callback(setMeshTool)
meshtoolmaterials:resize(234,27,26,26)
meshtoolmaterials:labelsize(2)
end

do meshtoolmagic= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Magic")
meshtoolmagic:label(gLabelTable[#gLabelTable])
meshtoolmagic:callback(setMeshTool)
meshtoolmagic:resize(262,27,26,26)
meshtoolmagic:labelsize(2)
end

do meshtoolpath= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "meshtoolPath")
meshtoolpath:label(gLabelTable[#gLabelTable])
meshtoolpath:callback(setMeshTool)
meshtoolpath:resize(291,27,26,26)
meshtoolpath:labelsize(1)
end

do meshtool6= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "meshtool6")
meshtool6:label(gLabelTable[#gLabelTable])
meshtool6:callback(setMeshTool)
meshtool6:resize(320,27,26,26)
meshtool6:labelsize(1)
end
Fl_Group:current(Fl_Group:current():parent())
end

do mesheditorrootgrp= fltk:Fl_Group(0,0,0,0,"")
mesheditorrootgrp:resize(5,58,375,370)
mesheditorrootgrp:box(fltk.FL_PLASTIC_DOWN_BOX)
mesheditorrootgrp:labelsize(11)
do Translate= fltk:Fl_Group(0,0,0,0,"")
Translate:resize(5,60,360,118)
Translate:box(fltk.FL_DOWN_BOX)
do xpos= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "x")
xpos:label(gLabelTable[#gLabelTable])
xpos:callback(handlePositionValueFields)
xpos:resize(30,70,60,22)
xpos:type(1)
xpos:labelsize(10)
xpos:align(1)
xpos:textsize(10)
end

do ypos= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "y")
ypos:label(gLabelTable[#gLabelTable])
ypos:callback(handlePositionValueFields)
ypos:resize(90,70,60,22)
ypos:type(1)
ypos:labelsize(10)
ypos:align(1)
ypos:textsize(10)
end

do zpos= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "z")
zpos:label(gLabelTable[#gLabelTable])
zpos:callback(handlePositionValueFields)
zpos:resize(150,70,60,22)
zpos:type(1)
zpos:labelsize(10)
zpos:align(1)
zpos:textsize(10)
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Get")
widget:label(gLabelTable[#gLabelTable])
widget:callback(handleGetButton)
widget:resize(8,71,20,21)
widget:labelsize(9)
end

do xsize= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "x-size")
xsize:label(gLabelTable[#gLabelTable])
xsize:callback(handleScaleValueFields)
xsize:resize(30,103,60,19)
xsize:type(1)
xsize:labelsize(10)
xsize:align(1)
xsize:textsize(10)
end

do ysize= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "y-size")
ysize:label(gLabelTable[#gLabelTable])
ysize:callback(handleScaleValueFields)
ysize:resize(90,103,60,19)
ysize:type(1)
ysize:labelsize(10)
ysize:align(1)
ysize:textsize(10)
end

do zsize= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "z-size")
zsize:label(gLabelTable[#gLabelTable])
zsize:callback(handleScaleValueFields)
zsize:resize(150,103,60,19)
zsize:type(1)
zsize:labelsize(10)
zsize:align(1)
zsize:textsize(10)
end

do MeshAlign= fltk:Fl_Group(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Alignment Size")
MeshAlign:label(gLabelTable[#gLabelTable])
MeshAlign:resize(88,149,277,26)
MeshAlign:labelsize(10)
MeshAlign:align(4)
do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Align")
widget:label(gLabelTable[#gLabelTable])
widget:callback(alignIt)
widget:resize(159,150,50,21)
widget:labelsize(10)
end

do alignSize= fltk:Fl_Value_Input(0,0,0,0,"")
alignSize:resize(90,151,60,19)
alignSize:labelsize(9)
alignSize:maximum(32)
alignSize:step(0.1)
alignSize:value(4)
alignSize:textsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do extrudegroup= fltk:Fl_Group(0,0,0,0,"")
extrudegroup:resize(13,127,203,19)
do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Extrude")
widget:label(gLabelTable[#gLabelTable])
widget:callback(extrudeButtonClicked)
widget:resize(159,127,50,19)
widget:labelsize(10)
end

do extrudeDepth= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Extrude Dist.")
extrudeDepth:label(gLabelTable[#gLabelTable])
extrudeDepth:callback(handleExtrudeValueField)
extrudeDepth:resize(90,127,60,19)
extrudeDepth:labelsize(10)
extrudeDepth:minimum(0.1)
extrudeDepth:maximum(100)
extrudeDepth:step(0.5)
extrudeDepth:value(1)
extrudeDepth:textsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do getsizebutton= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Get")
getsizebutton:label(gLabelTable[#gLabelTable])
getsizebutton:callback(handleGetSizeButton)
getsizebutton:resize(8,102,20,21)
getsizebutton:labelsize(9)
end
Fl_Group:current(Fl_Group:current():parent())
end

do meshviewgroup= fltk:Fl_Group(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "meshviewgroup")
meshviewgroup:label(gLabelTable[#gLabelTable])
meshviewgroup:resize(215,70,145,99)
meshviewgroup:box(fltk.FL_FLAT_BOX)
meshviewgroup:color(51)
meshviewgroup:labeltype(fltk.FL_NO_LABEL)
meshviewgroup:align(0)
do widget= fltk:Fl_Check_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Mesh Z-buffering")
widget:label(gLabelTable[#gLabelTable])
widget:callback(zbufferControlClicked)
widget:resize(225,70,105,19)
widget:down_box(fltk.FL_DOWN_BOX)
widget:labelsize(10)
end

do widget= fltk:Fl_Check_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Backface Culling")
widget:label(gLabelTable[#gLabelTable])
widget:callback(backfaceControlClicked)
widget:resize(225,89,100,16)
widget:down_box(fltk.FL_DOWN_BOX)
widget:labelsize(10)
end

do meshlinewidth= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Line Width")
meshlinewidth:label(gLabelTable[#gLabelTable])
meshlinewidth:callback(handlelinewidth)
meshlinewidth:resize(230,111,70,19)
meshlinewidth:labelsize(9)
meshlinewidth:align(8)
meshlinewidth:maximum(8)
meshlinewidth:step(0.02)
meshlinewidth:value(1)
meshlinewidth:textsize(10)
end

do meshpointwidth= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Point Width")
meshpointwidth:label(gLabelTable[#gLabelTable])
meshpointwidth:callback(handlepointwidth)
meshpointwidth:resize(230,134,70,18)
meshpointwidth:labelsize(9)
meshpointwidth:align(8)
meshpointwidth:maximum(8)
meshpointwidth:step(0.02)
meshpointwidth:value(1)
meshpointwidth:textsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end
Fl_Group:current(Fl_Group:current():parent())
end

do mesheditorsubgrps= fltk:Fl_Group(0,0,0,0,"")
mesheditorsubgrps:resize(-8,183,388,247)
mesheditorsubgrps:labelsize(11)
do magicgroup= fltk:Fl_Group(0,0,0,0,"")
magicgroup:resize(5,189,370,230)
magicgroup:box(fltk.FL_FLAT_BOX)
magicgroup:color(51)
do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Magic")
widget:label(gLabelTable[#gLabelTable])
widget:callback(DoMagic)
widget:resize(183,194,49,225)
widget:labelsize(10)
end

do magicValue= fltk:Fl_Value_Input(0,0,0,0,"")
magicValue:resize(109,194,60,11)
magicValue:labelsize(10)
magicValue:step(0.1)
magicValue:value(1)
magicValue:textsize(10)
end

do magicCyl= fltk:Fl_Check_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Cylindric")
magicCyl:label(gLabelTable[#gLabelTable])
magicCyl:resize(27,194,61,11)
magicCyl:down_box(fltk.FL_DOWN_BOX)
magicCyl:labelsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do bonesgroup= fltk:Fl_Group(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Bones")
bonesgroup:label(gLabelTable[#gLabelTable])
bonesgroup:resize(10,184,365,235)
bonesgroup:box(fltk.FL_FLAT_BOX)
bonesgroup:labelsize(10)
bonesgroup:align(21)
do meshBones= fltk:Fl_Browser(0,0,0,0,"")
meshBones:callback(meshBonesClicked)
meshBones:resize(10,200,135,218)
meshBones:type(2)
meshBones:labelsize(10)
meshBones:align(1)
meshBones:textsize(10)
end

do bonebuttonsgroup= fltk:Fl_Group(0,0,0,0,"")
bonebuttonsgroup:resize(145,198,215,221)
bonebuttonsgroup:box(fltk.FL_DOWN_BOX)
do updatebonelist= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Update list")
updatebonelist:label(gLabelTable[#gLabelTable])
updatebonelist:callback(listBones)
updatebonelist:resize(160,203,190,22)
updatebonelist:labelsize(10)
end

do verticetobone= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Make bone from selected vertex")
verticetobone:label(gLabelTable[#gLabelTable])
verticetobone:callback(bonemaker)
verticetobone:resize(160,233,190,22)
verticetobone:labelsize(10)
end

do attachmeshtobone= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Attach selected mesh to bone")
attachmeshtobone:label(gLabelTable[#gLabelTable])
attachmeshtobone:callback(boneattacher)
attachmeshtobone:resize(160,263,190,22)
attachmeshtobone:labelsize(10)
end

do selectbonemesh= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Select bone mesh")
selectbonemesh:label(gLabelTable[#gLabelTable])
selectbonemesh:callback(selectBoneMesh)
selectbonemesh:resize(160,294,190,22)
selectbonemesh:labelsize(10)
end

do widget= fltk:Fl_Group(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Bone Clustering")
widget:label(gLabelTable[#gLabelTable])
widget:resize(155,356,195,63)
widget:labelsize(10)
do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Set 1x1x1and 0,0,0 and Load Bones")
widget:label(gLabelTable[#gLabelTable])
widget:callback(prepMeshForBones)
widget:resize(160,361,190,24)
widget:labelsize(10)
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Set Auto Bones")
widget:label(gLabelTable[#gLabelTable])
widget:callback(boneMeshCluster)
widget:resize(160,393,190,22)
widget:labelsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end
Fl_Group:current(Fl_Group:current():parent())
end
Fl_Group:current(Fl_Group:current():parent())
end

do uvmappinggroup= fltk:Fl_Group(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "UV Mapping")
uvmappinggroup:label(gLabelTable[#gLabelTable])
uvmappinggroup:resize(10,183,370,232)
uvmappinggroup:box(fltk.FL_FLAT_BOX)
uvmappinggroup:labelsize(10)
uvmappinggroup:align(21)
do matValsgrp= fltk:Fl_Group(0,0,0,0,"")
matValsgrp:resize(205,188,160,167)
matValsgrp:box(fltk.FL_DOWN_BOX)
do uvmapaxis= fltk:Fl_Choice(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Mapping axis")
uvmapaxis:label(gLabelTable[#gLabelTable])
uvmapaxis:resize(210,328,150,21)
uvmapaxis:down_box(fltk.FL_BORDER_BOX)
uvmapaxis:labelsize(10)
uvmapaxis:align(5)
uvmapaxis:textsize(12)
uvmapaxis:add("Adaptive")
uvmapaxis:add("x-axis")
uvmapaxis:add("y-axis");uvmapaxis:add("z-axis");
uvmapaxis:value(0)
end

do uvwidth= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Width")
uvwidth:label(gLabelTable[#gLabelTable])
uvwidth:resize(274,223,70,19)
uvwidth:labelsize(10)
uvwidth:maximum(10000)
uvwidth:value(1)
end

do uvheight= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Height")
uvheight:label(gLabelTable[#gLabelTable])
uvheight:resize(279,245,65,19)
uvheight:labelsize(10)
uvheight:maximum(10000)
uvheight:value(1)
end

do uvrot= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Rotation")
uvrot:label(gLabelTable[#gLabelTable])
uvrot:resize(299,198,45,19)
uvrot:labelsize(10)
end

do uvscaleu= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "uv-factors")
uvscaleu:label(gLabelTable[#gLabelTable])
uvscaleu:resize(279,272,30,19)
uvscaleu:labelsize(10)
uvscaleu:maximum(10000)
uvscaleu:value(1)
uvscaleu:textsize(10)
end

do uvscalev= fltk:Fl_Value_Input(0,0,0,0,"")
uvscalev:resize(309,272,30,19)
uvscalev:labelsize(10)
uvscalev:maximum(10000)
uvscalev:value(1)
uvscalev:textsize(10)
end

do uvoffu= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "uv-offsets")
uvoffu:label(gLabelTable[#gLabelTable])
uvoffu:resize(279,292,30,22)
uvoffu:labelsize(10)
uvoffu:textsize(10)
end

do uvoffv= fltk:Fl_Value_Input(0,0,0,0,"")
uvoffv:resize(309,292,30,22)
uvoffv:labelsize(10)
uvoffv:textsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Match selection once")
widget:label(gLabelTable[#gLabelTable])
widget:callback(uvmatcher)
widget:resize(15,201,150,21)
widget:labelsize(10)
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Apply UV mapping")
widget:label(gLabelTable[#gLabelTable])
widget:callback(applyuvmapping)
widget:resize(210,384,150,21)
widget:labelsize(10)
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Scale UV mapping")
widget:label(gLabelTable[#gLabelTable])
widget:callback(scaleuvmapping)
widget:resize(15,233,150,21)
widget:labelsize(10)
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Offset UV mapping")
widget:label(gLabelTable[#gLabelTable])
widget:callback(offsetuvmapping)
widget:resize(15,264,150,21)
widget:labelsize(10)
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Apply cylindric mapping")
widget:label(gLabelTable[#gLabelTable])
widget:callback(cylindricMappingClicked)
widget:resize(210,359,150,21)
widget:labelsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do pathsgroup= fltk:Fl_Group(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Paths")
pathsgroup:label(gLabelTable[#gLabelTable])
pathsgroup:resize(12,187,363,232)
pathsgroup:box(fltk.FL_FLAT_BOX)
pathsgroup:labelsize(10)
pathsgroup:align(21)
do pathbuttonsgrp= fltk:Fl_Group(0,0,0,0,"")
pathbuttonsgrp:resize(15,198,147,207)
pathbuttonsgrp:box(fltk.FL_DOWN_BOX)
Fl_Group:current():resizable(pathbuttonsgrp)
do updatePathList= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Update list")
updatePathList:label(gLabelTable[#gLabelTable])
updatePathList:callback(listPaths)
updatePathList:resize(22,272,130,22)
updatePathList:labelsize(10)
end

do selectwholepath= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Select Connected")
selectwholepath:label(gLabelTable[#gLabelTable])
selectwholepath:callback(selectWholePath)
selectwholepath:resize(22,323,130,22)
selectwholepath:labelsize(10)
end

do savePathBtn= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Save")
savePathBtn:label(gLabelTable[#gLabelTable])
savePathBtn:callback(savePathClicked)
savePathBtn:resize(22,373,130,22)
savePathBtn:labelsize(10)
end

do loadPathBtn= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Load")
loadPathBtn:label(gLabelTable[#gLabelTable])
loadPathBtn:callback(loadPathClicked)
loadPathBtn:tooltip("Load Path Points")
loadPathBtn:resize(22,345,70,22)
loadPathBtn:labelsize(10)
end

do Newpath= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "New")
Newpath:label(gLabelTable[#gLabelTable])
Newpath:callback(NewPathClicked)
Newpath:tooltip("Insert selected vertice into path")
Newpath:resize(22,345,130,22)
Newpath:labelsize(10)
end

do removepathbtn= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Remove")
removepathbtn:label(gLabelTable[#gLabelTable])
removepathbtn:callback(RemovePathClicked)
removepathbtn:tooltip("Remove Selected Path")
removepathbtn:resize(22,377,130,22)
removepathbtn:labelsize(10)
end

do pathtoolgrp= fltk:Fl_Group(0,0,0,0,"")
pathtoolgrp:resize(15,201,137,67)
pathtoolgrp:labelsize(10)
do addToPath= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "ÐÐ+")
addToPath:label(gLabelTable[#gLabelTable])
addToPath:callback(addPointToPath)
addToPath:tooltip("Add selected vertex to Path")
addToPath:resize(117,237,35,31)
addToPath:labelsize(10)
end

do insertintopath= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Ð+Ð")
insertintopath:label(gLabelTable[#gLabelTable])
insertintopath:callback(insertIntoPath)
insertintopath:tooltip("Insert selected vertice into path")
insertintopath:resize(69,237,35,31)
insertintopath:labelsize(10)
end

do addToPath= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "+ÐÐ")
addToPath:label(gLabelTable[#gLabelTable])
addToPath:callback(addPointToPath)
addToPath:tooltip("Add selected vertex  before Path")
addToPath:resize(22,237,35,31)
addToPath:labelsize(10)
end

do addToPath= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "SÐ-")
addToPath:label(gLabelTable[#gLabelTable])
addToPath:callback(addPointToPath)
addToPath:tooltip("Add selected vertex to Path")
addToPath:resize(22,203,35,31)
addToPath:labelsize(10)
end

do insertintopath= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "ÐE SÊÐ")
insertintopath:label(gLabelTable[#gLabelTable])
insertintopath:callback(insertIntoPath)
insertintopath:tooltip("Insert selected vertice into path")
insertintopath:resize(69,203,35,31)
insertintopath:labelsize(10)
end

do addToPath= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "ÐE")
addToPath:label(gLabelTable[#gLabelTable])
addToPath:callback(addPointToPath)
addToPath:tooltip("Add selected vertex  before Path")
addToPath:resize(117,203,35,31)
addToPath:labelsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end
Fl_Group:current(Fl_Group:current():parent())
end

do pathsbrowsergrp= fltk:Fl_Group(0,0,0,0,"")
pathsbrowsergrp:resize(167,200,190,203)
do pathsBrowser= fltk:Fl_Browser(0,0,0,0,"")
pathsBrowser:callback(pathsBrowserClicked)
pathsBrowser:resize(167,200,185,82)
pathsBrowser:type(2)
pathsBrowser:labelsize(10)
pathsBrowser:align(1)
pathsBrowser:textsize(10)
end

do pathspointsBrowser= fltk:Fl_Browser(0,0,0,0,"")
pathspointsBrowser:callback(pathspointsBrowserClicked)
pathspointsBrowser:resize(167,285,185,118)
pathspointsBrowser:type(2)
pathspointsBrowser:labelsize(10)
pathspointsBrowser:align(1)
pathspointsBrowser:textsize(10)
Fl_Group:current():resizable(pathspointsBrowser)
end
Fl_Group:current(Fl_Group:current():parent())
end
Fl_Group:current(Fl_Group:current():parent())
end

do materialsgroup= fltk:Fl_Group(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Materials")
materialsgroup:label(gLabelTable[#gLabelTable])
materialsgroup:resize(10,191,365,239)
materialsgroup:box(fltk.FL_FLAT_BOX)
materialsgroup:labelsize(10)
materialsgroup:align(5)
Fl_Group:current():resizable(materialsgroup)
do meshMaterials= fltk:Fl_Browser(0,0,0,0,"")
meshMaterials:callback(meshMaterialsClicked)
meshMaterials:resize(15,200,185,156)
meshMaterials:type(2)
meshMaterials:labelsize(10)
meshMaterials:align(1)
meshMaterials:textsize(10)
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "New Material...")
widget:label(gLabelTable[#gLabelTable])
widget:callback(materialmaker)
widget:resize(241,236,125,19)
widget:labelsize(10)
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Set Material To Mesh")
widget:label(gLabelTable[#gLabelTable])
widget:callback(materialattacher)
widget:resize(240,296,125,19)
widget:labelsize(10)
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Update list")
widget:label(gLabelTable[#gLabelTable])
widget:callback(listMaterials)
widget:resize(241,196,125,19)
widget:labelsize(10)
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Select material mesh")
widget:label(gLabelTable[#gLabelTable])
widget:callback(selectMaterialMesh)
widget:resize(241,216,125,19)
widget:labelsize(10)
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Rename Material...")
widget:label(gLabelTable[#gLabelTable])
widget:callback(renameMaterial)
widget:resize(240,256,125,19)
widget:labelsize(10)
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Clear material")
widget:label(gLabelTable[#gLabelTable])
widget:callback(clearMaterial)
widget:resize(240,276,125,19)
widget:labelsize(10)
end

do matsetting= fltk:Fl_Choice(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Material settings")
matsetting:label(gLabelTable[#gLabelTable])
matsetting:callback(matsettingChosen)
matsetting:resize(235,351,125,19)
matsetting:down_box(fltk.FL_BORDER_BOX)
matsetting:labelsize(10)
matsetting:align(5)
matsetting:textsize(12)
setupmatsettingschooser();
matsetting:value(0);
end

do matred= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "R")
matred:label(gLabelTable[#gLabelTable])
matred:callback(matsettingChange)
matred:resize(17,374,55,23)
matred:labelsize(10)
matred:align(5)
matred:when(8)
matred:textsize(9)
end

do matgreen= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "G")
matgreen:label(gLabelTable[#gLabelTable])
matgreen:callback(matsettingChange)
matgreen:resize(72,374,55,23)
matgreen:labelsize(10)
matgreen:align(5)
matgreen:when(8)
matgreen:textsize(9)
end

do matblue= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "B")
matblue:label(gLabelTable[#gLabelTable])
matblue:callback(matsettingChange)
matblue:resize(134,374,55,23)
matblue:labelsize(10)
matblue:align(5)
matblue:when(8)
matblue:textsize(9)
end

do matalpha= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "A")
matalpha:label(gLabelTable[#gLabelTable])
matalpha:callback(matsettingChange)
matalpha:resize(189,374,55,23)
matalpha:labelsize(10)
matalpha:align(5)
matalpha:when(8)
matalpha:textsize(9)
end

do matpath= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Path")
matpath:label(gLabelTable[#gLabelTable])
matpath:callback(matsettingChange)
matpath:resize(17,374,350,23)
matpath:labelsize(10)
matpath:align(5)
matpath:when(8)
matpath:textsize(12)
matpath:hide()
end

do matbool= fltk:Fl_Check_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Smooth")
matbool:label(gLabelTable[#gLabelTable])
matbool:callback(matsettingChange)
matbool:resize(285,411,75,19)
matbool:down_box(fltk.FL_DOWN_BOX)
matbool:labelsize(10)
matbool:hide()
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Combine Equal Materials")
widget:label(gLabelTable[#gLabelTable])
widget:callback(combineEqualMaterialsCB)
widget:resize(240,316,125,19)
widget:labelsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end
Fl_Group:current(Fl_Group:current():parent())
end
end
mesheditor:show()

---- BUTTON ICONS 
fltk.fl_register_images()
local iconPath=gameroot.."Data/Icons/ig3dSetMeshTool/ig3dSetMeshTool"
mtl1 = Fl_Shared_Image.get(iconPath.."1.png")
mtl2 = Fl_Shared_Image.get(iconPath.."2.png")
mtl3 = Fl_Shared_Image.get(iconPath.."3.png")
mtl4 = Fl_Shared_Image.get(iconPath.."4.png")
mtl5 = Fl_Shared_Image.get(iconPath.."5.png")
mtl6 = Fl_Shared_Image.get(iconPath.."6.png")
mtlp = Fl_Shared_Image.get(iconPath.."Path.png")
mtld = Fl_Shared_Image.get(iconPath.."dropMesh.png")
mtlb = Fl_Shared_Image.get(iconPath.."Bones.png")
mtlm  = Fl_Shared_Image.get(iconPath.."Materials.png")
mtlma  = Fl_Shared_Image.get(iconPath.."Magic.png")
--mtlv  = Fl_Shared_Image.get(iconPath.."Views.png")

meshtool1:image(mtl1)
meshtool2:image(mtl2)
meshtool3:image(mtl3)
meshtool4:image(mtl4)
meshtool5:image(mtl5)
meshtool5:image(mtl6)
meshtoolpath:image(mtlp)
meshtooldropmesh:image(mtld)
meshtoolbones:image(mtlb)
meshtoolmaterials:image(mtlm)
meshtoolmagic:image(mtlma)
--meshtoolviews:image(mtlv)

meshtool1:image(mtl1,22,22)
meshtool2:image(mtl2,22,22)
meshtool3:image(mtl3,22,22)
meshtool4:image(mtl4,22,22)
meshtool5:image(mtl5,22,22)
meshtool6:image(mtl6,22,22)
meshtoolpath:image(mtlp,22,22)
meshtooldropmesh:image(mtld,22,22)
meshtoolbones:image(mtlb,22,22)
meshtoolmaterials:image(mtlm,22,22)
meshtoolmagic:image(mtlma,22,22)
--meshtoolviews:image(mtlv,22,22)

meshtool1:redraw()
meshtool2:redraw()
meshtool3:redraw()
meshtool4:redraw()
meshtool5:redraw()
meshtool6:redraw()
meshtoolpath:redraw()
meshtooldropmesh:redraw()
meshtoolbones:redraw()
meshtoolmaterials:redraw()
meshtoolmagic:redraw()
--meshtoolviews:redraw()

meshtool1:when(11)
meshtool2:when(11)
meshtool3:when(11)
meshtool4:when(11)
meshtool5:when(11)
meshtool6:when(11)
meshtoolpath:when(11)
meshtooldropmesh:when(11)
meshtoolbones:when(11)
meshtoolmaterials:when(11)
meshtoolmagic:when(11)
--meshtoolviews:when(11)
--- HANDLE CALL BACKS
extrudeDepth:when(11)	--enter key and changed
xpos:when(11)	--enter key and changed
ypos:when(11)
zpos:when(11)
xsize:when(11)	--enter key and changed
ysize:when(11)
zsize:when(11)
uvwidth:when(11)
uvheight:when(11)
uvrot:when(11)
uvscaleu:when(11)
uvscalev:when(11)
uvoffu:when(11)
uvoffv:when(11)
matred:when(11)
matblue:when(11)
matblue:when(11)
matalpha:when(11)
matpath:when(11)
-- FINAL STEP Mesh Editor GUI
setSceneInfo(IG3D_BACKGROUND_COLOR, 0.65,0.65,0.65)
--ig3d_SetFourViews_b(true)
ig3d_SetMode_i(1)

fill_MeshMenu()
if not UIMainTools then OPEN_UI_WINDOWS("UI_MAIN_TOOLS") end
mH= UIMainTools:x()+UIMainTools:h()+30
mY= UIMainTools:y()

mesheditor:x(mH);
mesheditor:y(mY);

hideAllGroups();
mesheditor:show()

Translate:show();
Fl:scheme("plastic");
mesheditor:make_current();
--end
Fl:run()
