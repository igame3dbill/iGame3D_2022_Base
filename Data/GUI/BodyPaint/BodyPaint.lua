--function make_window()
function createWhiteMeshTextures(w)
	local j=1
	local m=get(ig3d_material, -1, j)
	while m ~= nil do
		setMaterialInfo(m, IG3D_TEXTURE, bodypaintUnit:value(), make(ig3d_texture, (os.time()..(j))..".png",512,512))
		setMaterialInfo(m, IG3D_TRANSPARENT, true)
		j=j+1
		m=get(ig3d_material, -1, j)
	end	
end

function loadThePencil(w)
	loadTexture(w:value())

end
do BodyPaint= fltk:Fl_Double_Window(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Body Paint")
BodyPaint:label(gLabelTable[#gLabelTable])
BodyPaint:resize(675,295,371,70)
--BodyPaint:show()
do pencilTexture= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Pencil texture")
pencilTexture:label(gLabelTable[#gLabelTable])
pencilTexture:callback(loadThePencil)
pencilTexture:resize(100,10,160,25)
pencilTexture:value("Data/Images/Decals/bloodpencil1.png")
loadTexture("Data/Images/Decals/bloodpencil1.png")
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Create white textures for all materials")
widget:label(gLabelTable[#gLabelTable])
widget:callback(createWhiteMeshTextures)
widget:resize(10,40,250,25)
end

do bodypaintUnit= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Texture Unit")
bodypaintUnit:label(gLabelTable[#gLabelTable])
bodypaintUnit:resize(345,10,25,25)
bodypaintUnit:minimum(1)
bodypaintUnit:maximum(8)
bodypaintUnit:step(1)
bodypaintUnit:value(1)
end
end
BodyPaint:show()

bodyPaintOld=game_func

function bodyPaint()
	if click("-") then
		result,x,y,z,u,v,m=getSceneInfo(IG3D_EXACT_COLLISION_DATA, getSceneInfo(IG3D_MOUSE_LINE))
		if result then
			drawToTexture( getMaterialInfo(m, IG3D_TEXTURE, bodypaintUnit:value()), pencilTexture:value(),u,v, IG3D_ADD, IG3D_CLAMP)
		end
	end
	bodyPaintOld()
end

game_func=bodyPaint

BodyPaint:show()


setLightInfo(1, IG3D_POSITION, 0,0,15,1)
--end
Fl:run()
