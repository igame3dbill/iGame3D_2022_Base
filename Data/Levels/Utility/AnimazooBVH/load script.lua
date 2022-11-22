dofile(gameroot.."Data/Scripts/Examples/animazoobvh_parser.lua")

setCameraInfo(IG3D_POSITION, -0.33673650026321, 1.8189750909805, 3.1323306560516)
setCameraInfo(IG3D_ROTATION, 21.666597366333, 175.99995422363, -0)
ig3d_SetMode_i(2)

loadBVHFile(gameroot.."Data/BVH/Animazoo/Dancing - Capoiera.bvh")

--loadBVHFile(gameroot.."Data/BVH/Animazoo/legs crossed lady style.bvh")
--loadBVHFile(gameroot.."Data/BVH/Animazoo/gangster walk.bvh")

--loadBVHFile(gameroot.."Data/BVH/Animazoo/combo left southport.bvh")
--loadBVHFile(gameroot.."Data/BVH/Animazoo/Jumping - Hopping.bvh")
--loadBVHFile(gameroot.."Data/BVH/Animazoo/Running - Jog.bvh")
--loadBVHFile(gameroot.."Data/BVH/Animazoo/machine gun.bvh")
--loadBVHFile(gameroot.."Data/BVH/Animazoo/pointing.bvh")
--loadBVHFile(gameroot.."Data/BVH/Animazoo/walking waving.bvh")
--loadBVHFile(gameroot.."Data/BVH/Animazoo/lean back arms folded.bvh")


setSceneInfo(IG3D_BACKGROUND_COLOR, 1,0,0)

gCurFrame=1

gStart=0.0

function hahaha()
	gStart=gStart+passed()
	local frm=math.floor( gStart/gFrameTime)
	if frm>#poses then gStart=0;frm=1 end	
	itrtr=string.gmatch(poses[frm], "[%w.-]+")
	createLocalMatricesForBVHFrame(rootBone, itrtr)
	if click("-") then
		neutralPose(rootBone)
	end
	fltk_update()
end

edit_func=hahaha
--game_func=hahaha