--function make_window()
-- See Data/Scripts/Functions/collect_functions.lua
function collectAndResetGameFunc()
	game_func=gOldGameFunc
	local tbl=getListOfAllLevels()
	local i
	local collTbl={}

	
	for i=1,#tbl,1 do
		if tonumber(levelListBrowser:selected(i))==1 then
			table.insert(collTbl, tbl[i])
		end
	end
	
	collectorButton:label("Collecting...")
	Collector:redraw()
	collectLevels(collTbl, collectDestination:value())
	collectorButton:label("Collect Levels")
end

function collectAllSelectedLevels(w)
	--on windows you cant do shit in a callback, make it happen in the next frame!
	gOldGameFunc=game_func
	game_func=collectAndResetGameFunc
end

function selectCollectDestination(w)
	local dirname=fltk.fl_dir_chooser("Please choose a folder to collect the used data to...","/",false)
	if dirname then 
		if string.sub(dirname, -1,-1)~="/" then
			dirname=dirname.."/"
		end
		collectDestination:value(dirname)
	end
end
do Collector= fltk:Fl_Double_Window(0,0,0,0,"")
Collector:resize(132,178,215,259)
--Collector:show()
do levelListBrowser= fltk:Fl_Browser(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Levels to collect")
levelListBrowser:label(gLabelTable[#gLabelTable])
levelListBrowser:resize(5,15,205,170)
levelListBrowser:type(3)
levelListBrowser:labelsize(10)
levelListBrowser:align(5)
levelListBrowser:textsize(10)
end

do collectorButton= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Collect Levels")
collectorButton:label(gLabelTable[#gLabelTable])
collectorButton:callback(collectAllSelectedLevels)
collectorButton:resize(5,230,140,25)
end

do collectDestination= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Collect Destination Directory")
collectDestination:label(gLabelTable[#gLabelTable])
collectDestination:resize(5,200,205,25)
collectDestination:labelsize(10)
collectDestination:align(5)
collectDestination:textsize(10)
end

do widget= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Choose...")
widget:label(gLabelTable[#gLabelTable])
widget:callback(selectCollectDestination)
widget:resize(145,185,65,15)
widget:labelsize(10)
end
end
Collector:show()

Collector:show()



function listLevelsInBrowser()
	levelListBrowser:clear()
	local tbl=getListOfAllLevels()
	local i
	for i=1,#tbl,1 do
		levelListBrowser:add(tbl[i])
	end
end

listLevelsInBrowser()
collectDestination:value("/ig3d_iphone_xcode/build/Optimized-iphoneos/iGame3D.app/")
--end
Fl:run()
