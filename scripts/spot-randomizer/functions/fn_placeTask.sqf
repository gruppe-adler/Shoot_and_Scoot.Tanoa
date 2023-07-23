params ["_side", "_stationid"];

private _position =  markerPos _stationid;
private _text = trim(markerText _stationid); // Must trim whitespaces from markerText
private _taskID = (str _side) + _stationid; // Tasks are side-specific, so we add it to the id

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
