-- FILL THE LIBRARY MENU


function fill_WizardMenu()
wizPath=gameroot.."Data/Wizards/"
wizlist = listFolders(wizPath)

n=menuIndexCount+2
mainMenuIndex[n]="Wizard"
for i,v in pairs(wizlist) do 
if v ~= nil and type(v) ~= "table" then 
  n=n+1
  a=tostring(v) 
  print(a)
wout= string.gsub(a,wizPath,"")
  menuLine="Wizard/"..wout
  print(menuLine)
  menuBar:add(menuLine);
mainMenuIndex[n]=menuLine
end
end
menuIndexCount=n
end


-- Library Menu Callback
function Wizard_menu_callback(w)
print(w:label())
tMenu=w:label()
tVal=w:value()+LibStartVal
tPick=w:text()
--if tPick == "Console" then dofile(gameroot.."Data/Fluid/console/console.lua") end;

print(tMenu,tVal,tPick)
print(tVal,"=",mainMenuIndex[tVal]);
end


function wizardMenuPick(tPick)
gLastMenuPick = tPick
print("wizardMenuPick=",tPick)
OPEN_WIZARD_WINDOWS(tPick) ; -- see file_functions.lua

end