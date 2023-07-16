params ["_unit", "_didJIP"];
diag_log(name _unit + " has joined the game and did JIP? " + str _didJIP);

remoteExecCall ["shellTracker_fnc_postInit"]; // Gotta tell everyone to update their trackers, so new/JIP players also get tracked. Yes, this leads to redundant calls at mission start.
