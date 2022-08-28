params ["_player", "_didJIP"];
enableSaving [false, false];

// This will show the sound ranging to all players
// _player setVariable ["arsr_receptionAllowed", true];



// allow U menu for easier team management
["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;




// Prevent use of enemy UAV terminals
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


// only allow trucks with a raised mast to be listeners
if !(hasInterface) exitWith {};
private _actionOn = ["mission_antennaExtend", "Extend antenna","",{
    [_target, 1] spawn rhs_fnc_gaz66_radioDeploy;
    _target setVariable ["mission_errected", true, true];
    [{
        _this setVariable ["arsr_enabled", true, true];
    }, _target, 1] call CBA_fnc_waitAndExecute
},{
    alive _target && {
    !(_target getVariable ["arsr_enabled", true]) && {
    !(_target getVariable ["mission_errected", false])}}
},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;

private _actionOff = ["mission_antennaRetrieve", "Retrieve antenna","",{
    [_target, 0] spawn rhs_fnc_gaz66_radioDeploy;
    _target setVariable ["arsr_enabled", false, true];
    [{
        _this setVariable ["mission_errected", false, true];
    }, _target, 1] call CBA_fnc_waitAndExecute
},{
    alive _target && {
    (_target getVariable ["arsr_enabled", true]) && {
    (_target getVariable ["mission_errected", false])}}
},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;

{
    [_x, 0, ["ACE_MainActions"], _actionOn] call ace_interact_menu_fnc_addActionToClass;
    [_x, 0, ["ACE_MainActions"], _actionOff] call ace_interact_menu_fnc_addActionToClass;
} forEach ["UK3CB_CHD_W_B_Gaz66_Radio", "UK3CB_CHD_O_Gaz66_Radio"];

