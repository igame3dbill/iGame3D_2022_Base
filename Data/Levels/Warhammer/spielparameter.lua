  function spielVeroeffentlichen(w)
	dofile(gameroot.."Data/Levels/Warhammer/wartenaufmitspieler.lua")
	SpielParameter:hide()
	
end

function punkteLimitChanged(w)
	gMaxPunkte=w:value()
end

gMaxPunkte=2000
  do SpielParameter = fltk:Fl_Double_Window(280, 131);
    do local object = fltk:Fl_Button(50, 90, 150, 25, "Hosten...");
      object:callback(spielVeroeffentlichen);
    end -- Fl_Button* o
    do local object = fltk:Fl_Value_Input(125, 30, 75, 25, "Punktelimit");
      object:minimum(500);
      object:maximum(10000);
      object:step(50);
      object:value(2000);
      object:callback(punkteLimitChanged);
    end -- Fl_Value_Input* o
    Fl_Group:current(Fl_Group:current():parent());
  end

  
  
  SpielParameter:show();
  ig3d_RebuildMacMenubar();
  if game_func==nil then
  	function runner()
      	fltk_update();
  	end
  	game_func=runner;
  end
  Fl:scheme("plastic")
--Fl:run();
