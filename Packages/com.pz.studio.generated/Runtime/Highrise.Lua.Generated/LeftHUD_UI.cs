/*

    Copyright (c) 2025 Pocketz World. All rights reserved.

    This is a generated file, do not edit!

    Generated by com.pz.studio
*/

#if UNITY_EDITOR

using System;
using System.Linq;
using UnityEngine;
using Highrise.Client;
using Highrise.Studio;
using Highrise.Lua;

namespace Highrise.Lua.Generated
{
    [AddComponentMenu("Lua/LeftHUD_UI")]
    [LuaRegisterType(0x4d19413f7eb5b0a4, typeof(LuaBehaviour))]
    public class LeftHUD_UI : LuaBehaviourThunk
    {
        private const string s_scriptGUID = "ce6d7af3415efa440be9f37545cc3f2b";
        public override string ScriptGUID => s_scriptGUID;

        [SerializeField] public UnityEngine.Texture m_coinIcon = default;
        [SerializeField] public UnityEngine.Texture m_shopIcon = default;
        [SerializeField] public UnityEngine.Texture m_tutorialIcon = default;
        [SerializeField] public UnityEngine.Texture m_IWP_icon = default;

        protected override SerializedPropertyValue[] SerializeProperties()
        {
            if (_script == null)
                return Array.Empty<SerializedPropertyValue>();

            return new SerializedPropertyValue[]
            {
                CreateSerializedProperty(_script.GetPropertyAt(0), m_coinIcon),
                CreateSerializedProperty(_script.GetPropertyAt(1), m_shopIcon),
                CreateSerializedProperty(_script.GetPropertyAt(2), m_tutorialIcon),
                CreateSerializedProperty(_script.GetPropertyAt(3), m_IWP_icon),
                CreateSerializedProperty(_script.GetPropertyAt(4), null),
                CreateSerializedProperty(_script.GetPropertyAt(5), null),
                CreateSerializedProperty(_script.GetPropertyAt(6), null),
                CreateSerializedProperty(_script.GetPropertyAt(7), null),
                CreateSerializedProperty(_script.GetPropertyAt(8), null),
                CreateSerializedProperty(_script.GetPropertyAt(9), null),
                CreateSerializedProperty(_script.GetPropertyAt(10), null),
                CreateSerializedProperty(_script.GetPropertyAt(11), null),
            };
        }
    }
}

#endif
