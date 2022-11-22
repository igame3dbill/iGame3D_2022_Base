-- Check, if there is already an FPS gun arm, if there is none, create one
gGunArm=get(ig3d_object, "armwithgun1");
if not gGunArm then
	gGunArm=make(ig3d_object, "Weapons/armwithgun");
end
setObjectInfo(gGunArm, IG3D_POSITION, 0.099999964237213,-0.099999994039536,-0.12379701435566);
setObjectInfo(gGunArm, IG3D_ROTATION, 180, 0, 180)
setObjectInfo(gGunArm, IG3D_HUD, true);
--setObjectInfo(gGunArm, IG3D_ANIMATION, "Shoot", 0, true)

