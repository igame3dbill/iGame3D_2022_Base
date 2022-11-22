varying vec3 lightVec;
varying vec3 eyeVec;
uniform sampler2D tex0;
uniform sampler2D tex1;
uniform sampler2D tex2;
//uniform float invRadius;

void main (void)
{
	float invRadius=1.0/100.0;

	float distSqr = dot(lightVec, lightVec);
	float att = clamp(1.0 - invRadius * sqrt(distSqr), 0.0, 1.0);
	vec3 lVec = lightVec * inversesqrt(distSqr);

	att=1.0;//no attenuation just yet

	vec3 vVec = normalize(eyeVec);
	
	vec4 base = texture2D(tex0, gl_TexCoord[0].st);
	
	vec3 bump_color=texture2D(tex1, gl_TexCoord[1].st).xyz;

	vec4 unit2 = vec4(1.0,1.0,1.0,1.0);//texture2D(tex2, gl_TexCoord[2].st);
	
	vec3 bump = normalize( bump_color * 2.0 - 1.0);

	vec4 vAmbient = gl_LightSource[0].ambient * gl_FrontMaterial.ambient;

	
	float diffuse = max(dot(lVec, bump), 0.0);
	//float diffuse=lightVec.z;

	vec4 vDiffuse = gl_LightSource[0].diffuse * gl_FrontMaterial.diffuse * 
					diffuse;	

	
	float specular = pow(clamp(dot(reflect(-lVec, bump), vVec), 0.0, 1.0), 
	                 gl_FrontMaterial.shininess );

	
	
	
	vec4 vSpecular = gl_LightSource[0].specular * gl_FrontMaterial.specular * 
					 specular;

	//ignore specular:
	vSpecular=vec4(0,0,0,0);
	
	gl_FragColor = (( vAmbient*base + 
					 vDiffuse*base + 
					 vSpecular) * att + gl_FrontMaterial.emission )* unit2;

}