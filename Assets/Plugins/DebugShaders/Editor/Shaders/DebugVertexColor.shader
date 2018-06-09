Shader "Debug/Vertex Color"
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
				float4 color		: COLOR;
			};

			struct vertexOutput
			{
				float4 position		: SV_POSITION;
				float4 color		: COLOR;
			};

			vertexOutput vert (vertexInput input)
			{
				vertexOutput output;

				output.position = UnityObjectToClipPos (input.vertex);
				output.color	= input.color;

				return output;
			}

			float4 frag (vertexOutput input) : COLOR
			{
				return input.color;
			}

			ENDCG
		}
	}
}