// this will execute on ALL machines, no need to handle MP sync for basic things

// Initialize Loading of Streamator
if (isNil "CLib_fnc_loadModules") then {
    diag_log "CLib_fnc_loadModules is Nil";
} else { 
    call CLib_fnc_loadModules; 
};

// make BLUFOR radio truck a listener
["UK3CB_CHD_W_B_Gaz66_Radio", "initPost",{
    params ["_veh"];
    _veh setVariable ["arsr_side", blufor];
    if (local _veh) then {
		// disable directionfinding at start (when mast is not raised)
        _veh setVariable ["arsr_enabled", false, true];
        _veh setVariable ["tf_range", 0, true];  
    };
}, false, [], true]call CBA_fnc_addClassEventHandler;


// make OPFOR radio truck a listener
["UK3CB_CHD_O_Gaz66_Radio", "initPost",{
    params ["_veh"];
    _veh setVariable ["arsr_side", opfor];
    if (local _veh) then {
		// disable directionfinding at start (when mast is not raised)
        _veh setVariable ["arsr_enabled", false, true];
        _veh setVariable ["tf_range", 0, true];  
    };
}, false, [], true]call CBA_fnc_addClassEventHandler;


// nerf Darter drones to be more TvT friendly
["UAV_01_base_F", "init",{
    params ["_vehicle"];
    _vehicle disableTIEquipment true;   // disable thermal imaging
    _vehicle disableNVGEquipment true;  // disable night vision imaging
    // _vehicle removeMagazinesTurret ["Laserbatteries", [0]];   // disable laser designator
}, true, [], true] call CBA_fnc_addClassEventHandler;

["UAV_01_base_F", "Engine",{
    params ["_vehicle", "_engineState"];
    if (_engineState) then { 
    // if engine has just been turned on...    (needed to also cover battery recharge)
      if (fuel _vehicle > 0.66) then { 
        _vehicle setFuel 0.66; // limit fuel to 2/3 of full capacity
      } 
    }
}, true, [], true] call CBA_fnc_addClassEventHandler;


// turn off jammer when loaded into vehicle
fnc_DeactivateJammerOnLoad = {
    params ["_item","_vehicle"];
    if ( typeName _item == "OBJECT" && { typeOf _item == "Land_DataTerminal_01_F" }) then {
        ["crowsew_main_toggleJammer", [netId _item, false]] call CBA_fnc_serverEvent; // deactivate jammer
        ["crowsew_sounds_setSoundEnable", [_item, false]] call CBA_fnc_serverEvent;  // deactivate jammer sound
        [_item, 0] call BIS_fnc_dataTerminalAnimate; // close the data terminal box
    };
};
["ace_cargoLoaded", fnc_DeactivateJammerOnLoad] call CBA_fnc_addEventHandler;


// apply grad-loadout
["BLU_T_F", "NATO_Apex_Pacific"] call GRAD_Loadout_fnc_FactionSetLoadout;
["OPF_T_F", "CSAT_Apex_Pacific"] call GRAD_Loadout_fnc_FactionSetLoadout;
