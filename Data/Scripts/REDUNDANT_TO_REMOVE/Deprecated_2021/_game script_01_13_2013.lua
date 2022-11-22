function goDirsUp(path, numLevels)
--takes a path (with trailing /) and moves up numLevels levels and returns it
	local i
	local c=-1
	for i=#path,1,-1 do
		if string.sub(path, i,i)=="/" then
			c=c+1
		end
		if numLevels<=c then return string.sub(path, 1,i); end;
	end
	return "/"
end


--originating application path
bundleroot = getSceneInfo(IG3D_ROOT)


if murgaLua.getHostOsName()=="macos" then
	gameroot=goDirsUp(bundleroot, 3)
	--custom gameroot
	setSceneInfo(IG3D_ROOT,gameroot)
else
	gameroot=bundleroot
end

--check if a custom path has been set
f=io.open(bundleroot.."Data/alternateRoot.txt","r")
if f~= nil then
	gameroot=f:read("*a")
	f:close()
end

--try bundle now
f=io.open(gameroot.."Data/Scripts/core.lua","r")
if f==nil then
	gameroot=bundleroot
	setSceneInfo(IG3D_ROOT,gameroot)
end

--see if the Data folder is there, if not let user choose a root directory
ok=false
writeAlternate=false
while not ok do
	f=io.open(gameroot.."Data/Scripts/core.lua","r")
	if f==nil then
		fltk.fl_message("Could not find the iGame3D root directory here: \""..gameroot.."\".\nPlease choose your iGame3D root directory (folder containing the Data folder)\nin the following folder prompt...")
		theFolder = fltk.fl_dir_chooser("Please choose your iGame3D root directory...", nil, 0)
		if theFolder==nil then ok=true;quit() else gameroot=theFolder.."/";writeAlternate=true; end
	else
		ok=true
		f:close()
		if writeAlternate then
			f=io.open(bundleroot.."Data/alternateRoot.txt","w")
			f:write(gameroot)
			f:close()
		end
	end
	setSceneInfo(IG3D_ROOT,gameroot)
	ig3d_RebuildMacMenubar()
end
-- source of game Data files
gameroot=getSceneInfo(IG3D_ROOT)
----------------------------------------------


--branch too customizable default startup script inclusions
if game_func==nil then loadLevel("Data/Levels/default") end