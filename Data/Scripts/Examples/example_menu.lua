#!/usr/bin/murgaLua
--
-- Menu example
--
function menu_callback(w)
   print (w:text());
   io.flush();
end

local window = fltk:Fl_Double_Window(394, 150);
local menuBar = fltk:Fl_Menu_Bar(0, 0, 395, 25);
menuBar:callback(menu_callback);
menuBar:add("&First menu item/First item");
menuBar:shortcut(1, fltk.FL_CTRL + string.byte("f"));
menuBar:add("First menu item/Second test");
menuBar:shortcut(2, fltk.FL_ALT + string.byte("s"));
menuBar:add("First menu item/Third test");
menuBar:mode(3, fltk.FL_MENU_TOGGLE);

menuBar:add("Second menu item/&First item");
menuBar:add("Second menu item/&Second test");
menuBar:add("Second menu item/&Third test");	
menuBar:global()
window:show();
