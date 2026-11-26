-- Balatro swirl background (shaders/balatro.glsl).
return {
    meta = { name = "Balatro" },
    -- Battery-friendly: the effect is already pixelated, so half-resolution
    -- rendering looks the same (pixel size scales with iResolution) at about
    -- a quarter of the GPU work, and 30 fps is plenty for a slow swirl.
    fps_limit = 30,
    layers = {
        {
            effect = "ShaderToy Sandbox",
            tag = "main",
            clear_depth = true,
            settings = {
                -- Filled in by Nix with the shader's absolute store path.
                shader_file = "@SHADER@",
                layer_fbo_size = {0.5, 0.5},
            },
        },
    },
}
