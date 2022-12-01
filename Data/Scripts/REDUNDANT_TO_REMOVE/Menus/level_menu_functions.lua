-- FILL THE LEVEL MENU
levelMenuText={"Play","Save","Save As","Reset","New Level","Clear Scene"}

function fill_LevelMenu()
mainMenuIndex[menuIndexCount+1]="Level"
n=menuIndexCount+2
mainMenuIndex[n]="Level"
for i=1,#levelMenuText,1 do
n=n+1
menuLine="Level/"..levelMenuText[i]
menuBar:add(menuLine);
mainMenuIndex[n]=menuLine
end
menuIndexCount=n
end