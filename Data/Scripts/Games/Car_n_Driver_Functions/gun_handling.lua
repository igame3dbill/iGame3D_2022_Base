function handle_guns()
	--first position all the guns
	local i
	for i=1,#guns,1 do
			attachGunToObject(guns[i][1].cObj, guns[i][2].cObj, "RightHand", "LowerRightArm", "RightArm")
	end
end