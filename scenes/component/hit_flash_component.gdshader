shader_type canvas_item;

uniform float brightness : hint_range(0.0, 1.0);

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	vec4 target_color = mix(texture_color, vec4(vec3(1.0), texture_color.a), brightness);
	COLOR = target_color;
}
