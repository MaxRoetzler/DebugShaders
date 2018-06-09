Shader "Debug/Light Bake"
{
	Properties
	{ }

	SubShader
	{
		Tags
		{
			"Queue" = "Geometry"
			"Lightmode" = "Always"
		}

        Pass
        {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct vertexInput
			{
				float4 vertex		: POSITION;
				float2 texcoord1	: TEXCOORD1;
			};

			struct vertexOutput
			{
				float4 position		: SV_POSITION;
				float2 texcoord		: TEXCOORD0;
			};

			vertexOutput vert (vertexInput input)
			{
				vertexOutput output;

				output.position = UnityObjectToClipPos (input.vertex);
				output.texcoord	= input.texcoord1 * unity_LightmapST.xy + unity_LightmapST.zw;

				return output;
			}

			float4 frag (vertexOutput input) : COLOR
			{
				float3 lightmap = DecodeLightmap (UNITY_SAMPLE_TEX2D (unity_Lightmap, input.texcoord));

				return float4 (lightmap, 1);
			}

			ENDCG
		}
	}
}