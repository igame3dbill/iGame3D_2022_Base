gTestLight=true--false
	
	function udg_ShadowLights()	
local x,y,z=	getCameraInfo(IG3D_POSITION)
	setLightInfo(1, IG3D_POSITION, x,y+2,z,1)
	setLightInfo(1, IG3D_CONSTANT_ATTENUATION, 1)
	setLightInfo(1, IG3D_LINEAR_ATTENUATION, 0)
	setLightInfo(1, IG3D_QUADRATIC_ATTENUATION, 0.000816326)
	setLightInfo(2, IG3D_POSITION, 150,150,150,0)--for the shadows
	setLightInfo(2, IG3D_POSITION, 50,50,50, 0) --?? why that then?
	end
	
function udg_OneLight()
setLightInfo(1, IG3D_ENABLED, true)
setLightInfo(1, IG3D_POSITION, 49.500000,40.000000,60.000000,1.000000)
setLightInfo(1, IG3D_AMBIENT, 0.000000,0.000000,0.300000,1.000000)
setLightInfo(1, IG3D_DIFFUSE, 0.700000,0.700000,0.700000,1.000000)
setLightInfo(1, IG3D_SPECULAR, 1.000000,1.000000,1.000000,0.700000)
setLightInfo(1, IG3D_CONSTANT_ATTENUATION, 0.700000)
setLightInfo(1, IG3D_LINEAR_ATTENUATION, 0.600000)
setLightInfo(1, IG3D_QUADRATIC_ATTENUATION, 0.0100000)
setLightInfo(1, IG3D_SPOTLIGHT, -0.000000,-0.000000,-0.000000,180.000000,-0.000000)
end
	
function udg_TwoLight()
	setLightInfo(2, IG3D_ENABLED, false)
	setLightInfo(2, IG3D_POSITION, 0.000000,5.000000,7.000000,0.000000)
	setLightInfo(2, IG3D_AMBIENT, 1.000000,1.000000,1.000000,1.000000)
	setLightInfo(2, IG3D_DIFFUSE, 0.000000,0.000000,0.000000,1.000000)
	setLightInfo(2, IG3D_SPECULAR, 0.000000,0.000000,0.000000,1.000000)
	setLightInfo(2, IG3D_CONSTANT_ATTENUATION, 1.000000)
	setLightInfo(2, IG3D_LINEAR_ATTENUATION, 0.000000)
	setLightInfo(2, IG3D_QUADRATIC_ATTENUATION, 0.000000)
	setLightInfo(2, IG3D_SPOTLIGHT, 0.000000,0.000000,0.000000,180.000000,0.000000)
end
	
function udg_ThreeLight()
	setLightInfo(3, IG3D_ENABLED, true)
	setLightInfo(3, IG3D_POSITION, 0.043705,1.996988,0.233521,1.000000)
	setLightInfo(3, IG3D_AMBIENT, 0.000000,0.000000,0.000000,1.000000)
	setLightInfo(3, IG3D_DIFFUSE, 1.000000,0.000000,0.000000,1.000000)
	setLightInfo(3, IG3D_SPECULAR, 1.000000,0.000000,0.000000,1.000000)
	setLightInfo(3, IG3D_CONSTANT_ATTENUATION, 1.000000)
	setLightInfo(3, IG3D_LINEAR_ATTENUATION, 0.200000)
	setLightInfo(3, IG3D_QUADRATIC_ATTENUATION, 0.010000)
	setLightInfo(3, IG3D_SPOTLIGHT, 0.000000,0.000000,0.000000,180.000000,0.000000)
end

function udg_FourLightDark()
	local x,y,z=	getCameraInfo(IG3D_POSITION)
	setLightInfo(4, IG3D_POSITION, x,y,z,1)
	setLightInfo(4, IG3D_ENABLED, true)
	--setLightInfo(4, IG3D_POSITION, -10.400020,3.600000,173.399979,0.000000)
setLightInfo(4, IG3D_AMBIENT, 0.112000,0.044000,0.284000,1.000000)
setLightInfo(4, IG3D_DIFFUSE, 0.144000,0.160000,0.116000,1.000000)
setLightInfo(4, IG3D_SPECULAR, 0.844000,1.000000,0.496000,1.000000)
setLightInfo(4, IG3D_CONSTANT_ATTENUATION, 0.600000)
setLightInfo(4, IG3D_LINEAR_ATTENUATION, 0.000000)
setLightInfo(4, IG3D_QUADRATIC_ATTENUATION, 0.000000)
setLightInfo(4, IG3D_SPOTLIGHT, 0.000000,0.000000,0.000000,180.000000,0.000000)
end

function udg_FourLight()
setSceneInfo(IG3D_TINT_COLOR, 0.300000,0.300000,0.600000)
setSceneInfo(IG3D_FOG, true,0.000000,0.000000,0.000000,6.600000,10.000000)
setSceneInfo(IG3D_BACKGROUND_COLOR, 0.000000,0.000000,0.000000)
setSceneInfo(IG3D_FOV, true, 90.000000)

local x,y,z=	getCameraInfo(IG3D_POSITION)
	setLightInfo(4, IG3D_POSITION, x,y+3,z,1)
	setLightInfo(4, IG3D_ENABLED, true)

setLightInfo(4, IG3D_AMBIENT, 0.500000,0.500000,0.500000,0.700000)
setLightInfo(4, IG3D_DIFFUSE, 0.312000,0.276000,0.116000,1.000000)
setLightInfo(4, IG3D_SPECULAR, 0.744000,0.700000,0.796000,1.000000)
setLightInfo(4, IG3D_CONSTANT_ATTENUATION, 0.0030000)
setLightInfo(4, IG3D_LINEAR_ATTENUATION, 0.00003000)
setLightInfo(4, IG3D_QUADRATIC_ATTENUATION, 0.0161000)
setLightInfo(4, IG3D_SPOTLIGHT, 0.000000,0.000000,0.000000,180.000000,0.000000)
end

function udg_multifollowerLight(x,y,z)
setLightInfo(2, IG3D_POSITION, x,y,z,1)
setLightInfo(2, IG3D_ENABLED, true)
setLightInfo(2, IG3D_POSITION, x,y+6,z,1)
setLightInfo(2, IG3D_AMBIENT, 0.100000,0.100000,0.100000,0.400000)
setLightInfo(2, IG3D_DIFFUSE, 0.200000,0.200000,0.200000,1.000000)
setLightInfo(2, IG3D_SPECULAR, 0.200000,0.200000,0.300000,1.000000)
setLightInfo(2, IG3D_CONSTANT_ATTENUATION, 0.4050000)
setLightInfo(2, IG3D_LINEAR_ATTENUATION, 0.01115300)
setLightInfo(2, IG3D_QUADRATIC_ATTENUATION, 0.0561000)
setLightInfo(2, IG3D_SPOTLIGHT, -0.000000,-0.000000,-0.000000,180.000000,0.000000)
	setLightInfo(3, IG3D_POSITION, x,3,z,1)
	setLightInfo(3, IG3D_ENABLED, true)
setLightInfo(3, IG3D_AMBIENT, 1.000000,1.000000,1.000000,1.000000)
setLightInfo(3, IG3D_DIFFUSE, 0.612000,0.676000,0.616000,1.000000)
setLightInfo(3, IG3D_SPECULAR, 0.344000,0.300000,0.396000,1.000000)
setLightInfo(3, IG3D_CONSTANT_ATTENUATION, 1.000000)
setLightInfo(3, IG3D_LINEAR_ATTENUATION, 0.0200000)
setLightInfo(3, IG3D_QUADRATIC_ATTENUATION, 0.0010000)
setLightInfo(3, IG3D_SPOTLIGHT, 0.00,0.0,0.000000,180.000000,0.000000)

setLightInfo(1, IG3D_POSITION, 0,14,0,1)
setLightInfo(1, IG3D_ENABLED, true)
setLightInfo(1, IG3D_AMBIENT, 0.500000,0.500000,0.500000,1.000000)
setLightInfo(1, IG3D_DIFFUSE, 0.300000,0.300000,0.400000,1.000000)
setLightInfo(1, IG3D_SPECULAR, 0.400000,0.400000,0.400000,1.000000)
setLightInfo(1, IG3D_CONSTANT_ATTENUATION, 1.000000)
	setLightInfo(1, IG3D_LINEAR_ATTENUATION, 0.200000)
	setLightInfo(1, IG3D_QUADRATIC_ATTENUATION, 0.010000)
	setLightInfo(1, IG3D_SPOTLIGHT, 0.000000,0.000000,0.000000,180.000000,0.000000)
end
	
	function udg_LivingInnFiveLight()
	setLightInfo(5, IG3D_ENABLED, true)
	setLightInfo(5, IG3D_POSITION, 30.174551,4.514578,74.231514,1.000000)
	setLightInfo(5, IG3D_AMBIENT, 1.000000,1.000000,1.000000,1.000000)
	setLightInfo(5, IG3D_DIFFUSE, 1.000000,1.000000,1.000000,0.200000)
	setLightInfo(5, IG3D_SPECULAR, 1.000000,1.000000,1.000000,0.500000)
	setLightInfo(5, IG3D_CONSTANT_ATTENUATION, 1.000000)
	setLightInfo(5, IG3D_LINEAR_ATTENUATION, 0.004000)
	setLightInfo(5, IG3D_QUADRATIC_ATTENUATION, 0.008000)
	setLightInfo(5, IG3D_SPOTLIGHT, 0.392000,-0.212000,-0.012000,180.000000,0.000000)
	end
	
function udg_FlareFiveLight()
	setLightInfo(5, IG3D_ENABLED, true)
	setLightInfo(5, IG3D_POSITION, 0.043705,2.996988,0.233521,1.000000)
	setLightInfo(5, IG3D_AMBIENT, 0.000000,0.000000,0.000000,1.000000)
	setLightInfo(5, IG3D_DIFFUSE, 1.000000,0.000000,0.000000,1.000000)
	setLightInfo(5, IG3D_SPECULAR, 1.000000,0.000000,0.000000,1.000000)
	setLightInfo(5, IG3D_CONSTANT_ATTENUATION, 1.000000)
	setLightInfo(5, IG3D_LINEAR_ATTENUATION, 0.200000)
	setLightInfo(5, IG3D_QUADRATIC_ATTENUATION, 0.010000)
	setLightInfo(5, IG3D_SPOTLIGHT, 0.000000,0.000000,0.000000,180.000000,0.000000)
end


function udg_test_light_tint_fog()
	a11,a12,a13,a14,a21,a22,a23,a24,a31,a32,a33,a34,a41,a42,a43,a44=getCameraInfo(IG3D_ROTATION_MATRIX)

	setLightInfo(1, IG3D_POSITION, a41,a42,a43,1)
	setLightInfo(1, IG3D_AMBIENT, 0.1,0.1,0.1,1)
	setLightInfo(1, IG3D_DIFFUSE, 0.4,0.3,0.4,1)
	setLightInfo(1, IG3D_SPECULAR, 0,0,0,0)
	setLightInfo(1, IG3D_CONSTANT_ATTENUATION, 1)
	setLightInfo(1, IG3D_LINEAR_ATTENUATION, 0)
	setLightInfo(1, IG3D_QUADRATIC_ATTENUATION, 0.1)
	setLightInfo(1, IG3D_ENABLED, true)
	--setSceneInfo(IG3D_TINT_COLOR, 1,1,1,1)
	--setSceneInfo(IG3D_FOG, true, 0,0,0,0,10)
	
	setSceneInfo(IG3D_TINT_COLOR, 1.000000,1.000000,1.000000)
setSceneInfo(IG3D_FOG, true,0.000000,0.000000,0.000000,0.000000,10.000000)
setSceneInfo(IG3D_BACKGROUND_COLOR, 0.000000,0.000000,0.000000)
setSceneInfo(IG3D_FOV, true, 90.000000)
	setLightInfo(2, IG3D_POSITION, a41,a42+2,a43,1)
	setLightInfo(2, IG3D_AMBIENT, 0.1,0.1,0.1,1)
	setLightInfo(2, IG3D_DIFFUSE, 1,1,1,1)
	setLightInfo(2, IG3D_SPECULAR, 1,1,1,1)
	setLightInfo(2, IG3D_CONSTANT_ATTENUATION, 1)
	setLightInfo(2, IG3D_LINEAR_ATTENUATION, 0)
	setLightInfo(2, IG3D_QUADRATIC_ATTENUATION, 0.1)
	setLightInfo(2, IG3D_ENABLED, true)
	setLightInfo(3, IG3D_ENABLED, false)
	setLightInfo(4, IG3D_ENABLED, false)
	--setLightInfo(5, IG3D_ENABLED, false)
	--setLightInfo(6, IG3D_ENABLED, false)
	setLightInfo(7, IG3D_ENABLED, false)
	setLightInfo(8, IG3D_ENABLED, false)
end

function GunLightSix(x,y,z)

--setLightInfo(1, IG3D_ENABLED, false)
--setLightInfo(4, IG3D_ENABLED, false)
--setLightInfo(2, IG3D_ENABLED, false)
--setLightInfo(3, IG3D_ENABLED, false)
--setLightInfo(4, IG3D_ENABLED, false)
setLightInfo(6, IG3D_ENABLED, true)
setLightInfo(6, IG3D_POSITION, x,y+1,z)
setLightInfo(6, IG3D_AMBIENT, 1.000000,1.000000,1.000000,1.000000)
setLightInfo(6, IG3D_DIFFUSE, 1.000000,1.000000,0.308000,1.000000)
setLightInfo(6, IG3D_SPECULAR, 1.000000,1.000000,1.000000,1.000000)
setLightInfo(6, IG3D_CONSTANT_ATTENUATION, 1.000000)
setLightInfo(6, IG3D_LINEAR_ATTENUATION, 0.004000)
setLightInfo(6, IG3D_QUADRATIC_ATTENUATION, 0.340000)
setLightInfo(6, IG3D_SPOTLIGHT, 0.000000,-0.020000,0.000000,179.860001,0.000000)
gGunLightCount=0
end

function udg_ScreamLight(obj)
if obj == nil then obj = gScreamer end
if obj == nil then return end
local x,y,z =getObjectInfo(obj.cObj, IG3D_POSITION) 
  gScreamX,gScreamY,gScreamZ=x,y,z

	setLightInfo(5, IG3D_ENABLED, true)
	setLightInfo(5, IG3D_POSITION, x,y+2,z,1)
	setLightInfo(5, IG3D_AMBIENT, 0.000000,0.000000,0.000000,1.000000)
	setLightInfo(5, IG3D_DIFFUSE, 1.000000,0.000000,0.000000,1.000000)
	setLightInfo(5, IG3D_SPECULAR, 1.000000,0.000000,0.000000,1.000000)
	setLightInfo(5, IG3D_CONSTANT_ATTENUATION, 1.000000)
	setLightInfo(5, IG3D_LINEAR_ATTENUATION, 0.200000)
	setLightInfo(5, IG3D_QUADRATIC_ATTENUATION, 0.010000)
	setLightInfo(5, IG3D_SPOTLIGHT, 0.000000,0.000000,0.000000,180.000000,0.000000)
end


function UDGCreditsLighting()
setSceneInfo(IG3D_TINT_COLOR, 1.000000,1.000000,1.000000)
setSceneInfo(IG3D_FOG, false,0.100000,0.000000,0.000000,7.000000,10.00000)
setSceneInfo(IG3D_BACKGROUND_COLOR, -0.000000,-0.000000,-0.000000)
setSceneInfo(IG3D_FOV, true, 90.000000)
setLightInfo(1, IG3D_ENABLED, true)
setLightInfo(1, IG3D_POSITION, 49.500000,40.000000,60.000000,1.000000)
setLightInfo(1, IG3D_AMBIENT, 0.000000,0.000000,0.000000,1.000000)
setLightInfo(1, IG3D_DIFFUSE, 0.700000,0.700000,0.700000,1.000000)
setLightInfo(1, IG3D_SPECULAR, 1.000000,1.000000,1.000000,1.000000)
setLightInfo(1, IG3D_CONSTANT_ATTENUATION, 1.000000)
setLightInfo(1, IG3D_LINEAR_ATTENUATION, 0.200000)
setLightInfo(1, IG3D_QUADRATIC_ATTENUATION, 0.0100000)
setLightInfo(1, IG3D_SPOTLIGHT, -0.000000,-0.000000,-0.000000,180.000000,-0.000000)
setLightInfo(3, IG3D_ENABLED, true)
setLightInfo(3, IG3D_POSITION, 0.043705,1.996988,0.233521,1.000000)
setLightInfo(3, IG3D_AMBIENT, 0.000000,0.000000,0.000000,1.000000)
setLightInfo(3, IG3D_DIFFUSE, 1.000000,0.000000,0.000000,1.000000)
setLightInfo(3, IG3D_SPECULAR, 1.000000,0.000000,0.000000,1.000000)
setLightInfo(3, IG3D_CONSTANT_ATTENUATION, 1.000000)
setLightInfo(3, IG3D_LINEAR_ATTENUATION, 0.200000)
setLightInfo(3, IG3D_QUADRATIC_ATTENUATION, 0.010000)
setLightInfo(3, IG3D_SPOTLIGHT, 0.000000,0.000000,0.000000,180.000000,0.000000)
setLightInfo(4, IG3D_ENABLED, false)
setLightInfo(5, IG3D_ENABLED, true)
setLightInfo(5, IG3D_POSITION, 0.043705,2.996988,0.233521,1.000000)
setLightInfo(5, IG3D_AMBIENT, 0.000000,0.000000,0.000000,1.000000)
setLightInfo(5, IG3D_DIFFUSE, 1.000000,0.000000,0.000000,1.000000)
setLightInfo(5, IG3D_SPECULAR, 1.000000,0.000000,0.000000,1.000000)
setLightInfo(5, IG3D_CONSTANT_ATTENUATION, 1.000000)
setLightInfo(5, IG3D_LINEAR_ATTENUATION, 0.200000)
setLightInfo(5, IG3D_QUADRATIC_ATTENUATION, 0.010000)
setLightInfo(5, IG3D_SPOTLIGHT, 0.000000,0.000000,0.000000,180.000000,0.000000)
setLightInfo(6, IG3D_ENABLED, false)
setLightInfo(7, IG3D_ENABLED, false)
setLightInfo(8, IG3D_ENABLED, false)
end


function UDGWorkLighting()
setSceneInfo(IG3D_TINT_COLOR, 1.000000,1.000000,1.000000)
setSceneInfo(IG3D_FOG, false,0.100000,-0.000000,-0.000000,7.000000,10.000000)
setSceneInfo(IG3D_BACKGROUND_COLOR, 1.000000,1.000000,1.000000)
setSceneInfo(IG3D_FOV, true, 90.000000)
setLightInfo(1, IG3D_ENABLED, true)
setLightInfo(1, IG3D_POSITION, 72.000000,2.924348,74.000000,1.000000)
setLightInfo(1, IG3D_AMBIENT, 1.000000,1.000000,1.000000,1.000000)
setLightInfo(1, IG3D_DIFFUSE, 0.700000,0.700000,0.700000,1.000000)
setLightInfo(1, IG3D_SPECULAR, 1.000000,1.000000,1.000000,1.000000)
--setLightInfo(2, IG3D_ENABLED, false)
--setLightInfo(3, IG3D_ENABLED, false)
--setLightInfo(4, IG3D_ENABLED, false)
--setLightInfo(5, IG3D_ENABLED, false)
--setLightInfo(6, IG3D_ENABLED, false)
--setLightInfo(7, IG3D_ENABLED, false)
--setLightInfo(8, IG3D_ENABLED, false)
setLightInfo(2, IG3D_ENABLED, true)
setLightInfo(2, IG3D_POSITION, 0.000000,5.000000,7.000000,1.000000)
setLightInfo(2, IG3D_AMBIENT, 1.000000,1.000000,1.000000,1.000000)
setLightInfo(2, IG3D_DIFFUSE, 0.700000,0.700000,0.700000,1.000000)
setLightInfo(2, IG3D_SPECULAR, 0.000000,0.000000,0.000000,1.000000)
setLightInfo(2, IG3D_CONSTANT_ATTENUATION, 0.400000)
setLightInfo(2, IG3D_LINEAR_ATTENUATION, 0.400000)
setLightInfo(2, IG3D_QUADRATIC_ATTENUATION, 0.400000)
setLightInfo(2, IG3D_SPOTLIGHT, 0.000000,0.000000,0.000000,180.000000,0.000000)

levelislit = true
end


function UDGLevel1Lighting()

setSceneInfo(IG3D_TINT_COLOR, 0.800000,0.800000,1.000000)
setSceneInfo(IG3D_FOG, true,0.000000,0.000000,0.000000,7.000000,10.00000)
setSceneInfo(IG3D_BACKGROUND_COLOR, -0.000000,-0.000000,-0.000000)
setSceneInfo(IG3D_FOV, true, 90.000000)
setLightInfo(3, IG3D_ENABLED, false)
setLightInfo(5, IG3D_ENABLED, false)
setLightInfo(6, IG3D_ENABLED, false)
setLightInfo(7, IG3D_ENABLED, false)
setLightInfo(8, IG3D_ENABLED, false)

--udg_OneLight()
--udg_TwoLight()
udg_FourLight()
--udg_LivingInnFiveLight()

levelislit = false
end



function udg_snipersalleylights()

setSceneInfo(IG3D_TINT_COLOR, 0.800000,0.800000,1.000000)
setSceneInfo(IG3D_FOG, true,0.000000,0.000000,0.000000,7.000000,10.000000)
setSceneInfo(IG3D_BACKGROUND_COLOR, 0.000000,0.000000,0.000000)
setSceneInfo(IG3D_FOV, true, 90.000000)
setLightInfo(1, IG3D_ENABLED, true)
setLightInfo(1, IG3D_POSITION, 49.500000,40.000000,60.000000,1.000000)
setLightInfo(1, IG3D_AMBIENT, 0.000000,0.000000,0.300000,1.000000)
setLightInfo(1, IG3D_DIFFUSE, 0.700000,0.700000,0.700000,1.000000)
setLightInfo(1, IG3D_SPECULAR, 1.000000,1.000000,1.000000,0.700000)
setLightInfo(1, IG3D_CONSTANT_ATTENUATION, 0.700000)
setLightInfo(1, IG3D_LINEAR_ATTENUATION, 0.600000)
setLightInfo(1, IG3D_QUADRATIC_ATTENUATION, 0.010000)
setLightInfo(1, IG3D_SPOTLIGHT, 0.000000,0.000000,0.000000,180.000000,0.000000)
setLightInfo(2, IG3D_ENABLED, true)
setLightInfo(2, IG3D_POSITION, 0.000000,5.000000,7.000000,1.000000)
setLightInfo(2, IG3D_AMBIENT, 1.000000,1.000000,1.000000,1.000000)
setLightInfo(2, IG3D_DIFFUSE, 0.000000,0.000000,0.000000,1.000000)
setLightInfo(2, IG3D_SPECULAR, 0.000000,0.000000,0.000000,1.000000)
setLightInfo(2, IG3D_CONSTANT_ATTENUATION, 1.000000)
setLightInfo(2, IG3D_LINEAR_ATTENUATION, 0.000000)
setLightInfo(2, IG3D_QUADRATIC_ATTENUATION, 0.000000)
setLightInfo(2, IG3D_SPOTLIGHT, 0.000000,0.000000,0.000000,180.000000,0.000000)
setLightInfo(3, IG3D_ENABLED, true)
local x,y,z=getCameraInfo(IG3D_POSITION)
setLightInfo(3, IG3D_POSITION, x,y,z,1.000000)
setLightInfo(3, IG3D_AMBIENT, 1.000000,1.000000,1.000000,1.000000)
setLightInfo(3, IG3D_DIFFUSE, 1.000000,1.000000,1.000000,1.000000)
setLightInfo(3, IG3D_SPECULAR, 1.000000,0.304000,0.376000,1.000000)
setLightInfo(3, IG3D_CONSTANT_ATTENUATION, 1.000000)
setLightInfo(3, IG3D_LINEAR_ATTENUATION, 0.200000)
setLightInfo(3, IG3D_QUADRATIC_ATTENUATION, 0.010000)
setLightInfo(3, IG3D_SPOTLIGHT, 0.000000,0.000000,0.000000,180.000000,0.000000)
setLightInfo(4, IG3D_ENABLED, false)
setLightInfo(5, IG3D_ENABLED, false)
setLightInfo(6, IG3D_ENABLED, false)
setLightInfo(7, IG3D_ENABLED, false)
end


function udg_Instructions_lightfive()
setSceneInfo(IG3D_TINT_COLOR, 0.300000,0.300000,0.600000)
setSceneInfo(IG3D_FOG, true,0.000000,0.000000,0.000000,6.000000,10.000000)
setSceneInfo(IG3D_BACKGROUND_COLOR, 0.000000,0.000000,0.000000)
setSceneInfo(IG3D_FOV, true, 90.000000)

setLightInfo(5, IG3D_ENABLED, false)
setLightInfo(5, IG3D_POSITION, -14.0,3.0,-3.0,1.000000)
setLightInfo(2, IG3D_AMBIENT, 0.300000,0.300000,0.300000,1.000000)
setLightInfo(2, IG3D_DIFFUSE, 0.300000,0.300000,0.300000,1.000000)
setLightInfo(2, IG3D_SPECULAR, -0.400000,-0.400000,4.000000,1.000000)
setLightInfo(2, IG3D_CONSTANT_ATTENUATION, 0.030000)
setLightInfo(2, IG3D_LINEAR_ATTENUATION, 0.0200)
setLightInfo(2, IG3D_QUADRATIC_ATTENUATION, 0.0080000)
setLightInfo(2, IG3D_SPOTLIGHT, -0.000000,-0.000000,-0.000000,160.000000,0.800000)

udg_FourLight()
end
	
	
function udg_game_light()
if gScreamer ~= nil then 
		udg_ScreamLight()
		else
		setLightInfo(5, IG3D_ENABLED, false)
	 	end 	
	if getLightInfo(6, IG3D_ENABLED) == true then
	gGunLightCount = gGunLightCount + passed()
	local brightness=1.0-gGunLightCount/0.3
	setLightInfo(6, IG3D_AMBIENT, brightness, brightness, brightness,1.000000)
	setLightInfo(6, IG3D_DIFFUSE, brightness, brightness, brightness*0.308000,1.000000)
	setLightInfo(6, IG3D_SPECULAR, brightness, brightness, brightness,1.000000)
	end
	if gGunLightCount > 0.3 then 
		gGunLightCount = 0 
		setLightInfo(6, IG3D_ENABLED, false)
	end

end