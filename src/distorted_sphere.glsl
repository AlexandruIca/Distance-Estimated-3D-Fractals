@vs vs
in vec2 position;
out vec4 color;

void main() {
    gl_Position = vec4(position, 0.0, 1.0);
    color = vec4(0.7, 0.2, 0.4, 1.0);
}
@end

@fs fs
in vec4 color;
out vec4 frag_color;

void main() {
    frag_color = color;
}
@end

@program quad vs fs
