Shader "Debug/Light Probe"
{
	Properties
	{ }

	SubShader
	{
		Tags
		{
			"Queue" = "Geometry"
			"RenderType" = "Opaque"
			"Lightmode" = "ForwardBase"
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
				float3 normal		: NORMAL;
			};

			struct vertexOutput
			{
				float4 position		: SV_POSITION;
				float3 color		: COLOR;
			};

			vertexOutput vert (vertexInput input)
			{
				vertexOutput output;

				float3 worldNormal = UnityObjectToWorldNormal (input.normal);

				output.position = UnityObjectToClipPos (input.vertex);
				output.color = ShadeSH9 (float4 (worldNormal, 1));

				return output;
			}

			float4 frag (vertexOutput input) : COLOR
			{
				return float4 (input.color, 1);
			}

			ENDCG
		}
	}
}