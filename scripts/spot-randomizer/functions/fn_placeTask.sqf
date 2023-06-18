params ["_side", "_taskID", "_position"];

[
  _side,
  _taskID,
  ["Here is/was one of your own supply containers.",
  "Supply station",
  ""],
  _position,
  "CREATED",
  -1,
  true
] call BIS_fnc_taskCreate;
