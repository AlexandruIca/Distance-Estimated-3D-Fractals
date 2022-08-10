const defaultVertexShader = `
#version 300 es

in vec4 position;
out vec2 vPosition;

void main()
{
    vPosition = position.zw;
    gl_Position = vec4(position.xy, 0.0, 1.0);
}
`;

function createWebGL2Context(canvas, options, onError) {
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;

    const gl = canvas.getContext('webgl2', options);

    if (!gl) {
        onError("WebGL 2 is not available!");
        canvas.parentElement.innerHTML = "This example requires WebGL 2 which is unavailable on this device.";
    } else {
        gl.viewport(0, 0, gl.drawingBufferWidth, gl.drawingBufferHeight);
        gl.clearColor(0, 0, 0, 1);
    }

    return gl;
}

function getScreenRectVertices() {
    if (window.innerWidth > window.innerHeight) {
        const base = window.innerHeight;
        const bigger = window.innerWidth;
        const scale = bigger / base;
        const offset = (scale - 1) / 2;

        return new Float32Array([
            -1.0, 1.0, -1.0 - offset, 1.0, // top left
            -1.0, -1.0, -1.0 - offset, -1.0, // bottom left
            1.0, -1.0, 1.0 + offset, -1.0, // bottom right
            1.0, -1.0, 1.0 + offset, -1.0, // bottom right
            1.0, 1.0, 1.0 + offset, 1.0, // top right
            -1.0, 1.0, -1.0 - offset, 1.0 // top left
        ]);
    } else {
        const base = window.innerWidth;
        const bigger = window.innerHeight;
        const scale = bigger / base;
        const offset = (scale - 1) / 2;

        return new Float32Array([
            -1.0, 1.0, -1.0, 1.0 + offset, // top left
            -1.0, -1.0, -1.0, -1.0 - offset, // bottom left
            1.0, -1.0, 1.0, -1.0 - offset, // bottom right
            1.0, -1.0, 1.0, -1.0 - offset, // bottom right
            1.0, 1.0, 1.0, 1.0 + offset, // top right
            -1.0, 1.0, -1.0, 1.0 + offset // top left
        ]);
    }
}

function onResize(gl, canvas, vertexBuffer) {
    canvas.width = canvas.clientWidth;
    canvas.height = canvas.clientHeight;
    gl.viewport(0, 0, gl.drawingBufferWidth, gl.drawingBufferHeight);

    const newScreenRect = getScreenRectVertices();
    gl.bindBuffer(gl.ARRAY_BUFFER, vertexBuffer);
    gl.bufferSubData(gl.ARRAY_BUFFER, 0, newScreenRect, 0, newScreenRect.length);
}

function createPipeline(gl, vertexShaderSource, fragmentShaderSource, onError) {
    const vertShader = gl.createShader(gl.VERTEX_SHADER);
    const fragShader = gl.createShader(gl.FRAGMENT_SHADER);

    gl.shaderSource(vertShader, vertexShaderSource.trim());
    gl.compileShader(vertShader);

    if (!gl.getShaderParameter(vertShader, gl.COMPILE_STATUS)) {
        onError(gl.getShaderInfoLog(vertShader));
    }

    gl.shaderSource(fragShader, fragmentShaderSource.trim());
    gl.compileShader(fragShader);

    if (!gl.getShaderParameter(fragShader, gl.COMPILE_STATUS)) {
        onError(gl.getShaderInfoLog(fragShader));
    }

    const program = gl.createProgram();
    gl.attachShader(program, vertShader);
    gl.attachShader(program, fragShader);
    gl.linkProgram(program);

    if (!gl.getProgramParameter(program, gl.LINK_STATUS)) {
        onError(gl.getProgramInfoLog(program));
    }

    return program;
}

function createAndBindVertexBuffer(gl, program, vertices) {
    const vertexBuffer = gl.createBuffer();
    const positionCoord = gl.getAttribLocation(program, "position");
    gl.bindBuffer(gl.ARRAY_BUFFER, vertexBuffer);
    gl.bufferData(gl.ARRAY_BUFFER, vertices, gl.STATIC_DRAW);
    gl.vertexAttribPointer(positionCoord, 4, gl.FLOAT, false, 0, 0);
    gl.enableVertexAttribArray(positionCoord);

    return vertexBuffer;
}

function render(callback) {
    gl.clear(gl.COLOR_BUFFER_BIT);

    callback();

    gl.drawArrays(gl.TRIANGLES, 0, 6);
    window.requestAnimationFrame(() => render(callback));
}
