shader_type spatial;
render_mode depth_draw_opaque,cull_disabled;

uniform vec4 albedo : source_color;
uniform float roughness: hint_range(0,1);
uniform float specular;

uniform sampler2D wave_texture;
uniform float amplitude = 1.0;

void vertex() {
	vec2 uv = UV.xx + TIME * 0.1;
	VERTEX.y = texture(wave_texture, uv).r * amplitude;
	VERTEX.y += texture(wave_texture, UV.xx + 0.1).r * amplitude * 0.5;
}

void fragment() {
	ALBEDO = albedo.rgb;
	ROUGHNESS = roughness;
	SPECULAR = specular;
}
