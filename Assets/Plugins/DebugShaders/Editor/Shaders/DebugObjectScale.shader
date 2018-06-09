Shader "Debug/Object Scale"
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

				float worldScale = 0;

				worldScale += length (float3 (unity_ObjectToWorld[0].x, unity_ObjectToWorld[1].x, unity_ObjectToWorld[2].x));
				worldScale += length (float3 (unity_ObjectToWorld[0].y, unity_ObjectToWorld[1].y, unity_ObjectToWorld[2].y));
				worldScale += length (float3 (unity_ObjectToWorld[0].z, unity_ObjectToWorld[1].z, unity_ObjectToWorld[2].z));
				worldScale /= 3;

				if (worldScale >= 1.0)
				{
					worldScale = 1.0 / worldScale;
				}

				output.position = UnityObjectToClipPos (input.vertex);
				output.color = float3 (1 - worldScale, worldScale, 0);

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