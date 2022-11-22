function printtablerec(t)
	if t== nil then return end
	
	for i=1,#t,1 do
	if type(t[i])=="table" then
		
		printtablerec(t[i])
	else
		print(t[i])
	end
end
end

gObjects={}

dofile(gameroot.."Data/Levels/Warhammer/einheit.lua")

dofile(gameroot.."Data/Levels/Warhammer/warhammer.fl")
