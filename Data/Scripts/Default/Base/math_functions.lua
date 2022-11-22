SMALL_NUM = 0.000001
rseed=math.randomseed(os.time())
-- "return true if x,y inside of rectangle"
function insideRECT(locx,locy,Left,Top,Right,Bottom)
result=0
if locx >= Left and locx <= Right then result=result+1  end
if locy >= Top and locy <= Bottom then result=result+1  end
if result==2 then 
return true
end
end

-- rnd="random number from lowest to highest"
function rnd(lo,hi)math.randomseed(os.time())result=math.random(lo,hi)return resultend 

-- formattedTime="thetime?"
function formattedTime(n)
local m=math.floor(n/60)
local s=n-(m*60)
if s<10 then
s="0"..s
end
return m..":"..s
end


--------------------------------------------
--copysign(dV,-sV) returns -dV--copysign(-dV,sV) returns dVfunction copysign(destVal, sourceVal)	return math.abs(destVal)*sgn(sourceVal)end--------------------------------------------
function quaternionFromMatrix(m11,m12,m13,m14, m21,m22,m23,m24, m31,m32,m33,m34, m41,m42,m43,m44)
	qw = math.sqrt( math.max(0, 1+m11+m22+m33) ) *0.5
	qx = math.sqrt( math.max(0, 1+m11-m22-m33) ) *0.5
	qy = math.sqrt( math.max(0, 1-m11+m22-m33) ) *0.5
	qz = math.sqrt( math.max(0, 1-m11-m22+m33) ) *0.5
	qx = copysign( qx,m32-m23)
	qy = copysign( qy,m13-m31)
	qz = copysign( qz,m21-m12)
	
	return qw,qx,qy,qz
end
--------------------------------------------
function matrixFromQuaternion(W,X,Y,Z)
	--returns a 3x3 matrix from a given unit quaternion
	local	xx      = X * X;
	local    xy      = X * Y;
	local    xz      = X * Z;
	local    xw      = X * W;

	local    yy      = Y * Y;
	local    yz      = Y * Z;
	local    yw      = Y * W;

	local    zz      = Z * Z;
	local    zw      = Z * W;

	local	m00  = 1 - 2 * ( yy + zz );
	local	m01  =     2 * ( xy - zw );
	local	m02 =     2 * ( xz + yw );

	local	m10  =     2 * ( xy + zw );
	local	m11  = 1 - 2 * ( xx + zz );
	local	m12  =     2 * ( yz - xw );

	local	m20  =     2 * ( xz - yw );
	local	m21  =     2 * ( yz + xw );
	local	m22 = 1 - 2 * ( xx + yy );

	return m00,m01,m02,	m10,m11,m12, m20,m21,m22
end
--------------------------------------------
function slerp(pw,px,py,pz,  qw,qx,qy,qz,   t)
	--print(pw..","..px..","..py..","..pz.."\n")
	--print(qw..","..qx..","..qy..","..qz.."\n")
	cosphi=( pw*qw + px*qx + py*qy + pz*qz );
	if (cosphi<0.0) then
		cosphi=-cosphi
		qw=-qw
		qx=-qx
		qy=-qy
		qz=-qz
	end
		
	if cosphi>(0.9999) then
		return qw,qx,qy,qz
	end
		
		
	local phi=math.acos(cosphi)
	local recsinphi=1.0 / math.sin(phi)
	
	
	local sinphioneminust=math.sin(phi*(1-t))
	local sinphit=math.sin(phi*t)
	local rw = ( pw*sinphioneminust + qw*sinphit ) * recsinphi
	local rx = ( px*sinphioneminust + qx*sinphit ) * recsinphi
	local ry = ( py*sinphioneminust + qy*sinphit ) * recsinphi
	local rz = ( pz*sinphioneminust + qz*sinphit ) * recsinphi
	return rw,rx,ry,rz
end
--------------------------------------------
function quaternionMult(qw,qx,qy,qz,  pw,px,py,pz)
	local rw=(qw*pw)-(qx*px)-(qy*py)-(qz*pz)
	local rx=(qw*px)+(qx*pw)+(qy*pz)-(qz*py)
	local ry=(qw*py)-(qx*pz)+(qy*pw)+(qz*px)
	local rz=(qw*pz)+(qx*py)-(qy*px)+(qz*pw)
	return rw,rx,ry,rz
end
-------------------------------------------




-------------------------------------------
function direction_to_object(obj)
local dir={x= obj.x-camera.x, y= obj.y-camera.y, z= obj.z-camera.z}
return dir
end
-------------------------------------------
function camera_face_object(obj)
local dir=direction_to_object(obj)
camera.xang,camera.yang,camera.zang=dirToAngles(dir.x, dir.y, dir.z)
end
-------------------------------------------
function distance_to_object(obj)
return math.sqrt( (obj.x-camera.x)^2 + (obj.y-camera.y)^2 + (obj.z-camera.z)^2 )
end
-------------------------------------------
function distance_object_to_object(obj1, obj2)
return math.sqrt( (obj1.x-obj2.x)^2 + (obj1.y-obj2.y)^2 + (obj1.z-obj2.z)^2 )
end
-------------------------------------------
function distance_object_to_point(obj1, x,y,z)
return math.sqrt( (obj1.x-x)^2 + (obj1.y-y)^2 + (obj1.z-z)^2 )
end

-------------------------------------------
function matrixMult(a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44,
					b11,b12,b13,b14, b21,b22,b23,b24, b31,b32,b33,b34, b41,b42,b43,b44)

local c11=a11*b11+a12*b21+a13*b31--+a14*b41
local c12=a11*b12+a12*b22+a13*b32--+a14*b42
local c13=a11*b13+a12*b23+a13*b33--+a14*b43
--local c14=a11*b14+a12*b24+a13*b34+a14*b44

local c21=a21*b11+a22*b21+a23*b31--+a24*b41
local c22=a21*b12+a22*b22+a23*b32--+a24*b42
local c23=a21*b13+a22*b23+a23*b33--+a24*b43
--local c24=a21*b14+a22*b24+a23*b34+a24*b44

local c31=a31*b11+a32*b21+a33*b31--+a44*b41
local c32=a31*b12+a32*b22+a33*b32--+a44*b42
local c33=a31*b13+a32*b23+a33*b33--+a44*b43
--local c34=a31*b14+a32*b24+a33*b34+a44*b44

--local c41=a41*b11+a42*b21+a43*b31+a44*b41
--local c42=a41*b12+a42*b22+a43*b32+a44*b42
--local c43=a41*b13+a42*b23+a43*b33+a44*b43
--local c44=a41*b14+a42*b24+a43*b34+a44*b44

return c11,c12,c13,a14,c21,c22,c23,a24,c31,c32,c33,a34,a41,a42,a43,a44
end
-------------------------------------------
function matrixConcat(a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44,
					b11,b12,b13,b14, b21,b22,b23,b24, b31,b32,b33,b34, b41,b42,b43,b44)

local c11=a11*b11+a12*b21+a13*b31+a14*b41
local c12=a11*b12+a12*b22+a13*b32+a14*b42
local c13=a11*b13+a12*b23+a13*b33+a14*b43
local c14=a11*b14+a12*b24+a13*b34+a14*b44

local c21=a21*b11+a22*b21+a23*b31+a24*b41
local c22=a21*b12+a22*b22+a23*b32+a24*b42
local c23=a21*b13+a22*b23+a23*b33+a24*b43
local c24=a21*b14+a22*b24+a23*b34+a24*b44

local c31=a31*b11+a32*b21+a33*b31+a34*b41
local c32=a31*b12+a32*b22+a33*b32+a34*b42
local c33=a31*b13+a32*b23+a33*b33+a34*b43
local c34=a31*b14+a32*b24+a33*b34+a34*b44

local c41=a41*b11+a42*b21+a43*b31+a44*b41
local c42=a41*b12+a42*b22+a43*b32+a44*b42
local c43=a41*b13+a42*b23+a43*b33+a44*b43
local c44=a41*b14+a42*b24+a43*b34+a44*b44

return c11,c12,c13,c14, c21,c22,c23,c24, c31,c32,c33,c34, c41,c42,c43,c44
end
-------------------------------------------
function mat_det33(b11,b12,b13,b21,b22,b23,b31,b32,b33)
return b11*b22*b33 + b12*b23*b31 + b13*b21*b32 - b13*b22*b31 - b11*b23*b32 - b12*b21*b33
end
-------------------------------------------
function mat_inv33(a,b,c,d,e,f,g,h,i)
local mul=1/mat_det33(a,b,c,d,e,f,g,h,i)
local j=(e*i-f*h)*mul
local k=(c*h-b*i)*mul
local l=(b*f-c*e)*mul
local m=(f*g-d*i)*mul
local n=(a*i-c*g)*mul
local o=(c*d-a*f)*mul
local p=(d*h-e*g)*mul
local q=(b*g-a*h)*mul
local r=(a*e-b*d)*mul
return j,k,l,m,n,o,p,q,r
end

-------------------------------------------
function normalized(x,y,z)
l=math.sqrt(x^2+y^2+z^2)
if l > 0 then
x=x/l
y=y/l
z=z/l
end
return x,y,z
end
-------------------------------------------
function angle_delta(a,b)
c=a-b

if c<-180 then
c=c+360
end

if c>180 then
c=c-360
end
return c
end

-------------------------------------------
function dot(x1,x2,x3, y1,y2,y3)
return x1*y1+x2*y2+x3*y3
end

-------------------------------------------
function cross(ax, ay, az, bx, by, bz)
local cx=ay*bz-az*by
local cy=az*bx-ax*bz
local cz=ax*by-ay*bx
return cx, cy, cz
end

-------------------------------------------
function sgn(f)
if f>0 then
return 1.0
end
if f<0 then
return -1.0
end
return 0.0
end



-------------------------------------------
function vecLength(x,y,z)
return math.sqrt( x^2 + y^2 + z^2 )
end

-------------------------------------------

-------------------------------------------
function jiggle(stepvalue,modvalue)
return stepvalue*(-2)+math.random(1,3)*modvalue
end


-------------------------------------------
function GlRect(getWhat)
  glLeft,glTop,glRight,glBottom = ig3d_GetWindowBounds__4i()
   glWidth=math.abs(glRight-glLeft)  
glHeight=math.abs(glBottom-glTop )  
 glLocx= math.abs(glRight-(glWidth/2))  
  glLocy=  math.abs(glBottom-(glHeight/2))  
  if getWhat == nil then return glLeft,glTop,glRight,glBottom 
  elseif getWhat == "w,h"  then  return glWidth,glHeight
  elseif getWhat =="width,height" then  return glWidth,glHeight 
  elseif getWhat == "h,w"  then  return glHeight,glWidth
  elseif  getWhat =="height,width" then  return glHeight,glWidth 
 elseif getWhat == "loc" then return glLocx,glLocy 
  end
 end --GLRECT
 
-------------------------------------------
function groundMesh()
	local sx,bx,sy,by,sz,bz=ig3d_GetMeshBounds__6f()
	ig3d_SetMeshPosition_3f(0.5*(sx+bx), 0.5*(-sy+by), 0.5*(sz+bz))
end

function meshHWD()
local sx,bx,sy,by,sz,bz=ig3d_GetMeshBounds__6f()
local H = bx-sx
local W = by-sy
local D = bz -sz
return H,W,D
end


-------------------------------------------