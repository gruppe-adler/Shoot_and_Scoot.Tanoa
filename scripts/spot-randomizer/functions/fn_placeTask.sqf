params ["_side", "_marker"];

_position =  markerPos _marker;
_text = markerText _marker;
_taskID = (str _side) + _marker;

[
    _side,
    _taskID,
    ["Here is/was one of your own supply containers.",
    _text + " Supply Station",
    ""],
    _position,
    "CREATED",
    -1,
    true,
    "defend"
] call BIS_fnc_taskCreate;
