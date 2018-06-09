// Shader by Keijiro Takahashi
// https://github.com/keijiro

Shader "Debug/Vertex World Normal"
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

		Cull Off

        Pass
        {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct vertexInput
			{
				float4 vertex		: POSITION;
				float3 normal		: NORMAL;
			};

			struct vertexOutput
			{
				float4 position		: SV_POSITION;
				float3 normal		: NORMAL;
			};

			vertexOutput vert (vertexInput input)
			{
				vertexOutput output;

				output.position = UnityObjectToClipPos (input.vertex);
				output.normal = UnityObjectToWorldNormal (input.normal);

				return output;
			}

			float4 frag (vertexOutput input, fixed vface : VFACE) : SV_Target
			{
				float3 c = input.normal / 2 + 0.5;

				c = lerp (c, float3 (1, 0, 0), vface < 0);
				c = GammaToLinearSpace(c);

				return float4 (c, 1);
			}

			ENDCG
		}
	}
}