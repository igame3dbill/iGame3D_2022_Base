varying vec3 lightVec; 
varying vec3 eyeVec;
//attribute vec3 vTangent;

void main(void)
{
	vec3 t,b;
	vec3 n = normalize(gl_NormalMatrix * gl_Normal);
	vec3 c1 = cross(n, vec3(0.0, 0.0, 1.0)); 
	vec3 c2 = cross(n, vec3(0.0, 1.0, 0.0)); 
	
	t=c1;
	if (length(c1)<0.01){t=c2;}
	/*
	if(length(c1)>length(c2))
	{
		t = c1;	
	}
	else
	{
		t = c2;	
	}
	*/
	t = normalize(t);
	b=cross(t, n);//gl_Normal);

/*  -------- */
	
	vec3 vVertex = vec3(gl_ModelViewMatrix * gl_Vertex);
	vec3 tmpVec = vec3(gl_LightSource[0].position.xyz - vVertex);

	lightVec.x = dot(tmpVec, t);
	lightVec.y = dot(tmpVec, b);
	lightVec.z = dot(tmpVec, n);

	tmpVec = -vec3(vVertex);
	eyeVec.x = dot(tmpVec, t);
	eyeVec.y = dot(tmpVec, b);
	eyeVec.z = dot(tmpVec, n);

	gl_Position = ftransform();
	gl_TexCoord[0] = gl_MultiTexCoord0;
	gl_TexCoord[1] = gl_MultiTexCoord1;
	gl_TexCoord[2] = gl_MultiTexCoord2;
}
