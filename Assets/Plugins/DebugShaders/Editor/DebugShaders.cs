/// Date	: 27/03/2018
/// Company	: Fantastic, yes
/// Author	: Maximilian Rötzler
/// License	: This code is licensed under MIT license

using UnityEngine;
using UnityEditor;

public class DebugShaders
{
	private string m_path;
	private int m_selection;
	private Shader [] m_shaders;
	private GUIContent [] m_labels;

	/// <summary>
	/// Create a new instance of <ctor>DebugShaders</ctor> and initialize it.
	/// </summary>
	public DebugShaders ()
	{
		string [] guids = AssetDatabase.FindAssets ("t:Folder DebugShaders");

		if (guids.Length == 1)
		{
			m_path = AssetDatabase.GUIDToAssetPath (guids [0]);
			guids = AssetDatabase.FindAssets ("t:Shader", new string [1] { m_path });

			int length = guids.Length + 1;

			m_shaders = new Shader [length];
			m_shaders [0] = null;

			m_labels = new GUIContent [length];
			m_labels [0] = new GUIContent ("Default");

			for (int i = 1; i < length; i++)
			{
				m_shaders [i] = AssetDatabase.LoadAssetAtPath<Shader> (AssetDatabase.GUIDToAssetPath (guids [i - 1]));
				m_labels [i] = new GUIContent (m_shaders [i].name.Substring (6)); // Remove Debug from name
			}
		}
		else
		{
			m_shaders = new Shader [1] { null };
			m_labels = new GUIContent [1] { new GUIContent ("Default") };

			Debug.LogError ("[DebugShaders] Failed to load debug shaders! Make sure the directory: DebugShaders and sub-folder: Shaders exist!");
		}
	}

	/// <summary>
	/// Draw the DebugShaders UI control.
	/// </summary>
	/// <param name="rect"></param>
	public void Draw (Rect rect)
	{
		EditorGUI.BeginChangeCheck ();
		m_selection = EditorGUI.Popup (rect, GUIContent.none, m_selection, m_labels);

		if (EditorGUI.EndChangeCheck ())
		{
			Shader shader = m_shaders [m_selection];

			// Load additional resources
			if (m_selection > 0)
			{
				int propertyCount = ShaderUtil.GetPropertyCount (shader);

				for (int i = 0; i < propertyCount; i++)
				{
					if (ShaderUtil.GetPropertyType (shader, i) == ShaderUtil.ShaderPropertyType.TexEnv)
					{
						string textureName = ShaderUtil.GetPropertyName (shader, i);
						Texture2D textureFile = AssetDatabase.LoadAssetAtPath<Texture2D> (m_path + "/Editor/Textures/" + textureName.TrimStart ('_') + ".png");

						if (textureFile != null)
						{
							Shader.SetGlobalTexture (textureName, textureFile);
						}
					}
				}
			}

			SceneView.lastActiveSceneView.SetSceneViewShaderReplace (shader, null);
			SceneView.RepaintAll ();
		}
	}
}
