guns={}
local i,ii,shortname,checkName
for i=1,#gObjects,1 do
	checkName=string.sub(getObjectInfo(gObjects[i].cObj, IG3D_NAME),1,3)
	local shortname = string.sub(checkName, 1,3)
	
	if shortname== "glo" or shortname== "gun" or shortname== "rif" or shortname=="deadly" then
	table.insert(guns, gObjects[i])
	guns[#guns].alive = false 
	guns[#guns].shots= 8 -- has 8 shots by default
	setObjectInfo(gObjects[i].cObj, IG3D_VECTOR_CONSTRAINT, 0,0,0)
	
	--print("gun "..#guns.." = "..getObjectInfo(gObjects[i].cObj, IG3D_NAME))
	--print(getObjectInfo(gObjects[i].cObj, IG3D_NAME))
	end
end
	

function HumansWithGuns()
local i
local n  = 0 
	for i=1,#humans,1 do
	  -- random people with guns
		if  math.random(1,10) >= 8 then
		fullname=getObjectInfo(humans[i].cObj, IG3D_NAME)
		 	checkName = string.sub(fullname,1,5)
		 	    -- re - use gun emitters and guns
			
					for ii=1,#gHumanNames,1 do 
					humanName = string.sub(gHumanNames[ii],1,5)
			
						if humanName == checkName  then 
							if (n+1) == #guns+1 then n = 0 end;
						n = n + 1
						
						humans[i].behaviour = gunned_civilian_behaviour
						humans[i].gunSndEmt = assign_free_sound_emitter()
						setSound_emitterInfo(humans[i].gunSndEmt, IG3D_SAMPLE, "Data/Sounds/colt45.ogg")
						humans[i].gun = guns[n]
						setObjectInfo(guns[n].cObj, IG3D_COLL, false)
						setObjectInfo(guns[n].cObj, IG3D_GRAVITY_MULTIPLIER, 0)
						end
					end	
				end
		end --ifrnd
end
print("# guns=",#guns)