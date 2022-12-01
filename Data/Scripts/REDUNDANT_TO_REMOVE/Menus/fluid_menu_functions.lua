-- FILL THE FLUID MENU
FluidsMenuText={}

function fill_FluidsMenu()
local i=0;FluidsPath=getSceneInfo(IG3D_ROOT).."Data/Fluid";
n=menuIndexCount
n=n+2
mainMenuIndex[n]="Fluid/"
n=n-1
for file in lfs.dir(FluidsPath) do
if string.sub(file,1,1) ~="." then
if string.sub(file,-4,-4)~="." and string.sub(file,-3,-3) ~="." then
firstChar=string.upper(string.sub(file,1,1))

if firstChar~=oldChar then
oldChar=firstChar
n=n+2
mainMenuIndex[n]="Fluid/"..firstChar.."/"

end
n=n+1
menuLine="Fluid/"..firstChar.."/"..file
menuBar:add(menuLine);
mainMenuIndex[n]=menuLine
print(n, " menuline="..menuLine)
end
end
end
menuBar:value(0)
menuIndexCount=n
end

