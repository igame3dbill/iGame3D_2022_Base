--function make_window()
--head
function shaderApplyClicked(w)
	local obj=objNumber:value()
	local m=get(ig3d_material, obj, mtrlNumber:value())
	setMaterialInfo(m, IG3D_SHADER, shaderPath:value())
	setMaterialInfo(m, IG3D_TEXTURE, textureUnit:value(), texturePath:value())
	setSceneInfo(IG3D_SHADER_PARAM, paramNum:value(), param1:value(), param2:value(), param3:value(), param4:value())

end

function shaderParamsLooped()

	setSceneInfo(IG3D_SHADER_PARAM, paramNum:value(), param1:value(), param2:value(), param3:value(), param4:value())
	
	
	x,y,z=getObjectInfo(d, IG3D_POSITION)
	setLightInfo(1, IG3D_POSITION, x,y,z,1)

	setObjectInfo(d, IG3D_VELOCITY, 0,0,0)
	if key("w","-") then
		setObjectInfo(d, IG3D_VELOCITY, 0,0,-15)
	end
	
	if key("s","-") then
		setObjectInfo(d, IG3D_VELOCITY, 0,0,15)
	end
	
	if key("a","-") then
		setObjectInfo(d, IG3D_VELOCITY, -15,0,0)
	end
	
	if key("d","-") then
		setObjectInfo(d, IG3D_VELOCITY, 15,0,0)
	end
	
	if key("r","-") then
		setObjectInfo(d, IG3D_VELOCITY, 0,15,0)
	end
	
	if key("f","-") then
		setObjectInfo(d, IG3D_VELOCITY, 0,-15,0)
	end
	
	
	alt()
end

alt=game_func
--game_func=shaderParamsLooped
do shader_test= fltk:Fl_Double_Window(0,0,0,0,"")
shader_test:label("Shader test")
shader_test:resize(585,151,174,309)
--shader_test:show()
do shaderPath= fltk:Fl_Input(0,0,0,0,"")
shaderPath:label("Shader")
shaderPath:resize(5,20,145,25)
shaderPath:align(5)
shaderPath:textsize(10)
shaderPath:value("Data/Shaders/bump/")
Fl_Group:current(Fl_Group:current():parent())
end

do objNumber= fltk:Fl_Value_Input(0,0,0,0,"")
objNumber:label("Object")
objNumber:resize(5,70,60,25)
objNumber:align(5)
objNumber:minimum(1)
objNumber:maximum(100)
objNumber:step(1)
objNumber:value(1)
Fl_Group:current(Fl_Group:current():parent())
end

do mtrlNumber= fltk:Fl_Value_Input(0,0,0,0,"")
mtrlNumber:label("Material Number")
mtrlNumber:resize(75,70,75,25)
mtrlNumber:labelsize(11)
mtrlNumber:align(5)
mtrlNumber:minimum(1)
mtrlNumber:maximum(100)
mtrlNumber:step(1)
mtrlNumber:value(1)
Fl_Group:current(Fl_Group:current():parent())
end

do paramNum= fltk:Fl_Value_Input(0,0,0,0,"")
paramNum:label("Shader parameter")
paramNum:resize(5,240,25,25)
paramNum:align(5)
paramNum:minimum(1)
paramNum:value(1)
Fl_Group:current(Fl_Group:current():parent())
end

do param1= fltk:Fl_Value_Input(0,0,0,0,"")
param1:resize(50,240,25,25)
Fl_Group:current(Fl_Group:current():parent())
end

do param2= fltk:Fl_Value_Input(0,0,0,0,"")
param2:resize(75,240,25,25)
Fl_Group:current(Fl_Group:current():parent())
end

do param3= fltk:Fl_Value_Input(0,0,0,0,"")
param3:resize(100,240,25,25)
Fl_Group:current(Fl_Group:current():parent())
end

do param4= fltk:Fl_Value_Input(0,0,0,0,"")
param4:resize(125,240,25,25)
Fl_Group:current(Fl_Group:current():parent())
end

do shaderApply= fltk:Fl_Button(0,0,0,0,"")
shaderApply:label("Apply")
shaderApply:callback(shaderApplyClicked)
shaderApply:resize(5,270,90,25)
Fl_Group:current(Fl_Group:current():parent())
end

do texturePath= fltk:Fl_Input(0,0,0,0,"")
texturePath:resize(50,115,100,25)
texturePath:align(5)
texturePath:textsize(10)
texturePath:value("Data/Images/normals.png")
Fl_Group:current(Fl_Group:current():parent())
end

do textureUnit= fltk:Fl_Value_Input(0,0,0,0,"")
textureUnit:label("Texture Unit / Texture")
textureUnit:resize(5,115,40,25)
textureUnit:align(5)
textureUnit:minimum(1)
textureUnit:maximum(8)
textureUnit:step(1)
textureUnit:value(1)
Fl_Group:current(Fl_Group:current():parent())
end
Fl_Group:current(Fl_Group:current():parent())
end

--tail
shader_test:show()
ig3d_RebuildMacMenubar()
--end
