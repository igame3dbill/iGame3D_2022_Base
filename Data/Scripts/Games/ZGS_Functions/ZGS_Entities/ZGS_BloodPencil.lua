--ZGS_BloodPencil.lua
--Lade die Blutstempel
loadTexture("Data/Images/Decals/bloodpencil1.png")
loadTexture("Data/Images/Decals/bloodpencil2.png")
loadTexture("Data/Images/Decals/bloodpencil3.png")
--Gebe jedem Material in jedem Objekt eine neue Textur
for i=1,#gObjects,1 do
	j=1
	if gObjects[i].alive then
		m=get(ig3d_material, gObjects[i].cObj, j)
		while m ~= nil do
			setMaterialInfo(m, IG3D_TEXTURE, 3, make(ig3d_texture, getObjectInfo(gObjects[i].cObj, IG3D_NAME)..(os.time()).."tempblood"..(j)..".png",64,64))
			if getSceneInfo(IG3D_FRAGMENT_SHADER_SUPPORTED)==false then
				--no bumppass shader and no normal map in texture unit 2
				--setMaterialInfo(m, IG3D_SHADER, nil)
				--setMaterialInfo(m, IG3D_TEXTURE, 2, nil)
			end
			j=j+1
			m=get(ig3d_material, gObjects[i].cObj, j)
		end	
	end
end
