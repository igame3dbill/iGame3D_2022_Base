-- Menu Globals
mainMenuIndex={}
menuIndexCount=1
LibStartVal=1
oldChar=" "
lastLoadedFile = "default"
gLastMenuPick = ""
-- Fill Menu Bar
function FillMenuBar()
fill_FileMenu();
fill_EditMenu();
fill_LevelMenu();
	--fill_FluidsMenu();
fill_EntityMenu()
fill_LibraryMenu();
	--fill_LevelsMenu();
	--fill_MeshMenu();
	--fill_ObjectsMenu();
end

-- main_menu_callback

function main_menu_callback(w)
tMenu=w:label()
tVal=w:value()
tPick=w:text()
tIndex=mainMenuIndex[tVal]
tIndex1=mainMenuIndex[tVal+1]
gLastMenuPick = ""
if tIndex ~= nil then
menuHead=item(1,tIndex,"/")
--tPick = item(2,tIndex,"/")
print("main_menu_callback=",tMenu,tVal,tPick,menuHead,"\ntIndex,tIndex1=",tIndex,tIndex1)
	if string.find(tIndex,"/")  then
		if menuHead == "File" then fileMenuPick(tIndex)
		elseif menuHead == "Edit" then editMenuPick(tIndex)
		elseif menuHead == "Level" then levelMenuPick(tIndex)
		elseif string.find(menuHead,"Library") then libraryMenuPick(tIndex1)
		elseif menuHead == "Entity" then entityMenuPick(tIndex1)
		end	
	else
		if tIndex1 ~= nil then 
		menuHead=item(1,tIndex1,"/")
		tPick = item(2,tIndex1,"/")
		print("main_menu_callback1=",tPick,menuHead,"\ntIndex,tIndex1=",tIndex,tIndex1)
		if  menuHead == "Library" then libraryMenuPick(tPick) end
	     if menuHead == "Entity" then entityMenuPick(tIndex1) end
	
	end
	end
end
end


-- output menu Indices
function outputMenuIndices(tVal)
-- fileMenuPick(mainMenuIndex[tVal]);
--print("+1=",tVal+1,mainMenuIndex[tVal+1])
 -- print("+2=",tVal+2,mainMenuIndex[tVal+2])
 print(tVal,"=",mainMenuIndex[tVal]);
--print("-1=",tVal-1,mainMenuIndex[tVal-1])
 -- print("-2=",tVal-2,mainMenuIndex[tVal-2])
 end