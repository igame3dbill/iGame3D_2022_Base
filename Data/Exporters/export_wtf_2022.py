import bpy
import time
from pycl import print

header="iGame3D Mdl\n0\n#Author:\n#Date:"+time.strftime('%m-%d-%Y')+"\n"+"#Notes:\n#PNG: 0\n\n"
current_blender_file = bpy.path.display_name_from_filepath(bpy.data.filepath)

file_name=current_blender_file+".wtf"
# POP UP DIALOG
def noselectionerror(self, context):
    self.layout.label(text="You need to select a model for this to work.")
    


## OLD WTF EXPORT HERE:
def write_wtf(filepath):

    scn=bpy.context.scene  #Scene.GetCurrent()
    obj= bpy.context.selected_objects   #bpy.context.active_object    #().name_full   ##scn.objects.active

    if not obj:
        bpy.context.window_manager.popup_menu(noselectionerror, title="WARNING!", icon='INFO') #Blender.Draw.PupMenu()
        

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

## NEW TEMPLATE SCRIPT BELOW
def write_some_data(context, filepath, use_some_setting):
    print("running write_some_data...")
    f = open(filepath, 'w', encoding='utf-8')
    f.write("Hello World %s" % use_some_setting)
    f.close()

    return {'FINISHED'}


# ExportHelper is a helper class, defines filename and
# invoke() function which calls the file selector.
from bpy_extras.io_utils import ExportHelper
from bpy.props import StringProperty, BoolProperty, EnumProperty
from bpy.types import Operator


class ExportSomeData(Operator, ExportHelper):
    """This appears in the tooltip of the operator and in the generated docs"""
    bl_idname = "export_test.some_data"  # important since its how bpy.ops.import_test.some_data is constructed
    bl_label = "Export Some Data"

    # ExportHelper mixin class uses this
    filename_ext = ".wtf"

    filter_glob: StringProperty(
        default="*.wtf",
        options={'HIDDEN'},
        maxlen=255,  # Max internal buffer length, longer would be clamped.
    )

    # List of operator properties, the attributes will be assigned
    # to the class instance from the operator settings before calling.
    use_setting: BoolProperty(
        name="Example Boolean",
        description="Example Tooltip",
        default=True,
    )

    type: EnumProperty(
        name="Example Enum",
        description="Choose between two items",
        items=(
            ('OPT_A', "First Option", "Description one"),
            ('OPT_B', "Second Option", "Description two"),
        ),
        default='OPT_A',
    )

    def execute(self, context):
        return write_some_data(context, self.filepath, self.use_setting)


# Only needed if you want to add into a dynamic menu
def menu_func_export(self, context):
    self.layout.operator(ExportSomeData.bl_idname, text="Text Export Operator")


# Register and add to the "file selector" menu (required to use F3 search "Text Export Operator" for quick access).
def register():
    bpy.utils.register_class(ExportSomeData)
    bpy.types.TOPBAR_MT_file_export.append(menu_func_export)


def unregister():
    bpy.utils.unregister_class(ExportSomeData)
    bpy.types.TOPBAR_MT_file_export.remove(menu_func_export)


if __name__ == "__main__":
    register()

    # test call
    bpy.ops.export_test.some_data('INVOKE_DEFAULT')

