-- creates vertices to bones and tags for TrueBones style torso
function makeTrueBonesTorso()
--hip
ig3d_CreateMesh_tag_s("hip")
drawVertex(0.0,0.585175,0.0)
ig3d_AddToMesh_tag_i(1)
ig3d_MakeBoneFromVertex_2s ("hip","NONE")

--abdomen
ig3d_CreateMesh_tag_s("abdomen")
drawVertex(0.0,0.619878,0.0)
ig3d_AddToMesh_tag_i(2)
ig3d_MakeBoneFromVertex_2s ("abdomen","hip")

--chest
ig3d_CreateMesh_tag_s("chest")
drawVertex(-0.002743,0.784448,0.0)
ig3d_AddToMesh_tag_i(3)
ig3d_MakeBoneFromVertex_2s ("chest","abdomen");

--neckDummy
ig3d_CreateMesh_tag_s("neckDummy")
drawVertex(-0.002743,0.858504,0.0)
ig3d_AddToMesh_tag_i(4)
ig3d_MakeBoneFromVertex_2s ("neckDummy","chest")

--neck
ig3d_CreateMesh_tag_s("neck")
drawVertex(-0.002743,0.885058,0.0)
ig3d_AddToMesh_tag_i(5)
ig3d_MakeBoneFromVertex_2s ("neck","neckDummy")

--head
ig3d_CreateMesh_tag_s("head")
drawVertex(0.0,0.995986,0.0)
ig3d_AddToMesh_tag_i(6)
ig3d_MakeBoneFromVertex_2s ("head","neck")

--leftcollar
ig3d_CreateMesh_tag_s("lCollar")
drawVertex(0.061441,0.847235,0.0)
ig3d_AddToMesh_tag_i(7)
ig3d_MakeBoneFromVertex_2s ("lCollar","chest")

--rightcollar
ig3d_CreateMesh_tag_s("rCollar")
drawVertex(-0.080843,0.840767,0.0)
ig3d_AddToMesh_tag_i(11)
ig3d_MakeBoneFromVertex_2s ("rCollar","chest")
end -- createTorsoBones

-- creates left arm bones
function makeTrueBonesLeftArm()
--leftshoulder
ig3d_CreateMesh_tag_s("lShldr")
drawVertex(0.106713,0.789028,0.0)
ig3d_AddToMesh_tag_i(8)
ig3d_MakeBoneFromVertex_2s ("lShldr","lCollar")

--leftforearm
ig3d_CreateMesh_tag_s("lForeArm")
drawVertex(0.11576,0.704951,0.0)
ig3d_AddToMesh_tag_i(9)
ig3d_MakeBoneFromVertex_2s ("lForeArm","lShldr")

--lefthand
ig3d_CreateMesh_tag_s("lHand")
drawVertex(0.119648,0.58533,0.0)
ig3d_AddToMesh_tag_i(10)
ig3d_MakeBoneFromVertex_2s ("lHand","lForeArm")
end

-- creates right arm bones
function makeTrueBonesRightArm()
--rightshoulder
ig3d_CreateMesh_tag_s("rShldr")
drawVertex(-0.11318,0.78256,0.0)
ig3d_AddToMesh_tag_i(12)
ig3d_MakeBoneFromVertex_2s ("rShldr","rCollar")

--rightforearm
ig3d_CreateMesh_tag_s("rForeArm")
drawVertex(-0.126115,0.679081,0.0)
ig3d_AddToMesh_tag_i(13)
ig3d_MakeBoneFromVertex_2s ("rForeArm","rShldr")

--righthand
ig3d_CreateMesh_tag_s("rHand")
drawVertex(-0.133219,0.58207,0.0)
ig3d_AddToMesh_tag_i(14)
ig3d_MakeBoneFromVertex_2s ("rHand","rForeArm")
end

-- creates left leg bones
function makeTrueBonesLeftLeg()
--leftthigh
ig3d_CreateMesh_tag_s("lThigh")
drawVertex(0.059647,0.531313,0.0)
ig3d_AddToMesh_tag_i(15)
ig3d_MakeBoneFromVertex_2s ("lThigh","hip")

--leftshin
ig3d_CreateMesh_tag_s("lShin")
drawVertex(0.050742,0.300916,0.0)
ig3d_AddToMesh_tag_i(16)
ig3d_MakeBoneFromVertex_2s ("lShin","lThigh")

--leftfoot
ig3d_CreateMesh_tag_s("lFoot")
drawVertex(0.050742,0.030755,0.0)
ig3d_AddToMesh_tag_i(17)
ig3d_MakeBoneFromVertex_2s ("lFoot","lFoot")
end


-- creates right leg bones
function makeTrueBonesRightLeg()
--rightthigh
ig3d_CreateMesh_tag_s("rThigh")
drawVertex(-0.058971,0.528571,0.0)
ig3d_AddToMesh_tag_i(18)
ig3d_MakeBoneFromVertex_2s ("rThigh","hip")

--rightshin
ig3d_CreateMesh_tag_s("rShin")
drawVertex(-0.067199,0.306402,0.0)
ig3d_AddToMesh_tag_i(19)
ig3d_MakeBoneFromVertex_2s ("rShin","rThigh")

--rightfoot
ig3d_CreateMesh_tag_s("rFoot")
drawVertex(-0.064456,0.030755,0.0)
ig3d_AddToMesh_tag_i(20)
ig3d_MakeBoneFromVertex_2s ("rFoot","rShin")
end
