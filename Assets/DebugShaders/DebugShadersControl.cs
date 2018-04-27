/// Date	: 27/03/2018
/// Company	: Fantastic, yes
/// Author	: Maximilian Rötzler
/// License	: This code is licensed under MIT license

using UnityEngine;
using UnityEditor;

namespace FantasticYes.Tools
{
	[AddToToolbar ("DebugControl", "Debug Render Modes", ToolbarGroup.Art, 0)]
	public class DebugShaderControl : ToolbarControl
	{
		private DebugShaders m_debugShaders;

		public override void OnGUI ()
		{
			m_debugShaders.OnGUI (GUIContent.none);
		}

		private void OnEnable ()
		{
			m_debugShaders = new DebugShaders ();
		}
	}
}