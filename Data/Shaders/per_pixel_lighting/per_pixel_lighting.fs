/* -------------------------------------------------------

This shader implements a spotlight per pixel using  the 
diffuse, specular, and ambient terms acoording to "Mathematics of Lighthing" 
as found in the book "OpenGL Programming Guide" (aka the Red Book)

Antonio Ramires Fernandes

--------------------------------------------------------- */

varying vec4 diffuse;
vec4 ambientGlobal;
vec4 ambient;
varying vec3 normal;
varying vec3 lightDir,halfVector;
varying float dist;
uniform sampler2D tex0;
varying vec2 texCoord;
uniform bool light1Enabled;
uniform bool light2Enabled;

void main()
{
	vec3 n,halfV;
	float NdotL,NdotHV;
	vec4 color = vec4(0,0,0,1);//ambientGlobal;
	float att,spotEffect;
	

	int i=0;
	//color=vec4(0,0,0,1);//ignore ambient global light

	/* a fragment shader can't write a verying variable, hence we need
	a new variable to store the normalized interpolated normal */
	n = normalize(normal);
	
	/* compute the dot product between normal and ldir */
			NdotL = max(dot(n,normalize(lightDir)),0.0);

			if (NdotL > 0.0) {
				//make sure there is a spot
				vec3 spotDir=gl_LightSource[0].spotDirection;
				spotEffect = dot(normalize(spotDir), normalize(-lightDir));

				if (length(spotDir)==0.0){spotEffect=1.0;}

				
				if (spotEffect > gl_LightSource[0].spotCosCutoff) {
					spotEffect = pow(spotEffect, gl_LightSource[0].spotExponent);
					//if (gl_LightSource[0].spotCosCutoff==-1.0){spotEffect=1.0;}//for non spotlights the spotlight effect becomes one
					att = spotEffect / (gl_LightSource[0].constantAttenuation +
							gl_LightSource[0].linearAttenuation * dist +
							gl_LightSource[0].quadraticAttenuation * dist * dist);
					color += att * (diffuse * NdotL + ambient);
			
					halfV = normalize(halfVector);
					NdotHV = max(dot(n,halfV),0.0);
			
					//some GPUs dont compute 0^0 to 1, so there are unpredictable results with a shininess of 0, set the powTerm to 1 in that case
					float powTerm=1.0;
					if (gl_FrontMaterial.shininess!=0.0){powTerm=pow(NdotHV, gl_FrontMaterial.shininess);}

					color += min(att * gl_FrontMaterial.specular * gl_LightSource[0].specular * powTerm, 1.0);
				}
			}
		
	
	
	
	color+=gl_FrontMaterial.emission;
	vec4 textureSample=texture2D(tex0, texCoord);
	gl_FragColor = color*textureSample;
	
}
