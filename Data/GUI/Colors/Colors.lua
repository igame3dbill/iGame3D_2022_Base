--function make_window()
-- globals_and_functions_codeblock
colorAttributes={"Ambient","Diffuse","Specular","Alpha"}
gColorEditMode = "Background"
gColorAttribute = "Ambient"
gColorTargets = {"Background","Grid","Fog","Light","Object","Material","Tint"}
gfogEnabled, gFogRed, gFogGreen, gFogBlue, gFogstart, gFogend = getSceneInfo(IG3D_FOG)

colorsourcefile = gameroot.."Data/Images/Colors/colorsource.png"
loadTexture("Data/Images/Colors/colorsource.png") 
fltk.fl_register_images()
quote ='"'
gRed,gBlue,gGreen,Alpha = 1,1,1,1
gRed, gGreen, gBlue = getSceneInfo(IG3D_BACKGROUND_COLOR)
gAlpha = 1
choosr,choosg,choosb = (gRed +1) * 254, (gGreen+1) * 254, (gBlue+1) * 254
 setSceneInfo(IG3D_FOG, gfogEnabled, gRed, gGreen, gBlue, gFogstart, gFogend )
function MaxOfOne(w)
print(tonumber(w))
--if tonumber(w) == nil then return 0 end 
if tonumber(w) >= 1 then return 1 end
--if tonumber(w) <= 0.00004 then return 0.00004 end
end
-- displayColorAttribute
function displayColorAttribute()
colorswindow:make_current()
	--toggleAmb:value(0)
	--toggleDif:value(0)
	--toggleSpec:value(0)
	toggleEditBackground:value(0)
	toggleEditFog:value(0)
	toggleEditGrid:value(0)
	toggleEditTint:value(0)
	--toggleEditMeshMaterial:value(0)
	--toggleEditObjectMaterial:value(0)
	--toggleEditLight:value(0)
	fogStartFld:hide()
	fogEndFld:hide()
	toggleFogEnable:hide()
	Afld:hide()
	
	if gColorEditMode == "Fog" then 
	fogStartFld:show()
	fogEndFld:show()
	toggleFogEnable:show()
	else
	fogStartFld:hide()
	fogEndFld:hide()
	toggleFogEnable:hide()
	end
	
	colorswindow:redraw()
print(gColorEditMode)

	if gColorEditMode == "Light" then 
	toggleEditLight:value(1)
		if gChosenLight == nil then gChosenLight = 1 end
		
		if  gColorAttribute =="Ambient" then 
			gRed, gGreen, gBlue, gAlpha  = getLightInfo(gChosenLight,IG3D_AMBIENT)	
				toggleAmb:value(1)
		elseif gColorAttribute =="Diffuse" then 
			gRed, gGreen, gBlue, gAlpha = getLightInfo(gChosenLight,IG3D_DIFFUSE)
				toggleDif:value(1)
		elseif gColorAttribute =="Specular" then 
			gRed, gGreen, gBlue, gAlpha = getLightInfo(gChosenLight,IG3D_SPECULAR)
				toggleSpec:value(1)
		end
	end

	if gColorEditMode == "Background" then
		gRed, gGreen, gBlue = getSceneInfo(IG3D_BACKGROUND_COLOR)
		toggleEditBackground:value(1)
	
	elseif  gColorEditMode == "Grid"  then	
		--gRed, gGreen, gBlue = ig3d_GetGridColor_3f(IG3D_GRID_COLOR)
		toggleEditGrid:value(1)
	
	elseif  gColorEditMode == "Fog"  then
		gfogEnabled, gRed, gGreen, gBlue, gFogstart, gFogend = getSceneInfo(IG3D_FOG)
		toggleEditFog:value(1)
	if gfogEnabled == true then 
	toggleFogEnable:value(1)
	else
	toggleFogEnable:value(0)
	end
	
	elseif  gColorEditMode == "Object"  then
		toggleEditObjectMaterial:value(1)
	
	elseif  gColorEditMode == "Mesh"  then
		toggleEditMeshMaterial:value(1)
	
	elseif gColorEditMode == "Tint" then
		toggleEditTint:value(1)
		gRed, gGreen, gBlue = getSceneInfo(IG3D_TINT_COLOR)
		toggleEditTint:value(1)
	end
	
	Rfld:value(gRed)
	Gfld:value(rGreen)
	Bfld:value(rBlue)
	Afld:value(gAlpha)
	fogStartFld:value(gFogStart)
	fogEndFld:value(gFogend)
	
	colorswindow:redraw()

	
end
-- applyColor

function applyColor()


	
	if gColorEditMode == "Background" then
		ig3d_SetBackgroundColor_3f(gRed, gGreen, gBlue)
	elseif  gColorEditMode == "Grid"  then	
		ig3d_SetGridColor_3f(gRed, gGreen, gBlue)
		
		elseif  gColorEditMode == "Fog"  then
	          setSceneInfo(IG3D_FOG,gfogEnabled, gRed, gGreen, gBlue, gFogstart, gFogend)
		
		--elseif  gColorEditMode == "Object"  then
		--elseif  gColorEditMode == "Material"  then
	elseif gColorEditMode == "Tint" then
		setSceneInfo(IG3D_TINT_COLOR, gRed, gGreen, gBlue)
	
	end

        
	if gColorEditMode == "Light" then 
		if gColorAttribute =="Ambient" then
			setLightInfo(gChosenLight,IG3D_AMBIENT, gRed, gGreen, gBlue, gAlpha )
		elseif gColorAttribute =="Diffuse" then 
			setLightInfo(gChosenLight,IG3D_DIFFUSE, gRed, gGreen, gBlue, gAlpha )
		elseif gColorEditMode =="Specular" then 
			setLightInfo(gChosenLight,IG3D_SPECULAR, gRed, gGreen, gBlue, gAlpha )
		end
	end
	
	
end
-- colorBtnClicked
function colorBtnClicked(w)
	wLabel=w:label()
	w:value(1)		
		for i=1,#gColorTargets,1 do
				if wLabel == gColorTargets[i] then 
				gColorEditMode = wLabel 
				colorswindow:label(gColorEditMode.." Color")			
				else
				gColorAttribute = wLabel
				end
			end
	
		if gColorEditMode == "Fog" then 
			if wLabel == "Enable" then 
				if gfogEnabled == true then 
				gfogEnabled = false
				applyColor()
				w:value(0)
				else
				gfogEnabled = true
				applyColor()
				w:value(1)
				end
				else
				 showColorChooser()
			end
			displayColorAttribute()
			return
		end
		
		displayColorAttribute()	
	
	 showColorChooser()
	end
-- colormap_cb
function colormap_cb()
	local newcolor=fltk.fl_show_colormap(colormap:color())
--	colormap:hide() -- so there is no label overlap
	colormap:color(newcolor)
	colormap:label("FLTK Color "..newcolor)
	w:redraw()
	colormap:show()
	colormap:set_changed()
	colormap:redraw_label()
       Fl:flush()
end
-- handleColorInput
function handleColorInput(w)
local wLabel = w:label()	
	if wLabel =="Ambient" then
		toggleAmb:value(1)
		displayColorAttribute()
	elseif wLabel =="Diffuse" then 
		toggleDif:value(1)
		displayColorAttribute()
	elseif wLabel =="Specular" then 
		toggleSpec:value(1)
		displayColorAttribute()
	end
	if wLabel == "R" then 
		gRed = Rfld:value()
		applyColor()	
	elseif wLabel == "G" then 
		 gGreen = Gfld:value()
		 applyColor()
	elseif wLabel == "B" then
		gBlue = Bfld:value()
		applyColor()	
	elseif wLabel == "A" then 
		gAlpha = Afld:value()
		applyColor()
	end
	if wLabel == "Start"  then 
	gfogEnabled, gRed, gGreen, gBlue, gFogstart, gFogend = getSceneInfo(IG3D_FOG)
	gFogstart = w:value()
	applyColor()
	elseif wLabel == "End" then 
	gfogEnabled, gRed, gGreen, gBlue, gFogstart, gFogend = getSceneInfo(IG3D_FOG)
	gFogend = w:value()
	applyColor()
	end
end -- handleColorInput
-- showColorChooser
function showColorChooser()
	displayColorAttribute()
	choosr,choosg,choosb= (gRed * 255) , (gGreen * 255), (gBlue *255)
	color_ok, choosr, choosg , choosb = fltk.fl_color_chooser(gColorEditMode,choosr,choosg,choosb)	
	if color_ok == 1 then -- color_ok represents the first value (exit status) returned by fl_color_chooser
	Fl:set_color(15,choosr,choosg,choosb) -- change color 15
 	gRed, gGreen, gBlue = (choosr) / 255.0, (choosg) / 255.0, (choosb) / 255.0
 	colorswindow:make_current()	
	Rfld:value(gRed)
	Gfld:value(gGreen)
	Bfld:value(gBlue)
	colorswindow:redraw()
	applyColor()	
	end
end
-- colorFromSource
function colorFromSource(w)
texFile = ColorSource:image()
wleft=w:x()
wtop=w:y()
wright=wleft+w:w()
wbottom=wtop+w:h()
mousex, mousey = Fl:event_x_root() , Fl:event_y_root()
gRed, gGreen, gBlue, gAlpha = ig3d_GetColorInTexture_s6i_4f(texFile, wleft, wtop, wright, wbottom, mousex, mousey)
print(texFile, wleft, wtop, wright, wbottom, mousex, mousey, gRed, gGreen, gBlue)
end
-- color_event_callback
function color_event_callback(w)
if colorswindow == nil then return end
    evt = Fl:event()
	if (evt) then
	mousex = Fl:event_x()
	mousey = Fl:event_y()
		print(evt .. "   " .. murgaLua.getFltkEventText(evt))
		if (evt == 7) then tCount = 99999999 end
		if (evt == 5) then
			texFile = "/Data/Images/Colors/colorsource.png";
			--gRed, gGreen, gBlue, gAlpha = ig3d_GetColorInTexture_s6i_4f(texFile, 1, 1, 360, 72, mousex, mousey)
			print(mousex, mousey, gRed, gGreen, gBlue, gAlpha)
		end
	end
    colorswindow:redraw()
end
do colorswindow= fltk:Fl_Double_Window(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Colors")
colorswindow:label(gLabelTable[#gLabelTable])
colorswindow:resize(40,183,347,76)
colorswindow:when(3)
Fl_Group:current():resizable(colorswindow)
colorswindow:size_range(303,82,303,82)
--colorswindow:show()
do Rfld= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "R")
Rfld:label(gLabelTable[#gLabelTable])
Rfld:callback(handleColorInput)
Rfld:resize(5,38,66,22)
Rfld:labelsize(10)
Rfld:align(1)
Rfld:minimum(0.001)
Rfld:step(0.001)
Rfld:value(0.001)
Rfld:textsize(10)
end

do Gfld= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "G")
Gfld:label(gLabelTable[#gLabelTable])
Gfld:callback(handleColorInput)
Gfld:resize(73,38,66,22)
Gfld:labelsize(10)
Gfld:align(1)
Gfld:minimum(0.001)
Gfld:step(0.001)
Gfld:value(0.001)
Gfld:textsize(10)
end

do Bfld= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "B")
Bfld:label(gLabelTable[#gLabelTable])
Bfld:callback(handleColorInput)
Bfld:resize(140,38,66,22)
Bfld:labelsize(10)
Bfld:align(1)
Bfld:minimum(0.001)
Bfld:step(0.001)
Bfld:value(0.001)
Bfld:textsize(10)
end

do Afld= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "A")
Afld:label(gLabelTable[#gLabelTable])
Afld:callback(handleColorInput)
Afld:resize(205,38,66,22)
Afld:labelsize(10)
Afld:align(1)
Afld:minimum(0.001)
Afld:step(0.001)
Afld:value(0.001)
Afld:textsize(10)
end

do fogStartFld= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Start")
fogStartFld:label(gLabelTable[#gLabelTable])
fogStartFld:callback(handleColorInput)
fogStartFld:resize(207,38,66,22)
fogStartFld:labelsize(10)
fogStartFld:align(1)
fogStartFld:minimum(-200)
fogStartFld:maximum(4000)
fogStartFld:step(0.05)
fogStartFld:value(0.1)
fogStartFld:textsize(10)
end

do fogEndFld= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "End")
fogEndFld:label(gLabelTable[#gLabelTable])
fogEndFld:callback(handleColorInput)
fogEndFld:resize(274,38,66,22)
fogEndFld:labelsize(10)
fogEndFld:align(1)
fogEndFld:minimum(-100)
fogEndFld:maximum(4000)
fogEndFld:step(0.05)
fogEndFld:value(0.5)
fogEndFld:textsize(10)
end

do toggleEditBackground= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Background")
toggleEditBackground:label(gLabelTable[#gLabelTable])
toggleEditBackground:callback(colorBtnClicked)
toggleEditBackground:resize(5,5,68,20)
toggleEditBackground:down_box(fltk.FL_THIN_DOWN_BOX)
toggleEditBackground:labelsize(11)
end

do toggleEditGrid= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Grid")
toggleEditGrid:label(gLabelTable[#gLabelTable])
toggleEditGrid:callback(colorBtnClicked)
toggleEditGrid:resize(72,5,68,20)
toggleEditGrid:down_box(fltk.FL_THIN_DOWN_BOX)
toggleEditGrid:labelsize(11)
end

do toggleEditTint= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Tint")
toggleEditTint:label(gLabelTable[#gLabelTable])
toggleEditTint:callback(colorBtnClicked)
toggleEditTint:resize(138,5,68,20)
toggleEditTint:down_box(fltk.FL_THIN_DOWN_BOX)
toggleEditTint:labelsize(11)
end

do toggleEditFog= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Fog")
toggleEditFog:label(gLabelTable[#gLabelTable])
toggleEditFog:callback(colorBtnClicked)
toggleEditFog:resize(204,5,68,20)
toggleEditFog:down_box(fltk.FL_THIN_DOWN_BOX)
toggleEditFog:labelsize(11)
end

do toggleFogEnable= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Enable")
toggleFogEnable:label(gLabelTable[#gLabelTable])
toggleFogEnable:callback(colorBtnClicked)
toggleFogEnable:resize(270,5,68,20)
toggleFogEnable:down_box(fltk.FL_THIN_DOWN_BOX)
toggleFogEnable:labelsize(11)
end
end
colorswindow:show()

-- pop=fltk:Fl_Return_Button(left+bw,row+bw,bw*16,80,"push for built-in color map")
colormap=fltk:Fl_Button(10,10,20,20,"fl_show_colormap")
colormap:align(fltk.FL_ALIGN_BOTTOM)
--colormap:callback(colormap_cb)

colorchooser=fltk:Fl_Button(1,1,10,10,"fl_color_chooser")
colorchooser:align(fltk.FL_ALIGN_BOTTOM)
colorchooser:color(15)
colorchooser:callback(showColorChooser)
color_cube=fltk:Fl_Box(380,260,100,80,"fl_color_cube")
color_cube:align(fltk.FL_ALIGN_BOTTOM)
color_cube:box(fltk.FL_UP_BOX)
--
colorswindow:show();
colorswindow:make_current()
colorswindow:redraw()
displayColorAttribute()
--end
Fl:run()
