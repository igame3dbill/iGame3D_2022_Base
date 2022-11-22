--this file handles fallbacks for slow computers


function udg_disable_tex_unit2_of_all_materials()
	
		local j=1
		local m
		for i=1,#gObjects,1 do
				j=1
				while true do
					m=get(ig3d_material, gObjects[i].cObj, j)
					if not m then
						break
					else
						setMaterialInfo(m, IG3D_SHADER, nil)
						setMaterialInfo(m, IG3D_TEXTURE, 2, nil)
					end
					j=j+1
				end
		end
	
		j=1
		while true do
			local m=get(ig3d_material, -1, j)
			if not m then
				break
			else
				setMaterialInfo(m, IG3D_SHADER, nil)
				setMaterialInfo(m, IG3D_TEXTURE, 2, nil)
			end
			j=j+1
		end
	
end



--if we dont have shaders, disable tex unit 2 (which usually has bump maps)
gFallbackMode=false

if not getSceneInfo(IG3D_FRAGMENT_SHADER_SUPPORTED) or gFallbackMode then
	gFallbackMode=true
	--this is the criterium for "old" computer, do all fallbacks
	udg_disable_tex_unit2_of_all_materials()

	--disable shadow casting
	setSceneInfo(IG3D_RECEIVE_SHADOWS, false)

	--white people
	setSceneInfo(IG3D_LOD_DISTANCE, 5,9,9,9)
	
	--scale all textures down to 128x128!!
	ig3d_ScaleAllTexturesDownToWidth_i(128)
end
