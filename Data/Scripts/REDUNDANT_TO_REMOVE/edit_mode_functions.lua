function editingModeSwitch(newEditingMode)
gEditingMode = newEditingMode

if gEditingMode=="play" then
 setSceneInfo(IG3D_MOUSE_VIEW, gMouse, 1)
       ig3d_SetMode_i(4)
       end     
                     
if gEditingMode=="select_entity" then
print("gEditingMode="..gEditingMode)

ig3d_SetMeshTool_i(0)
      ig3d_SetMode_i(1)
      gMouse = false 
setSceneInfo(IG3D_MOUSE_VIEW, gMouse, 1) -- GlWindow does not lock the mouse
ig3d_TellFocus_b(not gMouse) -- iGame3D does not lock the keyboard
end


 --SELECT_MESH 
if gEditingMode=="select_mesh" then ig3d_SetMeshTool_i(2) end

 --igame3d does have the keyboard
if gEditingMode=="lookaround" then 
       		if ig3d_GetMode__i() == 4 then ig3d_SetMode_i(1) end
            gMouse=not gMouse
      	 	ig3d_TellFocus_b(not gMouse) --igame3d has the keyboard
			setSceneInfo(IG3D_MOUSE_VIEW, gMouse, 1)
		else
			gMouse = false 
			ig3d_TellFocus_b(not gMouse)
		end

	if newEditingMode == "edit_dropentity" then 
	gEditingMode = newEditingMode
	ig3d_SetMeshTool_i(999) 
	end

end

function EditModeToggle()
if gEditingMode==nil or gEditingMode=="play"  then em="select_entity"
else
 em="play"
 end
 gEditingMode = em
editingModeSwitch(em)
end

function viewplaytoggle()
if gEditingMode~="lookaround"  then em="lookaround"
else em="play"
end
editingModeSwitch(em)
end


--Edit button
function editbutton()
EditModeToggle()
UIUpdate()
end