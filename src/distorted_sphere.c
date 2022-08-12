#include "sokol_app.h"
#include "sokol_gfx.h"
#include "sokol_glue.h"

#include "distorted_sphere.glsl.h"

static struct {
    sg_pass_action pass_action;
    sg_pipeline pip;
    sg_bindings bind;
} state;

void init(void)
{
    sg_setup(&(sg_desc) {
        .context = sapp_sgcontext() });

    float vertices[] = {
        -1.0F, 1.0F, // top left
        -1.0F, -1.0F, // bottom left
        1.0F, -1.0F, // bottom right
        1.0F, 1.0F, // top right
    };

    state.bind.vertex_buffers[0] = sg_make_buffer(&(sg_buffer_desc) {
        .data = SG_RANGE(vertices),
        .label = "quad-vertices" });

    uint16_t indices[] = { 0, 1, 2, 2, 3, 0 };

    state.bind.index_buffer = sg_make_buffer(&(sg_buffer_desc) {
        .type = SG_BUFFERTYPE_INDEXBUFFER,
        .data = SG_RANGE(indices),
        .label = "quad-indices" });

    sg_shader shd = sg_make_shader(quad_shader_desc(sg_query_backend()));

    state.pip = sg_make_pipeline(&(sg_pipeline_desc) {
        .shader = shd,
        .index_type = SG_INDEXTYPE_UINT16,
        .layout = {
            .attrs = {
                [ATTR_vs_position].format = SG_VERTEXFORMAT_FLOAT2,
            } },
        .label = "quad-pipeline" });

    state.pass_action = (sg_pass_action) {
        .colors[0] = { .action = SG_ACTION_CLEAR, .value = { 0.0F, 0.0F, 0.0F, 1.0F } }
    };
}

void frame(void)
{
    sg_begin_default_pass(&state.pass_action, sapp_width(), sapp_height());
    sg_apply_pipeline(state.pip);
    sg_apply_bindings(&state.bind);
    sg_draw(0, 6, 1);
    sg_end_pass();
    sg_commit();
}

void cleanup(void)
{
    sg_shutdown();
}

sapp_desc sokol_main(int argc, char* argv[])
{
    (void)argc;
    (void)argv;
    return (sapp_desc) {
        .init_cb = init,
        .frame_cb = frame,
        .cleanup_cb = cleanup,
        .event_cb = NULL,
        .width = 800,
        .height = 800,
        .window_title = "Distorted Sphere",
        .icon.sokol_default = true,
    };
}
