--function make_window()
--callbacks

function spielErstellen()

	dofile(gameroot.."Data/Levels/Warhammer/spielparameter.lua")

	Hauptmenue:hide()

end



function mitspielen()

	dofile(gameroot.."Data/Levels/Warhammer/mitspielen.lua")

	Hauptmenue:hide()

end



function beenden()

	quit()

end
do Hauptmenue= fltk:Fl_Double_Window(0,0,0,0,"")
Hauptmenue:label("Hauptmenue")
Hauptmenue:resize(338,413,202,107)
--Hauptmenue:show()
do widget= fltk:Fl_Button(0,0,0,0,"")
widget:label("Spiel erstellen...")
widget:callback(spielErstellen)
widget:resize(40,15,120,25)
end

do widget= fltk:Fl_Button(0,0,0,0,"")
widget:label("Mitspielen...")
widget:callback(mitspielen)
widget:resize(40,40,120,25)
end

do widget= fltk:Fl_Button(0,0,0,0,"")
widget:label("Beenden")
widget:callback(beenden)
widget:resize(40,65,120,25)
end
end

Hauptmenue:show()
--end
