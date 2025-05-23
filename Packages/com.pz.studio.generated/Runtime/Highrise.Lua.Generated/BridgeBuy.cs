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
    [AddComponentMenu("Lua/BridgeBuy")]
    [LuaRegisterType(0x9cc11742a57b4da0, typeof(LuaBehaviour))]
    public class BridgeBuy : LuaBehaviourThunk
    {
        private const string s_scriptGUID = "3f45ed2b894ab484494ff4c07a257658";
        public override string ScriptGUID => s_scriptGUID;

        [SerializeField] public System.Double m_repairCost = 0;
        [SerializeField] public System.String m_upgradeId = "";
        [SerializeField] public UnityEngine.GameObject m_middlePart = default;
        [SerializeField] public UnityEngine.GameObject m_blocker = default;
        [SerializeField] public UnityEngine.GameObject m_sign = default;

        protected override SerializedPropertyValue[] SerializeProperties()
        {
            if (_script == null)
                return Array.Empty<SerializedPropertyValue>();

            return new SerializedPropertyValue[]
            {
                CreateSerializedProperty(_script.GetPropertyAt(0), m_repairCost),
                CreateSerializedProperty(_script.GetPropertyAt(1), m_upgradeId),
                CreateSerializedProperty(_script.GetPropertyAt(2), m_middlePart),
                CreateSerializedProperty(_script.GetPropertyAt(3), m_blocker),
                CreateSerializedProperty(_script.GetPropertyAt(4), m_sign),
            };
        }
    }
}

#endif
