-- FILL THE Objects MENU
ObjectsMenuText={}
ObjectsMenuText.Scene={"Scene"}
function fill_ObjectsMenu()
local i=0;
n=menuIndexCount+3
LibStartVal=n
mainMenuIndex[n]="Objects"
n=n+1
mainMenuIndex[n]="Objects/Add/"
n=n-1
wtfPath=getSceneInfo(IG3D_ROOT).."Data/WTF"
for file in lfs.dir(wtfPath) do
if string.sub(file,-4,-1)==".wtf" then
firstChar=string.upper(string.sub(file,1,1))
if oldChar~=firstChar then
n=n+2
oldChar=firstChar
mainMenuIndex[n]="Objects/Add/"..firstChar.."/"
end
n=n+1
wtfalphabetical="Objects/Add/"..firstChar.."/"..string.sub(file,1,-5)
menuLine=wtfalphabetical
Library_menuBar:add(menuLine);
mainMenuIndex[n]=menuLine
end
end
menuIndexCount=n
n=n+2
ObjectsMenuIndex[n]="Scene"
for i=1,table.getn(ObjectsMenuText.Scene),1 do
n=n+1
menuLine="Objects/"..ObjectsMenuText.Scene[i]
Library_menuBar:add(menuLine);
mainMenuIndex[n]=menuLine
end
menuIndexCount=n
Library_menuBar:value(0)
--print("n="..n)
end

-- loadObject
function loadObject(tfile)
gNumObjects = gNumObjects+1
iWtf = item(-1,tfile,"WTF/")
myWtf = string.sub(iWtf,1,-4)
print("myWTF=",myWtf)
gObjects[gNumObjects]={cObj=make(ig3d_object, myWtf)}
gCurObject=gObjects[gNumObjects].cObj
end

