--UV-related callbacks and functions
function getMapAxisFromControls()
	local i=uvmapaxis:value()
	if i==0 then return false,0,0,0 end
	if i==1 then return true,1,0,0 end
	if i==2 then return true,0,1,0 end
	return true,0,0,1
end
------------------

function uvmatcher()
	local b,dx,dy,dz=getMapAxisFromControls()
	local u,v=ig3d_GetMatchingUVSizesForMesh_fb3f_2f(uvrot:value(), b, dx,dy,dz)
	uvwidth:value(u)
	uvheight:value(v)
end
------------------

function applyuvmapping()
	ig3d_GenerateAndApplyMeshUVMapping_5fb3f(uvwidth:value(), uvheight:value(), 0,0, uvrot:value(), getMapAxisFromControls())
end
------------------
function scaleuvmapping()
	ig3d_ScaleUVMapping_2f(uvscaleu:value(), uvscalev:value())
end
------------------
function offsetuvmapping()
	ig3d_OffsetUVMapping_2f(uvoffu:value(), uvoffv:value())
end
------------------

--cylindricMappingClicked -- 08 20 2008
function cylindricMappingClicked(w)
	ig3d_GenerateAndApplyMeshCylindricUVMapping()
end




