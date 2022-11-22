
-- alignIt
function alignIt(w)
	ig3d_SetMeshAlignmentSize_f(alignSize:value())
	ig3d_AlignMesh()
end

-- backfaceControlClicked
function backfaceControlClicked(w)
	if w:value()==1 then ig3d_SetBackfaceCulling_b(true) else ig3d_SetBackfaceCulling_b(false) end
end



-- DoMagic
function DoMagic(w)
	if magicCyl:value()==1 then
		ig3d_MagicCatch_fb(magicValue:value(),true)
	else
		ig3d_MagicCatch_fb(magicValue:value(),false)
	end
end

-- duplicateButtonClicked
function duplicateButtonClicked(w)
	ig3d_DuplicateMesh()
end

-- hideSelectionClicked
function hideSelectionClicked(w)
	ig3d_MakeInvisible()
end

-- invertSelectionClicked
function invertSelectionClicked(w)
	ig3d_InvertMeshSelection()
end

-- selectAllClicked
function selectAllClicked(w)
	ig3d_SelectWholeMesh()
end

-- showAllClicked
function showAllClicked(w)
	ig3d_ShowAll()
end

-- selectConnectedClicked
function selectConnectedClicked(w)
	ig3d_SelectConnectedMesh()
end

-- subdivideClicked
function subdivideClicked(w)
	ig3d_SubdivideMesh()
end

-- extrudeButtonClicked
function extrudeButtonClicked(w)
	ig3d_ExtrudeSelectedMesh_fb(extrudeDepth:value(), true)
end
-- zbufferControlClicked
function zbufferControlClicked(w)
	if w:value()==1 then ig3d_SetMeshZBuffering_b(true) else ig3d_SetMeshZBuffering_b(false) end
end
-- handlePositionValueFields
function handlePositionValueFields(w)
	--tell igame3d that the input field has the focus
	ig3d_TellFocus_b(true)
	if Fl:event_key() ~= fltk.FL_Enter and Fl:event_key() ~= fltk.FL_KP_Enter then return end
	ig3d_SetMeshPosition_3f(xpos:value(), ypos:value(), zpos:value() )
end
-- handleScaleValueFields
function handleScaleValueFields(w)
	--tell igame3d that the input field has the focus
	ig3d_TellFocus_b(true)
	if Fl:event_key() ~= fltk.FL_Enter and Fl:event_key() ~= fltk.FL_KP_Enter then return end
	ig3d_ScaleSelectedMesh_3f(xsize:value(), ysize:value(), zsize:value() )
end
-- handleGetButton
function handleGetButton(w)
	local x,y,z=ig3d_GetMeshCentroid__3f()
	xpos:value(x)
	ypos:value(y)
	zpos:value(z)
end
-- handleGetSizeButton
function handleGetSizeButton(w)
	local x,y,z=meshHWD()
	xsize:value(x)
	ysize:value(y)
	zsize:value(z)
end
-- handleExtrudeValueField
function handleExtrudeValueField(w)
	--tell igame3d that the input field has the focus
	ig3d_TellFocus_b(true)
	if Fl:event_key() ~= fltk.FL_Enter and Fl:event_key() ~= fltk.FL_KP_Enter then return end
	extrudeButtonClicked(w)
end
-- handlelinewidth
function handlelinewidth(w)
ig3d_SetLineWidth_f(w:value()) 
end
-- handlepointwidth
function handlepointwidth(w)
ig3d_SetPointSize_f(w:value()) 

end

-- removeSpaces
function removeSpaces(theWord)
	local str=theWord..""
	local offset
	while true do
		offset=string.find(str, "	")
		
		if offset==nil then offset=string.find(str, " ") end
		
		if offset ~= nil then
			str=string.sub(str,1,offset-1)..string.sub(str,offset+1,-1)
		else
			break
		end
	end
	return str

end
-- faceMeshIn
function faceMeshIn()
	ig3d_MeshFaceAwayFromCamera()
end
--  faceMeshOut
function faceMeshOut()
	ig3d_MeshFaceAwayFromCamera()
	ig3d_InvertMeshFaces() 
end



function boneComponents()
	--find the components and create a bone for each, this breaks mesh group 1 but what the heck
	c=1
	while true do 
		b=ig3d_SelectAVisibleVertex__b()
		if not b then break end
		local compname="component"..(c)
		print(compname)
		c=c+1
		ig3d_SelectConnectedMesh()
		--ig3d_AddToMesh_tag_i(1)
		x,y,z=ig3d_GetMeshCentroid__3f()
		
		drawVertex(x,y,z)
		ig3d_MakeBoneFromVertex_2s(compname, "None")
		ig3d_MakeInvisible()
		b=ig3d_SelectAVisibleVertex__b()
		ig3d_SelectConnectedMesh()
		ig3d_AttachVertexToBone_s(compname)
		ig3d_MakeInvisible()
	end
ig3d_ShowAll()
end

function boneComponentsExtruding(extr)
	--find the components and create a bone for each, this breaks mesh group 1 but what the heck
	c=1
	while true do 
		b=ig3d_SelectAVisibleVertex__b()
		if not b then break end
		local compname="component"..(c)
		print(compname)
		c=c+1
		ig3d_SelectConnectedMesh()
		ig3d_ExtrudeSelectedMesh_fb(extr, true)
		ig3d_SelectConnectedMesh()
		--ig3d_AddToMesh_tag_i(1)
		x,y,z=ig3d_GetMeshCentroid__3f()
		
		drawVertex(x,y,z)
		ig3d_MakeBoneFromVertex_2s(compname, "None")
		ig3d_MakeInvisible()
		b=ig3d_SelectAVisibleVertex__b()
		ig3d_SelectConnectedMesh()
		ig3d_AttachVertexToBone_s(compname)
		ig3d_MakeInvisible()
	end
ig3d_ShowAll()
end

function boneCarComponents()
	ig3d_SelectWholeMesh()
	ig3d_CombineSelectedMeshOverlaps_f(0.02)
	--find the components and create a bone for each, this breaks mesh group 1 but what the heck
	
	local rightFrontExists=false
	local rightRearExists=false
	local leftFrontExists=false
	local leftRearExists=false
	while true do 
		b=ig3d_SelectAVisibleVertex__b()
		if not b then break end

		ig3d_SelectConnectedMesh()
		--ig3d_AddToMesh_tag_i(1)
		x,y,z=ig3d_GetMeshCentroid__3f()
		
		
		local compname="None"
		local createBone=false
		if y<0 then
			if x<0 and z>0 then
				if not rightFrontExists then
					createBone=true
				end
				rightFrontExists=true
				compname="RightFrontWheel"
			end
			if x<0 and z<0 then
				if not rightRearExists then
					createBone=true
				end
				rightRearExists=true
				compname="RightRearWheel"
			end
			if x>0 and z>0 then
				if not leftFrontExists then
					createBone=true
				end
				leftFrontExists=true
				compname="LeftFrontWheel"
			end
			if x>0 and z<0 then
				if not leftRearExists then
					createBone=true
				end
				leftRearExists=true
				compname="LeftRearWheel"
			end
		end
		
		if createBone then
			drawVertex(x,y,z)
			ig3d_MakeBoneFromVertex_2s(compname, "None")
			ig3d_MakeInvisible()
		end
			
		b=ig3d_SelectAVisibleVertex__b()
		ig3d_SelectConnectedMesh()
		ig3d_AttachVertexToBone_s(compname)
		
		ig3d_MakeInvisible()
	end
ig3d_ShowAll()
end

-- added 01 18 2009
function combineEqualMaterialsCB()
ig3d_CombineEqualMeshMaterials() 
listMaterials()
end