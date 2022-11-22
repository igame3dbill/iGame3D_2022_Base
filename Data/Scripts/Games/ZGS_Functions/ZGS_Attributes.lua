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
    local c,x,y,z,o=lineCollision(prx,pry,prz, prx,pry+10000,prz)
    if c==0 then
	ds=-1
    else
	ds=vecLength(x-prx, y-pry, z-prz)
	rx=x
	ry=y+0.5*h+0.05
	rz=z
    end
    
    
    local c,x,y,z,o=lineCollision(prx,pry,prz, prx,pry-10000,prz)
    if c~=0 then
	if ds==-1 or vecLength(x-prx,y-pry,z-prz)<ds then
	    rx=x
	    ry=y+0.5*h+0.05
            rz=z
	end
    end

    setObjectInfo(obj.cObj, IG3D_POSITION, rx,ry,rz)
end


function init_object(obj)
if obj==nil then return end
	obj.hearingDistance=30.0
	obj.noise=1.0
	obj.heardFlag=false
	obj.seenFlag=false
	obj.team=0
	obj.behaviour=default_behaviour
	obj.alive=true --this is a living or undead object (ie no item or car)
	obj.house=nil -- true is a house
	obj.vehicle=nil
	obj.anim={name="Stand", vx=0, vy=0, vz=0, link=true}
	obj.oldanimname="murx"
	obj.scareDistance=math.random(10,250)*0.10  --2.5
	obj.meleeDistance=1.0
	obj.farDistance=7.0
	obj.health=100
	obj.meleeInterval=1
	obj.nextMeleeAttack=time()
	obj.freezeTime=nil
	obj.gunInterval=0.4
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
	obj.pace=(math.random(70,100)*0.01)
	obj.locmem={math.random(-150,150),math.random(-150,150)}
	obj.task={id=object_action_walktospot, objInQuestion=obj, x=obj.locmem[1], y=1.0, z=obj.locmem[2]}
	
end


function init_all_objects()
	local i
	for i=#gObjects,1,-1 do	
	
		-- init object values
		init_object(gObjects[i])
		--putObjectOnGround(gObjects[i])
		objName = getObjectInfo(gObjects[i].cObj, IG3D_NAME)
		print(objName)
		if objName ~= nil and objName ~= "nil" then
		checkName = string.sub(objName,1,4)
	    shortObjName = string.sub(gMasterAnimSource, 1,4)
        if checkName == "mcTr" then master = gObjects[i] end
       --- selection box
        if checkName == "sele" then 
        selectionRect = gObjects[i]
        selectionRect.alive=false
	    setObjectInfo(selectionRect.cObj, IG3D_GRAVITY_MULTIPLIER,0) 
	    setObjectInfo(gObjects[i].cObj, IG3D_COLL, false)
        end
        else
        table.remove(gObjects,i)
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
				gObjects[i].hitSndEmt=assign_free_sound_emitter()
				setSound_emitterInfo(gObjects[i].hitSndEmt, IG3D_SAMPLE, "Data/Sounds/bodyhit.ogg")
				setObjectInfo(gObjects[i].cObj, IG3D_BONE_COLL, true)--uh oh
				setObjectInfo(gObjects[i].cObj, IG3D_CAST_SHADOW, gDoShadows, computeLODModelName(gObjects[i])) -- has shadows
	
	
			end
	end
end

