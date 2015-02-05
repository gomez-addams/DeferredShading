﻿Shader "Custom/PostEffect_Water" {
Properties {
}
SubShader {
    Tags { "RenderType"="Opaque" }
    Blend One One
    ZTest Always
    ZWrite Off
    Cull Back

    CGINCLUDE
    #include "Compat.cginc"
    #include "DSBuffers.cginc"

    struct ia_out
    {
        float4 vertex : POSITION;
    };

    struct vs_out
    {
        float4 vertex : SV_POSITION;
        float4 screen_pos : TEXCOORD0;
    };

    struct ps_out
    {
        float4 color : COLOR0;
    };


    vs_out vert(ia_out v)
    {
        vs_out o;
        o.vertex = v.vertex;
        o.screen_pos = v.vertex;
        return o;
    }

    ps_out frag(vs_out i)
    {
        float2 coord = (i.screen_pos.xy / i.screen_pos.w + 1.0) * 0.5;
        #if UNITY_UV_STARTS_AT_TOP
            coord.y = 1.0-coord.y;
        #endif

        ps_out r;
        r.color = 0.0;
        return r;
    }
    ENDCG

    Pass {
        CGPROGRAM
        #pragma vertex vert
        #pragma fragment frag
        #pragma target 3.0
        #ifdef SHADER_API_OPENGL 
            #pragma glsl
        #endif
        ENDCG
    }
}
}
