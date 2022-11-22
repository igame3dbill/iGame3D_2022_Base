// (c) 2008 iGame3D WTF Export from Cheetah3D
//

//var polyCount=0;

function main(doc){
    var	    i,j;    
    //get path for file
    var path=OS.runSavePanel("wtf");
    if(path==null){
	return;
	}
    
    //open file
    var file = new File(path);
    file.open(WRITE_MODE);
    
    //write some commentary at the beginning
    file.writeln("iGame3D Mdl");
    file.writeln("0");
    file.writeln("#Author:");
    file.writeln("#Date:");
    file.writeln("#Notes:");
    file.writeln("#PNG: 0");
    file.write("\n");
    
	
	
    //save object scene graph
    saveObject(doc.root(),file);
    
   
	
	
	
	
	/*
	 //save materials
    file.writeln("#Materials:");
    file.writeln("1");
	
	
    for(i=0;i<doc.materialCount();i++){
	
	
	
	var mat=doc.materialAtIndex(i);
	var count=0;
	var obj=doc.root();
	var core=obj.modCore();
	var mattags=obj.materialTags();
	
	for (j=0; j<polyCount; j++)
	{
		var	material=(core.materialTagIndex[j]==mattags.length) ? -1 : mattags[core.materialTagIndex[j]].linkedToMaterial();
		
		file.writeln(material+"");
		//if (mat==material){count++;}
	}
	
	
	var matcolor=mat.color();
	var matspecu=mat.specular();
	var matshine=64/mat.shininess();
	var matemiss=mat.emission();
	var mattexture=mat.colorMap();
	var matname=mat.getParameter("name");
	
	file.writeln(matname);
	file.writeln("13");
	file.writeln("lux=Boolean");
	file.writeln("smooth=0");
	file.writeln("color=" + matcolor.r.toPrecision(3) + "," + matcolor.g.toPrecision(3) + "," + matcolor.b.toPrecision(3) + ", " + matcolor.a.toPrecision(3));
	file.writeln("ambient=0.5,0.5,0.5,1.0");
	file.writeln("diffuse=0.3,0.3,0.3,1.0");
	file.writeln("specular="+ matspecu.r.toPrecision(3) + "," + matspecu.g.toPrecision(3) + "," + matspecu.b.toPrecision(3) + ", " + matspecu.a.toPrecision(3));
	file.writeln("shininess=" + matshine.toPrecision(3));
	file.writeln("emission="+ matemiss.r.toPrecision(3) + "," + matemiss.g.toPrecision(3) + "," + matemiss.b.toPrecision(3) + ", " + matemiss.a.toPrecision(3));
	file.writeln("blend=0");
	file.writeln("wire=0");
	file.writeln("depth=0");
	file.writeln("texture=1,"+ mattexture);
	file.writeln("shader=Data/Shaders/bump/");
	file.writeln(count+"");
	
	}
	*/
    
	    file.writeln("#Animations:");
	    file.writeln("0");
    //close file
    file.close(); 
}

 
function saveObject(obj,file){

	
    //save current object if it is a polygon object
    if(obj.family()==NGONFAMILY){
	var i,j;
	var objname=obj.getParameter("name");
	var obj2wordld=obj.obj2WorldMatrix();
	var mattags=obj.materialTags();
	var core=obj.modCore();
	var tag2mat=new Array(32);
	 vertN=0
	//build conversion table shadertag -> material index
	for(i=0;i<mattags.length;i++){
	    tag2mat[i]=mattags[i].linkedToMaterial();
	    print(tag2mat[i]);
	    }	
	//file.writeln("!!!!"+objname);
	file.writeln("#Bones:");
	file.writeln("0");
	
	//save object name, vertex count and polygon count
	//file.writeln("Object \"" + objname + "\" " + core.vertexCount() + " " + core.polygonCount());
	var vertCnt=core.vertexCount();
	file.writeln("#Vertices:");	
	file.writeln(""+vertCnt+"");
	//save vertices
	for(i=0;i<core.vertexCount();i++){
	    var vert=core.vertex(i);			//vertex in local coordinate system
	    var world_vert=obj2wordld.multiply(vert);	//vertex in world coordinate system
	    file.writeln(world_vert.x.toPrecision(3)*660.0 + ", " + world_vert.y.toPrecision(3)*660.0 + ", " + world_vert.z.toPrecision(3)*660.0+",0");
	    }
	    
	    file.writeln("#Paths:");
	    file.writeln("0");
		file.writeln("#Groups:");
	    file.writeln("0");
	    file.writeln("#BoneOrientations:");
	    file.writeln("1");
		file.writeln("0,0.0,-0.0,0.0/1.0,1.0,1.0");
	    
	    
	file.writeln("#Edges:");
	var EdgeCnt=core.polygonCount()*3;
	file.writeln(""+EdgeCnt +"");
	//save edges (mesh editor relevant only)
	
	//polyCount=1;//core.polygonCount();
	
	for(i=0;i<core.polygonCount();i++){
	    var polysize=core.polygonSize(i);
		
		polysize=3;//yes! triangles only
		
	    var usedShaderTag=core.materialTagIndex(i);
	    var	material=(usedShaderTag==mattags.length) ? -1 : tag2mat[usedShaderTag];
	    
	    //write the 3 edges of the triangle:
		file.writeln(core.vertexIndex(i,0)+","+core.vertexIndex(i,1));
		file.writeln(core.vertexIndex(i,1)+","+core.vertexIndex(i,2));
		file.writeln(core.vertexIndex(i,2)+","+core.vertexIndex(i,0));
	    
	    }
		
		/*
	var mat=doc.materialAtIndex(0);
	var matcolor=mat.color();
	var matspecu=mat.specular();
	var matshine=64/mat.shininess();
	var matemiss=mat.emission();
	var mattexture=mat.colorMap();
	var matname=mat.getParameter("name");
	*/
	
	 //save materials
    file.writeln("#Materials:");
    file.writeln("1");
	file.writeln("Instructionless material");
	file.writeln("0");
	/*
	file.writeln("lux=Boolean");
	file.writeln("smooth=0");
	file.writeln("color=" + matcolor.r.toPrecision(3) + "," + matcolor.g.toPrecision(3) + "," + matcolor.b.toPrecision(3) + ", " + matcolor.a.toPrecision(3));
	file.writeln("ambient=0.5,0.5,0.5,1.0");
	file.writeln("diffuse=0.3,0.3,0.3,1.0");
	file.writeln("specular="+ matspecu.r.toPrecision(3) + "," + matspecu.g.toPrecision(3) + "," + matspecu.b.toPrecision(3) + ", " + matspecu.a.toPrecision(3));
	file.writeln("shininess=" + matshine.toPrecision(3));
	file.writeln("emission="+ matemiss.r.toPrecision(3) + "," + matemiss.g.toPrecision(3) + "," + matemiss.b.toPrecision(3) + ", " + matemiss.a.toPrecision(3));
	file.writeln("blend=0");
	file.writeln("wire=0");
	file.writeln("depth=0");
	file.writeln("texture=1,"+ mattexture);
	file.writeln("shader=Data/Shaders/bump/");
	*/
	file.writeln(""+core.polygonCount()+"");
	//save polygons
	for(i=0;i<core.polygonCount();i++){
	    var polysize=core.polygonSize(i);
		
		polysize=3;//yes! triangles only
		
		file.writeln(core.vertexIndex(i,0)+","+core.vertexIndex(i,2)+","+core.vertexIndex(i,1)+","+(core.uvCoord(i,0)).u.toPrecision(3)+","+(core.uvCoord(i,0)).v.toPrecision(3)+","+(core.uvCoord(i,2)).u.toPrecision(3)+","+(core.uvCoord(i,2)).v.toPrecision(3)+","+(core.uvCoord(i,1)).u.toPrecision(3)+","+(core.uvCoord(i,1)).v.toPrecision(3));
		}
		
		
		
		
	}   
	 
	 
    //save child objects if obj is not a creator object
   if(obj.isCeatorObj()==false){
	for(var i=0;i<obj.childCount();i++){
	    var  zwi=obj.childAtIndex(i);  
	  saveObject(zwi,file);
	   }
	}
	
	
}




