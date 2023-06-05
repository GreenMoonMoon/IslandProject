// NOTE: Shader automatically converted from Godot Engine 4.0.3.stable's StandardMaterial3D.

shader_type spatial;
render_mode depth_draw_opaque,cull_disabled;

const float GRAVITY = 9.8;

uniform vec4 albedo : source_color;
uniform float roughness: hint_range(0,1);
uniform float specular;

// wave_profile [(x, y): direction, z: steepness, w: wave_length ]
uniform vec4 wave_a = vec4(1.0, 0.0, 0.75, 24.0);
uniform vec4 wave_b = vec4(0.0, 1.0, 0.5, 60.0);
uniform vec4 wave_c = vec4(0.7, 0.7, 0.25, 80.0);

vec3 grestner_wave(vec4 profile, vec3 position, inout vec3 tangent, inout vec3 binormal) {
	vec2 d = normalize(profile.xy); // Direction
	float s = profile.z; // Steepness
	float w = profile.w; // Wave length
	
	float k = TAU / w; // Wave number
	float c = sqrt(GRAVITY / k); // Speed
	float f = k * (dot(d, position.xz) - c * TIME); // Wave function
	float a = s / k; // Amplitude
	
	// Calculate normals
	tangent += vec3(
		-d.x * d.x * (s * sin(f)),
		d.x * (s * cos(f)),
		-d.x * d.y * (s * sin(f))
	);
	binormal += vec3(
		-d.x * d.y * (s * sin(f)),
		d.y * (s * cos(f)),
		-d.y * d.y * (s * sin(f))
	);
	
	// Return wave position
	return vec3(d.x * (a * cos(f)), a * sin(f), d.y * (a * cos(f)));
}

void vertex(){
	vec3 tangent = vec3(1.0, 0.0, 0.0);
	vec3 binormal = vec3(0.0, 0.0, 1.0);
	vec3 position = VERTEX;
	
	position += grestner_wave(wave_a, VERTEX, tangent, binormal);
	position += grestner_wave(wave_b, VERTEX, tangent, binormal);
	position += grestner_wave(wave_c, VERTEX, tangent, binormal);
	NORMAL = normalize(cross(binormal, tangent));
	VERTEX.x += position.x;
	VERTEX.y = position.y;
	VERTEX.z += position.z;
}

void fragment() {
	ALBEDO = albedo.rgb;
	ROUGHNESS = roughness;
	SPECULAR = specular;
}
