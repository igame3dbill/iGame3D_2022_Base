--08 2008
--prepMeshFormesh_Tags
function prepMeshFormesh_Tags()
ig3d_ScaleSelectedMeshTo_3f(0,1,0)
ig3d_SetMeshPositionNoUndo_3f (0.0,0.0,0.0) 
ig3d_MakeInvisible() 
--loadMesh("Data/WTF/Vehicles_air/EnemyFightermesh_Tags.wtf")
loadMesh("Data/WTF/Characters/truemesh_TagsTpose.wtf")
end

function mesh_TagsMeshCluster()
ig3d_ShowAll() 
ig3d_ClusterMeshmesh_Tags()
end



--- functions below before Aug. 20 2008
function meshmesh_TagsClicked(w)
if w:value() ~= 0 then
	ig3d_SelectMeshmesh_Tags_s(removeSpaces(w:text(w:value())))
	end
	
end
-- selectmesh_TagsMesh
function selectmesh_TagsMesh(w)
	ig3d_SelectMeshAttachedTomesh_Tags_s(removeSpaces(meshmesh_Tags:text(meshmesh_Tags:value())))
end
-- mesh_Tagsattacher
function mesh_Tagsattacher(w)
	ig3d_AttachVertexTomesh_Tags_s(removeSpaces(meshmesh_Tags:text(meshmesh_Tags:value())))
end

-- recursivemesh_TagsPrint
function recursivemesh_TagsPrint(b)	
	local str=""
	for i=1,bdepth,1 do
		str=str.."	"
	end
	meshmesh_Tags:add(str..b.name)
	
	
	
	bdepth=bdepth+1
	for i=1,#b.subs,1 do
		recursivemesh_TagsPrint(b.subs[i])
	end
	bdepth=bdepth-1
end
-- selmesh_TagsInListFromName
function selmesh_TagsInListFromName(name)
	for i=1,#mesh_Tagslist,1 do
		local a=removeSpaces(meshmesh_Tags:text(i))
		if a == name then
			meshmesh_Tags:value(i)
		end
	end
end

-- listmesh_Tags
function listmesh_Tags()
	-- turns the returned mesh_Tags list into a tree structure and displays that in the mesh_Tags list field
	-- using recursion
	local bl=ig3d_GetMeshmesh_TagsList__s()
	
	mesh_Tagslist={}
	
	for w in string.gmatch(bl, "[^\n]+") do
		local spaceoffset=string.find(w, " ")
		local nam=string.sub(w, 1, spaceoffset-1)
		local num=string.sub(w, spaceoffset+1, -1)
		
		it={name=nam, numb=num, parent=nil, subs={} }
		table.insert(mesh_Tagslist, it)
     	end
     	
     	
     	for i=2,#mesh_Tagslist,1 do
     		mesh_Tagslist[i].parent=mesh_Tagslist[ tonumber(mesh_Tagslist[i].numb) ]
     	end
     	
     	for i=1,#mesh_Tagslist,1 do
     		for j=2,#mesh_Tagslist,1 do
     			if mesh_Tagslist[j].parent==mesh_Tagslist[i] then
     				table.insert(mesh_Tagslist[i].subs, mesh_Tagslist[j])
     			end
     		end
     	end
     	
     	meshmesh_Tags:clear()
     	bdepth=0
     	recursivemesh_TagsPrint(mesh_Tagslist[1])
     
end
--  mesh_Tagsmaker
function mesh_Tagsmaker(w)
	local bname=fltk.fl_input("Please enter a name for the mesh_Tags and the name of the parent mesh_Tags. Use comma as delimiter.", "Newmesh_Tags,None")
	if bname~=nil then
		local commaoffset=string.find(bname, ",")
		local newmesh_Tags=string.sub(bname, 1, commaoffset-1)
		local parentmesh_Tags=string.sub(bname, commaoffset+1, -1)
		
		ig3d_Makemesh_TagsFromVertex_2s(newmesh_Tags, parentmesh_Tags)
		listmesh_Tags()
		--selmesh_TagsInListFromName(newmesh_Tags)
	end
	
end


