shader_type canvas_item;

uniform float pixel_scale = 64.0; // 控制像素化程度

void fragment() {
    vec2 uv = UV;
    uv = floor(uv * pixel_scale) / pixel_scale;
    COLOR = texture(TEXTURE, uv);
}