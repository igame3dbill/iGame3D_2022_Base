--function make_window()
function showFunctions()
a = parseScriptsForFunctions("Scripts/")
functionsBrowser:clear()

for i,v in pairs(gFunctionsInFile) do 
n=string.find(v,"%(")

if n~=nil then 
n=n-1
o=string.sub(v,1,n)
o=string.gsub(o,"\n","")
functionsBrowser:add(o)
end
end

functionsBrowser:redraw()
end
do widget= fltk:Fl_Double_Window(0,0,0,0,"")
widget:resize(83,50,356,471)
Fl_Group:current():resizable(widget)
--widget:show()
do functionsBrowser= fltk:Fl_Browser(0,0,0,0,"")
functionsBrowser:resize(5,5,345,455)
functionsBrowser:type(2)
functionsBrowser:labelsize(11)
functionsBrowser:textsize(11)
end
end
widget:show()

showFunctions()
--end
Fl:run()
