/// Date	: 09/06/2018
/// Company	: Fantastic, yes
/// Author	: Maximilian Rötzler
/// License	: This code is licensed under MIT license

using UnityEngine;
using UnityEditor;

namespace FantasticYes.Tools
{
	public class DebugShaderControl : EditorWindow
	{
		private DebugShaders m_debugShaders;

		public void OnGUI ()
		{
			Rect rect = EditorGUILayout.GetControlRect ();
			m_debugShaders.Draw (rect);
		}

		private void OnEnable ()
		{
			m_debugShaders = new DebugShaders ();
		}

		[MenuItem ("Tools/FantasticYes/DebugShaders")]
		public static void Open ()
		{
			GetWindow<DebugShaderControl> ().Show ();
		}
	}
}