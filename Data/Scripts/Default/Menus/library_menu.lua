-- FILL THE LIBRARY MENU
LibraryMenuText={"Console","Collect","BVH","Emitters","Fluid","FontPngs","GUI","Images","Levels","Scripts","Sounds","Text","Shaders","WIF","WTF"}

function fill_LibraryMenu()
n=menuIndexCount+2
mainMenuIndex[n]="Library"
for i=1,#LibraryMenuText,1 do
  n=n+1
  menuLine="Library/"..LibraryMenuText[i]
  menuBar:add(menuLine);
mainMenuIndex[n]=menuLine
end
menuIndexCount=n
end


-- Library Menu Callback
function Library_menu_callback(w)
print(w:label())
tMenu=w:label()
tVal=w:value()+LibStartVal
tPick=w:text()
--if tPick == "Console" then dofile(gameroot.."Data/Fluid/console/console.lua") end;

print(tMenu,tVal,tPick)
print(tVal,"=",mainMenuIndex[tVal]);
end


function libraryMenuPick(tPick)
gLastMenuPick = tPick
print("libraryMenuPick=",tPick)

UniversalBrowse(tPick) ; -- see file_functions.lua

end