params ["_player", "_didJIP"];
enableSaving [false, false];

// This will show the sound ranging to all players
// _player setVariable ["arsr_receptionAllowed", true];



// allow U menu for easier team management
["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;


// remove NVG googles for all players (even if set in Eden Editor) 
player unassignItem hmd player;
player removeItem   hmd player;


// respawn with the same loadout you had when you started
// [player, [missionNamespace, "inventory_at_start"]] call BIS_fnc_saveInventory;


// prevent use of enemy UAV terminals
["loadout", {
    params ["_unit", "_newUnitLoadout", "_oldUnitLoadout"];
    private _removeUavTerminal = ["O_UavTerminal", "B_UavTerminal"] select ((side group _unit) isNotEqualTo blufor);
    if (_removeUavTerminal in (str _newUnitLoadout)) then {
        _unit setUnitLoadout _oldUnitLoadout;
    };
}] call CBA_fnc_addPlayerEventHandler;


// prevent map markers because this would be too easy 
// --> we want to foster teamplay through radio comms instead
0 enableChannel false;  // disable  global   channel
1 enableChannel false;  // disable  side     channel
2 enableChannel false;  // disable  command  channel
3 enableChannel false;  // disable  group    channel
