gBoneStart=0
gYMod=0
gFirstFrame=true

function startTabsRemoved(str)
	while string.sub(str, 1,1)=="	" or string.sub(str, 1,1) == " " do
		str=string.sub(str, 2,-1)
	end
	return str
end

function loadAnotherBone(fh, bnname)
	local curly=fh:read("*l")--read away curly {
	local OFFSETline=startTabsRemoved(fh:read("*l"))
	
	local itrtr=string.gmatch(string.sub(OFFSETline, 8,-1), "[%w.-]+")
	local ox=itrtr()
	local oy=itrtr()
	local oz=itrtr()
	ox=ox*0.005263
	oy=oy*0.005263
	oz=oz*0.005263
	--print(ox,oy,oz)
	
	
	local newBone={children={}, channels={}, offx=ox, offy=oy, offz=oz, parent=nil, name=bnname, neutralx=0, neutraly=0, neutralz=0, index=gBoneStart}
	gBoneStart=gBoneStart+1
	
	local CHANNELSline=startTabsRemoved(fh:read("*l"))--read away channels line for now
	local itrtr=string.gmatch(string.sub(CHANNELSline, 10, -1), "[%w]+")
	local numChannels=itrtr()
	local i
	for i=1,numChannels,1 do
		table.insert(newBone.channels, itrtr())
	end
	
	
	
	local JOINTline="something"
	
	while string.sub(JOINTline,1,1)~="}" do
		JOINTline=startTabsRemoved(fh:read("*l"))
		if string.sub(JOINTline, 1,8)=="End Site" then 
			local curly=fh:read("*l")--read away curly {
			local curly=fh:read("*l")--offset
			local curly=fh:read("*l")--read away curly }
		else
			if string.sub(JOINTline,1,1)~="}" then
				local JOINTname=string.sub(JOINTline, 7,-1)
				print("Found bone: "..JOINTname)
				table.insert(newBone.children, loadAnotherBone(fh, JOINTname))
				newBone.children[#newBone.children].parent=newBone
			else
				return newBone
			end
		end
	end
	
	local curly=fh:read("*l")--read away curly }
	return newBone
end

function loadBVHHeader(fh)
	local HIERARCHYline=fh:read("*l")
	local ROOTline=fh:read("*l")
	local ROOTname=string.sub(ROOTline, 6,-1)
	print(ROOTname)
	
	rootBone=loadAnotherBone(fh,ROOTname)
		
end

function createLocalMatricesForBVHFrame(bone, itrtr)
	local i,j
	
	local ox=0
	local oy=0
	local oz=0
	
	for i=1,#bone.channels,1 do
		n=itrtr()
		if bone.channels[i]=="Zrotation" then
			setObjectInfo(bvhmarker, IG3D_POSITION, 0,0,0)
			setObjectInfo(bvhmarker, IG3D_ROTATION, 0,0,n)
			z11,z12,z13,z14, z21,z22,z23,z24, z31,z32,z33,z34, z41,z42,z43,z44=getObjectInfo(bvhmarker, IG3D_ROTATION_MATRIX)
			a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=matrixConcat(z11,z12,z13,z14, z21,z22,z23,z24, z31,z32,z33,z34, z41,z42,z43,z44, a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44)
		end
		if bone.channels[i]=="Yrotation" then
			setObjectInfo(bvhmarker, IG3D_POSITION, 0,0,0)
			setObjectInfo(bvhmarker, IG3D_ROTATION, 0,n,0)
			y11,y12,y13,y14, y21,y22,y23,y24, y31,y32,y33,y34, y41,y42,y43,y44=getObjectInfo(bvhmarker, IG3D_ROTATION_MATRIX)
			a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=matrixConcat(y11,y12,y13,y14, y21,y22,y23,y24, y31,y32,y33,y34, y41,y42,y43,y44, a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44)
		end
		if bone.channels[i]=="Xrotation" then
			setObjectInfo(bvhmarker, IG3D_POSITION, 0,0,0)
			setObjectInfo(bvhmarker, IG3D_ROTATION, n,0,0)
			x11,x12,x13,x14, x21,x22,x23,x24, x31,x32,x33,x34, x41,x42,x43,x44=getObjectInfo(bvhmarker, IG3D_ROTATION_MATRIX)
			a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44=matrixConcat(x11,x12,x13,x14, x21,x22,x23,x24, x31,x32,x33,x34, x41,x42,x43,x44, a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44)
		end
		
		if bone.channels[i]=="Zposition" then oz=n end
		if bone.channels[i]=="Yposition" then 
			if gFirstFrame==true then 
				gYMod=n
				gFirstFrame=false
			end
			oy=n-gYMod
		end
		if bone.channels[i]=="Xposition" then ox=n end
		
	end
	
	--[[
	 a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44= matrixConcat(y11,y12,y13,y14, y21,y22,y23,y24, y31,y32,y33,y34, y41,y42,y43,y44, x11,x12,x13,x14, x21,x22,x23,x24, x31,x32,x33,x34, x41,x42,x43,x44)
	 
	 a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44= matrixConcat(a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44, z11,z12,z13,z14, z21,z22,z23,z24, z31,z32,z33,z34, z41,z42,z43,z44)
	--]]
	a41=ox*0.005263 + bone.offx
	a42=oy*0.005263 + bone.offy
	a43=oz*0.005263 + bone.offz
	
	bone.neutralx=a41
	bone.neutraly=a42
	bone.neutralz=a43

	setObjectInfo(bvhmarker, IG3D_ROTATION_MATRIX, a11,a12,a13,a14, a21,a22,a23,a24, a31,a32,a33,a34, a41,a42,a43,a44)
	local xa,ya,za=getObjectInfo(bvhmarker, IG3D_ROTATION)
	setObjectInfo(bvhmarker, IG3D_ROTATION, 0,0,0)
	setObjectInfo(bvhmarker, IG3D_POSITION, 0,0,0)

	
	setBoneInfo(get(ig3d_bone, bvhmarker, bone.index), IG3D_ROTATION, xa,ya,za)
	setBoneInfo(get(ig3d_bone, bvhmarker, bone.index), IG3D_POSITION, ox*0.005263,oy*0.005263,oz*0.005263)
	
	
	for j=1,#bone.children,1 do
		createLocalMatricesForBVHFrame(bone.children[j], itrtr)
	end
	
end


function calculatePoseFromLocalMatrices(bone)
	
	if bone.parent~=nil then
		
		bone.neutralx=bone.neutralx+bone.parent.neutralx
		bone.neutraly=bone.neutraly+bone.parent.neutraly
		bone.neutralz=bone.neutralz+bone.parent.neutralz
	end
	
	
	
	local i
	for i=1,#bone.children,1 do
		calculatePoseFromLocalMatrices(bone.children[i])
	end
	
end


function loadBVHMotions(fh)
	local MOTIONline=fh:read("*l")
	local FRAMESline=fh:read("*l")
	
	local itrtr=string.gmatch(FRAMESline, "[%w:]+")
	itrtr()--waste
	local numFrames=itrtr()
	
	local FRAMETIMEline=fh:read("*l")
	local itrtr=string.gmatch(string.sub(FRAMETIMEline, 13,-1), "[%w.-]+")
	gFrameTime=itrtr()
	
	local poses={}
	
	local i
	for i=1,numFrames,1 do
		local frameLine=fh:read("*l")
		table.insert(poses, frameLine)
	end
	return poses
end

function neutralPose(bone)
	local i
	--setObjectInfo(bvhmarker, IG3D_ROTATION_MATRIX, 1,0,0,0, 0,1,0,0, 0,0,1,0, bone.offx,bone.offy,bone.offz,1)
	setBoneInfo(get(ig3d_bone, bvhmarker, bone.index), IG3D_ROTATION, 0,0,0)
	setBoneInfo(get(ig3d_bone, bvhmarker, bone.index), IG3D_POSITION, 0,0,0)
	bone.neutralx=bone.offx
	bone.neutraly=bone.offy
	bone.neutralz=bone.offz
	
	for i=1,#bone.children,1 do
		neutralPose(bone.children[i])
	end
end

function createMeshBones(bone)
	local i
	local prntname="None"
	
	i=1
	
	if bone.parent~=nil then
		if bone.parent~=rootBone then prntname=bone.parent.name end
		drawVertex(bone.neutralx, bone.neutraly, bone.neutralz*i*150.245)
		ig3d_SetMeshPositionNoUndo_3f(bone.neutralx, bone.neutraly, bone.neutralz)
		ig3d_MakeBoneFromVertex_2s(bone.name, prntname)
	end
	
	
	for i=1,#bone.children,1 do
		createMeshBones(bone.children[i])
	end
end

function loadBVHFile(fileName)
	--first step, replace CRLF with LF
	local fh=io.open(fileName, "r")
	buffer=fh:read("*a")
	fh:close()
	fh=io.open(fileName, "w")
	fh:write(string.gsub(buffer, "\r\n", "\n"))
	fh:close()

	bvhmarker=make(ig3d_object, "Weapons/bullet")

	local fh=io.open(fileName, "r")
	loadBVHHeader(fh)
	poses=loadBVHMotions(fh)
	fh:close()
	
	neutralPose(rootBone)
	
	calculatePoseFromLocalMatrices(rootBone)
	createMeshBones(rootBone)
	saveMesh("Data/WTF/Characters/animazoobvh.wtf")
	
	delete(ig3d_object, bvhmarker)
	bvhmarker=make(ig3d_object, "Characters/animazooJacky.wtf")
	setObjectInfo(bvhmarker, IG3D_POSITION, 0,0,0)
end


