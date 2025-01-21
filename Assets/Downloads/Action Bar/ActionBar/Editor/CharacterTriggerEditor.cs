using Highrise.Lua.Generated;
using Highrise.Studio;
using UnityEditor;
using UnityEngine;

[CustomEditor(typeof(CharacterTrigger))]
public class CharacterTriggerEditor : LuaThunkEditor
{
    private const string GUID = "ed36dfa7ba5ad7b4bbf70bd891f925e2";
    
    [MenuItem("GameObject/Highrise/Character Trigger", false, 1)]
    public static void CreateOneWayTeleporter()
    {
        var prefab = AssetDatabase.LoadAssetAtPath<GameObject>(AssetDatabase.GUIDToAssetPath(GUID));
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