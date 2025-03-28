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
    [AddComponentMenu("Lua/Upgrades_UI")]
    [LuaRegisterType(0xeebfcea349e1a5e7, typeof(LuaBehaviour))]
    public class Upgrades_UI : LuaBehaviourThunk
    {
        private const string s_scriptGUID = "cc2d86f5e3aeed041b46c799b231e707";
        public override string ScriptGUID => s_scriptGUID;

        [SerializeField] public UnityEngine.Texture m_closeIcon = default;
        [SerializeField] public UnityEngine.Texture m_coinIcon = default;

        protected override SerializedPropertyValue[] SerializeProperties()
        {
            if (_script == null)
                return Array.Empty<SerializedPropertyValue>();

            return new SerializedPropertyValue[]
            {
                CreateSerializedProperty(_script.GetPropertyAt(0), m_closeIcon),
                CreateSerializedProperty(_script.GetPropertyAt(1), m_coinIcon),
                CreateSerializedProperty(_script.GetPropertyAt(2), null),
                CreateSerializedProperty(_script.GetPropertyAt(3), null),
                CreateSerializedProperty(_script.GetPropertyAt(4), null),
                CreateSerializedProperty(_script.GetPropertyAt(5), null),
            };
        }
    }
}

#endif
