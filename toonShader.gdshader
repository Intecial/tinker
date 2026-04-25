shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_disabled, diffuse_toon, specular_toon;

uniform vec4 albedo : source_color = vec4(1.0);
uniform vec4 shadow_color : source_color = vec4(0.3, 0.3, 0.5, 1.0);
uniform float shadow_threshold : hint_range(-1.0, 1.0) = 0.0;
uniform float shadow_smoothness : hint_range(0.0, 0.1) = 0.01;

uniform vec4 rim_color : source_color = vec4(1.0);
uniform float rim_amount : hint_range(0.0, 8.0) = 4.0;
uniform float rim_threshold : hint_range(0.0, 1.0) = 0.1;

float fresnel(float amount, vec3 normal, vec3 view) {
    return pow((1.0 - clamp(dot(normalize(normal), normalize(view)), 0.0, 1.0)), amount);
}

void fragment() {
    // rim light
    float rim = fresnel(rim_amount, NORMAL, VIEW);
    vec3 rim_light = rim_color.rgb * step(rim_threshold, rim);
    
    ALBEDO = albedo.rgb + rim_light;
}

void light() {
    float dotproduct = dot(NORMAL, LIGHT);
    
    // stepped toon shading
    float toon = smoothstep(shadow_threshold, shadow_threshold + shadow_smoothness, dotproduct);
    
    vec3 shaded = mix(shadow_color.rgb, albedo.rgb, toon);
    
    DIFFUSE_LIGHT += shaded * LIGHT_COLOR * ATTENUATION;
}