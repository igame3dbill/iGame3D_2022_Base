#!BPY
#"""
# Name: 'WTF Export(wtf)...'
# Blender: 233
# Group: 'Export'
# Tooltip: 'Export to iGame3D WTF format.'
# """

import time
#import Blender
#from Blender import Scene, Mesh

header="iGame3D Mdl\n0\n#Author:\n#Date:"+time.strftime('%m-%d-%Y')+"\n"+"#Notes:\n#PNG: 0\n\n"
# file_name=Blender.Get('filename').replace(".blend",".wtf")

def write_wtf(filepath):

    scn=Scene.GetCurrent()
    obj=scn.objects.active

    if not obj:
        Blender.Draw.PupMenu("You need to select a model for this to work.")
        

    my_mesh=obj.getData(mesh=1)

    oldmode=Blender.Mesh.Mode()

    Blender.Mesh.Mode(3)
    #my_mesh.sel=1

    editmode=Blender.Window.EditMode()

    print "Triangulating"

    if not editmode:
        my_mesh.sel= True
        my_mesh.quadToTriangle(0)
    else:
        Blender.Window.EditMode(0)
        my_mesh.quadToTriangle(0)
        Blender.Window.EditMode(1)
        my_mesh.update()
                

    Blender.Mesh.Mode(oldmode)

    out_file=open(filepath,"w")
    out_file.write(header)
    out_file.write("#Bones:\n0\n")#No bones
    out_file.write("#Vertices:\n"+str(len(my_mesh.verts))+"\n")

    print "Writing verts"

    for v in my_mesh.verts:
        tmp=(v.co.x*500,v.co.y*500,v.co.z*500,0)#Need to scale things way up for iGame
        #tmp=[str(c) for c in tmp]
        tmp=['%f' % c for c in tmp]
        tmp=",".join(tmp)
        out_file.write(tmp+"\n")
    
    out_file.write("#Paths:\n0\n")#No paths
    out_file.write("#Groups:\n0\n")#No Groups
    out_file.write("#BoneOrientations:\n0\n")#No BoneOrientations

    out_file.write("#Edges:\n"+str(len(my_mesh.edges))+"\n")

    print "Writing edges"

    for e in my_mesh.edges:
        tmp=(e.v1.index,e.v2.index)
        tmp=[str(c) for c in tmp]
        tmp=",".join(tmp)
        out_file.write(tmp+"\n")

    print "Writing materials"

    #print my_mesh.materials
    #out_file.write("#Materials:\n"+str(len(my_mesh.materials))+"\n")
    out_file.write("#Materials:\n"+"1"+"\n")
    
    out_file.write("Default\n")
    out_file.write("3\n")
    
    out_file.write("lux=0\n")
    out_file.write("smooth=0\n")
    out_file.write("color=1,1,1,1\n")
    out_file.write(str(len(my_mesh.faces))+"\n")
    
    
    for f in my_mesh.faces:
        s_tmp=[]
        for v in f.verts:
            s_tmp.append(str(v.index))
            
        if my_mesh.faceUV:
            for u in f.uv:
                s_tmp.append('%f' % u[0])
                s_tmp.append('%f' % u[1])
        else:
            s_tmp.extend(['%f' % 0,'%f' % 0,'%f' % 0,'%f' % 0,'%f' % 0,'%f' % 0])
            
            
        out_file.write(",".join(s_tmp)+"\n")
    
    out_file.write("#Animations:\n0\n")
    out_file.close()
    print "File closed"


Blender.Window.FileSelector(write_wtf, "Export WTF",file_name)