// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Geometry/Wireframe"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        [PowerSlider(3.0)]
        _WireframeVal ("Wireframe width", Range(0., 0.34)) = 0.05
        _FrontColor ("Front color", color) = (1., 1., 1., 1.)
        _BackColor ("Back color", color) = (1., 1., 1., 1.)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
       
 
        Pass
        {
            Cull Front
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma geometry geom
            #include "UnityCG.cginc"
 
            struct v2g {
                float4 pos : SV_POSITION;
            };
 
            struct g2f {
                float4 pos : SV_POSITION;
                float3 bary : TEXCOORD0;
            };
 
            v2g vert(appdata_base v) {
                v2g o;
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }
 
            [maxvertexcount(3)]
            void geom(triangle v2g IN[3], inout TriangleStream<g2f> triStream) {
                g2f o;
                o.pos = IN[0].pos;
                o.bary = float3(1., 0., 0.);
                triStream.Append(o);
                o.pos = IN[1].pos;
                o.bary = float3(0., 0., 1.);
                triStream.Append(o);
                o.pos = IN[2].pos;
                o.bary = float3(0., 1., 0.);
                triStream.Append(o);
            }
 
            float _WireframeVal;
            fixed4 _BackColor;
 
            fixed4 frag(g2f i) : SV_Target {
            if(!any(bool3(i.bary.x < _WireframeVal, i.bary.y < _WireframeVal, i.bary.z < _WireframeVal)))
                 discard;
 
                return _BackColor;
            }
 
            ENDCG
        }
 
        Pass
        {
            Cull Back
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma geometry geom
            #include "UnityCG.cginc"
 
            struct v2g {
                float4 pos : SV_POSITION;
            };
 
            struct g2f {
                float4 pos : SV_POSITION;
                float3 bary : TEXCOORD0;
            };
 
            v2g vert(appdata_base v) {
                v2g o;
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }
 
            [maxvertexcount(3)]
            void geom(triangle v2g IN[3], inout TriangleStream<g2f> triStream) {
                g2f o;
                o.pos = IN[0].pos;
                o.bary = float3(1., 0., 0.);
                triStream.Append(o);
                o.pos = IN[1].pos;
                o.bary = float3(0., 0., 1.);
                triStream.Append(o);
                o.pos = IN[2].pos;
                o.bary = float3(0., 1., 0.);
                triStream.Append(o);
            }
 
            float _WireframeVal;
            fixed4 _FrontColor;
 
            fixed4 frag(g2f i) : SV_Target {
            if(!any(bool3(i.bary.x < _WireframeVal, i.bary.y < _WireframeVal, i.bary.z < _WireframeVal)))
                 discard;
 
                return _FrontColor;
            }
 
            ENDCG
        }
    }
}
/*Shader "Custom/NewSurfaceShader" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}*/
