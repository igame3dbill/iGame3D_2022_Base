--08 2008
--prepMeshForBones
function prepMeshForBones()
ig3d_ScaleSelectedMeshTo_3f(0,1,0)
ig3d_SetMeshPositionNoUndo_3f (0.0,0.0,0.0) 
ig3d_MakeInvisible() 
--loadMesh("Data/WTF/Vehicles_air/EnemyFighterBones.wtf")
loadMesh("Data/WTF/Characters/truebonesTpose.wtf")
end

function boneMeshCluster()
ig3d_ShowAll() 
ig3d_ClusterMeshBones()
end



--- functions below before Aug. 20 2008
function meshBonesClicked(w)
if w:value() ~= 0 then
	ig3d_SelectMeshBone_s(removeSpaces(w:text(w:value())))
	end
	
end
-- selectBoneMesh
function selectBoneMesh(w)
	ig3d_SelectMeshAttachedToBone_s(removeSpaces(meshBones:text(meshBones:value())))
end
-- boneattacher
function boneattacher(w)
	ig3d_AttachVertexToBone_s(removeSpaces(meshBones:text(meshBones:value())))
end

-- recursiveBonePrint
function recursiveBonePrint(b)	
	local str=""
	for i=1,bdepth,1 do
		str=str.."	"
	end
	meshBones:add(str..b.name)
	
	
	
	bdepth=bdepth+1
	for i=1,#b.subs,1 do
		recursiveBonePrint(b.subs[i])
	end
	bdepth=bdepth-1
end
-- selBoneInListFromName
function selBoneInListFromName(name)
	for i=1,#bonelist,1 do
		local a=removeSpaces(meshBones:text(i))
		if a == name then
			meshBones:value(i)
		end
	end
end

-- listBones
function listBones()
	-- turns the returned bone list into a tree structure and displays that in the bone list field
	-- using recursion
	local bl=ig3d_GetMeshBonesList__s()
	
	bonelist={}
	
	for w in string.gmatch(bl, "[^\n]+") do
		local spaceoffset=string.find(w, " ")
		local nam=string.sub(w, 1, spaceoffset-1)
		local num=string.sub(w, spaceoffset+1, -1)
		
		it={name=nam, numb=num, parent=nil, subs={} }
		table.insert(bonelist, it)
     	end
     	
     	
     	for i=2,#bonelist,1 do
     		bonelist[i].parent=bonelist[ tonumber(bonelist[i].numb) ]
     	end
     	
     	for i=1,#bonelist,1 do
     		for j=2,#bonelist,1 do
     			if bonelist[j].parent==bonelist[i] then
     				table.insert(bonelist[i].subs, bonelist[j])
     			end
     		end
     	end
     	
     	meshBones:clear()
     	bdepth=0
     	recursiveBonePrint(bonelist[1])
     
end
--  bonemaker
function bonemaker(w)
	local bname=fltk.fl_input("Please enter a name for the bone and the name of the parent bone. Use comma as delimiter.", "NewBone,None")
	if bname~=nil then
		local commaoffset=string.find(bname, ",")
		local newbone=string.sub(bname, 1, commaoffset-1)
		local parentbone=string.sub(bname, commaoffset+1, -1)
		
		ig3d_MakeBoneFromVertex_2s(newbone, parentbone)
		listBones()
		--selBoneInListFromName(newbone)
	end
	
end


