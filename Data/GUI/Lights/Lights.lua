--function make_window()
-- globals_and_functions_codeblock
lightAttributes={"Position","Ambient","Diffuse","Specular","Spot","Attenuate"}
quote ='"'
gLightEditMode = "Position"
gChosenLight = 1

function MaxOfOne(w)
print(tonumber(w))
--if tonumber(w) == nil then return 0 end 
if tonumber(w) >= 1 then return 1 end
--if tonumber(w) <= 0.00004 then return 0.00004 end
end
function getLight(w)
gChosenLight = w:value()+1

ig3d_SetSelection_s("light "..gChosenLight)
displayLightAttribute()
end
function lightsVisibility(w)
lightsVisible = w:label()
if lightsVisible == "Show Lights" then
w:label("Hide Lights")
ig3d_ShowLights_b(true)
else
w:label("Show Lights")
ig3d_ShowLights_b(false)
end
end
function lightBtnClicked(w)
gLightEditMode = w:label()
lightPositionGrp:hide();
lightAmbientGrp:hide();
lightDiffuseGrp:hide();
lightSpecularGrp:hide();
lightSpotGrp:hide();
lightAttenuateGrp:hide();
togglePos:value(0)
toggleAmb:value(0)
toggleDif:value(0)
toggleSpec:value(0)
toggleSpot:value(0)
toggleAtten:value(0)
w:value(1)
displayLightAttribute()
end

function enableButtonClicked(w)

	if getLightInfo(gChosenLight,IG3D_ENABLED) == true then 
	setLightInfo(gChosenLight,IG3D_ENABLED, false)
	else
	setLightInfo(gChosenLight,IG3D_ENABLED, true)
	w:value(1)
	end

	
	lightswindow:redraw()
end
-- displayLightAttribute
function displayLightAttribute()
lightswindow:make_current()
GLEM = gLightEditMode
print(gLightEditMode)
print("gChosenLight="..gChosenLight)
local light_enabled = getLightInfo(gChosenLight,IG3D_ENABLED)
print("light_enabled="..tostring(light_enabled))
	
	
	
	if getLightInfo(gChosenLight,IG3D_ENABLED) == true then 
	lightenableswitch:value(1)
	else
	lightenableswitch:value(0)
	end

light_x,light_y,light_z,light_w = getLightInfo(gChosenLight,IG3D_POSITION)
light_a_R,light_a_G,light_a_B,light_a_A = getLightInfo(gChosenLight,IG3D_AMBIENT)

light_d_R,light_d_G,light_d_B,light_d_A = getLightInfo(gChosenLight,IG3D_DIFFUSE)

light_s_R,light_s_G,light_s_B,light_s_A = getLightInfo(gChosenLight,IG3D_SPECULAR)

light_sp_DX,light_sp_DY,light_sp_DZ,light_sp_C,light_sp_EX = getLightInfo(gChosenLight,IG3D_SPOTLIGHT)

light_C_Att = getLightInfo(gChosenLight,IG3D_CONSTANT_ATTENUATION)
light_L_Att = getLightInfo(gChosenLight,IG3D_LINEAR_ATTENUATION)
light_Q_Att = getLightInfo(gChosenLight,IG3D_QUADRATIC_ATTENUATION)

if gLightEditMode =="Position" then 
	lightPositionGrp:show()
	lightxpos:value(light_x)
	lightypos:value(light_y)
	lightzpos:value(light_z)
	lightwpos:value(light_w)
elseif gLightEditMode =="Ambient" then 
	lightAmbientGrp:show();
	lightramb:value(light_a_R)
	lightgamb:value(light_a_G)
	lightbamb:value(light_a_B)
	lightaamb:value(light_a_A)
elseif gLightEditMode =="Diffuse" then 
	lightDiffuseGrp:show();
	lightdiffuser:value(light_d_R)
	lightdiffuseg:value(light_d_G)
	lightdiffuseb:value(light_d_B)
	lightdiffusea:value(light_d_A)
elseif gLightEditMode =="Specular" then 
	lightSpecularGrp:show();
	lightspecularr:value(light_s_R)
	lightspecularg:value(light_s_G)
	lightspecularb:value(light_s_B)
	lightspeculara:value(light_s_A)
elseif gLightEditMode =="Spot" then 
	lightSpotGrp:show();
	lightspotdx:value(light_sp_DX)
	lightspotdy:value(light_sp_DY)
	lightspotdz:value(light_sp_DZ)
	lightspotcutoff:value(light_sp_C)
	lightspotexponent:value(light_sp_EX)
elseif gLightEditMode =="Attenuate" then 
	lightAttenuateGrp:show();
	lightattenuatequadratic:value(light_Q_Att)
	lightattenuatelinear:value(light_L_Att)
	lightattenuateconstant:value(light_C_Att)
end
	
	lightswindow:redraw()
	
	
end
-- handleLightInput
function handleLightInput(w)
lightswindow:make_current()
local GLEM = gLightEditMode
local wLabel = w:label()

	
print(GLEM)
--local fixVal = MaxOfOne(w:value())
if GLEM == "Position" then 
	togglePos:value(1)
	light_x=lightxpos:value()
	light_y=lightypos:value()
	light_z=lightzpos:value()
	
	light_w=lightwpos:value()	
	
	setLightInfo(gChosenLight,IG3D_POSITION,light_x,light_y,light_z,light_w)
	
elseif GLEM=="Ambient" then
	toggleAmb:value(1)
	light_a_R =lightramb:value()
	light_a_G =lightgamb:value()
	light_a_B =lightbamb:value()
	light_a_A =lightaamb:value()
	setLightInfo(gChosenLight,IG3D_AMBIENT,light_a_R, light_a_G, light_a_B, light_a_A )

elseif GLEM=="Diffuse" then 
	toggleDif:value(1)
	light_d_R =lightdiffuser:value()
	light_d_G =lightdiffuseg:value()
	light_d_B =lightdiffuseb:value()
	light_d_A =lightdiffusea:value()
	
	setLightInfo(gChosenLight,IG3D_DIFFUSE,light_d_R, light_d_G, light_d_B, light_d_A )
	

elseif GLEM=="Specular" then 
	toggleSpec:value(1)
	light_s_R =lightspecularr:value()
	light_s_G =lightspecularg:value()
	light_s_B =lightspecularb:value()
	light_s_A =lightspeculara:value()
	setLightInfo(gChosenLight,IG3D_SPECULAR,light_s_R, light_s_G, light_s_B, light_s_A )

elseif GLEM=="Spot" then 
	toggleSpot:value(1)
	light_sp_DX =lightspotdx:value()
	light_sp_DY =lightspotdy:value()
	light_sp_DZ =lightspotdz:value()
	light_sp_C =lightspotcutoff:value()
	light_sp_EX =lightspotexponent:value()
	
	light_x,light_y,light_z,light_w = getLightInfo(gChosenLight,IG3D_POSITION)	
	setLightInfo(gChosenLight,IG3D_POSITION,light_x,light_y,light_z,1)
	
	setLightInfo(gChosenLight,IG3D_SPOTLIGHT, light_sp_DX, light_sp_DY, light_sp_DZ, light_sp_C, light_sp_EX)
	
elseif GLEM=="Attenuate" then
	toggleAtten:value(1)
	light_Q_Att =lightattenuatequadratic:value()
	light_L_Att =lightattenuatelinear:value()
	light_C_Att =lightattenuateconstant:value()
	
		if wLabel == "Constant" then
		setLightInfo(gChosenLight,IG3D_CONSTANT_ATTENUATION, light_C_Att )
		elseif wLabel == "Linear" then 
		setLightInfo(gChosenLight,IG3D_LINEAR_ATTENUATION , light_L_Att )
		elseif wLabel == "Quadratic" then 
		setLightInfo(gChosenLight,IG3D_QUADRATIC_ATTENUATION , light_Q_Att )
		end 
	end
	
	
lightswindow:redraw()
	displayLightAttribute()
	
end
do lightswindow= fltk:Fl_Double_Window(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Lights")
lightswindow:label(gLabelTable[#gLabelTable])
lightswindow:resize(97,183,480,90)
lightswindow:when(6)
--unknown attribute: noborder
lightswindow:size_range(480,67,480,90)
--lightswindow:show()
do lightChoice= fltk:Fl_Choice(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Light:")
lightChoice:label(gLabelTable[#gLabelTable])
lightChoice:callback(getLight)
lightChoice:resize(5,43,80,20)
lightChoice:down_box(fltk.FL_BORDER_BOX)
lightChoice:labelsize(10)
lightChoice:align(1)
lightChoice:textsize(11)
end

do LightAttributeBtnGrp= fltk:Fl_Group(0,0,0,0,"")
LightAttributeBtnGrp:resize(60,0,441,60)
do lightenableswitch= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Enable")
lightenableswitch:label(gLabelTable[#gLabelTable])
lightenableswitch:callback(enableButtonClicked)
lightenableswitch:resize(60,0,59,25)
lightenableswitch:down_box(fltk.FL_THIN_DOWN_BOX)
lightenableswitch:labelsize(11)
end

do togglePos= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Position")
togglePos:label(gLabelTable[#gLabelTable])
togglePos:callback(lightBtnClicked)
togglePos:resize(120,0,59,25)
togglePos:down_box(fltk.FL_THIN_DOWN_BOX)
togglePos:labelsize(11)
end

do toggleAmb= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Ambient")
toggleAmb:label(gLabelTable[#gLabelTable])
toggleAmb:callback(lightBtnClicked)
toggleAmb:resize(180,0,59,25)
toggleAmb:down_box(fltk.FL_THIN_DOWN_BOX)
toggleAmb:labelsize(11)
end

do toggleDif= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Diffuse")
toggleDif:label(gLabelTable[#gLabelTable])
toggleDif:callback(lightBtnClicked)
toggleDif:resize(240,0,59,25)
toggleDif:down_box(fltk.FL_THIN_DOWN_BOX)
toggleDif:labelsize(11)
end

do toggleSpec= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Specular")
toggleSpec:label(gLabelTable[#gLabelTable])
toggleSpec:callback(lightBtnClicked)
toggleSpec:resize(300,0,59,25)
toggleSpec:down_box(fltk.FL_THIN_DOWN_BOX)
toggleSpec:labelsize(11)
end

do toggleSpot= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Spot")
toggleSpot:label(gLabelTable[#gLabelTable])
toggleSpot:callback(lightBtnClicked)
toggleSpot:resize(360,0,59,25)
toggleSpot:down_box(fltk.FL_THIN_DOWN_BOX)
toggleSpot:labelsize(11)
end

do toggleAtten= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Attenuate")
toggleAtten:label(gLabelTable[#gLabelTable])
toggleAtten:callback(lightBtnClicked)
toggleAtten:resize(420,0,59,25)
toggleAtten:down_box(fltk.FL_THIN_DOWN_BOX)
toggleAtten:labelsize(11)
end
Fl_Group:current(Fl_Group:current():parent())
end

do lightPositionGrp= fltk:Fl_Group(0,0,0,0,"")
lightPositionGrp:resize(90,41,321,22)
lightPositionGrp:labelsize(11)
lightPositionGrp:align(4)
do lightxpos= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "X")
lightxpos:label(gLabelTable[#gLabelTable])
lightxpos:callback(handleLightInput)
lightxpos:resize(90,41,66,22)
lightxpos:labelsize(10)
lightxpos:align(1)
lightxpos:minimum(-1000)
lightxpos:maximum(1000)
lightxpos:step(0.4)
lightxpos:value(1)
lightxpos:textsize(10)
end

do lightypos= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Y")
lightypos:label(gLabelTable[#gLabelTable])
lightypos:callback(handleLightInput)
lightypos:resize(160,41,66,22)
lightypos:labelsize(10)
lightypos:align(1)
lightypos:minimum(-1000)
lightypos:maximum(1000)
lightypos:step(0.4)
lightypos:value(1)
lightypos:textsize(10)
end

do lightzpos= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Z")
lightzpos:label(gLabelTable[#gLabelTable])
lightzpos:callback(handleLightInput)
lightzpos:resize(230,41,66,22)
lightzpos:labelsize(10)
lightzpos:align(1)
lightzpos:minimum(-1000)
lightzpos:maximum(1000)
lightzpos:step(0.4)
lightzpos:value(1)
lightzpos:textsize(10)
end

do lightwpos= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "W")
lightwpos:label(gLabelTable[#gLabelTable])
lightwpos:callback(handleLightInput)
lightwpos:resize(300,41,66,22)
lightwpos:labelsize(10)
lightwpos:align(1)
lightwpos:step(1)
lightwpos:textsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do lightAmbientGrp= fltk:Fl_Group(0,0,0,0,"")
lightAmbientGrp:resize(90,40,321,23)
lightAmbientGrp:labelsize(11)
lightAmbientGrp:align(4)
do lightramb= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "R")
lightramb:label(gLabelTable[#gLabelTable])
lightramb:callback(handleLightInput)
lightramb:resize(90,41,66,22)
lightramb:labelsize(10)
lightramb:align(1)
lightramb:minimum(0.004)
lightramb:step(0.004)
lightramb:value(0.004)
lightramb:textsize(10)
end

do lightgamb= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "G")
lightgamb:label(gLabelTable[#gLabelTable])
lightgamb:callback(handleLightInput)
lightgamb:resize(160,41,66,22)
lightgamb:labelsize(10)
lightgamb:align(1)
lightgamb:minimum(0.004)
lightgamb:step(0.004)
lightgamb:value(0.004)
lightgamb:textsize(10)
end

do lightbamb= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "B")
lightbamb:label(gLabelTable[#gLabelTable])
lightbamb:callback(handleLightInput)
lightbamb:resize(230,41,66,22)
lightbamb:labelsize(10)
lightbamb:align(1)
lightbamb:minimum(0.004)
lightbamb:step(0.004)
lightbamb:value(0.004)
lightbamb:textsize(10)
end

do lightaamb= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "A")
lightaamb:label(gLabelTable[#gLabelTable])
lightaamb:callback(handleLightInput)
lightaamb:resize(300,41,66,22)
lightaamb:labelsize(10)
lightaamb:align(1)
lightaamb:minimum(0.004)
lightaamb:step(0.004)
lightaamb:value(0.004)
lightaamb:textsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do lightDiffuseGrp= fltk:Fl_Group(0,0,0,0,"")
lightDiffuseGrp:resize(90,41,321,22)
lightDiffuseGrp:labelsize(11)
lightDiffuseGrp:align(4)
do lightdiffuser= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "R")
lightdiffuser:label(gLabelTable[#gLabelTable])
lightdiffuser:callback(handleLightInput)
lightdiffuser:resize(90,41,66,22)
lightdiffuser:labelsize(10)
lightdiffuser:align(1)
lightdiffuser:minimum(0.004)
lightdiffuser:step(0.004)
lightdiffuser:value(0.004)
lightdiffuser:textsize(10)
end

do lightdiffuseg= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "G")
lightdiffuseg:label(gLabelTable[#gLabelTable])
lightdiffuseg:callback(handleLightInput)
lightdiffuseg:resize(160,41,66,22)
lightdiffuseg:labelsize(10)
lightdiffuseg:align(1)
lightdiffuseg:minimum(0.004)
lightdiffuseg:step(0.004)
lightdiffuseg:value(0.004)
lightdiffuseg:textsize(10)
end

do lightdiffuseb= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "B")
lightdiffuseb:label(gLabelTable[#gLabelTable])
lightdiffuseb:callback(handleLightInput)
lightdiffuseb:resize(230,41,66,22)
lightdiffuseb:labelsize(10)
lightdiffuseb:align(1)
lightdiffuseb:minimum(0.004)
lightdiffuseb:step(0.004)
lightdiffuseb:value(0.004)
lightdiffuseb:textsize(10)
end

do lightdiffusea= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "A")
lightdiffusea:label(gLabelTable[#gLabelTable])
lightdiffusea:callback(handleLightInput)
lightdiffusea:resize(300,41,66,22)
lightdiffusea:labelsize(10)
lightdiffusea:align(1)
lightdiffusea:minimum(0.004)
lightdiffusea:step(0.004)
lightdiffusea:value(0.004)
lightdiffusea:textsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do lightSpecularGrp= fltk:Fl_Group(0,0,0,0,"")
lightSpecularGrp:resize(90,41,321,24)
lightSpecularGrp:labelsize(11)
lightSpecularGrp:align(4)
do lightspecularr= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "R")
lightspecularr:label(gLabelTable[#gLabelTable])
lightspecularr:callback(handleLightInput)
lightspecularr:resize(90,41,66,22)
lightspecularr:labelsize(10)
lightspecularr:align(1)
lightspecularr:minimum(0.004)
lightspecularr:step(0.004)
lightspecularr:value(0.004)
lightspecularr:textsize(10)
end

do lightspecularg= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "G")
lightspecularg:label(gLabelTable[#gLabelTable])
lightspecularg:callback(handleLightInput)
lightspecularg:resize(160,41,66,22)
lightspecularg:labelsize(10)
lightspecularg:align(1)
lightspecularg:minimum(0.004)
lightspecularg:step(0.004)
lightspecularg:value(0.004)
lightspecularg:textsize(10)
end

do lightspecularb= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "B")
lightspecularb:label(gLabelTable[#gLabelTable])
lightspecularb:callback(handleLightInput)
lightspecularb:resize(230,41,66,22)
lightspecularb:labelsize(10)
lightspecularb:align(1)
lightspecularb:minimum(0.004)
lightspecularb:step(0.004)
lightspecularb:value(0.004)
lightspecularb:textsize(10)
end

do lightspeculara= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "A")
lightspeculara:label(gLabelTable[#gLabelTable])
lightspeculara:callback(handleLightInput)
lightspeculara:resize(300,41,66,22)
lightspeculara:labelsize(10)
lightspeculara:align(1)
lightspeculara:minimum(0.004)
lightspeculara:step(0.004)
lightspeculara:value(0.004)
lightspeculara:textsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do lightSpotGrp= fltk:Fl_Group(0,0,0,0,"")
lightSpotGrp:resize(90,36,411,27)
lightSpotGrp:labelsize(11)
lightSpotGrp:align(4)
do lightspotdx= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "dx")
lightspotdx:label(gLabelTable[#gLabelTable])
lightspotdx:callback(handleLightInput)
lightspotdx:resize(90,41,66,22)
lightspotdx:labelsize(10)
lightspotdx:align(1)
lightspotdx:minimum(-1000)
lightspotdx:maximum(1000)
lightspotdx:step(0.004)
lightspotdx:textsize(10)
end

do lightspotdy= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "dy")
lightspotdy:label(gLabelTable[#gLabelTable])
lightspotdy:callback(handleLightInput)
lightspotdy:resize(160,41,66,22)
lightspotdy:labelsize(10)
lightspotdy:align(1)
lightspotdy:minimum(-1000)
lightspotdy:maximum(1000)
lightspotdy:step(0.004)
lightspotdy:textsize(10)
end

do lightspotdz= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "dz")
lightspotdz:label(gLabelTable[#gLabelTable])
lightspotdz:callback(handleLightInput)
lightspotdz:resize(230,41,66,22)
lightspotdz:labelsize(10)
lightspotdz:align(1)
lightspotdz:minimum(-1000)
lightspotdz:maximum(1000)
lightspotdz:step(0.004)
lightspotdz:textsize(10)
end

do lightspotcutoff= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Cutoff")
lightspotcutoff:label(gLabelTable[#gLabelTable])
lightspotcutoff:callback(handleLightInput)
lightspotcutoff:resize(300,41,66,22)
lightspotcutoff:labelsize(10)
lightspotcutoff:align(1)
lightspotcutoff:minimum(-180)
lightspotcutoff:maximum(180)
lightspotcutoff:step(0.004)
lightspotcutoff:textsize(10)
end

do lightspotexponent= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Exponent")
lightspotexponent:label(gLabelTable[#gLabelTable])
lightspotexponent:callback(handleLightInput)
lightspotexponent:resize(370,41,66,22)
lightspotexponent:labelsize(10)
lightspotexponent:align(1)
lightspotexponent:minimum(1)
lightspotexponent:maximum(32)
lightspotexponent:step(0.004)
lightspotexponent:value(1)
lightspotexponent:textsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do lightAttenuateGrp= fltk:Fl_Group(0,0,0,0,"")
lightAttenuateGrp:resize(90,39,251,24)
lightAttenuateGrp:labelsize(11)
lightAttenuateGrp:align(4)
do lightattenuateconstant= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Constant")
lightattenuateconstant:label(gLabelTable[#gLabelTable])
lightattenuateconstant:callback(handleLightInput)
lightattenuateconstant:resize(90,41,66,22)
lightattenuateconstant:labelsize(10)
lightattenuateconstant:align(1)
lightattenuateconstant:minimum(0.004)
lightattenuateconstant:step(0.004)
lightattenuateconstant:value(0.004)
lightattenuateconstant:textsize(10)
end

do lightattenuatelinear= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Linear")
lightattenuatelinear:label(gLabelTable[#gLabelTable])
lightattenuatelinear:callback(handleLightInput)
lightattenuatelinear:resize(160,41,66,22)
lightattenuatelinear:labelsize(10)
lightattenuatelinear:align(1)
lightattenuatelinear:minimum(0.004)
lightattenuatelinear:step(0.004)
lightattenuatelinear:value(0.004)
lightattenuatelinear:textsize(10)
end

do lightattenuatequadratic= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Quadratic")
lightattenuatequadratic:label(gLabelTable[#gLabelTable])
lightattenuatequadratic:callback(handleLightInput)
lightattenuatequadratic:resize(230,41,66,22)
lightattenuatequadratic:labelsize(10)
lightattenuatequadratic:align(1)
lightattenuatequadratic:minimum(0.004)
lightattenuatequadratic:step(0.004)
lightattenuatequadratic:value(0.004)
lightattenuatequadratic:textsize(10)
end
Fl_Group:current(Fl_Group:current():parent())
end

do toggleLightVisibility= fltk:Fl_Repeat_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Hide Lights")
toggleLightVisibility:label(gLabelTable[#gLabelTable])
toggleLightVisibility:callback(lightsVisibility)
toggleLightVisibility:resize(0,0,59,25)
toggleLightVisibility:labelsize(10)
end
end
lightswindow:show()

for i = 1,8,1 do
lightChoice:add(i)
end

lightChoice:value(0)
lightenableswitch:value(1)

lightAmbientGrp:hide();
lightDiffuseGrp:hide();
lightSpecularGrp:hide();
lightSpotGrp:hide();
lightAttenuateGrp:hide();

togglePos:value(1)
lightswindow:show();
displayLightAttribute()
ig3d_ShowLights_b(true)
getLight(lightChoice)
--print("gChosenLight="..gChosenLight)
--print("gLightEditMode="..gLightEditMode)
-- print("changelight_enabled="..tostring(changelight_enabled))
--end
Fl:run()
