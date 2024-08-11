params ["_player", "_didJIP"];
enableSaving [false, false];


// allow U menu for easier team management
["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;


// make Indfor slots ACE spectators
if (playerSide == independent) then { 
    [true, true, false] call ace_spectator_fnc_setSpectator;
};


// prevent non-commanders from using the cruise missile launcher
private _rankId = rankId player;
private _rankInfo = format ["%1 is a %2", name player, rank player];
if (_rankId < 3) then {  // Lieutenants and higher ranks may use the VLS
    diag_log (_rankInfo + " and may NOT use the VLS.");
    ["loadout", {
        params ["_unit", "_newUnitLoadout", "_oldUnitLoadout"];
        if (playerSide == west) then { 
            player disableUAVConnectability [blufor_vls, true];
        };
        if (playerSide == east) then { 
            player disableUAVConnectability [opfor_vls, true];
        };
    }] call CBA_fnc_addPlayerEventHandler;
} else {
    diag_log (_rankInfo + " and may use the VLS.");
};


// prevent use of enemy UAV terminals and radios
["loadout", {
    params ["_unit", "_newUnitLoadout", "_oldUnitLoadout"];
    private _notBluFor = (side group _unit) isNotEqualTo blufor;
    private _removeUavTerminal = ["O_UavTerminal", "B_UavTerminal"] select _notBluFor;
    private _removeRadioSR     = ["TFAR_fadak", "TFAR_anprc152"] select _notBluFor;
    private _removeRadioLR     = ["UK3CB_B_O_Assault_camo_Radio", "TFAR_rt1523g_bwmod"] select _notBluFor;
    private _newLoadout = (str _newUnitLoadout);
    if (  _removeUavTerminal in _newLoadout ||
          _removeRadioSR     in _newLoadout || 
          _removeRadioLR     in _newLoadout
        ) then {
      _unit setUnitLoadout _oldUnitLoadout;   // restore previous loadout
      hint parseText "Don't even think of looting enemies<br/><t color='#ff0000'>for radios or UAV terminals!!!</t>";
    };
}] call CBA_fnc_addPlayerEventHandler;


// radio range booster towers
fnc_TFAR_Boost_RadioTower_Loop = {
    private _isBackToNormal = player getVariable ["tf_sendingDistanceMultiplicator", 1] == 1;
    private _radioTowersInRange = nearestObjects [player, ["Land_TTowerBig_1_F", "Land_TTowerBig_2_F"], 15, true];
    if (count _radioTowersInRange > 0) then {
        // boost radio range by factor of 10
        if (_isBackToNormal) then {
            hint parseText format ["Radio tower nearby. <br/> <t color='#00ffff'>You now have 10x radio range.</t>"];
        };
        player setVariable ["tf_receivingDistanceMultiplicator", 1/10, true];
        player setVariable ["tf_sendingDistanceMultiplicator", 10, true];
    } else {
        // reset radio range back to normal
        if (!_isBackToNormal) then {
            hint parseText format ["Radio tower out of range. <br/> Your radio range is back to normal."];
        };
        player setVariable ["tf_receivingDistanceMultiplicator", 1, true];
        player setVariable ["tf_sendingDistanceMultiplicator", 1, true];    
    };
};
[fnc_TFAR_Boost_RadioTower_Loop, 2] call CBA_fnc_addPerFrameHandler; 


// store last unloaded Mk6 mortar 
// (as workaround for https://github.com/acemod/ACE3/issues/10010)
["ace_cargoUnloaded", {
    params ["_item", "_vehicle", "_unloadType"];
    if (_item isKindOf "Mortar_01_base_F") then {
        localNamespace setVariable ["shootnscoot_lastUnloadedMortar", _item];
    };    
}] call CBA_fnc_addEventHandler;


// allow opening ingame documentation...
private _openDocuCode = {
    openMap true;
    player selectDiarySubject "shootnscoot_diarySubject:Record-1"; 
};
// ...from Vanilla mouse-wheel menu
player addAction ["Open <t color='#D18D1F'>Shoot and Scoot</t> docu", _openDocuCode, 
nil,    // no arguments for inner script
-100,   // super low prio to always display at bottom of list
false   // don't show menu action on middle of the screen
];
// ...from ACE self-action menu
private _action = ["Open Docu",
"Shoot and Scoot docu",
"\A3\ui_f\data\map\markers\handdrawn\unknown_CA.paa",
_openDocuCode,
{true}    // always add this action (without condition)
] call ace_interact_menu_fnc_createAction;
[(typeOf player), 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToClass;


// prevent map markers because this would be too easy 
// --> we want to foster teamplay through radio comms instead
0 enableChannel false;  // disable  global   channel
1 enableChannel false;  // disable  side     channel
2 enableChannel false;  // disable  command  channel
3 enableChannel false;  // disable  group    channel
