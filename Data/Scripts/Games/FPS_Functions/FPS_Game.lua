--FPS game
gLastClick=0
gDoubleClickInterval=0.4
gStatusString=""
gCameraSpeed=5
gVelocityClamp=1.16
	
	function normalized(x,y,z)
local l=math.sqrt(x*x+y*y+z*z)
if l==0 then l=1 end
return x/l,y/l,z/l
end

if gNativeOS =="iphone" then
	setSceneInfo(IG3D_MOUSE_VIEW, false, 1)
else
	setSceneInfo(IG3D_MOUSE_VIEW, true, 1)
end


function handle_FPS()
	if not first then
		local dx,dy=getSceneInfo(IG3D_MOUSE_DELTA)
		xa=xa+dy
		ya=ya-dx
		setCameraInfo(IG3D_ROTATION, xa,ya,za)
	end	
	for i=1,#gObjects,1 do
		if gObjects[i].becomeDoll then
			setObjectInfo(gObjects[i].cObj, IG3D_RAGDOLL,true)		
			gObjects[i].becomeDoll=false
			gObjects[i].dedoll=time()+6			
		end	
		--if gObjects[i].hit and gObjects[i].dedoll<= time() then
		--end
	end
	a11,a12,a13,a14,a21,a22,a23,a24,a31,a32,a33,a34,a41,a42,a43,a44=getCameraInfo(IG3D_ROTATION_MATRIX)
	x=0
	y=0
	z=0
	forw={a31,a32,a33}
	forw[2]=0
	forw[1],forw[2],forw[3]=normalized(forw[1],forw[2],forw[3])
	
	if key(" ","n") then
		loadLevel("Data/Levels/Simple/FPS")
	end
	
	if key("w","-") then
		x=x+forw[1]
		y=y+forw[2]
		z=z+forw[3]
	end
	
	if key("s","-") then
		x=x-forw[1]
		y=y-forw[2]
		z=z-forw[3]
	end
	
	if key("a","-") then
		x=x+a11
		y=y+a12
		z=z+a13
	end
	
	if key("d","-") then
		x=x-a11
		y=y-a12
		z=z-a13
	end
	dx,dy,dz=getObjectInfo(playerBox, IG3D_VELOCITY)
	if vecLength(dx,dy,dz)>gVelocityClamp then
		x=0
		y=0
		z=0
	end
	setObjectInfo(playerBox, IG3D_FORCE, x*gCameraSpeed-0.2*gCameraSpeed*dx, y*gCameraSpeed-0.2*gCameraSpeed*dy, z*gCameraSpeed-0.2*gCameraSpeed*dz)
	x,y,z=getObjectInfo(playerBox, IG3D_POSITION)
	y=y+0.65
	setCameraInfo(IG3D_POSITION, x,y,z)
	setParticle_emitterInfo(FPSgun, IG3D_POSITION, x,y,z)
	setParticle_emitterInfo(FPSgun, IG3D_ROTATION, getCameraInfo(IG3D_ROTATION))
	if click("n") then
		setParticle_emitterInfo(FPSgun, IG3D_START)
		if playerGunSound then
			setSound_emitterInfo(playerGunSound, IG3D_POSITION, x,y,z)
			setSound_emitterInfo(playerGunSound, IG3D_LOOP, true)
			setSound_emitterInfo(playerGunSound, IG3D_START)
		end
	end
	if click("o") then
		setParticle_emitterInfo(FPSgun, IG3D_STOP)
		if playerGunSound then
			setSound_emitterInfo(playerGunSound, IG3D_LOOP,false)
		end
	end		
	setSceneInfo(IG3D_MOUSE_VIEW, true, 1)
	default_escapekey()
	first=false	
	for i=1,#gObjects,1 do
		gObjects[i].blood=false
	end
	setLightInfo(1, IG3D_POSITION, x,y+2,z,1)
	setLightInfo(1, IG3D_CONSTANT_ATTENUATION, 1)
	setLightInfo(1, IG3D_LINEAR_ATTENUATION, 0)
	setLightInfo(1, IG3D_QUADRATIC_ATTENUATION, 0.000816326)
	setLightInfo(2, IG3D_POSITION, 150,150,150,0)--for the shadows
	handle_FPSAI()  -- lets find the objects first, where'd they go?
	
end

function objpart(obj, bone, emitter, x,y,z)
	if obj.blood==false then
		--[[
		local sx,sy,sz=getParticle_emitterInfo(get(ig3d_particle_emitter, emitter), IG3D_POSITION)
		dx=sx+(x-sx)*2
		dy=sy+(y-sy)*2
		dz=sz+(z-sz)*2
		
		result,x,y,z,u,v,m=getObjectInfo(obj.cObj, IG3D_EXACT_COLLISION_DATA, sx,sy,sz,dx,dy,dz)
		--]]
		local ox,oy,oz=getObjectInfo(obj.cObj, IG3D_POSITION)
		--local ox,oy,oz=getBoneInfo(get(ig3d_bone, obj.cObj, bone), IG3D_POSITION)
			--dy=y
			local dx,dy,dz
			dx=ox-x
			dy=oy-y
			dz=oz-z
			dx,dy,dz=normalized(dx,dy,dz)
			
			local sx=x-dx
			local sy=y-dy
			local sz=z-dz
			local fx=ox+dx
			local fy=oy+dy
			local fz=oz+dz
			
			
			result,x,y,z,u,v,m=getObjectInfo(obj.cObj, IG3D_EXACT_COLLISION_DATA, sx,sy,sz,fx,fy,fz)
		
		
		if result then
			if obj.hit==false then
				obj.becomeDoll=true
				obj.hit=true
			end
			setSound_emitterInfo(gSoundEmitters[1], IG3D_POSITION, x,y,z)
			setSound_emitterInfo(gSoundEmitters[1], IG3D_START)
			drawToTexture( getMaterialInfo(m, IG3D_TEXTURE, 3), "Data/Images/Decals/bloodpencil"..(math.random(3))..".png",u,v, IG3D_ADD, IG3D_CLAMP)
			obj.blood=true
		else
			--setObjectInfo(obj.cObj, IG3D_VELOCITY, 0,0,0)
			--setObjectInfo(obj.cObj, IG3D_OMEGA,0,0,0)
		end	
	end
	--	handle_FPSAI() crashy and doesn't workt FPS_Game.lua
end


game_func=handle_FPS

coll_o_p=objpart

--Lade die Blutstempel
loadTexture("Data/Images/Decals/bloodpencil1.png")
loadTexture("Data/Images/Decals/bloodpencil2.png")
loadTexture("Data/Images/Decals/bloodpencil3.png")

--Gebe jedem Material in jedem Objekt eine neue Textur
for i=1,#gObjects,1 do
	j=1
	m=get(ig3d_material, gObjects[i].cObj, j)
	while m ~= nil do
		if getSceneInfo(IG3D_FRAGMENT_SHADER_SUPPORTED)==false then
			--no bumppass shader and no normal map in texture unit 2
			setMaterialInfo(m, IG3D_SHADER, nil)
			setMaterialInfo(m, IG3D_TEXTURE, 2, nil)
		end
		setMaterialInfo(m, IG3D_TEXTURE, 3, make(ig3d_texture, getObjectInfo(gObjects[i].cObj, IG3D_NAME)..(os.time()).."tempblood"..(j)..".png",64,64))
		
		j=j+1
		m=get(ig3d_material, gObjects[i].cObj, j)
	end	
end

--setObjectInfo(gObjects[1].cObj, IG3D_ANIMATION, "LookAround", 0, true)--SitAndWait
--setObjectInfo(gObjects[3].cObj, IG3D_ANIMATION, "SitAndWait", 0, true)
--setObjectInfo(gObjects[4].cObj, IG3D_ANIMATION, "LookAround", 0, true)
--setObjectInfo(gObjects[5].cObj, IG3D_ANIMATION, "SitAndWait", 0, true)
--setObjectInfo(gObjects[6].cObj, IG3D_ANIMATION, "LookAround", 0, true)
--setObjectInfo(gObjects[7].cObj, IG3D_ANIMATION, "LookAround", 0, true)

--setObjectInfo(gObjects[3].cObj, IG3D_CAST_SHADOW, true)
--setObjectInfo(gObjects[1].cObj, IG3D_CAST_SHADOW, true, "Characters/mrchief2.wtf")--1
--setObjectInfo(gObjects[6].cObj, IG3D_CAST_SHADOW, true, "Characters/jacky2.wtf")--1

setSceneInfo(IG3D_RECEIVE_SHADOW, true)
