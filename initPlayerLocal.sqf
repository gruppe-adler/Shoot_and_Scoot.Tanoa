params ["_player", "_didJIP"];
enableSaving [false, false];


// allow U menu for easier team management
["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;


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


// prevent map markers because this would be too easy 
// --> we want to foster teamplay through radio comms instead
0 enableChannel false;  // disable  global   channel
1 enableChannel false;  // disable  side     channel
2 enableChannel false;  // disable  command  channel
3 enableChannel false;  // disable  group    channel
