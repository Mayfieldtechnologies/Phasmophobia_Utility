shader_type canvas_item;

uniform float burn_amount : hint_range(0.0, 1.0) = 1;

void fragment() {
    // Get the color of the current pixel
    vec4 color = texture(TEXTURE, SCREEN_UV);

    // Increase the red channel to create a burn effect
    color.r += burn_amount;

    // Output the modified color
    COLOR = color;
}
