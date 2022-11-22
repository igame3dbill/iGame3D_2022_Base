
-- wClose
function wClose(w)
w:hide()
w=nil
end


-- FLTK FUNCTIONS
event_constants = {["0"]="FL_NO_EVENT",
	["1"]="FL_PUSH",
	["2"]="FL_RELEASE",
	["3"]="FL_ENTER",
	["4"]="FL_LEAVE",
	["5"]="FL_DRAG",
	["6"]="FL_FOCUS",
	["7"]="FL_UNFOCUS",
	["8"]="FL_KEY",
	["9"]="FL_KEYUP",
	["10"]="FL_MOVE",
	["11"]="FL_SHORTCUT",
	["12"]="FL_ACTIVATE",
	["13"]="FL_DEACTIVATE",
	["14"]="FL_SHOW",
	["15"]="FL_HIDE",
	["16"]="FL_VIEWCHANGE",
	["17"]="FL_PASTE",
	["18"]="FL_DND_ENTER",
	["19"]="FL_DND_DRAG",
	["20"]="FL_DND_LEAVE",
	["21"]="FL_DND_RELEASE"
}
  
  function fltk_event_status()
      Fl:check()
  flevent = Fl:event()
  flmousex=Fl:event_x()
  flmousey=Fl:event_y()
mousexmousey="Fl:event_x()="..flmousex.."\n".."Fl:event_y()="..flmousey
flEventText="Fl:event()="..flevent .. ":   " .. event_constants["" .. flevent]
eventTextOut=mousexmousey.."\n\n"..flEventText  
return   mousexmousey.."\n\n"..flEventText  
end

function flwait()
   fltk_update();
   end
   
 
-- If you are going to use a callback it has to be defined before it's used.
function quit_callback(windowName)
if fltk.fl_choice("Are you sure you want to EXIT ?", "No", "Yes", nil) >= 1 then
windowName:hide()
--os.exit()
end
end

function newWindow(windowName,Flscheme)
  if windowName==nil then windowName="fltk_Fl_Double_Window(W,H,NAME)" end;
if Flscheme==nil then Flscheme="plastic" end;
   windowName = fltk:Fl_Double_Window(240, 200, windowName);
   windowName:box(fltk.FL_UP_BOX);
   windowName:callback(quit_callback)
    windowName:show();
  Fl:scheme(Flscheme)
      Fl:run();
return windowName
end
----------------------------------------------

mousex,mousey=Fl:event_x()..","..Fl:event_y()

function default_window_callback(myValue)
   if (Fl:event() == 12) and (Fl:event_key() == fltk.FL_Escape) then
       print ("No quit on Escape")
       io.flush()
   else
    if fltk.fl_choice("Are you sure you want to EXIT ?", "No", "Yes", nil) >= 1 then
window:hide()
--os.exit()
end
   end
end


