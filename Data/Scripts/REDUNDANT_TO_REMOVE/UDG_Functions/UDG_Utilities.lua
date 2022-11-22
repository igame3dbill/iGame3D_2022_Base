function udg_place_objects_randomly()
if dontPlaceRandomly == true then return end

	if levelmapXY then
		for i=1,#gObjects,1 do
			if gObjects[i]~=crosshair then
				local rndPos = levelmapXY[ math.random(1,#levelmapXY)]
				local xlow,xhigh,ylow,yhigh,zlow,zhigh=getObjectInfo(gObjects[i].cObj, IG3D_BOUNDS)
				
				setObjectInfo(gObjects[i].cObj, IG3D_POSITION, rndPos[1]*2,-ylow,rndPos[2]*2)
			end
		end
		setObjectInfo(playerBox, IG3D_POSITION, getObjectInfo(zombies[1].cObj, IG3D_POSITION))
		setCameraInfo(IG3D_POSITION, getObjectInfo(zombies[1].cObj, IG3D_POSITION))
	end
end

function udg_create_safe_places_randomly()
		gSafePlaces={}
		local cx,cy,cz=getObjectInfo(playerBox, IG3D_POSITION)
		if gNumRowVertices == nil then return end
		if gNumColumnVertices == nil then return end
		local c=0
		while c<30 do
			local rndx=math.random(1, gNumRowVertices)
			local rndz=math.random(1, gNumColumnVertices)
			local y=grid[rndx][rndz][#grid[rndx][rndz]].y
			--only outside floor spots are actually safe
			if y<1 and #grid[rndx][rndz][#grid[rndx][rndz]].scs>3 then--no corners
				if reachableFromPosition(cx,cy,cz, grid[rndx][rndz][#grid[rndx][rndz]].x, cy, grid[rndx][rndz][#grid[rndx][rndz]].z) then
					table.insert(gSafePlaces, {grid[rndx][rndz][#grid[rndx][rndz]].x, grid[rndx][rndz][#grid[rndx][rndz]].y, grid[rndx][rndz][#grid[rndx][rndz]].z})
					c=c+1
				end
			end
		end
	
end


function udg_listLevels()
UDG_LevelsTable={}
udgPath=gameroot.."Data/Levels/UDG/"
folderList=ListFolder(udgPath,"t")
local levelslist=""
	for i,v in pairs(folderList) do 
	listedFiles=listFiles(udgPath ..v)
		for ii,vv in pairs(listedFiles) do
		--print(ii,vv)
		if vv ~= nil then 
			if string.find(vv,"load script.lua") ~= nil then
			local levelshortname = string.sub(v,string.find(v,"UDG_")+4,-1)
			table.insert(UDG_LevelsTable,{"UDG/"..v, levelshortname})
			levelslist=levelslist..levelshortname.."\n"
			break
			end
			end
		end
	end
	return levelslist
end

function udg_object_may_astar(obj)
	if not obj.nextAStarTime or time()>=obj.nextAStarTime then
		obj.nextAStarTime=time()+1
		return true
	end

	return false
end



function udg_EmitAtStart(i)
if string.find(gParticleNamesAndEMTs[i][2], "Furniture") then return true end
 if string.find(gParticleNamesAndEMTs[i][1], "furniture") then return true end
  if string.find(gParticleNamesAndEMTs[i][1], "debris") then return true end
   if string.find(gParticleNamesAndEMTs[i][1], "scenery") then return true end
   if string.find(gParticleNamesAndEMTs[i][1], "snow") then return true end
   if string.find(gParticleNamesAndEMTs[i][1], "barrel") then return true end
   if string.find(gParticleNamesAndEMTs[i][1], "game") then return true end
   if string.find(gParticleNamesAndEMTs[i][1], "door") then return true end
    if string.find(gParticleNamesAndEMTs[i][1], "shelves") then return true end
    if string.find(gParticleNamesAndEMTs[i][1], "blood") then return true end
    if string.find(gParticleNamesAndEMTs[i][1], "oil") then return true end
   if string.find(gParticleNamesAndEMTs[i][1], "smoke") then return true end
  if string.find(gParticleNamesAndEMTs[i][1], "table") then return true end
  if string.find(gParticleNamesAndEMTs[i][1], "misc") then return true end
  if string.find(gParticleNamesAndEMTs[i][1], "chair") then return true end
  if string.find(gParticleNamesAndEMTs[i][1], "crate") then return true end
  if string.find(gParticleNamesAndEMTs[i][1], "office") then return true end
  if string.find(gParticleNamesAndEMTs[i][1], "desk") then return true end
 if string.find(gParticleNamesAndEMTs[i][1], "wall") then return true end
 if string.find(gParticleNamesAndEMTs[i][1], "wood") then return true end
  if string.find(gParticleNamesAndEMTs[i][1], "fence") then return true end
  if string.find(gParticleNamesAndEMTs[i][1], "cube") then return true end

end

function udg_StartUpEmitters()
	--if not gFallbackMode then
		for i=1,#gParticleNamesAndEMTs,1 do
			if udg_EmitAtStart(i) then
				runningParticle = get(ig3d_particle_emitter, i)
				setParticle_emitterInfo(gParticleEmitters[i], IG3D_FORCE, 0,-9.81,0)
				setParticle_emitterInfo(gParticleEmitters[i], IG3D_START)
			end
		end
	--end
end


function getNearestSafePlacePosition(x,y,z)
	local mindist=-1
	local dst
	local i
	local bestIndex=-1
	
	for i=1,#gSafePlaces,1 do
		dst=vecLength(gSafePlaces[i][1]-x, gSafePlaces[i][2]-y, gSafePlaces[i][3]-z)
		if mindist==-1 or dst<mindist then
			mindist=dst
			bestIndex=i
		end
	end
	return gSafePlaces[bestIndex][1],y,gSafePlaces[bestIndex][3]
end
