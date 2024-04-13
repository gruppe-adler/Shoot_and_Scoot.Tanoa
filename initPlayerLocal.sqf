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


// radio range booster towers
fnc_TFAR_Boost_RadioTower_Loop = {
    private _isBackToNormal = player getVariable ["tf_sendingDistanceMultiplicator", 1] == 1;
    private _radioTowersInRange = nearestObjects [player, ["Land_TTowerBig_2_F"], 10, true];
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



// prevent map markers because this would be too easy 
// --> we want to foster teamplay through radio comms instead
0 enableChannel false;  // disable  global   channel
1 enableChannel false;  // disable  side     channel
2 enableChannel false;  // disable  command  channel
3 enableChannel false;  // disable  group    channel
