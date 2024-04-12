#include "../initSettings.sqf"

if !(hasInterface) exitWith {};

["arsr_drawData", arsr_fnc_handleDraw] call CBA_fnc_addEventHandler;


// add eventhandler to radio transmission
// gives params in format: ["_unit", "_radioclass", "_radioType", "_additionalChannel", "_buttonDown"];
["PushToTalk_EventHandler", "OnTangent", arsr_fnc_handleOnTangent, player] call TFAR_fnc_addEventHandler;

// eventhandler for respawn as the TFAR EH we are using is removed upon respawn
player addEventHandler ["Respawn", {
    params ["_unit", "_corpse"];
	// reapply the TFAR eventhandler
   	["PushToTalk_EventHandler", "OnTangent", arsr_fnc_handleOnTangent, player] call TFAR_fnc_addEventHandler;
}];