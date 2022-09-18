// this will execute on ALL machines, no need to handle MP sync for basic things


// make BLUFOR radio truck a listener
["UK3CB_CHD_W_B_Gaz66_Radio", "initPost",{
    params ["_veh"];
    _veh setVariable ["arsr_side", blufor];
    if (local _veh) then {
        _veh setVariable ["arsr_enabled", false, true];  // disable directionfinding at start (when mast is not raised)
    };
}, false, [], true]call CBA_fnc_addClassEventHandler;


// make OPFOR radio truck a listener
["UK3CB_CHD_O_Gaz66_Radio", "initPost",{
    params ["_veh"];
    _veh setVariable ["arsr_side", opfor];
    if (local _veh) then {
        _veh setVariable ["arsr_enabled", false, true];  // disable directionfinding at start (when mast is not raised)
    };
}, false, [], true]call CBA_fnc_addClassEventHandler;


// nerf Darter's sensors to be more TvT friendly
["UAV_01_base_F", "init",{
    params ["_vehicle"];
    _vehicle disableTIEquipment true;
    _vehicle disableNVGEquipment true;
}, true, [], true] call CBA_fnc_addClassEventHandler;

