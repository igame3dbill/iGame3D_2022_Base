dofile(gameroot.."Data/Scripts/Examples/truebonesbvh_parser.lua")
dofile(gameroot.."Data/Fluid/BVHbrowser/BVHbrowser.fl")
ig3d_SetMode_i(2)
loadBVHFile(gameroot.."Data/BVH/TrueBones/A/AddonPak2.BVH")
gCurFrame=1

gStart=0.0

function truebonesbvhtestloop()
	gStart=gStart+passed()
	local frm=math.floor( gStart/gFrameTime)
	if frm>#poses then gStart=0;frm=1 end	
	rootBone.itrtr=string.gmatch(poses[frm], "[%w.-]+")
	
	createLocalMatricesForBVHFrame(rootBone, rootBone.itrtr)
	if click("-") then
		neutralPose(rootBone)
	end
	fltk_update()
end
edit_func=truebonesbvhtestloop

