if !(hasInterface) exitWith {};


// Whenever someone dies, we need to ensure all Zeus re-inits the tracker for the new player unit.
// This is crude, but still much more network efficient than making every client do this work or keeping track of who is actually Zeus at every time.
// This is run for every player locally.
player addEventHandler ["Respawn", {
	params ["_unit", "_corpse"];
    [[_unit]] remoteExecCall ["shellTracker_fnc_initTracker"];
}];

call shelltracker_fnc_initTracker;
