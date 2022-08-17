// this will execute on ALL machines, no need to handle MP sync for basic things


// make BLUFOR radio truck a listener
["UK3CB_CHD_W_B_Gaz66_Radio", "initPost",{
    params ["_veh"];
    _veh setVariable ["arsr_side", blufor];
}, false, [], true]call CBA_fnc_addClassEventHandler;


// make OPFOR radio truck a listener
["UK3CB_CHD_O_Gaz66_Radio", "initPost",{
    params ["_veh"];
    _veh setVariable ["arsr_side", opfor];
}, false, [], true]call CBA_fnc_addClassEventHandler;

