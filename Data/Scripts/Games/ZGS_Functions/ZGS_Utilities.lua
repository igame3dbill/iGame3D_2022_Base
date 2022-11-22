function zgs_print(txt)
	setText_boxInfo(zgs_console, IG3D_TEXT, getText_boxInfo(zgs_console, IG3D_TEXT).."\n"..txt)
end

function hiliteMarkedObjects()
	--hilite marked objects
	for i=#gObjects,1,-1 do
		local j=1
		m=get(ig3d_material, gObjects[i].cObj, j)
		while (m) do
			if gObjects[i].blinkingRed then
				setMaterialInfo(m, IG3D_EMISSION, gObjects[i].blinkingRed,0,0,1)
				gObjects[i].blinkingRed=gObjects[i].blinkingRed-passed()
				if gObjects[i].blinkingRed<=0 then gObjects[i].blinkingRed=nil end
			else
				setMaterialInfo(m, IG3D_EMISSION, 0,0,0,1)
			end
			j=j+1
			m=get(ig3d_material, gObjects[i].cObj, j)
		end
	
		if gObjects[i].selected then
			local x,y,z=getObjectInfo(gObjects[i].cObj, IG3D_POSITION)
			local xlow,xhigh, ylow,yhigh, zlow,zhigh= getObjectInfo(gObjects[i].cObj, IG3D_BOUNDS)
			local h=yhigh-ylow
			setParticle_emitterInfo(unitMarkerFriendly, IG3D_POSITION, x,y-0.5*h+0.04,z)
			setParticle_emitterInfo(unitMarkerFriendly, IG3D_SIZE, math.max(xhigh-xlow,zhigh-zlow)*2)
			setParticle_emitterInfo(unitMarkerFriendly, IG3D_START)
			if gObjects[i].order then
				if gObjects[i].order.target==nil then
					local nds= getSurroundingNodesOfPosition(x,y,z)
					setParticle_emitterInfo(unitMarkerEnemy, IG3D_SIZE, 1)
					setParticle_emitterInfo(unitMarkerEnemy, IG3D_POSITION, nds[1].x, nds[1].y-0.4, nds[1].z)
					--setParticle_emitterInfo(unitMarkerEnemy, IG3D_START)
					setParticle_emitterInfo(unitMarkerEnemy, IG3D_POSITION, nds[2].x, nds[2].y-0.4, nds[2].z)
					--setParticle_emitterInfo(unitMarkerEnemy, IG3D_START)
					setParticle_emitterInfo(unitMarkerEnemy, IG3D_POSITION, nds[3].x, nds[3].y-0.4, nds[3].z)
					--setParticle_emitterInfo(unitMarkerEnemy, IG3D_START)
					setParticle_emitterInfo(unitMarkerEnemy, IG3D_POSITION, nds[4].x, nds[4].y-0.4, nds[4].z)
					--setParticle_emitterInfo(unitMarkerEnemy, IG3D_START)
					nds=nil
					
					setParticle_emitterInfo(unitMarkerEnemy, IG3D_SIZE, 2)
					if gObjects[i].pth then
						local pthstepper=gObjects[i].pth
						while pthstepper do
							setParticle_emitterInfo(unitMarkerEnemy, IG3D_POSITION, pthstepper.x, pthstepper.y-0.4, pthstepper.z)
							setParticle_emitterInfo(unitMarkerEnemy, IG3D_START)
							pthstepper=pthstepper.next
						end
					
					end
					--setParticle_emitterInfo(unitMarkerEnemy, IG3D_SIZE, 2)
					--setParticle_emitterInfo(unitMarkerEnemy, IG3D_POSITION, gObjects[i].order.x, gObjects[i].order.y+0.04, gObjects[i].order.z)
					
				else		
					x,y,z=getObjectInfo(gObjects[i].order.target.cObj, IG3D_POSITION)
					xlow,xhigh, ylow,yhigh, zlow,zhigh= getObjectInfo(gObjects[i].order.target.cObj, IG3D_BOUNDS)
					h=yhigh-ylow
					setParticle_emitterInfo(unitMarkerEnemy, IG3D_POSITION, x,y-0.5*h+0.04,z)
					setParticle_emitterInfo(unitMarkerEnemy, IG3D_SIZE, math.max(xhigh-xlow,zhigh-zlow)*2)
				end
				setParticle_emitterInfo(unitMarkerEnemy, IG3D_START)
			end
		end
	end
end




kSelectionBoxDist=0.1
-- unselectAllObjects
function unselectAllObjects()
	for i=1,#gObjects,1 do
		gObjects[i].selected=false
	end
end

-- somethingSelected
function somethingSelected()
	local incr
	for incr=1,#gObjects,1 do
		if gObjects[incr].selected then return true end
	end
	return false
end

---some long utility functions outsourced to this file
-- setSelectionRect
function setSelectionRect(left,top,right,bottom)
	local upperleft=get(ig3d_bone, selectionRect.cObj, "one")
	local upperright=get(ig3d_bone, selectionRect.cObj, "three")
	local lowerright=get(ig3d_bone, selectionRect.cObj, "five")
	local lowerleft=get(ig3d_bone, selectionRect.cObj, "seven")
	
	local cx,cy,cz=getCameraInfo(IG3D_POSITION)
	setObjectInfo(selectionRect.cObj, IG3D_POSITION, cx,cy,cz)
	setObjectInfo(selectionRect.cObj, IG3D_ROTATION, 0,0,0)
	
	local a,b,c,d=ig3d_GetWindowBounds__4i()
	left=left+a
	right=right+a
	top=top+b
	bottom=bottom+b
	
	ig3d_FoolMousePosition_2i(left,top)
	local x,y,z,x2,y2,z2=getSceneInfo(IG3D_MOUSE_LINE)
	dx=x2-x
	dy=y2-y
	dz=z2-z
	dx,dy,dz=normalized(dx,dy,dz)
	x=x+dx*kSelectionBoxDist
	y=y+dy*kSelectionBoxDist
	z=z+dz*kSelectionBoxDist
	setBoneInfo(upperleft, IG3D_POSITION, x-cx,y-cy,z-cz)
	ig3d_FoolMousePosition_2i(right,top)
	local x,y,z,x2,y2,z2=getSceneInfo(IG3D_MOUSE_LINE)
	dx=x2-x
	dy=y2-y
	dz=z2-z
	dx,dy,dz=normalized(dx,dy,dz)
	x=x+dx*kSelectionBoxDist
	y=y+dy*kSelectionBoxDist
	z=z+dz*kSelectionBoxDist
	setBoneInfo(upperright, IG3D_POSITION, x-cx,y-cy,z-cz)
	ig3d_FoolMousePosition_2i(right,bottom)
	local x,y,z,x2,y2,z2=getSceneInfo(IG3D_MOUSE_LINE)
	dx=x2-x
	dy=y2-y
	dz=z2-z
	dx,dy,dz=normalized(dx,dy,dz)
	x=x+dx*kSelectionBoxDist
	y=y+dy*kSelectionBoxDist
	z=z+dz*kSelectionBoxDist
	setBoneInfo(lowerright, IG3D_POSITION, x-cx,y-cy,z-cz)
	ig3d_FoolMousePosition_2i(left,bottom)
	local x,y,z,x2,y2,z2=getSceneInfo(IG3D_MOUSE_LINE)
	dx=x2-x
	dy=y2-y
	dz=z2-z
	dx,dy,dz=normalized(dx,dy,dz)
	x=x+dx*kSelectionBoxDist
	y=y+dy*kSelectionBoxDist
	z=z+dz*kSelectionBoxDist
	setBoneInfo(lowerleft, IG3D_POSITION, x-cx,y-cy,z-cz)
	
	local upperleft=get(ig3d_bone, selectionRect.cObj, "two")
	local upperright=get(ig3d_bone, selectionRect.cObj, "four")
	local lowerright=get(ig3d_bone, selectionRect.cObj, "six")
	local lowerleft=get(ig3d_bone, selectionRect.cObj, "eight")
	
	left=left-1
	right=right+1
	top=top-1
	bottom=bottom+1
	
	ig3d_FoolMousePosition_2i(left,top)
	local x,y,z,x2,y2,z2=getSceneInfo(IG3D_MOUSE_LINE)
	dx=x2-x
	dy=y2-y
	dz=z2-z
	dx,dy,dz=normalized(dx,dy,dz)
	x=x+dx*kSelectionBoxDist
	y=y+dy*kSelectionBoxDist
	z=z+dz*kSelectionBoxDist
	setBoneInfo(upperleft, IG3D_POSITION, x-cx,y-cy,z-cz)
	ig3d_FoolMousePosition_2i(right,top)
	local x,y,z,x2,y2,z2=getSceneInfo(IG3D_MOUSE_LINE)
	dx=x2-x
	dy=y2-y
	dz=z2-z
	dx,dy,dz=normalized(dx,dy,dz)
	x=x+dx*kSelectionBoxDist
	y=y+dy*kSelectionBoxDist
	z=z+dz*kSelectionBoxDist
	setBoneInfo(upperright, IG3D_POSITION, x-cx,y-cy,z-cz)
	ig3d_FoolMousePosition_2i(right,bottom)
	local x,y,z,x2,y2,z2=getSceneInfo(IG3D_MOUSE_LINE)
	dx=x2-x
	dy=y2-y
	dz=z2-z
	dx,dy,dz=normalized(dx,dy,dz)
	x=x+dx*kSelectionBoxDist
	y=y+dy*kSelectionBoxDist
	z=z+dz*kSelectionBoxDist
	setBoneInfo(lowerright, IG3D_POSITION, x-cx,y-cy,z-cz)
	ig3d_FoolMousePosition_2i(left,bottom)
	local x,y,z,x2,y2,z2=getSceneInfo(IG3D_MOUSE_LINE)
	dx=x2-x
	dy=y2-y
	dz=z2-z
	dx,dy,dz=normalized(dx,dy,dz)
	x=x+dx*kSelectionBoxDist
	y=y+dy*kSelectionBoxDist
	z=z+dz*kSelectionBoxDist
	setBoneInfo(lowerleft, IG3D_POSITION, x-cx,y-cy,z-cz)
end


function handle_selection_box()
	if click("n") then
		local x,y,z,x2,y2,z2=getSceneInfo(IG3D_MOUSE_LINE)
		local winx,winy,winz=getSceneInfo(IG3D_WINDOW_COORDS, x2,y2,z2)
		
		gDraggingSelRect=true
		gSelectionRect.left=winx
		gSelectionRect.top=winy
		gSelectionRect.right=winx
		gSelectionRect.bottom=winy
		gSelectionRect.clickleft=winx
		gSelectionRect.clicktop=winy
		for i=1,#gObjects,1 do
			gObjects[i].oldSelected=gObjects[i].selected
		end
	end
	
	if click("-") and gDraggingSelRect then
		local x,y,z,x2,y2,z2=getSceneInfo(IG3D_MOUSE_LINE)
		local winx,winy,winz=getSceneInfo(IG3D_WINDOW_COORDS, x2,y2,z2)
		if winx<gSelectionRect.clickleft then
			gSelectionRect.left=winx
			gSelectionRect.right=gSelectionRect.clickleft
		else
			gSelectionRect.left=gSelectionRect.clickleft
			gSelectionRect.right=winx
		end
		if winy<gSelectionRect.clicktop then
			gSelectionRect.top=winy
			gSelectionRect.bottom=gSelectionRect.clicktop			
		else
			gSelectionRect.top=gSelectionRect.clicktop
			gSelectionRect.bottom=winy
		end
		
		
		for i=1,#gObjects,1 do
			gObjects[i].selected=gObjects[i].oldSelected
			local x,y,z=getObjectInfo(gObjects[i].cObj, IG3D_POSITION)
			winx,winy,winz=getSceneInfo(IG3D_WINDOW_COORDS, x,y,z)
			if winz>=0 and gObjects[i].team==gTeamSelect and gObjects[i].alive==true then
				if winx>=gSelectionRect.left then
					if winx<=gSelectionRect.right then
						if winy>=gSelectionRect.top then
							if winy<=gSelectionRect.bottom then
								if key(310,"-") then
									gObjects[i].selected=not gObjects[i].oldSelected
								else
									gObjects[i].selected=true
								end
							end
						end
					end
				end
			end
		end		
	end	
end