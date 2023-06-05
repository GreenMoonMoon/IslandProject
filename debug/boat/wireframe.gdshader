shader_type spatial;

render_mode wireframe, depth_draw_never, unshaded;

uniform vec3 color : source_color;

void fragment(){
	ALBEDO = color;
}