shader_type spatial;

uniform sampler2D heightmap;
uniform float sampling_distance = 0.01;

//TODO: generate the normal texture on loading for performance
vec3 calculate_normal(vec2 uv, float h){
	vec2 uv_offset = vec2(sampling_distance, 0.0);
	vec3 t = normalize(vec3(uv_offset, texture(heightmap, uv + uv_offset).r) - vec3(0.0, 0.0, h));
	vec3 b = normalize(vec3(uv_offset.yx, texture(heightmap, uv + uv_offset.yx).r) - vec3(0.0, 0.0, h));

	return cross(t, b);
}

void vertex() {
	VERTEX.y = texture(heightmap, UV).r * 64.0;
}

void fragment() {
	NORMAL = (vec4(normalize( cross(dFdy(VERTEX), dFdx(VERTEX))), 1.0)).xyz;
}
