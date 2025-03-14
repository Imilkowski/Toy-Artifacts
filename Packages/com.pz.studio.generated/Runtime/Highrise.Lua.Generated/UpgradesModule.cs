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
    [AddComponentMenu("Lua/UpgradesModule")]
    [LuaRegisterType(0xc8f7e72d5ff79a44, typeof(LuaBehaviour))]
    public class UpgradesModule : LuaBehaviourThunk
    {
        private const string s_scriptGUID = "8457691521963734183e823b286474aa";
        public override string ScriptGUID => s_scriptGUID;

        [SerializeField] public System.Collections.Generic.List<UnityEngine.Texture> m_upgradeIcons = default;
        [LuaScriptPropertyAttribute("442a0e5211fe7f34c9772f063dbc3129")]
        [SerializeField] public UnityEngine.Object m_teleportsManager = default;

        protected override SerializedPropertyValue[] SerializeProperties()
        {
            if (_script == null)
                return Array.Empty<SerializedPropertyValue>();

            return new SerializedPropertyValue[]
            {
                CreateSerializedProperty(_script.GetPropertyAt(0), m_upgradeIcons),
                CreateSerializedProperty(_script.GetPropertyAt(1), m_teleportsManager),
            };
        }
    }
}

#endif
