-- FILL THE EDIT MENU
editMenuText={"Undo","Copy","Paste","Delete","Select All","-","Clear Scene"}
function fill_EditMenu()
n=menuIndexCount+3
mainMenuIndex[n]="Edit"
for i=1,table.getn(editMenuText),1 do
n=n+1
menuLine="Edit/"..editMenuText[i]
menuBar:add(menuLine);
mainMenuIndex[n]=menuLine
end
menuIndexCount=n
end

-- edit Menu Pick
function editMenuPick(tPick)

local xPick=item(-2,tPick,"/")
local yPick=item(-1,tPick,"/")
local mPick=xPick.."/"..yPick
local tTitle=xPick.." "..yPick
local tDir=gameroot.."Data/"
local tFile="empty"
 
print("mPick="..mPick)
if mPick=="Edit/Clear Scene" then tFile =  clearsceneClicked() end
end