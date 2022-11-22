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
varying vec3 lightDir;
varying vec3 halfVector;
varying float dist;
varying vec2 texCoord;
uniform bool light1Enabled;
uniform bool light2Enabled;

void main()
{	
	vec4 ecPos;
	vec3 aux;
	int i;

	
	
	/* first transform the normal into eye space and normalize the result */
	normal = normalize(gl_NormalMatrix * gl_Normal);
	
	/* now normalize the light's direction. Note that according to the
	OpenGL specification, the light is stored in eye space.*/
	ecPos = gl_ModelViewMatrix * gl_Vertex;

	
			aux = vec3(gl_LightSource[0].position-ecPos);
			lightDir = normalize(aux);
	
			/* compute the distance to the light source to a varying variable*/
			dist = length(aux);

			/* Normalize the halfVector to pass it to the fragment shader */
			halfVector = normalize(gl_LightSource[0].halfVector.xyz);
	
			/* Compute the diffuse, ambient and globalAmbient terms */
			diffuse = gl_FrontMaterial.diffuse * gl_LightSource[0].diffuse;
			ambient = gl_FrontMaterial.ambient * gl_LightSource[0].ambient;


	ambientGlobal = gl_LightModel.ambient * gl_FrontMaterial.ambient;
	gl_Position = ftransform();
	texCoord = gl_MultiTexCoord0.xy;
} 
