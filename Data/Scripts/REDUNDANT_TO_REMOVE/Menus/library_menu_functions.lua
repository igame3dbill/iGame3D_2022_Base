-- FILL THE LIBRARY MENU
LibraryMenuText={"Console","BVH","Emitters","Fluid","FontPngs","GUI","Images","Levels","Scripts","Sounds","Text","Shaders","WIF","WTF"}

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
n=1
	if tPick == "Console" or tPick == "Library/Console" then 
		if console~= nil then
		console:hide()
		console = nil
		end
	OPEN_UI_WINDOWS("console")
	n=0
	end
	
	if string.find(tPick,"WIF") ~= nil then 
		if wifBrowser~= nil then
		wifBrowser:hide()
		wifBrowser = nil
		end	
	OPEN_UI_WINDOWS("wifbrowser")
	n=0
	end
	
	if string.find(tPick,"WTF") ~= nil then 
		if WTFBrowserNew~= nil then
		WTFBrowserNew:hide()
		WTFBrowserNew = nil
		end
	OPEN_UI_WINDOWS("WTFBrowser")
	n=0
	end
if n == 1 then
if uBrowserNew ~= nil then
	uBrowserNew:hide()
	uBrowserNew = nil
	end
OPEN_UI_WINDOWS("UniversalBrowser")
end
end