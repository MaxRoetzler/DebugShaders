﻿/// Date	: 27/03/2018
/// Company	: Fantastic, yes
/// Author	: Maximilian Rötzer
/// License	: This code is licensed under MIT license

using UnityEngine;
using UnityEditor;

public class DebugShaderWindow : EditorWindow
{
	private DebugShaders m_debugShaders;

	private void OnGUI ()
	{
		m_debugShaders.Draw (new GUIContent ("Render Mode"));
	}

	private void OnEnable ()
	{
		minSize = new Vector2 (200, 25);
		titleContent = new GUIContent ("Debug Shaders");

		m_debugShaders = new DebugShaders ();
	}

	[MenuItem ("Window/Debug Shaders")]
	public static void Open ()
	{
		GetWindow <DebugShaderWindow> ().Show ();
	}
}