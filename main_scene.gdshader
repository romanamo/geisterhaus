shader_type canvas_item;

uniform vec2 erase_center;
uniform float erase_radius = 50.0; // Adjustable radius for the erasing effect
uniform bool erase = false; // Control flag for erasing

void fragment() {
    if (erase && distance(erase_center, FRAGCOORD.xy) < erase_radius) {
        discard;  // Discard pixels within the radius from the erase_center
    }
    COLOR = vec4(0.0, 0.0, 0.0, 1.0); // Always render black unless discarded
}