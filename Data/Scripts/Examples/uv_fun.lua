--setSceneInfo(IG3D_ROOT, "/ig3d_mac_xcode/") -- commented out 11-20-2022
a=make(ig3d_object, "square")
setObjectInfo(a, IG3D_POSITION, 0,0,-40)
setObjectInfo(a, IG3D_ROTATION, 90,0,0)
m=get(ig3d_material, a, 1)
setMaterialInfo(m, IG3D_TEXTURE, 1, "Data/Images/blue.png")
ox=0
oy=0
movx=0
movy=0
rot=0
gTime=0

function oceaneffect()
	if time()>gTime then
		gTime=time()+math.random()*2.0
		movx=-1+math.random()*2
		movy=-1+math.random()*2
		omega=-12.5+math.random()*11
	end
	ox=ox+passed()*movx*0.1
	oy=oy+passed()*movy*0.1
	if click("-") then
	omega=15
	end
	rot=rot+omega*passed()
	setMaterialInfo(m, IG3D_UV_TRANSFORMATION, 0,0,rot,1,1,ox,oy)
	if click("-") then
		setMaterialInfo(m, IG3D_UV_TRANSFORMATION, 0,rot,0,1,1,0,0)
	end
end


oldGameFunc=game_func --remember game_func

function myFunction()
--do something
oceaneffect()
if oldGameFunc~=nil then oldGameFunc() end
end

game_func=myFunction