--08 2008
--prepMeshForPaths
--empty need to code this
-- 12 25 2008 happy holiday paths
gPathList={}
selectedPath = 1
selectedPathInfo={{}}

function getPathList()
gPathList={}
pathlist = ig3d_GetPathsList__s()
for i = 1,getlinecount(pathlist),1 do
tpath = getlineof(pathlist,i)
if tpath ~=nil then table.insert(gPathList,tpath) end
end
return gPathList
end


function getPathInfo2(i)
selectedPathInfo={{}}
pathinfo = ig3d_GetPathInfo_i_s(i)
	for i = 1,getlinecount(pathinfo),1 do
	local x,y,z = getlineof(pathinfo,i)
	if tinfo ~=nil then table.insert(selectedPathInfo,{x,y,z}) end
	end
	return selectedPathInfo
end

function setPathInfo2(i,x,y,z)
table.insert(selectedPathInfo,{x,y,z})

local s =""
local tinfo=""
for ii = 1,#selectedPathInfo,1 do
for iii = 1,#selectedPathInfo[ii],1 do
s=s..selectedPathInfo[ii][iii]..","
end
tinfo=tinfo..string.sub(s,1,-2).."\n"
end
ig3d_SetPathInfo_is(selectedPath,tinfo)
end

function addToPath(i,x,y,z)
ig3d_AddToPath_i(selectedPath)
end

function newPath(s)
ig3d_CreatePath_s(s)
getPathList()
selectedPath=#gPathList
end

function showPaths()
ig3d_SetPathsVisible_b(true)
end

function hidePaths()
ig3d_SetPathsVisible_b(true)
end

function pathMapDraw(x,y)
if gPathList == nil then
newPath("path0")
getPathList()
end
drawVertex (x,1,y) 
ig3d_AddToPath_i(selectedPath)
ig3d_SetPathsVisible_b(true)
table.insert(selectedPathInfo,{x*vgridwidth,1,z*vgridwidth})
local px,py,pz= selectedPathInfo[1][1],selectedPathInfo[1][2],selectedPathInfo[1][3]
if px ~= nil then
if px+py+pz==0 then
 local s= ig3d_GetPathInfo_i_s(selectedPath)
 if string.find(s,"\n")~= nil then
 ss=string.sub(s,string.find(s,"\n"),-1)
 if ss ~= nil then ig3d_SetPathInfo_is(selectedPath,ss) end
 getPathInfo()
 end
 end
 end
 
--if gPathList == nil then
--newPath("path0")
--end
--setPathInfo(selectedPath,x,1,y)

end

--ig3d_GetPathsList__s
--ig3d_GetPathInfo_i_s
--ig3d_SetPathInfo_is
--ig3d_AddToPath_i
--ig3d_CreatePath_s
--ig3d_DeletePath_i
--ig3d_SetPathName_is
--ig3d_SetPathsVisible_b

