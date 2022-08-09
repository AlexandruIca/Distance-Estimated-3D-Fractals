// Vertex shader

struct VertexInput {
    @location(0) position: vec3<f32>,
    @location(1) color: vec3<f32>,
};

struct VertexOutput {
    @builtin(position) clip_position: vec4<f32>,
    @location(0) color: vec3<f32>,
};

@vertex
fn vs_main(
    model: VertexInput,
) -> VertexOutput {
    var out: VertexOutput;
    out.color = model.color;
    out.clip_position = vec4<f32>(model.position, 1.0);
    return out;
}

// Fragment shader

fn distance_from_sphere(p: vec3<f32>, c: vec3<f32>, r: f32) -> f32 {
    return length(p - c) - r;
}

fn ray_march(ray_origin: vec3<f32>, ray_direction: vec3<f32>) -> vec3<f32> {
    var total_distance_travelled: f32 = 0.0;
    // `const` is not currently available in rust-wgpu :(
    let NUMBER_OF_STEPS: i32 = 32;
    let MINIMUM_HIT_DISTANCE: f32 = 0.001;
    let MAXIMUM_TRACE_DISTANCE: f32 = 1000.0;

    for (var i: i32 = 0; i < NUMBER_OF_STEPS; i++) {
        let current_position = ray_origin + total_distance_travelled * ray_direction;
        let distance_to_closest = distance_from_sphere(current_position, vec3(0.0, 0.0, 0.0), 1.0);

        if distance_to_closest < MINIMUM_HIT_DISTANCE {
            return vec3(1.0, 0.0, 0.0);
        }

        if total_distance_travelled > MAXIMUM_TRACE_DISTANCE {
            break;
        }

        total_distance_travelled += distance_to_closest;
    }

    return vec3(0.0, 0.0, 0.0);
}

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    let ray_origin = vec3(0.0, 0.0, -5.0);
    let ray_direction = vec3(in.clip_position.xy, 1.0);
    let shaded_color = ray_march(ray_origin, ray_direction);
    return vec4<f32>(shaded_color, 1.0);
}