--function make_window()
do kontrolle= fltk:Fl_Double_Window(0,0,0,0,"")
kontrolle:label("Bewegungsphase")
kontrolle:resize(404,101,900,144)
--unknown attribute: hide
do schw1= fltk:Fl_Button(0,0,0,0,"")
schw1:label("Rechtsschwenk")
schw1:callback(rechtsschwenk)
schw1:resize(710,0,110,25)
schw1:type(FLUID_Radio)
end

do schw2= fltk:Fl_Button(0,0,0,0,"")
schw2:label("Linksschwenk")
schw2:callback(linksschwenk)
schw2:resize(490,0,110,25)
schw2:type(FLUID_Radio)
end

do gerade= fltk:Fl_Button(0,0,0,0,"")
gerade:label("Geradeaus")
gerade:callback(geradeaus)
gerade:resize(600,0,110,25)
gerade:type(FLUID_Radio)
end

do bew1= fltk:Fl_Button(0,0,0,0,"")
bew1:label("Angriffe ansagen")
bew1:resize(-1,0,191,25)
bew1:type(FLUID_Toggle)
end

do bew3= fltk:Fl_Button(0,0,0,0,"")
bew3:label("Fliehende Truppen sammeln")
bew3:resize(-1,25,191,25)
bew3:type(FLUID_Toggle)
end

do bew4= fltk:Fl_Button(0,0,0,0,"")
bew4:label("Pflichtbewegungen")
bew4:resize(-1,50,191,25)
bew4:type(FLUID_Toggle)
end

do bew5= fltk:Fl_Button(0,0,0,0,"")
bew5:label("Angreifer bewegen")
bew5:resize(-1,75,191,25)
bew5:type(FLUID_Toggle)
end

do bew6= fltk:Fl_Button(0,0,0,0,"")
bew6:label("Restliche Bewegungen")
bew6:resize(-1,100,191,25)
bew6:type(FLUID_Toggle)
end

do widget= fltk:Fl_Button(0,0,0,0,"")
widget:label("Weiter")
widget:callback(nextPhase)
widget:resize(270,95,100,25)
end

do bew2= fltk:Fl_Button(0,0,0,0,"")
bew2:label("<- Angriffsreaktionen")
bew2:resize(190,0,191,25)
bew2:type(FLUID_Toggle)
end

do valb= fltk:Fl_Value_Output(0,0,0,0,"")
valb:label("B")
valb:resize(320,50,25,25)
valb:align(5)
end

do valkg= fltk:Fl_Value_Output(0,0,0,0,"")
valkg:label("KG")
valkg:resize(345,50,25,25)
valkg:align(5)
end

do valbf= fltk:Fl_Value_Output(0,0,0,0,"")
valbf:label("BF")
valbf:resize(370,50,25,25)
valbf:align(5)
end

do vals= fltk:Fl_Value_Output(0,0,0,0,"")
vals:label("S")
vals:resize(395,50,25,25)
vals:align(5)
end

do valw= fltk:Fl_Value_Output(0,0,0,0,"")
valw:label("W")
valw:resize(420,50,25,25)
valw:align(5)
end

do vallp= fltk:Fl_Value_Output(0,0,0,0,"")
vallp:label("LP")
vallp:resize(445,50,25,25)
vallp:align(5)
end

do vali= fltk:Fl_Value_Output(0,0,0,0,"")
vali:label("I")
vali:resize(470,50,25,25)
vali:align(5)
end

do vala= fltk:Fl_Value_Output(0,0,0,0,"")
vala:label("A")
vala:resize(495,50,25,25)
vala:align(5)
end

do valmw= fltk:Fl_Value_Output(0,0,0,0,"")
valmw:label("MW")
valmw:resize(520,50,25,25)
valmw:align(5)
end

do valname= fltk:Fl_Box(0,0,0,0,"")
valname:label("Name")
valname:resize(205,50,115,25)
end
end

kontrolle:show()
dofile(gameroot.."Data/Levels/Warhammer/init.lua")
--end
