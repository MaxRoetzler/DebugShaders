Shader "Debug/Light Reflection"
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
			#include "UnityStandardConfig.cginc"

			struct vertexInput
			{
				float4 vertex		: POSITION;
				float3 normal		: NORMAL;
			};

			struct vertexOutput
			{
				float4 position		: SV_POSITION;
				float3 reflection	: TEXCOORD0;
			};

			vertexOutput vert (vertexInput input)
			{
				vertexOutput output;

				float3 worldNormal		= UnityObjectToWorldNormal (input.normal);
				float3 worldPosition	= mul (unity_ObjectToWorld, input.vertex).xyz;
				float3 worldView		= normalize (_WorldSpaceCameraPos - worldPosition);

				output.position			= UnityObjectToClipPos (input.vertex);
				output.reflection		= reflect (-worldView, worldNormal);

				return output;
			}

			float4 frag (vertexOutput input) : COLOR
			{
				half4 reflection	= UNITY_SAMPLE_TEXCUBE_LOD (unity_SpecCube0, input.reflection, 0);
				reflection.rgb		= DecodeHDR (reflection, unity_SpecCube0_HDR);

				return reflection;
			}

			ENDCG
		}
	}
}