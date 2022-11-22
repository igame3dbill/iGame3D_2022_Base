-- iGame3D mouse functions defaults
function mouseloc()
  local nx,ny,nz,fx,fy,fz = getSceneInfo(IG3D_MOUSE_LINE)
  local winx,winy,winz = getSceneInfo(IG3D_WINDOW_COORDS, nx,ny,nz)
  local left,top,right,bottom = ig3d_GetWindowBounds__4i()
  local h= left + winx
  local v= top + winy
  
  local glmx,glmy,glmz = ig3d_Get3DPositionFrom2DCoordinates_2ib_3f(h,v,true)
 return glmx,glmy,glmz
  end
  
   -- return true false if inside of rectangle   
function mouseInBox(x1,y1, x2,y2, mx,my)
 if mx>=x1 and mx<=x2 and my>=y1 and my<=y2 then
 return true
 end
 return false
end

 function gridPen()
return 0,0,0
end

-- PathFromMouseDown
ig3d_CreatePath_s("path1")
ig3d_SetPathInfo_is(1,"0,0,0")
function PathFromMouseDown()

 ig3d_SetPathsVisible_b(true)
local x,y,z=mouseloc()
local lineString = x..","..y..","..z
allPoints = ig3d_GetPathInfo_i_s(1).."\n"..lineString
--print(allPoints)
 ig3d_SetPathInfo_is(1,allPoints) 
end --PathFromMouseDown


 
 
function onClickBeep()
	local fx,fy = Fl:event_x_root(), Fl:event_y_root()
--print(fx,fy)
--print(gx,gy,gz)
-- io.flush();
if gx ~= nil and gx ~= 0 then
if click("-") then beep() end
end
 if  ig3d_IsMouseButtonDown__b()  then 
 --print(gEditingMode)
if gEditingMode == "meshtoolPath" then PathFromMouseDown() end
 end
     end


-- return 3D coordinates at mouse point
function mouseCoords()
local x,y,z=getSceneInfo(IG3D_MOUSE_LINE)
x,y,z=getSceneInfo(IG3D_WINDOW_COORDS, x,y,z)
return x,y,z
end




