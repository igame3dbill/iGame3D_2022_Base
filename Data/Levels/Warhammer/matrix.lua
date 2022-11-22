
function build4x4matrix(obj)
	local a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=getObjectInfo(obj.cObj, IG3D_ROTATION_MATRIX)
	local t={ {a11,a12,a13,a14}, {a21,a22,a23,a24}, {a31,a32,a33,a34}, {a41,a42,a43,a44} }
	return t
end

function matrixtransform(mat, x,y,z)
	local tx=mat[1][1]*x+mat[2][1]*y+mat[3][1]*z+mat[4][1]
	local ty=mat[1][2]*x+mat[2][2]*y+mat[3][2]*z+mat[4][2]
	local tz=mat[1][3]*x+mat[2][3]*y+mat[3][3]*z+mat[4][3]
	return tx,ty,tz
end