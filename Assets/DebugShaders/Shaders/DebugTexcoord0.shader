Shader "Debug/Texcoord 0"
{
	Properties
	{
		_DebugUvGrid("", 2D) = "" {}
	}

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

			uniform sampler2D _DebugUvGrid;

			struct vertexInput
			{
				float4 vertex		: POSITION;
				float2 texcoord0	: TEXCOORD0;
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
				output.texcoord	= input.texcoord0;

				return output;
			}

			float4 frag (vertexOutput input) : COLOR
			{
				return tex2D (_DebugUvGrid, input.texcoord);
			}

			ENDCG
		}
	}
}