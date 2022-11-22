matox=0
matoy=0
matmovx=0
matmovy=0
matrot=0
gTime=0

function oceaneffect(m)
	if time()>gTime then
		gTime=time()+math.random()*2.0
		matmovx=-1+math.random()*2
		matmovy=-1+math.random()*2
		omega=-7.5+math.random()*15
	end
	matox=matox+passed()*matmovx
	matoy=matoy+passed()*matmovy
	if click("-") then
	omega=15
	end
	matrot=matrot+omega*passed()
	setMaterialInfo(m, IG3D_UV_TRANSFORMATION, 0,0,matrot,1,1,matox,matoy)
	if click("-") then
		setMaterialInfo(m, IG3D_UV_TRANSFORMATION, 0,matrot,0,1,1,0,0)
	end
end





-----Mesh Editor Material Functions
-- material-related callbacks and functions
function listMaterials()
	meshMaterials:clear()
     	local lst=ig3d_GetMeshMaterialsList__s()
	
	for w in string.gmatch(lst, "[^\n]+") do
		meshMaterials:add(w)
     	end
     	
     
end
---------------------
function selectMaterialMesh()
	local i=meshMaterials:value()
	if i> 0 then
		ig3d_SelectMeshOfMaterial_i(i)
	end
end
---------------------
function materialattacher()
	local i=meshMaterials:value()
	if i> 0 then
		ig3d_SetMaterialForSelectedMesh_i(i)
	end
end
---------------------
function materialmaker()
	local i=meshMaterials:value()
	ig3d_TellFocus_b(true)
	local mname=fltk.fl_input("Please enter a name for the new material", "NewMaterial")
	if mname~=nil then
		ig3d_CreateMaterial_s(mname)
		listMaterials()
		meshMaterials:value(i)
	end
end
---------------------
function renameMaterial()
	local i=meshMaterials:value()
	if i> 0 then
		ig3d_TellFocus_b(true)
		local mname=fltk.fl_input("Please enter a new name for the material", meshMaterials:text(i))
		if mname~=nil then
			ig3d_SetMeshMaterialName_is(i, mname)
			listMaterials()
			meshMaterials:value(i)
		end
	end
end
---------------------
function clearMaterial()
	local i=meshMaterials:value()
	if i> 0 then
		ig3d_DeleteMaterial_i(i)
		listMaterials()
	end
end
---------------------
function setupmatsettingschooser()
	matsetting:clear()
	matsetting:add("COLOR")
	matsetting:add("AMBIENT")
	matsetting:add("DIFFUSE")
	matsetting:add("SPECULAR")
	matsetting:add("EMISSION")
	matsetting:add("SHININESS")
	matsetting:add("DEPTH")
	matsetting:add("WIRE")
	matsetting:add("SMOOTH")
	matsetting:add("TRANSPARENT")
	matsetting:add("LUX")
	matsetting:add("SHADER")
	matsetting:add("TEXTURE 1")
	matsetting:add("TEXTURE 2")
	matsetting:add("TEXTURE 3")
	matsetting:add("TEXTURE 4")
	matsetting:add("TEXTURE 5")
	matsetting:add("TEXTURE 6")
	matsetting:add("TEXTURE 7")
	matsetting:add("TEXTURE 8")
end
---------------------
function booleanToInt(b)
	if b==true then return 1 else return 0 end
end
---------------------
function intToBoolean(i)
	if i==1 then return true else return false end
end
---------------------
function matsettingChosen(w)

	beep()
	local i=w:value()
	
	matred:hide()
	matgreen:hide()
	matblue:hide()
	matalpha:hide()
	matpath:hide()
	matbool:hide()
	matred:label("R")
	matbool:label("Smooth")
	
	if i>10 then
		matpath:show()
	else
		if i>7 then
			matbool:show()
			if i==9 then
				matbool:label("Transparent")
			end
			if i==10 then
				matbool:label("Self-illuminating")
			end
		else
			matred:show()
			if i<5 then
				matgreen:show()
				matblue:show()
				matalpha:show()
			end
			if i==5 then
				matred:label("Shininess value")
			end
			if i==6 then
				matred:label("Depth value")
			end
			
			if i==7 then
				matred:label("Wire size")
			end
		end
	end
	
	local j=meshMaterials:value()
	if j<1 then return end
	
	local r=0
	local g=0
	local b=0
	local a=0
	local bl=false
	local s=""
	
	local m=get(ig3d_material, -1, j)
	if i==0 then r,g,b,a=getMaterialInfo(m, IG3D_COLOR)
	elseif i == 1 then r,g,b,a=getMaterialInfo(m, IG3D_AMBIENT)
	elseif i == 2 then r,g,b,a=getMaterialInfo(m, IG3D_DIFFUSE)
	elseif i == 3 then r,g,b,a=getMaterialInfo(m, IG3D_SPECULAR)
	elseif i == 4 then r,g,b,a=getMaterialInfo(m, IG3D_EMISSION)
	elseif i == 5 then r=getMaterialInfo(m, IG3D_SHININESS)
	elseif i == 6 then r=getMaterialInfo(m, IG3D_DEPTH)
	elseif i == 7 then r=getMaterialInfo(m, IG3D_WIRE)
	elseif i == 8 then bl=getMaterialInfo(m, IG3D_SMOOTH)
	elseif i == 9 then bl=getMaterialInfo(m, IG3D_TRANSPARENT)
	elseif i == 10 then bl=getMaterialInfo(m, IG3D_LUX)
	elseif i == 11 then s=getMaterialInfo(m, IG3D_SHADER)
	elseif i > 11 then s=getMaterialInfo(m, IG3D_TEXTURE, i-11)

	end
	
	if s==nil then s="" end
	matred:value(r)
	matgreen:value(g)
	matblue:value(b)
	matalpha:value(a)
	matbool:value(booleanToInt(bl))
	matpath:value(s)
	
	--print(r,g,b,a,bl,s)
end
---------------------
function matsettingChange(w)
	ig3d_TellFocus_b(true)
	if Fl:event_key() ~= fltk.FL_Enter and Fl:event_key() ~= fltk.FL_KP_Enter and w~= matbool then return end

	local i=matsetting:value()
	
	local j=meshMaterials:value()
	if j<1 then return end
	
	local r=matred:value()
	local g=matgreen:value()
	local b=matblue:value()
	local a=matalpha:value()
	local bl=intToBoolean(matbool:value())
	local s=matpath:value()
	
	if s=="" then s=nil end
	
	local m=get(ig3d_material, -1, j)
	if i==0 then setMaterialInfo(m, IG3D_COLOR, r,g,b,a)
	elseif i == 1 then setMaterialInfo(m, IG3D_AMBIENT, r,g,b,a)
	elseif i == 2 then setMaterialInfo(m, IG3D_DIFFUSE, r,g,b,a)
	elseif i == 3 then setMaterialInfo(m, IG3D_SPECULAR, r,g,b,a)
	elseif i == 4 then setMaterialInfo(m, IG3D_EMISSION, r,g,b,a)
	elseif i == 5 then setMaterialInfo(m, IG3D_SHININESS,r)
	elseif i == 6 then setMaterialInfo(m, IG3D_DEPTH,r)
	elseif i == 7 then setMaterialInfo(m, IG3D_WIRE,r)
	elseif i == 8 then ig3d_MakeMeshSmoothShaded_b(bl);setMaterialInfo(m, IG3D_SMOOTH, bl);
	elseif i == 9 then setMaterialInfo(m, IG3D_TRANSPARENT, bl)
	elseif i == 10 then setMaterialInfo(m, IG3D_LUX, bl)
	elseif i == 11 then setMaterialInfo(m, IG3D_SHADER, s)
	elseif i > 11 then setMaterialInfo(m, IG3D_TEXTURE, i-11, s)

	end
	
	
end
---------------------
function meshMaterialsClicked()
	matsettingChosen(matsetting)
end
---------------------

---- callbacks above current to fluid 08 20 2008
