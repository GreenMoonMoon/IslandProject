shader_type spatial;

uniform vec3 water: source_color;
uniform float amplitude;
uniform float wave_length: hint_range(0.0, 1.0, 0.05);

void vertex() {
	float f = VERTEX.x * wave_length + TIME;
	VERTEX.y = sin(f) * amplitude;
	VERTEX.x += cos(f) * amplitude;
	
	f = VERTEX.z * wave_length * 2.0 + (TIME * 1.75);
	VERTEX.y = mix(VERTEX.y, sin(f) * (amplitude * 0.5), 0.5);
//	VERTEX.z += cos(f) * (amplitude * 0.5);
}

void fragment() {
	// Place fragment code here.
	ALBEDO = water;
}
