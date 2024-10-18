params ["_player", "_didJIP"];
enableSaving [false, false];


// allow U menu for easier team management
["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;


// make Indfor slots ACE spectators
if (playerSide == independent) then { 
    {
        [true, true, false] call ace_spectator_fnc_setSpectator;    // this will call TFAR funcs...
    } call CBA_fnc_directCall;  // ...which shall only be called in unscheduled environment
};


// prevent non-commanders from using the cruise missile launcher
private _rankId = rankId player;
private _rankInfo = format ["%1 is a %2", name player, rank player];
private _missileTracking = false;   // shall player track launched cruise missiles?
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
    _missileTracking = true;    // commanders shall track cruise missiles
};  
// enable cruise missile video feed and moving map marker after launch
private _VLStoMonitor = [];     // list of missile launchers to monitor for events
switch (playerSide) do
{
    case west: { _VLStoMonitor = [blufor_vls];  };
    case east: { _VLStoMonitor = [opfor_vls];   };
    // default    { _missileTracking = true;
    //              _VLStoMonitor = [blufor_vls, opfor_vls];   };   // for Zeus and streamers monitor both missile launchers
};
if (_missileTracking) then {
    // start video live feed when event with video source and target is received
    ["cruise_missile_live_feed_event", {
        params ["_projectile", "_gunner", "_magazine"];
        
        private _cameraTarget = missileTarget _projectile;
        diag_log format ["initPlayerLocal.sqf cruise_missile_live_feed_event: local _projectile ? '%1', _cameraTarget = '%2'", local _projectile, _cameraTarget];
        if ( local _projectile && !isNull _cameraTarget ) then {    // if this is not a given the remaining calls aren't without residual problems
        // if (playerSide == side _gunner || playerSide in [independent, civilian]) then {
            // if (isNull _cameraTarget) then { 
            //     _cameraTarget = getMarkerPos "demarkation_line";    // fallback target in the center of the map
            // };
            [_projectile, _cameraTarget, player, 0] call BIS_fnc_liveFeed;                  // add video live feed when "Fired"
            _projectile addEventHandler ["Deleted", { call BIS_fnc_liveFeedTerminate; }];   // terminate live feed when "Deleted"            
            [_projectile, _gunner, _magazine] call shelltracker_fnc_onFired;                // handling of moving map marker
        };
    }] call CBA_fnc_addEventHandler;

    {
        // add "Fired" event handler to send cruise_missile_live_feed_event
        _x addEventHandler ["Fired", {
            params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
            diag_log format ["initPlayerLocal.sqf Fired_EH: _projectile = '%1', _gunner = '%2', _magazine = '%3'", _projectile, _gunner, _magazine];
            ["cruise_missile_live_feed_event", [_projectile, _gunner, _magazine]] call CBA_fnc_globalEvent;     // send video source and target to other machines
        }];        
    } forEach _VLStoMonitor;
};


// prevent use of enemy UAV terminals and radios
["loadout", {
    params ["_unit", "_newUnitLoadout", "_oldUnitLoadout"];
    private _notBluFor = (side group _unit) isNotEqualTo blufor;
    private _removeUavTerminal = ["O_UavTerminal", "B_UavTerminal"] select _notBluFor;
    // private _removeRadioSR     = ["TFAR_fadak", "TFAR_anprc152"] select _notBluFor;
    // private _removeRadioLR     = ["UK3CB_B_O_Assault_camo_Radio", "TFAR_rt1523g_bwmod"] select _notBluFor;
    private _newLoadout = (str _newUnitLoadout);
    if (  _removeUavTerminal in _newLoadout /* ||
          _removeRadioSR     in _newLoadout || 
          _removeRadioLR     in _newLoadout */
        ) then {
      _unit setUnitLoadout _oldUnitLoadout;   // restore previous loadout
      // hint parseText "Don't even think of looting enemies<br/><t color='#ff0000'>for radios or UAV terminals!!!</t>";
      hint parseText "Don't even think of looting enemies<br/><t color='#ff0000'>for UAV terminals!!!</t>";
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
