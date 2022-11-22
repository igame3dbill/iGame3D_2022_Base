-- Variables for UI
Q='"'
nc =  math.random(1,255)
newcolor = nc	

CBI=string.char(123)
CBO=string.char(125)

champion="champion"
CHARACTER="CHARACTER"
TEST_PLAYER="TEST_PLAYER"
INV_TORSO="INV_TORSO"
INV_R_HAND="INV_R_HAND"
INV_L_HAND="INV_L_HAND"
INV_LEGS="INV_LEGS"
INV_NECK="INV_NECK"
INV_FEET="INV_FEET"
TEST2_PLAYER="TEST2_PLAYER"
TEST3_PLAYER="TEST3_PLAYER"
TEST4_PLAYER="TEST4_PLAYER"
VARIABLE="VARIABLE"
SOUTH="SOUTH"
NORTH="NORTH"
EAST="EAST"
WEST="WEST"
NORTHWEST="NORTHWEST"
SOUTHWEST="SOUTHWEST"
NORTHEAST="NORTHEAST"
SOUTHEAST="SOUTHEAST"
CENTER="CENTER"
LIMBO="LIMBO"
M_ACTIVATE="M_ACTIVATE"
M_DEACTIVATE="M_DEACTIVATE"
IN_OBJ="IN_OBJ"

tmp=0

local dsbtexthead = "table.insert(dsbtext2map,"..CBI.."1,52,52,0,5,"..CBI
local s=""
local sb=""
for i=1,52,1 do
sb = sb..Q.."0000000000000000000000000000000000000000000000000000"..Q..",\n"
end
bsdtext2MapBaseString = dsbtexthead..string.sub(sb,1,-2)..CBO..CBO..")\n"
newbsdtext2Map = loadstring(bsdtext2MapBaseString)





function listexvars(which)
local s=[[]]
local sb=""
tempb={}
local cn=0
	for i,v in pairs(exvar)  do 
	cn=cn+1
	sb="exvar["..Q..i..Q.."]={  "
	tempa={exvar[i]}
	for ia,av in pairs(tempa) do
		for ib,bv in pairs(av) do
		if lastib =="color" then sb=string.sub(sb,1,-3).."}," end		
			if type(bv) == "table"  then	
				for ic,cv in pairs(bv) do	
				
					if type(cv) == "string" then cv = Q..cv..Q end
						if ib ~= lastib then 
							if ib == "color" then 
							sb=sb..ib.."={"..tostring(cv).." , "
							else
							sb=sb..  ib.."="..tostring(cv).." , "
							end
							lastib=ib	
						else
							sb=sb..tostring(cv).." , "
						end
				end
			else	
			if type(bv) == "string" then bv = Q..bv..Q end
			if ib ~= lastib then 
			sb=sb..  ib.."="..tostring(bv).." , "	
			lastib=ib
			else
			sb=sb..tostring(bv).." , "
			end
			end
		end
	end	
	sb=string.sub(sb,1,-3).."}"
	if  which == cn or which == i then return sb end
	s=s.."\n"..sb
	end
 if which =="*" then return s end
end


function listspawninpack(which)
local s=""
local sb=""
local ws=""
	for i,t in pairs(spawninpack) do
		sb="spawninpack["..i.."]={"		
		for ii,v in pairs(spawninpack[i]) do
		echck=spawninpack[i][1]	
		if ii > 1 then 
				if type(v) == "string" then 
				sout = v
					if string.upper(sout) ~= sout then 
					sout = Q..sout..Q 
	  		    end	
				else
				sout = v
				end
	 		sb=sb..sout..","
	 		end
	 	end 	
	 sb=string.sub(sb,1,-2).."}"
	 ev=listexvars(spawninpack[i][2])
	 if ev ~= nil then  sb=sb.."\n"..ev.."\n" end
	 	if echck == which then ws=ws.."\n"..sb	end
	  s=s.."\n"..sb
	 end 
	  if ws~="" then
	  return ws 
	  end	  
--return s
end

function listChampions()
local s=""
	for i=1,#dsbaddchampion,1 do
		ss="dsbaddchampion["..i.."]={"
		s=s.."\n"..ss
			for ii=1,#dsbaddchampion[i] do
			if type(dsbaddchampion[i][ii]) ~= "table" then
				if type(dsbaddchampion[i][ii]) == "string" then 	
				sout =  dsbaddchampion[i][ii]
				--if string.upper(sout) ~= sout  or string.find(sout," ")~=nil then 
				sout = Q..sout..Q 
				--end
				else
				sout = dsbaddchampion[i][ii]
				end
			end		
			if sout~= nil then s=s..sout.."," end
	 		end
	 s=string.sub(s,1,-2).."}"
	 end	 
	 return s
end

function listdsbtext2map(which)
local s=""
local sb=""
	for i=1,#dsbtext2map,1 do
		ss="dsbtext2map["..i.."]={"
		sb=sb..ss
			for ii=1,#dsbtext2map[i] do
			if type(dsbtext2map[i][ii]) ~= "table" then
				if type(dsbtext2map[i][ii]) == "string" then 	
				sout =  dsbtext2map[i][ii]
				--if string.upper(sout) ~= sout  or string.find(sout," ")~=nil then 
				sout = Q..sout..Q 
				--end
				else
				sout = dsbtext2map[i][ii]
				end
				else
				sob="{\n"
				for n = 1,#dsbtext2map[i][ii],1 do
				 sob=sob..Q.. dsbtext2map[i][ii][n]..Q..",\n"
				end
				sout = string.sub(sob,1,-3).."}"
			end		
			sb=sb..sout..","
	 		end
	 sb=string.sub(sb,1,-2).."}"
	 if which == i then return sb end
	 s=s..sb.."\n"
	 end	 
	 return s
end


function listdspspawn()
local s=""
s=listChampions().."\n"
local sb=""
if not dsbpsawn  then return nil end
	for i=1,#dsbspawn,1 do
		sb="dsbspawn["..i.."]={"
		sp=listspawninpack(i)
			for ii=1,#dsbspawn[i] do
				if type(dsbspawn[i][ii]) == "string" then
				sout =  dsbspawn[i][ii]
				spc=" "
				if string.upper(sout) ~= sout or string.find(sout,spc)~=nil then 
				ev=listexvars(sout)
				sout = Q..dsbspawn[i][ii]..Q 
				end
				else
				sout = dsbspawn[i][ii]
				end
			sb=sb..sout..","
	 		end
	 sb=string.sub(sb,1,-2).."}"
	if ev ~= nil then  sb=sb.."\n\t"..ev.."\n" end
	if sp ~= nil then  sb=sb.."\n\t"..sp.."\n" end
	s=s.."\n"..sb
	 end	 
return s
end

function BSDDungeonSpawnsOut()
	s=listdspspawn()
	if s==nil then return nil end
	gBSDDungeonOutFile = gameroot.."Data/WTF/Dungeons/"..fileShortNameFromPath(gMapFile).."_BSDout.lua"
	f=io.open(gBSDDungeonOutFile,"w")
		if f == nil then return nil end
		f:write(s)
		io.close(f)
		return gBSDDungeonOutFile
	
end




function listSpawnXY()
listSpawnxy={}
spawnindex={}
local sb=""
local s=""
	for i=1,#dsbspawn,1 do
	local sx=dsbspawn[i][3]
	local sy=dsbspawn[i][4]
	local c = string.sub(dsbspawn[i][1],1,1)
	local spawnlevel = tonumber(dsbspawn[i][2])
	if spawnlevel~= nil then 
	spawnlevel = spawnlevel + 1	

			if type(sx) == "string" then
				if string.upper(sx) ~= sx   then sx = Q..sx..Q  end
			end
			if type(sy) == "string" then
				if string.upper(sy) ~= sy   then sy = Q..sy..Q  end
			end	
			
		sb="spawnXY["..i.."]={"..sx..","..sy..",char="..Q..c..Q.." , "..spawnlevel.." }"
		local a = loadstring(sb)
		a()
		if spawnlevel == currentLevel then
		if type(sx)=="number" and type(sy)=="number" then 
		table.insert(spawnindex,i) 
		table.insert(listSpawnxy,{sx,sy,c,spawnlevel,dsbspawn[i][1]})
		table.insert(XYSpawned[sx+1][sy+1],dsbspawn[i][1])
		end
		end
		
		s=s.."\n"..sb
		end
	 end 
return sb
end

function ButtonSpawnXY()
local sb=""
local s=""
spawnbtnListXY={}
listSpawnXY()
if #listSpawnxy < 1 then return end
for i=1,#listSpawnxy,1 do
--print(listSpawnxy[i][1][4])
level =listSpawnxy[i][4]
x,y,c=listSpawnxy[i][1],listSpawnxy[i][2],listSpawnxy[i][3]
if type(x) ~= "number" then return end
if type(y) ~= "number" then return end
if tonumber(level) == currentLevel-1 then
x=x
y=y
c=string.byte(c)
sb=sb..x..","..y..","..c..","..level.."\n"
tbtn="x"..(x).."y"..(y)
		if DungeonMapperWindow ~= nil then
		table.insert(spawnbtnListXY,{x+1,y+1})
		-- used to be btnListXY
		
		act=tbtn..":color("..c..")\n"
		 ColorSpawnButtons=loadstring(act)
		ColorSpawnButtons()
			DungeonMapperWindow:redraw()
		end
end
end
return sb
end


function spawnedgrid()
local s = ""
local si =""
listdspspawn()
sps=listSpawnXY()
makeit=loadstring(sps)
makeit()
	for i=1,52,1 do
	spawngrid[i]={}
	for ii=1,52,1 do
	spawngrid[i][ii]="."
	end
	end
for i=1,#spawnXY,1 do
	sx=tonumber(spawnXY[i][1])
	sy=tonumber(spawnXY[i][2])

	if sx ~= nil and sy ~= nil then 
	if sx > 0 and sy > 0   then 
	spawngrid[sx][sy]=spawnXY[i]["char"] 
	table.insert(spawnindex,{sx,sy})
	si = si..sx..","..sy.."\n"
	end
	end
end

	for i,v in pairs(spawngrid)  do
	for ii,vv in pairs(v) do
	if type(vv) ~= "table" then 
	s=s..vv --spawngrid[i][ii]
	end
	end
	s=s.."\n"
	end
	spawntext = s
	return s
end




function parseText2Map(n)
local sb=""
textArray={}
btnListXY={}
textmapXY={}
btnList={}
quadwalls={}
if n==nil then n=1 end
if n == 0 then n=1 end
local schc=""
y=1
if n > #dsbtext2map then n = #dsbtext2map end
for i = 1,#dsbtext2map[n][6], 1 do
	sc=dsbtext2map[n][6][i]
	sb=sb..sc.."\n"
	--print(sb)
for c=1,string.len(sc),1 do
	--floor
	QFloor = string.sub(sc,c,c) 
	QEast = string.sub(sc,c+1,c+1)
	QWest = string.sub(sc,c-1,c-1)
	schc=schc..QWest 

	table.insert(textArray,QFloor)	
	
	if QFloor ~= "0" then
	
	table.insert(textmapXY,{c,y}) 
 	table.insert(btnListXY,{c,y})
 	xys=(tostring(c)..","..tostring(y))
	table.insert(btnList,xys) 
	-- using quadwalls for roof and floor
 	table.insert(quadwalls,{c,y,"floor"})
 	table.insert(quadwalls,{c,y,"roof"})
	
		QRoof = QFloor
		if i <= #dsbtext2map[n][6] then 
		QSouth = string.sub(dsbtext2map[n][6][i+1],c,c) -- wall faces north
		if QSouth ~= "1" then table.insert(quadwalls,{c,y+1,"north"}) end
		end
		
		if i >= 2 then
		QNorth = string.sub(dsbtext2map[n][6][i-1],c,c) -- wall faces south
		if QNorth ~= "1" then table.insert(quadwalls,{c,y-1,"south"}) end
		end
		--
		

 	-- east and west
 
if c < string.len(sc) and QEast ~= "1" then table.insert(quadwalls,{c,y,"east"}) end
 
 	--West
 	if c>1 and QWest ~= "1" then table.insert(quadwalls,{c,y,"west"}) end
 	-- Border
 		if i == 1 then table.insert(quadwalls,{c,y,"north"}) end
		if c== 1 then table.insert(quadwalls,{c,y,"west"}) end
 	   	if c==string.len(sc) then table.insert(quadwalls,{c,y,"east"}) end
 	 	if i==#dsbtext2map then table.insert(quadwalls,{c,y,"south"}) end 	 		
 end -- if
end  -- c
	
y=y+1
end  -- i
--for i=1,#quadwalls,1 do print(quadwalls[i][2]) end
	act="DungeonMapperWindow:make_current()\n"
	for i=1,#textmapXY,1 do
	x=tonumber(textmapXY[i][1])
	y=tonumber(textmapXY[i][2])
	if x == nil  or y == nil then  return end
	if x > GridSize then x = GridSize end
	if y > GridSize then y = GridSize end
	tbtn = "x"..tostring(x).."y"..tostring(y)
	if DungeonMapperWindow ~= nil then	
	act="if "..tbtn.."~= nil then "..tbtn..":color(255) end\n"
	 dsbtext2mapButtonChanges= loadstring(act)
	dsbtext2mapButtonChanges()
	end
	end
end


--- over ride DSB functions
function dsb_spawn(...)
if arg.n > 0 then 
local name = arg[1]
dsbspawn[#dsbspawn+1]={}
	for i = 1,arg.n do 

		if arg[i] ~= nil then 
		table.insert(dsbspawn[#dsbspawn],arg[i])
		end 
	end
end

return arg[1]
end

function dsb_add_champion(...)
if arg.n > 0 then 
local name = arg[1]
dsbaddchampion[#dsbaddchampion+1]={{}}
	for i = 1,arg.n do 
		if arg[i] ~= nil then 
		table.insert(dsbaddchampion[#dsbaddchampion],arg[i])
		end 
	end
end
return arg[2].."_"..arg[3]
end

function spawn_in_pack(...) 
if arg.n > 0 then 
local name = arg[1]
spawninpack[#spawninpack+1]={}
spawninpack[#spawninpack][1]= #dsbspawn
	for i = 1,arg.n do 
		if arg[i] ~= nil then 
		table.insert(spawninpack[#spawninpack],arg[i])
		end 
	end
end
return arg[1]
end

function dsb_text2map(...)
if arg.n > 0 then 
local name = arg[1]
dsbtext2map[#dsbtext2map+1]={}
	for i = 1,arg.n do 
		if arg[i] ~= nil then 
		table.insert(dsbtext2map[#dsbtext2map],arg[i])
		end 
	end
end
return #dsbtext2map
end

function dungeon_translate()
end

function dsb_spawnburst_begin()
end
function dsb_spawnburst_end()
end
function dsb_set_maxhp()
end

function dsb_set_gameflag()
end
function dsb_champion_toparty()
end
function dsb_party_place()
end
function dsb_image2map()
end
function dsb_level_wallset()
end
function dsb_set_exviewinst()
end
function dsb_set_hp()
end
function dsb_alt_wallset()
end
function dsb_disable()
end
function spawn_pit()
end

--dofile("/Applications/dsbtest35/dm/dungeon.lua")
--dofile("/Applications/dsbtest35/dungeonout.lua")