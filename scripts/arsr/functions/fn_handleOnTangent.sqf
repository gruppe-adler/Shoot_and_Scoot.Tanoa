params [["_unit", objNull], "_radioclass", "_radioType", "_additionalChannel", "_buttonDown"];

if (_buttonDown) then {  // only when transmission starts
	[getPos _unit, side _unit, true] call arsr_fnc_calculate;
};
