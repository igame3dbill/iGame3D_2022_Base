-- ZGS_Collisions
function objectAgainstParticles(obj, bone, emt, x,y,z)
	
	if emt=="Bullets" then
		local bn=get(ig3d_bone, obj.cObj, bone)
		local bnname=getBoneInfo(bn, IG3D_NAME)
		obj.health=obj.health - (100+math.random(20))
		
		
		if obj.blood==false and obj.alive then
			if math.random(4)==1 then bnname="head" end--remove
			if bnname=="head" or bname=="neck" or bname=="neckDummy" then
				
				obj.health=-10
				
				obj.headshot=true
				if math.random(5)==1 then
					bn=get(ig3d_bone, obj.cObj, "head")
					setBoneInfo(bn, IG3D_ENABLED, false)
					setParticle_emitterInfo(bloodParticles2, IG3D_POSITION, getBoneInfo(bn, IG3D_POSITION))
					setParticle_emitterInfo(bloodParticles2, IG3D_ROTATION, -90,0,0)
					setParticle_emitterInfo(bloodParticles2, IG3D_START)
				end
				
			end
		
		
			setSound_emitterInfo(obj.hitSndEmt, IG3D_POSITION, x,y,z)
			setSound_emitterInfo(obj.hitSndEmt, IG3D_START)
			setParticle_emitterInfo(bloodParticles, IG3D_POSITION, x,y,z)
			setParticle_emitterInfo(bloodParticles, IG3D_ROTATION, 0,0,0)
			setParticle_emitterInfo(bloodParticles, IG3D_START)
			
			
			--shot is targeting inside
			
			local dx,dy,dz=getObjectInfo(obj.cObj, IG3D_POSITION)
			dy=y
			local sx=x+(x-dx)
			local sy=y+(y-dy)
			local sz=z+(z-dz)
			
			
			result,x,y,z,u,v,m=getObjectInfo(obj.cObj, IG3D_EXACT_COLLISION_DATA, sx,sy,sz,dx,dy,dz)
			if result then
				drawToTexture( getMaterialInfo(m, IG3D_TEXTURE, 3), "Data/Images/Decals/bloodpencil"..(math.random(1,3))..".png",u,v, IG3D_ADD, IG3D_REPEAT)
				obj.blood=true
			end
			
		
		end
		
		
	end
end

function objectAgainstObject(obj1, bone1, obj2, bone2, x,y,z)
	
	local damage=vecLength(getObjectInfo(obj1.cObj, IG3D_VELOCITY))+vecLength(getObjectInfo(obj2.cObj, IG3D_VELOCITY))*5
	if getObjectInfo(obj1.cObj, IG3D_VEHICLE) and getObjectInfo(obj2.cObj, IG3D_VEHICLE) then
		 --a crash!! kazoom
		 
		if obj1.health>0 and obj2.health>0 then
			obj1.health=obj1.health-damage
			obj2.health=obj2.health-damage
		end
		return
	end
	
	if getObjectInfo(obj1.cObj, IG3D_VEHICLE) then
		if obj1.driver~= nil and not obj2.alive then
			obj1.driver.curDrivingFrame=1
			obj1.driver.startDriving=time()-1
			--local rnd=math.random(#gCrazyDrives)
			--obj1.crazyDrive=gCrazyDrives[rnd]
			obj1.health=obj1.health-damage
			
		end
		if obj2.alive and obj2 ~= obj1.driver and obj1.driver~= nil then
			obj1.health=obj1.health-damage*0.3
			obj2.health=obj2.health-damage
			
			setSound_emitterInfo(obj2.hitSndEmt, IG3D_POSITION, x,y,z)
			setSound_emitterInfo(obj2.hitSndEmt, IG3D_START)
		end
	else
		if getObjectInfo(obj2.cObj, IG3D_VEHICLE) then
			if obj2.driver~= nil and not obj1.alive then
				obj2.driver.curDrivingFrame=1
				obj2.driver.startDriving=time()-1
				--local rnd=math.random(#gCrazyDrives)
				--obj2.crazyDrive=gCrazyDrives[rnd]
				obj2.health=obj2.health-damage
				
			end
			if obj1.alive and obj1 ~= obj2.driver and obj2.driver~= nil then
				obj2.health=obj2.health-damage*0.3
				obj1.health=obj1.health-damage
				setSound_emitterInfo(obj1.hitSndEmt, IG3D_POSITION, x,y,z)
				setSound_emitterInfo(obj1.hitSndEmt, IG3D_START)
			end
		end
	end
end



coll_o_p=objectAgainstParticles
coll_o_o=objectAgainstObject
