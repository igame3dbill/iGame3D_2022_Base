--function make_window()
OtherGlobals={{}}
FLTKGlobals={}
OtherFunctions={}
IG3DGlobals={}


function fillbrowsers()
Fbrowser:clear()
Tbrowser:clear()
Hbrowser:clear()
OtherGlobals={}
FLTKGlobals={}
IG3DGlobals={}
OtherFunctions={}
for i,v in pairs(_G) do 
--Fbrowser:add(tostring(i))
--Tbrowser:add(type(v))
s=tostring(v)
a=tostring(i)
sf=string.find(s,":")

if s~= nil  and sf ~=nil then
ss=string.sub(s,sf+1,-1)
collected=false

if string.sub(a,1,3)=="Fl_" or string.sub(a,1,3)=="FL_" or string.sub(a,1,4)=="fltk" then 
table.insert(FLTKGlobals,a) 
collected=true
end
if string.sub(a,1,5)=="ig3d_" then 
table.insert(IG3DGlobals,a) 
collected=true
end

if collected==false then 
if type(v)=="function" then
Fbrowser:add(a)
table.insert(OtherFunctions,v)
else
table.insert(OtherGlobals,v)
Tbrowser:add(a)
--Hbrowser:add(ss)
end
end




--print(tostring(i),type(v),ss)
end

end

Fbrowser:redraw()
Tbrowser:redraw()
Hbrowser:redraw()
end
--TBrowseClick
function TBrowseClick(w)
n=w:value()

if n==nil or n<=0 then return end
a=OtherGlobals[n]
Hbrowser:clear()
		if type(a) == "table" then
			for i,v in pairs(a) do
				if type(v) ~= "table" and type(v) ~= "function" then 
				Hbrowser:add(v) 
				else
				
				--for ii,vv in pairs(v) do
				-- HBrowser:add(ii) 
				 
				--end
				end
		
			end
		
		end
	

end
do GLOBALFUNCTIONS= fltk:Fl_Double_Window(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "GLOBAL FUNCTIONS")
GLOBALFUNCTIONS:label(gLabelTable[#gLabelTable])
GLOBALFUNCTIONS:resize(773,196,708,369)
Fl_Group:current():resizable(GLOBALFUNCTIONS)
--GLOBALFUNCTIONS:show()
do Fbrowser= fltk:Fl_Browser(0,0,0,0,"")
Fbrowser:resize(5,10,235,350)
Fbrowser:type(2)
Fbrowser:textsize(10)
Fl_Group:current():resizable(Fbrowser)
end

do Tbrowser= fltk:Fl_Browser(0,0,0,0,"")
Tbrowser:callback(TBrowseClick)
Tbrowser:resize(245,10,205,350)
Tbrowser:type(2)
Tbrowser:textsize(10)
end

do Hbrowser= fltk:Fl_Browser(0,0,0,0,"")
Hbrowser:resize(455,10,195,350)
Hbrowser:type(2)
Hbrowser:textsize(10)
end
end
GLOBALFUNCTIONS:show()

fillbrowsers()
--end
Fl:run()
