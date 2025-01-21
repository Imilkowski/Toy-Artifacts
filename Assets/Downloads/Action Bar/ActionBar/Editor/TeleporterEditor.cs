using Highrise.Lua.Generated;
using System;
using UnityEditor;
using UnityEngine;

[CustomEditor(typeof(Teleporter))]
public class TeleporterEditor : Editor
{
    private Teleporter _teleporter;

    private GUIContent _iconContent = new("Icon", "Icon to use for the button in the action bar.");
    private GUIContent _sortingContent = new("Sorting", "Determines the order the buttons appear in the action bar, lower numbers are further to the left.");
    private GUIStyle _labelStyle = null;

    private const float DiscRadius = 0.3f;
    private const string OneWayGuid = "96579e5e58c30d846b8cad7a4a2d3d40";
    private const string TwoWayGuid = "ae515ad82f07df143bf84339c830b4e9";
    private readonly Color HandleColor = new(0f, 0.0f, 0.5f, 1.0f);
    
    private void OnEnable()
    {
        _teleporter = target as Teleporter;
    }
    
    public override void OnInspectorGUI()
    {
        serializedObject.Update();
        
        EditorGUILayout.PropertyField(serializedObject.FindProperty("m_destination"));
        
        EditorGUILayout.PropertyField(serializedObject.FindProperty("m_playSound"));
        if (_teleporter.m_playSound)
        {
            EditorGUI.indentLevel++;
            EditorGUILayout.PropertyField(serializedObject.FindProperty("m_soundToPlay"));
            EditorGUI.indentLevel--;
        }
        
        EditorGUILayout.PropertyField(serializedObject.FindProperty("m_playParticleEffect"));
        if (_teleporter.m_playParticleEffect)
        {
            EditorGUI.indentLevel++;
            EditorGUILayout.PropertyField(serializedObject.FindProperty("m_teleportParticles"));
            EditorGUI.indentLevel--;
        }
        
        EditorGUILayout.PropertyField(serializedObject.FindProperty("m_useActionBar"));
        if (_teleporter.m_useActionBar)
        {
            EditorGUI.indentLevel++;
            EditorGUI.BeginChangeCheck();
            _teleporter.m_icon = EditorGUILayout.ObjectField(_iconContent, _teleporter.m_icon, typeof(Texture2D), false) as Texture2D;
            _teleporter.m_sorting = EditorGUILayout.IntField(_sortingContent, Convert.ToInt32(_teleporter.m_sorting));
            if(EditorGUI.EndChangeCheck())
                EditorUtility.SetDirty(_teleporter);
            EditorGUI.indentLevel--;
        }
        
        EditorGUILayout.PropertyField(serializedObject.FindProperty("m_resetCameraAfterTeleport"));

        var sceneView = SceneView.lastActiveSceneView;
        if (sceneView != null)
        {
            EditorGUILayout.BeginHorizontal();
            if(GUILayout.Button("Look At Teleporter"))
                sceneView.LookAt(_teleporter.transform.position, sceneView.rotation, 2.0f);
            if(GUILayout.Button("Look At Destination"))
                sceneView.LookAt(_teleporter.m_destination.position, sceneView.rotation, 2.0f);
            EditorGUILayout.EndHorizontal();
        }
        
        serializedObject.ApplyModifiedProperties();
    }

    public void OnSceneGUI()
    {
        if (_teleporter == null)
            return;

        var previousColor = Handles.color;
        Handles.color = HandleColor;
        
        Handles.DrawWireDisc(_teleporter.transform.position, Vector3.up, DiscRadius);
        
        if (_teleporter.m_destination == null)
            return;

        var destination = _teleporter.m_destination;
        Handles.DrawWireDisc(destination.position, Vector3.up, DiscRadius);
        
        EditorGUI.BeginChangeCheck();
        var newDestination = Handles.PositionHandle(destination.position, destination.rotation);
        if (EditorGUI.EndChangeCheck())
        {
            Undo.RecordObject(destination, "Move Destination");
            destination.position = newDestination;
        }

        _labelStyle ??= new GUIStyle("sv_label_2");
        if(_labelStyle != null)
            Handles.Label(destination.position, "Destination", _labelStyle);
        
        Handles.color = previousColor;
    }
    
    [MenuItem("GameObject/Highrise/One-Way Teleporter", false, 1)]
    public static void CreateOneWayTeleporter()
    {
        CreateTeleporter(OneWayGuid);
    }
    
    [MenuItem("GameObject/Highrise/Two-Way Teleporter", false, 1)]
    public static void CreateTwoWayTeleporter()
    {
        CreateTeleporter(TwoWayGuid);
    }

    private static void CreateTeleporter(string guid)
    {
        var prefab = AssetDatabase.LoadAssetAtPath<GameObject>(AssetDatabase.GUIDToAssetPath(guid));
        if (prefab == null)
            return;

        var go = (GameObject)PrefabUtility.InstantiatePrefab(prefab);
        if (go == null)
            return;
        
        GameObjectUtility.EnsureUniqueNameForSibling(go);
        Undo.RegisterCreatedObjectUndo(go, "Create " + go.name);
        Selection.activeGameObject = go;
    }
}