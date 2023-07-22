params ["_unit", "_didJIP"];
diag_log(name _unit + " has joined the game and did JIP? " + str _didJIP);

// Only for JIP to prevent superfluous remoteExecs at mission start. At missionstart, everybody should be registered via regular postInit.
if (_didJIP) exitWith {remoteExecCall ["shellTracker_fnc_postInit"] }; // Gotta tell everyone to update their trackers, so new/JIP players also get tracked.
