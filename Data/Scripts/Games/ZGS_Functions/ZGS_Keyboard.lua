-- ZGS_Keyboard.lua
gTrackLightEnabled = true
function bulletTimeKey(tkey)
	if time()>=gSpeedResetTime then
		setSceneInfo(IG3D_SPEED, gOldGameSpeed)
		-- toggle freeze time slow mode
		if key(tkey,"n") then
			if getSceneInfo(IG3D_SPEED)==1 then
				setSceneInfo(IG3D_SPEED, 0.1)
				gOldGameSpeed=0.1
			else
				setSceneInfo(IG3D_SPEED, 1)
				gOldGameSpeed=1
			end
		end
	end
end

function stopTimeKey(tkey)
		if key(tkey,"-") then setSceneInfo(IG3D_SPEED, 0.0001) end ;	
	end
	
	
function tabThroughObjects()
	local oldtracked=gTrackedObject
	local ok=false
	setSceneInfo(IG3D_SPEED, 0.0001)
	gSpeedResetTime=time()+0.00015 --reset speed after 5 seconds
		
	while not ok do
		gTrackedObject=gTrackedObject+1
		if gTrackedObject>#gObjects then gTrackedObject=1 end
		if gObjects[gTrackedObject].alive and gObjects[gTrackedObject].team==gTeamSelect then ok=true end
		if gTrackedObject==oldtracked then break end
	end
	
	unselectAllObjects()
	
	if ok then
		gObjects[gTrackedObject].selected=true
		gTrackedPosition.x,gTrackedPosition.y,gTrackedPosition.z=getObjectInfo(gObjects[gTrackedObject].cObj, IG3D_POSITION)
			
		gTrackingLights[gTeamSelect+3][2]=gObjects[gTrackedObject]
			
		
	end

end
	


function trackLightsKey(v)
local  n
local Tlx,Tly,Tlz
if v ~= nil then 
n = tonumber(v) 
else
 n = 0
end
gAr,gAg,gAb,gAa = getLightInfo(1,IG3D_AMBIENT)
gDr,gDg,gDb,gDa = getLightInfo(1,IG3D_DIFFUSE)
gSr,gSg,gSb,gSa = getLightInfo(1,IG3D_SPECULAR)

light_a_R,light_a_G,light_a_B,light_a_A = getLightInfo(4,IG3D_AMBIENT)
	if n ~= 0 then  
	light_a_R = light_a_R + n*passed()
	light_a_G = light_a_G + n*passed()
	light_a_B = light_a_B + n*passed()
	light_a_A = 1
	
	end

	for i=1,#gTrackingLights,1 do
	lightN = gTrackingLights[i][1]
	
		if gTrackingLights[i][2] == nil then
		 Tlx,Tly,Tlz=getLightInfo(lightN,IG3D_POSITION)
		 Tly=1
		else
		obj = gTrackingLights[i][2].cObj
		 Tlx,Tly,Tlz=getObjectInfo(obj, IG3D_POSITION)
		 Tly=Tly+10
		 	
		end
	if light_a_R > gAr then light_a_R = gAr  end
	if light_a_G > gAg  then light_a_G = gAg  end
	if light_a_B > gAb  then light_a_B = gAb  end
	if light_a_R <= 0.0 then light_a_R = 0.0 end
	if light_a_G <= 0.0 then light_a_G = 0.0 end
	if light_a_B <= 0.0 then light_a_B = 0.0 end
         setLightInfo(lightN,IG3D_POSITION,Tlx,Tly,Tlz,1)
		setLightInfo(lightN,IG3D_AMBIENT,light_a_R, light_a_G, light_a_B, light_a_A )
		setLightInfo(lightN,IG3D_DIFFUSE,gDr,gDg,gDb,gDa)
	setLightInfo(lightN,IG3D_SPECULAR,gSr,gSg,gSb,gSa )
	setLightInfo(lightN,IG3D_ENABLED, gTrackLightEnabled) 
	setLightInfo(lightN, IG3D_CONSTANT_ATTENUATION, 1)
	setLightInfo(lightN, IG3D_LINEAR_ATTENUATION, 0)
	setLightInfo(lightN, IG3D_QUADRATIC_ATTENUATION, 0.005816326)
	
	end
	
end


