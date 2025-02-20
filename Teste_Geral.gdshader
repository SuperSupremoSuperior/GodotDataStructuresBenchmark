shader_type canvas_item;

uniform float scale : hint_range(0.0, 1.0) = 0.2;
uniform float speed : hint_range(0.0, 1.0) = 0.2;

uniform sampler2D noise : repeat_enable;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = UV * scale + vec2(TIME * speed * 0.1, TIME * speed * 0.1);
	vec4 textura = texture(noise, uv);
	
	COLOR = vec4(textura.rgb, 1);
}

