-- FILL THE Mesh MENU
MeshMenuIndex={}

MeshMenuText={}
MeshMenuText.base={"Focus Mesh","Goto Points","Tag Vertices","Duplicate Vertices","Extrude","Combine Overlaps","Subdivide","Delete Vertices","Clear Mesh"}
MeshMenuText.Select={"Select/All Vertices","Select/Connected","Select/Invert","Select/Connected to Bone","Select/Same Material","Select/Same Tag"}
MeshMenuText.Face={"Face/In","Face/Out","Face/Invert"}
MeshMenuText.View={"View/Hide","View/Hide All","View/Show All","View/Swap Hidden","View/Hide Faces","View/Show Faces","View/Invisible","View/Visible"}
MeshMenuText.Mirror={"Mirror/x","Mirror/y","Mirror/z"}
meshIndexCount=0


function fillMeshbase(MeshMenuIndex)
meshIndexCount = table.getn(MeshMenuIndex)
local mstop=table.getn(MeshMenuText.base)
local i = 0
while(i ~= mstop) do	
i=i+1
print(i)
menuLine="Mesh/"..MeshMenuText.base[i]
meshMenu:add(menuLine);
meshIndexCount = table.getn(MeshMenuIndex)+1
MeshMenuIndex[meshIndexCount] = menuLine
end
MeshMenuIndex[meshIndexCount+1]=""
end --fillMeshbase

function fillMeshSelect(MeshMenuIndex)
meshIndexCount = table.getn(MeshMenuIndex)+1
MeshMenuIndex[meshIndexCount]="Select"
local mstop = table.getn(MeshMenuText.Select)
local i = 0
while(i ~= mstop) do
i=i+1
menuLine=MeshMenuText.Select[i]
meshMenu:add(menuLine);
meshIndexCount = table.getn(MeshMenuIndex)+1
MeshMenuIndex[meshIndexCount] = menuLine
end
MeshMenuIndex[meshIndexCount+1]=""
end --fillMeshSelect


function fillMeshFace(MeshMenuIndex)
meshIndexCount = table.getn(MeshMenuIndex)+1
MeshMenuIndex[meshIndexCount]="Face"
local mstop=table.getn(MeshMenuText.Face)
local i = 0
while(i ~= mstop) do
i=i+1
menuLine=MeshMenuText.Face[i]
meshMenu:add(menuLine);
meshIndexCount = table.getn(MeshMenuIndex)+1
MeshMenuIndex[meshIndexCount]=menuLine
end
MeshMenuIndex[meshIndexCount+1]=""
end --fillMeshFace

function fillMeshView(MeshMenuIndex)
meshIndexCount = table.getn(MeshMenuIndex)+1
MeshMenuIndex[meshIndexCount]="View"
local mstop=table.getn(MeshMenuText.View)
local i = 0
while(i ~= mstop) do
i=i+1
menuLine=MeshMenuText.View[i]
meshMenu:add(menuLine);


meshIndexCount = table.getn(MeshMenuIndex)+1
MeshMenuIndex[meshIndexCount]=menuLine
end
MeshMenuIndex[meshIndexCount+1]=""
end --fillMeshView

function fillMeshMirror(MeshMenuIndex)
meshIndexCount = table.getn(MeshMenuIndex)+1
MeshMenuIndex[meshIndexCount]="Mirror"
local mstop=table.getn(MeshMenuText.Mirror)
local i = 0
while(i ~= mstop) do
i=i+1
menuLine=MeshMenuText.Mirror[i]
meshMenu:add(menuLine);
meshIndexCount = table.getn(MeshMenuIndex)+1
MeshMenuIndex[meshIndexCount] = menuLine
end

end --fillMeshMirror

function fill_MeshMenu()
fillMeshbase(MeshMenuIndex)
fillMeshSelect(MeshMenuIndex)
fillMeshFace(MeshMenuIndex)
fillMeshView(MeshMenuIndex)
fillMeshMirror(MeshMenuIndex)
end




---------------------------------------------

-- mesh menu Picks for mesh editor

-- meshBasePick
function meshBasePick(tIndex)
if tPick == "Focus Mesh" then action = 1
elseif tPick == "Goto Points" then action = 1
elseif tPick == "Tag Vertices" then action = 1
elseif tPick == "Duplicate Vertices" then ig3d_DuplicateMesh()
elseif tPick == "Extrude" then ig3d_ExtrudeSelectedMesh_fb(extrudeDepth:value(), true)
elseif tPick == "Combine Overlaps" then ig3d_CombineSelectedMeshOverlaps_f(1.0) 
elseif tPick == "Subdivide" then ig3d_SubdivideMesh()
elseif tPick == "Delete Vertices" then ig3d_DeleteMesh_b(false)
elseif tPick == "Clear Mesh" then ig3d_DeleteMesh_b(true)
end
end
-- meshSelectPick

function meshSelectPick(tPick)
if tPick == "All Vertices" then ig3d_SelectWholeMesh() 
elseif tPick == "Connected" then  ig3d_SelectConnectedMesh()
elseif tPick == "Invert" then ig3d_InvertMeshSelection()
elseif tPick == "Connected to Bone" then ig3d_SelectMeshAttachedToBone_s(removeSpaces(meshBones:text(meshBones:value())))
elseif tPick == "Same Material" then
elseif tPick == "Same Tag" then

end
end
-- meshFacePick
function meshFacePick(tPick)

if tPick == "In" then  faceMeshIn()
elseif tPick == "Out" then faceMeshOut()
elseif tPick == "Invert" then ig3d_InvertMeshFaces() 
end

end
-- meshViewPick

function meshViewPick(tPick)
if tPick == "Hide" then ig3d_MakeInvisible()
elseif tPick == "Hide All"  then ig3d_ShowAll()
elseif tPick == "Show All"  then ig3d_ShowAll()
elseif tPick == "Swap Hidden"  then ig3d_ShowAll()
elseif tPick == "Hide Faces"  then ig3d_ShowAll()
elseif tPick == "Show Faces"  then ig3d_ShowAll()
elseif tPick == "Invisible"   then ig3d_ShowAll()
elseif tPick == "Visible"  then ig3d_ShowAll()
end

end
-- meshMirrorPick
function meshMirrorPick(tIndex)
if tIndex ==  "x"  then ig3d_MirrorSelectedMesh_3i(1,0,0) --MIRRORX
elseif tIndex ==  "y" then ig3d_MirrorSelectedMesh_3i(0,1,0) --MIRRORY 
elseif tIndex ==  "z" then ig3d_MirrorSelectedMesh_3i(0,0,1) --MIRRORZ
end
end


-- save as WTF OBJ  3DS Meshwork
function save_asWTF()
if gMapMeshPath == nil then
wtfsaveFile=fastFilePaths("WTF",".wtf")
else
wtfsaveFile=gMapMeshPath
end
ig3d_SaveMeshAsWTF_sf(wtfsaveFile,100)
end

function save_asOBJ()
objsaveFile = fastFilePaths("OBJ",".obj")

ig3d_SaveMeshAsOBJ_sf(objsaveFile,100)
end

function save_as3DS()

threedsavefile=fastFilePaths("3DS",".3ds")
ig3d_SaveMeshAs3DS_sf(threedsavefile,100)
end

function save_asMeshWork()
meshworksavefile=fastFilePaths("Meshwork",".mesh")
ig3d_SaveMeshAsMeshwork_sf(meshworksavefile,100)
end

-- mesh_menu_callback
function mesh_menu_callback(w)
tMenu = w:label()
tVal = w:value()
tPick = w:text()
tIndex = MeshMenuIndex[tVal]
tIndex1 = MeshMenuIndex[tVal-1]
tIndex2 = MeshMenuIndex[tVal+1]
print(tMenu,tVal,tPick,tIndex)
if tIndex ~=nil then 
meshmenuHead=item(1,tIndex,"/")
--print(meshmenuHead,tPick)
 if meshmenuHead == "Mesh" then meshBasePick(tPick) 
 elseif meshmenuHead == "Select" then meshSelectPick(tPick) 
 elseif meshmenuHead == "Face" then meshFacePick(tPick) 
  elseif meshmenuHead == "View" then meshViewPick(tPick) 
   elseif meshmenuHead == "Mirror" then meshMirrorPick(tPick) 
 end
 end 
  Fl:check();
   io.flush();
end
