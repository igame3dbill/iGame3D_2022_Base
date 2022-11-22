function putObjectOnGround(obj)
    local xlow,xhigh, ylow,yhigh, zlow,zhigh= getObjectInfo(obj.cObj, IG3D_BOUNDS)-- determine object bounds
    local h=yhigh-ylow-- determine height
    local ds=-1
    local prx,pry,prz=getObjectInfo(obj.cObj, IG3D_POSITION)
    setObjectInfo(obj.cObj, IG3D_POSITION, prx-1000,pry,prz)-- move object away so that the ray cant collide with it
    local rx=prx
    local ry=pry
    local rz=prz
	

    --cast a ray from object upwards and downwards, position object at nearest collision of the two
    c,x,y,z,o=lineCollision(prx,pry+0.1,prz, prx,pry-100,prz)
    if c==0 then
		ds=-1
		--beep()
    else
		ds=vecLength(x-prx, y-pry, z-prz)
		rx=x
		ry=y-ylow
		rz=z
    end
    
    --[[
    local c,x,y,z,o=lineCollision(prx,pry,prz, prx,pry-10000,prz)
    if c~=0 then
	if ds==-1 then or vecLength(x-prx,y-pry,z-prz)<ds then
	    rx=x
	    ry=y+0.5*h+0.05
        rz=z
	end
    end
	--]]
    setObjectInfo(obj.cObj, IG3D_POSITION, rx,ry,rz)
end

-- Bill added those random factors 012609 trying to make this winnable.

function init_object(obj)
	obj.followPlayer=false
	obj.hearingDistance=math.random(20,30)
	obj.noise=0.0
	obj.heardFlag=false
	obj.seenFlag=false
	obj.team=0
	obj.behaviour=default_behaviour
	
	--01312009 all objects alive at start up causes all objects to have behaviors
	if string.find(ig3d_GetObjectModelPath_s_s(getObjectInfo(obj.cObj, IG3D_NAME)),"Characters") ~= nil then 
	obj.alive=true --this is a living or undead object (ie no item or car)
	else
	obj.alive=false
	end
	
	obj.house=nil -- true is a house
	obj.vehicle=nil --has a car
	obj.isVehicle=false --true -> is a vehicle
	obj.isGun=false
	obj.anim={name="murxomat", vx=0, vy=0, vz=0, link=true}
	obj.oldanimname="murx"
	obj.scareDistance=3
	obj.meleeDistance=1.0
	obj.farDistance=6
	obj.health=100
	obj.meleeInterval=0.9
	obj.nextMeleeAttack=time()
	obj.startEatingTime=time()
	obj.freezeTime=nil
	obj.nextGunAttack=time()
	obj.startDriving=time()
	obj.reanimateTime=time()
	obj.driver = nil -- else is passenger/houseperson1
	obj.occupant = nil -- else is passenger/houseperson2
	obj.mind={}
	obj.blood=false
	obj.headshot=false
	obj.gun=nil
	obj.order=nil
	obj.selected=false
	obj.sensed={}
	obj.targetNum=math.random(1,#gObjects)
	obj.pace=1--(math.random(80,100)*0.01)
	obj.meleeDelay=0.5
	obj.task={id=object_action_idle, objInQuestion=obj, x=0, y=0, z=0}
	obj.deathCount=3--4
	obj.mayStunThisCombat=true
	obj.mayStunAgainTime=time()
	obj.mayRush=true
	obj.numGrenades=0
	obj.nextSoundTime=time()
	obj.decideOnVictimTime=time()
	obj.distPenalty=0
	obj.numBoxesHit=0
	obj.firstBoxHitTime=time()
end


function init_all_objects()
	local i
	for i=1,#gObjects,1 do	
	
		-- init object values
		init_object(gObjects[i])
		
		--quick hack to avoid intersecting object in the start
		local x,y,z=getObjectInfo(gObjects[i].cObj, IG3D_POSITION)--
		setObjectInfo(gObjects[i].cObj, IG3D_POSITION, x,y+3000,z)--
		putObjectOnGround(gObjects[i])
		checkName = string.sub(getObjectInfo(gObjects[i].cObj, IG3D_NAME),1,4)
	    shortObjName = string.sub(gMasterAnimSource, 1,4)
        if checkName == "mcTr" then master = gObjects[i] end
       --- selection box
        if checkName == "sele" then 
        selectionRect = gObjects[i]
        selectionRect.alive=false
	    setObjectInfo(selectionRect.cObj, IG3D_GRAVITY_MULTIPLIER,0) 
	    setObjectInfo(gObjects[i].cObj, IG3D_COLL, false)
	    selectionRect.team=12
        end
        
	end
	if master == nil then master = gObjects[1] end
	
end

function allEntitySoundCollLOD()
-- final entity run through
local i
	for i=1,#gObjects,1 do
		--all objects have gravity
		setObjectInfo(gObjects[i].cObj, IG3D_GRAVITY_MULTIPLIER, 1)
		
			if gObjects[i].alive then
				setObjectInfo(gObjects[i].cObj, IG3D_VECTOR_CONSTRAINT, 0,1,0)
				gObjects[i].noiseSndEmt=assign_free_sound_emitter()
				setSound_emitterInfo(gObjects[i].noiseSndEmt, IG3D_SAMPLE, "Data/Sounds/bodyhit.ogg")
				setObjectInfo(gObjects[i].cObj, IG3D_BONE_COLL, true)--uh oh
				setObjectInfo(gObjects[i].cObj, IG3D_CAST_SHADOW, gDoShadows)--, "Characters/humanoid_shadowlow.wtf")
				--setObjectInfo(gObjects[i].cObj, IG3D_RECEIVE_SHADOW, gDoShadows)
				setObjectInfo(gObjects[i].cObj, IG3D_LOD_MODEL, computeLODModelName(gObjects[i]))
			end
	end
end

