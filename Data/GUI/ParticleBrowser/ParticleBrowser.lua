--function make_window()
do ParticleBrowser= fltk:Fl_Double_Window(0,0,0,0,"")
ParticleBrowser:callback(wClose)
ParticleBrowser:resize(63,178,363,368)
ParticleBrowser:color(40)
ParticleBrowser:labelsize(10)
--ParticleBrowser:show()
do ParticlesMenu= fltk:Fl_Menu_Bar(0,0,0,0,"")
menudir0=""
ParticlesMenu:callback(particles_menu_callback)
ParticlesMenu:resize(-2,0,371,22)
ParticlesMenu:color(38)
ParticlesMenu:labelsize(10)
ParticlesMenu:textsize(10)
Fl_Group:current(Fl_Group:current():parent())
end

do EmitterValueGroup= fltk:Fl_Group(0,0,0,0,"")
EmitterValueGroup:resize(148,38,211,277)
do CurValBrowser= fltk:Fl_Browser(0,0,0,0,"")
CurValBrowser:resize(148,38,210,276)
CurValBrowser:type(3)
CurValBrowser:color(50)
CurValBrowser:labelsize(10)
CurValBrowser:when(4)
CurValBrowser:textsize(10)
end

do ValueListBrowser= fltk:Fl_Browser(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Values:")
ValueListBrowser:label(gLabelTable[#gLabelTable])
ValueListBrowser:callback(ValueListCallback)
ValueListBrowser:resize(149,38,210,276)
ValueListBrowser:type(3)
ValueListBrowser:color(50)
ValueListBrowser:labelsize(10)
ValueListBrowser:align(1)
ValueListBrowser:when(4)
ValueListBrowser:textsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do EmitterRootGroup= fltk:Fl_Group(0,0,0,0,"")
EmitterRootGroup:callback(runButton)
EmitterRootGroup:resize(4,39,148,275)
do EmitterListBrowser= fltk:Fl_Browser(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Emitters")
EmitterListBrowser:label(gLabelTable[#gLabelTable])
EmitterListBrowser:callback(emitterListBrowserCallback)
EmitterListBrowser:resize(4,39,74,275)
EmitterListBrowser:type(3)
EmitterListBrowser:color(48)
EmitterListBrowser:labelsize(10)
EmitterListBrowser:align(1)
EmitterListBrowser:when(4)
EmitterListBrowser:textsize(10)
end

do EmitAttListBrowser= fltk:Fl_Browser(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Attributes:")
EmitAttListBrowser:label(gLabelTable[#gLabelTable])
EmitAttListBrowser:callback(EMTAttPicked)
EmitAttListBrowser:resize(76,39,74,275)
EmitAttListBrowser:type(3)
EmitAttListBrowser:color(48)
EmitAttListBrowser:labelsize(10)
EmitAttListBrowser:align(1)
EmitAttListBrowser:when(4)
EmitAttListBrowser:textsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do EmitterSaveAsGroup= fltk:Fl_Group(0,0,0,0,"")
EmitterSaveAsGroup:resize(152,38,205,50)
do SourceNameInput= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Emitter Source File ")
SourceNameInput:label(gLabelTable[#gLabelTable])
SourceNameInput:callback(particleSaveButtonClick)
SourceNameInput:resize(152,38,205,25)
SourceNameInput:color(50)
SourceNameInput:labelsize(10)
SourceNameInput:align(1)
SourceNameInput:when(8)
SourceNameInput:textsize(10)
end

do PSaveControl= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Save")
PSaveControl:label(gLabelTable[#gLabelTable])
PSaveControl:callback(particleSaveButtonClick)
PSaveControl:resize(307,68,50,20)
PSaveControl:labelsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do EmitterTextureGroup= fltk:Fl_Group(0,0,0,0,"")
EmitterTextureGroup:resize(149,38,208,276)
EmitterTextureGroup:box(fltk.FL_THIN_DOWN_BOX)
do pngPreviewGroup= fltk:Fl_Group(0,0,0,0,"")
pngPreviewGroup:resize(186,175,128,129)
pngPreviewGroup:align(16)
pngPreviewGroup:when(6)
do pngPreviewBox= fltk:Fl_Box(0,0,0,0,"")
pngPreviewBox:callback(pngLoad)
pngPreviewBox:resize(186,175,128,128)
pngPreviewBox:box(fltk.FL_FLAT_BOX)
pngPreviewBox:color(40)
pngPreviewBox:align(16)
end
Fl_Group:current(Fl_Group:current():parent())
end

do pngFileBrowser= fltk:Fl_Browser(0,0,0,0,"")
pngFileBrowser:callback(browserControlClicked)
pngFileBrowser:resize(149,38,208,132)
pngFileBrowser:type(2)
pngFileBrowser:color(48)
pngFileBrowser:labelsize(10)
pngFileBrowser:align(1)
pngFileBrowser:when(3)
pngFileBrowser:textsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do MakeEmitterBtn= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Make")
MakeEmitterBtn:label(gLabelTable[#gLabelTable])
MakeEmitterBtn:callback(MakeEmitter)
MakeEmitterBtn:resize(150,320,205,24)
MakeEmitterBtn:labelsize(10)
end

do EmissionInputGroup= fltk:Fl_Group(0,0,0,0,"")
EmissionInputGroup:resize(5,316,355,44)
EmissionInputGroup:box(fltk.FL_EMBOSSED_BOX)
EmissionInputGroup:color(50)
do NameInput= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Name:")
NameInput:label(gLabelTable[#gLabelTable])
NameInput:callback(RenameEmitter)
NameInput:resize(150,322,205,22)
NameInput:color(50)
NameInput:labelsize(10)
NameInput:textsize(10)
end

do BoolBtn= fltk:Fl_Check_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "button")
BoolBtn:label(gLabelTable[#gLabelTable])
BoolBtn:callback(particleBoolBtnPick)
BoolBtn:resize(125,322,19,23)
BoolBtn:down_box(fltk.FL_DOWN_BOX)
BoolBtn:align(4)
BoolBtn:when(1)
end

do ParticleValInputA= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "x")
ParticleValInputA:label(gLabelTable[#gLabelTable])
ParticleValInputA:callback(valInput)
ParticleValInputA:resize(150,322,46,22)
ParticleValInputA:color(51)
ParticleValInputA:labelsize(12)
ParticleValInputA:align(2)
ParticleValInputA:minimum(-1)
ParticleValInputA:maximum(99)
ParticleValInputA:step(0.1)
ParticleValInputA:textsize(10)
end

do ParticleValInputB= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "y")
ParticleValInputB:label(gLabelTable[#gLabelTable])
ParticleValInputB:callback(valInput)
ParticleValInputB:resize(203,322,46,22)
ParticleValInputB:color(51)
ParticleValInputB:labelsize(12)
ParticleValInputB:align(2)
ParticleValInputB:minimum(-1)
ParticleValInputB:maximum(99)
ParticleValInputB:step(0.1)
ParticleValInputB:textsize(10)
end

do ParticleValInputC= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "z")
ParticleValInputC:label(gLabelTable[#gLabelTable])
ParticleValInputC:callback(valInput)
ParticleValInputC:resize(256,322,46,22)
ParticleValInputC:color(51)
ParticleValInputC:labelsize(12)
ParticleValInputC:align(2)
ParticleValInputC:minimum(-1)
ParticleValInputC:maximum(99)
ParticleValInputC:step(0.1)
ParticleValInputC:textsize(10)
end

do ParticleValInputD= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "a")
ParticleValInputD:label(gLabelTable[#gLabelTable])
ParticleValInputD:callback(valInput)
ParticleValInputD:resize(310,322,46,22)
ParticleValInputD:color(51)
ParticleValInputD:labelsize(12)
ParticleValInputD:align(2)
ParticleValInputD:minimum(-1)
ParticleValInputD:maximum(99)
ParticleValInputD:step(0.1)
ParticleValInputD:textsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do EmitterSourceGroup= fltk:Fl_Group(0,0,0,0,"")
EmitterSourceGroup:resize(147,40,210,274)
do emtFileBrowser= fltk:Fl_Browser(0,0,0,0,"")
emtFileBrowser:callback(emtFileBrowserCallback)
emtFileBrowser:resize(149,40,208,274)
emtFileBrowser:type(2)
emtFileBrowser:labelsize(10)
emtFileBrowser:align(1)
emtFileBrowser:when(1)
emtFileBrowser:textsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end
end
ParticleBrowser:show()

ParticleBrowserShow()
--end
Fl:run()
