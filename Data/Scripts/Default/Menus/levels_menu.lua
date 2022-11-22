-- FILL THE LEVELS MENU
LevelsMenuText={}
function fill_LevelsMenu()
local i=0;
local LevelsPath=getSceneInfo(IG3D_ROOT).."Data/Levels/"

n=menuIndexCount+3
mainMenuIndex[n]="Levels"

print("Levelsmenu",n)
n=n-1

for file in lfs.dir(LevelsPath) do

if string.sub(file,1,1) ~="." then
if string.sub(file,-4,-4)~="." and string.sub(file,-3,-3) ~="." then
firstChar=string.upper(string.upper(string.sub(file,1,1)))

if firstChar~=oldChar then
oldChar=firstChar
n=n+2
mainMenuIndex[n]="Levels/"..firstChar.."/"
end

n=n+1
menuLine="Levels/"..firstChar.."/"..file
menuBar:add(menuLine);
mainMenuIndex[n]=menuLine
end
end
end
menuBar:value(0)
menuIndexCount=n
end

--Exit
function exittomenu()
game_func=nil
loadLevel("Data/Levels/default")
end

--restart
function restartbutton()
tLevel=ig3d_GetLevelName__s()
delete(ig3d_scene)
loadLevel(tLevel)
end

-- Clear scene
function clearsceneClicked(w)
	delete(ig3d_scene)
	--game_func=nil
end

-- new level
function newLevel()
if not askLevel then OPEN_UI_WINDOWS("askLevel") end --see Data/Scripts/Default/Base/file_functions.lua
end


-- Save Functions --
-- save_levelState
function save_levelState()
levelStateFile=gameroot..ig3d_GetLevelName__s().."/savedstate.lua"
levelState=ig3d_GetStateScript__s()
io.output(levelStateFile)
io.write(levelState)
end
-- save_levelMesh

function save_levelMesh()
	local wordList={}
	levelPath=ig3d_GetLevelName__s()
--levelPathAsWords = string.gsub(levelPath, "/", " ")
--wordList = extractWords(levelPathAsWords)
--lastWord=wordList[#wordList]
--levelMeshFile= (levelPath.."/"..lastWord.."_level_mesh.wtf")
--savelevelMesh = ig3d_SaveMeshAsWTF_sf(gameroot..levelMeshFile,100)

	local i,offst
	for i=#levelPath-1,2,-1 do
		if string.sub(levelPath, i,i)=="/" then offst=i; break end
	end

	levelMeshFile=levelPath..string.sub(levelPath, offst,-1).."_level_mesh.wtf"
	setSceneInfo(IG3D_LEVEL_MESH, levelMeshFile)
	saveMesh(levelMeshFile)
end

-- save level
function save_level()
save_levelMesh();

tLevel=ig3d_GetLevelName__s();

f=io.open(gameroot..tLevel.."/load script.lua","r")
if f ~= nil then
lst = f:read("*a")
if getlineof(lst,2) == "LockScript = true" then return end
f:close()
end


saveLevel(tLevel);

end



function saveAsNewLevel()
if asksaveLevel == nil then 
OPEN_UI_WINDOWS("saveLevelAs")
else
asksaveLevel:show()
end
end

-- level Menu Pick
function levelMenuPick(tPick)

local xPick=item(-2,tPick,"/")
local yPick=item(-1,tPick,"/")
local mPick=xPick.."/"..yPick
local tTitle=xPick.." "..yPick
local tDir=gameroot.."Data/"
local tFile="empty"
print("mPick="..mPick)
if mPick == "Level/Clear Scene" then action =  clearsceneClicked() 
elseif mPick == "Level/Reset" then action =  restartbutton()
elseif mPick == "Level/Main Menu" then action =  exittomenu()
elseif mPick == "Level/Save" then  action =  save_level()
elseif mPick == "Level/Save As" then  action =  saveAsNewLevel()
elseif mPick == "Level/Play" then action = editingModeSwitch("play")
elseif mPick == "Level/New Level" then action = newLevel()

end

end