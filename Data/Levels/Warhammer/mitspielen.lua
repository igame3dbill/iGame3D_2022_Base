  function mitspielenClicked(w)
	if joinName:value()=="" then
		fltk.fl_message("Sie muessen sich erst einen Namen geben!")
		return
	end

	control = socket.tcp()
	control:settimeout(10.0)
	host=joinMessage:value()
	port="53839"
	connected,error=control:connect(host,port)
	
	if connected then
		control:settimeout(0.0)
		control:send(joinName:value().."\n")
		
	else
		fltk.fl_message("Keine Antwort vom Server!")
		control=nil
		connected=false
	end
	
end

function armeelisteAuswaehlenC()

	gListenDatei = fltk.fl_file_chooser("Bitte waehlen Sie eine Armeeliste mit max. "..gMaxPunkte.." Punkten aus:", "Army Builder XML Exports (*.{xml})", nil, nil)

	Mitspielen:hide()
	if gListenDatei~= nil then
		loadLevel("Data/Levels/Warhammer")

	else

		

		control:close()

		Hauptmenue:show()	

	end

end

gMeinIndex=2 --client is player 2 always!
gSpieler=0
  do Mitspielen = fltk:Fl_Double_Window(411, 73);
    do joinMessage = fltk:Fl_Input(80, 35, 230, 25, "IP Adresse:");
    end -- Fl_Input* joinMessage
    do local object = fltk:Fl_Button(310, 35, 90, 25, "Mitspielen");
      object:callback(mitspielenClicked);
    end -- Fl_Button* o
    do joinName = fltk:Fl_Input(80, 5, 230, 25, "Dein Name:");
    end -- Fl_Input* joinName
    Fl_Group:current(Fl_Group:current():parent());
  end

  
  function warteAufAkzeptieren()
	fltk_update()
	
	if connected then
		result,e=control:receive()
	
		if e == "closed" then
			fltk.fl_message("Du wurdest als Mitspieler abgelehnt!")
			connected=false
			control=nil
		end
		
		if result~= nil then
		
			if punkteEmpfangen then
				gSpieler=result
				armeelisteAuswaehlenC()
				return
			end
		
			if ackEmpfangen then
				gMaxPunkte=result
				punkteEmpfangen=true
				return
				
			end
			if result=="/ack" then
				joinMessage:value("Akzeptiert -> Spielvorbereitung")
				ackEmpfangen=true
			end
		
		end
	end
end

game_func=warteAufAkzeptieren
setSceneInfo(IG3D_RUN_IN_BACKGROUND, true)
  
  Mitspielen:show();
  ig3d_RebuildMacMenubar();
  if game_func==nil then
  	function runner()
      	fltk_update();
  	end
  	game_func=runner;
  end
  Fl:scheme("plastic")
--Fl:run();
