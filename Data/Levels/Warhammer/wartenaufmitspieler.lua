  function zumHauptmenue()

	server:close()

	WartenAufMitspieler:hide()

	Hauptmenue:show()

end



function akzeptierenClicked(w)

	control:send("/ack\n")

	control:send(gMaxPunkte.."\n")
	
	gMeinIndex=1 --host is player 1
	gSpieler=1
	control:send(gSpieler.."\n") -- host starts by default

	armeelisteAuswaehlen()
	WartenAufMitspieler:hide()

end



function ablehnenClicked(w)

	control:close()

	hostAbort:activate()

	hostDeny:deactivate()

	hostAccept:deactivate()

	connected=false

	enemyName=nil

	control=nil

	hostMessage:value("Warte auf Mitspieler...")

end



function armeelisteAuswaehlen()

	gListenDatei = fltk.fl_file_chooser("Bitte waehlen Sie eine Armeeliste mit max. "..gMaxPunkte.." Punkten aus:", "Army Builder XML Exports (*.{xml})", nil, nil)

	if gListenDatei~= nil then

		loadLevel("Data/Levels/Warhammer")

		

	else

		WartenAufMitspieler:hide()

		control:close()

		Hauptmenue:show()	

	end

end
  do WartenAufMitspieler = fltk:Fl_Double_Window(582, 50, "Warte auf Mitspieler...");
    do hostAbort = fltk:Fl_Button(5, 10, 90, 25, "Abbrechen");
      hostAbort:callback(zumHauptmenue);
    end -- Fl_Button* hostAbort
    do hostMessage = fltk:Fl_Multiline_Output(100, 10, 275, 30);
    end -- Fl_Multiline_Output* hostMessage
    do hostAccept = fltk:Fl_Button(380, 15, 90, 25, "Akzeptieren");
      hostAccept:callback(akzeptierenClicked);
    end -- Fl_Button* hostAccept
    do hostDeny = fltk:Fl_Button(470, 15, 90, 25, "Ablehnen");
      hostDeny:callback(ablehnenClicked);
    end -- Fl_Button* hostDeny
    Fl_Group:current(Fl_Group:current():parent());
  end

  
  hostAccept:deactivate()
hostDeny:deactivate()

host = "*"		--"localhost";
port = "53839";
server = assert(socket.bind(host, port));
server:settimeout(0.0)
ack = "\n";
connected=false
enemyName=nil

setSceneInfo(IG3D_RUN_IN_BACKGROUND, true)

hostMessage:value("Warte auf Mitspieler...")

function waitForJoiningEnemy()
	fltk_update()
	
	if connected==false then
		control = server:accept();
		control:settimeout(0.0)
    
    		connected=true
 
    		
    	else
    		result,e=control:receive()
    		if result~= nil and e==nil then
    			if enemyName==nil then
    				enemyName=result
    				hostMessage:value(enemyName.." moechte mitspielen...")
    				beep()
    				hostAccept:activate()
    				hostDeny:activate()
    				hostAbort:deactivate()
    			end
    		end
    	
    	end
end

game_func=waitForJoiningEnemy
  
  WartenAufMitspieler:show();
  ig3d_RebuildMacMenubar();
  if game_func==nil then
  	function runner()
      	fltk_update();
  	end
  	game_func=runner;
  end
  Fl:scheme("plastic")
--Fl:run();
