
Shader "URP/Custom/SimpleWaterURP"
{
    Properties
    {
        _BaseMap("Base Map", 2D) = "white" {}
        _NormalMap("Normal Map", 2D) = "bump" {}
        _NormalScale("Normal Scale", Float) = 1
        _DeepColor("Deep Color", Color) = (0, 0, 0, 1)
        _ShallowColor("Shallow Color", Color) = (1, 1, 1, 1)
        _WaterDepth("Water Depth", Float) = 1
        _WaterFalloff("Water Falloff", Float) = 1
        _Distortion("Distortion", Float) = 0.1
        _Smoothness("Smoothness", Range(0, 1)) = 0.5
        _Metallic("Metallic", Range(0, 1)) = 0.0
    }

    SubShader
    {
        Tags { "RenderPipeline" = "UniversalRenderPipeline" "Queue" = "Transparent" "RenderType" = "Transparent" }
        LOD 200
        Cull Back
        Blend SrcAlpha OneMinusSrcAlpha
        ZWrite Off

        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            struct Attributes
            {
                float4 positionOS : POSITION;
                float2 uv : TEXCOORD0;
                float3 normalOS : NORMAL;
            };

            struct Varyings
            {
                float4 positionHCS : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            TEXTURE2D(_BaseMap);
            SAMPLER(sampler_BaseMap);

            TEXTURE2D(_NormalMap);
            SAMPLER(sampler_NormalMap);

            float4 _DeepColor;
            float4 _ShallowColor;
            float _WaterDepth;
            float _WaterFalloff;
            float _NormalScale;
            float _Distortion;
            float _Smoothness;
            float _Metallic;

            Varyings vert (Attributes IN)
            {
                Varyings OUT;
                OUT.positionHCS = TransformObjectToHClip(IN.positionOS.xyz);
                OUT.uv = IN.uv;
                return OUT;
            }

            half4 frag (Varyings IN) : SV_Target
            {
                float3 normal = UnpackNormal(SAMPLE_TEXTURE2D(_NormalMap, sampler_NormalMap, IN.uv));
                float4 baseColor = lerp(_DeepColor, _ShallowColor, 0.5); // Depth-based blend placeholder

                return half4(baseColor.rgb, 0.8); // Semi-transparent water
            }
            ENDHLSL
        }
    }
    FallBack "Hidden/Universal Forward"
}
